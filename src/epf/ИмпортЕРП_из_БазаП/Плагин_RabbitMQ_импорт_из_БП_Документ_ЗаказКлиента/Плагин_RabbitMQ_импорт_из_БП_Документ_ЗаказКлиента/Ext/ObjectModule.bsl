﻿Перем НЕ_ЗАГРУЖАТЬ;
Перем СОЗДАТЬ;
Перем ОБНОВИТЬ;
Перем ОТМЕНИТЬ_ПРОВЕДЕНИЕ;

Перем ИмяСобытияЖР;
Перем jsonText;
Перем СобиратьНенайденнуюНоменклатуру Экспорт;
Перем НеНайденнаяНоменклатураМассив;   
Перем СобиратьНенайденныхКонтрагентов Экспорт;
Перем НеНайденныеКонтрагентыМассив;   

Перем мЛоггер;
Перем мИдВызова;


Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.9");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_БП_Документ_ЗаказКлиента");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_БП_Документ_ЗаказКлиента");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_БП_Документ_ЗаказКлиента",
		"Форма_Плагин_RabbitMQ_импорт_из_БП_Документ_ЗаказКлиента",
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



Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт документов из База Показов: Заявка покупателя");
	
    Попытка
		
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			Возврат Неопределено;
		КонецЕсли;
	
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.заявкапокупателя") Тогда
			Возврат Неопределено;
		КонецЕсли;

		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;

		Рез = СоздатьОбновитьДокумент(СтруктураОбъекта);   	
		
		//*************************** Экспорт ненайденной номенклатуры ****************  
		Попытка
			ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовНоменклатуры(НеНайденнаяНоменклатураМассив);
			Сообщить("Выполнен экспорт ненайденной номенклатуры - " + Строка(НеНайденнаяНоменклатураМассив.Количество()) + " позиций");
		Исключение
		    т = ОписаниеОшибки();
			Сообщить("Ошибка экспорта ненайденной номенклатуры в УПП.");
	        ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение,,,
			"Ошибка экспорта ненайденной номенклатуры в УПП. Подробности: "+т);
		КонецПопытки;            
		//*************************** Экспорт ненайденной контрагентов ****************  
		Попытка
			ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовКонтрагентов(НеНайденныеКонтрагентыМассив);
			Сообщить("Выполнен экспорт ненайденных контрагентов - " + Строка(НеНайденныеКонтрагентыМассив.Количество()) + " позиций");
		Исключение
		    т = "Ошибка экспорта ненайденных контрагентов в УПП. Подробности: "+ОписаниеОшибки();
			Сообщить(т);
	        ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение,,,т);
			мЛоггер.ерр(т);
		КонецПопытки;            
		
		
		
		Возврат Рез;
		
    Исключение
        мЛоггер.ерр("Импорт из Базы показов. Плагин: Импорт Документ.ЗаявкаПокупателя. Подробности: "+ОписаниеОшибки());
		ВызватьИсключение;// для помещения в retry
	КонецПопытки;			
КонецФункции


Функция СоздатьОбновитьДокумент(СтруктураОбъекта) Экспорт
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;   
	
	ПустойДокумент = Документы.ЗаказКлиента.ПустаяСсылка();
	
	ДокументИзБазаПоказов = "Заявка покупателя (База показов) № " + деф.Number + " от " + строка(деф.Date);
		
	УИД = Новый УникальныйИдентификатор(id.Ref);
	СуществующийДокСсылка = Документы.ЗаказКлиента.ПолучитьСсылку(УИД);
	
	
	Если ЗначениеЗаполнено(СуществующийДокСсылка.ВерсияДанных) Тогда
		ЭтоНовый = Ложь;
	Иначе   
		ЭтоНовый = Истина;
	КонецЕсли;
	
	Комментарий = "";
	
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
			т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
				"Объект не загружен! Ошибка блокировки документа для " + ДокументИзБазаПоказов + ". Подробности: " + т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
	
	Рез = Неопределено;
	
	//------------------------------------- Заполнение реквизитов
	
	Попытка			
		
		Действие = ДействиеСДокументом(ЭтоНовый, СуществующийДокСсылка, деф);
		Если Действие = НЕ_ЗАГРУЖАТЬ Тогда
			ОтменитьТранзакцию();                                             
			мЛоггер.инфо("Действие = НЕ Загружать. Документ пропущен: %1", ДокументИзБазаПоказов);
			Возврат СуществующийДокСсылка;
		КонецЕсли;
		
		Если Действие = ОТМЕНИТЬ_ПРОВЕДЕНИЕ Тогда
			ОбъектДанных = СуществующийДокСсылка.ПолучитьОбъект();
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
			ЗафиксироватьТранзакцию();
			мЛоггер.инфо("Действие = Отменить проведение. Документ: %1", ДокументИзБазаПоказов);
			Возврат СуществующийДокСсылка;
		КонецЕсли;
		
		Если Действие = ОБНОВИТЬ Тогда
			ОбъектДанных = СуществующийДокСсылка.ПолучитьОбъект();
			мЛоггер.инфо("Действие = Обновить. Документ будет обновлен: %1", ДокументИзБазаПоказов);
		ИначеЕсли Действие = СОЗДАТЬ Тогда
			ОбъектДанных = Документы.ЗаказКлиента.СоздатьДокумент();
			СсылкаНового = Документы.ЗаказКлиента.ПолучитьСсылку(УИД);
			ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
			мЛоггер.инфо("Действие = Создать. Документ будет создан: %1", ДокументИзБазаПоказов);
		Иначе 
			ОтменитьТранзакцию();
			мЛоггер.инфо("Действие = Неизвестое действие: "+Строка(Действие)+". Документ: %1", ДокументИзБазаПоказов);
			Возврат ПустойДокумент;
		КонецЕсли;
		
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		
		ЗаполнитьРеквизиты(СтруктураОбъекта, ОбъектДанных);		

		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		
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
		
		мЛоггер.инфо("Записан Документ : %1. Исходный док. БазаПоказов: %2", ОбъектДанных, ДокументИзБазаПоказов);
		
		Рез = ОбъектДанных.ССылка;
		
	Исключение
		т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа " + ДокументИзБазаПоказов + ". Подробности: " + т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
	КонецПопытки;	
	
	Возврат Рез;
	
КонецФункции



// Заполняет реквизиты объекта и пишет сопутствующие данные. Должна вызываться в транзакции.
Функция ЗаполнитьРеквизиты(СтруктураОбъекта, ОбъектДанных, jsonText = "") Экспорт

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
    ОбъектДанных.Комментарий = "[База Показов №" + деф.Number + " от " + деф.Date + " ]. Ориг. коммент.: "+деф.Комментарий;

    ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
		
	ОбъектДанных.Валюта = Константы.ВалютаРегламентированногоУчета.Получить();
	
    ТэгКонтрагента = деф.Контрагент;
	КонтрагентСсылка = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, мВнешняяСистема);
	
	Если СобиратьНенайденныхКонтрагентов и ТэгКонтрагента.Свойство("ref") Тогда
		Если ТипЗнч(КонтрагентСсылка) = Тип("СправочникСсылка.Контрагенты") И НЕ ЗначениеЗаполнено(КонтрагентСсылка.ВерсияДанных) Тогда
			Если НеНайденныеКонтрагентыМассив.Найти(ТэгКонтрагента.ref) = Неопределено Тогда
				НеНайденныеКонтрагентыМассив.Добавить(ТэгКонтрагента.Ref);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ОбъектДанных.Контрагент = КонтрагентСсылка;
	
	ОбъектДанных.Договор = ксп_ИмпортСлужебный.НайтиДоговор(деф.ДоговорКонтрагента); //по гуид
	Если НЕ ЗначениеЗаполнено(ОбъектДанных.Договор) Тогда
		ОбъектДанных.Договор = НайтиДоговорРеализации(ОбъектДанных.Контрагент, ОбъектДанных.Организация);  //первый попавшийся "СПокупателем"
	КонецЕсли;

	ОбъектДанных.НалогообложениеНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;

	ОбъектДанных.ОплатаВВалюте = Ложь;

	Если ЗначениеЗаполнено(ОбъектДанных.Контрагент) Тогда
		ОбъектДанных.Партнер = ОбъектДанных.Контрагент.Партнер;
	Иначе 
		ОбъектДанных.Партнер = Неопределено;
	КонецЕсли;
	
	ОбъектДанных.Статус = Перечисления.СтатусыЗаказовКлиентов.КОтгрузке;
	
	ОбъектДанных.Соглашение = 
	РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций.Настройка("СоглашениеСКлиентамиДляБазыПоказов", мВнешняяСистема);
	
	ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;
	
	ОбъектДанных.СпособДоставки = Перечисления.СпособыДоставки.Самовывоз;
	
	ОбъектДанных.Приоритет = Справочники.Приоритеты.НайтиПоНаименованию("средний", истина);
	
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.РеализацияКлиенту;
	
	

	////------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();

		СтрокаТЧ.Количество = стрк.Количество;

		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;

		Если стрк.Номенклатура.Свойство("identification") Тогда
			// это полный объект номенклатуры.
			ТэгНоменклатуры = стрк.Номенклатура.identification;
		Иначе 
			ТэгНоменклатуры = стрк.Номенклатура;
		КонецЕсли;			
		
		_Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(ТэгНоменклатуры);
		
		Если СобиратьНенайденнуюНоменклатуру и ТэгНоменклатуры.Свойство("ref") Тогда
			Если ТипЗнч(_Номенклатура) = Тип("СправочникСсылка.Номенклатура") И НЕ ЗначениеЗаполнено(_Номенклатура.ВерсияДанных) Тогда
				Если НеНайденнаяНоменклатураМассив.Найти(ТэгНоменклатуры.ref) = Неопределено Тогда
					НеНайденнаяНоменклатураМассив.Добавить(ТэгНоменклатуры.Ref);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		СтрокаТЧ.Номенклатура = _Номенклатура;
		
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
		

		СтрокаТЧ.ПроцентАвтоматическойСкидки = стрк.ПроцентАвтоматическихСкидок;

		СтрокаТЧ.СтавкаНДС = СтрокаТЧ.Номенклатура.СтавкаНДС;//ксп_ИмпортСлужебный.ОпределитьСтавкуНДСПоПеречислениюРозницы(стрк.СтавкаНДС);

		СтрокаТЧ.Сумма = стрк.Сумма;

		СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;

		СтрокаТЧ.СуммаСНДС = стрк.Сумма;

		//СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиЕдиницуИзмерения(стрк.Упаковка, стрк.Номенклатура);

		СтрокаТЧ.Цена = стрк.Цена;
		
		СтрокаТЧ.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Отгрузить;
		
		СтрокаТЧ.ДатаОтгрузки = ОбъектДанных.Дата;

	КонецЦикла;

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


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиДоговорРеализации(Контрагент, Организация) Экспорт
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДоговорыКонтрагентов.Ссылка КАК Договор
		|ИЗ
		|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
		|ГДЕ
		|	ДоговорыКонтрагентов.ТипДоговора = &ТипДоговора
		|	И ДоговорыКонтрагентов.Организация = &Организация
		|	И ДоговорыКонтрагентов.Контрагент = &Контрагент";
	
	
	ТипДоговора = Перечисления.ТипыДоговоров.СПокупателем;
	
	Запрос.УстановитьПараметр("ТипДоговора", ТипДоговора);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Договор;
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
Функция НайтиСоздатьОбъектРасчетов(ДокСсылка) Экспорт
	
	
		
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

 // Описание_метода
//
// Параметры:
//  Параметр1   - Тип1 -
//
Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции

мВнешняяСистема = "bazap";
ИмяСобытияЖР = "Импорт_из_RabbitMQ_БазаП";
 
СобиратьНенайденнуюНоменклатуру = Истина;
НеНайденнаяНоменклатураМассив = Новый Массив;

НЕ_ЗАГРУЖАТЬ = 1;
СОЗДАТЬ = 2;
ОБНОВИТЬ = 3;
ОТМЕНИТЬ_ПРОВЕДЕНИЕ = 4;

 СобиратьНенайденныхКонтрагентов = Истина;
 НеНайденныеКонтрагентыМассив = Новый Массив;   

 