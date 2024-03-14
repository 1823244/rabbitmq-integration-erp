﻿// https://infostart.ru/1c/articles/827126/
Перем мИДСессии;
Перем мЧтениеJSON;

Перем Плагины; // структура
Перем КэшОбъектовПлагинов; //ТЗ

Перем ИмяСобытияЖР;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.6");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Импорт из 1С:УПП");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Импорт из 1С:УПП");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.7.306"); // ОБЯЗАТЕЛЬНО!!! //(https://forum.infostart.ru/forum9/topic179193/)
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Открыть форму : Импорт из 1С:УПП","ЗагрузитьДанныеИз1СУППИнтерактивно",ТипКоманды, Ложь) ;
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Выполнить импорт НСИ из 1С:УПП","ЗагрузитьНСИИз1СУПП",ТипКоманды, Ложь) ;
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Выполнить импорт документов из 1С:УПП","ЗагрузитьДокументыИз1СУПП",ТипКоманды, Ложь) ;

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
	
	Если ИмяКоманды = "ЗагрузитьДокументыИз1СУПП" Тогда
		ВыполнитьИмпортДокументов();
	ИначеЕсли ИмяКоманды = "ЗагрузитьНСИИз1СУПП" Тогда
		ВыполнитьИмпортНСИ();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти 	



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ВыполнитьИмпортДокументов() Экспорт
	
	мИДСессии = Строка(Новый УникальныйИдентификатор);
	
	Плагины();

	Если мЧтениеJSON = Неопределено Тогда
		мЧтениеJSON = Новый ЧтениеJSON;
	КонецЕсли;
	
	// на случай, если в расширении RabbitConnector нет констант (Старая версия)
	Попытка
		Очередь = Константы.ксп_ОчередьВходящихДокументов.Получить();
	Исключение
	    Очередь = "to-erp-from-upp-doc";
	КонецПопытки;
	Если НЕ ЗначениеЗаполнено(Очередь) Тогда
		Очередь = "to-erp-from-upp-doc";
	КонецЕсли;
	
	ЗагрузитьДанныеИзОчереди(Очередь);
		
КонецПроцедуры

Процедура ВыполнитьИмпортНСИ() Экспорт
	
	мИДСессии = Строка(Новый УникальныйИдентификатор);
	
	Плагины();

	Если мЧтениеJSON = Неопределено Тогда
		мЧтениеJSON = Новый ЧтениеJSON;
	КонецЕсли;
	
	// на случай, если в расширении RabbitConnector нет констант (Старая версия)
	Попытка
		Очередь = Константы.ксп_ОчередьВходящихНСИ.Получить();
	Исключение
	    Очередь = "to-erp-from-upp-static";
	КонецПопытки;
	Если НЕ ЗначениеЗаполнено(Очередь) Тогда
		Очередь = "to-erp-from-upp-static";
	КонецЕсли;
	
	ЗагрузитьДанныеИзОчереди(Очередь);
		
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
		|	спр.ИмяОбъекта ПОДОБНО ""Плагин_RabbitMQ_импорт_из_УПП%""
		|	И спр.ПометкаУдаления = ЛОЖЬ
		|	И НЕ спр.Публикация = &ПубликацияОтключена";
		
		
	Запрос.УстановитьПараметр("ПубликацияОтключена", Перечисления.ВариантыПубликацииДополнительныхОтчетовИОбработок.Отключена);
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

		ИмяОбработки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(стрк.ИмяОбъекта, ".");//разделим на имя расширени
		
		массивСлов = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИмяОбработки[0], "_");
		
		//Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_Номенклатура.epf	
		//ключ - тип объекта МД (напр. Справочник_Номенклатура), значение - ссылка в Доп обработках
		Ключ = массивСлов[5] + "_" + массивСлов[6];

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


//--------------------------------------------------------------------------------

// Описание_метода
//
// Параметры:
//	ИмяОчереди 	- строка - очередь, откуда читаем данные
//	Клиент - Неопределено (прод) / Обработка (тест) - только для тестирования! 
//		Сюда передается мок (встроенная или внешняя обработка (объекь), которая
//		имитируем методы Рэббита.
//		Тест будет использовать объект этой обработки, созданный из
//		подсистемы Доп обработок
//
Процедура ЗагрузитьДанныеИзОчереди(ИмяОчереди, Знач Клиент = Неопределено) Экспорт

	мИДСессии = Строка(Новый УникальныйИдентификатор);
	ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,"Сессия запущена.ИД "+мИДСессии);
	

	ПолучаемоеСообщение 	= "";
	ТегСообщения			= 0;
	
	Если Клиент = Неопределено Тогда
		
		Выполнить("Клиент = PinkRabbit.ПолучитьКлиента();");
		
	КонецЕсли;
		
	КоличествоПолученных = 0;
	
    //https://github.com/BITERP/PinkRabbitMQ
    queue = ИмяОчереди; //- Строка - Очередь из которой будем читать сообщения.
    consumerId = ""; //- Строка - [НЕ РЕАЛИЗОВАНО] имя потребителя. Если не задан, то имя потребителя сгенерирует сервер и вернет из метода
    noConfirm = Ложь;//- Булево - не ждать подтверждения обработки. Сообщения будут удалены из очереди сразу после отправки на клиента.
    exclusive = Ложь;// - Булево - монопольно захватить очередь
    selectSize = 40; //- Число - количество единовременно считываемых сообщений из очереди в кеш компоненты. Оптимизационный параметр, который влияет на скорость забора сообщений. Рекомендуемый диапазон 100-1000. Нежелательно устанавливать слишком высокие значения, т.к. чтение большого числа накопленных сообщений в очереди может спровоцировать нехватку памяти на клиенте 1С и падение компоненты без вызова исключения.
    arguments = "";// - Строка - [НЕОБЯЗАТЕЛЬНЫЙ] произвольные свойства в формате Json-объект. Пример: {"x-stream-offset": "first"}.
	
	Попытка
		consumerId = Клиент.BasicConsume(queue, consumerId, noConfirm, exclusive, selectSize, arguments);
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Предупреждение,,,
		"Потребитель подключен под именем: "+Строка(consumerId)+". Сессия ИД "+мИДСессии);
		
	Исключение
		т = Клиент.GetLastError();
		Клиент = Неопределено;
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
		"Ошибка получения сообщений. Сессия ИД "+мИДСессии+". Подробности: "+т);
		
		Клиент = Неопределено;
		
		Возврат;
	КонецПопытки; 
	
	ПолучаемоеСообщение = "";
	
	Попытка

	    //consumerId - Строка - [НЕ РЕАЛИЗОВАНО] Имя зарегистрированного потребителя
		//outdata - Строка - Выходной параметр. Тело сообщения.
		//messageTag - Число - Выходной параметр. Тег сообщения для подтверждения через метод BasicAck
		//timeout - Число - Таймаут ожидания сообщения в миллисекундах. 
		//Не рекомендуется ставить параметр слшком низким, т.к. сообщение просто может не успеть
		//прийти из очереди. Рекомендуемый диапазон 3000-60000.

		Пока Клиент.BasicConsumeMessage(consumerId, ПолучаемоеСообщение, ТегСообщения, 5000) Цикл
			КоличествоПолученных = КоличествоПолученных + 1;
			NeedReject = false;
			Попытка
				мЧтениеJSON.УстановитьСтроку(ПолучаемоеСообщение);
				тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
				обк = тДанные.identification;
				ТипОбъекта = тДанные.type;
				ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,
					"Обработка сообщения с тэгом "+ТегСообщения+". Тип объекта = "+Строка(ТипОбъекта)+". Сессия ИД "+мИДСессии);
			Исключение                                                                 
				т = ОписаниеОшибки();
				ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
	            	"Удалено из очереди сообщение_ с тэгом "+ТегСообщения+". Ошибка чтения json: "+Строка(т)+". Сессия ИД "+мИДСессии);

				NeedReject = true;//Клиент.BasicReject(ТегСообщения);  // удаляет из очереди

			КонецПопытки;
			
			if NeedReject = true then
				Попытка
					Клиент.BasicReject(ТегСообщения);
					ТегСообщения = 0;
					Продолжить;
				Исключение           
					ТегСообщения = 0;
					т = Клиент.GetLastError();
					ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
						"Ошибка RabbitMQ при пропуске (BasicReject без загрузки в 1С, т.к. не найден нужный плагин) сообщения."+
						" Сессия ИД "+мИДСессии+". Подробности: "+т);		
					Продолжить;
				КонецПопытки;			
			endIf;
			
			// найти плагин
			Плагин = Неопределено;
			Успешно = НайтиПлагин(ТипОбъекта, Плагин);
			Если НЕ Успешно Тогда
				т = "Для типа данных <"+Строка(ТипОбъекта)+"> нет доп. обработки импорта json из RabbitMQ!";
				
				// а если объектов будет миллион?
				ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение, ,,	т);
			
				Попытка
					Клиент.BasicReject(ТегСообщения);					
					ТегСообщения = 0;
					Продолжить;
				Исключение           
					ТегСообщения = 0;
					т = Клиент.GetLastError();
					ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
						"Ошибка RabbitMQ при пропуске (BasicReject без загрузки в 1С, т.к. не найден нужный плагин) сообщения."+
						" Сессия ИД "+мИДСессии+". Подробности: "+т);		
					Продолжить;
				КонецПопытки;			
				
			КонецЕсли;
			
	        NeedReject = false;
			//НачатьТранзакцию();
			Попытка	
									
				Плагин.ЗагрузитьОбъект(тДанные); //здесь может быть исключение
				
				Клиент.BasicAck(ТегСообщения); 			

				ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,
					"Получено сообщение с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+мИДСессии);
				ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти
				
				//ЗафиксироватьТранзакцию();
				
			Исключение
				//Если ТранзакцияАктивна() Тогда
				//	ОтменитьТранзакцию();
				//КонецЕсли;
								
				т = Клиент.GetLastError();
				Если НЕ ЗначениеЗаполнено(т) Тогда
					// ошибка НЕ в компоненте
					т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
					ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
						"Ошибка обработки (Не в PinkRabbitMQ.dll) сообщения с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+мИДСессии+". Подробности: "+т);
				Иначе 
					ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
						"Ошибка PinkRabbitMQ.dll при обработке сообщения с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+мИДСессии+". Подробности: "+т);
				КонецЕсли; 
				
				NeedReject = true;
				
			КонецПопытки; 
			
			if NeedReject = true then
				Попытка
					
					Клиент.BasicReject(ТегСообщения);//сообщение отправится в dead-letter-exchange
					
					ТегСообщения = 0;
				Исключение           
					ТегСообщения = 0;
					т = Клиент.GetLastError();
					ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
						"Ошибка RabbitMQ (BasicReject после ошибки загрузки в 1С)"+
						" Сессия ИД "+мИДСессии+". Подробности: "+т);		
				КонецПопытки;			
			endIf;
			
			ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти	
			
		КонецЦикла;
		Клиент.BasicCancel("");
		
		Клиент = Неопределено;
	
	
	Исключение
		
		т = Клиент.GetLastError();
		Если ЗначениеЗаполнено(т) Тогда
			Клиент = Неопределено;
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Ошибка получения сообщений - ошибка RabbitMQ. Сессия ИД "+мИДСессии+". Подробности: "+т);
		Иначе
			
			т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Ошибка получения сообщений - ошибка НЕ RabbitMQ. Сессия ИД "+мИДСессии+". Подробности: "+т);
		КонецЕсли;
	КонецПопытки;	
	
	ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,"Получено сообщений "+строка(КоличествоПолученных)+". Сессия ИД "+мИДСессии);
	ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,"Сессия Завершена.ИД "+мИДСессии);

КонецПроцедуры


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ВыполнитьЛогику1(тДанные, Товары)
	
	//в одной транзакции
	//
	//ДокЗаказ = СоздатьЗаказНаПеремещениеИзПеремещенияУПП(тДанные, Товары);  
	//
	//СоздатьРОИзПеремещенияУПП(тДанные, ДокЗаказ);  
	 
	
КонецПроцедуры    


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Функция СоздатьЗаказНаПеремещениеИзПеремещенияУПП(тДанные, Товары)
	
	//проверить существование документа
	//Если существует Тогда
	//	использовать блокировку
	//КонецЕсли;
	//
	//ДокОбк = Документы.ЗаказНаПеремещение.СоздатьДокумент();
	//ДокОбк.дата = тДанные.date;  
	//заполнить шапку из тДанные
	//
	//докобк.Товары.очистить();
	//
	//Для каждого стрк Из товары Цикл
	//	
	//	новСТр = докобк.Товары.Добавить();
	//	
	//КонецЦикла;
	//
	//ДокОбк.Записать();
	//
	//возврат докобк.ссылка;
		
КонецФункции



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьРОИзПеремещенияУПП(тДанные, Товары, ДокЗаказ)
	
	ДокОбк = Документы.РасходныйОрдерНаТовары.СоздатьДокумент();
	
	// нужна связь с докЗаказ!
	
	Возврат Неопределено;
	
КонецФункции














Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	//Если Свойство = "Сумма" Тогда
	//	Возврат XMLЗначение(Тип("Число"),Значение);
	//КонецЕсли;
	
КонецФункции



ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

                              