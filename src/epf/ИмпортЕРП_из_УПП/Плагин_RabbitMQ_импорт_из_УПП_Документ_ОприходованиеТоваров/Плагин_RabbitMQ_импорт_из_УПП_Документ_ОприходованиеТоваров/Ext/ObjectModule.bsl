﻿Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем мЛоггер;
Перем мИдВызова;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.5");
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОприходованиеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОприходованиеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_ОприходованиеТоваров",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_ОприходованиеТоваров",
		ТипКоманды, 
		Ложь) ;
	
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
	НоваяКоманда = ТаблицаКоманд.Добавить() ;
	НоваяКоманда.Представление = Представление ;
	НоваяКоманда.Идентификатор = Идентификатор ;
	НоваяКоманда.Использование = Использование ;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение ;
	НоваяКоманда.Модификатор = Модификатор ;
КонецПроцедуры

#КонецОбласти 	

#Область ЗагрузитьОбъект_

Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	
	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт документов из УПП: Оприходование товаров");
	
	Попытка
		
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ОприходованиеТоваров") Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;
		
		ПредставлениеДокументаУПП 			= "ОприходованиеТоваров №"+деф.Number+" от "+строка(деф.Date);
		
		СкладУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.Склад, "КСП_СкладыУПП");

		Если НЕ ЗНачениезаполнено(СкладУПП) Тогда
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= Неопределено;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Не найден склад УПП!";
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
								деф.Number,деф.date,Ложь,id.ref);

			мЛоггер.ерр("Документ не загружен! Не найден склад УПП для Оприходования : %1", 
				ПредставлениеДокументаУПП);
								
			Возврат Неопределено;
		КонецЕсли;

		СкладХраненияУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладХранения, "КСП_СкладыХраненияУПП");
		
		Если СкладХраненияУПП=Неопределено Тогда
			СкладХраненияУПП=Справочники.КСП_СкладыХраненияУПП.ПустаяСсылка();
		ИначеЕсли 
			// так проверям на битую ссылку
			НЕ ЗНачениезаполнено(СкладХраненияУПП)
			или (ТипЗнч(СкладХраненияУПП) = Тип( "СправочникСсылка.ксп_СкладыХраненияУПП")
				И НЕ ЗначениеЗаполнено( СкладХраненияУПП.ВерсияДанных)) тогда 
			
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= СкладУПП;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Не найден склад хранения УПП или это битая ссылка!";
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
			ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь,
			Id.ref);            
			
			мЛоггер.ерр("Документ не загружен! Не найден склад ХРАНЕНИЯ УПП для Оприходования : %1", 
				ПредставлениеДокументаУПП);
			
			Возврат Неопределено;
		КонецЕсли;

		ВидДокументаУППСсылка = НайтиВидДокументаУПП(СтруктураОбъекта.type);
		
		Если НЕ ЗНачениезаполнено(ВидДокументаУППСсылка) Тогда
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= СкладУПП;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Не найден вид документа УПП! (в спр. ВидыДокументовУПП)";
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь,
			Id.ref);
			
			мЛоггер.ерр("Документ не загружен! Не найден Вид документа УПП Оприходование : %1", 
				ПредставлениеДокументаУПП);
			
			Возврат Неопределено;
		КонецЕсли;

		// ищем элемент спр Виды операций. Там может быть несколько строк со складом хранения в ТЧ Получатели
		МассивВидОперацииПоСкладу = Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП_Получатели(
			СкладУПП); 
			
		Если МассивВидОперацииПоСкладу.Количество() = 0 Тогда
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= СкладУПП;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Не найден в ТЧ Получатели вид операции по складу! Склад: "+строка(СкладУПП);
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь,
			Id.ref);
				мЛоггер.ерр("Документ не загружен! Не найден Вид операции УПП : %1", 
				ПредставлениеДокументаУПП);
							

			Возврат Неопределено;
		КонецЕсли;
		
		Для каждого ВидОперацииПоСкладу Из МассивВидОперацииПоСкладу Цикл
			
			ЛогикаОбработки = НайтиЛогикуПоВидуДокумента(ВидОперацииПоСкладу, СкладХраненияУПП, ВидДокументаУППСсылка);	
			
			Если НЕ ЗначениеЗаполнено(ЛогикаОбработки) Тогда
				ВидДокумента 		= СтруктураОбъекта.type;
				Склад 				= СкладУПП;
				СкладОтправитель 	= Неопределено;
				СкладПолучатель 	= Неопределено;
				ТекстСообщения 		= "Не найдена логика обработки в ТЧ Получатели вида операции! Вид операции по складу: "+строка(ВидОперацииПоСкладу) + " код "+строка(ВидОперацииПоСкладу.код);
				ЛогикаСклад			= Неопределено;
				ЛогикаПеремещения 	= Неопределено;
				Обработчик 			= Неопределено;
				РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
									ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
				деф.Number,
				деф.date,
				Ложь,
				Id.ref);
				мЛоггер.ерр("Документ не загружен! Не найдена Логика обработки УПП : %1, СкладУПП : %2, ВидОперацииПоСкладу : %3", 
				ПредставлениеДокументаУПП, СкладУПП, ВидОперацииПоСкладу);
									
				продолжить;
			КонецЕсли;
						
			СсылкаОбработчика = НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаОбработки, ВидДокументаУППСсылка);
			
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение,,,
			"субплагин: "+строка(СсылкаОбработчика)+" код "+строка(СсылкаОбработчика.код)+
			" вид операции "+Строка(ВидОперацииПоСкладу) + " код " + строка(ВидОперацииПоСкладу.Код)+
			" логика " + строка(ЛогикаОбработки) + " код " + Строка(ЛогикаОбработки.код));
						
			Если НЕ ЗначениеЗаполнено(СсылкаОбработчика) Тогда
				ВидДокумента 		= СтруктураОбъекта.type;
				Склад 				= СкладУПП;
				СкладОтправитель 	= Неопределено;
				СкладПолучатель 	= Неопределено;
				ТекстСообщения 		= "Не найден субплагин в ТЧ элемента логики! Логика обработки: "+строка(ЛогикаОбработки)+ " код " + строка(ЛогикаОбработки.код);
				ЛогикаПеремещения 	= Неопределено;
				ЛогикаСклад 		= ЛогикаОбработки;
				Обработчик 			= Неопределено;
				РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
									ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
				деф.Number,
				деф.date,
				Ложь,
				Id.ref);
				мЛоггер.ерр("Документ не загружен! Не найден Субплагин : %1", 
				ПредставлениеДокументаУПП);

				продолжить;
			КонецЕсли;
			
			ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(СсылкаОбработчика);
			ОбъектОбработчика = ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(СсылкаОбработчика);
			
			Если ОбъектОбработчика = Неопределено Тогда
				ВызватьИсключение "Не удалось подключить внешнюю обработку! Имя = "+Строка(СсылкаОбработчика);			
			КонецЕсли;
			
			// запуск импорта
			мЛоггер.инфо("Запускается субплагин "+Строка(ОбъектОбработчика));
            Попытка        
                Рез = ОбъектОбработчика
                        .сетИдВызова(мИдВызова)
                        .ЗагрузитьОбъект(СтруктураОбъекта,"",ВидОперацииПоСкладу.СкладЕРП);
            Исключение
                т = НСтр("ru = '"+ОписаниеОшибки()+"'");
                Сообщить(т, СтатусСообщения.Внимание);
                мЛоггер.ерр("Ошибка при обработке вида операции "+Строка(ВидОперацииПоСкладу)+". Переходим к следующему (если их больше одного). Подробности ошибки: "+т);
                Продолжить;
            КонецПопытки;			
			
			
			//успешно
			
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= СкладУПП;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Успешно загружен";
			ЛогикаПеремещения 	= Неопределено;
			ЛогикаСклад 		= ЛогикаОбработки;
			Обработчик 			= СсылкаОбработчика;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Истина, // ошибки исправлены
			Id.ref,
			Рез.Оприходование);			
			
		КонецЦикла;	
		
		Возврат  Рез;
		   
	Исключение
		т = ОписаниеОшибки();
		мЛоггер.ерр("Плагин: Плагин_RabbitMQ_импорт_из_УПП_Документ_ОприходованиеТоваров . Подробности: " + т);
		
		//    ОБЯЗАТЕЛЬНО!!! Потому что в оркестраторе вызов плагина в попытке. и если была ошибка, надо сделать BasicReject()
		ВызватьИсключение т;
		
	КонецПопытки;

	
КонецФункции

#КонецОбласти 	

#Область СлужебныеЗаполненияИПолученияСсылок

Функция ПолучитьСкладERP(СкладУПП) 

	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП КАК СкладУПП,
	|	КСП_ВидыОперацийПоСкладамУПП.СкладЕРП КАК СкладЕРП,
	|	КСП_ВидыОперацийПоСкладамУПП.Ссылка КАК Ссылка,
	|	КСП_ВидыОперацийПоСкладамУПП.ЛогикаОбработкиВШапке КАК ЛогикаОбработки
	|ИЗ
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП КАК КСП_ВидыОперацийПоСкладамУПП
	|ГДЕ
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП = &СкладУПП";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат СкладУПП;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.СкладЕРП;

КонецФункции

Функция ПолучитьЛогикуСклада(СкладУПП) 

	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	КСП_ВидыОперацийПоСкладамУПП.ЛогикаОбработкиВШапке КАК ЛогикаОбработки
	|ИЗ
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП КАК КСП_ВидыОперацийПоСкладамУПП
	|ГДЕ
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП = &СкладУПП";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.ЛогикаОбработки;

КонецФункции

Функция ЗаполненаСсылка(СтруктураID) 
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Ложь;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если ЗначениеЗаполнено(Ref) Тогда
			Возврат Истина;
		КонецЕсли;
	Исключение
		Возврат Ложь;
	КонецПопытки;
КонецФункции

Функция ПолучитьСсылкуДокументаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
			Возврат Неопределено;
		КонецЕсли;
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	ДанныеСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	Возврат ДанныеСсылка;
КонецФункции

Функция ПолучитьСсылкуСправочникаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	ГУИД = "";
	Если СтруктураID.Свойство("Ref", ГУИД) Тогда
		Возврат Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции


// Ищет Вид операции по складу по
//- складу УПП в шапке
//- складу хранения в ТЧ Получатели
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: спр Виды операций по складам УПП
//
Функция Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП_Получатели(СкладУПП)
	
	МассивОперацийПоСкладу = Новый массив;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ТЧ.Ссылка как ВидОперацииПоСкладу
	|ИЗ 
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП.Получатели КАК ТЧ
	|	left join Справочник.КСП_ВидыОперацийПоСкладамУПП КАК шапка
	|	ПО шапка.ссылка = ТЧ.ссылка
	|ГДЕ 
	|	1=1
	|	И Шапка.СкладУПП = &СкладУПП
	|   И Шапка.Отключено = ЛОЖЬ
	|
	|";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат МассивОперацийПоСкладу;
	КонецЕсли;
	
	Рез = Неопределено;
	сч = 0;
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		Рез = Выборка.ВидОперацииПоСкладу;
		МассивОперацийПоСкладу.Добавить(Рез);
		сч = сч + 1;
	КонецЦикла;

	
	Возврат МассивОперацийПоСкладу;
	
КонецФункции



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиВидДокументаУПП(ВидДокумента)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ТТ.Ссылка КАК ВидДок
		|ИЗ
		|	Справочник.КСП_ВидыДокументовУПП КАК ТТ
		|ГДЕ
		|	
		|	ТТ.Наименование = &ВидДокумента";
	
	Запрос.УстановитьПараметр("ВидДокумента", ВидДокумента);
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		ВызватьИсключение "Не найден вид документа УПП в спр. видов документов: "+Строка(ВидДокумента);
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	ВидДок = Неопределено;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ВидДок = ВыборкаДетальныеЗаписи.ВидДок;
	КонецЦикла;
	
		
	Возврат ВидДок;
	
КонецФункции

// Версия 2024-03-19
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: спр ссылка КСП_ЛогикаОбработкиДвиженияПоСкладуУПП
//
Функция НайтиЛогикуПоВидуДокумента(ВидОперации, СкладХраненияУПП, ВидДокументаУППСсылка)
	
	ЛогикаОбработки = Неопределено;
	
	//ЕНС. Найти все строки, где есть искомый вид документа в "логике" (там это ТЧ ОбработчикиТиповДокументов)
	// Если это одна строка - возвращаем логику
	// Если больше одной - ищем в них склад хранения УПП
	
	МассивСтрокПолучателей = Новый Массив;   // строки ТЧ Получатели
	
	Для каждого стрк Из ВидОперации.Получатели Цикл
		Если НЕ ЗначениеЗаполнено(стрк.ЛогикаОбработкиВТЧ) Тогда
			Продолжить;
		КонецЕсли;
		
		Для каждого стркЛогика Из стрк.ЛогикаОбработкиВТЧ.ОбработчикиТиповДокументов Цикл
			Если стркЛогика.ВидДокументаУПП = ВидДокументаУППСсылка Тогда
				МассивСтрокПолучателей.Добавить(стрк);
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;

	Если МассивСтрокПолучателей.Количество() = 1 Тогда
		Возврат МассивСтрокПолучателей[0].ЛогикаОбработкиВТЧ;
	КонецЕсли;
	
	// если нашли более 1 строки в ТЧ Получатели - ищем нужную по складу хранения УПП
	
	Для каждого стрк Из МассивСтрокПолучателей Цикл
		Если стрк.СкладХраненияУПП = СкладХраненияУПП Тогда
			Возврат стрк.ЛогикаОбработкиВТЧ;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;

КонецФункции      

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаОбработки, ВидДокументаУППСсылка)
	
	Для каждого стркОбработчик Из ЛогикаОбработки.ОбработчикиТиповДокументов Цикл
		
		Если стркОбработчик.ВидДокументаУПП = ВидДокументаУППСсылка Тогда
			
			Возврат стркОбработчик.СсылкаНаДопОбработку;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;

КонецФункции 


#КонецОбласти

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
	
	Если Свойство = "Date" Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период" Тогда
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
	мРеквизиты.Добавить("Склад");
	мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции

 Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции

мВнешняяСистема = "UPP";
 ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
 