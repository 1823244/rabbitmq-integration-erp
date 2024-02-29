﻿Перем мВнешняяСистема;
Перем мИмяСобытияЖР;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.3");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах",
		ТипКоманды, 
		Ложь) ;
	
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")

	//ТаблицаКоманд.Колонки.Добавить("Представление", РеквизитыТабличнойЧасти.Представление.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Идентификатор", РеквизитыТабличнойЧасти.Идентификатор.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	//ТаблицаКоманд.Колонки.Добавить("ПоказыватьОповещение", РеквизитыТабличнойЧасти.ПоказыватьОповещение.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Модификатор", РеквизитыТабличнойЧасти.Модификатор.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Скрыть",      РеквизитыТабличнойЧасти.Скрыть.Тип);
	//ТаблицаКоманд.Колонки.Добавить("ЗаменяемыеКоманды", РеквизитыТабличнойЧасти.ЗаменяемыеКоманды.Тип);
	
//           ** Использование - Строка - тип команды:
//               "ВызовКлиентскогоМетода",
//               "ВызовСерверногоМетода",
//               "ЗаполнениеФормы",
//               "ОткрытиеФормы" или
//               "СценарийВБезопасномРежиме".
//               Для получения типов команд рекомендуется использовать функции
//               ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКоманды<ИмяТипа>.
//               В комментариях к этим функциям также даны шаблоны процедур-обработчиков команд.

	НоваяКоманда = ТаблицаКоманд.Добавить() ;
	НоваяКоманда.Представление = Представление ;
	НоваяКоманда.Идентификатор = Идентификатор ;
	НоваяКоманда.Использование = Использование ;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение ;
	НоваяКоманда.Модификатор = Модификатор ;
КонецПроцедуры


#КонецОбласти 	



Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	Если НЕ СтруктураОбъекта.Свойство("type") Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.ОтчетКомиссионераОПродажах") Тогда
		Возврат Неопределено;
	КонецЕсли;

	

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	
	
	
	ВидОбъекта = "ОтчетКомиссионера";

	//------------------------------------- работа с GUID	
	ОбъектДанных = Неопределено;
	ДанныеСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	ПредставлениеОбъекта = Строка(ДанныеСсылка);
	ЭтоНовый = Ложь;
	Если НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных) Тогда
		ОбъектДанных = Документы[ВидОбъекта].СоздатьДокумент();
		СсылкаНового = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		ЭтоНовый = Истина;
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
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(мИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ОбъектДанных.Ссылка,
				"Объект не загружен! Ошибка блокировки объекта <"+ПредставлениеОбъекта+">. Подробности: "+т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
		
	//------------------------------------- Заполнение реквизитов
	Попытка			
		ЗаполнитьРеквизиты(ОбъектДанных, СтруктураОбъекта, jsonText);		
		ЗафиксироватьТранзакцию();          		
		Возврат ДанныеСсылка;		
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(мИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ДанныеСсылка,
			"Объект не загружен! Ошибка в процессе загрузки объекта: <"+ПредставлениеОбъекта+">. Подробности: "+т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;	
			
КонецФункции



// Заполняет реквизиты объекта и пишет сопутствующие данные. Должна вызываться в транзакции.
Функция ЗаполнитьРеквизиты(ОбъектДанных, СтруктураОбъекта, jsonText = "") Экспорт

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	//гуид="";
	//ЕстьАтрибут = деф.Автор.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Автор = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Автор.Ref ) );
	//Иначе
	//	ОбъектДанных.Автор = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Автор = ксп_ИмпортСлужебный.НайтиАвтор(деф.Автор);

	//гуид="";
	//ЕстьАтрибут = деф.БанковскийСчет.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.БанковскийСчет = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.БанковскийСчет.Ref ) );
	//Иначе
	//	ОбъектДанных.БанковскийСчет = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.БанковскийСчет = ксп_ИмпортСлужебный.НайтиБанковскийСчет(деф.БанковскийСчет);

	ОбъектДанных.Валюта = константы.ВалютаРегламентированногоУчета.Получить();

	ОбъектДанных.ВидыЗапасовУказаныВручную = Ложь;


	//гуид="";
	//ЕстьАтрибут = деф.ГрафикОплаты.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ГрафикОплаты = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ГрафикОплаты.Ref ) );
	//Иначе
	//	ОбъектДанных.ГрафикОплаты = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ГрафикОплаты = ксп_ИмпортСлужебный.НайтиГрафикОплаты(деф.ГрафикОплаты);

	//гуид="";
	//ЕстьАтрибут = деф.Грузоотправитель.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Грузоотправитель = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Грузоотправитель.Ref ) );
	//Иначе
	//	ОбъектДанных.Грузоотправитель = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Грузоотправитель = ксп_ИмпортСлужебный.НайтиГрузоотправитель(деф.Грузоотправитель);

	//гуид="";
	//ЕстьАтрибут = деф.ГруппаФинансовогоУчета.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ГруппаФинансовогоУчета = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ГруппаФинансовогоУчета.Ref ) );
	//Иначе
	//	ОбъектДанных.ГруппаФинансовогоУчета = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ГруппаФинансовогоУчета = ксп_ИмпортСлужебный.НайтиГруппаФинансовогоУчета(деф.ГруппаФинансовогоУчета);

	ОбъектДанных.ДатаВходящегоДокумента = деф.ДатаВходящегоДокумента;

	//ОбъектДанных.ДатаПлатежа = деф.ДатаПлатежа;

	//гуид="";
	//ЕстьАтрибут = деф.Договор.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Договор = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Договор.Ref ) );
	//Иначе
	//	ОбъектДанных.Договор = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	ОбъектДанных.Договор = ксп_ИмпортСлужебный.НайтиДоговор(деф.ДоговорКонтрагента, деф.Контрагент);

	//ОбъектДанных.ИдентификаторДокумента = деф.ИдентификаторДокумента;

	//ОбъектДанных.ИдентификаторПлатежа = деф.ИдентификаторПлатежа;

	//гуид="";
	//ЕстьАтрибут = деф.Касса.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Касса = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Касса.Ref ) );
	//Иначе
	//	ОбъектДанных.Касса = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Касса = ксп_ИмпортСлужебный.НайтиКасса(деф.Касса);

	ОбъектДанных.Комментарий = деф.Комментарий;

	//ОбъектДанных.КонецПериода = деф.КонецПериода;

	//гуид="";
	//ЕстьАтрибут = деф.КонтактноеЛицо.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.КонтактноеЛицо = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.КонтактноеЛицо.Ref ) );
	//Иначе
	//	ОбъектДанных.КонтактноеЛицо = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.КонтактноеЛицо = ксп_ИмпортСлужебный.НайтиКонтактноеЛицо(деф.КонтактноеЛицо);

	ОбъектДанных.Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, МВнешняяСистема);

	//гуид="";
	//ЕстьАтрибут = деф.Менеджер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Менеджер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Менеджер.Ref ) );
	//Иначе
	//	ОбъектДанных.Менеджер = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Менеджер = ксп_ИмпортСлужебный.НайтиМенеджер(деф.Менеджер);

	//ОбъектДанных.НаименованиеВходящегоДокумента = деф.НаименованиеВходящегоДокумента;

	ОбъектДанных.НалогообложениеНДС = перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;

	//гуид="";
	//ЕстьАтрибут = деф.НаправлениеДеятельности.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.НаправлениеДеятельности = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.НаправлениеДеятельности.Ref ) );
	//Иначе
	//	ОбъектДанных.НаправлениеДеятельности = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.НаправлениеДеятельности = ксп_ИмпортСлужебный.НайтиНаправлениеДеятельности(деф.НаправлениеДеятельности);

	//ОбъектДанных.НачалоПериода = деф.НачалоПериода;

	ОбъектДанных.НомерВходящегоДокумента = деф.НомерВходящегоДокумента;

	//гуид="";
	//ЕстьАтрибут = деф.ОбъектРасчетов.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ОбъектРасчетов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ОбъектРасчетов.Ref ) );
	//Иначе
	//	ОбъектДанных.ОбъектРасчетов = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ОбъектРасчетов = ксп_ИмпортСлужебный.НайтиОбъектРасчетов(деф.ОбъектРасчетов);

	//гуид="";
	//ЕстьАтрибут = деф.ОбъектРасчетовВознаграждение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ОбъектРасчетовВознаграждение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ОбъектРасчетовВознаграждение.Ref ) );
	//Иначе
	//	ОбъектДанных.ОбъектРасчетовВознаграждение = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ОбъектРасчетовВознаграждение = ксп_ИмпортСлужебный.НайтиОбъектРасчетовВознаграждение(деф.ОбъектРасчетовВознаграждение);

	ОбъектДанных.ОплатаВВалюте = Ложь;

	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);

	//гуид="";
	//ЕстьАтрибут = деф.Партнер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Партнер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Партнер.Ref ) );
	//Иначе
	//	ОбъектДанных.Партнер = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	ОбъектДанных.Партнер = ОбъектДанных.Контрагент.Партнер;//ксп_ИмпортСлужебный.НайтиПартнер(деф.Партнер);
	
	//гуид="";
	//ЕстьАтрибут = деф.Подразделение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Подразделение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Подразделение.Ref ) );
	//Иначе
	//	ОбъектДанных.Подразделение = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Подразделение = ксп_ИмпортСлужебный.НайтиПодразделение(деф.Подразделение);

	ОбъектДанных.ПоРезультатамИнвентаризации = Ложь;

	//_знч = "";
	//ЕстьЗначение = деф.ПорядокРасчетов.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ПорядокРасчетов = деф.ПорядокРасчетов.Значение;
	//Иначе
	//	ОбъектДанных.ПорядокРасчетов = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	ОбъектДанных.ПорядокРасчетов = ОбъектДанных.Договор.ПорядокРасчетов;

	ОбъектДанных.ПроцентВознаграждения = деф.ПроцентКомиссионногоВознаграждения;

	//гуид="";
	//ЕстьАтрибут = деф.Руководитель.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Руководитель = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Руководитель.Ref ) );
	//Иначе
	//	ОбъектДанных.Руководитель = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Руководитель = ксп_ИмпортСлужебный.НайтиРуководитель(деф.Руководитель);
	
	// todo Нужна константа
	//ОбъектДанных.Соглашение = ксп_ИмпортСлужебный.НайтиСоглашение(деф.Соглашение);

	// todo нужна конвертация перечисления
	ОбъектДанных.СпособРасчетаВознаграждения = деф.СпособРасчетаКомиссионногоВознаграждения;

	// todo нужна конвертация перечисления
	ОбъектДанных.СтавкаНДСВознаграждения = деф.СтавкаНДСВознаграждения;
	
	// todo Нужна константа
	//ОбъектДанных.СтатьяРасходов = ксп_ИмпортСлужебный.НайтиСтатьяРасходов(деф.СтатьяРасходов);

	ОбъектДанных.СуммаВознаграждения = деф.СуммаВознаграждения;

	ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;

	ОбъектДанных.СуммаНДСВознаграждения = деф.СуммаНДСВознаграждения;

	ОбъектДанных.УдержатьВознаграждение = деф.УдержатьКомиссионноеВознаграждение;// булево

	// todo Нужна константа

	//гуид="";
	//ЕстьАтрибут = деф.Услуга.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Услуга = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Услуга.Ref ) );
	//Иначе
	//	ОбъектДанных.Услуга = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Услуга = ксп_ИмпортСлужебный.НайтиУслуга(деф.Услуга);

	// todo Нужна константа
	//ОбъектДанных.ФормаОплаты = ксп_ИмпортСлужебный.НайтиПеречисление_ФормаОплаты(деф.ФормаОплаты);

	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ОтчетКомиссионера;

	ОбъектДанных.ЦенаВключаетНДС = деф.НДСВключенВСтоимость;




	//------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();

	
	Склад = Неопределено;
	
	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();
		
		
		//гуид="";
		//ЕстьАтрибут = стрк.ВидЦены.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ВидЦены = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ВидЦены.Ref ) );
		//Иначе
		//	СтрокаТЧ.ВидЦены = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.ВидЦены = ксп_ИмпортСлужебный.НайтиВидЦены(стрк.ВидЦены);

		//гуид="";
		//ЕстьАтрибут = стрк.ВидЦеныПродажи.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ВидЦеныПродажи = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ВидЦеныПродажи.Ref ) );
		//Иначе
		//	СтрокаТЧ.ВидЦеныПродажи = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.ВидЦеныПродажи = ксп_ИмпортСлужебный.НайтиВидЦеныПродажи(стрк.ВидЦеныПродажи);

		//СтрокаТЧ.ДатаСчетаФактурыКомиссионера = стрк.ДатаСчетаФактурыКомиссионера;

		//СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

		//гуид="";
		//ЕстьАтрибут = стрк.КодТНВЭД.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.КодТНВЭД = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.КодТНВЭД.Ref ) );
		//Иначе
		//	СтрокаТЧ.КодТНВЭД = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.КодТНВЭД = ксп_ИмпортСлужебный.НайтиКодТНВЭД(стрк.КодТНВЭД);

		СтрокаТЧ.Количество = стрк.Количество;

		//СтрокаТЧ.КоличествоПоРНПТ = стрк.КоличествоПоРНПТ;

		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;

		СтрокаТЧ.КоличествоУпаковокУчет = стрк.Количество;

		СтрокаТЧ.КоличествоУпаковокФакт = стрк.Количество;

		СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);
		
		//гуид="";
		//ЕстьАтрибут = стрк.НомерГТД.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.НомерГТД = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НомерГТД.Ref ) );
		//Иначе
		//	СтрокаТЧ.НомерГТД = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.НомерГТД = ксп_ИмпортСлужебный.НайтиНомерГТД(стрк.НомерГТД);

		//СтрокаТЧ.НомерСчетаФактурыКомиссионера = стрк.НомерСчетаФактурыКомиссионера;

		//гуид="";
		//ЕстьАтрибут = стрк.Покупатель.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Покупатель = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Покупатель.Ref ) );
		//Иначе
		//	СтрокаТЧ.Покупатель = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.Покупатель = ксп_ИмпортСлужебный.НайтиПокупатель(стрк.Покупатель);

		//гуид="";
		//ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Серия = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Серия.Ref ) );
		//Иначе
		//	СтрокаТЧ.Серия = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.Серия = ксп_ИмпортСлужебный.НайтиСерия(стрк.Серия);

		СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.ОпределитьСтавкуНДСПоПеречислениюУПП(стрк.СтавкаНДС);

		//СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;
				//"Сумма": "1438",
				//"СуммаВознаграждения": "193.74",
				//"СуммаНДС": "239.67",
				//"СуммаНДСВознаграждения": "32.29",
				//"СуммаНДСПередачи": "3366.5",
				//"СуммаПередачи": "20199",

		СтрокаТЧ.Сумма = стрк.Сумма;

		СтрокаТЧ.СуммаВознаграждения = стрк.СуммаВознаграждения;

		СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;

		СтрокаТЧ.СуммаНДСВознаграждения = стрк.СуммаНДСВознаграждения;

		СтрокаТЧ.СуммаПродажи = стрк.Сумма;

		СтрокаТЧ.СуммаПродажиНДС = стрк.СуммаНДС;

		СтрокаТЧ.СуммаСНДС = стрк.Сумма;

		СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиЕдиницуИзмерения(стрк.ЕдиницаИзмерения, стрк.Номенклатура);

        // ОК
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);

		СтрокаТЧ.Цена = стрк.ЦенаПередачи;

		СтрокаТЧ.ЦенаПродажи = стрк.Цена;

		// временно отключим, чтоы проверить внутренние механизмы заполнения
		//СтрокаТЧ.АналитикаУчетаНоменклатуры = ксп_ИмпортСлужебный
		//	.НайтиСоздатьКлючАналитикиНом(строкаТЧ.Номенклатура, Склад, строкаТЧ.Характеристика);

		
	КонецЦикла;

	////------------------------------------------------------     ТЧ ЭтапыГрафикаОплаты



	//ОбъектДанных.ЭтапыГрафикаОплаты.Очистить();


	//Для счТовары = 0 По деф.ТЧЭтапыГрафикаОплаты.Количество()-1 Цикл
	//	стрк = деф.ТЧЭтапыГрафикаОплаты[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ЭтапыГрафикаОплаты.Добавить();


	//	_знч = "";
	//	ЕстьЗначение = стрк.ВариантОплаты.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ВариантОплаты = стрк.ВариантОплаты.Значение;
	//	Иначе
	//		СтрокаТЧ.ВариантОплаты = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ВариантОплаты = ксп_ИмпортСлужебный.НайтиПеречисление_ВариантОплаты(стрк.ВариантОплаты);

	//	_знч = "";
	//	ЕстьЗначение = стрк.ВариантОтсчета.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ВариантОтсчета = стрк.ВариантОтсчета.Значение;
	//	Иначе
	//		СтрокаТЧ.ВариантОтсчета = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ВариантОтсчета = ксп_ИмпортСлужебный.НайтиПеречисление_ВариантОтсчета(стрк.ВариантОтсчета);

	//	СтрокаТЧ.ДатаПлатежа = стрк.ДатаПлатежа;

	//	СтрокаТЧ.ПроцентПлатежа = стрк.ПроцентПлатежа;

	//	СтрокаТЧ.Сдвиг = стрк.Сдвиг;

	//	СтрокаТЧ.СуммаВзаиморасчетов = стрк.СуммаВзаиморасчетов;

	//	СтрокаТЧ.СуммаПлатежа = стрк.СуммаПлатежа;

	//КонецЦикла;


	
	////------------------------------------------------------     ТЧ ВидыЗапасов



	//ОбъектДанных.ВидыЗапасов.Очистить();


	//Для счТовары = 0 По деф.ТЧВидыЗапасов.Количество()-1 Цикл
	//	стрк = деф.ТЧВидыЗапасов[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ВидыЗапасов.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.АналитикаУчетаНоменклатуры.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.АналитикаУчетаНоменклатуры = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.АналитикаУчетаНоменклатуры.Ref ) );
	//	Иначе
	//		СтрокаТЧ.АналитикаУчетаНоменклатуры = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.АналитикаУчетаНоменклатуры = ксп_ИмпортСлужебный.НайтиАналитикаУчетаНоменклатуры(стрк.АналитикаУчетаНоменклатуры);

	//	гуид="";
	//	ЕстьАтрибут = стрк.ВидЗапасов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ВидЗапасов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ВидЗапасов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ВидЗапасов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ВидЗапасов = ксп_ИмпортСлужебный.НайтиВидЗапасов(стрк.ВидЗапасов);

	//	СтрокаТЧ.ДатаСчетаФактурыКомиссионера = стрк.ДатаСчетаФактурыКомиссионера;

	//	СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

	//	гуид="";
	//	ЕстьАтрибут = стрк.КодТНВЭД.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.КодТНВЭД = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.КодТНВЭД.Ref ) );
	//	Иначе
	//		СтрокаТЧ.КодТНВЭД = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.КодТНВЭД = ксп_ИмпортСлужебный.НайтиКодТНВЭД(стрк.КодТНВЭД);

	//	СтрокаТЧ.Количество = стрк.Количество;

	//	СтрокаТЧ.КоличествоПоРНПТ = стрк.КоличествоПоРНПТ;

	//	СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;

	//	гуид="";
	//	ЕстьАтрибут = стрк.НомерГТД.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.НомерГТД = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НомерГТД.Ref ) );
	//	Иначе
	//		СтрокаТЧ.НомерГТД = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.НомерГТД = ксп_ИмпортСлужебный.НайтиНомерГТД(стрк.НомерГТД);

	//	СтрокаТЧ.НомерСчетаФактурыКомиссионера = стрк.НомерСчетаФактурыКомиссионера;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Покупатель.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Покупатель = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Покупатель.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Покупатель = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Покупатель = ксп_ИмпортСлужебный.НайтиПокупатель(стрк.Покупатель);

	//	гуид="";
	//	ЕстьАтрибут = стрк.СтавкаНДС.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.СтавкаНДС = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.СтавкаНДС.Ref ) );
	//	Иначе
	//		СтрокаТЧ.СтавкаНДС = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.НайтиСтавкаНДС(стрк.СтавкаНДС);

	//	СтрокаТЧ.СуммаВознаграждения = стрк.СуммаВознаграждения;

	//	СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;

	//	СтрокаТЧ.СуммаНДСВознаграждения = стрк.СуммаНДСВознаграждения;

	//	СтрокаТЧ.СуммаСНДС = стрк.СуммаСНДС;

	//	_знч = "";
	//	ЕстьЗначение = стрк.УдалитьСтавкаНДС.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.УдалитьСтавкаНДС = стрк.УдалитьСтавкаНДС.Значение;
	//	Иначе
	//		СтрокаТЧ.УдалитьСтавкаНДС = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.УдалитьСтавкаНДС = ксп_ИмпортСлужебный.НайтиПеречисление_УдалитьСтавкаНДС(стрк.УдалитьСтавкаНДС);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Упаковка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Упаковка.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Упаковка = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиУпаковка(стрк.Упаковка);

	//КонецЦикла;

	////------------------------------------------------------     ТЧ ДополнительныеРеквизиты



	//ОбъектДанных.ДополнительныеРеквизиты.Очистить();


	//Для счТовары = 0 По деф.ТЧДополнительныеРеквизиты.Количество()-1 Цикл
	//	стрк = деф.ТЧДополнительныеРеквизиты[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ДополнительныеРеквизиты.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.Значение.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Значение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Значение.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Значение = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Значение = ксп_ИмпортСлужебный.НайтиЗначение(стрк.Значение);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Свойство.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Свойство = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Свойство.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Свойство = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Свойство = ксп_ИмпортСлужебный.НайтиСвойство(стрк.Свойство);

	//	СтрокаТЧ.ТекстоваяСтрока = стрк.ТекстоваяСтрока;

	//КонецЦикла;

	////------------------------------------------------------     ТЧ РасшифровкаПлатежаСКлиентом



	//ОбъектДанных.РасшифровкаПлатежаСКлиентом.Очистить();


	//Для счТовары = 0 По деф.ТЧРасшифровкаПлатежаСКлиентом.Количество()-1 Цикл
	//	стрк = деф.ТЧРасшифровкаПлатежаСКлиентом[счТовары];
	//	СтрокаТЧ = ОбъектДанных.РасшифровкаПлатежаСКлиентом.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.ОбъектРасчетов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ОбъектРасчетов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ОбъектРасчетов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ОбъектРасчетов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ОбъектРасчетов = ксп_ИмпортСлужебный.НайтиОбъектРасчетов(стрк.ОбъектРасчетов);

	//	СтрокаТЧ.Сумма = стрк.Сумма;

	//	СтрокаТЧ.СуммаВзаиморасчетов = стрк.СуммаВзаиморасчетов;

	//	гуид="";
	//	ЕстьАтрибут = стрк.УдалитьЗаказ.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.УдалитьЗаказ = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.УдалитьЗаказ.Ref ) );
	//	Иначе
	//		СтрокаТЧ.УдалитьЗаказ = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.УдалитьЗаказ = ксп_ИмпортСлужебный.НайтиУдалитьЗаказ(стрк.УдалитьЗаказ);

	//КонецЦикла;

	////------------------------------------------------------     ТЧ РасшифровкаПлатежаСПоставщиком



	//ОбъектДанных.РасшифровкаПлатежаСПоставщиком.Очистить();


	//Для счТовары = 0 По деф.ТЧРасшифровкаПлатежаСПоставщиком.Количество()-1 Цикл
	//	стрк = деф.ТЧРасшифровкаПлатежаСПоставщиком[счТовары];
	//	СтрокаТЧ = ОбъектДанных.РасшифровкаПлатежаСПоставщиком.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.ОбъектРасчетов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ОбъектРасчетов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ОбъектРасчетов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ОбъектРасчетов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ОбъектРасчетов = ксп_ИмпортСлужебный.НайтиОбъектРасчетов(стрк.ОбъектРасчетов);

	//	СтрокаТЧ.Сумма = стрк.Сумма;

	//	СтрокаТЧ.СуммаВзаиморасчетов = стрк.СуммаВзаиморасчетов;

	//	гуид="";
	//	ЕстьАтрибут = стрк.УдалитьЗаказ.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.УдалитьЗаказ = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.УдалитьЗаказ.Ref ) );
	//	Иначе
	//		СтрокаТЧ.УдалитьЗаказ = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.УдалитьЗаказ = ксп_ИмпортСлужебный.НайтиУдалитьЗаказ(стрк.УдалитьЗаказ);

	//КонецЦикла;

	////------------------------------------------------------     ТЧ Серии



	//ОбъектДанных.Серии.Очистить();


	//Для счТовары = 0 По деф.ТЧСерии.Количество()-1 Цикл
	//	стрк = деф.ТЧСерии[счТовары];
	//	СтрокаТЧ = ОбъектДанных.Серии.Добавить();


	//	СтрокаТЧ.Количество = стрк.Количество;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Номенклатура.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Номенклатура = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Номенклатура.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Номенклатура = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатура(стрк.Номенклатура);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Серия = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Серия.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Серия = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Серия = ксп_ИмпортСлужебный.НайтиСерия(стрк.Серия);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Характеристика.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Характеристика = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Характеристика.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Характеристика = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристика(стрк.Характеристика);

	//КонецЦикла;

	
	
	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	
	
	Попытка
		// ЕНС. Используем типовые механизны для дозаполнения документа
		Отказ = Ложь;                                     
		ТаблицыДокумента = Документы.ОтчетКомиссионера.КоллекцияТабличныхЧастейТоваров();
		ОбъектДанных.ЗаполнитьВидыЗапасовПриОбмене(Отказ, ТаблицыДокумента);
	Исключение
		т = ОписаниеОшибки();
		ЗаписьЖурналаРегистрации(мИмяСобытияЖР, УровеньЖурналаРегистрации.Ошибка,,,т);
	КонецПопытки;

КонецФункции






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
	
	Рез = Неопределено;
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		
		Для каждого эл Из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(эл);
		КонецЦикла;
		
	Иначе 
		//структура
		рез = ЗагрузитьОбъект(СтруктураОбъекта);
	КонецЕсли;

	
	
	Возврат рез;
	
КонецФункции

#КонецОбласти 	


Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
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
	//мРеквизиты.Добавить("Склад");
	//мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции


 мВнешняяСистема = "retail";
 
 мИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
 
 
 
 