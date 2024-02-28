﻿// Данная обработка обеспечивает транспорт

Перем ИмяСобытияЖР;

#Область Версия_1_описание

// 2023-11-15  Используется эта версия

// Версия 1

// объекты для выгрузки выбираются из плана обмена через метод
//	Выборка = ПланыОбмена.ВыбратьИзменения(Узел,1);

#КонецОбласти 	


#Область Версия_2_описание

// 2023-11-15  Это - прототип. Рабочий. См. раздел "Использование"

// Версия 2

// Объекты для выгрузки выбираются одним запросом - в одном запросе один вид метаданных.
// План обмена используется, как отбор (через INNER JOIN с таблицей изменений).
// Запрос для выбора объектов лежит в плагинах.

//		ИНСТРУКЦИЯ - для ВЕРСИИ 2 - по добавлению нового объекта метаданных

//	1. В метод ВидыМетаданныхДляВыгрузки() добавить новый вид объектов
//	2. В метод ПолучитьИзменения_ПоВидуМетаданных() добавить вызов нового метода получения выборки
//	3. Реализовать новый метод получения выборки для п.2 (пример - ПолучитьИзменения_Справочник_Номенклатура())

//		Использование

// Для использования этой версии надо вносить изменения в плагины.
// Сейчас исправлен только один - для выгрузки спр Склады.
// Но! Эти исправления отключены, т.к. вернулись к версии 1.
// Они отмечены комментариями "Версия2", в комментариях написано что надо сделать.

#КонецОбласти 	




Перем Плагины; // структура?
Перем КэшОбъектовПлагинов; //ТЗ
Перем мИмяТочкиОбмена;
Перем мУзел;



#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.7");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Выгрузка из ЕРП");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Выгрузка из ЕРП");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180"); // ОБЯЗАТЕЛЬНО!!! //(https://forum.infostart.ru/forum9/topic179193/)
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Открыть форму : Экспорт из ЕРП","ЭкпортИзЕРПФорма",ТипКоманды, Ложь) ;
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Выполнить экспорт из ЕРП","ЭкспортИзЕРП",ТипКоманды, Ложь) ;
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Выполнить экспорт. Версия 2","ЭкспортИзЕРПВерсия2",ТипКоманды, Ложь) ;

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
	ИначеЕсли ИмяКоманды = "ЭкспортИзЕРПВерсия2" Тогда
		ВыполнитьЭкспорт_Версия_2();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти 	


#Область Версия1


// Выгружает объекты из плана обмена
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ВыполнитьЭкспорт(ПараметрыВыполнения = Неопределено) Экспорт

	ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,
		"Запуск" );
	
	ВремяНач = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	Если ПараметрыСеанса.РаботаСВнешнимиРесурсамиЗаблокирована Тогда
		
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Экспорт не выполнен, т.к. ПараметрыСеанса.РаботаСВнешнимиРесурсамиЗаблокирована = Истина" );
		
		Возврат;
		
	КонецЕсли;
	
	ИмяТочкиОбмена = Константы.ксп_ТочкаОбмена.Получить().Наименование;
	
	Если Не ЗначениеЗаполнено(ИмяТочкиОбмена) Тогда
		ВызватьИсключение "Константа ксп_ТочкаОбмена не установлена!";
	КонецЕсли;

	Узел = Константы.ксп_УзелОбменаRabbit.Получить();
	Если Не ЗначениеЗаполнено(Узел) Тогда
		ВызватьИсключение "Константа ксп_УзелОбменаRabbit не установлена!";
	КонецЕсли;
	


	Плагины(); //заполняем кэш плагинов
	
	Клиент = PinkRabbit.ПолучитьКлиента();
	
	
	Выборка = ПланыОбмена.ВыбратьИзменения(Узел,1);
	Пока Выборка.Следующий() Цикл

		Объект = Выборка.Получить();
		ДанныеСсылка = Объект.Ссылка;

		Если ТипЗнч(Объект) = Тип("УдалениеОбъекта") Тогда
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение,,ДанныеСсылка,
				"Тип данных <УдалениеОбъекта> не обрабатывается и будет пропущен!");
			Продолжить;
		КонецЕсли;
		
		ПредставлениеОбъекта = Строка(Объект);
		
		ТипОбъекта = Объект.Метаданные().ПолноеИмя();
			
		//// найти плагин
		//Плагин = Неопределено;
		//Успешно = НайтиПлагин(ТипОбъекта, Плагин);
		//Если НЕ Успешно Тогда
		//	
		//	// а если объектов будет миллион?
		//	//ЗаписьЖурналаРегистрации("ЕНС", УровеньЖурналаРегистрации.Предупреждение, ,, 
		//	//	"Для типа данных <"+Строка(ТипОбъекта)+"> нет доп. обработки формирования json для экспорта в RabbitMQ!");
		//	
		//	Продолжить;
		//КонецЕсли;
// -------------------------------------------- БЛОКИРОВКА
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить(ТипОбъекта);
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("Ссылка", Объект.Ссылка);

		НачатьТранзакцию();
		
		Попытка
			Блокировка.Заблокировать();
		Исключение
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Информация,,Объект.Ссылка,
				"Объект не выгружен! Ошибка блокировки объекта <"+ПредставлениеОбъекта+">. Подробности: "+т);
			ОтменитьТранзакцию();
			Продолжить;
		КонецПопытки;
// -------------------------------------------- БЛОКИРОВКА
		
		Попытка
			//json = Плагин.ВыгрузитьОбъект(Объект);   
			
			// ЕНС. пока не сделал универсальную функцию для других типов
			
			//Если Справочники.ТипВсеСсылки().СодержитТип(ТипЗнч(ДанныеСсылка)) Тогда
			//	json = ксп_ЭкспортСлужебный.ВыгрузитьОбъектПоСсылке(Объект);   
			//	
			//ИначеЕсли Документы.ТипВсеСсылки().СодержитТип(ТипЗнч(ДанныеСсылка)) Тогда
			//	json = ксп_ЭкспортСлужебный.ВыгрузитьОбъектПоСсылке(Объект);

			//ИначеЕсли ПланыВидовХарактеристик.ТипВсеСсылки().СодержитТип(ТипЗнч(ДанныеСсылка)) Тогда
			//	json = Плагин.ВыгрузитьОбъект(Объект);   

			//КонецЕсли;
			
			json = ксп_ЭкспортСлужебный.ВыгрузитьОбъектПоСсылке(Объект);
			
			// для отладки
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,ДанныеСсылка,
				"Сформирован json для объекта <"+ПредставлениеОбъекта+">");

		Исключение
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
				"Ошибка формирования json для объекта <"+ПредставлениеОбъекта+">. Подробности: "+т);
			ОтменитьТранзакцию();
			Продолжить;
		КонецПопытки;
		
		_типОбъекта = ТипЗнч(Объект.Ссылка);	
		RoutingKey = "";
		Если Документы.ТипВсеСсылки().СодержитТип(_типОбъекта) Тогда
			RoutingKey = "doc";
		ИначеЕсли Справочники.ТипВсеСсылки().СодержитТип(_типОбъекта) 
			ИЛИ Перечисления.ТипВсеСсылки().СодержитТип(_типОбъекта)
			ИЛИ ПланыВидовХарактеристик.ТипВсеСсылки().СодержитТип(_типОбъекта) Тогда
			RoutingKey = "static";
		КонецЕсли;
		
			// для отладки
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,ДанныеСсылка,
				"Определен routing key для объекта <"+ПредставлениеОбъекта+">: "+RoutingKey);
		
		
		УспешноОпубликован = Ложь;
		Попытка
			Клиент.BasicPublish(ИмяТочкиОбмена, RoutingKey, json, 0, Ложь);
			УспешноОпубликован = Истина;

			// для отладки
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,ДанныеСсылка,
				"Выполнена публикация для объекта <"+ПредставлениеОбъекта+">");

		Исключение
	        т = Клиент.GetLastError();
			тт = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,	
				"Ошибка публикации объекта <"+ПредставлениеОбъекта+">. Ошибка PinkRabbitMQ: "+т+символы.ПС+
				"Ошибка 1С: "+тт);
			ОтменитьТранзакцию();
			Продолжить;
		КонецПопытки;

		Если УспешноОпубликован = Истина Тогда
			Попытка
				ПланыОбмена.УдалитьРегистрациюИзменений(Узел, Объект);			

			// для отладки
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,ДанныеСсылка,
				"Удалена регистрация в плане обмена для объекта <"+ПредставлениеОбъекта+">");
				
			Исключение
				т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
				ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
					"Не удалось удалить регистрацию объекта <"+Строка(ПредставлениеОбъекта)+">. Подробности: "+т);
				ОтменитьТранзакцию();
				Продолжить;
			КонецПопытки;
		КонецЕсли;  
		
		ЗафиксироватьТранзакцию();
		
	КонецЦикла;
	
	Клиент = Неопределено;
	
	ВремяКон = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Длительность = ВремяКон - ВремяНач;
	ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Информация,,,
		"Завершение. Длительность = " + строка(Длительность) + " мс" );
	
КонецПроцедуры


#КонецОбласти 	


#Область Версия2_ЭтоПрототип_НеИспользуетсяВПроде

// Оркестратор. Формирует список видо объектов для выгрузки и вызывает метод экспорта
Процедура ВыполнитьЭкспорт_Версия_2(ПараметрыВыполнения = Неопределено) Экспорт

	ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Информация,,,
		"Запуск" );
	
	ВремяНач = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	Если ПараметрыСеанса.РаботаСВнешнимиРесурсамиЗаблокирована Тогда
		
		ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,,
			"Экспорт не выполнен, т.к. ПараметрыСеанса.РаботаСВнешнимиРесурсамиЗаблокирована = Истина" );
		
		Возврат;
		
	КонецЕсли;
	
	мИмяТочкиОбмена = Константы.ксп_ТочкаОбмена.Получить().Наименование;
	
	Если Не ЗначениеЗаполнено(мИмяТочкиОбмена) Тогда
		ВызватьИсключение "Константа ксп_ТочкаОбмена не установлена!";
	КонецЕсли;

	мУзел = Константы.ксп_УзелОбменаRabbit.Получить();
	Если Не ЗначениеЗаполнено(мУзел) Тогда
		ВызватьИсключение "Константа ксп_УзелОбменаRabbit не установлена!";
	КонецЕсли;
	
  	Плагины(); //заполняем кэш плагинов
	
	ВидыМетаданныхДляВыгрузки = ВидыМетаданныхДляВыгрузки();//массив строк вида Справочник.Номенклатура

	Для каждого ТипОбъекта Из ВидыМетаданныхДляВыгрузки Цикл
		
		ВыгрузитьОбъектыМетаданныхОдногоВида(ТипОбъекта);
		
	КонецЦикла;	
	
	ВремяКон = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Длительность = ВремяКон - ВремяНач;
	ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Информация,,,
		"Завершение. Длительность = " + строка(Длительность) + " мс" );	
	
КонецПроцедуры


// Исполнитель. Публикует в шину объекты одного вида
//
// Параметры:
//	ТипОбъекта - строка - пример: "Справочник.Номенклатура" 
//
Процедура ВыгрузитьОбъектыМетаданныхОдногоВида(ТипОбъекта)
	
	// найти плагин
	Плагин = Неопределено;
	Успешно = НайтиПлагин(ТипОбъекта, Плагин);
	Если НЕ Успешно Тогда
		
		// а если объектов будет миллион?
		//ЗаписьЖурналаРегистрации("ЕНС", УровеньЖурналаРегистрации.Предупреждение, ,, 
		//	"Для типа данных <"+Строка(ТипОбъекта)+"> нет доп. обработки формирования json для экспорта в RabbitMQ!");
		ЗаписьЖурналаРегистрации("Экспорт_из_ЕРП", УровеньЖурналаРегистрации.Предупреждение, ,,
			"Для типа объектов экспорт версии 2 не реализован: "+Строка(ТипОбъекта));
		
		Возврат;
	КонецЕсли;

	РезультатЗапроса = Плагин.ПолучитьОбъектыДляВыгрузки(мУзел);	
	
	Если РезультатЗапроса = Неопределено ИЛИ РезультатЗапроса.Пустой() Тогда
		ЗаписьЖурналаРегистрации("Экспорт_из_ЕРП", УровеньЖурналаРегистрации.Предупреждение, ,,
			"Для типа объектов экспорт версии 2 не нашел зарегистрированных данных: "+Строка(ТипОбъекта));
		Возврат;
	КонецЕсли;
	
	Клиент = PinkRabbit.ПолучитьКлиента();
		
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Объект = Выборка;
		
		// доделать
		//Если ТипЗнч(Объект) = Тип("УдалениеОбъекта") Тогда
		//	ЗаписьЖурналаРегистрации("Экспорт_из_ЕРП", УровеньЖурналаРегистрации.Предупреждение,,,
		//		"Тип данных <УдалениеОбъекта> не обрабатывается и будет пропущен!");
		//	Продолжить;
		//КонецЕсли;
		
		ПредставлениеОбъекта = Строка(Объект.Ссылка);        
		
			
		Попытка
			json = Плагин.ВыгрузитьОбъект(Объект);
		Исключение
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,,
				"Ошибка формирования json для объекта <"+ПредставлениеОбъекта+">. Подробности: "+т);
			Продолжить;
		КонецПопытки;
		
		RoutingKey = Плагин.getRoutingKey();
		//RoutingKey = "";
		//Если Документы.ТипВсеСсылки().СодержитТип(ТипЗнч(Объект.Ссылка)) Тогда
		//	RoutingKey = "doc";
		//	
		//ИначеЕсли Справочники.ТипВсеСсылки().СодержитТип(ТипЗнч(Объект.Ссылка)) 
		//	ИЛИ Перечисления.ТипВсеСсылки().СодержитТип(ТипЗнч(Объект.Ссылка)) Тогда
		//	
		//	RoutingKey = "static";
		//КонецЕсли;
		
		УспешноОпубликован = Ложь;
		Попытка
			Клиент.BasicPublish(мИмяТочкиОбмена, RoutingKey, json, 0, Ложь);
			УспешноОпубликован = Истина;
		Исключение
	        т = Клиент.GetLastError();
			тт = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,,	
				"Ошибка публикации объекта <"+ПредставлениеОбъекта+">. "+
				"Ошибка PinkRabbitMQ: "+т+символы.ПС+
				"Ошибка 1С: "+тт);
			Продолжить;
		КонецПопытки;

		Если УспешноОпубликован = Истина Тогда
			Попытка
				ПланыОбмена.УдалитьРегистрациюИзменений(мУзел, Объект.Ссылка);			
			Исключение
				т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
				ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,,
					"Не удалось удалить регистрацию объекта <"+Строка(ПредставлениеОбъекта)+">. (Объект выгружен успеншо). Подробности: "+т);
				Продолжить;
			КонецПопытки;
		КонецЕсли;
		
	КонецЦикла;
	
	Клиент = Неопределено;
	
		
КонецПроцедуры


// Выбирает, какой метод вызывать для получения выборки в зависимости от вида метаданных
//
// Параметры:
//	ТипОбъекта 	- строка - пример: "Справочник.Номенклатура"
//
// Возвращаемое значение:
//	Тип: выборка из рез запроса
//
Функция ПолучитьИзменения_ПоВидуМетаданных(ТипОбъекта)
	
	Если ТипОбъекта = "Справочник.Номенклатура" Тогда
		Возврат ПолучитьИзменения_Справочник_Номенклатура();
		
	ИначеЕсли ТипОбъекта = "Справочник.Склады" Тогда
		Возврат ПолучитьИзменения_Справочник_Склады();
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: массив
//
Функция ВидыМетаданныхДляВыгрузки() Экспорт
	
	_м = Новый Массив;
	_м.Добавить("Справочник.Номенклатура");
	_м.Добавить("Справочник.Склады");
	
	_м.Добавить("Документ.ЗаказКлиента");
	
	Возврат _м;
	
КонецФункции


// Выбирает зарегистрированные к обмену объекты
//
// Параметры:
//	нет
//
// Возвращаемое значение:
//	Тип: выборка из рез запроса
//
Функция ПолучитьИзменения_Справочник_Номенклатура()
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	спр.Ссылка КАК Ссылка,
		|	спр.ВерсияДанных КАК ВерсияДанных,
		|	спр.ПометкаУдаления КАК ПометкаУдаления,
		|	спр.Родитель КАК Родитель,
		|	спр.ЭтоГруппа КАК ЭтоГруппа,
		|	спр.Код КАК Код,
		|	спр.Наименование КАК Наименование,
		|	спр.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|	спр.Артикул КАК Артикул,
		|	спр.ВариантОформленияПродажи КАК ВариантОформленияПродажи,
		|	спр.ВесЕдиницаИзмерения КАК ВесЕдиницаИзмерения,
		|	спр.ВесЗнаменатель КАК ВесЗнаменатель,
		|	спр.ВесИспользовать КАК ВесИспользовать,
		|	спр.ВесМожноУказыватьВДокументах КАК ВесМожноУказыватьВДокументах,
		|	спр.ВесЧислитель КАК ВесЧислитель,
		|	спр.ВестиУчетПоГТД КАК ВестиУчетПоГТД,
		|	спр.ВестиУчетСертификатовНоменклатуры КАК ВестиУчетСертификатовНоменклатуры,
		|	спр.ВидАлкогольнойПродукции КАК ВидАлкогольнойПродукции,
		|	спр.ВидНоменклатуры КАК ВидНоменклатуры,
		|	спр.ГруппаДоступа КАК ГруппаДоступа,
		|	спр.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
		|	спр.НаименованиеПолное КАК НаименованиеПолное,
		|	спр.ЕдиницаИзмеренияСрокаГодности КАК ЕдиницаИзмеренияСрокаГодности,
		|	спр.ЕстьТоварыДругогоКачества КАК ЕстьТоварыДругогоКачества,
		|	спр.ИмпортнаяАлкогольнаяПродукция КАК ИмпортнаяАлкогольнаяПродукция,
		|	спр.ДлинаЕдиницаИзмерения КАК ДлинаЕдиницаИзмерения,
		|	спр.ДлинаЗнаменатель КАК ДлинаЗнаменатель,
		|	спр.ДлинаИспользовать КАК ДлинаИспользовать,
		|	спр.ДлинаМожноУказыватьВДокументах КАК ДлинаМожноУказыватьВДокументах,
		|	спр.ДлинаЧислитель КАК ДлинаЧислитель,
		|	спр.ИспользованиеХарактеристик КАК ИспользованиеХарактеристик,
		|	спр.ИспользоватьИндивидуальныйШаблонЦенника КАК ИспользоватьИндивидуальныйШаблонЦенника,
		|	спр.ИспользоватьИндивидуальныйШаблонЭтикетки КАК ИспользоватьИндивидуальныйШаблонЭтикетки,
		|	спр.ИспользоватьУпаковки КАК ИспользоватьУпаковки,
		|	спр.Качество КАК Качество,
		|	спр.КодДляПоиска КАК КодДляПоиска,
		|	спр.Марка КАК Марка,
		|	спр.НаборУпаковок КАК НаборУпаковок,
		|	спр.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчета,
		|	спр.НоменклатураМногооборотнаяТара КАК НоменклатураМногооборотнаяТара,
		|	спр.ОбъемДАЛ КАК ОбъемДАЛ,
		|	спр.Описание КАК Описание,
		|	спр.ПодакцизныйТовар КАК ПодакцизныйТовар,
		|	спр.ПоставляетсяВМногооборотнойТаре КАК ПоставляетсяВМногооборотнойТаре,
		|	спр.Производитель КАК Производитель,
		|	спр.ПроизводительИмпортерКонтрагент КАК ПроизводительИмпортерКонтрагент,
		|	спр.СкладскаяГруппа КАК СкладскаяГруппа,
		|	спр.СрокГодности КАК СрокГодности,
		|	спр.УдалитьСтавкаНДС КАК УдалитьСтавкаНДС,
		|	спр.СтавкаНДС КАК СтавкаНДС,
		|	спр.ТипНоменклатуры КАК ТипНоменклатуры,
		|	спр.ТоварнаяКатегория КАК ТоварнаяКатегория,
		|	спр.ФайлКартинки КАК ФайлКартинки,
		|	спр.ФайлОписанияДляСайта КАК ФайлОписанияДляСайта,
		|	спр.ОбъемЕдиницаИзмерения КАК ОбъемЕдиницаИзмерения,
		|	спр.ОбъемЗнаменатель КАК ОбъемЗнаменатель,
		|	спр.ОбъемИспользовать КАК ОбъемИспользовать,
		|	спр.ОбъемМожноУказыватьВДокументах КАК ОбъемМожноУказыватьВДокументах,
		|	спр.ОбъемЧислитель КАК ОбъемЧислитель,
		|	спр.ХарактеристикаМногооборотнаяТара КАК ХарактеристикаМногооборотнаяТара,
		|	спр.ПлощадьЕдиницаИзмерения КАК ПлощадьЕдиницаИзмерения,
		|	спр.ПлощадьЗнаменатель КАК ПлощадьЗнаменатель,
		|	спр.СхемаОбеспечения КАК СхемаОбеспечения,
		|	спр.СпособОбеспеченияПотребностей КАК СпособОбеспеченияПотребностей,
		|	спр.ПлощадьИспользовать КАК ПлощадьИспользовать,
		|	спр.ПлощадьМожноУказыватьВДокументах КАК ПлощадьМожноУказыватьВДокументах,
		|	спр.ПлощадьЧислитель КАК ПлощадьЧислитель,
		|	спр.ЦеноваяГруппа КАК ЦеноваяГруппа,
		|	спр.ШаблонЦенника КАК ШаблонЦенника,
		|	спр.ЕдиницаДляОтчетов КАК ЕдиницаДляОтчетов,
		|	спр.КоэффициентЕдиницыДляОтчетов КАК КоэффициентЕдиницыДляОтчетов,
		|	спр.ШаблонЭтикетки КАК ШаблонЭтикетки,
		|	спр.СезоннаяГруппа КАК СезоннаяГруппа,
		|	спр.КоллекцияНоменклатуры КАК КоллекцияНоменклатуры,
		|	спр.Принципал КАК Принципал,
		|	спр.Контрагент КАК Контрагент,
		|	спр.РейтингПродаж КАК РейтингПродаж,
		|	спр.ОбособленнаяЗакупкаПродажа КАК ОбособленнаяЗакупкаПродажа,
		|	спр.ГруппаАналитическогоУчета КАК ГруппаАналитическогоУчета,
		|	спр.КодТНВЭД КАК КодТНВЭД,
		|	спр.КодОКВЭД КАК КодОКВЭД,
		|	спр.КодОКП КАК КодОКП,
		|	спр.ОблагаетсяНДПИПоПроцентнойСтавке КАК ОблагаетсяНДПИПоПроцентнойСтавке,
		|	спр.ВладелецСерий КАК ВладелецСерий,
		|	спр.ВладелецХарактеристик КАК ВладелецХарактеристик,
		|	спр.ВладелецТоварныхКатегорий КАК ВладелецТоварныхКатегорий,
		|	спр.Крепость КАК Крепость,
		|	спр.ОсобенностьУчета КАК ОсобенностьУчета,
		|	спр.ПродукцияМаркируемаяДляГИСМ КАК ПродукцияМаркируемаяДляГИСМ,
		|	спр.КиЗГИСМ КАК КиЗГИСМ,
		|	спр.КиЗГИСМВид КАК КиЗГИСМВид,
		|	спр.КиЗГИСМСпособВыпускаВОборот КАК КиЗГИСМСпособВыпускаВОборот,
		|	спр.КиЗГИСМGTIN КАК КиЗГИСМGTIN,
		|	спр.КиЗГИСМРазмер КАК КиЗГИСМРазмер,
		|	спр.ПодконтрольнаяПродукцияВЕТИС КАК ПодконтрольнаяПродукцияВЕТИС,
		|	спр.АлкогольнаяПродукцияВоВскрытойТаре КАК АлкогольнаяПродукцияВоВскрытойТаре,
		|	спр.КодРаздел7ДекларацииНДС КАК КодРаздел7ДекларацииНДС,
		|	спр.ОблагаетсяНДСУПокупателя КАК ОблагаетсяНДСУПокупателя,
		|	спр.КодОКВЭД2 КАК КодОКВЭД2,
		|	спр.КодОКПД2 КАК КодОКПД2,
		|	спр.КодВидаНоменклатурнойКлассификации КАК КодВидаНоменклатурнойКлассификации,
		|	спр.НаименованиеВидаНоменклатурнойКлассификации КАК НаименованиеВидаНоменклатурнойКлассификации,
		|	спр.ЕдиницаИзмеренияТНВЭД КАК ЕдиницаИзмеренияТНВЭД,
		|	спр.СтранаПроисхождения КАК СтранаПроисхождения,
		|	спр.ПрослеживаемыйТовар КАК ПрослеживаемыйТовар,
		|	спр.КодТРУ КАК КодТРУ,
		|	спр.НаименованиеЯзык1 КАК НаименованиеЯзык1,
		|	спр.НаименованиеЯзык2 КАК НаименованиеЯзык2,
		|	спр.ДополнительныеРеквизиты.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		Свойство КАК Свойство,
		|		Значение КАК Значение,
		|		ТекстоваяСтрока КАК ТекстоваяСтрока
		|	) КАК ДополнительныеРеквизиты,
		|	спр.ДрагоценныеМатериалы.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		ДрагоценныйМатериал КАК ДрагоценныйМатериал,
		|		Количество КАК Количество,
		|		ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|		Расположение КАК Расположение,
		|		Комментарий КАК Комментарий
		|	) КАК ДрагоценныеМатериалы,
		|	спр.Представления.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		КодЯзыка КАК КодЯзыка,
		|		НаименованиеПолное КАК НаименованиеПолное,
		|		Наименование КАК Наименование
		|	) КАК Представления,
		|	спр.Предопределенный КАК Предопределенный,
		|	спр.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных
		|ИЗ
		|	Справочник.Номенклатура.Изменения КАК дифф
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК спр
		|		ПО (спр.Ссылка = дифф.Ссылка)
		|ГДЕ
		|	дифф.Узел = &НужныйУзелПланаОбмена";
	
	
	Запрос.УстановитьПараметр("НужныйУзелПланаОбмена", мУзел);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Возврат ВыборкаДетальныеЗаписи;
	
КонецФункции


// Выбирает зарегистрированные к обмену объекты
//
// Параметры:
//	нет
//
// Возвращаемое значение:
//	Тип: выборка из рез запроса
//
Функция ПолучитьИзменения_Справочник_Склады()
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Склады.Ссылка КАК Ссылка,
		|	Склады.ВерсияДанных КАК ВерсияДанных,
		|	Склады.ПометкаУдаления КАК ПометкаУдаления,
		|	Склады.Родитель КАК Родитель,
		|	Склады.ЭтоГруппа КАК ЭтоГруппа,
		|	Склады.Наименование КАК Наименование,
		|	Склады.ВыборГруппы КАК ВыборГруппы,
		|	Склады.ИспользоватьАдресноеХранение КАК ИспользоватьАдресноеХранение,
		|	Склады.ИспользоватьАдресноеХранениеСправочно КАК ИспользоватьАдресноеХранениеСправочно,
		|	Склады.ИспользоватьОрдернуюСхемуПриОтгрузке КАК ИспользоватьОрдернуюСхемуПриОтгрузке,
		|	Склады.ИспользоватьОрдернуюСхемуПриОтраженииИзлишковНедостач КАК ИспользоватьОрдернуюСхемуПриОтраженииИзлишковНедостач,
		|	Склады.ИспользоватьОрдернуюСхемуПриПоступлении КАК ИспользоватьОрдернуюСхемуПриПоступлении,
		|	Склады.ИспользоватьСерииНоменклатуры КАК ИспользоватьСерииНоменклатуры,
		|	Склады.ИспользоватьСкладскиеПомещения КАК ИспользоватьСкладскиеПомещения,
		|	Склады.Календарь КАК Календарь,
		|	Склады.КонтролироватьОперативныеОстатки КАК КонтролироватьОперативныеОстатки,
		|	Склады.НастройкаАдресногоХранения КАК НастройкаАдресногоХранения,
		|	Склады.Подразделение КАК Подразделение,
		|	Склады.БизнесРегион КАК БизнесРегион,
		|	Склады.РозничныйВидЦены КАК РозничныйВидЦены,
		|	Склады.ТекущаяДолжностьОтветственного КАК ТекущаяДолжностьОтветственного,
		|	Склады.ТекущийОтветственный КАК ТекущийОтветственный,
		|	Склады.ТипСклада КАК ТипСклада,
		|	Склады.УровеньОбслуживания КАК УровеньОбслуживания,
		|	Склады.УчетныйВидЦены КАК УчетныйВидЦены,
		|	Склады.НачинатьОтгрузкуПослеФормированияЗаданияНаПеревозку КАК НачинатьОтгрузкуПослеФормированияЗаданияНаПеревозку,
		|	Склады.ИспользованиеРабочихУчастков КАК ИспользованиеРабочихУчастков,
		|	Склады.ИсточникИнформацииОЦенахДляПечати КАК ИсточникИнформацииОЦенахДляПечати,
		|	Склады.ИспользоватьСтатусыРасходныхОрдеров КАК ИспользоватьСтатусыРасходныхОрдеров,
		|	Склады.ИспользоватьСтатусыПриходныхОрдеров КАК ИспользоватьСтатусыПриходныхОрдеров,
		|	Склады.ИспользоватьСтатусыПересчетовТоваров КАК ИспользоватьСтатусыПересчетовТоваров,
		|	Склады.ДатаНачалаОрдернойСхемыПриОтгрузке КАК ДатаНачалаОрдернойСхемыПриОтгрузке,
		|	Склады.ДатаНачалаОрдернойСхемыПриПоступлении КАК ДатаНачалаОрдернойСхемыПриПоступлении,
		|	Склады.ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач КАК ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач,
		|	Склады.ДатаНачалаИспользованияСкладскихПомещений КАК ДатаНачалаИспользованияСкладскихПомещений,
		|	Склады.ДатаНачалаАдресногоХраненияОстатков КАК ДатаНачалаАдресногоХраненияОстатков,
		|	Склады.УчитыватьСебестоимостьПоСериям КАК УчитыватьСебестоимостьПоСериям,
		|	Склады.КонтролироватьСвободныеОстатки КАК КонтролироватьСвободныеОстатки,
		|	Склады.СкладОтветственногоХранения КАК СкладОтветственногоХранения,
		|	Склады.ВидПоклажедержателя КАК ВидПоклажедержателя,
		|	Склады.Поклажедержатель КАК Поклажедержатель,
		|	Склады.СрокОтветственногоХранения КАК СрокОтветственногоХранения,
		|	Склады.ОтветственноеХранениеДоВостребования КАК ОтветственноеХранениеДоВостребования,
		|	Склады.ОсобыеОтметки КАК ОсобыеОтметки,
		|	Склады.УсловияХраненияТоваров КАК УсловияХраненияТоваров,
		|	Склады.ЦеховаяКладовая КАК ЦеховаяКладовая,
		|	Склады.ВМагазинеПоддерживаетсяСборкаЗаказов КАК ВМагазинеПоддерживаетсяСборкаЗаказов,
		|	Склады.ВМагазинеПоддерживаетсяДоставкаСвоимиКурьерами КАК ВМагазинеПоддерживаетсяДоставкаСвоимиКурьерами,
		|	Склады.СпособСозданияРеализацииПриСборкеЗаказов КАК СпособСозданияРеализацииПриСборкеЗаказов,
		|	Склады.СпособФискализацииПриДоставке КАК СпособФискализацииПриДоставке,
		|	Склады.СборкаИДоставкаВыполняетсяОднимСотрудником КАК СборкаИДоставкаВыполняетсяОднимСотрудником,
		|	Склады.КурьерыМогутНазначатьСебеЗаказы КАК КурьерыМогутНазначатьСебеЗаказы,
		|	Склады.СборщикиМогутНазначатьСебеЗаказы КАК СборщикиМогутНазначатьСебеЗаказы,
		|	Склады.НормативныйСрокДоставкиЗаказов КАК НормативныйСрокДоставкиЗаказов,
		|	Склады.КурьерыИспользуютЭквайринговыеТерминалы КАК КурьерыИспользуютЭквайринговыеТерминалы,
		|	Склады.КурьерыИспользуютАвтономныеККТ КАК КурьерыИспользуютАвтономныеККТ,
		|	Склады.ДатаНачалаСборкиЗаказов КАК ДатаНачалаСборкиЗаказов,
		|	Склады.ДатаНачалаДоставкиСвоимиКурьерами КАК ДатаНачалаДоставкиСвоимиКурьерами,
		|	Склады.ГруппировкаТоваров КАК ГруппировкаТоваров,
		|	Склады.ИндивидуальныйВидЦены КАК ИндивидуальныйВидЦены,
		|	Склады.КонтактнаяИнформация.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		Тип КАК Тип,
		|		Вид КАК Вид,
		|		Представление КАК Представление,
		|		ЗначенияПолей КАК ЗначенияПолей,
		|		Страна КАК Страна,
		|		Регион КАК Регион,
		|		Город КАК Город,
		|		АдресЭП КАК АдресЭП,
		|		ДоменноеИмяСервера КАК ДоменноеИмяСервера,
		|		НомерТелефона КАК НомерТелефона,
		|		НомерТелефонаБезКодов КАК НомерТелефонаБезКодов,
		|		ВидДляСписка КАК ВидДляСписка,
		|		Значение КАК Значение
		|	) КАК КонтактнаяИнформация,
		|	Склады.ДополнительныеРеквизиты.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		Свойство КАК Свойство,
		|		Значение КАК Значение,
		|		ТекстоваяСтрока КАК ТекстоваяСтрока
		|	) КАК ДополнительныеРеквизиты,
		|	Склады.Предопределенный КАК Предопределенный,
		|	Склады.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных
		|ИЗ
		|	Справочник.Склады.Изменения КАК СкладыИзменения
		|		ПОЛНОЕ СОЕДИНЕНИЕ Справочник.Склады КАК Склады
		|		ПО СкладыИзменения.Ссылка = Склады.Ссылка";
	
	
	Запрос.УстановитьПараметр("НужныйУзелПланаОбмена", мУзел);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Возврат ВыборкаДетальныеЗаписи;
	
КонецФункции




#КонецОбласти


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
		|	спр.ИмяОбъекта ПОДОБНО ""Плагин_RabbitMQ_экспорт%"" И спр.ПометкаУдаления = ЛОЖЬ
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
//	ТипОбъекта 	- строка - это не ТипЗнч()! а вот так: Объект.Метаданные().ПолноеИмя() - "Справочник.ВидыЦен"
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





ИмяСобытияЖР = "Экспорт_в_RabbitMQ";
