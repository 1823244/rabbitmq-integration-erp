﻿Перем мВнешняяСистема;
Перем мЛоггер;
Перем мИдВызова;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.10");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетОРозничныхПродажах");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетОРозничныхПродажах");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетОРозничныхПродажах",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетОРозничныхПродажах",
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
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ОтчетОРозничныхПродажах") Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
		
		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;
		
		ПредставлениеДокументаУПП 			= "ОтчетОРозничныхПродажах №"+деф.Number+" от "+строка(деф.Date);
		
		СкладУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.Склад, "КСП_СкладыУПП");
		СкладХраненияУПП = Неопределено;
		ВидДокументаУППСсылка = НайтиВидДокументаУПП(СтруктураОбъекта.type);
		МассивВидОперацииПоСкладу = Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП_Получатели(СкладУПП); 
		
		Если МассивВидОперацииПоСкладу.Количество() = 0 Тогда
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= СкладУПП;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Не найден вид операции по складу в шапке! Склад: "+строка(СкладУПП);
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			НомерДокумента 		= деф.Number;
			ДатаДокумента 		= деф.Date;
			ОшибкаИсправлена 	= Ложь;
			ГУИДДокументаУПП 	= id.ref;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
				ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
				НомерДокумента,
				ДатаДокумента,
				ОшибкаИсправлена,
				ГУИДДокументаУПП);
			
			Возврат Неопределено;
		КонецЕсли;
		
		Для каждого ВидОперацииПоСкладу Из МассивВидОперацииПоСкладу Цикл
			
			// ищем логику в строках ТЧ Получатели с 
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
				НомерДокумента 		= деф.Number;
				ДатаДокумента 		= деф.Date;
				ОшибкаИсправлена 	= Ложь;
				ГУИДДокументаУПП 	= id.ref;
				РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
				ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
				НомерДокумента,
				ДатаДокумента,
				ОшибкаИсправлена,
				ГУИДДокументаУПП);
				
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
				НомерДокумента 		= деф.Number;
				ДатаДокумента 		= деф.Date;
				ОшибкаИсправлена 	= Ложь;
				ГУИДДокументаУПП 	= id.ref;
				РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
				ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
				НомерДокумента,
				ДатаДокумента,
				ОшибкаИсправлена,
				ГУИДДокументаУПП);
				
				
				//Возврат Неопределено;
				продолжить;
			КонецЕсли;
			
			ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(СсылкаОбработчика);
			ОбъектОбработчика = ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(СсылкаОбработчика);
			
			Если ОбъектОбработчика = Неопределено Тогда
				ВызватьИсключение "Не удалось подключить внешнюю обработку!";			
			КонецЕсли;
			
			// запуск импорта
			
            Попытка        
                СсылкаНаДокумент = ОбъектОбработчика
                        .сетИдВызова(мИдВызова)
                        .ЗагрузитьОбъект(СтруктураОбъекта,"",ВидОперацииПоСкладу.СкладЕРП);
            Исключение
                т = НСтр("ru = '"+ОписаниеОшибки()+"'");
                Сообщить(т, СтатусСообщения.Внимание);
                мЛоггер.ерр("Ошибка при обработке вида операции: "+Строка(ВидОперацииПоСкладу)+
				". Переходим к следующему (если их больше одного). Подробности ошибки: "+т+
				Символы.ПС+
				"Субплагин: "+строка(СсылкаОбработчика)+
				Символы.ПС+
				"Субплагин ГУИД: "+строка(СсылкаОбработчика.УникальныйИдентификатор())
				
				
				);
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
			СсылкаНаДокумент);				
			
		КонецЦикла;	     // Цикл обхода МассивВидОперацииПоСкладу
		
		Возврат СсылкаНаДокумент;
		
	Исключение
		т = ОписаниеОшибки();
		мЛоггер.ерр("Плагин: Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетОРозничныхПродажах . Подробности: " + т);
		
		//    ОБЯЗАТЕЛЬНО!!! Потому что в оркестраторе вызов плагина в попытке. и если была ошибка, надо сделать BasicReject()
		ВызватьИсключение т;
		
	КонецПопытки;
	
КонецФункции

#КонецОбласти 	

#Область СлужебныеЗаполненияИПолученияСсылок

Функция ПолучитьСсылкаНаДопОбработку(id,деф,СтруктураОбъекта,jsonText)
	Ответ = Новый Структура;
	СкладОтправительУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладОтправитель, "КСП_СкладыУПП");
	СкладПолучательУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладПолучатель, "КСП_СкладыУПП");
	Если ЗначениеЗаполнено(СкладОтправительУПП) и ЗначениеЗаполнено(СкладПолучательУПП) Тогда
		ЛогикаОбработкиСкладОтправительУПП = ПолучитьЛогикуСклада(СкладОтправительУПП);
		ЛогикаОбработкиСкладПолучательУПП = ПолучитьЛогикуСклада(СкладПолучательУПП);
		Если ЗначениеЗаполнено(ЛогикаОбработкиСкладОтправительУПП) и ЗначениеЗаполнено(ЛогикаОбработкиСкладПолучательУПП) Тогда
			Запрос = Новый Запрос;
			Запрос.УстановитьПараметр("ЛогикаСкладПолучатель", ЛогикаОбработкиСкладПолучательУПП);
			Запрос.УстановитьПараметр("ЛогикаСкладОтправитель", ЛогикаОбработкиСкладОтправительУПП);
			Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
				|	КСП_ЛогикаОбработкиПеремещений.СсылкаНаДопОбработку КАК СсылкаНаДопОбработку
				|ИЗ
				|	Справочник.КСП_ЛогикаОбработкиПеремещений КАК КСП_ЛогикаОбработкиПеремещений
				|ГДЕ
				|	КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладОтправитель = &ЛогикаСкладОтправитель
				|	И КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладПолучатель = &ЛогикаСкладПолучатель";

			Результат = Запрос.Выполнить();
			Если Результат.Пустой() Тогда
				Возврат Неопределено;
			КонецЕсли;
			Выборка = Результат.Выбрать();
			Выборка.Следующий();
			Возврат Выборка.СсылкаНаДопОбработку;
		Иначе
			Возврат Неопределено;	
		КонецЕсли;
	Иначе
		Возврат Неопределено;
	КонецЕсли;	
КонецФункции

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
	//++ Задача 18036 Оздьон ЕВ 13.03.2024  
	ГУИД = "";
	Если СтруктураID.Свойство("Ref", ГУИД) Тогда
		Возврат Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	//-- Задача 18036

	//Попытка
	//	Ref = СтруктураID.Ref;	
	//	Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
	//		Возврат Неопределено;
	//	КонецЕсли;
	//Исключение
	//	Возврат Неопределено;
	//КонецПопытки;
	//ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	//Если НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных) Тогда
	//	ОбъектДанных = Справочники[ВидОбъекта].СоздатьЭлемент();
	//	СсылкаНового = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	//	ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	//	Попытка
	//		ОбъектДанных.Код = СтруктураID.code;
	//	Исключение
	//	КонецПопытки;
	//	Попытка
	//		ОбъектДанных.Наименование = СтруктураID.Description;
	//	Исключение
	//	КонецПопытки;
	//	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	//	ОбъектДанных.Записать();
	//	Возврат СсылкаНового;
	//Иначе
	//	Возврат ДанныеСсылка;
	//КонецЕсли; 
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
	
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ТЧ.Ссылка как ВидОперацииПоСкладу
	|
	|ИЗ 
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП.Получатели КАК ТЧ
	|	left join Справочник.КСП_ВидыОперацийПоСкладамУПП КАК шапка
	|	ПО шапка.ссылка = ТЧ.ссылка
	|ГДЕ 
	|	шапка.СкладУПП = &СкладУПП
	|   И Шапка.Отключено = ЛОЖЬ
	|   И Шапка.ПометкаУдаления = ЛОЖЬ
	|";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат МассивОперацийПоСкладу;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		МассивОперацийПоСкладу.Добавить(Выборка.ВидОперацииПоСкладу);
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

// ЕНС. todo. Перенести в общий модуль ксп_ИмпортСлужебный
Функция ПолучитьСсылкаНаЛогикуПеремещения(ЛогикаОбработкиСкладОтправительУПП,
		ЛогикаОбработкиСкладПолучательУПП)
		
		Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ЛогикаСкладПолучатель", ЛогикаОбработкиСкладПолучательУПП);
	Запрос.УстановитьПараметр("ЛогикаСкладОтправитель", ЛогикаОбработкиСкладОтправительУПП);
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	КСП_ЛогикаОбработкиПеремещений.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.КСП_ЛогикаОбработкиПеремещений КАК КСП_ЛогикаОбработкиПеремещений
		|ГДЕ
		|	КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладОтправитель = &ЛогикаСкладОтправитель
		|	И КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладПолучатель = &ЛогикаСкладПолучатель";

	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.Ссылка;
КонецФункции

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




Функция ЗагрузитьИзJsonНаСервереИзФайла(Адрес) export

	
	
	ДвоичныеДанные  = ПолучитьИзВременногоХранилища(Адрес);
	Если 1=0 Тогда
		ДвоичныеДанные = новый ДвоичныеДанные("");
	КонецЕсли;                                
	
	ИмяФайла = ПолучитьИмяВременногоФайла("json");
	ДвоичныеДанные.Записать(ИмяФайла);
	
	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.ОткрытьФайл(ИмяФайла);
	
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		Для Каждого эл из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(эл);
		КонецЦикла;
	Иначе
	    Возврат ЗагрузитьОбъект(СтруктураОбъекта);
	КонецЕсли;
	
	Возврат Неопределено;
	
	
	
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
	мРеквизиты.Добавить("СкладОтправитель");
	мРеквизиты.Добавить("СкладПолучатель");
	мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции

Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции

 мВнешняяСистема = "UPP";
 
 