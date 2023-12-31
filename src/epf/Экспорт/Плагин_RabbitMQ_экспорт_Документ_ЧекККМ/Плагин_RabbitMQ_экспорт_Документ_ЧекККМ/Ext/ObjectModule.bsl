﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Документ_ЧекККМ");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Документ_ЧекККМ");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Документ_ЧекККМ",
		"Форма_Плагин_RabbitMQ_экспорт_Документ_ЧекККМ",
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
	
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.ЧекККМ") Тогда
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
				
	definition.Вставить("Архивный", Обк.Архивный);
	definition.Вставить("Валюта", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Валюта));
	definition.Вставить("ВидЦены", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВидЦены));
	definition.Вставить("ГруппаФинансовогоУчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ГруппаФинансовогоУчета));
	definition.Вставить("ИдентификаторДокумента", Обк.ИдентификаторДокумента);
	definition.Вставить("ИспользоватьОплатуБонуснымиБаллами", Обк.ИспользоватьОплатуБонуснымиБаллами);
	definition.Вставить("КартаЛояльности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КартаЛояльности));
	definition.Вставить("КассаККМ", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КассаККМ));
	definition.Вставить("Кассир", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Кассир));
	definition.Вставить("КассоваяСмена", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КассоваяСмена));
	definition.Вставить("Комментарий", Обк.Комментарий);
	definition.Вставить("Контрагент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Контрагент));
	definition.Вставить("НалогообложениеНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.НалогообложениеНДС));
	definition.Вставить("НаправлениеДеятельности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.НаправлениеДеятельности));
	definition.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Организация));
	definition.Вставить("ОрганизацияЕГАИС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ОрганизацияЕГАИС));
	definition.Вставить("ОтложенДо", XMLСтрока(Обк.ОтложенДо));
	definition.Вставить("Партнер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Партнер));
	definition.Вставить("Подразделение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Подразделение));
	definition.Вставить("ПолученоНаличными", Обк.ПолученоНаличными);
	definition.Вставить("ПорядокРасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ПорядокРасчетов));
	definition.Вставить("СкидкиРассчитаны", Обк.СкидкиРассчитаны);
	definition.Вставить("Склад", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Склад));
	definition.Вставить("Статус", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Статус));
	definition.Вставить("СуммаДокумента", Обк.СуммаДокумента);
	definition.Вставить("ФормаОплаты", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ФормаОплаты));
	definition.Вставить("ЦенаВключаетНДС", Обк.ЦенаВключаетНДС);

	
	//Таблица: Товары    Товары
	
	ТЧТовары = Новый Массив;
	
	Для сч = 0 По обк.Товары.Количество()-1 Цикл
		
		стрк = обк.Товары[сч];
		
		НовСтр = Новый Структура;   
					
		НовСтр.Вставить("ИдентификаторСтроки", стрк.ИдентификаторСтроки);
		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("КоличествоУпаковок", стрк.КоличествоУпаковок);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("НоменклатураЕГАИС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НоменклатураЕГАИС));
		НовСтр.Вставить("НоменклатураНабора", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НоменклатураНабора));
		НовСтр.Вставить("Помещение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Помещение));
		НовСтр.Вставить("Продавец", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Продавец));
		НовСтр.Вставить("ПроцентАвтоматическойСкидки", стрк.ПроцентАвтоматическойСкидки);
		НовСтр.Вставить("ПроцентРучнойСкидки", стрк.ПроцентРучнойСкидки);
		НовСтр.Вставить("Серия", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Серия));
		НовСтр.Вставить("СтавкаНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтавкаНДС));
		НовСтр.Вставить("СтатусУказанияСерий", стрк.СтатусУказанияСерий);
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("СуммаАвтоматическойСкидки", стрк.СуммаАвтоматическойСкидки);
		НовСтр.Вставить("СуммаБонусныхБалловКСписанию", стрк.СуммаБонусныхБалловКСписанию);
		НовСтр.Вставить("СуммаБонусныхБалловКСписаниюВВалюте", стрк.СуммаБонусныхБалловКСписаниюВВалюте);
		НовСтр.Вставить("СуммаНачисленныхБонусныхБалловВВалюте", стрк.СуммаНачисленныхБонусныхБалловВВалюте);
		НовСтр.Вставить("СуммаНДС", стрк.СуммаНДС);
		НовСтр.Вставить("СуммаРучнойСкидки", стрк.СуммаРучнойСкидки);
		НовСтр.Вставить("УдалитьСтавкаНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.УдалитьСтавкаНДС));
		НовСтр.Вставить("Упаковка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Упаковка));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		НовСтр.Вставить("ХарактеристикаНабора", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ХарактеристикаНабора));
		НовСтр.Вставить("Цена", стрк.Цена);
		НовСтр.Вставить("Штрихкод", стрк.Штрихкод);

		ТЧТовары.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧТовары", ТЧТовары);

	
	//Таблица:	ОплатаПлатежнымиКартами  ОплатаПлатежнымиКартами 

	ТЧОплатаПлатежнымиКартами = Новый Массив;
	
	Для сч = 0 По обк.ОплатаПлатежнымиКартами.Количество()-1 Цикл
		
		стрк = обк.ОплатаПлатежнымиКартами[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("ВидОплаты", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВидОплаты));
		НовСтр.Вставить("ДоговорПодключения", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДоговорПодключения));
		НовСтр.Вставить("ИдентификаторКорзины", стрк.ИдентификаторКорзины);
		НовСтр.Вставить("ИдентификаторПлатежнойСистемы", стрк.ИдентификаторПлатежнойСистемы);
		НовСтр.Вставить("ИдентификаторСтроки", стрк.ИдентификаторСтроки);
		НовСтр.Вставить("КодАвторизации", стрк.КодАвторизации);
		НовСтр.Вставить("НомерПлатежнойКарты", стрк.НомерПлатежнойКарты);
		НовСтр.Вставить("НомерЧекаЭТ", стрк.НомерЧекаЭТ);
		НовСтр.Вставить("СсылочныйНомер", стрк.СсылочныйНомер);
		НовСтр.Вставить("СтатусОплатыСБП", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтатусОплатыСБП));
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("ТекстОшибки", стрк.ТекстОшибки);
		НовСтр.Вставить("ЭквайринговыйТерминал", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЭквайринговыйТерминал));

		ТЧОплатаПлатежнымиКартами.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧОплатаПлатежнымиКартами", ТЧОплатаПлатежнымиКартами);

		
	//Таблица:	СкидкиНаценки   СкидкиНаценки

	ТЧСкидкиНаценки = Новый Массив;
	
	Для сч = 0 По обк.СкидкиНаценки.Количество()-1 Цикл
		
		стрк = обк.СкидкиНаценки[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("НапомнитьПозже", стрк.НапомнитьПозже);
		НовСтр.Вставить("СкидкаНаценка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СкидкаНаценка));
		НовСтр.Вставить("Сумма", стрк.Сумма);

		ТЧСкидкиНаценки.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧСкидкиНаценки", ТЧСкидкиНаценки);

	//Таблица:	Серии   Серии

	ТЧСерии = Новый Массив;
	
	Для сч = 0 По обк.Серии.Количество()-1 Цикл
		
		стрк = обк.Серии[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("Помещение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Помещение));
		НовСтр.Вставить("Серия", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Серия));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));

		ТЧСерии.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧСерии", ТЧСерии);

	//Таблица:	ПодарочныеСертификаты   ПодарочныеСертификаты

	ТЧПодарочныеСертификаты = Новый Массив;
	
	Для сч = 0 По обк.ПодарочныеСертификаты.Количество()-1 Цикл
		
		стрк = обк.ПодарочныеСертификаты[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("ИдентификаторСтроки", стрк.ИдентификаторСтроки);
		НовСтр.Вставить("ОбъектРасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ОбъектРасчетов));
		НовСтр.Вставить("ПодарочныйСертификат", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ПодарочныйСертификат));
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("СуммаВВалютеСертификата", стрк.СуммаВВалютеСертификата);
		НовСтр.Вставить("СуммаВзаиморасчетов", стрк.СуммаВзаиморасчетов);

		ТЧПодарочныеСертификаты.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧПодарочныеСертификаты", ТЧПодарочныеСертификаты);
		
	//Таблица:	БонусныеБаллы   БонусныеБаллы

	ТЧБонусныеБаллы = Новый Массив;
	
	Для сч = 0 По обк.БонусныеБаллы.Количество()-1 Цикл
		
		стрк = обк.БонусныеБаллы[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("БонуснаяПрограммаЛояльности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.БонуснаяПрограммаЛояльности));
		НовСтр.Вставить("ДатаНачисления", стрк.ДатаНачисления);
		НовСтр.Вставить("ДатаСписания", стрк.ДатаСписания);
		НовСтр.Вставить("СуммаБонусныхБаллов", стрк.СуммаБонусныхБаллов);

		ТЧБонусныеБаллы.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧБонусныеБаллы", ТЧБонусныеБаллы);
	
	//Таблица:	АкцизныеМарки   АкцизныеМарки

	ТЧАкцизныеМарки = Новый Массив;
	
	Для сч = 0 По обк.АкцизныеМарки.Количество()-1 Цикл
		
		стрк = обк.АкцизныеМарки[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("АкцизнаяМарка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АкцизнаяМарка));
		НовСтр.Вставить("ИдентификаторСтроки", стрк.ИдентификаторСтроки);
		НовСтр.Вставить("КодАкцизнойМарки", стрк.КодАкцизнойМарки);
		НовСтр.Вставить("Справка2", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Справка2));
		НовСтр.Вставить("ЧастичноеВыбытиеВариантУчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЧастичноеВыбытиеВариантУчета));
		НовСтр.Вставить("ЧастичноеВыбытиеКоличество", стрк.ЧастичноеВыбытиеКоличество);
		НовСтр.Вставить("ЧастичноеВыбытиеНоменклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЧастичноеВыбытиеНоменклатура));
		НовСтр.Вставить("ЧастичноеВыбытиеХарактеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЧастичноеВыбытиеХарактеристика));
		НовСтр.Вставить("ШтрихкодУпаковки", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ШтрихкодУпаковки));

		ТЧАкцизныеМарки.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧАкцизныеМарки", ТЧАкцизныеМарки);
	
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




