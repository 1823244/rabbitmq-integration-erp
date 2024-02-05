﻿ Перем мОрганизация;
 
#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Создание документов Вывод из оборота ИС МП");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Создание документов Вывод из оборота ИС МП");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.7.306"); // ОБЯЗАТЕЛЬНО!!! //(https://forum.infostart.ru/forum9/topic179193/)
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Открыть форму : Создание документов Вывод из оборота ИС МП","Интерактивно",ТипКоманды, Ложь) ;
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Выполнить Создание документов Вывод из оборота ИС МП","Программно",ТипКоманды, Ложь) ;
	
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
	
	Если ИмяКоманды = "Программно" Тогда
		СформироватьДокументыВыводИзОборотаИСМП();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти 	




// Точка входа
Функция СформироватьДокументыВыводИзОборотаИСМП(ДвиженияКМФулфилментСсылка = Неопределено) Экспорт
	
	мОрганизация = Справочники.Организации.НайтиПоРеквизиту("ИНН", "6152001000");
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"Выбрать 
	|	Рег.ДвиженияКМФулфилмент КАК ДвиженияКМФулфилмент,
	|	Рег.ВыводИзОборотаИСМП КАК ВыводИзОборотаИСМП,
	|	Рег.ДвиженияКМФулфилмент.Дата КАК ДатаИсточник,
	|	Рег.ДвиженияКМФулфилмент.ВидОперации КАК ВидОперации,
	|	Рег.ДвиженияКМФулфилмент.Организация КАК ОрганизацияИсточник,
	|	Рег.ДвиженияКМФулфилмент.ВидПродукции КАК ВидПродукцииИсточник,
	|	Рег.ДвиженияКМФулфилмент.НомерЗаказа КАК НомерЗаказаИсточник,
	|	Рег.ДвиженияКМФулфилмент.ДатаЗаказа КАК ДатаЗаказаИсточник,
	|	Рег.ДвиженияКМФулфилмент.Комментарий КАК КомментарийИсточник
	|из 
	|	регистрСведений.ксп_ВыводИзОборотаИСМП КАК Рег
	|где            
	|	&УсловиеНаСтатус
	|	И &УсловиеНаДокумент";
	
	Если ЗначениеЗаполнено(ДвиженияКМФулфилментСсылка) Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"&УсловиеНаДокумент", "Рег.ДвиженияКМФулфилмент = &ДвиженияКМФулфилментСсылка");
		Запрос.УстановитьПараметр("ДвиженияКМФулфилментСсылка", ДвиженияКМФулфилментСсылка);
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"&УсловиеНаСтатус", "1=1");  
	Иначе 
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"&УсловиеНаДокумент", "1=1");  
		УсловиеНаСтатус = "	(Рег.СтатусДокумента = Значение(Перечисление.КСП_СтатусыЗаказовДляВыводаИзОборота.Новый) 
			|	или Рег.СтатусДокумента = Значение(Перечисление.КСП_СтатусыЗаказовДляВыводаИзОборота.пустаяСсылка) 
			|	или Рег.СтатусДокумента = Неопределено)";
		Запрос.Текст = СтрЗаменить(Запрос.Текст,"&УсловиеНаСтатус", УсловиеНаСтатус);  

	КонецЕсли;
	Запрос.УстановитьПараметр("ДвиженияКМФулфилментСсылка", ДвиженияКМФулфилментСсылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Если Выборка.ВидОперации = Перечисления.ВидыДвиженийКМФулфилмент.ВыводИзОборота Тогда
			СформироватьВыводИзОборотаИСМП(Выборка);
		ИначеЕсли Выборка.ВидОперации = Перечисления.ВидыДвиженийКМФулфилмент.ВозвратВОборот Тогда
			СформироватьВозвратВОборотИСМП(Выборка);
		КонецЕсли;
		
	КонецЦикла;
	
КонецФункции

//формирует один (1) документ вывода из оборота
Функция СформироватьВыводИзОборотаИСМП(Выборка) Экспорт
	
	ЭтоНовый = Ложь;
	Если ЗначениеЗаполнено(Выборка.ВыводИзОборотаИСМП)  Тогда                               

		МЗ = РегистрыСведений.СтатусыДокументовИСМП.СоздатьМенеджерЗаписи();
		МЗ.Документ = Выборка.ВыводИзОборотаИСМП;
		МЗ.Прочитать();
		
		Если МЗ.Выбран() Тогда
			Если МЗ.Статус = Перечисления.СтатусыОбработкиВыводаИзОборотаИСМП.Черновик Тогда
				ОбъектДанных = Выборка.ВыводИзОборотаИСМП.ПолучитьОбъект(); 
				Если ОбъектДанных.Проведен Тогда
					ОбъектДанных.записать(РежимЗаписиДокумента.ОтменаПроведения);
				КонецЕсли;
			Иначе 
				Возврат Выборка.ВыводИзОборотаИСМП;
			КонецЕсли;
		КонецЕсли;

	Иначе 
		ОбъектДанных = Документы.ВыводИзОборотаИСМП.СоздатьДокумент();
		ОбъектДанных.УстановитьНовыйНомер();
		ЭтоНовый = Истина;
	КонецЕсли;
	
	ОбъектДанных.Дата = Выборка.ДатаИсточник;

	ОбъектДанных.ВидПервичногоДокумента = Перечисления.ВидыПервичныхДокументовИСМП.Прочее;

	//ОбъектДанных.ВидПродукции = Перечисления.ВидыПродукцииИС.ЛегкаяПромышленность;
	ОбъектДанных.ВидПродукции = Выборка.ВидПродукцииИсточник;
	//ОбъектДанных.Организация = Справочники.Организации.ОрганизацияПоУмолчанию();
	ОбъектДанных.Организация = мОрганизация;//Выборка.ОрганизацияИсточник;
	ОбъектДанных.Комментарий = Выборка.комментарийИсточник;

	ОбъектДанных.НаименованиеПервичногоДокумента = "Заказ интернет-магазина";

	ОбъектДанных.НомерПервичногоДокумента = Выборка.НомерЗаказаИсточник;
	ОбъектДанных.ДатаПервичногоДокумента = Выборка.ДатаЗаказаИсточник;

	ОбъектДанных.Операция = Перечисления.ВидыОперацийИСМП.ВыводИзОборотаРозничнаяПродажа;	


	////------------------------------------------------------     ТЧ Товары


	ОбъектДанных.ШтрихкодыУпаковок.Очистить();
	ОбъектДанных.Товары.Очистить();
	
	ДокОснование = Выборка.ДвиженияКМФулфилмент;

	Для счТовары = 0 По ДокОснование.ДвиженияКодовМаркировки.Количество()-1 Цикл
		стрк = ДокОснование.ДвиженияКодовМаркировки[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();

        // GTIN - строка, 14
		Если Лев(стрк.КодМаркировки, 4) = "(01)" Тогда
			СтрокаТЧ.GTIN = Сред(стрк.КодМаркировки, 5, 14);
		ИначеЕсли Лев(стрк.КодМаркировки, 2) = "01" Тогда
			СтрокаТЧ.GTIN = Сред(стрк.КодМаркировки, 3, 14);
		Иначе 
			СтрокаТЧ.GTIN = Лев(стрк.КодМаркировки, 14);
		КонецЕсли;
		

	//	СтрокаТЧ.КоличествоПотребительскихУпаковок = стрк.КоличествоПотребительскихУпаковок;

	СтрокаТЧ.КоличествоУпаковок = стрк.Количество;

	СтрокаТЧ.Номенклатура = стрк.Номенклатура;
	СтрокаТЧ.Характеристика = стрк.ХарактеристикаНоменклатуры;
	СтрокаТЧ.Количество = стрк.Количество;
	
	//	гуид="";
	//	ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Серия = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Серия.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Серия = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Серия = ксп_ИмпортСлужебный.НайтиСерия(стрк.Серия);

		СтрокаТЧ.СтавкаНДС = стрк.СтавкаНДС;

	//	СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;

		СтрокаТЧ.Сумма = стрк.Сумма;

		СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;

		СтрокаТЧ.СуммаСНДС = стрк.СуммаСНДС;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Упаковка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Упаковка.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Упаковка = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиУпаковка(стрк.Упаковка);

		СтрокаТЧ.Цена = стрк.Цена;    
		
		
		// штрихкод
		
		ШК = НайтиСоздатьШтрихкод(стрк.КодМаркировки, СтрокаТЧ.Номенклатура, СтрокаТЧ.Характеристика);
		
		СтрокаШК = ОбъектДанных.ШтрихкодыУпаковок.Добавить();

		СтрокаШК.ШтрихкодУпаковки = ШК;

	КонецЦикла;

	////------------------------------------------------------ ФИНАЛ

	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();
	
	// Используем типовой код
	ОбъектДанных.ДополнительныеСвойства.Вставить("ЭтоНовый", ЭтоНовый);
	ИнтеграцияИСМП.ЗаписатьСтатусДокументаИСМППоУмолчанию(ОбъектДанных);

	РегистрыСведений.ксп_ВыводИзОборотаИСМП.ДобавитьВыводИзОборота(ДокОснование, ОбъектДанных.Ссылка);
	
	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	Попытка
		ОбъектДанных.Записать(РежимЗаписиДокумента.Проведение);
	Исключение
		т = ОписаниеОшибки();
	    ЗаписьЖурналаРегистрации("ВыводИзОборотаИСМПФулфилмент",
			УровеньЖурналаРегистрации.Ошибка,,,"НЕ удалось провести ВыводИзОборота! Причина: "+т);
	КонецПопытки;
	
	Возврат ОбъектДанных.Ссылка;

КонецФункции

//формирует один (1) документ возврата в оборот
// Параметры
//	Выборка - Выборка из результата запроса - в общем случае это может быть любая коллекция с нужными полями
//
Функция СформироватьВозвратВОборотИСМП(Выборка) Экспорт
	
	ЭтоНовый = Ложь;
	Если ЗначениеЗаполнено(Выборка.ВыводИзОборотаИСМП)  Тогда                               

		МЗ = РегистрыСведений.СтатусыДокументовИСМП.СоздатьМенеджерЗаписи();
		МЗ.Документ = Выборка.ВыводИзОборотаИСМП;
		МЗ.Прочитать();
		
		Если МЗ.Выбран() Тогда
			Если МЗ.Статус = Перечисления.СтатусыОбработкиВозвратаВОборотИСМП.Черновик Тогда
				ОбъектДанных = Выборка.ВыводИзОборотаИСМП.ПолучитьОбъект();  // это ВозвратВОборотИСМП
				Если ОбъектДанных.Проведен Тогда
					ОбъектДанных.записать(РежимЗаписиДокумента.ОтменаПроведения);
				КонецЕсли;
			Иначе 
				Возврат Выборка.ВыводИзОборотаИСМП;
			КонецЕсли;
		КонецЕсли;

	Иначе 
		ОбъектДанных = Документы.ВозвратВОборотИСМП.СоздатьДокумент();
		ОбъектДанных.УстановитьНовыйНомер();
		ЭтоНовый = Истина;
	КонецЕсли;
	
	ОбъектДанных.Дата = Выборка.ДатаИсточник;
	//ОбъектДанных.ВидПродукции = Перечисления.ВидыПродукцииИС.ЛегкаяПромышленность;
	ОбъектДанных.ВидПродукции = Выборка.ВидПродукцииИсточник;
	ОбъектДанных.Организация = мОрганизация;//Выборка.ОрганизацияИсточник;
	ОбъектДанных.Комментарий = Выборка.комментарийИсточник;
	ОбъектДанных.Операция = Перечисления.ВидыОперацийИСМП.ВозвратВОборотПриДистанционномСпособеПродажи;


	////------------------------------------------------------     ТЧ Товары

	ОбъектДанных.Товары.Очистить();
	
	ДокОснование = Выборка.ДвиженияКМФулфилмент;

	Для счТовары = 0 По ДокОснование.ДвиженияКодовМаркировки.Количество()-1 Цикл
		стрк = ДокОснование.ДвиженияКодовМаркировки[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();
				
		СтрокаТЧ.Номенклатура = стрк.Номенклатура;	
		СтрокаТЧ.Характеристика = стрк.ХарактеристикаНоменклатуры;
		ШК = НайтиСоздатьШтрихкод(стрк.КодМаркировки, СтрокаТЧ.Номенклатура, СтрокаТЧ.Характеристика);
		СтрокаТЧ.КодМаркировки = ШК;
	    СтрокаТЧ.ВидПервичногоДокумента = Перечисления.ВидыПервичныхДокументовИСМП.Прочее;
	    СтрокаТЧ.НаименованиеПервичногоДокумента = "Заказ интернет-магазина";
		СтрокаТЧ.НомерПервичногоДокумента = Выборка.НомерЗаказаИсточник;
		СтрокаТЧ.ДатаПервичногоДокумента = Выборка.ДатаЗаказаИсточник;

	КонецЦикла;

	////------------------------------------------------------ ФИНАЛ

	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();	
	
	// Используем типовой код
	ОбъектДанных.ДополнительныеСвойства.Вставить("ЭтоНовый", ЭтоНовый);
	ИнтеграцияИСМП.ЗаписатьСтатусДокументаИСМППоУмолчанию(ОбъектДанных);
	
	РегистрыСведений.ксп_ВыводИзОборотаИСМП.ДобавитьВыводИзОборота(ДокОснование, ОбъектДанных.Ссылка);
	
	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	Попытка
		ОбъектДанных.Записать(РежимЗаписиДокумента.Проведение);
	Исключение
		т = ОписаниеОшибки();
	    ЗаписьЖурналаРегистрации("ВыводИзОборотаИСМПФулфилмент",
			УровеньЖурналаРегистрации.Ошибка,,,"НЕ удалось провести ВозвратВОборот! Причина: "+т);
	КонецПопытки;
		
	Возврат ОбъектДанных.Ссылка;

КонецФункции



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция КонвертироватьВКодМаркировки0121(Знач КодМаркировки)
	
	КодМаркировки0121 = КодМаркировки;
	
	Если СтрДлина(КодМаркировки) >= 27 Тогда
		Если СтрНачинаетсяС(КодМаркировки, "(01)") Тогда
			КодМаркировки0121 = КодМаркировки;
		ИначеЕсли СтрНачинаетсяС(КодМаркировки, "01") Тогда
			КодМаркировки0121 = "(01)" + Сред(КодМаркировки, 3, 14) + "(21)" + Сред(КодМаркировки, 19);
		Иначе
			КодМаркировки0121 = "(01)" + Сред(КодМаркировки, 1, 14) + "(21)" + Сред(КодМаркировки, 15);
		КонецЕсли;	
		
   КонецЕсли;
		
	Возврат КодМаркировки0121;

КонецФункции



// Описание_метода
//
// Параметры:
//	КодМаркировки - Строка - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиСоздатьШтрихкод(КодМаркировки, Номенклатура, Характеристика) Экспорт
		
		КодМаркировки0121 = КонвертироватьВКодМаркировки0121(КодМаркировки);
		
		ШтрихкодУпаковки = Справочники.ШтрихкодыУпаковокТоваров
			.НайтиПоРеквизиту("ЗначениеШтрихкода", КодМаркировки0121);
			
		Если Не ЗначениеЗаполнено(ШтрихкодУпаковки) Тогда
				
			ШК = Справочники.ШтрихкодыУпаковокТоваров.СоздатьЭлемент();
			ШК.Номенклатура 		= Номенклатура;
			ШК.Характеристика 		= Характеристика;
			ШК.ЗначениеШтрихкода 	= КодМаркировки0121;
			ШК.ТипШтрихкода 		= Перечисления.ТипыШтрихкодов.GS1_DataMatrix;
			ШК.ТипУпаковки 			= Перечисления.ТипыУпаковок.МаркированныйТовар;
			ШК.Записать();      
			
			ШтрихкодУпаковки		= ШК.Ссылка;
			
		КонецЕсли;   
		
		Возврат ШтрихкодУпаковки;
	
КонецФункции










