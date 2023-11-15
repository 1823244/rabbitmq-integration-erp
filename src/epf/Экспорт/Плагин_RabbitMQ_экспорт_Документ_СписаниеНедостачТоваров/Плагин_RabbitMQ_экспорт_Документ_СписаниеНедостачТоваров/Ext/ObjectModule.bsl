﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Документ_СписаниеНедостачТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Документ_СписаниеНедостачТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Документ_СписаниеНедостачТоваров",
		"Форма_Плагин_RabbitMQ_экспорт_Документ_СписаниеНедостачТоваров",
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
	
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.СписаниеНедостачТоваров") Тогда
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
	definition.Вставить("АналитикаАктивовПассивов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.АналитикаАктивовПассивов));
	definition.Вставить("АналитикаРасходов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.АналитикаРасходов));
	definition.Вставить("ВидДеятельностиНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВидДеятельностиНДС));
	definition.Вставить("ВидЦены", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВидЦены));
	definition.Вставить("ВидыЗапасовУказаныВручную", Обк.ВидыЗапасовУказаныВручную);
	definition.Вставить("ГлавныйБухгалтер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ГлавныйБухгалтер));
	definition.Вставить("ИдентификаторДокумента", Обк.ИдентификаторДокумента);
	definition.Вставить("Исправление", Обк.Исправление);
	definition.Вставить("ИсправляемыйДокумент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ИсправляемыйДокумент));
	definition.Вставить("ИсточникИнформацииОЦенахДляПечати", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ИсточникИнформацииОЦенахДляПечати));
	definition.Вставить("Комментарий", Обк.Комментарий);
	definition.Вставить("НастройкаСчетовУчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.НастройкаСчетовУчета));
	definition.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Организация));
	definition.Вставить("Основание", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Основание));
	definition.Вставить("Ответственный", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Ответственный));
	definition.Вставить("ПересчетТоваров", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ПересчетТоваров));
	definition.Вставить("Подразделение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Подразделение));
	definition.Вставить("Руководитель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Руководитель));
	definition.Вставить("Склад", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Склад));
	definition.Вставить("СтатьяРасходов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СтатьяРасходов));
	definition.Вставить("СторнируемыйДокумент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СторнируемыйДокумент));
	definition.Вставить("УдалитьСубконто1", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьСубконто1));
	definition.Вставить("УдалитьСубконто2", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьСубконто2));
	definition.Вставить("УдалитьСубконто3", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьСубконто3));

	
	//Таблица: Товары   
	
	ТЧТовары = Новый Массив;
	
	Для сч = 0 По обк.товары.Количество()-1 Цикл
		
		стрк = обк.товары[сч];
		
		НовСтр = Новый Структура;   
	
		НовСтр.Вставить("АналитикаУчетаНоменклатуры", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаУчетаНоменклатуры));
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("Назначение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Назначение));
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("Серия", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Серия));
		НовСтр.Вставить("СтатусУказанияСерий", стрк.СтатусУказанияСерий);
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));

		ТЧТовары.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧТовары", ТЧТовары);

	
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

	
	//Таблица:	ВидыЗапасов    ВидыЗапасов

	ТЧВидыЗапасов = Новый Массив;
	
	Для сч = 0 По обк.ВидыЗапасов.Количество()-1 Цикл
		
		стрк = обк.ВидыЗапасов[сч];
		
		НовСтр = Новый Структура;   
			
		НовСтр.Вставить("АналитикаУчетаНоменклатуры", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаУчетаНоменклатуры));
		НовСтр.Вставить("ВидЗапасов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВидЗапасов));
		НовСтр.Вставить("ИдентификаторСтроки", стрк.ИдентификаторСтроки);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("КоличествоПоРНПТ", стрк.КоличествоПоРНПТ);
		НовСтр.Вставить("НомерГТД", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НомерГТД));

		ТЧВидыЗапасов.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧВидыЗапасов", ТЧВидыЗапасов);

	
		
	
	
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




