﻿// Данная обработка обеспечивает транспорт

Перем Плагины; // структура?
Перем КэшОбъектовПлагинов; //ТЗ

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Экспорт из ЕРП");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Экспорт из ЕРП");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180"); // ОБЯЗАТЕЛЬНО!!! //(https://forum.infostart.ru/forum9/topic179193/)
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Открыть форму : Экспорт из ЕРП","ЭкпортИзЕРПФорма",ТипКоманды, Ложь) ;
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Экспорт из ЕРП","ЭкспортИзЕРП",ТипКоманды, Ложь) ;
	
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

// Интерфейс для запуска логики обработки.
Процедура ВыполнитьКоманду(ИмяКоманды, ПараметрыВыполнения) Экспорт
	
	Если ИмяКоманды = "ЭкспортИзЕРП" Тогда
		ВыполнитьЭкспорт(ПараметрыВыполнения);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти 	




// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ВыполнитьЭкспорт(ПараметрыВыполнения = Неопределено) Экспорт

	ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Информация,,,
		"Запуск" );
	
	ВремяНач = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	Если ПараметрыСеанса.РаботаСВнешнимиРесурсамиЗаблокирована Тогда
		
		ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,,
			"Экспорт не выполнен, т.к. ПараметрыСеанса.РаботаСВнешнимиРесурсамиЗаблокирована = Истина" );
		
		Возврат;
		
	КонецЕсли;
	
	ИмяТочкиОбмена = Константы.ксп_ТочкаОбмена.Получить().Наименование;
	
	Если Не ЗначениеЗаполнено(ИмяТочкиОбмена) Тогда
		ВызватьИсключение "Константа ксп_ТочкаОбмена не установлена!";
	КонецЕсли;

	Узел = Константы.ксп_УзелОбменаРозница.Получить();
	Если Не ЗначениеЗаполнено(Узел) Тогда
		ВызватьИсключение "Константа ксп_УзелОбменаРозница не установлена!";
	КонецЕсли;
	


	Плагины(); //заполняем кэш плагинов
	
	Клиент = PinkRabbit.ПолучитьКлиента();
	
	
	Выборка = ПланыОбмена.ВыбратьИзменения(Узел,1);
	Пока Выборка.Следующий() Цикл

		Объект = Выборка.Получить();
		
		ПредставлениеОбъекта = Строка(Объект);
		
		ТипОбъекта = Объект.Метаданные().ПолноеИмя();
			
		// найти плагин
		Плагин = Неопределено;
		Успешно = НайтиПлагин(ТипОбъекта, Плагин);
		Если НЕ Успешно Тогда
			
			// а если объектов будет миллион?
			//ЗаписьЖурналаРегистрации("ЕНС", УровеньЖурналаРегистрации.Предупреждение, ,, 
			//	"Для типа данных <"+Строка(ТипОбъекта)+"> нет доп. обработки формирования json для экспорта в RabbitMQ!");
			
			Продолжить;
		КонецЕсли;
			
		Попытка
			json = Плагин.ВыгрузитьОбъект(Объект);
		Исключение
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,,
				"Ошибка формирования json для объекта <"+ПредставлениеОбъекта+">. Подробности: "+т);
			Продолжить;
		КонецПопытки;
		
		
		RoutingKey = "";
		Если Документы.ТипВсеСсылки().СодержитТип(ТипЗнч(Объект.Ссылка)) Тогда
			RoutingKey = "doc";
			
		ИначеЕсли Справочники.ТипВсеСсылки().СодержитТип(ТипЗнч(Объект.Ссылка)) 
			ИЛИ Перечисления.ТипВсеСсылки().СодержитТип(ТипЗнч(Объект.Ссылка)) Тогда
			
			RoutingKey = "static";
		КонецЕсли;
		
		УспешноОпубликован = Ложь;
		Попытка
			Клиент.BasicPublish(ИмяТочкиОбмена, RoutingKey, json, 0, Ложь);
			УспешноОпубликован = Истина;
		Исключение
	        т = Клиент.GetLastError();
			тт = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,,	
				"Ошибка публикации объекта <"+ПредставлениеОбъекта+">. Ошибка PinkRabbitMQ: "+т+символы.ПС+
				"Ошибка 1С: "+тт);
			Продолжить;
		КонецПопытки;

		Если УспешноОпубликован = Истина Тогда
			Попытка
				ПланыОбмена.УдалитьРегистрациюИзменений(Узел, Объект);			
			Исключение
				т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
				ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,,
					"Не удалось удалить регистрацию объекта <"+Строка(ПредставлениеОбъекта)+">. Подробности: "+т);
				Продолжить;
			КонецПопытки;
		КонецЕсли;
		
	КонецЦикла;
	
	Клиент = Неопределено;
	
	ВремяКон = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Длительность = ВремяКон - ВремяНач;
	ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Информация,,,
		"Завершение. Длительность = " + строка(Длительность) + " мс" );
	
	
	
	
КонецПроцедуры






#Область Плагины

// Собирает плагины из спр Доп. обработки в ТЗ
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиПлагиныВДопОбработках()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	спр.Ссылка КАК Ссылка,
		|	спр.ИмяОбъекта КАК ИмяОбъекта
		|ИЗ
		|	Справочник.ДополнительныеОтчетыИОбработки КАК спр
		|ГДЕ
		|	спр.ИмяОбъекта ПОДОБНО ""Плагин_RabbitMQ_экспорт%""";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса.Выгрузить();
	
КонецФункции


// Подключает плагины - обработки, формирующие json-тексты из объектов базы данных
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура Плагины() Экспорт
	
	Если ТипЗнч(Плагины) <> Тип("Структура") Тогда
		Плагины = Новый Структура;
	Иначе 
		Плагины.Очистить();
	КонецЕсли;
	
	
	// универсальный код подключения плагина
	
	ТЗ = НайтиПлагиныВДопОбработках();
	Для каждого стрк Из ТЗ Цикл

		//ключ - тип объекта МД, значение - ссылка в Доп обработках
		Ключ = Сред(стрк.ИмяОбъекта, 25);
		Плагины.Вставить(Ключ, стрк.Ссылка);
		
	КонецЦикла;	
	
	
	// теперь создание объектов обработок
	
	КэшОбъектовПлагинов = Новый ТаблицаЗначений;
	КэшОбъектовПлагинов.Колонки.Добавить("ТипОбъекта");//строка в формате "Справочник_Номенклатура"
	КэшОбъектовПлагинов.Колонки.Добавить("ПлагинСсылка");//спр ссылка Доп. обработки
	КэшОбъектовПлагинов.Колонки.Добавить("ОбъектПлагина");//объект обработки
	//индексы
	КэшОбъектовПлагинов.Индексы.Добавить("ТипОбъекта");
	КэшОбъектовПлагинов.Индексы.Добавить("ПлагинСсылка");
	
	Для каждого стрк Из Плагины Цикл
		НовСтр = КэшОбъектовПлагинов.Добавить();
		НовСтр.ТипОбъекта 		= стрк.Ключ;
		НовСтр.ПлагинСсылка 	= стрк.Значение;
		НовСтр.ОбъектПлагина 	= ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(стрк.Значение);
	КонецЦикла;
	
		
КонецПроцедуры


// Ищет плагин для указанного типа объекта в кэше - ТЗ "КэшОбъектовПлагинов"
// Параметры:
//	ТипОбъекта 	- строка - это не ТипЗнч()! а вот так: Объект.Метаданные().ПолноеИмя();
//	Плагин - объект обработки - возвращаемый параметр
//
// Возвращаемое значение:
//	Тип: Булево. Истина в случае успеха
//
Функция НайтиПлагин(Знач ТипОбъекта, Плагин = Неопределено)
	
	ТипОбъекта = СтрЗаменить(ТипОбъекта, ".", "_");
	
	Рез = КэшОбъектовПлагинов.Найти(ТипОбъекта, "ТипОбъекта");
	Если НЕ Рез = Неопределено Тогда
		Плагин = Рез.ОбъектПлагина;
		Возврат Истина;
	КонецЕсли;
	Возврат Ложь;
	
КонецФункции


#КонецОбласти 	


#Область Тесты


// какое-то легаси, для примера
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ТЕСТ() Экспорт


	ИмяТочкиОбмена = "data";
	ИмяОчереди = "testroute";
	ОтправляемоеСообщение = "Test message";
	ОтветноеСообщение = ""; 
	ТегСообщения = 0;

	
	Если НЕ ПодключитьВнешнююКомпоненту("ОбщийМакет.PinkRabbitMQ64", "BITERP", ТипВнешнейКомпоненты.Native) Тогда
		ВызватьИсключение "Ошибка подключения PinkRabbitMQ.dll";
	КонецЕсли;
	
	Клиент  = Новый("AddIn.BITERP.PinkRabbitMQ3");

    Коннект = Константы.ксп_АктивныйСерверRabbitMQ.Получить();
	
	server = Коннект.server;                                                              
	port = Коннект.port;
	username = Коннект.username;
	password = Коннект.password;
	vhost = Коннект.vhost;
	
	Попытка
		Клиент.Connect(server, port, username, password, vhost);
		Клиент.DeclareExchange(ИмяТочкиОбмена, "topic", Ложь, Истина, Ложь);
		Клиент.DeclareQueue(ИмяОчереди, Ложь, Ложь, Ложь, Ложь);
		Клиент.BindQueue(ИмяОчереди, ИмяТочкиОбмена, "#" + ИмяОчереди + "#");
	Исключение
        т = Клиент.GetLastError();
		Клиент = Неопределено;
		ВызватьИсключение т;
	КонецПопытки;
	
	Попытка
	  	Клиент.BasicPublish(ИмяТочкиОбмена, "#" + ИмяОчереди + "#", ОтправляемоеСообщение, 0, Ложь);
	Исключение
        т = Клиент.GetLastError();
		Клиент = Неопределено;
		ВызватьИсключение т;
	КонецПопытки;
	
	Попытка
	    Потребитель = Клиент.BasicConsume(ИмяОчереди, "", Истина, Ложь, 0);
	    Пока Клиент.BasicConsumeMessage("", ОтветноеСообщение, ТегСообщения, 5000) Цикл
	        Клиент.BasicAck(ТегСообщения);
	        //Сообщить("Успешно! Из очереди прочитано сообщение " + ОтветноеСообщение);
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = НСтр("ru = 'Успешно! Из очереди прочитано message: "+ОтветноеСообщение+"'");
			Сообщение.Поле = "";
			//Сообщение.УстановитьДанные();
			Сообщение.Сообщить();
	        ОтветноеСообщение = ""; // Обнуляем, чтобы избежать утечку памяти
	        ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти
	    КонецЦикла;
	    Клиент.BasicCancel(Потребитель);
		Клиент = Неопределено;
	Исключение
	    Сообщить(Клиент.GetLastError());
		Клиент = Неопределено;
	КонецПопытки;	
КонецПроцедуры


// для теста
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СформироватьJsonСправочникНоменклатура(НоменклатураСсылка) Экспорт

	Плагины();
	
	ТипОбъекта = НоменклатураСсылка.Метаданные().ПолноеИмя();
	
	// найти плагин
	Плагин = Неопределено;
	Успешно = НайтиПлагин(ТипОбъекта, Плагин);
	Если НЕ Успешно Тогда
		ВызватьИсключение "Для типа данных <"+ТипОбъекта+"> нет доп. обработки формирования json для экспорта в RabbitMQ!";
	КонецЕсли;
	
	//ОбъектПлагина = ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(Плагин);
	json = Плагин.ВыгрузитьОбъект(НоменклатураСсылка);
	
	Возврат json;
	
КонецФункции

#КонецОбласти 	



/////////////////////////////////////////////////////////////////////////////////////////////





