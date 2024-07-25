﻿Перем КэшТНВЭД;

Перем мЛоггер;
Перем мИдВызова;
Перем мОбновлять;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.26");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Справочник_Номенклатура");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Справочник_Номенклатура");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Справочник_Номенклатура",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Справочник_Номенклатура",
		ТипКоманды, 
		Ложь) ;
	
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")

	НоваяКоманда = ТаблицаКоманд.Добавить() ;
	НоваяКоманда.Представление = Представление ;
	НоваяКоманда.Идентификатор = Идентификатор ;
	НоваяКоманда.Использование = Использование ;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение ;
	НоваяКоманда.Модификатор = Модификатор ;
КонецПроцедуры


#КонецОбласти 	

// Описание_метода
//
// Параметры:
//	СтруктураОбъекта	- структура - после метода тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьОбъект(СтруктураОбъекта, ВидНоменклатуры = Неопределено) Экспорт 
	
	мЛоггер = Вычислить("мис_ЛоггерСервер.getLogger(мИдВызова, ""Импорт документов из УПП: Отчет комиссионера о продажах"")");
     
    Попытка
         
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			млоггер.варн("Пропущено! Нет свойства type в сообщении");
			Возврат Неопределено;
		КонецЕсли;

		Если НЕ НРег(СтруктураОбъекта.type) = "справочник.номенклатура" Тогда  
			млоггер.варн("Пропущено! В type не Справочник.Номенклатура");
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		def = СтруктураОбъекта.definition; 
		
		СуществующийОбъект = Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			
		Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
			Если def.isFolder = true Тогда
				ОбъектДанных = Справочники.Номенклатура.СоздатьГруппу();
			Иначе	
				ОбъектДанных = Справочники.Номенклатура.СоздатьЭлемент();
			КонецЕсли; 
			ОбъектДанных.УстановитьНовыйКод();
			СсылкаНового = Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		Иначе
			
			Если НЕ мОбновлять = Истина Тогда  
				млоггер.варн("Пропущено! Флаг Обновлять не включен! "+строка(СуществующийОбъект));
				Возврат СуществующийОбъект;
			КонецЕсли;
			
			ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		КонецЕсли;   
		
		
		ЗаполнитьРеквизиты(ОбъектДанных, СтруктураОбъекта, ВидНоменклатуры);
			
		ОбъектДанных.ОбменДанными.Загрузка = Истина;
		
		ОбъектДанных.Записать();
		
		//ЕНС. 2024-03-23 пока отключено для бо	лее быстрой загрузки ненайденной номенклатуры
		//ДобавитьШтрихкоды(def, ОбъектДанных.Ссылка);
	

		n = 1;
		Для каждого элемент из def Цикл  
			
			Если элемент.Ключ = "Характеристика_" + n Тогда
				
				Если Элемент.Значение.Свойство("ref") Тогда
					Характеристика = Справочники.ХарактеристикиНоменклатуры.ПолучитьСсылку(
						Новый УникальныйИдентификатор(Элемент.Значение.ref));
					Если НЕ ЗначениеЗаполнено(Характеристика.ВерсияДанных)Тогда
						ОбъектХарактеристика = Справочники.ХарактеристикиНоменклатуры.СоздатьЭлемент();
						СсылкаХарактеристика = Справочники.ХарактеристикиНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(Элемент.Значение.ref));
						ОбъектХарактеристика.УстановитьСсылкуНового(СсылкаХарактеристика);
						ОбъектХарактеристика.УстановитьНовыйКод();
						ОбъектХарактеристика.Владелец = ОбъектДанных.Ссылка;
						ОбъектХарактеристика.Наименование = элемент.Значение.description;
						ОбъектХарактеристика.ОбменДанными.Загрузка = Истина; 
						
						СоздатьХарактеристикуЦО(ОбъектХарактеристика);
						
						ОбъектХарактеристика.Записать();
					КонецЕсли;
					n = n + 1;
				Иначе
					Продолжить;
					
				КонецЕсли;
			КонецЕсли;
			
		КонецЦикла;  
		
        Если def.Свойство("Коллекция") Тогда
			
			//Поиск и добавление в регистр для хранения истории изменения Коллекции в Номенклатуре
			Если def.isFolder <> true Тогда
				РегистрыСведений.ксп_ИсторияИзмененийКоллекцииНоменклатуры.НайтиИсториюКоллекции(ОбъектДанных.Ссылка, ОбъектДанных.КоллекцияНоменклатуры);
			КонецЕсли;
		КонецЕсли;
		
		млоггер.варн("Записан объект: "+строка(ОбъектДанных)+", ЭтоГруппа = "+Строка(ОбъектДанных.ЭтоГруппа));
		
		Возврат ОбъектДанных.Ссылка;
		
    Исключение
          т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
          мЛоггер.ерр("Плагин импорта номенклатуры УПП. Подробности: " + т);
           
          //    ОБЯЗАТЕЛЬНО!!! Потому что в оркестраторе вызов плагина в попытке. и если была ошибка, надо сделать BasicReject()
          ВызватьИсключение т;
 
    КонецПопытки;
	
	
КонецФункции

Функция ЗаполнитьРеквизиты(объектДанных, СтруктураОбъекта, ВидНоменклатуры = Неопределено) Экспорт 
	
         
		
	id = СтруктураОбъекта.identification;
	def = СтруктураОбъекта.definition; 
	
		
	//ОбъектДанных.Код = id.code;
	
	ОбъектДанных.Наименование = сокрлп(def.description);
	ParentRef = "";
	Если def.parent.Свойство("Ref", ParentRef) Тогда
		Попытка
			ОбъектДанных.Родитель = Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(ParentRef));
		Исключение
		    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
		КонецПопытки;
		
	КонецЕсли;
	
	
	ОбъектДанных.ПометкаУдаления = def.DeletionMark; 	
	
	Если def.isFolder = true Тогда
		Возврат Истина;
		
	КонецЕсли;
	

	ОбъектДанных.Артикул 					= def.Артикул;
	ОбъектДанных.НаименованиеПолное 		= def.НаименованиеПолное;
	ОбъектДанных.ВариантОформленияПродажи 	= Перечисления.ВариантыОформленияПродажи.РеализацияТоваровУслуг;
	ОбъектДанных.ВидНоменклатуры 			= ПолучитьВидНоменклатуры(def);
	ОбъектДанных.ТипНоменклатуры 			= ОбъектДанных.ВидНоменклатуры.ТипНоменклатуры;
	
	Если def.Свойство("Сезон") Тогда
		Сезон 			= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры(def.Сезон,СтруктураОбъекта.source);
	КонецЕсли;
	Если def.Свойство("Проект") Тогда
    	Проект 			= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры(def.Проект, СтруктураОбъекта.source);
	КонецЕсли;
	Если def.Свойство("Коллекция") Тогда
		Коллекция = Справочники.КоллекцииНоменклатуры.ПустаяСсылка();
    	//Коллекция 		= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры(def.Коллекция, СтруктураОбъекта.source);
		//2024-07-25
		Если def.Коллекция.Свойство("code") Тогда
			Коллекция = Справочники.КоллекцииНоменклатуры.НайтиПоНаименованию(СокрЛП(def.Коллекция.code), Истина);
		КонецЕсли;
	КонецЕсли;
	Если def.Свойство("ПериодВывески") Тогда
    	Вывеска 		= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры(def.ПериодВывески, СтруктураОбъекта.source);
	КонецЕсли;
	Если def.Свойство("Капсула") Тогда
    	Капсула			= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры (def.Капсула, СтруктураОбъекта.source);
	КонецЕсли;
	Если def.Свойство("Производитель") и def.Производитель.Свойство("description") Тогда
    	Производитель 		= Справочники.Производители.НайтиПоНаименованию(def.Производитель.description);
	КонецЕсли;
		

	
	
	
	//Производитель	
	Если Производитель <> Неопределено Тогда
		Если Производитель = Справочники.Производители.ПустаяСсылка() Тогда
			ОбъектПроизводитель = Справочники.Производители.СоздатьЭлемент();
			ОбъектПроизводитель.Наименование = def.Производитель.description;
			ОбъектПроизводитель.ОбменДанными.Загрузка = Истина;
			ОбъектПроизводитель.Записать();
		КонецЕсли;
	КонецЕсли;   
	
	ОбъектДанных.ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.ИндивидуальныеДляНоменклатуры;
	
	Если def.ЕдиницаИзмерения.Свойство("code") Тогда
		ОбъектДанных.ЕдиницаИзмерения = Справочники.УпаковкиЕдиницыИзмерения.НайтиПоКоду(def.ЕдиницаИзмерения.code);
	КонецЕсли;
	
	
	Если def.Свойство("СтавкаНДС") И    def.СтавкаНДС.Свойство("Представление") Тогда
		ОбъектДанных.СтавкаНДС = Справочники.СтавкиНДС.НайтиПоНаименованию(def.СтавкаНДС.Представление);
	КонецЕсли;
	
	Если ОбъектПроизводитель <> Неопределено Тогда 
		ОбъектДанных.Производитель = ОбъектПроизводитель.Ссылка;
	КонецЕсли; 
	
	Если Коллекция <> Неопределено Тогда
		ОбъектДанных.КоллекцияНоменклатуры = Коллекция.Ссылка;
	КонецЕсли;

	Если def.Свойство("ТНВЭД") И def.ТНВЭД.Свойство("description") Тогда
		ОбъектДанных.КодТНВЭД = НайтиСоздатьКодТНВЭД(def.ТНВЭД.description, def.ТНВЭД.code);
	КонецЕсли;
	
					
	
		
КонецФункции


Процедура СоздатьХарактеристикуЦО(ОбъектДанныхХарактеристика)
	
	Если ТипЗнч(ОбъектДанныхХарактеристика.Владелец) = Тип("СправочникСсылка.ВидыНоменклатуры") Тогда
		ВидНоменклатуры = ОбъектДанныхХарактеристика.Владелец;
	Иначе
		ВидНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОбъектДанныхХарактеристика.Владелец, "ВидНоменклатуры");
	КонецЕсли; 
	
	СтруктураРеквизитов = Новый Структура;
	
	СтруктураРеквизитов.Вставить("ШаблонРабочегоНаименованияХарактеристики");
	СтруктураРеквизитов.Вставить("ЗапретРедактированияРабочегоНаименованияХарактеристики");
	СтруктураРеквизитов.Вставить("ШаблонНаименованияДляПечатиХарактеристики");
	СтруктураРеквизитов.Вставить("ЗапретРедактированияНаименованияДляПечатиХарактеристики");
	СтруктураРеквизитов.Вставить("НастройкиКлючаЦенПоХарактеристике");
	
	
	РеквизитыОбъекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ВидНоменклатуры, СтруктураРеквизитов);
	
	НастройкиКлючаЦен = РеквизитыОбъекта.НастройкиКлючаЦенПоХарактеристике;
	
	РеквизитыДляПоиска = ОбъектДанныхХарактеристика.ПолучитьРеквизитыДляПоиска(ВидНоменклатуры, РеквизитыОбъекта);
	ОбъектДанныхХарактеристика.ХарактеристикаНоменклатурыДляЦенообразования = Справочники.ХарактеристикиНоменклатурыДляЦенообразования.ПолучитьХарактеристикуНоменклатурыДляЦенообразования(РеквизитыДляПоиска);
	
	
	
КонецПРоцедуры 

// Записывает штрихкоды в регистр сведений ШтрихкодыНоменклатуры
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ДобавитьШтрихкоды(def, Номенклатура)
	
		 
		//ЕНС. Штрихкоды
		Если def.Свойство("Штрихкоды") Тогда
			
			Для каждого стрк Из def.Штрихкоды Цикл
				
				Если ЗначениеЗаполнено(стрк.Штрихкод) Тогда
					НаборЗаписей = РегистрыСведений.ШтрихкодыНоменклатуры.СоздатьНаборЗаписей();
					НаборЗаписей.Отбор.Штрихкод.Установить(стрк.Штрихкод);
					
					//ЕНС. пока не перезаписываем существующие
					НаборЗаписей.Прочитать();                 
					Если НаборЗаписей.количество() > 0 Тогда
						Возврат Неопределено;
					КонецЕсли;
					НовСтр = НаборЗаписей.Добавить();
					
					НовСтр.Штрихкод = стрк.Штрихкод;
					НовСтр.Номенклатура = ксп_импортСлужебный.найтиНоменклатуру(Номенклатура);
					НовСтр.Характеристика = ксп_импортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
					НовСтр.Упаковка = ксп_импортСлужебный.НайтиЕдиницуИзмерения(стрк.ЕдиницаИзмерения);
					
					НаборЗаписей.Записать();
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
	
		
	Возврат Неопределено;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПолучитьВидНоменклатуры(def)
	
	ТНВЭД = "";
	КодТНВЭД = Неопределено;
	Если def.Свойство("ТНВЭД") И def.ТНВЭД.Свойство("description", ТНВЭД) Тогда
		КодТНВЭД = лев(ТНВЭД,4);
	КонецЕсли;
	
	//ЕНС. Добавил ветку
	Если def.Свойство("ВидВоспроизводства") и def.ВидВоспроизводства.Свойство("Представление") Тогда
		Если КодТНВЭД = "6201" ИЛИ КодТНВЭД = "6202" ИЛИ КодТНВЭД = "6106" Тогда
			ВидНоменклатуры = 
				РегистрыСведений.ксп_МэппингСправочникВидыНоменклатуры.ПоМэппингу(
					"ТНВЭД", 
					КодТНВЭД,
					"upp", 
					def.ВидВоспроизводства.Представление);
		Иначе
			ВидНоменклатуры = 
				РегистрыСведений.ксп_МэппингСправочникВидыНоменклатуры.ПоМэппингу(
					"", 
					"", 
					"upp", 
					def.ВидВоспроизводства.Представление);
		КонецЕсли;
	Иначе 
		
		
		ВидНоменклатуры = 
			РегистрыСведений.ксп_МэппингСправочникВидыНоменклатуры.ПоМэппингу(
				"", 
				"", 
				"upp", 
				"");
		
	КонецЕсли;
	
		
	Возврат ВидНоменклатуры ;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиСоздатьКодТНВЭД(TNVED, TNVED_Kod)
	
	Поиск = КэшТНВЭД.Найти(TNVED_Kod, "КОД");
	
	Если Поиск = Неопределено Тогда
		
		Рез = Справочники.КлассификаторТНВЭД.НайтиПоКоду(TNVED_Kod,Истина);
		Если НЕ ЗначениеЗаполнено(Рез) или Рез = Справочники.КлассификаторТНВЭД.ПустаяСсылка() Тогда
			обк = Справочники.КлассификаторТНВЭД.СоздатьЭлемент(); 
			Обк.Код = TNVED_Kod;
			обк.Наименование = TNVED;
			обк.НаименованиеПолное = TNVED;
			обк.Записать();
			Рез = Обк.Ссылка;
		КонецЕсли;
		
		НовСтр = КэшТНВЭД.Добавить();
		НовСтр.КОД = TNVED;
		НовСтр.Ссылка = Рез; 
		
		Возврат Рез;
		
	Иначе 
		Возврат Поиск.ссылка;
	КонецЕсли;
	
	
	
КонецФункции


#Область Тестирование



Функция ЗагрузитьИзJsonНаСервере(Json, ВидНоменклатуры = Неопределено) export
	
	Если не ЗначениеЗаполнено(json) Тогда
		ВызватьИсключение "Пустой json";
	КонецЕсли;

	мЧтениеJSON = Новый ЧтениеJSON;

	
	мЧтениеJSON.УстановитьСтроку(Json);
		
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		Для Каждого эл из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(эл, ВидНоменклатуры);
		КонецЦикла;
	Иначе
	    Возврат ЗагрузитьОбъект(СтруктураОбъекта, ВидНоменклатуры);
	КонецЕсли;
	
КонецФункции


Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Попытка
			Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
		Исключение
		    Возврат '00010101';
		КонецПопытки;
		
	КонецЕсли;
	Если Свойство = "Сумма" Тогда
		Возврат XMLЗначение(Тип("Число"),Значение);
	КонецЕсли;
	Если Свойство = "Валюта" Тогда
		Возврат Справочники.Валюты.НайтиПоКоду(Значение);
	КонецЕсли;
	
КонецФункции




// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервереИзФайла(Адрес, ВидНоменклатуры, Обновлять = Истина) ЭКспорт
	
	мОбновлять = Обновлять;
	
	ДвоичныеДанные  = ПолучитьИзВременногоХранилища(Адрес);
	Если 1=0 Тогда
		ДвоичныеДанные = новый ДвоичныеДанные("");
	КонецЕсли;                                
	
	ИмяФайла = ПолучитьИмяВременногоФайла("json");
	ДвоичныеДанные.Записать(ИмяФайла);
	
	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.ОткрытьФайл(ИмяФайла);
	
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		Для Каждого эл из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(эл, ВидНоменклатуры);
		КонецЦикла;
	Иначе
	    Возврат ЗагрузитьОбъект(СтруктураОбъекта, ВидНоменклатуры);
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции   

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервереИзМассиваАдресов(МассивАдресов, ВидНоменклатуры, Обновлять = Истина) Экспорт
	
	мОбновлять = Обновлять;
	млоггер = мис_логгерСервер.getLogger(мИдВызова);
	
	млоггер.инфо("НАЧАЛИ пакет из "+строка(МассивАдресов.Количество())+" файлов");

	сч_обраотано = 0;       
	сч_ошибок = 0;
	
	Для каждого Адрес Из МассивАдресов Цикл

		
		ДвоичныеДанные  = ПолучитьИзВременногоХранилища(Адрес);
		Если 1=0 Тогда
			ДвоичныеДанные = новый ДвоичныеДанные("");
		КонецЕсли;                                
		
		ИмяФайла = ПолучитьИмяВременногоФайла("json");
		ДвоичныеДанные.Записать(ИмяФайла);
		
		мЧтениеJSON = Новый ЧтениеJSON;
		мЧтениеJSON.ОткрытьФайл(ИмяФайла);
		
		СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
		
		Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
			Для Каждого эл из СтруктураОбъекта Цикл
				
				Попытка
					ЗагрузитьОбъект(эл, ВидНоменклатуры);
					сч_обраотано = сч_обраотано +1;
				Исключение
				    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
					сч_ошибок = сч_ошибок + 1;
				КонецПопытки;
				
			КонецЦикла;
		Иначе 
			
			Попытка
				ЗагрузитьОбъект(СтруктураОбъекта, ВидНоменклатуры);
				сч_обраотано = сч_обраотано +1;
			Исключение
			    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
				сч_ошибок = сч_ошибок + 1;
			КонецПопытки;
		    
			
		КонецЕсли;

	КонецЦикла;
	
	млоггер.инфо("ЗАВЕРШИЛИ пакет из "+строка(МассивАдресов.Количество())+" файлов. УСпешно обработано = "+строка(сч_обраотано)
	+", ошибок = "+Строка(сч_ошибок));
	
	Возврат Неопределено;
	
КонецФункции



#КонецОбласти 	

Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции


мОбновлять = ИСтина;

	КэшТНВЭД = Новый ТаблицаЗначений;
	КэшТНВЭД.Колонки.Добавить("КОД");
	КэшТНВЭД.Колонки.Добавить("Ссылка");
	КэшТНВЭД.Индексы.Добавить("КОД");


	
	