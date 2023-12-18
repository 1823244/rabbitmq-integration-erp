﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_РегистрНакопления_ТоварыПереданные");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_РегистрНакопления_ТоварыПереданные");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_РегистрНакопления_ТоварыПереданные",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_РегистрНакопления_ТоварыПереданные",
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
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("РегистрНакопления.ТоварыПереданные") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;

    	
	ОбъектДанных = Документы.ВводОстатковТоваров.СоздатьДокумент();
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Дата = деф.ДатаОстатков;
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	
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
	//ЕстьАтрибут = деф.Валюта.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Валюта = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Валюта.Ref ) );
	//Иначе
	//	ОбъектДанных.Валюта = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Валюта = ксп_ИмпортСлужебный.НайтиВалюта(деф.Валюта);

	//_знч = "";
	//ЕстьЗначение = деф.ВидДеятельностиНДС.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ВидДеятельностиНДС = деф.ВидДеятельностиНДС.Значение;
	//Иначе
	//	ОбъектДанных.ВидДеятельностиНДС = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ВидДеятельностиНДС = ксп_ИмпортСлужебный.НайтиПеречисление_ВидДеятельностиНДС(деф.ВидДеятельностиНДС);

	//гуид="";
	//ЕстьАтрибут = деф.Договор.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Договор = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Договор.Ref ) );
	//Иначе
	//	ОбъектДанных.Договор = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Договор = ксп_ИмпортСлужебный.НайтиДоговор(деф.Договор);

	//ОбъектДанных.ДополнятьНомера = деф.ДополнятьНомера;

	//гуид="";
	//ЕстьАтрибут = деф.Заказ.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Заказ = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Заказ.Ref ) );
	//Иначе
	//	ОбъектДанных.Заказ = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Заказ = ксп_ИмпортСлужебный.НайтиЗаказ(деф.Заказ);

	//гуид="";
	//ЕстьАтрибут = деф.ЗонаПриемки.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ЗонаПриемки = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ЗонаПриемки.Ref ) );
	//Иначе
	//	ОбъектДанных.ЗонаПриемки = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ЗонаПриемки = ксп_ИмпортСлужебный.НайтиЗонаПриемки(деф.ЗонаПриемки);

	//ОбъектДанных.Исправление = деф.Исправление;

	//гуид="";
	//ЕстьАтрибут = деф.ИсправляемыйДокумент.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ИсправляемыйДокумент = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ИсправляемыйДокумент.Ref ) );
	//Иначе
	//	ОбъектДанных.ИсправляемыйДокумент = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ИсправляемыйДокумент = ксп_ИмпортСлужебный.НайтиИсправляемыйДокумент(деф.ИсправляемыйДокумент);

	//ОбъектДанных.Комментарий = деф.Комментарий;

	//гуид="";
	//ЕстьАтрибут = деф.Контрагент.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Контрагент = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Контрагент.Ref ) );
	//Иначе
	//	ОбъектДанных.Контрагент = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагент(деф.Контрагент);

	//гуид="";
	//ЕстьАтрибут = деф.Менеджер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Менеджер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Менеджер.Ref ) );
	//Иначе
	//	ОбъектДанных.Менеджер = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Менеджер = ксп_ИмпортСлужебный.НайтиМенеджер(деф.Менеджер);

	//_знч = "";
	//ЕстьЗначение = деф.НалогообложениеНДС.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.НалогообложениеНДС = деф.НалогообложениеНДС.Значение;
	//Иначе
	//	ОбъектДанных.НалогообложениеНДС = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.НалогообложениеНДС = ксп_ИмпортСлужебный.НайтиПеречисление_НалогообложениеНДС(деф.НалогообложениеНДС);

	//гуид="";
	//ЕстьАтрибут = деф.НаправлениеДеятельности.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.НаправлениеДеятельности = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.НаправлениеДеятельности.Ref ) );
	//Иначе
	//	ОбъектДанных.НаправлениеДеятельности = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.НаправлениеДеятельности = ксп_ИмпортСлужебный.НайтиНаправлениеДеятельности(деф.НаправлениеДеятельности);

	

	//гуид="";
	//ЕстьАтрибут = деф.Основание.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Основание = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Основание.Ref ) );
	//Иначе
	//	ОбъектДанных.Основание = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Основание = ксп_ИмпортСлужебный.НайтиОснование(деф.Основание);

	//гуид="";
	//ЕстьАтрибут = деф.Ответственный.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Ответственный = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Ответственный.Ref ) );
	//Иначе
	//	ОбъектДанных.Ответственный = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.НайтиОтветственный(деф.Ответственный);

	//ОбъектДанных.ОтражатьВБУиНУ = деф.ОтражатьВБУиНУ;

	//ОбъектДанных.ОтражатьВОперативномУчете = деф.ОтражатьВОперативномУчете;

	//ОбъектДанных.ОтражатьВУУ = деф.ОтражатьВУУ;

	//ОбъектДанных.ОтражатьСебестоимость = деф.ОтражатьСебестоимость;

	//гуид="";
	//ЕстьАтрибут = деф.Партия.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Партия = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Партия.Ref ) );
	//Иначе
	//	ОбъектДанных.Партия = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Партия = ксп_ИмпортСлужебный.НайтиПартия(деф.Партия);

	//гуид="";
	//ЕстьАтрибут = деф.Партнер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Партнер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Партнер.Ref ) );
	//Иначе
	//	ОбъектДанных.Партнер = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Партнер = ксп_ИмпортСлужебный.НайтиПартнер(деф.Партнер);

	//гуид="";
	//ЕстьАтрибут = деф.Подразделение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Подразделение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Подразделение.Ref ) );
	//Иначе
	//	ОбъектДанных.Подразделение = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Подразделение = ксп_ИмпортСлужебный.НайтиПодразделение(деф.Подразделение);

	//гуид="";
	//ЕстьАтрибут = деф.Помещение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Помещение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Помещение.Ref ) );
	//Иначе
	//	ОбъектДанных.Помещение = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Помещение = ксп_ИмпортСлужебный.НайтиПомещение(деф.Помещение);

	//ОбъектДанных.Префикс = деф.Префикс;

	//гуид="";
	//ЕстьАтрибут = деф.Склад.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Склад = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Склад.Ref ) );
	//Иначе
	//	ОбъектДанных.Склад = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Склад = ксп_ИмпортСлужебный.НайтиСклад(деф.Склад);

	//гуид="";
	//ЕстьАтрибут = деф.СоглашениеСКлиентом.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.СоглашениеСКлиентом = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.СоглашениеСКлиентом.Ref ) );
	//Иначе
	//	ОбъектДанных.СоглашениеСКлиентом = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СоглашениеСКлиентом = ксп_ИмпортСлужебный.НайтиСоглашениеСКлиентом(деф.СоглашениеСКлиентом);

	//гуид="";
	//ЕстьАтрибут = деф.СоглашениеСКомиссионером.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.СоглашениеСКомиссионером = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.СоглашениеСКомиссионером.Ref ) );
	//Иначе
	//	ОбъектДанных.СоглашениеСКомиссионером = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СоглашениеСКомиссионером = ксп_ИмпортСлужебный.НайтиСоглашениеСКомиссионером(деф.СоглашениеСКомиссионером);

	//гуид="";
	//ЕстьАтрибут = деф.СоглашениеСКомитентом.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.СоглашениеСКомитентом = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.СоглашениеСКомитентом.Ref ) );
	//Иначе
	//	ОбъектДанных.СоглашениеСКомитентом = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СоглашениеСКомитентом = ксп_ИмпортСлужебный.НайтиСоглашениеСКомитентом(деф.СоглашениеСКомитентом);

	//гуид="";
	//ЕстьАтрибут = деф.СторнируемыйДокумент.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.СторнируемыйДокумент = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.СторнируемыйДокумент.Ref ) );
	//Иначе
	//	ОбъектДанных.СторнируемыйДокумент = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СторнируемыйДокумент = ксп_ИмпортСлужебный.НайтиСторнируемыйДокумент(деф.СторнируемыйДокумент);

	//_знч = "";
	//ЕстьЗначение = деф.ХозяйственнаяОперация.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ХозяйственнаяОперация = деф.ХозяйственнаяОперация.Значение;
	//Иначе
	//	ОбъектДанных.ХозяйственнаяОперация = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ХозяйственнаяОперация = ксп_ИмпортСлужебный.НайтиПеречисление_ХозяйственнаяОперация(деф.ХозяйственнаяОперация);

	//ОбъектДанных.ЦенаВключаетНДС = деф.ЦенаВключаетНДС;




	////------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();


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

	//	гуид="";
	//	ЕстьАтрибут = стрк.ГруппаПродукции.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ГруппаПродукции = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ГруппаПродукции.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ГруппаПродукции = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ГруппаПродукции = ксп_ИмпортСлужебный.НайтиГруппаПродукции(стрк.ГруппаПродукции);

	//	СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

	//	СтрокаТЧ.КодСтроки = стрк.КодСтроки;

		СтрокаТЧ.Количество = стрк.Количество;

	//	СтрокаТЧ.КоличествоПоРНПТ = стрк.КоличествоПоРНПТ;

		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Назначение.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Назначение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Назначение.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Назначение = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Назначение = ксп_ИмпортСлужебный.НайтиНазначение(стрк.Назначение);

	//	СтрокаТЧ.НДСРегл = стрк.НДСРегл;

		СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатура(стрк.Номенклатура);
	//	гуид="";
	//	ЕстьАтрибут = стрк.Характеристика.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Характеристика = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Характеристика.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Характеристика = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);

	//	гуид="";
	//	ЕстьАтрибут = стрк.НомерГТД.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.НомерГТД = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НомерГТД.Ref ) );
	//	Иначе
	//		СтрокаТЧ.НомерГТД = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.НомерГТД = ксп_ИмпортСлужебный.НайтиНомерГТД(стрк.НомерГТД);

	//	СтрокаТЧ.ПредусмотренЗалогЗаТару = стрк.ПредусмотренЗалогЗаТару;

	//	СтрокаТЧ.РезервПодОбесценениеРегл = стрк.РезервПодОбесценениеРегл;

	//	СтрокаТЧ.РезервПодОбесценениеУпр = стрк.РезервПодОбесценениеУпр;

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
	//	ЕстьАтрибут = стрк.СтавкаНДС.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.СтавкаНДС = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.СтавкаНДС.Ref ) );
	//	Иначе
	//		СтрокаТЧ.СтавкаНДС = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.НайтиСтавкаНДС(стрк.СтавкаНДС);

	//	СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;

	//	СтрокаТЧ.Сумма = стрк.Сумма;

	//	СтрокаТЧ.СуммаБезНДС = стрк.СуммаБезНДС;

	//	СтрокаТЧ.СуммаВР = стрк.СуммаВР;

	//	СтрокаТЧ.СуммаЗабаланс = стрк.СуммаЗабаланс;

	//	СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;

	//	СтрокаТЧ.СуммаПР = стрк.СуммаПР;

	//	СтрокаТЧ.СуммаРегл = стрк.СуммаРегл;

	//	СтрокаТЧ.СуммаРеглЗабаланс = стрк.СуммаРеглЗабаланс;

	//	СтрокаТЧ.СуммаСНДС = стрк.СуммаСНДС;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Упаковка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Упаковка.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Упаковка = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиУпаковка(стрк.Упаковка);


	//	СтрокаТЧ.Цена = стрк.Цена;

	//	СтрокаТЧ.ЦенаЗабаланс = стрк.ЦенаЗабаланс;

	КонецЦикла;

	////------------------------------------------------------     ТЧ Серии



	//ОбъектДанных.Серии.Очистить();


	//Для счТовары = 0 По деф.ТЧСерии.Количество()-1 Цикл
	//	стрк = деф.ТЧСерии[счТовары];
	//	СтрокаТЧ = ОбъектДанных.Серии.Добавить();


	//	СтрокаТЧ.Количество = стрк.Количество;

	//	СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Назначение.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Назначение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Назначение.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Назначение = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Назначение = ксп_ИмпортСлужебный.НайтиНазначение(стрк.Назначение);

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
	//	ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Упаковка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Упаковка.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Упаковка = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиУпаковка(стрк.Упаковка);

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

	////------------------------------------------------------     ТЧ ДетализацияПартий



	//ОбъектДанных.ДетализацияПартий.Очистить();


	//Для счТовары = 0 По деф.ТЧДетализацияПартий.Количество()-1 Цикл
	//	стрк = деф.ТЧДетализацияПартий[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ДетализацияПартий.Добавить();


	//	_знч = "";
	//	ЕстьЗначение = стрк.ВидЦенности.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ВидЦенности = стрк.ВидЦенности.Значение;
	//	Иначе
	//		СтрокаТЧ.ВидЦенности = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ВидЦенности = ксп_ИмпортСлужебный.НайтиПеречисление_ВидЦенности(стрк.ВидЦенности);

	//	гуид="";
	//	ЕстьАтрибут = стрк.ДокументПоступления.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ДокументПоступления = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ДокументПоступления.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ДокументПоступления = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ДокументПоступления = ксп_ИмпортСлужебный.НайтиДокументПоступления(стрк.ДокументПоступления);

	//	СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Контрагент.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Контрагент = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Контрагент.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Контрагент = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагент(стрк.Контрагент);

	//	СтрокаТЧ.НДСРегл = стрк.НДСРегл;

	//	СтрокаТЧ.НДСУпр = стрк.НДСУпр;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Партнер.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Партнер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Партнер.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Партнер = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Партнер = ксп_ИмпортСлужебный.НайтиПартнер(стрк.Партнер);

	//	гуид="";
	//	ЕстьАтрибут = стрк.СтавкаНДС.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.СтавкаНДС = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.СтавкаНДС.Ref ) );
	//	Иначе
	//		СтрокаТЧ.СтавкаНДС = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.НайтиСтавкаНДС(стрк.СтавкаНДС);

	//	гуид="";
	//	ЕстьАтрибут = стрк.СтатьяРасходов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.СтатьяРасходов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.СтатьяРасходов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.СтатьяРасходов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.СтатьяРасходов = ксп_ИмпортСлужебный.НайтиСтатьяРасходов(стрк.СтатьяРасходов);

	//	СтрокаТЧ.СуммаРегл = стрк.СуммаРегл;

	//	СтрокаТЧ.СуммаУпр = стрк.СуммаУпр;

	//КонецЦикла;




	//------------------------------------------------------ ФИНАЛ


	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();


	// сохранить исходный json
	//РегистрыСведений.ксп_ИсходныеДанныеСообщений.ДобавитьЗапись(ОбъектДанных.Ссылка, jsonText);


	Возврат ОбъектДанных.Ссылка;
	
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

	
	
	Возврат ЗагрузитьОбъект(СтруктураОбъекта);
	
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


 мВнешняяСистема = "upp";
 
 