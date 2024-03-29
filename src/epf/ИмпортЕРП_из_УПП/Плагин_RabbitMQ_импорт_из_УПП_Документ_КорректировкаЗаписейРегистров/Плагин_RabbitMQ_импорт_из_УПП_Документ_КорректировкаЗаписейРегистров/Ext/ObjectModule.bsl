﻿Перем мЗапросПоискаХарактеристики;
Перем мВнешняяСистема;
Перем СкладУПП;
Перем мНеНайденныхТоваров;
Перем мЛоггер;
Перем мИдВызова;
Перем ИмяСобытияЖР;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.36");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_КорректировкаЗаписейРегистров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_КорректировкаЗаписейРегистров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_КорректировкаЗаписейРегистров",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_КорректировкаЗаписейРегистров",
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
	Перем Результат;
	
	Если НЕ ЗначениеЗаполнено(мИдВызова) Тогда
		мИдВызова = мис_ЛоггерСервер.СоздатьИдВызова(Неопределено, 
		"Импорт Корректировок записей регистров из УПП в ВводОстатковТоваров",ТекущаяДатаСеанса(), , , );
	КонецЕсли;
	
  	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт документов из УПП: Корректировка записей регистров");
	
	РезультатСтруктура =    Новый СТруктура("ВводОстатков,ЗаказНаВнутрПотр" );
	
    Попытка
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.КорректировкаЗаписейРегистров") Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;

		ПредставлениеДокументаУПП 			= "корректировка записей регистров№"+деф.Number+" от "+строка(деф.Date);

		СкладУППСтруктура = Неопределено;
		СкладХраненияСтруктура = Неопределено;
		
		Если Лев(деф.Комментарий,15) = "остатки для ERP" и деф.DeletionMark Тогда
			
			СсылкаВводОстатков = ЗагрузкаОстатков(id,деф,СтруктураОбъекта);
			мЛоггер.инфо("Создан/обновлен документ: %1", СсылкаВводОстатков);
			Результат = СсылкаВводОстатков;
			
			мЛоггер.инфо("Плагин: Импорт Документ.КорректировкаЗаписейРегистров. Из документа УПП № %1 от %2 создан документ ЕРП 'Ввод остатков товаров' № %3 от %4",
				деф.Number,Строка(деф.Date),Результат.Номер,Результат.Дата);
				
			Для счСТрок = 0 По деф.РегистрНакопления_ТоварыНаСкладах.Количество()-1 Цикл
				СкладУППСтруктура = деф.РегистрНакопления_ТоварыНаСкладах[счСТрок]["Склад"];
				Прервать;
			КонецЦикла;
			СкладУПП = ПолучитьСсылкуСправочникаПоДаннымID(СкладУППСтруктура, "КСП_СкладыУПП");
			
			Для счСТрок = 0 По деф.РегистрНакопления_ТоварыНаСкладах.Количество()-1 Цикл
				СкладХраненияСтруктура = деф.РегистрНакопления_ТоварыНаСкладах[счСТрок]["СкладХранения"];
				Прервать;
			КонецЦикла;
			СкладХраненияУПП = ПолучитьСсылкуСправочникаПоДаннымID(СкладХраненияСтруктура, "КСП_СкладыХраненияУПП");
			

		ИначеЕсли Лев(деф.Комментарий,23) = "остатки розницы для ERP" и деф.DeletionMark Тогда
			
			СсылкаВводОстатков = ЗагрузкаОстатков(id,деф,СтруктураОбъекта);
			мЛоггер.инфо("Создан/обновлен документ: %1", СсылкаВводОстатков);
			Результат = СсылкаВводОстатков;
			
			мЛоггер.инфо("Плагин: Импорт Документ.КорректировкаЗаписейРегистров. Из документа УПП № %1 от %2 создан документ ЕРП 'Ввод остатков товаров' № %3 от %4",
				деф.Number,Строка(деф.Date),Результат.Номер,Результат.Дата);
				
			Для счСТрок = 0 По деф.РегистрНакопления_ТоварыВРознице.Количество()-1 Цикл
				СкладУППСтруктура = деф.РегистрНакопления_ТоварыВРознице[счСТрок]["Склад"];
				Прервать;
			КонецЦикла;
			СкладУПП = ПолучитьСсылкуСправочникаПоДаннымID(СкладУППСтруктура, "КСП_СкладыУПП");
			
			Для счСТрок = 0 По деф.РегистрНакопления_ТоварыВРознице.Количество()-1 Цикл
				СкладХраненияСтруктура = деф.РегистрНакопления_ТоварыВРознице[счСТрок]["СкладХранения"];
				Прервать;
			КонецЦикла;
			СкладХраненияУПП = ПолучитьСсылкуСправочникаПоДаннымID(СкладХраненияСтруктура, "КСП_СкладыХраненияУПП");
			
		Иначе
			
			СсылкаКорректировкаЗаписейРегистров = ЗагрузкаКорректировкаЗаписейРегистров(id,деф,СтруктураОбъекта);
			мЛоггер.инфо("Создан/обновлен документ: %1", СсылкаКорректировкаЗаписейРегистров);
			Результат = СсылкаКорректировкаЗаписейРегистров;
			
		КонецЕсли;   
		
		РезультатСтруктура.ВводОстатков = Результат;
		
		// ЕНС. 2024-03-28 Пока отключено, т.к. создаются руками из док-а ВВодОстатков
        //ЗаказНаВнутрПотр = СоздатьРезерв(СтруктураОбъекта, СкладХраненияУПП, ПредставлениеДокументаУПП);
		ЗаказНаВнутрПотр = Неопределено;
		 
        РезультатСтруктура.ЗаказНаВнутрПотр = ЗаказНаВнутрПотр;
		 
		Возврат РезультатСтруктура
			       
//-------------2
		
		
    Исключение
        мЛоггер.ерр("Плагин: Плагин_RabbitMQ_импорт_из_УПП_Документ_КорректировкаЗаписейРегистров . Подробности: "+ОписаниеОшибки());
		ВызватьИсключение;
	КонецПопытки;
	

КонецФункции

Функция ЗагрузкаОстатков(id, деф, СтруктураОбъекта, ВидОбъекта = "ВводОстатковТоваров")
	
	
	ДанныеСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	
	ЭтоНовый = Ложь;
	Если (НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных)) и ЗначениеЗаполнено(ДанныеСсылка.Номер) = Ложь и ЗначениеЗаполнено(ДанныеСсылка.Дата) = Ложь Тогда
		ОбъектДанных = Документы[ВидОбъекта].СоздатьДокумент();
		СсылкаНового = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка("Новый документ ВводОстатковТоваров. Дата = "+строка(деф.Date));
		ЭтоНовый = Истина;
	Иначе 
		
		// ЕНС. 2024-03-28. Не обновляем проведенные!
		Если ДанныеСсылка.Проведен Тогда
			
			мЛоггер.инфо("Пропущен проведенный: "+Строка(ДанныеСсылка));
			
			Возврат ДанныеСсылка;
			
		КонецЕсли;
		
		ОбъектДанных = ДанныеСсылка.ПолучитьОбъект();
		ПредставлениеОбъекта = Строка(ДанныеСсылка);
		
		// ОТМЕНА ПРОВЕДЕНИЯ
		
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
			// перечитаем документ, чтобы не было ошибки "Данные изменены"
			ДанныеСсылка = ОбъектДанных.Ссылка;
			ОбъектДанных = ДанныеСсылка.ПолучитьОбъект();   
			
			мЛоггер.инфо("Отмена проведения: "+Строка(ОбъектДанных));
		КонецЕсли;			
	КонецЕсли; 
	

	
	//------------------------------------- Заполнение реквизитов

	Попытка			
		
		Если Лев(деф.Комментарий,15) = "остатки для ERP" и деф.DeletionMark Тогда
			
			ЗаполнитьДокументВводОстатковТоваров(ОбъектДанных, деф, id);		
			
		ИначеЕсли Лев(деф.Комментарий,23) = "остатки розницы для ERP" и деф.DeletionMark Тогда
			
			
			ЗаполнитьДокументВводОстатковТоваровРозница(ОбъектДанных, деф, id);		
		КонецЕсли;     
		
		ОбъектДанных.Комментарий = ОбъектДанных.Комментарий + ". Дата обновления: " + Строка(ТекущаяДатаСеанса());
			
		
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		т="Объект не загружен! Ошибка в процессе загрузки объекта: <"+ПредставлениеОбъекта+">. Подробности: "+т;
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,т);
		мЛоггер.ерр(т);
		ВызватьИсключение;
	КонецПопытки; 
	
	РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(
		"Документ.ВводОстатковТоваров",
		СкладУПП,
		Неопределено,
		Неопределено,
		"Успешно загружен",
		Неопределено,
		Неопределено,
		Неопределено,
		"",
		ОбъектДанных.Номер,
		ОбъектДанных.Дата,
		Истина,
		id.ref,
		ОбъектДанных.Ссылка); 
	
	ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовНоменклатуры(мНеНайденныхТоваров);

	Возврат ДанныеСсылка;	

КонецФункции

Процедура ЗаполнитьДокументВводОстатковТоваров(ОбъектДанных, деф, id)
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.ПометкаУдаления = Ложь;
	ОбъектДанных.Валюта	= Константы.ВалютаРегламентированногоУчета.Получить();
	ОбъектДанных.Комментарий = деф.Number;
	ОбъектДанных.ЦенаВключаетНДС = Истина;
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковСобственныхТоваров;
	ОбъектДанных.ОтражатьВОперативномУчете = Истина;
	ОбъектДанных.ОтражатьСебестоимость = Истина;  //Нужно проверить есть ли записи в ценах
	ОбъектДанных.ОтражатьВУУ = Истина;
	ОбъектДанных.ВидДеятельностиНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
	ОбъектДанных.НалогообложениеНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
	
	ОбъектДанных.Склад = Неопределено;
	ТЗ_Цены = Новый ТаблицаЗначений;
	ТЗ_Цены.Колонки.Добавить("НоменклатураГУИД",Новый ОписаниеТипов("Строка",,,Новый КвалификаторыСтроки(50)));
	ТЗ_Цены.Колонки.Добавить("ХарактеристикаНоменклатурыГУИД",Новый ОписаниеТипов("Строка",,,Новый КвалификаторыСтроки(50)));
	ТЗ_Цены.Колонки.Добавить("Цена",Новый ОписаниеТипов("Число",,,,Новый КвалификаторыЧисла(15,2)));
	Организация = Неопределено;
	Склад = Неопределено;
	Для каждого строка из деф.РегистрНакопления_Продажи Цикл
		НС = ТЗ_Цены.Добавить();
		НС.НоменклатураГУИД = "";
		Если строка.Номенклатура.Свойство("Ref") Тогда
			НС.НоменклатураГУИД = строка.Номенклатура.Ref;
		КонецЕсли;
		НС.ХарактеристикаНоменклатурыГУИД = "";
		Если строка.ХарактеристикаНоменклатуры.Свойство("Ref") Тогда
			НС.ХарактеристикаНоменклатурыГУИД = строка.ХарактеристикаНоменклатуры.Ref;
		КонецЕсли;

		НС.Цена = строка.Стоимость /  строка.Количество;
		Если Организация = Неопределено Тогда
			Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(строка.Организация, мВнешняяСистема);
		КонецЕсли;
	КонецЦикла;
	ОбъектДанных.Организация = Организация;
	
	ОбъектДанных.Товары.Очистить();
	
	ВидЗапасов = ксп_ИмпортСлужебный.НайтиВидЗапасовСобственныйТовар(ОбъектДанных.Организация);
	Если НЕ ЗначениеЗаполнено(ВидЗапасов) Тогда
		мЛоггер.варн("Не найден вид запасов Собственный товар для организации <%1>!", Организация);
	КонецЕсли;
	
	Для каждого строка из деф.РегистрНакопления_ТоварыНаСкладах Цикл
		НоваяСтрока = ОбъектДанных.Товары.Добавить();

		НоваяСтрока.ВидЗапасов = ВидЗапасов;
		
		НоваяСтрока.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(строка.Номенклатура);
		Если Не ЗначениеЗаполнено(НоваяСтрока.Номенклатура.ВерсияДанных) Тогда
			Если мНеНайденныхТоваров.Найти(НоваяСтрока.Номенклатура) = Неопределено Тогда
				Если строка.Номенклатура.Свойство("Ref") Тогда
					мНеНайденныхТоваров.Добавить(строка.Номенклатура.Ref);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

		Если ЗаполненаСсылка(строка.Номенклатура) Тогда
			НоваяСтрока.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(строка.ХарактеристикаНоменклатуры);
		КонецЕсли;
		
		// ЕНС. 2024-03-28. Ищем/Создаем характеристику "Неопределена", если из УПП ничего не пришло
		Если НЕ ЗначениеЗаполнено(НоваяСтрока.Характеристика) Тогда
			НоваяСтрока.Характеристика = ХарактеристикаНеопределена(НоваяСтрока.Номенклатура);
		КонецЕсли;
		
		НоваяСтрока.Количество = строка.Количество; 
		НоваяСтрока.КоличествоУпаковок = строка.Количество;
		Попытка
			НоменклатураГУИД = строка.Номенклатура.Ref;
		Исключение
			НоменклатураГУИД = "";
		КонецПопытки;
		Попытка
			ХарактеристикаНоменклатурыГУИД = строка.ХарактеристикаНоменклатуры.Ref;
		Исключение
			ХарактеристикаНоменклатурыГУИД = "";
		КонецПопытки;
		Цена = 0;
		ПоискЦены = Новый Структура("НоменклатураГУИД,ХарактеристикаНоменклатурыГУИД",НоменклатураГУИД,ХарактеристикаНоменклатурыГУИД);
		НайдСтрокаЦены = ТЗ_Цены.НайтиСтроки(ПоискЦены);
		Если НайдСтрокаЦены.Количество()>0 Тогда 
			Цена = НайдСтрокаЦены[0].Цена;
		КонецЕсли;
		НоваяСтрока.Цена = Цена;
		НоваяСтрока.Сумма = Цена * НоваяСтрока.Количество; 
		НоваяСтрока.СуммаСНДС = Цена * НоваяСтрока.Количество; 
		НоваяСтрока.СтавкаНДС = НоваяСтрока.Номенклатура.СтавкаНДС;
		Если НоваяСтрока.СтавкаНДС = Справочники.СтавкиНДС.БезНДС или НоваяСтрока.СтавкаНДС = Справочники.СтавкиНДС.ПустаяСсылка() Тогда
			СтНДС = 0;
		Иначе
			СтНДС = НоваяСтрока.СтавкаНДС.Ставка/100;
		КонецЕсли;	
		НоваяСтрока.СуммаНДС = НоваяСтрока.СуммаСНДС / (1 + СтНДС) * СтНДС;
		НоваяСтрока.СуммаБезНДС = НоваяСтрока.СуммаСНДС - НоваяСтрока.СуммаНДС;
		Если Склад = Неопределено Тогда
			Если строка.Склад.Свойство("Ref") Тогда
				СкладУПП = Справочники.КСП_СкладыУПП.ПолучитьСсылку(
					Новый УникальныйИдентификатор(строка.Склад.Ref));
				Склад = ПолучитьСкладERP(СкладУПП);
				Если не ЗначениеЗаполнено(Склад) Тогда
					РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(
						"Документ.ВводОстатковТоваров",
						СкладУПП,
						Неопределено,
						Неопределено,
						"не найден склад ЕРП",
						Неопределено,
						Неопределено,
						Неопределено,
						"",
						ОбъектДанных.Номер,
						ОбъектДанных.Дата,
						Ложь,
						id.ref,
						Неопределено); 
                КонецЕсли;
				ОбъектДанных.Склад = Склад;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла; 
	
	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	ОбъектДанных.Записать();

	Попытка
		// Используем типовой механизм
	 	МестаУчета = РегистрыСведений.АналитикаУчетаНоменклатуры.МестаУчета(
			ОбъектДанных.ХозяйственнаяОперация, ОбъектДанных.Склад, Неопределено, Неопределено);
		ИменаПолей = РегистрыСведений.АналитикаУчетаНоменклатуры.ИменаПолейКоллекцииПоУмолчанию();
		ИменаПолей.СтатусУказанияСерий = "СтатусУказанияСерий";
		РегистрыСведений.АналитикаУчетаНоменклатуры.ЗаполнитьВКоллекции(ОбъектДанных.Товары, МестаУчета, ИменаПолей);
		
		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.Записать();
	Исключение
		т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
	    мЛоггер.ерр("Ошибка заполнения АналитикаУчетаНоменклатуры. Документ все равно загружен. Номер: %1, Подробности: %2", ОбъектДанных.Номер, т);
	КонецПопытки;
	
	
КонецПроцедуры

Процедура ЗаполнитьДокументВводОстатковТоваровРозница(ОбъектДанных, деф, id)
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.ПометкаУдаления = Ложь;
	ОбъектДанных.Валюта	= Константы.ВалютаРегламентированногоУчета.Получить();
	ОбъектДанных.Комментарий = деф.Number;
	ОбъектДанных.ЦенаВключаетНДС = Истина;
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковСобственныхТоваров;
	ОбъектДанных.ОтражатьВОперативномУчете = Истина;
	ОбъектДанных.ОтражатьСебестоимость = Истина;  //Нужно проверить есть ли записи в ценах
	ОбъектДанных.ОтражатьВУУ = Истина;
	ОбъектДанных.ВидДеятельностиНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
	
	ОбъектДанных.Склад = Неопределено;
	ТЗ_Цены = Новый ТаблицаЗначений;
	ТЗ_Цены.Колонки.Добавить("НоменклатураГУИД",Новый ОписаниеТипов("Строка",,,Новый КвалификаторыСтроки(50)));
	ТЗ_Цены.Колонки.Добавить("ХарактеристикаНоменклатурыГУИД",Новый ОписаниеТипов("Строка",,,Новый КвалификаторыСтроки(50)));
	ТЗ_Цены.Колонки.Добавить("Цена",Новый ОписаниеТипов("Число",,,,Новый КвалификаторыЧисла(15,2)));
	Организация = Неопределено;
	Склад = Неопределено;
	Для каждого строка из деф.РегистрНакопления_Продажи Цикл
		НС = ТЗ_Цены.Добавить();
		НС.НоменклатураГУИД = "";
		Если строка.Номенклатура.Свойство("Ref") Тогда
			НС.НоменклатураГУИД = строка.Номенклатура.Ref;
		КонецЕсли;
		НС.ХарактеристикаНоменклатурыГУИД = "";
		Если строка.ХарактеристикаНоменклатуры.Свойство("Ref") Тогда
			НС.ХарактеристикаНоменклатурыГУИД = строка.ХарактеристикаНоменклатуры.Ref;
		КонецЕсли;

		НС.Цена = строка.Стоимость /  строка.Количество;
		Если Организация = Неопределено Тогда
			Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(строка.Организация, мВнешняяСистема);
		КонецЕсли;
	КонецЦикла;
	ОбъектДанных.Организация = Организация;
	
	ОбъектДанных.Товары.Очистить();
	
	ВидЗапасов = ксп_ИмпортСлужебный.НайтиВидЗапасовСобственныйТовар(ОбъектДанных.Организация);
	
	Для каждого строка из деф.РегистрНакопления_ТоварыВРознице Цикл
		НоваяСтрока = ОбъектДанных.Товары.Добавить();

		НоваяСтрока.ВидЗапасов = ВидЗапасов;
		
		НоваяСтрока.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(строка.Номенклатура);
		Если Не ЗначениеЗаполнено(НоваяСтрока.Номенклатура.ВерсияДанных) Тогда
			Если мНеНайденныхТоваров.Найти(НоваяСтрока.Номенклатура) = Неопределено Тогда
				Если строка.Номенклатура.Свойство("Ref") Тогда
					мНеНайденныхТоваров.Добавить(строка.Номенклатура.Ref);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

		Если ЗаполненаСсылка(строка.Номенклатура) Тогда
			НоваяСтрока.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(строка.ХарактеристикаНоменклатуры);
		КонецЕсли;
		НоваяСтрока.Количество = строка.Количество; 
		НоваяСтрока.КоличествоУпаковок = строка.Количество;
		Попытка
			НоменклатураГУИД = строка.Номенклатура.Ref;
		Исключение
			НоменклатураГУИД = "";
		КонецПопытки;
		Попытка
			ХарактеристикаНоменклатурыГУИД = строка.ХарактеристикаНоменклатуры.Ref;
		Исключение
			ХарактеристикаНоменклатурыГУИД = "";
		КонецПопытки;
		Цена = 0;
		ПоискЦены = Новый Структура("НоменклатураГУИД,ХарактеристикаНоменклатурыГУИД",НоменклатураГУИД,ХарактеристикаНоменклатурыГУИД);
		НайдСтрокаЦены = ТЗ_Цены.НайтиСтроки(ПоискЦены);
		Если НайдСтрокаЦены.Количество()>0 Тогда 
			Цена = НайдСтрокаЦены[0].Цена;
		КонецЕсли;
		НоваяСтрока.Цена = Цена;
		НоваяСтрока.Сумма = Цена * НоваяСтрока.Количество; 
		НоваяСтрока.СуммаСНДС = Цена * НоваяСтрока.Количество; 
		НоваяСтрока.СтавкаНДС = НоваяСтрока.Номенклатура.СтавкаНДС;
		Если НоваяСтрока.СтавкаНДС = Справочники.СтавкиНДС.БезНДС или НоваяСтрока.СтавкаНДС = Справочники.СтавкиНДС.ПустаяСсылка() Тогда
			СтНДС = 0;
		Иначе
			СтНДС = НоваяСтрока.СтавкаНДС.Ставка/100;
		КонецЕсли;	
		НоваяСтрока.СуммаНДС = НоваяСтрока.СуммаСНДС / (1 + СтНДС) * СтНДС;
		НоваяСтрока.СуммаБезНДС = НоваяСтрока.СуммаСНДС - НоваяСтрока.СуммаНДС;
		Если Склад = Неопределено Тогда
			Если строка.Склад.Свойство("Ref") Тогда
				СкладУПП = Справочники.КСП_СкладыУПП.ПолучитьСсылку(
					Новый УникальныйИдентификатор(строка.Склад.Ref));
				Склад = ПолучитьСкладERP(СкладУПП);
				Если не ЗначениеЗаполнено(Склад) Тогда
					РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(
						"Документ.ВводОстатковТоваров",
						СкладУПП,
						Неопределено,
						Неопределено,
						"не найден склад ЕРП",
						Неопределено,
						Неопределено,
						Неопределено,
						"",
						ОбъектДанных.Номер,
						ОбъектДанных.Дата,
						Ложь,
						id.ref,
						Неопределено); 
                КонецЕсли;
				ОбъектДанных.Склад = Склад;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	ОбъектДанных.Записать();   
	
	Попытка
		// Используем типовой механизм
	 	МестаУчета = РегистрыСведений.АналитикаУчетаНоменклатуры.МестаУчета(
			ОбъектДанных.ХозяйственнаяОперация, ОбъектДанных.Склад, Неопределено, Неопределено);
		ИменаПолей = РегистрыСведений.АналитикаУчетаНоменклатуры.ИменаПолейКоллекцииПоУмолчанию();
		ИменаПолей.СтатусУказанияСерий = "СтатусУказанияСерий";
		РегистрыСведений.АналитикаУчетаНоменклатуры.ЗаполнитьВКоллекции(ОбъектДанных.Товары, МестаУчета, ИменаПолей);
		
		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.Записать();
	Исключение
		т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
	    мЛоггер.ерр("Ошибка заполнения АналитикаУчетаНоменклатуры. Документ все равно загружен. Номер: %1, Подробности: %2", ОбъектДанных.Номер, т);
	КонецПопытки;
	
КонецПроцедуры


// Вызов субплагина СубПлагин_Резерв_внутр_потреб.epf
// Суплагин создает документ Заказ на внутреннее потребление
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьРезерв(СтруктураОбъекта, СкладХраненияУПП, ПредставлениеДокументаУПП)
		
		// Создание резервов
	id = СтруктураОбъекта.identification;	
	деф = СтруктураОбъекта.definition;	
		
		ВидДокСубПлагин = СтруктураОбъекта.type;
		

		Если НЕ ЗНачениезаполнено(СкладУПП) Тогда
			ВидДокумента 		= ВидДокСубПлагин;
			Склад 				= Неопределено;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Не найден склад УПП!";
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;   
			ОшибкаИсправлена 	= Ложь;
			ГУИДДокументаУПП 	= Id.ref;
			ЗагруженныйДокумент = Неопределено;
			ВидДокументаПриемник = "Документ.ВводОстатковТоваров";
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			ОшибкаИсправлена,
			ГУИДДокументаУПП,
			ЗагруженныйДокумент,
			ВидДокументаПриемник);
								

			Результат = Неопределено;
		Иначе 
			
		КонецЕсли;
		
		ВидДокументаУППСсылка = НайтиВидДокументаУПП(СтруктураОбъекта.type);
		
		Если НЕ ЗНачениезаполнено(ВидДокументаУППСсылка) Тогда
			ВидДокумента 		= ВидДокСубПлагин;
			Склад 				= СкладУПП;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Не найден вид документа УПП! (в спр. ВидыДокументовУПП)";
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено; 
			ОшибкаИсправлена 	= Ложь;
			ГУИДДокументаУПП 	= Id.ref;
			ЗагруженныйДокумент = Неопределено;
			ВидДокументаПриемник = "Документ.ВводОстатковТоваров";
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			ОшибкаИсправлена,
			ГУИДДокументаУПП,
			ЗагруженныйДокумент,
			ВидДокументаПриемник);
								

			Результат = Неопределено;
		КонецЕсли;

		
		//Если НЕ ЗНачениезаполнено(СкладХраненияУПП) Тогда // Было до корректировки Оздьон Е.В. 11.03.2024 19:43 
		Если СкладХраненияУПП=Неопределено Тогда   //Если  Неопределено, тогда ПустаяССылка , это не ошибка 
			СкладХраненияУПП=Справочники.КСП_СкладыХраненияУПП.ПустаяСсылка();
		ИначеЕсли 
			// так проверям на битую ссылку
			НЕ ЗНачениезаполнено(СкладХраненияУПП)
			или (ТипЗнч(СкладХраненияУПП) = Тип( "СправочникСсылка.ксп_СкладыХраненияУПП")
			И НЕ ЗначениеЗаполнено( СкладХраненияУПП.ВерсияДанных)) тогда 
			
			ВидДокумента 		= ВидДокСубПлагин;
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
			Результат = Неопределено;
		КонецЕсли;
		
		// ищем элемент спр Виды операций. Там может быть несколько строк со складом хранения в ТЧ Получатели
		МассивВидОперацииПоСкладу = Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП_Получатели(
			СкладУПП, СкладХраненияУПП); 
			
		//Если НЕ ЗначениеЗаполнено(ВидОперацииПоСкладу) Тогда
		Если МассивВидОперацииПоСкладу.Количество() = 0 Тогда
			ВидДокумента 		= ВидДокСубПлагин;
			Склад 				= СкладУПП;
			СкладОтправитель 	= Неопределено;
			СкладПолучатель 	= Неопределено;
			ТекстСообщения 		= "Не найден в ТЧ Получатели вид операции по складу и складу хранения! Склад: "+строка(СкладУПП)+", Склад хранения: "+строка(СкладХраненияУПП);
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь,
			Id.ref);
								

			результат = Неопределено;
		КонецЕсли;
		
		
//-------------2
		Для каждого ВидОперацииПоСкладу Из МассивВидОперацииПоСкладу Цикл
			
			// ищем логику в строках ТЧ Получатели с 
			ЛогикаОбработки = НайтиЛогикуПоВидуДокумента(ВидОперацииПоСкладу, СкладХраненияУПП, ВидДокументаУППСсылка);	
			
			Если НЕ ЗначениеЗаполнено(ЛогикаОбработки) Тогда
				ВидДокумента 		= ВидДокСубПлагин;
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
									

				//Возврат Неопределено;
				продолжить;
			КонецЕсли;
			
			
			
			СсылкаОбработчика = НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаОбработки, ВидДокументаУППСсылка);
			
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение,,,
			"субплагин: "+строка(СсылкаОбработчика)+" код "+строка(СсылкаОбработчика.код)+
			" вид операции "+Строка(ВидОперацииПоСкладу) + " код " + строка(ВидОперацииПоСкладу.Код)+
			" логика " + строка(ЛогикаОбработки) + " код " + Строка(ЛогикаОбработки.код));
			
			
			Если НЕ ЗначениеЗаполнено(СсылкаОбработчика) Тогда
				ВидДокумента 		= ВидДокСубПлагин;
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
				Результат = ОбъектОбработчика
						.сетИдВызова(мИдВызова)
						.ЗагрузитьОбъект(СтруктураОбъекта,"",ВидОперацииПоСкладу.СкладЕРП);
						
				Если типЗнч(Результат ) = тип("ДокументСсылка.ЗаказНаВнутреннееПотребление") Тогда
								мЛоггер.инфо("Плагин: Импорт Документ.КорректировкаЗаписейРегистров. Из документа УПП № %1 от %2 создан документ ЕРП 'Заказ на внутреннее потребление' № %3 от %4",
									деф.Number,Строка(деф.Date),Результат.Номер,Результат.Дата);
				КонецЕсли;						
			Исключение
				т = НСтр("ru = '"+ОписаниеОшибки()+"'");
			    Сообщить(т, СтатусСообщения.Внимание);
				мЛоггер.ерр("Ошибка при обработке вида операции "+Строка(ВидОперацииПоСкладу)+". Переходим к следующему (если их больше одного). Подробности ошибки: "+т);
				Продолжить;
			КонецПопытки;
			
			//успешно
			
			ВидДокумента 		= ВидДокСубПлагин;
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
			Результат);
			
		КонецЦикла;	  
		
	
КонецФункции



//	НЕ РЕАЛИЗОВАНО !
Функция ЗагрузкаКорректировкаЗаписейРегистров(id, деф, СтруктураОбъекта, ВидОбъекта = "КорректировкаРегистров")
	ВызватьИсключение "Загрузка в документ Корректировка записей регистров не реализована!";
КонецФункции


	
#КонецОбласти 	

#Область СлужебныеЗаполненияИПолученияСсылок
Функция ПолучитьСкладERP(СкладУПП) 

	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	КСП_ВидыОперацийПоСкладамУПП.СкладЕРП КАК СкладЕРП
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
	Возврат Выборка.СкладЕРП;

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
	Возврат ДанныеСсылка;
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
		Попытка
			Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
		Исключение
			Возврат Значение;
		КонецПопытки;
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

Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции

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

Функция Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП_Получатели(СкладУПП, СкладХраненияУПП)
	
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



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ХарактеристикаНеопределена(Номенклатура)
	
	
	мЗапросПоискаХарактеристики.УстановитьПараметр("Владелец", Номенклатура);
	Рез = мЗапросПоискаХарактеристики.Выполнить();
	Если Рез.Пустой() Тогда		
		Хркт = Справочники.ХарактеристикиНоменклатуры.СоздатьЭлемент();
		хркт.Владелец = Номенклатура;
		хркт.Наименование = "Неопределена";
		хркт.НаименованиеПолное = "Неопределена";
		хркт.ВидНоменклатуры = Номенклатура.ВидНоменклатуры;
		хркт.Записать();
		хркт = хркт.Ссылка;
	Иначе 
		Выборка = Рез.Выбрать();
		Выборка.Следующий();
		хркт = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Хркт;
	
КонецФункции


мВнешняяСистема = "UPP";
СкладУПП = Неопределено;
мНеНайденныхТоваров = Новый Массив;
ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

мЗапросПоискаХарактеристики = Новый Запрос;
мЗапросПоискаХарактеристики.Текст = 
	"ВЫБРАТЬ
	|	х.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ХарактеристикиНоменклатуры КАК х
	|ГДЕ
	|	х.Наименование = ""Неопределена""
	|	И х.Владелец = &Владелец";


