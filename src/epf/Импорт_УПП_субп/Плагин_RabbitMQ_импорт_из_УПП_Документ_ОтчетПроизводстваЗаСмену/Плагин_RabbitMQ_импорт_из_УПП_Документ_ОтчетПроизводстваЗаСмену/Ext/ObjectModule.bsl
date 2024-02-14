﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.12");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетПроизводстваЗаСмену");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетПроизводстваЗаСмену");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетПроизводстваЗаСмену",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетПроизводстваЗаСмену",
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
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ОтчетПроизводстваЗаСмену") Тогда
		Возврат Неопределено;
	КонецЕсли;

	ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	сообщить(деф.date);
	
	ПредставлениеДокументаУПП 			= "ОтчетПроизводстваЗаСмену №"+деф.Number+" от "+строка(деф.Date);
	
	СкладУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.Склад, "КСП_СкладыУПП");
	СкладХраненияУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладХранения, "КСП_СкладыХраненияУПП");
	
	// детализируем поиск до склада хранения и вида документа
	// ищем в ТЧ Получатели
	
	
	// здесь так детально ищем "логику", потому что нужно писать ошибки в "лог"
	
	ВидДокументаУППСсылка = НайтиВидДокументаУПП(СтруктураОбъекта.type);
	
	// ищем элемент спр Виды операций. Там может быть несколько строк со складом хранения в ТЧ Получатели
	МассивВидОперацииПоСкладу = Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП_Получатели(
		СкладУПП, СкладХраненияУПП); 
		
	//Если НЕ ЗначениеЗаполнено(ВидОперацииПоСкладу) Тогда
	Если МассивВидОперацииПоСкладу.Количество() = 0 Тогда
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= СкладУПП;
		СкладОтправитель 	= Неопределено;
		СкладПолучатель 	= Неопределено;
		ТекстСообщения 		= "Не найден вид операции по складу в шапке и складу хранения в ТЧ Получатели! Склад: "+строка(СкладУПП)+", Склад хранения: "+строка(СкладХраненияУПП);
		ЛогикаСклад			= Неопределено;
		ЛогикаПеремещения 	= Неопределено;
		Обработчик 			= Неопределено;
	НомерДокумента = деф.Number;
	ДатаДокумента = деф.Date;
	ОшибкаИсправлена = Ложь;
	ГУИДДокументаУПП = id.ref;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			НомерДокумента,
	ДатаДокумента,
	ОшибкаИсправлена,
	ГУИДДокументаУПП
);

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
	НомерДокумента = деф.Number;
	ДатаДокумента = деф.Date;
	ОшибкаИсправлена = Ложь;
	ГУИДДокументаУПП = id.ref;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
				НомерДокумента,
	ДатаДокумента,
	ОшибкаИсправлена,
	ГУИДДокументаУПП
);

			//Возврат Неопределено;
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
	НомерДокумента = деф.Number;
	ДатаДокумента = деф.Date;
	ОшибкаИсправлена = Ложь;
	ГУИДДокументаУПП = id.ref;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
				НомерДокумента,
	ДатаДокумента,
	ОшибкаИсправлена,
	ГУИДДокументаУПП
);

			//Возврат Неопределено;
			продолжить;
		КонецЕсли;
		
		// создание объекта из эл спр "Доп отчеты и обработки"
		ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(СсылкаОбработчика);
		ОбъектОбработчика = ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(СсылкаОбработчика);
		
		Если ОбъектОбработчика = Неопределено Тогда
			ВызватьИсключение "Не удалось подключить внешнюю обработку!";
			
		КонецЕсли;
		
		// запуск импорта
		
		Попытка
			СсылкаНаДокумент = ОбъектОбработчика.ЗагрузитьОбъект(
			
				СтруктураОбъекта,
				"",
				ВидОперацииПоСкладу.СкладЕРП
			
			);
		Исключение
			т = ОписаниеОшибки();
		    Сообщить(НСтр("ru = '"+т+"'"), СтатусСообщения.Внимание);  
			
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= СкладУПП;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "субПлагин найден, но выдал ошибку: "+т;
			ЛогикаПеремещения 	= Неопределено;
			ЛогикаСклад 		= ЛогикаОбработки;
			Обработчик 			= СсылкаОбработчика;
	НомерДокумента = деф.Number;
	ДатаДокумента = деф.Date;
	ОшибкаИсправлена = Ложь;
	ГУИДДокументаУПП = id.ref;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			
	НомерДокумента,
	ДатаДокумента,
	ОшибкаИсправлена,
	ГУИДДокументаУПП
			);
			
			Продолжить;
		КонецПопытки;
		
	КонецЦикла;	
	
	Возврат  Неопределено;
	
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
	Попытка
		Ref = СтруктураID.Ref;	
		Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
			Возврат Неопределено;
		КонецЕсли;
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	Если НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных) Тогда
		ОбъектДанных = Справочники[ВидОбъекта].СоздатьЭлемент();
		СсылкаНового = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		Попытка
			ОбъектДанных.Код = СтруктураID.code;
		Исключение
		КонецПопытки;
		Попытка
			ОбъектДанных.Наименование = СтруктураID.Description;
		Исключение
		КонецПопытки;
		ОбъектДанных.ОбменДанными.Загрузка = Истина;
		ОбъектДанных.Записать();
		Возврат СсылкаНового;
	Иначе
		Возврат ДанныеСсылка;
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
Функция Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП_Получатели(СкладУПП, СкладХраненияУПП)
	
	
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	Запрос.УстановитьПараметр("СкладХраненияУПП", СкладХраненияУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ТЧ.Ссылка как ВидОперацииПоСкладу
	|
	|ИЗ 
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП.Получатели КАК ТЧ
	|	left join Справочник.КСП_ВидыОперацийПоСкладамУПП КАК шапка
	|	ПО шапка.ссылка = ТЧ.ссылка
	|ГДЕ 
	|	ТЧ.СкладХраненияУПП = &СкладХраненияУПП
	|	И шапка.СкладУПП = &СкладУПП
	|   И Шапка.Отключено = ЛОЖЬ
	|
	|
	|
	|
	|
	|
	|
	|
	|
	|";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Новый массив;
	КонецЕсли;
	
	
	МассивОперацийПоСкладу = Новый массив;	
	Рез = Неопределено;
	сч = 0;
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		Рез = Выборка.ВидОперацииПоСкладу;
		МассивОперацийПоСкладу.Добавить(Рез);
		сч = сч + 1;
	КонецЦикла;
	
	
	Если сч > 1 Тогда
		
		т = "";
		Для сч = 0 По МассивОперацийПоСкладу.Количество() - 1 Цикл
			
			т = т + строка(МассивОперацийПоСкладу[сч])+" код "+МассивОперацийПоСкладу[сч].Код+", ";
			
		КонецЦикла;
		//ВызватьИсключение "Найдено более одного вида операции по складу! Список операций: "+т;
	КонецЕсли;
	
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

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиЛогикуПоВидуДокумента(ВидОперации, СкладХраненияУПП, ВидДокументаУППСсылка)
	
	ЛогикаОбработки = Неопределено;
	
	Для каждого стрк Из ВидОперации.ПОлучатели Цикл
		
		Если НЕ стрк.СкладХраненияУПП = СкладХраненияУПП Тогда
			Продолжить;
		КонецЕсли;
		
		ТекущаяЛогика = стрк.ЛогикаОбработкиВТЧ;
		
		Для каждого стркОбработчик Из ТекущаяЛогика.ОбработчикиТиповДокументов Цикл
			
			Если стркОбработчик.ВидДокументаУПП = ВидДокументаУППСсылка Тогда
				
				Возврат ТекущаяЛогика;
				
			КонецЕсли;
			
		КонецЦикла;
		
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
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		
		Для каждого эл Из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(эл);
		КонецЦикла;
		
	Иначе 
		ЗагрузитьОбъект(СтруктураОбъекта);
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

 мВнешняяСистема = "UPP";
 
 