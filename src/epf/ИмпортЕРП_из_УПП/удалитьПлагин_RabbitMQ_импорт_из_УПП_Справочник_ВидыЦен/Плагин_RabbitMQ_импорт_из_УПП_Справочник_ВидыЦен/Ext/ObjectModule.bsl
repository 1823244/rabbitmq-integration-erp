﻿Перем мВнешняяСистема;    
Перем ИмяСобытияЖР;
Перем jsonText;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.5");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Справочник_ВидыЦен");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Справочник_ВидыЦен");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Справочник_ВидыЦен",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Справочник_ВидыЦен",
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

Функция ЗагрузитьОбъект(СтруктураОбъекта, njsonText = "") Экспорт
		
	//ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
	//id = СтруктураОбъекта.identification;
	//деф = СтруктураОбъекта.definition;	
	//jsonText = njsonText;
	
	ЧислоЭлементов = 0;
	ЧислоНовыхЭлементов = 0;
	Если типзнч(СтруктураОбъекта) = тип("Массив") Тогда
		Для каждого эл Из СтруктураОбъекта Цикл
			Рез = Загрузить_Справочник_ТипыЦенНоменклатурыУПП(эл);
			Если Рез <> Неопределено Тогда
				ЧислоЭлементов = ЧислоЭлементов + 1;
				Если Рез = 1 Тогда
					ЧислоНовыхЭлементов = ЧислоНовыхЭлементов + 1;
				КонецЕсли;						
			КонецЕсли;	
		КонецЦикла;
	КонецЕсли;
	Рез = Строка(ЧислоЭлементов) + "-" + Строка(ЧислоНовыхЭлементов);
	Возврат Рез;
КонецФункции

#Область ЗагрузкаВСправочник

Функция Загрузить_Справочник_ТипыЦенНоменклатурыУПП(СтруктураОбъекта, jsonText = "") Экспорт
	
	ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП в спр-к ВидыЦен"; 
	
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("справочник.ТипыЦенНоменклатуры") Тогда
		Сообщить("Тип объекта для импорта: " + СтруктураОбъекта.type);
		Возврат Неопределено;
	КонецЕсли;

	id 	= СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;  
    ВидОбъекта = "ВидыЦен";

	//------------------------------------- работа с GUID	
	ОбъектДанных = Неопределено;
	ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	ПредставлениеОбъекта = Строка(ДанныеСсылка);
	ЭтоНовый = Ложь;
	Если НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных) Тогда
		ОбъектДанных = Справочники[ВидОбъекта].СоздатьЭлемент();		
		СсылкаНового = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		ЭтоНовый = Истина; 
		Сообщить("создаем новый э-т спр-ка");
	КонецЕсли; 
	// -------------------------------------------- БЛОКИРОВКА
	Если НЕ ЭтоНовый Тогда
		Блокировка = ксп_Блокировки.СоздатьБлокировкуОдногоОбъекта(ДанныеСсылка);
	КонецЕсли;

	НачатьТранзакцию();
	
	Если НЕ ЭтоНовый Тогда
		Попытка
			Блокировка.Заблокировать();
			ОбъектДанных = ДанныеСсылка.ПолучитьОбъект();
		Исключение
			т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ОбъектДанных.Ссылка,
				"Объект не загружен! Ошибка блокировки объекта <"+ПредставлениеОбъекта+">. Подробности: "+т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
		
	//------------------------------------- Заполнение реквизитов
	Попытка			    
		Рез = ЗаполнитьРеквизитыЭлементаСправочника_ВидыЦен(ОбъектДанных, СтруктураОбъекта, jsonText, ЭтоНовый);		
		ЗафиксироватьТранзакцию(); 
		//Возврат ДанныеСсылка;		
		Если ЭтоНовый Тогда 
			Возврат 1;
		Иначе 
			Возврат 10;
		КонецЕсли;				
	Исключение
		т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ПредставлениеОбъекта,
			"Объект не загружен! Ошибка в процессе загрузки объекта: <"+ПредставлениеОбъекта+">. Подробности: "+т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;	
			
КонецФункции

// Заполняет реквизиты объекта и пишет сопутствующие данные. Должна вызываться в транзакции.
Функция ЗаполнитьРеквизитыЭлементаСправочника_ВидыЦен(ОбъектДанных, СтруктураОбъекта, jsonText = "", ЭтоНовый = Истина) Экспорт

	id 	= СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
//	ОбъектДанных.Код = деф.code;      
	ОбъектДанных.Наименование = id.Description;
	ОбъектДанных.БазовыйВидЦены = Неопределено;
//	ОбъектДанных.ВалютаЦены   = ксп_ИмпортСлужебный.НайтиВалюту(деф.валюта);
	ОбъектДанных.ВалютаЦены = Справочники.Валюты.НайтиПоКоду(деф.Валюта);
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
 	ОбъектДанных.ВариантОкругления = Перечисления.ВариантыОкругления.ПоАрифметическимПравилам;
//	ОбъектДанных.Статус = Перечисления.СтатусыДействияВидовЦен.НеДействует;
	ОбъектДанных.Статус = Перечисления.СтатусыДействияВидовЦен.Действует;
	ОбъектДанных.ТочностьОкругления = 0.01;   
	
	ОбъектДанных.БазовыйВидЦены = деф.БазовыйТипЦен;
	ОбъектДанных.ОкруглятьВБольшуюСторону = деф.ОкруглятьВБольшуюСторону;
	//ОбъектДанных.ОкруглятьСкидкиКак_49_99 = деф.ОкруглятьСкидкиКак_49_99; 
	//ОбъектДанных.Округлять = деф.ОкруглятьСкидкиКак_49_99; 
	
	//ОбъектДанных.ПорядокОкругления = деф.ПорядокОкругления;
	//ОбъектДанных.ПроцентСкидкиНаценки = деф.ПроцентСкидкиНаценки;
	ОбъектДанных.ЦенаВключаетНДС = деф.ЦенаВключаетНДС;
	
	ОбъектДанных.СпособЗаданияЦены = Перечисления.СпособыЗаданияЦен.Вручную;
	//ОбъектДанных.СпособЗаданияЦены = Перечисления.СпособыЗаданияЦен.ЗаполнятьПоДаннымИБ;
	//ОбъектДанных.СпособЗаданияЦены = Перечисления.СпособыЗаданияЦен.ЗагружаетсяСOzon;

	//гуид="";
	//ЕстьАтрибут = id.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	Ссылка = ксп_ИмпортСлужебный.НайтиВидЦеныПоГУИД(ГУИД, мВнешняяСистема);
	//	ОбъектДанных.Ссылка = Ссылка;
	//	//Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.БанковскийСчетОрганизации.Ref ) );
	//Иначе
	//	ОбъектДанных.Ссылка = Неопределено;  
	//	Сообщить("Для вида цен Наименование " + id.description + " нет данных");
	//КонецЕсли;
	// на случай, если есть метод поиска ссылки:                                                                               
	//Если деф.БанковскийСчетОрганизации.Свойство("Счет") Тогда 
	//	ОбъектДанных.БанковскийСчет = ПолучитьБанковскийСчетОрганизации(ОбъектДанных.Организация);
	//Иначе
	//	ОбъектДанных.БанковскийСчет = Неопределено;
	//КонецЕсли;

	//------------------------------------------------------ ФИНАЛ	

	ОбъектДанных.ОбменДанными.Загрузка = Истина; 
	//Сообщить("ОД - записали");
	ОбъектДанных.Записать();  
	//ДанныеСсылка = ОбъектДанных.Ссылка.ПолучитьОбъект();
	//ДанныеСсылка.Формула = Новый УникальныйИдентификатор(ДанныеСсылка);
	//ДанныеСсылка.Записать();  

	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	
	Возврат ОбъектДанных;
	
КонецФункции

#КонецОбласти 	


#Область Тестирование

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервере(JsonText) export

	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.УстановитьСтроку(JsonText);
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	
	Рез = ЗагрузитьОбъект(СтруктураОбъекта, JsonText);
	Возврат Рез;
КонецФункции

Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Сумма" Тогда
		Возврат XMLЗначение(Тип("Число"),Значение);
	КонецЕсли;
	Если Свойство = "Валюта" Тогда
		Возврат Справочники.Валюты.НайтиПоКоду(Значение);
	КонецЕсли;
	
КонецФункции


#КонецОбласти 	

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция МассивРеквизитовШапкиДляПроверки() Экспорт
	
	мРеквизиты = Новый Массив;
	//мРеквизиты.Добавить("Склад");
	//мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции

мВнешняяСистема = "upp";

