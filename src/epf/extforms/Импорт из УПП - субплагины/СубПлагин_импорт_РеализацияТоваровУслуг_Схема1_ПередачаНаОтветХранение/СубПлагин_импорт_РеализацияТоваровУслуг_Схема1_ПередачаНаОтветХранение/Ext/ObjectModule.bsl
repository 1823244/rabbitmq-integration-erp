﻿
Перем НЕ_ЗАГРУЖАТЬ;
Перем СОЗДАТЬ;
Перем ОБНОВИТЬ;
Перем ОТМЕНИТЬ_ПРОВЕДЕНИЕ;
Перем ПОМЕТИТЬ;

Перем мВнешняяСистема;
Перем мВнутренняяСистема;
Перем ИмяСобытияЖР;
Перем jsonText;

Перем СобиратьНенайденнуюНоменклатуру Экспорт; // дли интерактивного импорта
Перем НеНайденнаяНоменклатураМассив;

Перем мЛоггер;
Перем мИдВызова;

Перем мСкладОтправитель;
Перем мСкладПолучатель;
Перем мДоговор;


#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт
	
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();
	
	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.9");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","СубПлагин_импорт_РеализацияТоваровУслуг_Схема1_ПередачаНаОтветХранение");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","СубПлагин_импорт_РеализацияТоваровУслуг_Схема1_ПередачаНаОтветХранение");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
	"Открыть форму : СубПлагин_импорт_РеализацияТоваровУслуг_Схема1_ПередачаНаОтветХранение",
	"Форма_СубПлагин_импорт_РеализацияТоваровУслуг_Схема1_ПередачаНаОтветХранение",
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


// Возвращает структуру. Поля различаются в зависимости от режима загрузки.
// Это нужно для отладки, а не для обычного режима работы.
//
Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "", СкладЕРП = Неопределено) Экспорт
	
	мЛоггер = Вычислить("мис_ЛоггерСервер.getLogger(мИдВызова, ""Импорт документов из УПП: РеализацияТоваровУслуг"")");
	
	Попытка
		
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			Возврат Неопределено;
		КонецЕсли;
		
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.РеализацияТоваровУслуг") Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;
		
		ВидОперации = "";
		НайденноеЗначение = "";
		Если деф.ВидОперации.Свойство("Значение", НайденноеЗначение) Тогда
			ВидОперации = НайденноеЗначение;
		КонецЕсли;
		
		Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, мВнешняяСистема);
		УзелКонтрагента = Неопределено;
		
		//ЕНС. 2024-01-16. Договор теперь хранится в РС "КСП_КомиссионерыДляРеализацийУПП" для каждого контрагента
		//ДоговорКонтрагента = ксп_ИмпортСлужебный.НайтиДоговор(деф.ДоговорКонтрагента, УзелКонтрагента, Контрагент);
		ДоговорКонтрагента = Неопределено;
		
		ЭтоКомиссионер = РегистрыСведений.КСП_КомиссионерыДляРеализацийУПП.ЭтоКомиссионер(мВнешняяСистема, Контрагент, ДоговорКонтрагента, деф.date);
		
		мСкладОтправитель = СкладЕРП;
		мСкладПолучатель = РегистрыСведений.КСП_КомиссионерыДляРеализацийУПП.СкладПолучатель(мВнешняяСистема, Контрагент, ДоговорКонтрагента, деф.date);
		мДоговор = РегистрыСведений.КСП_КомиссионерыДляРеализацийУПП.Договор(мВнешняяСистема, Контрагент, деф.date);
		
		Результат = Схема_1_ПеремещениеНаФулфилмент(СтруктураОбъекта);
		
	Исключение
		
		ТекстОшибки = ОписаниеОшибки();
		мЛоггер.ерр("Субплагин: Субплагин_RabbitMQ_импорт_из_УПП_Документ_РеализацияТоваровУслуг_Схема1_ПередачаНаОтветХранение.
		|Подробности: " + ТекстОшибки);
		
		ВызватьИсключение ТекстОшибки;
		
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

Функция Схема_1_ПеремещениеНаФулфилмент(СтруктураОбъекта) Экспорт
	//Заказ на перемещение (склад Щепкин - склад PFS), Расходный ордер на товар, Перемещение.
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ПредставлениеДокументаИзУПП = "РеализацияТоваровУслуг (УПП) № "+деф.Number+" от "+строка(деф.Date);
	
	СуществующийЗаказСсылка 		= СоздатьПолучитьСсылкуДокумента(id.Ref, "ЗаказНаПеремещение");
	СуществующийРОСсылка 			= СоздатьПолучитьСсылкуДокумента(id.Ref, "РасходныйОрдерНаТовары");
	СуществующийПеремещениеСсылка	= СоздатьПолучитьСсылкуДокумента(id.Ref, "ПеремещениеТоваров");
	
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(СуществующийЗаказСсылка);
	МассивСсылок.Добавить(СуществующийРОСсылка);
	МассивСсылок.Добавить(СуществующийПеремещениеСсылка);
	
	// -------------------------------------------- БЛОКИРОВКА
	// не будем различать ситуации Новый/НеНовый
	Если ЗначениеЗаполнено(СуществующийЗаказСсылка.ВерсияДанных) Тогда
		ЭтоНовый = Ложь;
	Иначе
		ЭтоНовый = Истина;
	КонецЕсли;
	//Если НЕ ЭтоНовый Тогда
	Блокировка = ксп_Блокировки.СоздатьБлокировкуНесколькихОбъектов(МассивСсылок);
	//КонецЕсли;
	
	НачатьТранзакцию();
	
	//Если НЕ ЭтоНовый Тогда
	Попытка
		Блокировка.Заблокировать();
	Исключение
		ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка блокировки цепочки документов для "+ПредставлениеДокументаИзУПП+".
			|Подробности: " + ТекстОшибки);
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	//КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	Действие = ксп_ИмпортСлужебный.ДействиеСДокументом(ЭтоНовый, СуществующийЗаказСсылка, деф);
	
	Результат = Новый Структура;
	
	Если Действие = НЕ_ЗАГРУЖАТЬ Тогда
		ОтменитьТранзакцию();
		мЛоггер.инфо("Действие = НЕ Загружать. Документ пропущен: %1", ПредставлениеДокументаИзУПП);
		Результат.Вставить("ЗаказНаПеремещение", СуществующийЗаказСсылка);
		Возврат Результат;
	КонецЕсли;
	
    // добавлено 2024-07-03
    Если Действие = ПОМЕТИТЬ Тогда
        ОбъектДанных = СуществующийЗаказСсылка.ПолучитьОбъект();
        ОбъектДанных.УстановитьПометкуУдаления(Истина);
        РегистрыСведений.ксп_ОтложенноеПроведение.УдалитьОтложенноеПроведение(СуществующийЗаказСсылка);//добавлено 2024-07-03
        ЗафиксироватьТранзакцию();
		Результат.Вставить("ЗаказНаПеремещение", СуществующийЗаказСсылка);
		мЛоггер.дебаг("Действие = ПОМЕТИТЬ. Документ будет помечен на удаление: %1", ПредставлениеДокументаИзУПП);
		Возврат Результат;
	КонецЕсли;
		
	Если Действие = ОТМЕНИТЬ_ПРОВЕДЕНИЕ Тогда
		ОбъектДанных = СуществующийЗаказСсылка.ПолучитьОбъект();
		ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		ЗафиксироватьТранзакцию();
		мЛоггер.инфо("Действие = Отменить проведение. Документ: %1", ПредставлениеДокументаИзУПП);
		Результат.Вставить("ЗаказНаПеремещение", СуществующийЗаказСсылка);
		Возврат Результат;
	КонецЕсли;
	
	Если Действие = ОБНОВИТЬ Тогда
		ОбъектДанных = СуществующийЗаказСсылка.ПолучитьОбъект();
		мЛоггер.инфо("Действие = Обновить. Документ будет обновлен: %1", ПредставлениеДокументаИзУПП);
	ИначеЕсли Действие = СОЗДАТЬ Тогда
		ОбъектДанных = Документы.ЗаказНаПеремещение.СоздатьДокумент();
		СсылкаНового = Документы.ЗаказНаПеремещение.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		мЛоггер.инфо("Действие = Создать. Документ будет создан: %1", ПредставлениеДокументаИзУПП);
	Иначе
		ОтменитьТранзакцию();
		ТекстСообщения = "Действие = Неизвестое действие: "+Строка(Действие)+". Документ: " + ПредставлениеДокументаИзУПП;
		мЛоггер.ерр(ТекстСообщения);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	Попытка
		
		ЗаказНаПеремещениеОбъект = СоздатьЗаказНаПеремещение(СтруктураОбъекта, СуществующийЗаказСсылка, ОбъектДанных);
		РООбъект = СоздатьРасходныйОрдер(СтруктураОбъекта, СуществующийРОСсылка, ЗаказНаПеремещениеОбъект);
		ПеремещениеОбъект = СоздатьПеремещение(СтруктураОбъекта, СуществующийПеремещениеСсылка, РООбъект, ЗаказНаПеремещениеОбъект);
		
		Комментарий = "";
		
		РегистрыСведений.КСП_СвязьРеализацийУППиЦепочекПеремещений.ДобавитьЗапись(
			мВнешняяСистема, id.Ref, ЗаказНаПеремещениеОбъект.Ссылка, ПеремещениеОбъект.Ссылка, 
			РООбъект.Ссылка, ПредставлениеДокументаИзУПП, Комментарий);
		
		ЗафиксироватьТранзакцию();
		
		Результат.Вставить("ЗаказНаПеремещение", ЗаказНаПеремещениеОбъект.Ссылка);
		Результат.Вставить("РО", РООбъект.Ссылка);
		Результат.Вставить("Перемещение", ПеремещениеОбъект.Ссылка);
		
	Исключение
		
		ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
		"Объект не загружен! Ошибка в процессе загрузки документа "+ПредставлениеДокументаИзУПП+". Подробности: " + ТекстОшибки);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
		
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьЗаказНаПеремещение(СтруктураОбъекта, СуществующийЗаказСсылка, ОбъектДанных)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ПредставлениеДокументаИзУПП = "ЗаказНаПеремещение (УПП РеализацияТоваровУслуг) № " + деф.Number + " от " + строка(деф.Date);
	
	//------------------------------------- Заполнение реквизитов -----------------------------------
	
	//ОбъектДанных.Номер = деф.Number;
	Если ЗначениеЗаполнено(деф.Date) Тогда
		ОбъектДанных.Дата = деф.Date;
	КонецЕсли;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	ОбъектДанных.СкладОтправитель = мСкладОтправитель;
	ОбъектДанных.СкладПолучатель = мСкладПолучатель;
	ОбъектДанных.ЖелаемаяДатаПоступления = ОбъектДанных.Дата;
	ОбъектДанных.Комментарий = СтрШаблон("схема ПередачаНаОтветХранение: [УПП РеализацияТоваровУслуг № %1 от %2 ]
		|СкладОтправитель: %3
		|СкладПолучатель: %4
		|Оригинальный комментарий: %5",
		строка(деф.number),
		строка(деф.date),
		мСкладОтправитель,
		мСкладПолучатель,
		деф.Комментарий,);
	
	мПриоритет = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций.Настройка("ПриоритетДляРТУ_схема1_УПП", мВнешняяСистема);
	Если ЗначениеЗаполнено(мПриоритет) Тогда
		ОбъектДанных.Приоритет = мПриоритет;
	Иначе
		мЛоггер.ерр("Не заполнена настройка ПриоритетДляРТУ_схема1_УПП в регистре ксп_ДополнительныеНастройкиИнтеграций
		|для %1. ", ПредставлениеДокументаИзУПП);
	КонецЕсли;
	
	ОбъектДанных.Статус = Перечисления.СтатусыВнутреннихЗаказов.КВыполнению;
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПеремещениеТоваров;
	ОбъектДанных.СпособДоставки = Перечисления.СпособыДоставки.Самовывоз;
	ОбъектДанных.ВариантПриемкиТоваров = Перечисления.ВариантыПриемкиТоваров.РазделенаПоЗаказамИНакладным;
	
	////------------------------------------------------------     ТЧ Товары
	
	ОбъектДанных.Товары.Очистить();
	
	КодСтроки = 1;
	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();
		
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
		
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
		СтрокаТЧ.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Отгрузить;
		СтрокаТЧ.НачалоОтгрузки = ОбъектДанных.Дата;
		СтрокаТЧ.КодСтроки = КодСтроки; 
		КодСтроки = КодСтроки + 1;
		
	КонецЦикла;
	
	
	//------------------------------------------------------ ФИНАЛ	
	
	Попытка
		
		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.ДополнительныеСвойства.Вставить("НеРегистрироватьКОбменуRabbitMQ", Истина);
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		Иначе 
			ОбъектДанных.Записать();
		КонецЕсли;
		
		// Документ будет помещен в Отложенное проведение
		jsonText = "";
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		
	Исключение
		
		СообщениеОбОшибке=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа "+ПредставлениеДокументаИзУПП+".
			|Подробности: " + СообщениеОбОшибке);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		мЛоггер.ерр("Ошибка загрузки документа (УПП): %1.
			|Подробности: %2", ПредставлениеДокументаИзУПП, СообщениеОбОшибке);
		
		ВызватьИсключение;
		
	КонецПопытки;
	
	Возврат ОбъектДанных;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьРасходныйОрдер(СтруктураОбъекта, СуществующийРОСсылка, ЗаказНаПеремещениеОбъект)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ПредставлениеДокументаИзУПП = "РасходныйОрдерНаТовары (УПП РеализацияТоваровУслуг) № " + деф.Number + " от " + строка(деф.Date);
	
	//------------------------------------- Заполнение реквизитов
	
	Если ЗначениеЗаполнено(СуществующийРОСсылка.ВерсияДанных) Тогда
		ЭтоНовый = Ложь;
	Иначе
		ЭтоНовый = Истина;
	КонецЕсли;
	
	Действие = ксп_ИмпортСлужебный.ДействиеСДокументом(ЭтоНовый, СуществующийРОСсылка, деф);
	
	Если Действие = НЕ_ЗАГРУЖАТЬ Тогда
		мЛоггер.инфо("Действие = НЕ Загружать. Документ пропущен: %1", ПредставлениеДокументаИзУПП);
		Возврат СуществующийРОСсылка;
	КонецЕсли;
	
    // добавлено 2024-07-03
    Если Действие = ПОМЕТИТЬ Тогда
        ОбъектДанных = СуществующийРОСсылка.ПолучитьОбъект();
        ОбъектДанных.УстановитьПометкуУдаления(Истина);
        РегистрыСведений.ксп_ОтложенноеПроведение.УдалитьОтложенноеПроведение(СуществующийРОСсылка);//добавлено 2024-07-03
        ЗафиксироватьТранзакцию();
		мЛоггер.дебаг("Действие = ПОМЕТИТЬ. Документ будет помечен на удаление: %1", ПредставлениеДокументаИзУПП);
		Возврат СуществующийРОСсылка;
	КонецЕсли;

	Если Действие = ОТМЕНИТЬ_ПРОВЕДЕНИЕ Тогда
		ОбъектДанных = СуществующийРОСсылка.ПолучитьОбъект();
		ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		ЗафиксироватьТранзакцию();
		мЛоггер.инфо("Действие = Отменить проведение. Документ: %1", ПредставлениеДокументаИзУПП);
		Возврат СуществующийРОСсылка;
	КонецЕсли;
	
	Если Действие = ОБНОВИТЬ Тогда
		ОбъектДанных = СуществующийРОСсылка.ПолучитьОбъект();
		мЛоггер.инфо("Действие = Обновить. Документ будет обновлен: %1", ПредставлениеДокументаИзУПП);
	ИначеЕсли Действие = СОЗДАТЬ Тогда
		ОбъектДанных = Документы.РасходныйОрдерНаТовары.СоздатьДокумент();
		СсылкаНового = Документы.РасходныйОрдерНаТовары.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		мЛоггер.инфо("Действие = Создать. Документ будет создан: %1", ПредставлениеДокументаИзУПП);
	Иначе
		ТекстСообщения = "Действие = Неизвестое действие: "+Строка(Действие)+". Документ: " + ПредставлениеДокументаИзУПП;
		мЛоггер.ерр(ТекстСообщения);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	//ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
	ОбъектДанных.Склад = мСкладОтправитель;
	ОбъектДанных.Получатель = мСкладПолучатель;
	
	ОбъектДанных.СкладскаяОперация = перечисления.СкладскиеОперации.ОтгрузкаПоПеремещению;
	ОбъектДанных.Статус = Перечисления.СтатусыРасходныхОрдеров.Отгружен;
	
	//ОбъектДанных.ВсегоМест = деф.ВсегоМест;
	
	ОбъектДанных.ДатаОтгрузки = деф.Date;
	
	мПриоритет = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций.Настройка("ПриоритетДляРТУ_схема1_УПП", мВнешняяСистема);
	Если ЗначениеЗаполнено(мПриоритет) Тогда
		ОбъектДанных.Приоритет = мПриоритет;
	Иначе
		мЛоггер.ерр("Не заполнена настройка ПриоритетДляРТУ_схема1_УПП в регистре ксп_ДополнительныеНастройкиИнтеграций
		|для %1. ", ПредставлениеДокументаИзУПП);
	КонецЕсли;
	
	ОбъектДанных.Комментарий = СтрШаблон("схема ПередачаНаОтветХранение: [УПП РеализацияТоваровУслуг № %1 от %2 ]
		|СкладОтправитель: %3
		|СкладПолучатель: %4
		|Оригинальный комментарий: %5",
		строка(деф.number),
		строка(деф.date),
		мСкладОтправитель,
		мСкладПолучатель,
		деф.Комментарий,);  
		
	
	////------------------------------------------------------     ТЧ ТоварыПоРаспоряжениям + ОтгружаемыеТовары
	
	
	ОбъектДанных.ТоварыПоРаспоряжениям.Очистить();
	ОбъектДанных.ОтгружаемыеТовары.Очистить();
	
	Для каждого стрк Из ЗаказНаПеремещениеОбъект.Товары Цикл
		
		СтрокаТЧ = ОбъектДанных.ТоварыПоРаспоряжениям.Добавить();
		
		СтрокаТЧ.Номенклатура = стрк.Номенклатура;
		СтрокаТЧ.Характеристика = стрк.Характеристика;
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.Распоряжение = ЗаказНаПеремещениеОбъект.Ссылка;	
		
		СтрокаТЧ = ОбъектДанных.ОтгружаемыеТовары.Добавить();       
		
		СтрокаТЧ.Номенклатура = стрк.Номенклатура;
		СтрокаТЧ.Характеристика = стрк.Характеристика;
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;
		СтрокаТЧ.Действие = Перечисления.ДействияСоСтрокамиОрдеровНаОтгрузку.Отгрузить;
		
	КонецЦикла;
	
	
	//------------------------------------------------------ ФИНАЛ
	
	Попытка
		
		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.ДополнительныеСвойства.Вставить("НеРегистрироватьКОбменуRabbitMQ", Истина);
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		Иначе 
			ОбъектДанных.Записать();
		КонецЕсли;
		
		// Документ будет помещен в Отложенное проведение
		jsonText = "";
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		
	Исключение
		
		СообщениеОбОшибке=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа "+ПредставлениеДокументаИзУПП+".
			|Подробности: "+СообщениеОбОшибке);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		мЛоггер.ерр("Ошибка загрузки документа (УПП): %1.
			|Подробности: %2", ПредставлениеДокументаИзУПП, СообщениеОбОшибке);
		
		ВызватьИсключение;
		
	КонецПопытки;
	
	Возврат ОбъектДанных;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьПеремещение(СтруктураОбъекта, СуществующийПеремещениеСсылка, РООбъект, ЗаказНаПеремещениеОбъект)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	
	Если ЗначениеЗаполнено(СуществующийПеремещениеСсылка.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийПеремещениеСсылка.ПолучитьОбъект();
		ПредставлениеОбъекта = Строка(СуществующийПеремещениеСсылка);
	Иначе 
		ОбъектДанных = Документы.ПеремещениеТоваров.СоздатьДокумент();
		СсылкаНового = Документы.ПеремещениеТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		
	КонецЕсли;
	
	ПредставлениеДокументаИзУПП = "ПеремещениеТоваров (УПП РеализацияТоваровУслуг) № " + деф.Number + " от " + строка(деф.Date);
	
	//------------------------------------- Заполнение реквизитов
	
	Если ЗначениеЗаполнено(СуществующийПеремещениеСсылка.ВерсияДанных) Тогда
		ЭтоНовый = Ложь;
	Иначе
		ЭтоНовый = Истина;
	КонецЕсли;
	
	Действие = ксп_ИмпортСлужебный.ДействиеСДокументом(ЭтоНовый, СуществующийПеремещениеСсылка, деф);
	
	Если Действие = НЕ_ЗАГРУЖАТЬ Тогда
		мЛоггер.инфо("Действие = НЕ Загружать. Документ пропущен: %1", ПредставлениеДокументаИзУПП);
		Возврат СуществующийПеремещениеСсылка;
	КонецЕсли;

    // добавлено 2024-07-03
    Если Действие = ПОМЕТИТЬ Тогда
        ОбъектДанных = СуществующийПеремещениеСсылка.ПолучитьОбъект();
        ОбъектДанных.УстановитьПометкуУдаления(Истина);
        РегистрыСведений.ксп_ОтложенноеПроведение.УдалитьОтложенноеПроведение(СуществующийПеремещениеСсылка);//добавлено 2024-07-03
        ЗафиксироватьТранзакцию();
		мЛоггер.дебаг("Действие = ПОМЕТИТЬ. Документ будет помечен на удаление: %1", ПредставлениеДокументаИзУПП);
		Возврат СуществующийПеремещениеСсылка;
	КонецЕсли;
			
	Если Действие = ОТМЕНИТЬ_ПРОВЕДЕНИЕ Тогда
		ОбъектДанных = СуществующийПеремещениеСсылка.ПолучитьОбъект();
		ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		ЗафиксироватьТранзакцию();
		мЛоггер.инфо("Действие = Отменить проведение. Документ: %1", ПредставлениеДокументаИзУПП);
		Возврат СуществующийПеремещениеСсылка;
	КонецЕсли;
	
	Если Действие = ОБНОВИТЬ Тогда
		ОбъектДанных = СуществующийПеремещениеСсылка.ПолучитьОбъект();
		мЛоггер.инфо("Действие = Обновить. Документ будет обновлен: %1", ПредставлениеДокументаИзУПП);
	ИначеЕсли Действие = СОЗДАТЬ Тогда
		ОбъектДанных = Документы.ПеремещениеТоваров.СоздатьДокумент();
		СсылкаНового = Документы.ПеремещениеТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		мЛоггер.инфо("Действие = Создать. Документ будет создан: %1", ПредставлениеДокументаИзУПП);
	Иначе
		ТекстСообщения = "Действие = Неизвестое действие: "+Строка(Действие)+". Документ: " + ПредставлениеДокументаИзУПП;
		мЛоггер.ерр(ТекстСообщения);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	
	//ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
	ОбъектДанных.ПеремещениеПоЗаказам = Истина;
	ОбъектДанных.ЗаказНаПеремещение = ЗаказНаПеремещениеОбъект.Ссылка;
	
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	ОбъектДанных.СкладОтправитель = мСкладОтправитель;
	ОбъектДанных.СкладПолучатель = мСкладПолучатель;
	ОбъектДанных.ПеремещениеПоЗаказам = Истина;
	
	ОбъектДанных.Статус = Перечисления.СтатусыПеремещенийТоваров.Принято;
	
	ОбъектДанных.ХозяйственнаяОперация = перечисления.ХозяйственныеОперации.ПеремещениеТоваров;
	
	ОбъектДанных.Комментарий = СтрШаблон("схема ПередачаНаОтветХранение: [УПП РеализацияТоваровУслуг № %1 от %2 ]
		|СкладОтправитель: %3
		|СкладПолучатель: %4
		|Оригинальный комментарий: %5",
		строка(деф.number),
		строка(деф.date),
		мСкладОтправитель,
		мСкладПолучатель,
		деф.Комментарий,);
	

	ОбъектДанных.СпособДоставки = Перечисления.СпособыДоставки.Самовывоз;
	ОбъектДанных.ВариантПриемкиТоваров = Перечисления.ВариантыПриемкиТоваров.РазделенаПоЗаказамИНакладным;
	
	//------------------------------------------------------     ТЧ Товары
	
	ОбъектДанных.Товары.Очистить();
	
	//Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
	Для каждого стрк Из ЗаказНаПеремещениеОбъект.Товары Цикл
		
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();
		
		СтрокаТЧ.Номенклатура = стрк.Номенклатура;
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;
		СтрокаТЧ.Характеристика = стрк.Характеристика;
		СтрокаТЧ.ЗаказНаПеремещение = ЗаказНаПеремещениеОбъект.Ссылка;	
		СтрокаТЧ.КодСтроки = стрк.КодСтроки;
		
	КонецЦикла;
		
	//------------------------------------------------------ ФИНАЛ
	
	Попытка
		
		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.ДополнительныеСвойства.Вставить("НеРегистрироватьКОбменуRabbitMQ", Истина);
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		Иначе 
			ОбъектДанных.Записать();
		КонецЕсли;
		
		// Документ будет помещен в Отложенное проведение
		jsonText = "";
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		
	Исключение
		
		СообщениеОбОшибке=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа "+ПредставлениеДокументаИзУПП+".
			|Подробности: "+СообщениеОбОшибке);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		мЛоггер.ерр("Ошибка загрузки документа (УПП): %1.
			|Подробности: %2", ПредставлениеДокументаИзУПП, СообщениеОбОшибке);
		
		ВызватьИсключение;
		
	КонецПопытки;
	
	Возврат ОбъектДанных;
	
КонецФункции


#Область Тестирование

// вызывается из формы
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервере(JsonText) export
	
	мЧтениеJSON = Новый ЧтениеJSON;
	
	
	мЧтениеJSON.УстановитьСтроку(JsonText);
	
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		
		НеНайденнаяНоменклатураМассив = Новый Массив;
		
		Для Каждого эл из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(эл);
		КонецЦикла;                       
		
		Рез = Новый Структура;
		Рез.Вставить("НеНайденнаяНоменклатураМассив", НеНайденнаяНоменклатураМассив);
		
		Возврат Рез;
		
	Иначе
		Возврат ЗагрузитьОбъект(СтруктураОбъекта);
	КонецЕсли;
	
	
КонецФункции 

Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
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

#КонецОбласти


// Возвращает ссылку! (не объект)
// Если документ существует - возвращает его
// Если нет - создает, устанавливает ссылку нового, возвращает ссылку из объекта (а не СсылкаНового)
//
// Параметры:
//	ГУИД 	- строка - 36 симв
//
// Возвращаемое значение:
//	Тип: Ссылка на документ
//
Функция СоздатьПолучитьСсылкуДокумента(ГУИД, ВидОбъекта)
	
	СуществующийОбъект 		= Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		Возврат СуществующийОбъект;
	Иначе 
		
		ОбъектДанных = Документы[ВидОбъекта].СоздатьДокумент();
		СсылкаНового = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		
		Возврат ОбъектДанных.Ссылка;
	КонецЕсли;	
	
КонецФункции


// Используется в  ксп_ИмпортСлужебный.ПроверитьКачествоДанных()
//
// Параметры:
//  ДокументОбъект  - ДокументСсылка - <описание параметра>
//
// Возвращаемое значение:
//  ТЗ, Колонки:
//   * ИмяТЧ
//   * ИмяКолонки
//
Функция ТабличныеЧастиДляПроверки(ДокументСсылка = Неопределено) Экспорт
	
	ТЗ = Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("ИмяТЧ");
	ТЗ.Колонки.Добавить("ИмяКолонки");
	
	Если ДокументСсылка = Неопределено 
		ИЛИ ТипЗнч(ДокументСсылка) = Тип("ДокументСсылка.ЗаказНаПеремещение")
		ИЛИ ТипЗнч(ДокументСсылка) = Тип("ДокументСсылка.ПеремещениеТоваров") Тогда
		
		НовСтр = ТЗ.Добавить();
		НовСтр.ИмяТЧ = "Товары";
		НовСтр.ИмяКолонки = "Номенклатура";
		НовСтр = ТЗ.Добавить();
		НовСтр.ИмяТЧ = "Товары";
		НовСтр.ИмяКолонки = "Характеристика";
		
	ИначеЕсли ТипЗнч(ДокументСсылка) = Тип("ДокументСсылка.РасходныйОрдерНаТовары") Тогда
		
		НовСтр = ТЗ.Добавить();
		НовСтр.ИмяТЧ = "ТоварыПоРаспоряжениям";
		НовСтр.ИмяКолонки = "Номенклатура";
		НовСтр = ТЗ.Добавить();
		НовСтр.ИмяТЧ = "ТоварыПоРаспоряжениям";
		НовСтр.ИмяКолонки = "Характеристика";
		
		НовСтр = ТЗ.Добавить();
		НовСтр.ИмяТЧ = "ОтгружаемыеТовары";
		НовСтр.ИмяКолонки = "Номенклатура";
		НовСтр = ТЗ.Добавить();
		НовСтр.ИмяТЧ = "ОтгружаемыеТовары";
		НовСтр.ИмяКолонки = "Характеристика";
		
	КонецЕсли;
	
	Возврат ТЗ;
	
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
	//мРеквизиты.Добавить("Склад");
	//мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции

Функция сетИдВызова(пИдВызова) Экспорт
	
	мИдВызова = пИдВызова;
	Возврат ЭтотОбъект;
	
КонецФункции


мВнешняяСистема = "upp";
ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

СобиратьНенайденнуюНоменклатуру = Истина;
НеНайденнаяНоменклатураМассив = Новый Массив;

НЕ_ЗАГРУЖАТЬ = 1;
СОЗДАТЬ = 2;
ОБНОВИТЬ = 3;
ОТМЕНИТЬ_ПРОВЕДЕНИЕ = 4;
ПОМЕТИТЬ = 5;
