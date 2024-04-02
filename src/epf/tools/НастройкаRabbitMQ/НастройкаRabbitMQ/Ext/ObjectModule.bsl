// Данная обработка обеспечивает транспорт

Перем ИмяСобытияЖР;
Перем мЛоггер;  
Перем мИДСессии;


Перем ТЗ_СВЯЗЫВАНИЕ;


#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","НастройкаRabbitMQ");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","НастройкаRabbitMQ");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180"); // ОБЯЗАТЕЛЬНО!!! //(https://forum.infostart.ru/forum9/topic179193/)
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Открыть форму : НастройкаRabbitMQ","ЭНастройкаRabbitMQ",ТипКоманды, Ложь) ;
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Выполнить настройку","ВыполнитьНастройкаRabbitMQ",ТипКоманды, Ложь) ;

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
	
	Если ИмяКоманды = "ВыполнитьНастройкаRabbitMQ" Тогда
		ВыполнитьНастройкаRabbitMQ();          
	Иначе 
		ВызватьИсключение "Неизвестная команда!";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти 	


#Область Версия1


// Выгружает объекты из плана обмена
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ВыполнитьНастройкаRabbitMQ(ИдВызова = Неопределено, ПараметрыВыполнения = Неопределено) Экспорт

	ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,
		"Запуск" );
	мИдВызова = ИдВызова;
	мИДСессии = Строка(Новый УникальныйИдентификатор);
	мЛоггер = мис_ЛоггерСервер.getLogger(ИдВызова, "Экспорт в RabbitMQ");
	мЛоггер.инфо("Запуск. ИдСессии: "+мИДСессии);

	
		ВремяНач = ТекущаяУниверсальнаяДатаВМиллисекундах();
		
		Клиент = Вычислить("PinkRabbit.ПолучитьКлиента()");
		
		//		EXCHANGES
		
		ТЗ_ТочкиОбмена = ТЗ_ТочкиОбмена();
		Для каждого стрк Из ТЗ_ТочкиОбмена Цикл
			сообщить("Создаем exchange: "+строка(стрк.name));
			Попытка
				Клиент.DeclareExchange (стрк.name, 
										стрк.type, 
										стрк.onlyCheckIfExists, 
										стрк.durable, 
										стрк.autodelete, 
										стрк.arguments);
			Исключение
			    т = ОписаниеОшибки();
				сообщить(т);    
				т = Клиент.GetLastError();
				Если ЗначениеЗаполнено(т) Тогда
					сообщить(т);
				КонецЕсли;
				
			КонецПопытки;
		КонецЦикла;
		
		
		ТЗ_СВЯЗЫВАНИЕ = ТЗ_Связывание();
		
		
		//		QUEUES
		
				
		ТЗ_Очереди = ТЗ_Очереди();
		Для каждого стрк Из ТЗ_Очереди Цикл
			сообщить("Создаем queue: "+строка(стрк.name));
			
			Попытка
				Клиент.DeleteQueue(стрк.name, ложь, ложь);
			Исключение
			    сообщить("Не удалось удалить очередь: "+строка(стрк.name));
			КонецПопытки;
			
			Попытка
				Клиент.DeclareQueue  (стрк.name,
										стрк.onlyCheckIfExists, 
										стрк.save, 
										стрк.exclusive, 
										стрк.autodelete, 
										стрк.maxPriority,
										стрк.arguments);
			Исключение
			    т = ОписаниеОшибки();
				сообщить(т);
				т = Клиент.GetLastError();
				Если ЗначениеЗаполнено(т) Тогда
					сообщить(т);
				КонецЕсли;
				
			КонецПопытки;
		КонецЦикла;    
		
		
		//		BINDING
		
		
		Для каждого стрк Из ТЗ_СВЯЗЫВАНИЕ Цикл
			сообщить("Bind queue: "+строка(стрк.queue));
			Попытка
				Клиент.BindQueue  (стрк.queue,              //queue - Строка - Имя очереди
										стрк.exchange,      //exchange - Строка - Имя точки обмена
										стрк.routingKey,    //routingKey - Строка - Rлюч маршрутизации.
										стрк.arguments);    //arguments - Строка - [НЕОБЯЗАТЕЛЬНЫЙ] 
															//произвольные свойства в формате Json-объект. 
															//Пример: {"x-match": "all"}.
			Исключение
			    т = ОписаниеОшибки();
				сообщить(т);
				т = Клиент.GetLastError();
				Если ЗначениеЗаполнено(т) Тогда
					сообщить(т);
				КонецЕсли;
			КонецПопытки;
		КонецЦикла;

		
		
КонецПроцедуры



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: ТЗ
//
Функция ТЗ_ТочкиОбмена()
		
	ТЗ = Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("name");     // - Строка - Имя exchange
	ТЗ.Колонки.Добавить("type");     // - Строка - Тип точки обмена. Поддерживаются "direct", "fanout", "topic"
	ТЗ.Колонки.Добавить("onlyCheckIfExists");         // - Булево - Не создавать новую, выбросить исключение, если такой точки нет.
	ТЗ.Колонки.Добавить("durable");   //- Булево - Сохранять сообщения на диске на случай рестарта RMQ (не рекомендуется)
	ТЗ.Колонки.Добавить("autodelete");//- Булево - Удалить после того, как от точки будут отвязаны все очереди.
	ТЗ.Колонки.Добавить("arguments"); //- Строка - [НЕОБЯЗАТЕЛЬНЫЙ] произвольные свойства в формате Json-объект. Пример: {"x-message-ttl": 60000}.
	
	ЗапланироватьТочкуОбмена(ТЗ, "erp", "direct", false, true, false, ""); // исходящие сообщения
	
	ЗапланироватьТочкуОбмена(ТЗ, "erp-from-ut.retry", "direct", false, true, false, "");
	ЗапланироватьТочкуОбмена(ТЗ, "erp-from-ut.return", "direct", false, true, false, "");

	ЗапланироватьТочкуОбмена(ТЗ, "erp-from-retail.retry", "direct", false, true, false, "");
	ЗапланироватьТочкуОбмена(ТЗ, "erp-from-retail.return", "direct", false, true, false, "");

	ЗапланироватьТочкуОбмена(ТЗ, "erp-from-bazap.retry", "direct", false, true, false, "");
	ЗапланироватьТочкуОбмена(ТЗ, "erp-from-bazap.return", "direct", false, true, false, "");

	ЗапланироватьТочкуОбмена(ТЗ, "erp-from-upp.retry", "direct", false, true, false, "");
	ЗапланироватьТочкуОбмена(ТЗ, "erp-from-upp.return", "direct", false, true, false, "");

	
	ЗапланироватьТочкуОбмена(ТЗ, "ut", "direct", false, true, false, "");
	
	ЗапланироватьТочкуОбмена(ТЗ, "ut-from-erp.retry", "direct", false, true, false, "");
	ЗапланироватьТочкуОбмена(ТЗ, "ut-from-erp.return", "direct", false, true, false, "");
	

	ЗапланироватьТочкуОбмена(ТЗ, "retail", "direct", false, true, false, "");
	
	ЗапланироватьТочкуОбмена(ТЗ, "retail-from-erp.retry", "direct", false, true, false, "");
	ЗапланироватьТочкуОбмена(ТЗ, "retail-from-erp.return", "direct", false, true, false, "");
	

	ЗапланироватьТочкуОбмена(ТЗ, "bazap", "direct", false, true, false, "");
	
	ЗапланироватьТочкуОбмена(ТЗ, "bazap-from-erp.retry", "direct", false, true, false, "");
	ЗапланироватьТочкуОбмена(ТЗ, "bazap-from-erp.return", "direct", false, true, false, "");

	
	ЗапланироватьТочкуОбмена(ТЗ, "upp", "direct", false, true, false, "");
	
	ЗапланироватьТочкуОбмена(ТЗ, "upp-from-erp.retry", "direct", false, true, false, "");
	ЗапланироватьТочкуОбмена(ТЗ, "upp-from-erp.return", "direct", false, true, false, "");
	
	Возврат ТЗ;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ЗапланироватьТочкуОбмена(ТЗ, name, type, onlyCheckIfExists, durable, autodelete, arguments)
	
	НовСтр = ТЗ.Добавить();
	НовСтр.name = name;
	НовСтр.type = type;
	НовСтр.onlyCheckIfExists = onlyCheckIfExists;
	НовСтр.durable = durable;
	НовСтр.autodelete = autodelete;
	НовСтр.arguments = arguments;
	
КонецПроцедуры


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: ТЗ
//
Функция ТЗ_Очереди()

	ТЗ = Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("name");     // - Строка - Имя очереди
	ТЗ.Колонки.Добавить("onlyCheckIfExists");         // - Булево - Не создавать очередь с таким именем, использовать существующую
	ТЗ.Колонки.Добавить("save");         //- Булево - Кешировать сообщения на диске, на случай падения RMQ.
	ТЗ.Колонки.Добавить("exclusive");    //- Булево - Только текущее соединение может иметь доступ к этой очереди.
	ТЗ.Колонки.Добавить("autodelete");   //- Булево - Удалить очередь если к ней был подключен, а затем отключен читающий клиент.
	ТЗ.Колонки.Добавить("maxPriority");  //- Число - [НЕОБЯЗАТЕЛЬНЫЙ] устанавливает максимальное значение приоритета, которое может быть 
										//затем установлено для отправляемых сообщений через метод setPriority.
										//Если 0 - то приоритет не используется. По-умолчанию 0.
	ТЗ.Колонки.Добавить("arguments");   //- Строка - [НЕОБЯЗАТЕЛЬНЫЙ] произвольные свойства в формате Json-объект. 
										//Пример: {"x-message-ttl": 60000}. 
										//Документация: https://www.rabbitmq.com/queues.html#optional-arguments
	
										
	//arguments = "{""x-dead-letter-exchange"": ""to-erp-from-retail-doc-retry""}";
	//arguments = "{""x-message-ttl"": 300000}";
	
#Область aaaaaaa
#КонецОбласти
	
#Область           to_ERP_from_RETAIL
	// to ERP from RETAIL - DOC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-erp-from-retail-doc";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-retail.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "retail";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "erp-from-retail.return";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-erp-from-retail-doc-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-retail.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp-from-retail.retry";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// to ERP from RETAIL - STATIC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-erp-from-retail-static";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-retail.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "retail";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "erp-from-retail.return";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-erp-from-retail-static-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-retail.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp-from-retail.retry";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
#КонецОбласти
	
#Область           to_ERP_from_UT
	// to ERP from UT - DOC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-erp-from-ut-doc";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-ut.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "ut";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "erp-from-ut.return";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-erp-from-ut-doc-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-ut.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp-from-ut.retry";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// to ERP from RETAIL - STATIC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-erp-from-ut-static";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-ut.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "ut";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "erp-from-ut.return";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-erp-from-ut-static-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-ut.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp-from-ut.retry";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
#КонецОбласти
	
#Область           to_ERP_from_UPP
	// to ERP from UPP - DOC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-erp-from-upp-doc";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-upp.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "upp";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "erp-from-upp.return";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-erp-from-upp-doc-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-upp.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp-from-upp.retry";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// to ERP from RETAIL - STATIC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-erp-from-upp-static";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-upp.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "upp";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "erp-from-upp.return";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-erp-from-upp-static-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-upp.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp-from-upp.retry";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
#КонецОбласти
	
#Область           to_ERP_from_BAZAP
	// to ERP from BAZAP - DOC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-erp-from-bazap-doc";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-bazap.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "bazap";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "erp-from-bazap.return";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-erp-from-bazap-doc-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-bazap.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp-from-bazap.retry";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// to ERP from RETAIL - STATIC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-erp-from-bazap-static";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-bazap.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "bazap";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "erp-from-bazap.return";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-erp-from-bazap-static-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"erp-from-bazap.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp-from-bazap.retry";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
#КонецОбласти
	
	
	
#Область           to_BAZAP_from_ERP
	// - DOC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-bazap-from-erp-doc";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"bazap-from-erp.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "bazap-from-erp.return";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-bazap-from-erp-doc-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"bazap-from-erp.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "bazap-from-erp.retry";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	//  - STATIC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-bazap-from-erp-static";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"bazap-from-erp.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "bazap-from-erp.return";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-bazap-from-erp-static-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"bazap-from-erp.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "bazap-from-erp.retry";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
#КонецОбласти
	
#Область           to_UT_from_ERP
	// - DOC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-ut-from-erp-doc";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"ut-from-erp.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "ut-from-erp.return";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-ut-from-erp-doc-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"ut-from-erp.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "ut-from-erp.retry";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	//  - STATIC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-ut-from-erp-static";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"ut-from-erp.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "ut-from-erp.return";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-ut-from-erp-static-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"ut-from-erp.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "ut-from-erp.retry";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
#КонецОбласти
	
#Область           to_RETAIL_from_ERP
	// - DOC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-retail-from-erp-doc";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"retail-from-erp.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "retail-from-erp.return";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-retail-from-erp-doc-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"retail-from-erp.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"doc");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "retail-from-erp.retry";
	routingKey = "doc";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	//  - STATIC
	
	// прямая очередь, подключается к точке обмена Источника и к точке обмена типа Return
	queue = "to-retail-from-erp-static";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"retail-from-erp.retry");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "erp";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	exchange = "retail-from-erp.return";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
	// retry-очередь. Подключается к точке обмена типа Retry
	queue = "to-retail-from-erp-static-retry";
	СтруктураАргументов = Новый Соответствие;
	СтруктураАргументов.Вставить("x-dead-letter-exchange", 		"retail-from-erp.return");
	СтруктураАргументов.Вставить("x-dead-letter-routing-key", 	"static");
	СтруктураАргументов.Вставить("x-message-ttl", 	300000);
	arguments = СформироватьАргументы(СтруктураАргументов);
	ЗапланироватьОчередь(ТЗ, queue, false, true, false, false, 0, arguments);										
	
	exchange = "retail-from-erp.retry";
	routingKey = "static";
	ЗапланироватьСвязывание(ТЗ_Связывание, queue, exchange, routingKey, "");
	
#КонецОбласти
	
	
	
	Возврат ТЗ;
	
КонецФункции

Процедура ЗапланироватьОчередь(ТЗ, name, onlyCheckIfExists, save, exclusive, autodelete, maxPriority, arguments)
	
	НовСтр = ТЗ.Добавить();
	НовСтр.name = name;
	НовСтр.onlyCheckIfExists = onlyCheckIfExists;
	НовСтр.save = save;
	НовСтр.exclusive = exclusive;
	НовСтр.autodelete = autodelete;
	НовСтр.maxPriority = maxPriority;
	НовСтр.arguments = arguments;
	
КонецПроцедуры


Функция ТЗ_Связывание()
	//queue - Строка - Имя очереди
	//exchange - Строка - Имя точки обмена
	//routingKey - Строка - Rлюч маршрутизации.
	//arguments - Строка - [НЕОБЯЗАТЕЛЬНЫЙ] произвольные свойства в формате Json-объект. Пример: {"x-match": "all"}.

	ТЗ = Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("queue");         	//queue - Строка - Имя очереди
	ТЗ.Колонки.Добавить("exchange");   		//exchange - Строка - Имя точки обмена
	ТЗ.Колонки.Добавить("routingKey");      //routingKey - Строка - Rлюч маршрутизации.
	ТЗ.Колонки.Добавить("arguments");    	//arguments - Строка - [НЕОБЯЗАТЕЛЬНЫЙ] произвольные свойства в формате Json-объект. Пример: {"x-match": "all"}.
	
										
	//arguments = "{""x-dead-letter-exchange"": ""to-erp-from-retail-doc-retry""}";
	//arguments = "{""x-message-ttl"": 300000}";
	
	Возврат ТЗ;
	
КонецФункции


// Описание_метода
//
// Параметры:
	//queue - Строка - Имя очереди
	//exchange - Строка - Имя точки обмена
	//routingKey - Строка - Rлюч маршрутизации.
	//arguments - Строка - [НЕОБЯЗАТЕЛЬНЫЙ] произвольные свойства в формате Json-объект. Пример: {"x-match": "all"}.
//
Процедура ЗапланироватьСвязывание(ТЗ, знач queue, знач exchange, знач routingKey, знач arguments)

	НовСтр = ТЗ.Добавить();
	НовСтр.queue = queue;
	НовСтр.exchange = exchange;
	НовСтр.routingKey = routingKey;
	НовСтр.arguments = arguments;
		
КонецПроцедуры


// Описание_метода
//
// Параметры:
//	СтруктураАргументов 	- структура - 
//
// Возвращаемое значение:
//	Тип: строка
//
Функция СформироватьАргументы(СтруктураАргументов)
	
	Результат = "";
	
	ЗаписьJson = Новый ЗаписьJson;
	ЗаписьJson.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJson, СтруктураАргументов);
	
	Результат = ЗаписьJson.Закрыть();
	
	Возврат Результат;
	
КонецФункции


#КонецОбласти 	

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция getVersion() экспорт

	_п = СведенияОВнешнейОбработке();
	Возврат _п.Версия;
	
КонецФункции



/////////////////////////////////////////////////////////////////////////////////////////////





ИмяСобытияЖР = "Настройка_RabbitMQ";


