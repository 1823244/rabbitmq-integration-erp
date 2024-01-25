﻿
#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.7");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","ОтложенноеПроведение");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","ОтложенноеПроведение");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : ОтложенноеПроведение",
		"Форма_ОтложенноеПроведение",
		ТипКоманды, 
		Ложь) ;
		
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Выполнить отложенное проведение",
		"ВыполнитьОтложенноеПроведение",
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

// Интерфейс для запуска логики обработки.
Процедура ВыполнитьКоманду(ИмяКоманды, ПараметрыВыполнения) Экспорт
	
	Если ИмяКоманды = "ВыполнитьОтложенноеПроведение" Тогда
		ВыполнитьОтложенноеПроведение();
		
	КонецЕсли;
	
КонецПроцедуры



#КонецОбласти 	



// Обработчик команды формы
//
// Параметры:
//	СтруктураОбъекта	- структура - после метода тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ВыполнитьОтложенноеПроведение() Экспорт

	ВремяНач = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	ИДСессии = Строка(Новый УникальныйИдентификатор);
	
    ЗаписьЖурналаРегистрации("ОтложенноеПроведение_ИмпортИзRabbit", 
		УровеньЖурналаРегистрации.Информация,,,
		"Начало сессии отложенного проведения"
		+Символы.ПС+"Сессия ИД: "+ИДСессии);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Рег.ДокументСсылка КАК ДокументСсылка,
		|	Представление(Рег.ДокументСсылка) КАК ПредставлениеДокумента,
		|	Рег.СтатусОбъекта КАК СтатусОбъекта
		|ИЗ
		|	РегистрСведений.ксп_ОтложенноеПроведение КАК Рег
		|Где 
		|	Рег.СтатусПроведения В (&СтатусыПроведения)
		|";

	СтатусыПроведения = Новый Массив;
	СтатусыПроведения.Добавить(Перечисления.КСП_СтатусыОтложенногоПроведения.НеПроведен);
	СтатусыПроведения.Добавить(Перечисления.КСП_СтатусыОтложенногоПроведения.ОшибкаПроведения);
	СтатусыПроведения.Добавить(Перечисления.КСП_СтатусыОтложенногоПроведения.ПустаяСсылка());
	СтатусыПроведения.Добавить(Неопределено);
	СтатусыПроведения.Добавить(null);
	
	Запрос.УстановитьПараметр("СтатусыПроведения", СтатусыПроведения);
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		Если НЕ ЗначениеЗаполнено(ВыборкаДетальныеЗаписи.ДокументСсылка) Тогда
			Продолжить;
		КонецЕсли;
		
		ВыполнитьПроведениеОдногоДокумента(ВыборкаДетальныеЗаписи.ДокументСсылка, ИДСессии);
			
	КонецЦикла;       

	Длительность = ТекущаяУниверсальнаяДатаВМиллисекундах() - ВремяНач;
	
	ЗаписьЖурналаРегистрации("ОтложенноеПроведение_ИмпортИзRabbit", 
		УровеньЖурналаРегистрации.Ошибка,,,
		"Завершение сессии отложенного проведения"
		+Символы.ПС+"Сессия ИД: "+ИДСессии+". Длительность "+строка(Длительность)+" мс");
	                                                                            
	
КонецФункции


// Обработчик команды формы
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПровестиОдинДокумент(ДокументСсылка) Экспорт
		
	ВыполнитьПроведениеОдногоДокумента(ДокументСсылка, "Проведение одного документа");
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ВыполнитьПроведениеОдногоДокумента(ДокументСсылка, ИДСессии = "")
	
	мд = ДокументСсылка.Метаданные();
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить(мд.ПолноеИмя());
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.УстановитьЗначение("Ссылка", ДокументСсылка);
	
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ксп_ОтложенноеПроведение");
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.УстановитьЗначение("ДокументСсылка", ДокументСсылка);

	НЗ = РегистрыСведений.ксп_ОтложенноеПроведение.СоздатьНаборЗаписей();
	НЗ.Отбор.ДокументСсылка.Установить(ДокументСсылка);
	
	Успешно = Ложь;
	
	ОшибкаПроведения = "";
	
	НачатьТранзакцию();
	
	ПредставлениеДокумента = Строка(ДокументСсылка);
	
	Попытка
		
		Блокировка.Заблокировать();
		
		ОбъектДанных = ДокументСсылка.ПолучитьОбъект();
		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
		
		//РегистрыСведений.ксп_ОтложенноеПроведение.УдалитьЗапись(ВыборкаДетальныеЗаписи.ДокументСсылка);
		
		НЗ.Прочитать();
		Для каждого стрк Из НЗ Цикл
			стрк.СтатусПроведения = Перечисления.КСП_СтатусыОтложенногоПроведения.Проведен;
			стрк.ДатаОбработки = ТекущаяДатаСеанса();
			стрк.ОшибкаПроведения = "";
		КонецЦикла;
		
		НЗ.Записать();
		
		Успешно = Истина;
		
		ЗафиксироватьТранзакцию();
		
	Исключение   
		ОтменитьТранзакцию();
		
		т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		
	    ЗаписьЖурналаРегистрации("ОтложенноеПроведение_ИмпортИзRabbit", 
			УровеньЖурналаРегистрации.Ошибка,мд,,
			"Не удалось провести документ через ОтложенноеПроведение! Документ: "+ПредставлениеДокумента+". Подробности: "+т
			+Символы.ПС+"Сессия ИД: "+ИДСессии);
			
		ОшибкаПроведения = т;
	КонецПопытки;
	
	Если НЕ Успешно Тогда
		
		НЗ.Прочитать();
		Для каждого стрк Из НЗ Цикл
			стрк.СтатусПроведения = Перечисления.КСП_СтатусыОтложенногоПроведения.ОшибкаПроведения;
			стрк.ДатаОбработки = ТекущаяДатаСеанса();
			стрк.ОшибкаПроведения = ОшибкаПроведения;
		КонецЦикла;			
		
		НЗ.Записать();
	
	КонецЕсли;
	
    ЗаписьЖурналаРегистрации("ОтложенноеПроведение_ИмпортИзRabbit", 
		УровеньЖурналаРегистрации.Информация,мд,ДокументСсылка,
		"Успешно проведен документ через ОтложенноеПроведение!"
		+Символы.ПС+"Сессия ИД: "+ИДСессии);


КонецФункции

