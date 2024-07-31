﻿
Перем мЛоггер;
Перем мИдВызова;
Перем мОбновлять;
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.4");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Справочник_Кассы");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Справочник_Кассы");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Справочник_Кассы",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Справочник_Кассы",
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
	
	
	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт из УПП: Справочник.Кассы");
     
    Попытка
         
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			млоггер.варн("Пропущено! Нет свойства type в сообщении");
			Возврат Неопределено;
		КонецЕсли;

		Если НЕ НРег(СтруктураОбъекта.type) = "справочник.кассы" Тогда  
			млоггер.варн("Пропущено! В type не Справочник.Кассы");
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		def = СтруктураОбъекта.definition; 
		
		СуществующийОбъект = Справочники.Кассы.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			
		Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
			Если def.isFolder = true Тогда
				ОбъектДанных = Справочники.Кассы.СоздатьГруппу();
			Иначе	
				ОбъектДанных = Справочники.Кассы.СоздатьЭлемент();
			КонецЕсли; 
			ОбъектДанных.УстановитьНовыйКод();
			СсылкаНового = Справочники.Кассы.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
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
		
		ДобавитьМэппинг(СтруктураОбъекта, ОбъектДанных);
		
			
		млоггер.варн("Записан объект: "+строка(ОбъектДанных)+", ЭтоГруппа = "+Строка(ОбъектДанных.ЭтоГруппа));
		
		Возврат ОбъектДанных.Ссылка;
		
    Исключение
          т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
          мЛоггер.ерр("Плагин импорта НомерАртикула УПП. Подробности: " + т);
           
          //    ОБЯЗАТЕЛЬНО!!! Потому что в оркестраторе вызов плагина в попытке. и если была ошибка, надо сделать BasicReject()
          ВызватьИсключение т;
 
    КонецПопытки;
	
	
КонецФункции   


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ДобавитьМэппинг(СтруктураОбъекта, ОбъектДанных)
	
		
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition; 
	
	Если РегистрыСведений.ксп_МэппингСправочникКассы.ЕстьГУИД(id.Ref, мВнешняяСистема) = Ложь Тогда
		РегистрыСведений.ксп_МэппингСправочникКассы.ДобавитьЗапись(id.Ref, деф.Наименование, мВнешняяСистема, ОбъектДанных.Ссылка);
	КонецЕсли;
		
КонецПроцедуры


Функция ЗаполнитьРеквизиты(объектДанных, СтруктураОбъекта, ВидНоменклатуры = Неопределено) Экспорт 
	
         
		
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition; 
	
	
	ОбъектДанных.Наименование = деф.Наименование;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark; 	
		
	////ОбъектДанных.ВерхНиз                      = Номенклатура.ВерхНиз;
	//
	//Если деф.ВидВоспроизводства.свойство("Значение") Тогда
	//	Если деф.ВидВоспроизводства.Значение = "Покупка" Тогда
	//		ОбъектДанных.ВидВоспроизводства 					= перечисления.КСП_ВидВоспроизводства.Покупка;
	//	ИначеЕсли деф.ВидВоспроизводства.Значение = "Производство" Тогда
	//		ОбъектДанных.ВидВоспроизводства 					= перечисления.КСП_ВидВоспроизводства.Производство;
	//	ИначеЕсли деф.ВидВоспроизводства.Значение = "Переработка" Тогда
	//		ОбъектДанных.ВидВоспроизводства 					= перечисления.КСП_ВидВоспроизводства.Переработка;
	//	ИначеЕсли деф.ВидВоспроизводства.Значение = "ПринятыеВПереработку" Тогда
	//		ОбъектДанных.ВидВоспроизводства 					= перечисления.КСП_ВидВоспроизводства.ПринятыеВПереработку;
	//	КонецЕсли;
	//	
	//КонецЕсли; 
	//
	//
	////ОбъектДанных.ВидПродукции                 = Номенклатура.ВидПродукции;

	//Если деф.ВидТорговли.свойство("Значение") Тогда
	//	Если деф.ВидТорговли.Значение = "Опт" Тогда
	//		ОбъектДанных.ВидТорговли 					= перечисления.КСП_ВидТорговли.Опт;
	//	ИначеЕсли деф.ВидТорговли.Значение = "Розница" Тогда
	//		ОбъектДанных.ВидТорговли 					= перечисления.КСП_ВидТорговли.Розница;
	//	ИначеЕсли деф.ВидТорговли.Значение = "Прогноз" Тогда
	//		ОбъектДанных.ВидТорговли 					= перечисления.КСП_ВидТорговли.Прогноз;
	//	ИначеЕсли деф.ВидТорговли.Значение = "Партнеры" Тогда
	//		ОбъектДанных.ВидТорговли 					= перечисления.КСП_ВидТорговли.Партнеры;
	//	ИначеЕсли деф.ВидТорговли.Значение = "ОптРозница" Тогда
	//		ОбъектДанных.ВидТорговли 					= перечисления.КСП_ВидТорговли.ОптРозница;
	//	ИначеЕсли деф.ВидТорговли.Значение = "СверхПлана" Тогда
	//		ОбъектДанных.ВидТорговли 					= перечисления.КСП_ВидТорговли.СверхПлана;
	//	КонецЕсли;
	//	
	//КонецЕсли; 
	//
	//
	////пока не трогаем
	////ОбъектДанных.ВнутреннийТовар              = Номенклатура.ВнутреннийТовар;
	//
	//Если деф.ВозрастнаяГруппа.свойство("ref") Тогда
	//	Уид = Новый УникальныйИдентификатор(деф.ВозрастнаяГруппа.Ref);
	//	ОбъектДанных.ВозрастнаяГруппа 						= Справочники.ксп_ВозрастнаяГруппа.ПолучитьСсылку(уид);
	//КонецЕсли;
	//
	//ОбъектДанных.ДатаИзготовления				= деф.ДатаИзготовления;

	//Если деф.Капсула.свойство("ref") Тогда
	//	Уид = Новый УникальныйИдентификатор(деф.капсула.Ref);
	//	ОбъектДанных.Капсула 						= Справочники.ксп_Капсулы.ПолучитьСсылку(уид);
	//КонецЕсли;
	//
	//
	//Если деф.Ликвидность.свойство("Значение") Тогда
	//	Если деф.Ликвидность.Значение = "Ликвид" Тогда
	//		ОбъектДанных.Ликвидность 					= перечисления.КСП_Ликвидность.Ликвид;
	//	ИначеЕсли деф.Ликвидность.Значение = "ПолуЛиквид" Тогда
	//		ОбъектДанных.Ликвидность 					= перечисления.КСП_Ликвидность.ПолуЛиквид;
	//	ИначеЕсли деф.Ликвидность.Значение = "Сток" Тогда
	//		ОбъектДанных.Ликвидность 					= перечисления.КСП_Ликвидность.Сток;
	//	КонецЕсли;
	//	
	//КонецЕсли; 
	//
	//Если деф.Модность.свойство("Значение") Тогда
	//	Если деф.Модность.Значение = "fashion" Тогда
	//		ОбъектДанных.Модность 					= перечисления.КСП_Модность.Fashion;
	//	ИначеЕсли деф.Модность.Значение = "basic" Тогда
	//		ОбъектДанных.Модность 					= перечисления.КСП_Модность.basic;
	//	ИначеЕсли деф.Модность.Значение = "Прочие" Тогда
	//		ОбъектДанных.Модность 					= перечисления.КСП_Модность.Прочие;
	//	КонецЕсли;
	//	
	//КонецЕсли; 
	//
	//Если деф.ХарактерТкани.свойство("ref") Тогда
	//	Уид = Новый УникальныйИдентификатор(деф.ХарактерТкани.Ref);
	//	ОбъектДанных.ХарактерТканиНоменклатуры		= Справочники.ксп_ХарактерТкани.ПолучитьСсылку(уид);
	//КонецЕсли;
	//
	//
	////доделать - поиск по наименованию. из УПП отдавать в тэгах Наименование, а не ГУИД
	//Если деф.цвет.свойство("Ref") Тогда
	//	ОбъектДанных.Цвет 						= деф.Цвет;
	//КонецЕсли;
	//
	
	Если деф.ВалютаДенежныхСредств.свойство("currencyCode") Тогда
		ОбъектДанных.ВалютаДенежныхСредств			= ксп_ИмпортСлужебный.НайтиВалюту(деф.ВалютаДенежныхСредств.currencyCode);
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

мВнешняяСистема = "UPP";
	