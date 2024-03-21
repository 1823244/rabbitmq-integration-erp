﻿Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем мНеНайденнаяНоменклатураМассив;
Перем мТребуетсяПроведение; // Булево



#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","2.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","СубПлагин_док_ОприходованиеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","СубПлагин_док_ОприходованиеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : СубПлагин_док_ОприходованиеТоваров",
		"Форма_СубПлагин_док_ОприходованиеТоваров",
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

Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "", СкладЕРП = Неопределено ) Экспорт
	
	мНеНайденнаяНоменклатураМассив = Новый Массив;
		
	Рез = СоздатьДокументыПоСхеме(СтруктураОбъекта, СкладЕРП);
	
    ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовНоменклатуры( мНеНайденнаяНоменклатураМассив );

	Возврат Рез;
		
КонецФункции

Функция  СоздатьБлокировкуОдногоОбъекта(ДанныеСсылка) 
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("Документ.ОрдерНаОтражениеИзлишковТоваров"); 
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.УстановитьЗначение("Ссылка",ДанныеСсылка);
	Возврат Блокировка;
КонецФункции
	
#КонецОбласти 	


#Область Схема_1


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: структура
//
Функция СоздатьДокументыПоСхеме(СтруктураОбъекта, СкладЕРП)
	
	Рез = Новый Структура;
	Рез.Вставить("Оприходование", Неопределено);

	Если СтруктураОбъекта.Свойство("identification") = Ложь Тогда
		Возврат Рез;
	КонецЕсли;                                             
	

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	мТребуетсяПроведение = деф.Проведен;
	
	ДокументИзУПП = "ОприходованиеТоваров (УПП) № "+деф.Number+" от "+строка(деф.Date);
	
	СуществующийДокумент 		= СоздатьПолучитьСсылкуДокумента(id.Ref, "ОрдерНаОтражениеИзлишковТоваров");
	
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(СуществующийДокумент);
	
	// -------------------------------------------- БЛОКИРОВКА
	// не будем различать ситуации Новый/НеНовый
	//Если НЕ ЭтоНовый Тогда
		Блокировка = ксп_Блокировки.СоздатьБлокировкуНесколькихОбъектов(МассивСсылок);
	//КонецЕсли;
	
	НачатьТранзакцию();
	
	//Если НЕ ЭтоНовый Тогда
		Попытка
			Блокировка.Заблокировать();
		Исключение
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
				"Объект не загружен! Ошибка блокировки цепочки документов для "+ДокументИзУПП+". Подробности: "+т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	//КонецЕсли;
		
	//------------------------------------- Заполнение реквизитов
	Попытка	
				
		ДокументОбъект = СоздатьОприходование(СтруктураОбъекта, СуществующийДокумент, СкладЕРП);
			
		ЗафиксироватьТранзакцию();          		
		
		Рез.Вставить("Оприходование", ДокументОбъект.Ссылка);
			
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа "+ДокументИзУПП+". Подробности: "+т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;	

	Возврат Рез;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьОприходование(СтруктураОбъекта, СуществующийДокументСсылка, СкладЕРП)
	
	ОбъектДанных = Неопределено;
	
	деф = СтруктураОбъекта.definition;
		
	Если ЗначениеЗаполнено(СуществующийДокументСсылка.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийДокументСсылка.ПолучитьОбъект();
		ПредставлениеОбъекта = Строка(СуществующийДокументСсылка); 
		
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
			// перечитаем документ, чтобы не было ошибки "Данные изменены"
			СсылкаНаДокумент = ОбъектДанных.Ссылка;
			ОбъектДанных = СсылкаНаДокумент.ПолучитьОбъект();
		КонецЕсли;	
		
	Иначе 
		ОбъектДанных = Документы.ОрдерНаОтражениеИзлишковТоваров.СоздатьДокумент();
		СсылкаНового = Документы.ОрдерНаОтражениеИзлишковТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураОбъекта.identification.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
    
	ОбъектДанных.Дата = деф.Date;
    
	ОбъектДанных.Склад = СкладЕРП;
	ОбъектДанных.Комментарий = деф.Комментарий;
	ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию(); //деф.Ответственный.Ref;


	//------------------------------------------------------     ТЧ Товары

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
	            Если мНеНайденнаяНоменклатураМассив.Найти(НомГУИД) = Неопределено Тогда
	                мНеНайденнаяНоменклатураМассив.Добавить(НомГУИД);
	            КонецЕсли;
			КонецЕсли;
           
        КонецЕсли;
         
        СтрокаТЧ.Номенклатура = _Номенклатура;
 
		///////////////////////////////////////////         НЕНАЙДЕННАЯ НОМЕНКЛАТУРА (КОНЕЦ)

		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);

		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;
		
	КонецЦикла;

	//------------------------------------------------------ ФИНАЛ
	
	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	ОбъектДанных.Записать();
	
	jsonText = "";
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);	

	Возврат ОбъектДанных;
	
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
Функция ЗагрузитьИзJsonНаСервере(Json, СкладЕРП) export

	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.УстановитьСтроку(Json);
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		
		Для каждого эл Из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(эл,,СкладЕРП);
		КонецЦикла;
		
	Иначе 
		Возврат ЗагрузитьОбъект(СтруктураОбъекта, , СкладЕРП);
	КонецЕсли;
	
	
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
	мРеквизиты.Добавить("Склад");
	Возврат мРеквизиты;
	
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
//	Тип: ДокументСсылка
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

// Описание_метода
//
// Параметры:
//	ГУИД 	- строка - 36 симв
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ПолучитьСсылкуДокумента(ГУИД, ВидОбъекта)

	СуществующийОбъект 		= Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	
	Возврат СуществующийОбъект;
    
КонецФункции

#КонецОбласти 	

Функция ТребуетсяПроведение() Экспорт
		
	Возврат мТребуетсяПроведение;
	
КонецФункции


 мВнешняяСистема = "UPP";
 
 ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
 
 

мТребуетсяПроведение = Ложь;

