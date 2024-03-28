﻿Перем мЛоггер;
Перем мИдВызова;
Перем мОбновлять;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.19");
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
	
	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт документов из УПП: Отчет комиссионера о продажах");
     
    Попытка
         
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			Возврат Неопределено;
		КонецЕсли;

		Если НЕ НРег(СтруктураОбъекта.type) = "справочник.номенклатура" Тогда
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
				Возврат СуществующийОбъект;
			КонецЕсли;
			
			ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		КонецЕсли;
			
		//ОбъектДанных.Код = id.code;
		
		ОбъектДанных.Наименование = сокрлп(def.description);
		ParentRef = "";
		Если def.parent.Свойство("Ref", ParentRef) Тогда
			ОбъектДанных.Родитель = Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(ParentRef));
		КонецЕсли;
		
		
		ОбъектДанных.ПометкаУдаления = def.DeletionMark; 	
		
		Если def.isFolder <> true Тогда
			
			ОбъектДанных.Артикул = def.Артикул;
			
			ОбъектДанных.НаименованиеПолное = def.НаименованиеПолное;
			
			ОбъектДанных.ВариантОформленияПродажи = Перечисления.ВариантыОформленияПродажи.РеализацияТоваровУслуг;
			
			ТНВЭД = "";
			КодТНВЭД = Неопределено;
			Если def.Свойство("ТНВЭД") И def.ТНВЭД.Свойство("description", ТНВЭД) Тогда
				КодТНВЭД = лев(ТНВЭД,4);
			КонецЕсли;
			
			//ЕНС. Добавил ветку
			Если def.Свойство("ВидВоспроизводства") и def.ВидВоспроизводства.Свойство("Представление") Тогда
				Если КодТНВЭД = "6201" ИЛИ КодТНВЭД = "6202" ИЛИ КодТНВЭД = "6106" Тогда
					ОбъектДанных.ВидНоменклатуры = 
						РегистрыСведений.ксп_МэппингСправочникВидыНоменклатуры.ПоМэппингу(
							"ТНВЭД", 
							КодТНВЭД,
							СтруктураОбъекта.source, 
							def.ВидВоспроизводства.Представление);
				Иначе
					ОбъектДанных.ВидНоменклатуры = 
						РегистрыСведений.ксп_МэппингСправочникВидыНоменклатуры.ПоМэппингу(
							"", 
							"", 
							СтруктураОбъекта.source, 
							def.ВидВоспроизводства.Представление);
				КонецЕсли;
			Иначе 
				
				Если ЗначениеЗаполнено(ВидНоменклатуры) Тогда
					// это интерактивная загрузка, вид номенклатуры пришел из формы
					//ОбъектДанных.ВидНоменклатуры = ВидНоменклатуры;
				Иначе 
					
				КонецЕсли;
				
				ОбъектДанных.ВидНоменклатуры = 
					РегистрыСведений.ксп_МэппингСправочникВидыНоменклатуры.ПоМэппингу(
						"", 
						"", 
						СтруктураОбъекта.source, 
						"");
				
			КонецЕсли;
			
			
			ОбъектДанных.ТипНоменклатуры = ОбъектДанных.ВидНоменклатуры.ТипНоменклатуры;
			
			Попытка
				Сезон 			= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры(def.Сезон,СтруктураОбъекта.source);
			Исключение
			КонецПопытки;
			
			Попытка
				Проект 			= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры(def.Проект, СтруктураОбъекта.source);
			Исключение
			КонецПопытки;
			
			Попытка
				Коллекция 		= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры(def.Коллекция, СтруктураОбъекта.source);
			Исключение
			КонецПопытки;
			
			Попытка
				Вывеска 		= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры(def.ПериодВывески, СтруктураОбъекта.source);
			Исключение
			КонецПопытки;
			
			Попытка
				Капсула			= ксп_ИмпортСлужебный.НайтиКоллекциюНоменклатуры (def.Капсула, СтруктураОбъекта.source);
			Исключение
			КонецПопытки; 
			
	       	Попытка
			Производитель 		= Справочники.Производители.НайтиПоНаименованию(def.Производитель.description);
			Исключение
			КонецПопытки;

			
			//Сезон
			Попытка
				Если НЕ ЗначениеЗаполнено(Сезон.ВерсияДанных) Тогда	
					Сезон = Справочники.КоллекцииНоменклатуры.СоздатьЭлемент();
					СсылкаСезон = Справочники.КоллекцииНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(def.Сезон.ref));
					Сезон.УстановитьСсылкуНового(СсылкаСезон);
					Сезон.Наименование = def.Сезон.code;
					Сезон.ОбменДанными.Загрузка = Истина;
					Сезон.Записать();
					РегистрыСведений.ксп_МэппингСправочникКоллекцииНоменклатуры.ДобавитьГУИД(def.сезон.ref,def.Сезон.code,СтруктураОбъекта.source); 
				КонецЕсли;
			Исключение
			КонецПопытки;
			
			//Проект
			Попытка
				Если НЕ ЗначениеЗаполнено(Проект.ВерсияДанных) Тогда
					Проект = Справочники.КоллекцииНоменклатуры.СоздатьЭлемент();
					СсылкаПроект = Справочники.КоллекцииНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(def.Проект.ref));
					Проект.УстановитьСсылкуНового(СсылкаПроект);
					Проект.Наименование = def.Проект.description; 
					Если Сезон <> Неопределено Тогда
						Проект.Родитель = Сезон.Ссылка;
					КонецЕсли;
					Проект.ОбменДанными.Загрузка = Истина;
					Проект.Записать();
					РегистрыСведений.ксп_МэппингСправочникКоллекцииНоменклатуры.ДобавитьГУИД(def.Проект.ref,def.Проект.code,СтруктураОбъекта.source); 
				КонецЕсли;
			Исключение
			КонецПопытки;

			
			//Коллекция
			Попытка
				Если НЕ ЗначениеЗаполнено(Коллекция.ВерсияДанных) Тогда
					Коллекция = Справочники.КоллекцииНоменклатуры.СоздатьЭлемент();
					СсылкаКоллекция = Справочники.КоллекцииНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(def.Коллекция.ref));
					Коллекция.УстановитьСсылкуНового(СсылкаКоллекция);
					Коллекция.Наименование = def.Коллекция.code;
					Если Проект <> Неопределено Тогда
						Коллекция.Родитель = Проект.Ссылка;
					ИначеЕсли Сезон <> Неопределено Тогда
						Коллекция.Родитель = Сезон.Ссылка;
					КонецЕсли;
					Коллекция.ОбменДанными.Загрузка = Истина;
					Коллекция.Записать();
					РегистрыСведений.ксп_МэппингСправочникКоллекцииНоменклатуры.ДобавитьГУИД(def.Коллекция.ref,def.Коллекция.code,СтруктураОбъекта.source)
				КонецЕсли;
			Исключение
			КонецПопытки;

			
			//Вывеска
			Попытка
				Если НЕ ЗначениеЗаполнено(Вывеска.ВерсияДанных) Тогда
					Вывеска = Справочники.КоллекцииНоменклатуры.СоздатьЭлемент();
					СсылкаВывеска = Справочники.КоллекцииНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(def.ПериодВывески.ref));
					Вывеска.УстановитьСсылкуНового(СсылкаВывеска);
					Вывеска.Наименование = def.ПериодВывески.code;
					Если Коллекция <> Неопределено Тогда
						Вывеска.Родитель = Коллекция.Ссылка;
					ИначеЕсли Проект <> Неопределено Тогда
						Вывеска.Родитель = Проект.Ссылка;
					ИначеЕсли Сезон <> Неопределено Тогда
						Вывеска.Родитель = Сезон.Ссылка;
					КонецЕсли;	
					Вывеска.ОбменДанными.Загрузка = Истина;
					Вывеска.Записать();
					РегистрыСведений.ксп_МэппингСправочникКоллекцииНоменклатуры.ДобавитьГУИД(def.ПериодВывески.ref,def.ПериодВывески.code,СтруктураОбъекта.source)
				КонецЕсли;
			Исключение
			КонецПопытки;

			
			//Капсула
			Попытка
				Если НЕ ЗначениеЗаполнено(Капсула.ВерсияДанных) Тогда
					Капсула = Справочники.КоллекцииНоменклатуры.СоздатьЭлемент();
					СсылкаКапсула = Справочники.КоллекцииНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(def.Капсула.ref));
					Капсула.УстановитьСсылкуНового(СсылкаКапсула);
					Капсула.Наименование = def.Капсула.code;
					Если Вывеска <> Неопределено Тогда
						Капсула.Родитель = Вывеска.Ссылка;	
					ИначеЕсли Коллекция <> Неопределено Тогда
						Капсула.Родитель = Коллекция.Ссылка;
					ИначеЕсли Проект <> Неопределено Тогда
						Капсула.Родитель = Проект.Ссылка;
					ИначеЕсли Сезон <> Неопределено Тогда
						Капсула.Родитель = Сезон.Ссылка;
					КонецЕсли;
					Капсула.ОбменДанными.Загрузка = Истина;
					Капсула.Записать();
					РегистрыСведений.ксп_МэппингСправочникКоллекцииНоменклатуры.ДобавитьГУИД(def.Капсула.ref,def.Капсула.code,СтруктураОбъекта.source)
				КонецЕсли;
			Исключение
			КонецПопытки;
			
			
			Если Производитель <> Неопределено Тогда
				Если Производитель = Справочники.Производители.ПустаяСсылка() Тогда
					ОбъектПроизводитель = Справочники.Производители.СоздатьЭлемент();
					ОбъектПроизводитель.Наименование = def.Производитель.description;
					ОбъектПроизводитель.ОбменДанными.Загрузка = Истина;
					ОбъектПроизводитель.Записать();
				КонецЕсли;
			КонецЕсли;   
			
			ОбъектДанных.ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.ИндивидуальныеДляНоменклатуры;
			
			ОбъектДанных.ЕдиницаИзмерения = Справочники.УпаковкиЕдиницыИзмерения.НайтиПоКоду(def.ЕдиницаИзмерения.code);
			
			Если def.Свойство("СтавкаНДС") И    def.СтавкаНДС.Свойство("Представление") Тогда
				ОбъектДанных.СтавкаНДС = Справочники.СтавкиНДС.НайтиПоНаименованию(def.СтавкаНДС.Представление);
			КонецЕсли;
			
			Если ОбъектПроизводитель <> Неопределено Тогда 
				ОбъектДанных.Производитель = ОбъектПроизводитель.Ссылка;
			КонецЕсли; 
			
			Если Коллекция <> Неопределено Тогда
				ОбъектДанных.КоллекцияНоменклатуры = Коллекция.Ссылка;
			КонецЕсли;
		
		КонецЕсли;
		
		ОбъектДанных.ОбменДанными.Загрузка = Истина;
		
		ОбъектДанных.Записать();
		
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
						ОбъектХарактеристика.Записать();
					КонецЕсли;
					n = n + 1;
				Иначе
					Продолжить;
					
				КонецЕсли;
			КонецЕсли;
			
		КонецЦикла;  
		
		//Поиск и добавление в регистр для хранения истории изменения Коллекции в Номенклатуре
		Если Коллекция <> Неопределено и def.isFolder <> true Тогда
			РегистрыСведений.ксп_ИсторияИзмененийКоллекцииНоменклатуры.НайтиИсториюКоллекции(ОбъектДанных.Ссылка, Коллекция.Ссылка);
		КонецЕсли;
		
		// ЕНС. 2024-03-23 пока отключено для более быстрой загрузки ненайденной номенклатуры
		////ЕНС. Штрихкоды
		//Если def.Свойство("Штрихкоды") Тогда
		//	
		//	Для каждого стрк Из def.Штрихкоды Цикл
		//		
		//		Если ЗначениеЗаполнено(стрк.Штрихкод) Тогда
		//			НаборЗаписей = РегистрыСведений.ШтрихкодыНоменклатуры.СоздатьНаборЗаписей();
		//			НаборЗаписей.Отбор.Штрихкод.Установить(стрк.Штрихкод);
		//			
		//			//ЕНС. пока не перезаписываем существующие
		//			НаборЗаписей.Прочитать();                 
		//			Если НаборЗаписей.количество() > 0 Тогда
		//				Возврат Неопределено;
		//			КонецЕсли;
		//			НовСтр = НаборЗаписей.Добавить();
		//			
		//			НовСтр.Штрихкод = стрк.Штрихкод;
		//			НовСтр.Номенклатура = ксп_импортСлужебный.найтиНоменклатуру(стрк.Владелец);
		//			НовСтр.Характеристика = ксп_импортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
		//			НовСтр.Упаковка = ксп_импортСлужебный.НайтиЕдиницуИзмерения(стрк.ЕдиницаИзмерения);
		//			
		//			НаборЗаписей.Записать();
		//		КонецЕсли;
		//		
		//	КонецЦикла;
		//	
		//КонецЕсли;
		
		Возврат ОбъектДанных.Ссылка;
		
    Исключение
          т = ОписаниеОшибки();
          мЛоггер.ерр("Плагин: Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах . Подробности: " + т);
           
          //    ОБЯЗАТЕЛЬНО!!! Потому что в оркестраторе вызов плагина в попытке. и если была ошибка, надо сделать BasicReject()
          ВызватьИсключение т;
 
    КонецПопытки;
	
	
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


#КонецОбласти 	

Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции


мОбновлять = ИСтина;

