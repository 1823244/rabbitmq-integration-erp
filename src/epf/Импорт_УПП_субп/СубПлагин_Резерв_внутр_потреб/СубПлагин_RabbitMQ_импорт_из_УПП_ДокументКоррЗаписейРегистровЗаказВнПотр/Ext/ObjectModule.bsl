﻿Перем мВнешняяСистема;
Перем мТребуетсяПроведение; // Булево
Перем ИмяСобытияЖР;
Перем мИдВызова;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.6");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","СубПлагин_RabbitMQ_импорт_из_УПП_ДокументКоррЗаписейРегистровЗаказВнПотр");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","СубПлагин_RabbitMQ_импорт_из_УПП_ДокументКоррЗаписейРегистровЗаказВнПотр");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : СубПлагин_RabbitMQ_импорт_из_УПП_ДокументКоррЗаписейРегистровЗаказВнПотр",
		"Форма_СубПлагин_RabbitMQ_импорт_из_УПП_ДокументКоррЗаписейРегистровЗаказВнПотр",
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

#Область ПолучениеВнешнейОбработкиПоИмени

Функция ПолучитьОбъектВнешнейОбработкиПоНаименованию(Наименование)
	ТекСсылка = Справочники.ДополнительныеОтчетыИОбработки.НайтиПоНаименованию(Наименование);
	Если не ЗначениеЗаполнено(ТекСсылка) Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(ТекСсылка);
	Возврат ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(ТекСсылка);
КонецФункции

Функция ПолучитьОбъектВнешнейОбработкиПоСсылке(ТекСсылка)
	Если не ЗначениеЗаполнено(ТекСсылка) Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(ТекСсылка);
	Возврат ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(ТекСсылка);
КонецФункции

#КонецОбласти

#Область ЗагрузитьОбъект_

Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "", СкладЕРП = Неопределено) Экспорт
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.КорректировкаЗаписейРегистров") Тогда
		Возврат Неопределено;
	КонецЕсли;


	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	//мТребуетсяПроведение = деф.Проведен;  // у этого вида документов нет такого признака
	мТребуетсяПроведение = Ложь; // эти документы обрабатываются вручную на этапе переноса остатков
	
	Если Лев(деф.Комментарий,15) = "остатки для ERP" и деф.DeletionMark Тогда
		Возврат ЗагрузкаЗаказНаВнутреннееПотребление(id,деф, СтруктураОбъекта, СкладЕРП);
		
	Иначе
		Возврат Документы.ЗаказНаВнутреннееПотребление.ПустаяСсылка();
	КонецЕсли;

КонецФункции

Функция ЗагрузкаЗаказНаВнутреннееПотребление(id, деф, СтруктураОбъекта, СкладЕРП, ВидОбъекта = "ЗаказНаВнутреннееПотребление")
	ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
	
	ДанныеСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	ПредставлениеОбъекта = Строка(ДанныеСсылка);
	ЭтоНовый = Ложь;
	Если (НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных)) и ЗначениеЗаполнено(ДанныеСсылка.Номер) = Ложь и ЗначениеЗаполнено(ДанныеСсылка.Дата) = Ложь Тогда
		ОбъектДанных = Документы[ВидОбъекта].СоздатьДокумент();
		СсылкаНового = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		ЭтоНовый = Истина;
	Иначе
		ОбъектДанных = ДанныеСсылка.ПолучитьОбъект();
	КонецЕсли; 
	
	// -------------------------------------------- БЛОКИРОВКА
	Если НЕ ЭтоНовый Тогда
		Блокировка = СоздатьБлокировкуОдногоОбъекта(ДанныеСсылка, ВидОбъекта);
		Если 1=0 Тогда
			Блокировка = Новый БлокировкаДанных;
		КонецЕсли;
	КонецЕсли;

	НачатьТранзакцию();
	
	//------------------------------------- Заполнение реквизитов
	Провести = ложь;
	Попытка			
		Блокировка.Заблокировать();
		ЗаполнитьДокументЗаказНаВнутреннееПотребление(ОбъектДанных, деф, СкладЕРП);		

		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.Записать(); 
		jsonText = "";
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);	

		ЗафиксироватьТранзакцию();
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ДанныеСсылка,
			"Объект не загружен! Ошибка в процессе загрузки объекта: <"+ПредставлениеОбъекта+">. Подробности: "+т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;
	
	Возврат ОбъектДанных.Ссылка;	

КонецФункции

Процедура ЗаполнитьДокументЗаказНаВнутреннееПотребление(ОбъектДанных, деф, СкладЕРП)
	ОбъектДанных.Организация = Неопределено;;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.ПометкаУдаления = Ложь;
	ОбъектДанных.Комментарий = деф.Number;
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.СписаниеТоваровПоТребованию;
	ОбъектДанных.Статус = Перечисления.СтатусыВнутреннихЗаказов.КВыполнению; 
	ОбъектДанных.КСП_ТипДокументаСлужебногоРезерва = Перечисления.КСП_ТипДокументаСлужебногоРезерва.РаспределениеГотовойПродукцииКаналы;
	ОбъектДанных.Согласован = Истина; 
	ОбъектДанных.Приоритет = Справочники.Приоритеты.НайтиПоНаименованию("Средний");
	ОбъектДанных.Товары.Очистить();
	ОбъектДанных.Склад = СкладЕРП;
	//ТЗ_Цены = Новый ТаблицаЗначений;
	//ТЗ_Цены.Колонки.Добавить("НоменклатураГУИД",Новый ОписаниеТипов("Строка",,,Новый КвалификаторыСтроки(50)));
	//ТЗ_Цены.Колонки.Добавить("ХарактеристикаНоменклатурыГУИД",Новый ОписаниеТипов("Строка",,,Новый КвалификаторыСтроки(50)));
	//ТЗ_Цены.Колонки.Добавить("Цена",Новый ОписаниеТипов("Число",,,,Новый КвалификаторыЧисла(15,2)));
	Организация = Неопределено;
	
	Для каждого строка из деф.РегистрНакопления_Продажи Цикл
		//НС = ТЗ_Цены.Добавить();
		//НС.НоменклатураГУИД = строка.Номенклатура.Ref;
		//Попытка
		//	НС.ХарактеристикаНоменклатурыГУИД = строка.ХарактеристикаНоменклатуры.Ref;
		//Исключение
		//КонецПопытки;
		//НС.Цена = строка.Стоимость /  строка.Количество;
		Если Организация = Неопределено Тогда
			Организация = ПолучитьСсылкуСправочникаПоДаннымID(строка.Организация, "Организации");
		КонецЕсли;
	КонецЦикла;
	ОбъектДанных.Организация = Организация;
	Для каждого строка из деф.РегистрНакопления_ТоварыНаСкладах Цикл
		НоваяСтрока = ОбъектДанных.Товары.Добавить();
		Если ЗаполненаСсылка(строка.Номенклатура) Тогда
			НоваяСтрока.Номенклатура = ПолучитьСсылкуСправочникаПоДаннымID(строка.Номенклатура, "Номенклатура");
		КонецЕсли;
		Если ЗаполненаСсылка(строка.Номенклатура) Тогда
			НоваяСтрока.Характеристика = ПолучитьСсылкуСправочникаПоДаннымID(строка.ХарактеристикаНоменклатуры, "ХарактеристикиНоменклатуры");
		КонецЕсли;
		НоваяСтрока.Количество = строка.Количество; 
		НоваяСтрока.КоличествоУпаковок = строка.Количество; 
		НоваяСтрока.ДатаОтгрузки = ОбъектДанных.Дата;
		НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.СоСклада;
		НоваяСтрока.СтатьяРасходов = ПланыВидовХарактеристик.СтатьиРасходов.ВыбытияТоваровВПрошлыхПериодах;
	КонецЦикла;
	
КонецПроцедуры



Функция  СоздатьБлокировкуОдногоОбъекта(ДанныеСсылка,ВидОбъекта) 
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("Документ."+ВидОбъекта); 
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.УстановитьЗначение("Ссылка",ДанныеСсылка);
	Возврат Блокировка;
КонецФункции
	
#КонецОбласти 	

#Область СлужебныеЗаполненияИПолученияСсылок
Функция ПолучитьСкладERP(СкладУПП) 

	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП КАК СкладУПП,
	|	КСП_ВидыОперацийПоСкладамУПП.СкладЕРП КАК СкладЕРП,
	|	КСП_ВидыОперацийПоСкладамУПП.Ссылка КАК Ссылка,
	|	КСП_ВидыОперацийПоСкладамУПП.ЛогикаОбработкиВШапке КАК ЛогикаОбработки
	|ИЗ
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП КАК КСП_ВидыОперацийПоСкладамУПП
	|ГДЕ
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП = &СкладУПП";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.СкладЕРП;

КонецФункции

Функция ЗаполненаСсылка(СтруктураID) 
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Ложь;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если ЗначениеЗаполнено(Ref) Тогда
			Возврат Истина;
		КонецЕсли;
	Исключение
		Возврат Ложь;
	КонецПопытки;
КонецФункции

Функция ПолучитьСсылкуДокументаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
			Возврат Неопределено;
		КонецЕсли;
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	ДанныеСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	Возврат ДанныеСсылка;
КонецФункции

Функция ПолучитьСсылкуСправочникаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
			Возврат Неопределено;
		КонецЕсли;
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	Возврат ДанныеСсылка;
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
Функция ЗагрузитьИзJsonНаСервере(Json) export

	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.УстановитьСтроку(Json);
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	Возврат ЗагрузитьОбъект(СтруктураОбъекта);
	
КонецФункции

#КонецОбласти 	

Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date" Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период" Тогда
		Попытка
			Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
		Исключение
			Возврат Значение;
		КонецПопытки;
	КонецЕсли;
	Если Свойство = "Сумма" Тогда
		Если ТипЗнч(Значение) = Тип("Число") Тогда
			Возврат Значение;
		Иначе
			Возврат XMLЗначение(Тип("Число"),Значение);
		КонецЕсли;
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
Функция МассивРеквизитовШапкиДляПроверки() Экспорт
	
	мРеквизиты = Новый Массив;
	мРеквизиты.Добавить("СкладОтправитель");
	мРеквизиты.Добавить("СкладПолучатель");
	мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции

Функция ТребуетсяПроведение() Экспорт
		
	Возврат мТребуетсяПроведение;
	
КонецФункции


Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции


мВнешняяСистема = "UPP";
мТребуетсяПроведение = Ложь;
ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

