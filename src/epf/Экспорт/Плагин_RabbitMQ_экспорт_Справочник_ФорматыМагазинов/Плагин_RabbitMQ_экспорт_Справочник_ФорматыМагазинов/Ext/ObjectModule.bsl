﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Справочник_ФорматыМагазинов");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Справочник_ФорматыМагазинов");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Справочник_ФорматыМагазинов",
		"Форма_Плагин_RabbitMQ_экспорт_Справочник_ФорматыМагазинов",
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


Функция ВыгрузитьОбъект(ДанныеСсылка) Экспорт
	Если ТипЗнч(ДанныеСсылка) = Тип("СправочникСсылка.ФорматыМагазинов") Тогда
		Обк = ДанныеСсылка.ПолучитьОбъект(); 
	Иначе 
		Обк = ДанныеСсылка; 
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
	
	// общие для элемента и группы
	

	// только для элемента
	
	//мд = ДанныеСсылка.метаданные();
	//Если мд.Иерархический = Истина И Обк.ЭтоГруппа Тогда
	Если НЕ Обк.ЭтоГруппа Тогда	
	
		definition.Вставить("ВМагазинеПоддерживаетсяДоставкаСвоимиКурьерами", Обк.ВМагазинеПоддерживаетсяДоставкаСвоимиКурьерами);
		definition.Вставить("ВМагазинеПоддерживаетсяСборкаЗаказов", Обк.ВМагазинеПоддерживаетсяСборкаЗаказов);
		definition.Вставить("ГруппировкаТоваров", Обк.ГруппировкаТоваров);
		definition.Вставить("ИндивидуальныйВидЦены", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ИндивидуальныйВидЦены));
		definition.Вставить("КоличествоАссортиментныхПозиций", Обк.КоличествоАссортиментныхПозиций);
		definition.Вставить("КурьерыИспользуютАвтономныеККТ", Обк.КурьерыИспользуютАвтономныеККТ);
		definition.Вставить("КурьерыИспользуютЭквайринговыеТерминалы", Обк.КурьерыИспользуютЭквайринговыеТерминалы);
		definition.Вставить("КурьерыМогутНазначатьСебеЗаказы", Обк.КурьерыМогутНазначатьСебеЗаказы);
		definition.Вставить("НормативныйСрокДоставкиЗаказов", Обк.НормативныйСрокДоставкиЗаказов);
		definition.Вставить("ПлощадьТорговогоЗалаМаксимальная", Обк.ПлощадьТорговогоЗалаМаксимальная);
		definition.Вставить("ПлощадьТорговогоЗалаМинимальная", Обк.ПлощадьТорговогоЗалаМинимальная);
		definition.Вставить("РозничныйВидЦены", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.РозничныйВидЦены));
		definition.Вставить("СборкаИДоставкаВыполняетсяОднимСотрудником", Обк.СборкаИДоставкаВыполняетсяОднимСотрудником);
		definition.Вставить("СборщикиМогутНазначатьСебеЗаказы", Обк.СборщикиМогутНазначатьСебеЗаказы);
		definition.Вставить("СпособСозданияРеализацииПриСборкеЗаказов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СпособСозданияРеализацииПриСборкеЗаказов));
		definition.Вставить("СпособФискализацииПриДоставке", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СпособФискализацииПриДоставке));
		definition.Вставить("ТехнологияРазмещенияТовараИОбслуживанияПокупателей", Обк.ТехнологияРазмещенияТовараИОбслуживанияПокупателей);
		definition.Вставить("ЦелевоеМестоположение", Обк.ЦелевоеМестоположение);
		definition.Вставить("ЦелевыеГруппыПокупателей", Обк.ЦелевыеГруппыПокупателей);

	КонецЕсли;

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

Функция ПолучитьОбъектыДляВыгрузки(Узел) Экспорт
	Возврат Неопределено;
КонецФункции

Функция getRoutingKey() Экспорт
	Возврат "static";
КонецФункции

