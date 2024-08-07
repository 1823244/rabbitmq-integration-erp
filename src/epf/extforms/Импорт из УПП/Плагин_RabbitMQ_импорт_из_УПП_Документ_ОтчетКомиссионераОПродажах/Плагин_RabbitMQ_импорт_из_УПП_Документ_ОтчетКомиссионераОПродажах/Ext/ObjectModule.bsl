﻿
Перем НЕ_ЗАГРУЖАТЬ;
Перем СОЗДАТЬ;
Перем ОБНОВИТЬ;
Перем ОТМЕНИТЬ_ПРОВЕДЕНИЕ;

Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем СобиратьНенайденнуюНоменклатуру Экспорт;
Перем НеНайденнаяНоменклатураМассив;

Перем мЛоггер;
Перем мИдВызова;


#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.8");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах",
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


Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "", СкладЕРП = Неопределено) Экспорт
	
	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт документов из УПП: Отчет комиссионера о продажах");
	
	Попытка
		
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда
			//мЛоггер.Варн("Нет свойства type в сообщении! Объект не загружен.");
			Возврат Неопределено;
		КонецЕсли;
		
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ОтчетКомиссионераОПродажах") Тогда
			//мЛоггер.Варн("type не равен 'Документ.ОтчетКомиссионераОПродажах' ! Объект не загружен.");
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;
		
		Результат = СоздатьДокументыПоСхеме(СтруктураОбъекта, jsonText, СкладЕРП);
		
		//*************************** Экспорт ненайденной номенклатуры ****************
		Если НеНайденнаяНоменклатураМассив.Количество() > 0 Тогда
			Попытка
				ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовНоменклатуры(НеНайденнаяНоменклатураМассив);
				мЛоггер.инфо("Выполнен экспорт ненайденной номенклатуры - " +
				Строка(НеНайденнаяНоменклатураМассив.Количество()) + " позиций");
			Исключение
				ТекстОшибки = ОписаниеОшибки();
				ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение,,,
				"Ошибка экспорта ненайденной номенклатуры в УПП. Подробности: "+ТекстОшибки);
				
				мЛоггер.инфо("Ошибка экспорта ненайденной номенклатуры в УПП.
				|Подробности: "+ТекстОшибки);
				
			КонецПопытки;
		КонецЕсли;
		//***************************
		
		Возврат Результат;
		
	Исключение
		
		ТекстОшибки = ОписаниеОшибки();
		мЛоггер.ерр("Плагин: Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетКомиссионераОПродажах .
			|Подробности: "+ТекстОшибки);
		ВызватьИсключение ТекстОшибки;
		
	КонецПопытки;
	
КонецФункции


#Область Схема_1

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: структура
//
Функция СоздатьДокументыПоСхеме(СтруктураОбъекта, jsonText, СкладЕРП)
	
	Результат = Новый Структура;
	Результат.Вставить("ОтчетКомиссионера", Неопределено);
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ПредставлениеДокументаИзУПП = "ОтчетКомиссионераОПродажах № "+строка(деф.number)+" от "+Строка(деф.date);
	
	ВидОбъекта = "ОтчетКомиссионера";
	
	СуществующийДокСсылка = СоздатьПолучитьСсылкуДокумента(id.Ref, "ОтчетКомиссионера");
	
	Если ЗначениеЗаполнено(СуществующийДокСсылка.ВерсияДанных) Тогда
		ЭтоНовый = Ложь;
	Иначе   
		ЭтоНовый = Истина;
	КонецЕсли;
	
	// -------------------------------------------- БЛОКИРОВКА
	
	Если НЕ ЭтоНовый Тогда
		МассивСсылок = Новый Массив;
		МассивСсылок.Добавить(СуществующийДокСсылка);
		Блокировка = ксп_Блокировки.СоздатьБлокировкуНесколькихОбъектов(МассивСсылок);
	КонецЕсли;
	
	НачатьТранзакцию();
	
	Если НЕ ЭтоНовый Тогда
		Попытка
			
			Блокировка.Заблокировать();
			
		Исключение
			
			СообщениеОбОшибке = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
				"Объект не загружен! Ошибка блокировки цепочки документов для "+ПредставлениеДокументаИзУПП+".
				|Подробности: "+СообщениеОбОшибке);
			ОтменитьТранзакцию();
			
			мЛоггер.ерр("Ошибка загрузки документа (УПП): %1. 
				|Подробности: %2", ПредставлениеДокументаИзУПП, СообщениеОбОшибке);
			
			ВызватьИсключение;
			
		КонецПопытки;
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	Попытка
		
		Действие = ДействиеСДокументом(ЭтоНовый, СуществующийДокСсылка, деф);
		Если Действие = НЕ_ЗАГРУЖАТЬ Тогда
			ОтменитьТранзакцию();                                             
			мЛоггер.инфо("Действие = НЕ Загружать. Документ пропущен: %1", ПредставлениеДокументаИзУПП);
			Результат.Вставить("ОтчетКомиссионера", СуществующийДокСсылка);
			Возврат Результат;
		КонецЕсли;
		
		Если Действие = ОТМЕНИТЬ_ПРОВЕДЕНИЕ Тогда
			ОбъектДанных = СуществующийДокСсылка.ПолучитьОбъект();
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
			ЗафиксироватьТранзакцию();
			мЛоггер.инфо("Действие = Отменить проведение. Документ: %1", ПредставлениеДокументаИзУПП);
			Результат.Вставить("ОтчетКомиссионера", СуществующийДокСсылка);
			Возврат Результат;
		КонецЕсли;
		
		Если Действие = ОБНОВИТЬ Тогда
			ОбъектДанных = СуществующийДокСсылка.ПолучитьОбъект();
			мЛоггер.инфо("Действие = Обновить. Документ будет обновлен: %1", ПредставлениеДокументаИзУПП);
		ИначеЕсли Действие = СОЗДАТЬ Тогда
			ОбъектДанных = Документы.ОтчетКомиссионера.СоздатьДокумент();
			СсылкаНового = Документы.ОтчетКомиссионера.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
			мЛоггер.инфо("Действие = Создать. Документ будет создан: %1", ПредставлениеДокументаИзУПП);
		Иначе 
			ОтменитьТранзакцию();
			ТекстСообщения = "Действие = Неизвестое действие: "+Строка(Действие)+". Документ: " + ПредставлениеДокументаИзУПП;
			мЛоггер.ерр(ТекстСообщения);
			ВызватьИсключение ТекстСообщения;
			
		КонецЕсли;
		
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		
		ЗаполнитьРеквизиты(СтруктураОбъекта, ОбъектДанных, jsonText);
		
		//// ЕНС. Используем типовые механизны для дозаполнения документа
		////ТЧ видыЗапасов заполняется сама из ПриЗаписи
		Попытка
			Отказ = Ложь;
			ТаблицыДокумента = Документы.ОтчетКомиссионера.КоллекцияТабличныхЧастейТоваров();
			ТаблицыДокумента.Товары = ОбъектДанных.Товары;
			ОбъектДанных.ЗаполнитьВидыЗапасовПриОбмене(Отказ, ТаблицыДокумента);
		Исключение
			ТекстОшибки = ОписаниеОшибки();
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Ошибка,,,ТекстОшибки);
			мЛоггер.ерр("Не получилось ЗаполнитьВидыЗапасовПриОбмене: %1", ПредставлениеДокументаИзУПП);
		КонецПопытки;
		
		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.ДополнительныеСвойства.Вставить("НеРегистрироватьКОбменуRabbitMQ", Истина);
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		Иначе 
			ОбъектДанных.Записать();
		КонецЕсли;
		
		// Документ будет помещен в Отложенное проведение
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		
		ЗафиксироватьТранзакцию();
		
		мЛоггер.инфо("Записан Документ : %1. Исходный док. УПП: %2", ОбъектДанных, ПредставлениеДокументаИзУПП);
		
		Результат.Вставить("ОтчетКомиссионера", ОбъектДанных.Ссылка);
		
	Исключение
		
		СообщениеОбОшибке = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка, , ,
			"Объект не загружен! Ошибка в процессе загрузки объекта: "+ПредставлениеДокументаИзУПП+".
			|Подробности: " + СообщениеОбОшибке);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		мЛоггер.ерр("Ошибка загрузки документа (УПП): %1.
			|Подробности: %2", ПредставлениеДокументаИзУПП, СообщениеОбОшибке);
		
		ВызватьИсключение;
		
	КонецПопытки;
	
	//ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовНоменклатуры( НеНайденнаяНоменклатураМассив );
	
	Если Результат.ОтчетКомиссионера = Неопределено Тогда
		
		//НЕ успешно
		
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= Неопределено;
		СкладПолучатель 	= Неопределено;
		ТекстСообщения 		= "Ошибка загрузки (без субплагина): "+СообщениеОбОшибке;
		ЛогикаПеремещения 	= Неопределено;
		ЛогикаСклад 		= Неопределено;
		Обработчик 			= Неопределено;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
			ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаИзУПП,
			деф.Number,
			деф.date,
			Ложь, // ошибки исправлены
			Id.ref);
		
	Иначе
		
		//успешно
		
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= Неопределено;
		СкладПолучатель 	= Неопределено;
		ТекстСообщения 		= "Успешно загружен (без субплагина)";
		ЛогикаПеремещения 	= Неопределено;
		ЛогикаСклад 		= Неопределено;
		Обработчик 			= Неопределено;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
			ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаИзУПП,
			деф.Number,
			деф.date,
			Истина, // ошибки исправлены
			Id.ref);
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Заполняет реквизиты объекта и пишет сопутствующие данные. Должна вызываться в транзакции.
Функция ЗаполнитьРеквизиты(СтруктураОбъекта, ОбъектДанных, jsonText = "") Экспорт
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	//------------------------------------- Заполнение реквизитов
	
	//ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	ОбъектДанных.Валюта = константы.ВалютаРегламентированногоУчета.Получить();
	ОбъектДанных.ВидыЗапасовУказаныВручную = Ложь;
	ОбъектДанных.ДатаВходящегоДокумента = деф.ДатаВходящегоДокумента;
	
	ОбъектДанных.Соглашение = ПолучитьСоглашение(ОбъектДанных.Организация);
	
	// заполнение договора зависит от соглашения
	Если ЗначениеЗаполнено(ОбъектДанных.Соглашение) Тогда
		Если ОбъектДанных.Соглашение.ИспользуютсяДоговорыКонтрагентов Тогда
			
			СпрДоговор = ксп_ИмпортСлужебный.НайтиДоговор(деф.ДоговорКонтрагента, деф.Контрагент);
			Если НЕ ЗначениеЗаполнено(СпрДоговор)
				ИЛИ (ТипЗнч(СпрДоговор) = Тип("СправочникСсылка.ДоговорыКонтрагентов")
				И НЕ ЗначениеЗаполнено(СпрДоговор.ВерсияДанных)) Тогда
				
				ПредставлениеДокументаИзУПП = "ОтчетКомиссионераОПродажах № "+строка(деф.number)+" от "+Строка(деф.date);
				
				ВидДокумента 		= СтруктураОбъекта.type;
				Склад 				= Неопределено;
				СкладОтправитель 	= Неопределено;
				СкладПолучатель 	= Неопределено;
				ТекстСообщения 		= "Не найден ДоговорыКонтрагентов УПП или это битая ссылка!
					|"+Строка(СпрДоговор);
				ЛогикаСклад			= Неопределено;
				ЛогикаПеремещения 	= Неопределено;
				Обработчик 			= Неопределено;
				РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель,
					ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаИзУПП,
					деф.Number,
					деф.date,
					Ложь,
					Id.ref);
				
				мЛоггер.Варн("Документ не загружен! Не найден ДоговорыКонтрагентов УПП:
					|%1
					|для документа :
					|%2",
					Строка(СпрДоговор), ПредставлениеДокументаИзУПП);
				
			КонецЕсли;
			
			ОбъектДанных.Договор = СпрДоговор;
			
		КонецЕсли;
	КонецЕсли;
	
	ОбъектДанных.Комментарий = "[УПП № " + Строка(деф.Number) + " от " + Строка(ОбъектДанных.Дата) + "] " + деф.Комментарий;
	
	ОбъектДанных.Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, МВнешняяСистема);
	ОбъектДанных.НалогообложениеНДС = перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
	
	ОбъектДанных.НомерВходящегоДокумента = деф.НомерВходящегоДокумента;
	ОбъектДанных.ОплатаВВалюте = Ложь;
	
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	ОбъектДанных.Партнер = ОбъектДанных.Контрагент.Партнер;//ксп_ИмпортСлужебный.НайтиПартнер(деф.Партнер);
	
	ОбъектДанных.Услуга = Справочники.Номенклатура.НайтиПоНаименованию("Услуга");
	
	ОбъектДанных.ПоРезультатамИнвентаризации = Ложь;
	ОбъектДанных.ПорядокРасчетов = ОбъектДанных.Договор.ПорядокРасчетов;
	ОбъектДанных.ПроцентВознаграждения = деф.ПроцентКомиссионногоВознаграждения;
	
	//мСпособРасчетаВознаграждения = деф.СпособРасчетаКомиссионногоВознаграждения;
	//Если ЗначениеЗаполнено(мСпособРасчетаВознаграждения) Тогда
	//	ОбъектДанных.СпособРасчетаВознаграждения = мСпособРасчетаВознаграждения;
	//Иначе
		ОбъектДанных.СпособРасчетаВознаграждения = Перечисления.СпособыРасчетаКомиссионногоВознаграждения.ПроцентОтСуммыПродажи;
	//КонецЕсли;
	
	Если ТипЗнч(деф.СтавкаНДСВознаграждения) = Тип("Структура") Тогда
		НайденноеПредставление = "";
		Если деф.СтавкаНДСВознаграждения.Свойство("Представление", НайденноеПредставление) Тогда
			Если ЗначениеЗаполнено(НайденноеПредставление) Тогда
				ОбъектДанных.СтавкаНДСВознаграждения = Справочники.СтавкиНДС.НайтиПоНаименованию(НайденноеПредставление);;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ОбъектДанных.СуммаВознаграждения = деф.СуммаВознаграждения;
	ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;
	ОбъектДанных.СуммаНДСВознаграждения = деф.СуммаНДСВознаграждения;
	
	ОбъектДанных.УдержатьВознаграждение = деф.УдержатьКомиссионноеВознаграждение;// булево
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ОтчетКомиссионера;
	ОбъектДанных.ЦенаВключаетНДС = деф.НДСВключенВСтоимость;
	
	
	//------------------------------------------------------     ТЧ Товары
	
	
	ОбъектДанных.Товары.Очистить();
	
	Склад = Неопределено;
	
	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();
		
		СтрокаТЧ.Количество = стрк.Количество;
		
		//СтрокаТЧ.КоличествоПоРНПТ = стрк.КоличествоПоРНПТ;
		
		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковокУчет = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковокФакт = стрк.Количество;
		
		//////////////////////////////////////////         НЕНАЙДЕННАЯ НОМЕНКЛАТУРА (НАЧАЛО)
		
		Если стрк.Номенклатура.Свойство("identification") Тогда
			// это полный объект номенклатуры.
			ТэгНоменклатуры = стрк.Номенклатура.identification;
		Иначе 
			ТэгНоменклатуры = стрк.Номенклатура;
		КонецЕсли;
		
		_Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(ТэгНоменклатуры);
		
		Если ТипЗнч(_Номенклатура) = Тип("СправочникСсылка.Номенклатура") И
			НЕ ЗначениеЗаполнено(_Номенклатура.ВерсияДанных) Тогда
			
			НомГУИД = "";
			Если ТэгНоменклатуры.Свойство("Ref", НомГУИД) Тогда
				Если НеНайденнаяНоменклатураМассив.Найти(НомГУИД) = Неопределено Тогда
					НеНайденнаяНоменклатураМассив.Добавить(НомГУИД);
				КонецЕсли;
			КонецЕсли;
			
		КонецЕсли;
		
		СтрокаТЧ.Номенклатура = _Номенклатура;
		
		///////////////////////////////////////////         НЕНАЙДЕННАЯ НОМЕНКЛАТУРА (КОНЕЦ)
		
		СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.ОпределитьСтавкуНДСПоПеречислениюУПП(стрк.СтавкаНДС);
		
		//СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;
		//"Сумма": "1438",
		//"СуммаВознаграждения": "193.74",
		//"СуммаНДС": "239.67",
		//"СуммаНДСВознаграждения": "32.29",
		//"СуммаНДСПередачи": "3366.5",
		//"СуммаПередачи": "20199",
		
		СтрокаТЧ.Сумма = стрк.Сумма;
		СтрокаТЧ.СуммаВознаграждения = стрк.СуммаВознаграждения;
		СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;
		СтрокаТЧ.СуммаНДСВознаграждения = стрк.СуммаНДСВознаграждения;
		СтрокаТЧ.СуммаПродажи = стрк.Сумма;
		СтрокаТЧ.СуммаПродажиНДС = стрк.СуммаНДС;
		СтрокаТЧ.СуммаСНДС = стрк.Сумма;
		
		СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиЕдиницуИзмерения(стрк.ЕдиницаИзмерения, стрк.Номенклатура);
		
		// ОК
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
		
		СтрокаТЧ.Цена = стрк.ЦенаПередачи;
		
		СтрокаТЧ.ЦенаПродажи = стрк.Сумма / стрк.Количество;
		
		// временно отключим, чтоы проверить внутренние механизмы заполнения
		//СтрокаТЧ.АналитикаУчетаНоменклатуры = ксп_ИмпортСлужебный
		//	.НайтиСоздатьКлючАналитикиНом(строкаТЧ.Номенклатура, Склад, строкаТЧ.Характеристика);
		
	КонецЦикла;
	
	
	////------------------------------------------------------     ТЧ ЭтапыГрафикаОплаты
	
	
	//ОбъектДанных.ЭтапыГрафикаОплаты.Очистить();
	
	//Для счТовары = 0 По деф.ТЧЭтапыГрафикаОплаты.Количество()-1 Цикл
	//	стрк = деф.ТЧЭтапыГрафикаОплаты[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ЭтапыГрафикаОплаты.Добавить();
	
	//	_знч = "";
	//	ЕстьЗначение = стрк.ВариантОплаты.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ВариантОплаты = стрк.ВариантОплаты.Значение;
	//	Иначе
	//		СтрокаТЧ.ВариантОплаты = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ВариантОплаты = ксп_ИмпортСлужебный.НайтиПеречисление_ВариантОплаты(стрк.ВариантОплаты);
	
	//	_знч = "";
	//	ЕстьЗначение = стрк.ВариантОтсчета.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ВариантОтсчета = стрк.ВариантОтсчета.Значение;
	//	Иначе
	//		СтрокаТЧ.ВариантОтсчета = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ВариантОтсчета = ксп_ИмпортСлужебный.НайтиПеречисление_ВариантОтсчета(стрк.ВариантОтсчета);
	
	//	СтрокаТЧ.ДатаПлатежа = стрк.ДатаПлатежа;
	//	СтрокаТЧ.ПроцентПлатежа = стрк.ПроцентПлатежа;
	//	СтрокаТЧ.Сдвиг = стрк.Сдвиг;
	
	//	СтрокаТЧ.СуммаВзаиморасчетов = стрк.СуммаВзаиморасчетов;
	//	СтрокаТЧ.СуммаПлатежа = стрк.СуммаПлатежа;
	
	//КонецЦикла;
	
	
	////------------------------------------------------------     ТЧ ВидыЗапасов
	
	
	//ОбъектДанных.ВидыЗапасов.Очистить();
	
	//Для счТовары = 0 По деф.ТЧВидыЗапасов.Количество()-1 Цикл
	//	стрк = деф.ТЧВидыЗапасов[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ВидыЗапасов.Добавить();
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.АналитикаУчетаНоменклатуры.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.АналитикаУчетаНоменклатуры = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.АналитикаУчетаНоменклатуры.Ref ) );
	//	Иначе
	//		СтрокаТЧ.АналитикаУчетаНоменклатуры = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.АналитикаУчетаНоменклатуры = ксп_ИмпортСлужебный.НайтиАналитикаУчетаНоменклатуры(стрк.АналитикаУчетаНоменклатуры);
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.ВидЗапасов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ВидЗапасов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ВидЗапасов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ВидЗапасов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ВидЗапасов = ксп_ИмпортСлужебный.НайтиВидЗапасов(стрк.ВидЗапасов);
	
	//	СтрокаТЧ.ДатаСчетаФактурыКомиссионера = стрк.ДатаСчетаФактурыКомиссионера;
	
	//	СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.КодТНВЭД.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.КодТНВЭД = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.КодТНВЭД.Ref ) );
	//	Иначе
	//		СтрокаТЧ.КодТНВЭД = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.КодТНВЭД = ксп_ИмпортСлужебный.НайтиКодТНВЭД(стрк.КодТНВЭД);
	
	//	СтрокаТЧ.Количество = стрк.Количество;
	//	СтрокаТЧ.КоличествоПоРНПТ = стрк.КоличествоПоРНПТ;
	//	СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.НомерГТД.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.НомерГТД = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НомерГТД.Ref ) );
	//	Иначе
	//		СтрокаТЧ.НомерГТД = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.НомерГТД = ксп_ИмпортСлужебный.НайтиНомерГТД(стрк.НомерГТД);
	
	//	СтрокаТЧ.НомерСчетаФактурыКомиссионера = стрк.НомерСчетаФактурыКомиссионера;
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.Покупатель.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Покупатель = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Покупатель.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Покупатель = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Покупатель = ксп_ИмпортСлужебный.НайтиПокупатель(стрк.Покупатель);
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.СтавкаНДС.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.СтавкаНДС = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.СтавкаНДС.Ref ) );
	//	Иначе
	//		СтрокаТЧ.СтавкаНДС = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.НайтиСтавкаНДС(стрк.СтавкаНДС);
	
	//	СтрокаТЧ.СуммаВознаграждения = стрк.СуммаВознаграждения;
	//	СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;
	//	СтрокаТЧ.СуммаНДСВознаграждения = стрк.СуммаНДСВознаграждения;
	//	СтрокаТЧ.СуммаСНДС = стрк.СуммаСНДС;
	
	//	_знч = "";
	//	ЕстьЗначение = стрк.УдалитьСтавкаНДС.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.УдалитьСтавкаНДС = стрк.УдалитьСтавкаНДС.Значение;
	//	Иначе
	//		СтрокаТЧ.УдалитьСтавкаНДС = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.УдалитьСтавкаНДС = ксп_ИмпортСлужебный.НайтиПеречисление_УдалитьСтавкаНДС(стрк.УдалитьСтавкаНДС);
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Упаковка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Упаковка.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Упаковка = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиУпаковка(стрк.Упаковка);
	
	//КонецЦикла;
	
	
	////------------------------------------------------------     ТЧ ДополнительныеРеквизиты
	
	
	//ОбъектДанных.ДополнительныеРеквизиты.Очистить();
	
	//Для счТовары = 0 По деф.ТЧДополнительныеРеквизиты.Количество()-1 Цикл
	//	стрк = деф.ТЧДополнительныеРеквизиты[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ДополнительныеРеквизиты.Добавить();
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.Значение.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Значение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Значение.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Значение = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Значение = ксп_ИмпортСлужебный.НайтиЗначение(стрк.Значение);
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.Свойство.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Свойство = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Свойство.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Свойство = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Свойство = ксп_ИмпортСлужебный.НайтиСвойство(стрк.Свойство);
	
	//	СтрокаТЧ.ТекстоваяСтрока = стрк.ТекстоваяСтрока;
	
	//КонецЦикла;
	
	
	////------------------------------------------------------     ТЧ РасшифровкаПлатежаСКлиентом
	
	
	//ОбъектДанных.РасшифровкаПлатежаСКлиентом.Очистить();
	
	//Для счТовары = 0 По деф.ТЧРасшифровкаПлатежаСКлиентом.Количество()-1 Цикл
	//	стрк = деф.ТЧРасшифровкаПлатежаСКлиентом[счТовары];
	//	СтрокаТЧ = ОбъектДанных.РасшифровкаПлатежаСКлиентом.Добавить();
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.ОбъектРасчетов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ОбъектРасчетов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ОбъектРасчетов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ОбъектРасчетов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ОбъектРасчетов = ксп_ИмпортСлужебный.НайтиОбъектРасчетов(стрк.ОбъектРасчетов);
	
	//	СтрокаТЧ.Сумма = стрк.Сумма;
	//	СтрокаТЧ.СуммаВзаиморасчетов = стрк.СуммаВзаиморасчетов;
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.УдалитьЗаказ.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.УдалитьЗаказ = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.УдалитьЗаказ.Ref ) );
	//	Иначе
	//		СтрокаТЧ.УдалитьЗаказ = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.УдалитьЗаказ = ксп_ИмпортСлужебный.НайтиУдалитьЗаказ(стрк.УдалитьЗаказ);
	
	//КонецЦикла;
	
	
	////------------------------------------------------------     ТЧ РасшифровкаПлатежаСПоставщиком
	
	
	//ОбъектДанных.РасшифровкаПлатежаСПоставщиком.Очистить();
	
	//Для счТовары = 0 По деф.ТЧРасшифровкаПлатежаСПоставщиком.Количество()-1 Цикл
	//	стрк = деф.ТЧРасшифровкаПлатежаСПоставщиком[счТовары];
	//	СтрокаТЧ = ОбъектДанных.РасшифровкаПлатежаСПоставщиком.Добавить();
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.ОбъектРасчетов.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ОбъектРасчетов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ОбъектРасчетов.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ОбъектРасчетов = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ОбъектРасчетов = ксп_ИмпортСлужебный.НайтиОбъектРасчетов(стрк.ОбъектРасчетов);
	
	//	СтрокаТЧ.Сумма = стрк.Сумма;
	
	//	СтрокаТЧ.СуммаВзаиморасчетов = стрк.СуммаВзаиморасчетов;
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.УдалитьЗаказ.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.УдалитьЗаказ = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.УдалитьЗаказ.Ref ) );
	//	Иначе
	//		СтрокаТЧ.УдалитьЗаказ = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.УдалитьЗаказ = ксп_ИмпортСлужебный.НайтиУдалитьЗаказ(стрк.УдалитьЗаказ);
	
	//КонецЦикла;
	
	
	////------------------------------------------------------     ТЧ Серии
	
	
	//ОбъектДанных.Серии.Очистить();
	
	//Для счТовары = 0 По деф.ТЧСерии.Количество()-1 Цикл
	//	стрк = деф.ТЧСерии[счТовары];
	//	СтрокаТЧ = ОбъектДанных.Серии.Добавить();
	
	//	СтрокаТЧ.Количество = стрк.Количество;
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.Номенклатура.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Номенклатура = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Номенклатура.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Номенклатура = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатура(стрк.Номенклатура);
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Серия = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Серия.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Серия = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Серия = ксп_ИмпортСлужебный.НайтиСерия(стрк.Серия);
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.Характеристика.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Характеристика = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Характеристика.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Характеристика = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристика(стрк.Характеристика);
	
	//КонецЦикла;
	
КонецФункции

Функция ПолучитьСоглашение(Организация)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	СоглашенияСКлиентами.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.СоглашенияСКлиентами КАК СоглашенияСКлиентами
		|ГДЕ
		|	СоглашенияСКлиентами.Организация = &Организация
		|	И СоглашенияСКлиентами.ХозяйственнаяОперация = &ХозяйственнаяОперация";
	
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ХозяйственнаяОперация", Перечисления.ХозяйственныеОперации.РеализацияКлиенту);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		
		Возврат Справочники.СоглашенияСКлиентами.ПустаяСсылка();
		
	Иначе
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		ВыборкаДетальныеЗаписи.Следующий();
		
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
		
	КонецЕсли;
	
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
Функция ЗагрузитьИзJsonНаСервере(Json, СкладЕРП = Неопределено) export
	
	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.УстановитьСтроку(Json);
	
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	Рез = Неопределено;
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		
		Для каждого ЭлМассива Из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(ЭлМассива, ,СкладЕРП);
		КонецЦикла;
		
	Иначе 
		//структура
		рез = ЗагрузитьОбъект(СтруктураОбъекта, ,СкладЕРП);
	КонецЕсли;
	
	Возврат рез;
	
КонецФункции

#КонецОбласти 


#Область Служебные

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
	//мРеквизиты.Добавить("СкладОтправитель");
	//мРеквизиты.Добавить("СкладПолучатель");
	//мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ДействиеСДокументом(ЭтоНовый, СуществующийДокСсылка, деф) Экспорт
	
	
	Если НЕ ЭтоНовый Тогда	
		
		Если СуществующийДокСсылка.ПометкаУдаления Тогда
			
			Если деф.DeletionMark = Истина Тогда
				Возврат НЕ_ЗАГРУЖАТЬ;
			ИначеЕсли НЕ деф.isPosted Тогда
				Возврат НЕ_ЗАГРУЖАТЬ;
			ИначеЕсли деф.isPosted Тогда
				Возврат ОБНОВИТЬ;
			КонецЕсли;		
			
		ИначеЕсли НЕ СуществующийДокСсылка.Проведен Тогда
			
			Если деф.DeletionMark = Истина Тогда
				Возврат НЕ_ЗАГРУЖАТЬ;
			ИначеЕсли НЕ деф.isPosted Тогда
				Возврат НЕ_ЗАГРУЖАТЬ;
			ИначеЕсли деф.isPosted Тогда
				Возврат ОБНОВИТЬ;
			КонецЕсли;
			
		ИначеЕсли СуществующийДокСсылка.Проведен Тогда
			
			Если деф.DeletionMark = Истина Тогда
				Возврат ОТМЕНИТЬ_ПРОВЕДЕНИЕ;
			ИначеЕсли НЕ деф.isPosted Тогда
				Возврат ОТМЕНИТЬ_ПРОВЕДЕНИЕ;
			ИначеЕсли деф.isPosted Тогда
				Возврат ОБНОВИТЬ;
			КонецЕсли;
			
		КонецЕсли;
		
	Иначе // новый документ
		
		Если деф.DeletionMark = Истина Тогда
			Возврат НЕ_ЗАГРУЖАТЬ;
		ИначеЕсли НЕ деф.isPosted Тогда
			Возврат НЕ_ЗАГРУЖАТЬ;
		ИначеЕсли деф.isPosted Тогда
			Возврат СОЗДАТЬ;
		КонецЕсли;		
		
	КонецЕсли;
	
	Возврат НЕ_ЗАГРУЖАТЬ;
	
КонецФункции

// Используется в  ксп_ИмпортСлужебный.ПроверитьКачествоДанных()
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//ТЗ, Колонки:
// * ИмяТЧ
// * ИмяКолонки       
//
Функция ТабличныеЧастиДляПроверки() Экспорт
	
	ТЗ = Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("ИмяТЧ");
	ТЗ.Колонки.Добавить("ИмяКолонки");
	
	НовСтр = ТЗ.Добавить();
	НовСтр.ИмяТЧ = "Товары";
	НовСтр.ИмяКолонки = "Номенклатура";
	НовСтр = ТЗ.Добавить();
	НовСтр.ИмяТЧ = "Товары";
	НовСтр.ИмяКолонки = "Характеристика";
	
	Возврат ТЗ;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	ГУИД 	- строка - 36 симв
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьПолучитьСсылкуДокумента(ГУИД, ВидОбъекта)
	
	СуществующаяСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	
	Если ЗначениеЗаполнено(СуществующаяСсылка.ВерсияДанных) Тогда
		
		Возврат СуществующаяСсылка;
		
	Иначе
		
		СсылкаНового = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
		ОбъектДанных = Документы[ВидОбъекта].СоздатьДокумент();
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		
		Возврат ОбъектДанных.Ссылка;
		
	КонецЕсли;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Функция сетИдВызова(пИдВызова) Экспорт
	
	мИдВызова = пИдВызова;
	Возврат ЭтотОбъект;
	
КонецФункции

#КонецОбласти



//мВнешняяСистема = "retail";

мВнешняяСистема = "UPP";
ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
СобиратьНенайденнуюНоменклатуру = Истина;
НеНайденнаяНоменклатураМассив = Новый Массив;

НЕ_ЗАГРУЖАТЬ = 1;
СОЗДАТЬ = 2;
ОБНОВИТЬ = 3;
ОТМЕНИТЬ_ПРОВЕДЕНИЕ = 4;

