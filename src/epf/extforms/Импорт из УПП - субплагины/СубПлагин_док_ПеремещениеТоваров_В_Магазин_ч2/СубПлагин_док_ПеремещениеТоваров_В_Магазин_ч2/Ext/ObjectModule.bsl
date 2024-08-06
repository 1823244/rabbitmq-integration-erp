﻿Перем НЕ_ЗАГРУЖАТЬ;
Перем СОЗДАТЬ;
Перем ОБНОВИТЬ;
Перем ОТМЕНИТЬ_ПРОВЕДЕНИЕ;
ПЕРЕМ ПОМЕТИТЬ;

Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем jsonText;
Перем СобиратьНенайденнуюНоменклатуру Экспорт;
Перем НеНайденнаяНоменклатураМассив;

Перем мЛоггер;
Перем мИдВызова;
Перем мСкладОтправитель;
Перем мСкладПолучатель;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.16");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","СубПлагин_док_ПеремещениеТоваров_В_Магазин_ч2");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","СубПлагин_док_ПеремещениеТоваров_В_Магазин_ч2");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : СубПлагин_док_ПеремещениеТоваров_В_Магазин_ч2",
		"Форма_СубПлагин_док_ПеремещениеТоваров_В_Магазин_ч2",
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

Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "", СкладЕРПОтправитель = Неопределено, СкладЕРППолучатель = Неопределено) Экспорт
	
	мЛоггер = Вычислить("мис_ЛоггерСервер.getLogger(мИдВызова, ""Субплагин Импорт документов из УПП: ПеремещениеТоваров_В_Магазин_ч2"")");
	
	мЛоггер.Инфо("Субплагин. Версия "+строка(СведенияОВнешнейОбработке().Версия)+". Импорт док. УПП ПеремещениеТоваров_В_Магазин_ч2 №"+СтруктураОбъекта.definition.Number);
	
	Попытка
		
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			Возврат Неопределено;
		КонецЕсли;
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ПеремещениеТоваров") Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		def = СтруктураОбъекта.definition;
		
		мСкладОтправитель = СкладЕРПОтправитель;
		мСкладПолучатель = СкладЕРППолучатель;
		
		Рез = СоздатьДокументыПоСхемеПеремещения_2(СтруктураОбъекта);
		
		//*************************** Экспорт ненайденной номенклатуры ****************
		Попытка
			ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовНоменклатуры(НеНайденнаяНоменклатураМассив);
			Сообщить("Выполнен экспорт ненайденной номенклатуры - " + Строка(НеНайденнаяНоменклатураМассив.Количество()) + " позиций");
		Исключение
			ТекстОшибки = ОписаниеОшибки();
			Сообщить("Ошибка экспорта ненайденной номенклатуры в УПП.");
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение,,,
				"Ошибка экспорта ненайденной номенклатуры в УПП.
				|Подробности: " + ТекстОшибки);
		КонецПопытки;
		//***************************
		
		Возврат Рез;
		
	Исключение
		мЛоггер.ерр("Субплагин ПеремещениеТоваров_В_Магазин_ч2 - Ошибка. Номер "+строка(def.Номер)+". Подробности: "+ОписаниеОшибки());
		ВызватьИсключение;// для помещения в retry
	КонецПопытки;
	
КонецФункции

#КонецОбласти


#Область Схема_Перемещение_2

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: структура
//
Функция СоздатьДокументыПоСхемеПеремещения_2(СтруктураОбъекта)
	
	Результат = Новый Структура;
	Результат.Вставить("ЗаказНаПеремещение", Неопределено);
	Результат.Вставить("ПО", Неопределено);
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ПредставлениеДокументаИзУПП = "ПеремещениеТоваров (УПП) № "+деф.Number+" от "+строка(деф.Date);
	
	//СуществующийЗаказСсылка = Документы["ЗаказНаПеремещение"].ПолучитьСсылку(Новый УникальныйИдентификатор(деф.ДокументОснование.Ref));
	//СуществующийПОСсылка = Документы["ПриходныйОрдерНаТовары"].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	
	СуществующийЗаказСсылка		= ПолучитьСсылкуДокументаПоДаннымID(деф.ДокументОснование, "ЗаказНаПеремещение");
	СуществующийПОСсылка		= ПолучитьСсылкуДокументаПоДаннымID(id, "ПриходныйОрдерНаТовары");
	
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(СуществующийЗаказСсылка);
	МассивСсылок.Добавить(СуществующийПОСсылка);
	
	Комментарий = "";
	
	// -------------------------------------------- БЛОКИРОВКА
	//Если НЕ ЭтоНовый Тогда
	Блокировка = ксп_Блокировки.СоздатьБлокировкуНесколькихОбъектов(МассивСсылок);
	//КонецЕсли;
	
	НачатьТранзакцию();
	
	//Если НЕ ЭтоНовый Тогда
	Попытка
		Блокировка.Заблокировать();
	Исключение
		СообщениеОбОшибке=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка блокировки цепочки документов для "++". Подробности: "+СообщениеОбОшибке);
		ОтменитьТранзакцию();
		
		мЛоггер.ерр("Ошибка загрузки документа (УПП): %1. Подробности: %2", ПредставлениеДокументаИзУПП, СообщениеОбОшибке);
		
		ВызватьИсключение;
	КонецПопытки;
	//КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	Попытка
		
		ЭтоНовый = Истина;
		Если ЗначениеЗаполнено(СуществующийПОСсылка.ВерсияДанных) Тогда
			ЭтоНовый = Ложь;
		КонецЕсли;
		
		Действие = ксп_ИмпортСлужебный.ДействиеСДокументом(ЭтоНовый, СуществующийПОСсылка, деф);
		
		Если Действие = НЕ_ЗАГРУЖАТЬ Тогда
			ОтменитьТранзакцию();
			мЛоггер.инфо("Действие = НЕ Загружать. Документ пропущен: %1", ПредставлениеДокументаИзУПП);
			Результат.Вставить("ПО", СуществующийПОСсылка);
			Возврат Результат;
		КонецЕсли;
		
        // добавлено 2024-07-03
        Если Действие = ПОМЕТИТЬ Тогда
            ОбъектДанных = СуществующийПОСсылка.ПолучитьОбъект();
            ОбъектДанных.УстановитьПометкуУдаления(Истина);
            РегистрыСведений.ксп_ОтложенноеПроведение.УдалитьОтложенноеПроведение(СуществующийПОСсылка);//добавлено 2024-07-03
            ЗафиксироватьТранзакцию();
			Результат.Вставить("ПО", СуществующийПОСсылка);
			мЛоггер.дебаг("Действие = ПОМЕТИТЬ. Документ будет помечен на удаление: %1", ПредставлениеДокументаИзУПП);
			Возврат Результат;
		КонецЕсли;
		
		Если Действие = ОТМЕНИТЬ_ПРОВЕДЕНИЕ Тогда
			ОбъектДанных = СуществующийПОСсылка.ПолучитьОбъект();
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
			ЗафиксироватьТранзакцию();
			мЛоггер.инфо("Действие = Отменить проведение. Документ: %1", ПредставлениеДокументаИзУПП);
			Результат.Вставить("ПО", СуществующийПОСсылка);
			Возврат Результат;
		КонецЕсли;
		
		Если Действие = ОБНОВИТЬ Тогда
			ОбъектДанных = СуществующийПОСсылка.ПолучитьОбъект();
			мЛоггер.инфо("Действие = Обновить. Документ будет обновлен: %1", ПредставлениеДокументаИзУПП);
		ИначеЕсли Действие = СОЗДАТЬ Тогда
			ОбъектДанных = Документы.ПриходныйОрдерНаТовары.СоздатьДокумент();
			СсылкаНового = Документы.ПриходныйОрдерНаТовары.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
			мЛоггер.инфо("Действие = Создать. Документ будет создан: %1", ПредставлениеДокументаИзУПП);
		Иначе 
			ОтменитьТранзакцию();
			ТекстСообщения = "Действие = Неизвестое действие: "+Строка(Действие)+". Документ: " + ПредставлениеДокументаИзУПП;
			мЛоггер.ерр(ТекстСообщения);
			ВызватьИсключение ТекстСообщения;
			
		КонецЕсли;
		
		ЗаполнитьРеквизиты_ПриходныйОрдер(СтруктураОбъекта, СуществующийЗаказСсылка, ОбъектДанных);
		
		//------------------------------------------------------ ФИНАЛ
		
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
		
		// -------------------------------------------- ПОСТ ОБРАБОТКА
		
		#Область Справочник_КСП_РезультатыИмпортаУПП
		СтруктураПараметры = Справочники.КСП_РезультатыИмпортаУПП.СтруктураПараметров();
	
		СтруктураПараметры.Вставить("ВидДокумента", "Документ.ПеремещениеТоваров");
		СтруктураПараметры.Вставить("Номер", деф.Number);
		СтруктураПараметры.Вставить("Дата", деф.Date);
		СтруктураПараметры.Вставить("ГУИД", id.ref);
		СтруктураПараметры.Вставить("Проведен", деф.IsPosted);
		МассивДокументов = Новый Массив;
		МассивДокументов.Добавить(ОбъектДанных.Ссылка);
		
		СтруктураПараметры.Вставить("МассивДокументов", МассивДокументов);
		
		Справочники.КСП_РезультатыИмпортаУПП.ДобавитьЗапись(СтруктураПараметры);
		#конецОбласти
		
		ЗафиксироватьТранзакцию();
		
		мЛоггер.инфо("Найден Документ: %1.
			|Записан Документ: %2.
			|Исходный док. УПП: %4.", 
			СуществующийЗаказСсылка, ОбъектДанных.Ссылка, ПредставлениеДокументаИзУПП);

		Результат.Вставить("ЗаказНаПеремещение", СуществующийЗаказСсылка);
		Результат.Вставить("ПО", ОбъектДанных.Ссылка);
		
	Исключение
		
		СообщениеОбОшибке=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа "+строка(ПредставлениеДокументаИзУПП)+".
			|Подробности: "+СообщениеОбОшибке);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		мЛоггер.ерр("Ошибка загрузки документа (УПП): %1.
		|Подробности: %2", ПредставлениеДокументаИзУПП, СообщениеОбОшибке);
		
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
Функция ЗаполнитьРеквизиты_ПриходныйОрдер(СтруктураОбъекта, СуществующийЗаказСсылка, ОбъектДанных)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	//------------------------------------- Заполнение реквизитов
	
	//ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
	ОбъектДанных.Склад = мСкладПолучатель;
	ОбъектДанных.Отправитель = мСкладОтправитель;
	
	ОбъектДанных.СкладскаяОперация = перечисления.СкладскиеОперации.ПриемкаПоПеремещению;
	ОбъектДанных.Статус = Перечисления.СтатусыПриходныхОрдеров.Принят;
	
	ОбъектДанных.Распоряжение = СуществующийЗаказСсылка;
	
	ОбъектДанных.Комментарий = СтрШаблон("схема В_Магазин_ч2: [УПП ПеремещениеТоваров № %1 от %2 ]
		|мСкладОтправитель: %3
		|мСкладПолучатель: %4
		|Оригинальный комментарий: %5",
		строка(деф.number),
		строка(деф.date),
		мСкладОтправитель,
		мСкладПолучатель,
		деф.Комментарий,);
		
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПеремещениеТоваров;
		
	//гуид="";
	//ЕстьАтрибут = деф.ЗаданиеНаПеревозку.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ЗаданиеНаПеревозку = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ЗаданиеНаПеревозку.Ref ) );
	//Иначе
	//	ОбъектДанных.ЗаданиеНаПеревозку = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ЗаданиеНаПеревозку = ксп_ИмпортСлужебный.НайтиЗаданиеНаПеревозку(деф.ЗаданиеНаПеревозку);
	
	//гуид="";
	//ЕстьАтрибут = деф.ЗонаОтгрузки.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ЗонаОтгрузки = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ЗонаОтгрузки.Ref ) );
	//Иначе
	//	ОбъектДанных.ЗонаОтгрузки = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ЗонаОтгрузки = ксп_ИмпортСлужебный.НайтиЗонаОтгрузки(деф.ЗонаОтгрузки);
	
	//ОбъектДанных.Комментарий = деф.Комментарий;
	
	//гуид="";
	//ЕстьАтрибут = деф.Контролер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Контролер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Контролер.Ref ) );
	//Иначе
	//	ОбъектДанных.Контролер = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Контролер = ксп_ИмпортСлужебный.НайтиКонтролер(деф.Контролер);
	
	//гуид="";
	//ЕстьАтрибут = деф.Ответственный.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Ответственный = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Ответственный.Ref ) );
	//Иначе
	//	ОбъектДанных.Ответственный = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.НайтиОтветственный(деф.Ответственный);
	
	//ОбъектДанных.ОтгрузкаПоЗаданиюНаПеревозку = деф.ОтгрузкаПоЗаданиюНаПеревозку;
	
	//гуид="";
	//ЕстьАтрибут = деф.Получатель.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Получатель = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Получатель.Ref ) );
	//Иначе
	//	ОбъектДанных.Получатель = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	
	
	//гуид="";
	//ЕстьАтрибут = деф.Помещение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Помещение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Помещение.Ref ) );
	//Иначе
	//	ОбъектДанных.Помещение = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Помещение = ксп_ИмпортСлужебный.НайтиПомещение(деф.Помещение);
	
	//ОбъектДанных.ПорядокДоставки = деф.ПорядокДоставки;
	
	//ОбъектДанных.РежимПросмотраПоТоварам = деф.РежимПросмотраПоТоварам;
	
	////------------------------------------------------------     ТЧ ТоварыПоРаспоряжениям
	
	ОбъектДанных.Товары.Очистить();
	
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
		
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
		
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;
		
	КонецЦикла;
	
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

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
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

#КонецОбласти


#Область Служебные

// Описание_метода
//
// Параметры:
//	ГУИД 	- строка - 36 симв
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьПолучитьСсылкуДокумента(ГУИД, ВидОбъекта)
	
	СуществующийОбъект = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		Возврат СуществующийОбъект;
	Иначе 
		
		ОбъектДанных = Документы[ВидОбъекта].СоздатьДокумент();
		СсылкаНового = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		
		Возврат ОбъектДанных.Ссылка;
	КонецЕсли;
	
КонецФункции
Функция ПолучитьСсылкуДокументаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	
	Если Не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Документы[ВидОбъекта].ПустаяСсылка();;
	КонецЕсли;
	
	ГУИД = "";
	Если СтруктураID.Свойство("Ref", ГУИД) Тогда
		Если НЕ ЗначениеЗаполнено(ГУИД) ИЛИ ГУИД="00000000-0000-0000-0000-000000000000" Тогда
			Возврат Документы[ВидОбъекта].ПустаяСсылка();
		КонецЕсли;
		Возврат Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	Иначе
		Возврат Документы[ВидОбъекта].ПустаяСсылка();
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
		ИЛИ ТипЗнч(ДокументСсылка) = Тип("ДокументСсылка.ПриходныйОрдерНаТовары") Тогда
		
		НовСтр = ТЗ.Добавить();
		НовСтр.ИмяТЧ = "Товары";
		НовСтр.ИмяКолонки = "Номенклатура";
		НовСтр = ТЗ.Добавить();
		НовСтр.ИмяТЧ = "Товары";
		НовСтр.ИмяКолонки = "Характеристика";
		
	КонецЕсли;
	
	Возврат ТЗ;
	
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

#КонецОбласти


мВнешняяСистема = "UPP";
ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
СобиратьНенайденнуюНоменклатуру = Истина;
НеНайденнаяНоменклатураМассив = Новый Массив;

НЕ_ЗАГРУЖАТЬ = 1;
СОЗДАТЬ = 2;
ОБНОВИТЬ = 3;
ОТМЕНИТЬ_ПРОВЕДЕНИЕ = 4;
ПОМЕТИТЬ = 5;