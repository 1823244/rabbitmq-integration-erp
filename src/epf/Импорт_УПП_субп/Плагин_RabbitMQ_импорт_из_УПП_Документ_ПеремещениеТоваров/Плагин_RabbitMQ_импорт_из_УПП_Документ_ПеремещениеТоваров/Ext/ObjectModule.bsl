﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.3");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров",
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
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ПеремещениеТоваров") Тогда
		Возврат Неопределено;
	КонецЕсли;

	ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ПредставлениеДокументаУПП 			= "Перемещение товаров №"+деф.Number+" от "+строка(деф.Date);
	
	// поиск ссылки на эл спр "Доп отчеты и обработки"
	//СсылкаОбработчика = ксп_ИмпортСлужебный.ПолучитьСсылкаНаДопОбработкуПеремещение( деф );
	
	
	СкладОтправительУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладОтправитель, "КСП_СкладыУПП");
	
	СкладПолучательУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладПолучатель, "КСП_СкладыУПП");
	
	// здесь так детально ищем "логику", потому что нужно писать ошибки в "лог"
	ВидОперацииПоСкладу = Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП(СкладОтправительУПП);
	
	// ищем склад в ТЧ Получатели
	СтрокаТЧ = НайтиПолучателяВТЧПолучатели( ВидОперацииПоСкладу , СкладПолучательУПП); // это строка ТЧ
	
	Если НЕ ЗначениеЗаполнено(СтрокаТЧ) Тогда
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= СкладОтправительУПП;
		СкладПолучатель 	= СкладПолучательУПП;
		ТекстСообщения 		= "Не найден склад-получатель в ТЧ вида операции! Вид операции по складу: "+строка(ВидОперацииПоСкладу);
		ЛогикаСклад			= Неопределено;
		ЛогикаПеремещения 	= Неопределено;
		Обработчик 			= Неопределено;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП);

		Возврат Неопределено;
	КонецЕсли;
	
	
	ЛогикаПеремещения = СтрокаТЧ.ЛогикаОбработкиВТЧ;
	
	Если НЕ ЗначениеЗаполнено(ЛогикаПеремещения) Тогда
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= СкладОтправительУПП;
		СкладПолучатель 	= СкладПолучательУПП;
		ТекстСообщения 		= "Не найдена логика обработки! Вид операции по складу: "+строка(ВидОперацииПоСкладу);
		ЛогикаСклад			= Неопределено;
		ЛогикаПеремещения 	= ЛогикаПеремещения;
		Обработчик 			= Неопределено;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП);

		Возврат Неопределено;
	КонецЕсли;

	ВидДокументаУППСсылка = НайтиВидДокументаУПП(СтруктураОбъекта.type);
	
	Если НЕ ЗначениеЗаполнено(ВидДокументаУППСсылка) Тогда
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= СкладОтправительУПП;
		СкладПолучатель 	= СкладПолучательУПП;
		ТекстСообщения 		= "Не найден вид документа в Справочнике ВидыДокументовУПП! Вид документа : "+строка(СтруктураОбъекта.type);
		ЛогикаСклад			= Неопределено;
		ЛогикаПеремещения 	= ЛогикаПеремещения;
		Обработчик 			= Неопределено;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП);

		Возврат Неопределено;
		
	КонецЕсли;
	
	СсылкаОбработчика = НайтиЛогикуВТЧПоВидуДокументаУПП(ЛогикаПеремещения, ВидДокументаУППСсылка);
	
	Если НЕ ЗначениеЗаполнено(СсылкаОбработчика) Тогда
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= СкладОтправительУПП;
		СкладПолучатель 	= СкладПолучательУПП;
		ТекстСообщения 		= "Не найден субплагин в ТЧ элемента логики! Логика обработки: "+строка(ЛогикаПеремещения);
		ЛогикаСклад			= Неопределено;
		ЛогикаПеремещения 	= ЛогикаПеремещения;
		Обработчик 			= Неопределено;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП);

		Возврат Неопределено;
	КонецЕсли;
	
	// создание объекта из эл спр "Доп отчеты и обработки"
	ОбъектОбработчика = ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(СсылкаОбработчика);
	
	Если ОбъектОбработчика = Неопределено Тогда
		ВызватьИсключение "Не удалось подключить внешнюю обработку!";
		Возврат Неопределено;
	КонецЕсли;
	
	// запуск импорта
	
	СсылкаПеремещение = ОбъектОбработчика.ЗагрузитьОбъект(
	
		СтруктураОбъекта
		

	
	);
	
	
	Возврат  СсылкаПеремещение;
	
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


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП(СкладОтправительУПП)
	
	Рез = Справочники.КСП_ВидыОперацийПоСкладамУПП.НайтиПоРеквизиту("СкладУПП", СкладОтправительУПП);
	Возврат Рез;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: строка ТЧ Получатели справочника КСП_ВидыОперацийПоСкладамУПП
//
Функция НайтиПолучателяВТЧПолучатели( ВидОперацииПоСкладу , СкладПолучательУПП)
	
	СтрокаТЧ = ВидОперацииПоСкладу.Получатели.Найти(СкладПолучательУПП, "Склад");
	Возврат СтрокаТЧ;
	
		
КонецФункции

// Параметры
//	ВидДокументаСтрока - строка - из СтруктураОбъекта.type
//
Функция НайтиВидДокументаУПП(ВидДокументаСтрока)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ТТ.Ссылка КАК субПлагин
		|ИЗ
		|	Справочник.КСП_ВидыДокументовУПП КАК ТТ
		|ГДЕ
		|	
		|	ТТ.Наименование = &ВидДокумента";
	
	Запрос.УстановитьПараметр("ВидДокумента", ВидДокументаСтрока);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
КонецФункции  

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиЛогикуВТЧПоВидуДокументаУПП(ЛогикаПеремещения, ВидДокументаУППСсылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ТЧ.СсылкаНаДопОбработку КАК субПлагин
		|ИЗ
		|	Справочник.КСП_ЛогикаОбработкиДвиженияПоСкладуУПП.ОбработчикиТиповДокументов КАК ТЧ
		|ГДЕ
		|	ТЧ.Ссылка = &ЛогикаПеремещения
		|	И ТЧ.ВидДокументаУПП = &ВидДокументаУППСсылка";
	
	Запрос.УстановитьПараметр("ВидДокументаУППСсылка", ВидДокументаУППСсылка);
	Запрос.УстановитьПараметр("ЛогикаПеремещения", ЛогикаПеремещения);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.субПлагин;
	КонецЦикла;
	
КонецФункции      

#Область ПолучениеВнешнейОбработкиПоИмени

Функция ПолучитьОбъектВнешнейОбработкиПоНаименованию(Наименование)
	ТекСсылка = Справочники.ДополнительныеОтчетыИОбработки.НайтиПоНаименованию(Наименование);
	Если не ЗначениеЗаполнено(ТекСсылка) Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(ТекСсылка);
	Возврат ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(ТекСсылка);
КонецФункции

Функция ПолучитьОбъектВнешнейОбработкиПоСсылке(ТекСсылка)
	Если не ЗначениеЗаполнено(ТекСсылка) Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(ТекСсылка);
	Возврат ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(ТекСсылка);
КонецФункции

#КонецОбласти


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
 
 