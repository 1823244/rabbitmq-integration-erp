﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Документ_ПриходныйКассовыйОрдер");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Документ_ПриходныйКассовыйОрдер");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Документ_ПриходныйКассовыйОрдер",
		"Форма_Плагин_RabbitMQ_экспорт_Документ_ПриходныйКассовыйОрдер",
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


// Описание_метода
//
// Параметры:
//	Номенклатура	- СправочникСсылка.Номенклатура / СправочникОбъект.Номенклатура - при чтении узла обмена сюда будут приходить именно объекты
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ВыгрузитьОбъект(Ссылка) Экспорт
	
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.ПриходныйКассовыйОрдер") Тогда
		Обк = Ссылка.ПолучитьОбъект(); 
	Иначе 
		Обк = Ссылка; 
	КонецЕсли;

	
	
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, Символы.Таб);
	ЗаписьJson = Новый ЗаписьJSON;
	ЗаписьJson.УстановитьСтроку(ПараметрыЗаписиJSON);
	
	// Это основной объект json-сообщения
	СтруктураОбъекта = Новый Структура;
	
	СтруктураОбъекта.Вставить("source", "ERP");
	СтруктураОбъекта.Вставить("type", Обк.метаданные().ПолноеИмя());
	СтруктураОбъекта.Вставить("datetime", XMLСтрока(ТекущаяДатаСеанса()));
	
	identification = ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Ссылка);
	СтруктураОбъекта.Вставить("identification", identification);
	
	//	DEFINITION
	
	definition = ксп_ЭкспортСлужебный.СоздатьУзелDefinition(Обк.Ссылка);
	
	//Таблица:	Шапка	
				
	definition.Вставить("Автор", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Автор));
	definition.Вставить("БанковскийСчет", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.БанковскийСчет));
	definition.Вставить("Валюта", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Валюта));
	definition.Вставить("ВалютаКонвертации", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВалютаКонвертации));
	definition.Вставить("ВТомЧислеНДС", Обк.ВТомЧислеНДС);
	definition.Вставить("ГлавныйБухгалтер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ГлавныйБухгалтер));
	definition.Вставить("ГруппаФинансовогоУчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ГруппаФинансовогоУчета));
	definition.Вставить("ДоверенностьВыданная", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДоверенностьВыданная));
	definition.Вставить("Договор", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Договор));
	definition.Вставить("ДокументОснование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДокументОснование));
	definition.Вставить("ИдентификаторДокумента", Обк.ИдентификаторДокумента);
	definition.Вставить("Исправление", Обк.Исправление);
	definition.Вставить("ИсправляемыйДокумент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ИсправляемыйДокумент));
	definition.Вставить("Касса", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Касса));
	definition.Вставить("КассаККМ", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КассаККМ));
	definition.Вставить("КассаОтправитель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КассаОтправитель));
	definition.Вставить("Кассир", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Кассир));
	definition.Вставить("Комментарий", Обк.Комментарий);
	definition.Вставить("Контрагент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Контрагент));
	definition.Вставить("КратностьКурсаКонвертации", Обк.КратностьКурсаКонвертации);
	definition.Вставить("КурсКонвертации", Обк.КурсКонвертации);
	definition.Вставить("НалогообложениеНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.НалогообложениеНДС));
	definition.Вставить("НаправлениеДеятельности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.НаправлениеДеятельности));
	definition.Вставить("ОбъектРасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ОбъектРасчетов));
	definition.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Организация));
	definition.Вставить("Основание", Обк.Основание);
	definition.Вставить("Партнер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Партнер));
	definition.Вставить("ПодотчетноеЛицо", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ПодотчетноеЛицо));
	definition.Вставить("Подразделение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Подразделение));
	definition.Вставить("Приложение", Обк.Приложение);
	definition.Вставить("ПринятоОт", Обк.ПринятоОт);
	definition.Вставить("РаспоряжениеНаПеремещениеДенежныхСредств", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.РаспоряжениеНаПеремещениеДенежныхСредств));
	definition.Вставить("СтатьяДвиженияДенежныхСредств", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СтатьяДвиженияДенежныхСредств));
	definition.Вставить("СторнируемыйДокумент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СторнируемыйДокумент));
	definition.Вставить("СуммаДокумента", Обк.СуммаДокумента);
	definition.Вставить("СуммаКонвертации", Обк.СуммаКонвертации);
	definition.Вставить("ХозяйственнаяОперация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ХозяйственнаяОперация));

	
	//Таблица: РасшифровкаПлатежа    РасшифровкаПлатежа
	
	ТЧРасшифровкаПлатежа = Новый Массив;
	
	Для сч = 0 По обк.РасшифровкаПлатежа.Количество()-1 Цикл
		
		стрк = обк.РасшифровкаПлатежа[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("АналитикаАктивовПассивов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаАктивовПассивов));
		НовСтр.Вставить("АналитикаДоходов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаДоходов));
		НовСтр.Вставить("АналитикаРасходов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаРасходов));
		НовСтр.Вставить("ВалютаВзаиморасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВалютаВзаиморасчетов));
		НовСтр.Вставить("ДоговорАренды", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДоговорАренды));
		НовСтр.Вставить("ДоговорЗаймаСотруднику", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДоговорЗаймаСотруднику));
		НовСтр.Вставить("ДоговорКредитаДепозита", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДоговорКредитаДепозита));
		НовСтр.Вставить("ИдентификаторСтроки", стрк.ИдентификаторСтроки);
		НовСтр.Вставить("КурсЗнаменательВзаиморасчетов", стрк.КурсЗнаменательВзаиморасчетов);
		НовСтр.Вставить("КурсЧислительВзаиморасчетов", стрк.КурсЧислительВзаиморасчетов);
		НовСтр.Вставить("НаправлениеДеятельности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НаправлениеДеятельности));
		НовСтр.Вставить("НастройкаСчетовУчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НастройкаСчетовУчета));
		НовСтр.Вставить("ОбъектРасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ОбъектРасчетов));
		НовСтр.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Организация));
		НовСтр.Вставить("ОснованиеПлатежа", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ОснованиеПлатежа));
		НовСтр.Вставить("Партнер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Партнер));
		НовСтр.Вставить("Подразделение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Подразделение));
		НовСтр.Вставить("РасчетныйДокументПоАренде", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.РасчетныйДокументПоАренде));
		НовСтр.Вставить("СтавкаНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтавкаНДС));
		НовСтр.Вставить("СтатьяДвиженияДенежныхСредств", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтатьяДвиженияДенежныхСредств));
		НовСтр.Вставить("СтатьяДоходов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтатьяДоходов));
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("СуммаВзаиморасчетов", стрк.СуммаВзаиморасчетов);
		НовСтр.Вставить("СуммаНДС", стрк.СуммаНДС);
		НовСтр.Вставить("ТипПлатежаПоАренде", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ТипПлатежаПоАренде));
		НовСтр.Вставить("ТипСуммыКредитаДепозита", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ТипСуммыКредитаДепозита));

		ТЧРасшифровкаПлатежа.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧРасшифровкаПлатежа", ТЧРасшифровкаПлатежа);

	
	//Таблица:	ДополнительныеРеквизиты   

	ТЧДополнительныеРеквизиты = Новый Массив;
	
	Для сч = 0 По обк.ДополнительныеРеквизиты.Количество()-1 Цикл
		
		стрк = обк.ДополнительныеРеквизиты[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("Значение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Значение));
		НовСтр.Вставить("Свойство", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Свойство));
		НовСтр.Вставить("ТекстоваяСтрока", стрк.ТекстоваяСтрока);

		ТЧДополнительныеРеквизиты.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧДополнительныеРеквизиты", ТЧДополнительныеРеквизиты);

		
	
	
	//------------------------------------------------------
	
	СтруктураОбъекта.Вставить("definition", definition);
	
	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
	json = ЗаписьJson.Закрыть();
	
	Возврат json;
	
	
	Возврат Неопределено;
	
КонецФункции

Функция ПолучитьОбъектыДляВыгрузки(Узел) Экспорт
	Возврат Неопределено;
КонецФункции

Функция getRoutingKey() Экспорт
	Возврат "doc";
КонецФункции




