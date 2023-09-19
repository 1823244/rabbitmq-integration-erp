﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Справочник_Склады");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Справочник_Склады");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Справочник_Склады",
		"Форма_Плагин_RabbitMQ_экспорт_Справочник_Склады",
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


Функция ВыгрузитьОбъект(ЭлементСпр) Экспорт
	Если ТипЗнч(ЭлементСпр) = Тип("СправочникСсылка.Склады") Тогда
		Обк = ЭлементСпр.ПолучитьОбъект(); 
	Иначе 
		Обк = ЭлементСпр; 
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
	definition.Вставить("БизнесРегион", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.БизнесРегион));
	definition.Вставить("ВидПоклажедержателя", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВидПоклажедержателя));
	definition.Вставить("ВМагазинеПоддерживаетсяДоставкаСвоимиКурьерами", Обк.ВМагазинеПоддерживаетсяДоставкаСвоимиКурьерами);
	definition.Вставить("ВМагазинеПоддерживаетсяСборкаЗаказов", Обк.ВМагазинеПоддерживаетсяСборкаЗаказов);
	definition.Вставить("ВыборГруппы", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВыборГруппы));
	definition.Вставить("ГруппировкаТоваров", Обк.ГруппировкаТоваров);
	definition.Вставить("ДатаНачалаАдресногоХраненияОстатков", Обк.ДатаНачалаАдресногоХраненияОстатков);
	definition.Вставить("ДатаНачалаДоставкиСвоимиКурьерами", Обк.ДатаНачалаДоставкиСвоимиКурьерами);
	definition.Вставить("ДатаНачалаИспользованияСкладскихПомещений", Обк.ДатаНачалаИспользованияСкладскихПомещений);
	definition.Вставить("ДатаНачалаОрдернойСхемыПриОтгрузке", Обк.ДатаНачалаОрдернойСхемыПриОтгрузке);
	definition.Вставить("ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач", Обк.ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач);
	definition.Вставить("ДатаНачалаОрдернойСхемыПриПоступлении", Обк.ДатаНачалаОрдернойСхемыПриПоступлении);
	definition.Вставить("ДатаНачалаСборкиЗаказов", Обк.ДатаНачалаСборкиЗаказов);
	definition.Вставить("ИндивидуальныйВидЦены", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ИндивидуальныйВидЦены));
	definition.Вставить("ИспользованиеРабочихУчастков", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ИспользованиеРабочихУчастков));
	definition.Вставить("ИспользоватьАдресноеХранение", Обк.ИспользоватьАдресноеХранение);
	definition.Вставить("ИспользоватьАдресноеХранениеСправочно", Обк.ИспользоватьАдресноеХранениеСправочно);
	definition.Вставить("ИспользоватьОрдернуюСхемуПриОтгрузке", Обк.ИспользоватьОрдернуюСхемуПриОтгрузке);
	definition.Вставить("ИспользоватьОрдернуюСхемуПриОтраженииИзлишковНедостач", Обк.ИспользоватьОрдернуюСхемуПриОтраженииИзлишковНедостач);
	definition.Вставить("ИспользоватьОрдернуюСхемуПриПоступлении", Обк.ИспользоватьОрдернуюСхемуПриПоступлении);
	definition.Вставить("ИспользоватьСерииНоменклатуры", Обк.ИспользоватьСерииНоменклатуры);
	definition.Вставить("ИспользоватьСкладскиеПомещения", Обк.ИспользоватьСкладскиеПомещения);
	definition.Вставить("ИспользоватьСтатусыПересчетовТоваров", Обк.ИспользоватьСтатусыПересчетовТоваров);
	definition.Вставить("ИспользоватьСтатусыПриходныхОрдеров", Обк.ИспользоватьСтатусыПриходныхОрдеров);
	definition.Вставить("ИспользоватьСтатусыРасходныхОрдеров", Обк.ИспользоватьСтатусыРасходныхОрдеров);
	definition.Вставить("ИсточникИнформацииОЦенахДляПечати", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ИсточникИнформацииОЦенахДляПечати));
	definition.Вставить("Календарь", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Календарь));
	definition.Вставить("КонтролироватьОперативныеОстатки", Обк.КонтролироватьОперативныеОстатки);
	definition.Вставить("КонтролироватьСвободныеОстатки", Обк.КонтролироватьСвободныеОстатки);
	definition.Вставить("КурьерыИспользуютАвтономныеККТ", Обк.КурьерыИспользуютАвтономныеККТ);
	definition.Вставить("КурьерыИспользуютЭквайринговыеТерминалы", Обк.КурьерыИспользуютЭквайринговыеТерминалы);
	definition.Вставить("КурьерыМогутНазначатьСебеЗаказы", Обк.КурьерыМогутНазначатьСебеЗаказы);
	definition.Вставить("НастройкаАдресногоХранения", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.НастройкаАдресногоХранения));
	definition.Вставить("НачинатьОтгрузкуПослеФормированияЗаданияНаПеревозку", Обк.НачинатьОтгрузкуПослеФормированияЗаданияНаПеревозку);
	definition.Вставить("НормативныйСрокДоставкиЗаказов", Обк.НормативныйСрокДоставкиЗаказов);
	definition.Вставить("ОсобыеОтметки", Обк.ОсобыеОтметки);
	definition.Вставить("ОтветственноеХранениеДоВостребования", Обк.ОтветственноеХранениеДоВостребования);
	definition.Вставить("Подразделение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Подразделение));
	definition.Вставить("Поклажедержатель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Поклажедержатель));
	definition.Вставить("РозничныйВидЦены", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.РозничныйВидЦены));
	definition.Вставить("СборкаИДоставкаВыполняетсяОднимСотрудником", Обк.СборкаИДоставкаВыполняетсяОднимСотрудником);
	definition.Вставить("СборщикиМогутНазначатьСебеЗаказы", Обк.СборщикиМогутНазначатьСебеЗаказы);
	definition.Вставить("СкладОтветственногоХранения", Обк.СкладОтветственногоХранения);
	definition.Вставить("СпособСозданияРеализацииПриСборкеЗаказов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СпособСозданияРеализацииПриСборкеЗаказов));
	definition.Вставить("СпособФискализацииПриДоставке", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СпособФискализацииПриДоставке));
	definition.Вставить("СрокОтветственногоХранения", Обк.СрокОтветственногоХранения);
	definition.Вставить("ТекущаяДолжностьОтветственного", Обк.ТекущаяДолжностьОтветственного);
	definition.Вставить("ТекущийОтветственный", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ТекущийОтветственный));
	definition.Вставить("ТипСклада", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ТипСклада));
	definition.Вставить("УровеньОбслуживания", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УровеньОбслуживания));
	definition.Вставить("УсловияХраненияТоваров", Обк.УсловияХраненияТоваров);
	definition.Вставить("УчетныйВидЦены", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УчетныйВидЦены));
	definition.Вставить("УчитыватьСебестоимостьПоСериям", Обк.УчитыватьСебестоимостьПоСериям);
	definition.Вставить("ЦеховаяКладовая", Обк.ЦеховаяКладовая);

	//------------------------------------------------------     ТЧ КонтактнаяИнформация

	ТЧКонтактнаяИнформация = Новый Массив;

	Для сч = 0 По обк.КонтактнаяИнформация.Количество()-1 Цикл

		стрк = обк.КонтактнаяИнформация[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("АдресЭП", стрк.АдресЭП);
		НовСтр.Вставить("Вид", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Вид));
		НовСтр.Вставить("ВидДляСписка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВидДляСписка));
		НовСтр.Вставить("Город", стрк.Город);
		НовСтр.Вставить("ДоменноеИмяСервера", стрк.ДоменноеИмяСервера);
		НовСтр.Вставить("Значение", стрк.Значение);
		НовСтр.Вставить("ЗначенияПолей", стрк.ЗначенияПолей);
		НовСтр.Вставить("НомерТелефона", стрк.НомерТелефона);
		НовСтр.Вставить("НомерТелефонаБезКодов", стрк.НомерТелефонаБезКодов);
		НовСтр.Вставить("Представление", стрк.Представление);
		НовСтр.Вставить("Регион", стрк.Регион);
		НовСтр.Вставить("Страна", стрк.Страна);
		НовСтр.Вставить("Тип", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Тип));
		ТЧКонтактнаяИнформация.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧКонтактнаяИнформация", ТЧКонтактнаяИнформация);

	//------------------------------------------------------     ТЧ ДополнительныеРеквизиты

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




	//------------------------------------------------------ ФИНАЛ


	СтруктураОбъекта.Вставить("definition", definition);
	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
	json = ЗаписьJson.Закрыть();
	Возврат json;
КонецФункции

