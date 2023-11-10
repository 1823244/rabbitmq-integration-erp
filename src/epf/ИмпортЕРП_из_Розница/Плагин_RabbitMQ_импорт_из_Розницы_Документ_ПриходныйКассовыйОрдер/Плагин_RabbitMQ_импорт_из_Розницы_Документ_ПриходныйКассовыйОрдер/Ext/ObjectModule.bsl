﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПриходныйКассовыйОрдер");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПриходныйКассовыйОрдер");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПриходныйКассовыйОрдер",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПриходныйКассовыйОрдер",
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
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.приходныйкассовыйордер") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	СуществующийОбъект = Документы.ПриходныйКассовыйОрдер.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		
	Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = Документы.ПриходныйКассовыйОрдер.СоздатьДокумент();
		СсылкаНового = Документы.ПриходныйКассовыйОрдер.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	Иначе 
		// а вот здесь вопрос - надо обновлять документ или нет?
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		КонецЕсли;
	КонецЕсли;
		
	ОбъектДанных.Номер = id.Number;
	ОбъектДанных.Дата = id.Date;
	
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	//гуид="";
	//ЕстьАтрибут = деф.Автор.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Автор = деф.Автор.Ref;
	//Иначе
		ОбъектДанных.Автор = Неопределено;
	//КонецЕсли;
	НомерСчета="";
	ЕстьАтрибут = деф.БанковскийСчет.свойство("НомерСчета",НомерСчета);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.БанковскийСчет = ксп_ИмпортСлужебный.НайтиБанковскийСчет(НомерСчета, деф.БанковскийСчет.БИК);
	Иначе
		ОбъектДанных.БанковскийСчет = Неопределено;
	КонецЕсли;
	ОбъектДанных.Валюта = Константы.ВалютаРегламентированногоУчета.Получить();
	ОбъектДанных.ВалютаКонвертации = Неопределено;
	ОбъектДанных.ГлавныйБухгалтер = Неопределено;
	ОбъектДанных.ГруппаФинансовогоУчета = Неопределено;
	
	// доделать
	гуид="";
	ЕстьАтрибут = деф.ДоговорКонтрагента.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.Договор = Справочники.ДоговорыКонтрагентов.ПолучитьСсылку(деф.ДоговорКонтрагента.Ref);
	Иначе
		ОбъектДанных.Договор = Неопределено;
	КонецЕсли;
	
	// основания в Рознице:
	
	//ВозвратТоваровОтПокупателя
	//ЗаказПоставщику	
	//ЗарплатаКВыплатеОрганизаций
	//ЗаявкаНаРасходованиеДенежныхСредств
	//ОтчетКомитентуОПродажах
	//ОтчетОРозничныхПродажах
	//ПоступлениеТоваров
	//ПриходныйКассовыйОрдер
	
	// основания в ЕРП
	
	//АвансовыйОтчет
	//ВозвратТоваровОтКлиента
	//ВыкупПринятыхНаХранениеТоваров
	//ЗаказПереработчику
	//ЗаказПереработчику2_5
	//ЗаказПоставщику
	//ЗаявкаНаРасходованиеДенежныхСредств
	//НачислениеДивидендов
	//ОтчетКомиссионера
	//ОтчетКомиссионераОСписании
	//ОтчетКомитенту
	//ОтчетКомитентуОСписании
	//ОтчетОператораСистемыПлатон
	//ОтчетОСписанииТоваровСХранения
	//ОтчетПереработчика
	//ОтчетПереработчика2_5
	//ОтчетПоКомиссииМеждуОрганизациями
	//ОтчетПоКомиссииМеждуОрганизациямиОСписании
	//ПередачаТоваровМеждуОрганизациями
	//ПоступлениеДенежныхДокументов
	//ПоступлениеУслугПоАренде
	//ПриобретениеТоваровУслуг
	//ПриобретениеУслугПрочихАктивов
	//ТаможеннаяДекларацияИмпорт	
	
	гуид="";
	ЕстьАтрибут = деф.ДокументОснование.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		
		type = деф.ДокументОснование.type;
		 
		ДокОсн = Неопределено;
		                                          
		ГУИД = Новый УникальныйИдентификатор(гуид);
		
		//это типы Розницы
		Если type = "Документ.ВозвратТоваровПоставщику" Тогда
			ДокОсн = Документы.ВозвратТоваровПоставщику.ПолучитьСсылку(ГУИД);
		ИначеЕсли type = "Документ.ВыемкаДенежныхСредствИзКассыККМ" Тогда
			ДокОсн = Документы.ВыемкаДенежныхСредствИзКассыККМ.ПолучитьСсылку(ГУИД);
		ИначеЕсли type = "Документ.ЗаказПокупателя" Тогда
			ДокОсн = Документы.ЗаказКлиента.ПолучитьСсылку(ГУИД);
		ИначеЕсли type = "Документ.ОтчетКомитентуОПродажах" Тогда
			ДокОсн = Документы.ОтчетКомитенту.ПолучитьСсылку(ГУИД);
		ИначеЕсли type = "Документ.РасходныйКассовыйОрдер" Тогда
			ДокОсн = Документы.РасходныйКассовыйОрдер.ПолучитьСсылку(ГУИД);
		ИначеЕсли type = "Документ.РеализацияТоваров" Тогда
			ДокОсн = Документы.РеализацияТоваровУслуг.ПолучитьСсылку(ГУИД);
		ИначеЕсли type = "Документ.ЧекККМ" Тогда
			ДокОсн = Документы.ЧекККМ.ПолучитьСсылку(ГУИД);
		ИначеЕсли type = "Документ.ЧекКоррекции" Тогда
			ДокОсн = Документы.ЧекККМКоррекции.ПолучитьСсылку(ГУИД);
		КонецЕсли;
		
		ОбъектДанных.ДокументОснование = ДокОсн;
	Иначе
		ОбъектДанных.ДокументОснование = Неопределено;
	КонецЕсли;

	
	ОбъектДанных.ИдентификаторДокумента = Строка(Новый УникальныйИдентификатор);
	ОбъектДанных.Исправление = Неопределено;
	ОбъектДанных.ИсправляемыйДокумент = Неопределено;
	
	ОбъектДанных.Касса = ксп_ИмпортСлужебный.НайтиКассу(деф.Касса, мВнешняяСистема);
	
	гуид="";
	ЕстьАтрибут = деф.КассаККМ.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.КассаККМ = Справочники.КассыККМ.ПолучитьСсылку(Новый УникальныйИдентификатор(деф.КассаККМ.Ref));
	Иначе
		ОбъектДанных.КассаККМ = Неопределено;
	КонецЕсли;
	
	ОбъектДанных.КассаОтправитель = Неопределено;

	ОбъектДанных.Кассир = Неопределено;
	ОбъектДанных.Комментарий = деф.Комментарий;

	гуид="";
	ЕстьАтрибут = деф.Контрагент.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.Контрагент = Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(деф.Контрагент.Ref));
	Иначе
		ОбъектДанных.Контрагент = Неопределено;
	КонецЕсли;

	ОбъектДанных.КратностьКурсаКонвертации = 1;
	ОбъектДанных.КурсКонвертации = 1;
	
	ОбъектДанных.НалогообложениеНДС = перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;

	// доделать
	//гуид="";
	//ЕстьАтрибут = деф.НаправлениеДеятельности.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.НаправлениеДеятельности = деф.НаправлениеДеятельности.Ref;
	//Иначе
	//	ОбъектДанных.НаправлениеДеятельности = Неопределено;
	//КонецЕсли;
		
	ОбъектДанных.ОбъектРасчетов = Неопределено;
	
	
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);

	ОбъектДанных.Основание = деф.Основание;

	ОбъектДанных.Партнер = ОбъектДанных.Контрагент.Партнер;
	
	ОбъектДанных.ПодотчетноеЛицо = Неопределено;
	ОбъектДанных.Подразделение = Неопределено;	
	ОбъектДанных.Приложение = деф.Приложение;
	
	ОбъектДанных.РаспоряжениеНаПеремещениеДенежныхСредств = Неопределено;

	// доделать
	ОбъектДанных.СтатьяДвиженияДенежныхСредств = Неопределено;
	
	ОбъектДанных.СторнируемыйДокумент = Неопределено;

	ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;
	ОбъектДанных.СуммаКонвертации = Неопределено;
	
	ОбъектДанных.ХозяйственнаяОперация = ксп_ИмпортСлужебный.КонвертацияПеречисления_ХозяйственныеОперации_Розница(деф.ХозяйственнаяОперация);

	
	ОбъектДанных.ПринятоОт = деф.ПринятоОт;
	ОбъектДанных.ДоверенностьВыданная = Неопределено;
	ОбъектДанных.ВТомЧислеНДС = деф.ВТомЧислеНДС;
	
//------------------------------------------------------     ТЧ РасшифровкаПлатежа



	ОбъектДанных.РасшифровкаПлатежа.Очистить();


	Для счТовары = 0 По деф.ТЧРасшифровкаПлатежа.Количество()-1 Цикл
		стрк = деф.ТЧРасшифровкаПлатежа[счТовары];
		СтрокаТЧ = ОбъектДанных.РасшифровкаПлатежа.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.АналитикаАктивовПассивов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.АналитикаАктивовПассивов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.АналитикаАктивовПассивов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.АналитикаАктивовПассивов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.АналитикаАктивовПассивов = ксп_ИмпортСлужебный.НайтиАналитикаАктивовПассивов(стрк.АналитикаАктивовПассивов);

	//	гуид="";
	//	ЕстьАтрибут = стрк.АналитикаДоходов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.АналитикаДоходов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.АналитикаДоходов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.АналитикаДоходов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.АналитикаДоходов = ксп_ИмпортСлужебный.НайтиАналитикаДоходов(стрк.АналитикаДоходов);

	//	гуид="";
	//	ЕстьАтрибут = стрк.АналитикаРасходов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.АналитикаРасходов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.АналитикаРасходов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.АналитикаРасходов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.АналитикаРасходов = ксп_ИмпортСлужебный.НайтиАналитикаРасходов(стрк.АналитикаРасходов);

		СтрокаТЧ.ВалютаВзаиморасчетов = Константы.ВалютаРегламентированногоУчета.Получить();

	//	гуид="";
	//	ЕстьАтрибут = стрк.ДоговорАренды.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ДоговорАренды = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ДоговорАренды.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ДоговорАренды = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ДоговорАренды = ксп_ИмпортСлужебный.НайтиДоговорАренды(стрк.ДоговорАренды);

	//	гуид="";
	//	ЕстьАтрибут = стрк.ДоговорЗаймаСотруднику.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ДоговорЗаймаСотруднику = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ДоговорЗаймаСотруднику.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ДоговорЗаймаСотруднику = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ДоговорЗаймаСотруднику = ксп_ИмпортСлужебный.НайтиДоговорЗаймаСотруднику(стрк.ДоговорЗаймаСотруднику);

	//	гуид="";
	//	ЕстьАтрибут = стрк.ДоговорКредитаДепозита.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ДоговорКредитаДепозита = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ДоговорКредитаДепозита.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ДоговорКредитаДепозита = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ДоговорКредитаДепозита = ксп_ИмпортСлужебный.НайтиДоговорКредитаДепозита(стрк.ДоговорКредитаДепозита);

		СтрокаТЧ.ИдентификаторСтроки = Строка(Новый УникальныйИдентификатор);

		СтрокаТЧ.КурсЗнаменательВзаиморасчетов = 1;
    	СтрокаТЧ.КурсЧислительВзаиморасчетов = 1;

	//	гуид="";
	//	ЕстьАтрибут = стрк.НаправлениеДеятельности.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.НаправлениеДеятельности = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НаправлениеДеятельности.Ref ) );
	//	Иначе
	//		СтрокаТЧ.НаправлениеДеятельности = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.НаправлениеДеятельности = ксп_ИмпортСлужебный.НайтиНаправлениеДеятельности(стрк.НаправлениеДеятельности);

	//	гуид="";
	//	ЕстьАтрибут = стрк.НастройкаСчетовУчета.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.НастройкаСчетовУчета = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НастройкаСчетовУчета.Ref ) );
	//	Иначе
	//		СтрокаТЧ.НастройкаСчетовУчета = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.НастройкаСчетовУчета = ксп_ИмпортСлужебный.НайтиНастройкаСчетовУчета(стрк.НастройкаСчетовУчета);

	//	гуид="";
	//	ЕстьАтрибут = стрк.ОбъектРасчетов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ОбъектРасчетов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ОбъектРасчетов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ОбъектРасчетов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ОбъектРасчетов = ксп_ИмпортСлужебный.НайтиОбъектРасчетов(стрк.ОбъектРасчетов);

		СтрокаТЧ.Организация = ОбъектДанных.Организация;

	//	гуид="";
	//	ЕстьАтрибут = стрк.ОснованиеПлатежа.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ОснованиеПлатежа = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ОснованиеПлатежа.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ОснованиеПлатежа = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ОснованиеПлатежа = ксп_ИмпортСлужебный.НайтиОснованиеПлатежа(стрк.ОснованиеПлатежа);

		СтрокаТЧ.Партнер = ОбъектДанных.Партнер;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Подразделение.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Подразделение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Подразделение.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Подразделение = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Подразделение = ксп_ИмпортСлужебный.НайтиПодразделение(стрк.Подразделение);

	//	гуид="";
	//	ЕстьАтрибут = стрк.РасчетныйДокументПоАренде.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.РасчетныйДокументПоАренде = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.РасчетныйДокументПоАренде.Ref ) );
	//	Иначе
	//		СтрокаТЧ.РасчетныйДокументПоАренде = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.РасчетныйДокументПоАренде = ксп_ИмпортСлужебный.НайтиРасчетныйДокументПоАренде(стрк.РасчетныйДокументПоАренде);

	//	гуид="";
	//	ЕстьАтрибут = стрк.СтавкаНДС.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.СтавкаНДС = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.СтавкаНДС.Ref ) );
	//	Иначе
	//		СтрокаТЧ.СтавкаНДС = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.НайтиСтавкаНДС(стрк.СтавкаНДС);

		СтрокаТЧ.СтатьяДвиженияДенежныхСредств = ксп_ИмпортСлужебный.НайтиСтатьюДДС(стрк.СтатьяДвиженияДенежныхСредств, мВнешняяСистема);

	//	гуид="";
	//	ЕстьАтрибут = стрк.СтатьяДоходов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.СтатьяДоходов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.СтатьяДоходов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.СтатьяДоходов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.СтатьяДоходов = ксп_ИмпортСлужебный.НайтиСтатьяДоходов(стрк.СтатьяДоходов);

		СтрокаТЧ.Сумма = стрк.Сумма;

		СтрокаТЧ.СуммаВзаиморасчетов = стрк.Сумма;

	//	СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;

	//	_знч = "";
	//	ЕстьЗначение = стрк.ТипПлатежаПоАренде.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ТипПлатежаПоАренде = стрк.ТипПлатежаПоАренде.Значение;
	//	Иначе
	//		СтрокаТЧ.ТипПлатежаПоАренде = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ТипПлатежаПоАренде = ксп_ИмпортСлужебный.НайтиПеречисление_ТипПлатежаПоАренде(стрк.ТипПлатежаПоАренде);

	//	_знч = "";
	//	ЕстьЗначение = стрк.ТипСуммыКредитаДепозита.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ТипСуммыКредитаДепозита = стрк.ТипСуммыКредитаДепозита.Значение;
	//	Иначе
	//		СтрокаТЧ.ТипСуммыКредитаДепозита = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ТипСуммыКредитаДепозита = ксп_ИмпортСлужебный.НайтиПеречисление_ТипСуммыКредитаДепозита(стрк.ТипСуммыКредитаДепозита);


	КонецЦикла;	


	//------------------------------------------------------ ФИНАЛ

		
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();

	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	Если деф.isPosted Тогда 
		ОбъектДанных.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
	КонецЕсли;
	
	// сохранить исходное сообщение
	
//	РегистрыСведений.ксп_ИсходныеДанныеСообщений.ДобавитьЗапись(ОбъектДанных.Ссылка, jsonText);
	
	
	// добавить документ в РС для проведения
	
	ксп_ИмпортСлужебный.ПроверитьКачествоДанных(ОбъектДанных, ЭтотОбъект);
	
	

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


 мВнешняяСистема = "retail";
 
 