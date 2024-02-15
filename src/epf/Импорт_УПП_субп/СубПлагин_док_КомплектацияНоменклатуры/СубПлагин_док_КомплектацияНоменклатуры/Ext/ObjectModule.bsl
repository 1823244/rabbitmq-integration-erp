﻿Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем мНеНайденнаяНоменклатураМассив;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","СубПлагин_док_КомплектацияНоменклатуры");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","СубПлагин_док_КомплектацияНоменклатуры");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : СубПлагин_док_КомплектацияНоменклатуры",
		"Форма_СубПлагин_док_КомплектацияНоменклатуры",
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

	ЗаписьJson = Новый ЗаписьJson;
	ЗаписьJson.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJson, мНеНайденнаяНоменклатураМассив);
	jsonGoods = ЗаписьJson.Закрыть();
	 
	МассивОбъектовJson = Новый Массив;
	МассивОбъектовJson.Добавить(jsonGoods);
	 
	Попытка
	    ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_СписокJsonИзМассива( МассивОбъектовJson, "goods.guid" );
	Исключение
	    т=ОписаниеОшибки();
	    ЗаписьЖурналаРегистрации("ИмпортИзУПП", УровеньЖурналаРегистрации.Предупреждение,,,
	        "Ошибка экспорта ненайденной номенклатуры в УПП. Подробности: "+т);
	КонецПопытки;

	Возврат Рез;
		
КонецФункции

Функция  СоздатьБлокировкуОдногоОбъекта(ДанныеСсылка) 
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("Документ.ПеремещениеТоваров"); 
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
	Рез.Вставить("СборкаТоваров", Неопределено);

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ДокументИзУПП = "КомплектацияНоменклатуры (УПП) № "+деф.Number+" от "+строка(деф.Date);
	
	СуществующийСборка 		= СоздатьПолучитьСсылкуДокумента(id.Ref, "СборкаТоваров");
	
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(СуществующийСборка);
	
	Комментарий = "";    
	
	//СкладПолучательЕРП = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций
	//	.Настройка("УПП-ЗаказНаПроизводство-СкладПолучатель", мВнешняяСистема);
	
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
		СборкаОбъект = СоздатьСборку(СтруктураОбъекта, СуществующийСборка, СкладЕРП);
			
		ЗафиксироватьТранзакцию();          		
		
		Рез.Вставить("СборкаТоваров", СборкаОбъект.Ссылка);
			
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
Функция СоздатьСборку(СтруктураОбъекта, СуществующийСборкаСсылка, СкладЕРП)
	
	ОбъектДанных = Неопределено;
	
	деф = СтруктураОбъекта.definition;
		
	Если ЗначениеЗаполнено(СуществующийСборкаСсылка.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийСборкаСсылка.ПолучитьОбъект();
		ПредставлениеОбъекта = Строка(СуществующийСборкаСсылка);
	Иначе 
		ОбъектДанных = Документы.СборкаТоваров.СоздатьДокумент();
		СсылкаНового = Документы.СборкаТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураОбъекта.identification.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
    
	ОбъектДанных.Дата = деф.Date;
	
    
	//гуид="";
	//ЕстьАтрибут = деф.АналитикаУчетаНоменклатуры.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.АналитикаУчетаНоменклатуры = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.АналитикаУчетаНоменклатуры.Ref ) );
	//Иначе
	//	ОбъектДанных.АналитикаУчетаНоменклатуры = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.АналитикаУчетаНоменклатуры = ксп_ИмпортСлужебный.НайтиАналитикаУчетаНоменклатуры(деф.АналитикаУчетаНоменклатуры);

	//гуид="";
	//ЕстьАтрибут = деф.ВариантКомплектации.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ВариантКомплектации = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ВариантКомплектации.Ref ) );
	//Иначе
	//	ОбъектДанных.ВариантКомплектации = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ВариантКомплектации = ксп_ИмпортСлужебный.НайтиВариантКомплектации(деф.ВариантКомплектации);

	//ОбъектДанных.ВариантПриемкиТоваров = ксп_ИмпортСлужебный.НайтиПеречисление_ВариантПриемкиТоваров(деф.ВариантПриемкиТоваров);
	//ОбъектДанных.ВидыЗапасовУказаныВручную = деф.ВидыЗапасовУказаныВручную;

	ОбъектДанных.ДатаПоступления = ОбъектДанных.Дата;

	//ОбъектДанных.ЗаказНаСборку = ксп_ИмпортСлужебный.НайтиЗаказНаСборку(деф.ЗаказНаСборку);
	//ОбъектДанных.Исправление = деф.Исправление;
	//ОбъектДанных.ИсправляемыйДокумент = ксп_ИмпортСлужебный.НайтиИсправляемыйДокумент(деф.ИсправляемыйДокумент);

	ОбъектДанных.Количество = деф.Количество;
	ОбъектДанных.КоличествоУпаковок = деф.Количество;
	ОбъектДанных.Комментарий = деф.Комментарий;

	//ОбъектДанных.Назначение = ксп_ИмпортСлужебный.НайтиНазначение(деф.Назначение);
	//ОбъектДанных.НаправлениеДеятельности = ксп_ИмпортСлужебный.НайтиНаправлениеДеятельности(деф.НаправлениеДеятельности);


	///////////////////////////////////////////         НЕНАЙДЕННАЯ НОМЕНКЛАТУРА (НАЧАЛО)

    _Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(деф.Номенклатура);
     
    Если ТипЗнч(_Номенклатура) = Тип("СправочникСсылка.Номенклатура") И
        НЕ ЗначениеЗаполнено(_Номенклатура.ВерсияДанных) Тогда
         
        мНеНайденнаяНоменклатураМассив.Добавить(деф.Номенклатура.Ref);
         
    КонецЕсли;
     
    ОбъектДанных.Номенклатура = _Номенклатура;
 
	///////////////////////////////////////////         НЕНАЙДЕННАЯ НОМЕНКЛАТУРА (КОНЕЦ)	
	
	//ОбъектДанных.НоменклатураОсновногоКомпонента = ксп_ИмпортСлужебный.НайтиНоменклатураОсновногоКомпонента(деф.НоменклатураОсновногоКомпонента);

	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);

	//ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.НайтиОтветственный(деф.Ответственный);

	// нет пока такого метода
	//ОбъектДанных.Подразделение = ксп_ИмпортСлужебный.НайтиПодразделение(деф.Подразделение);
	//ОбъектДанных.СборкаПодДеятельность = ксп_ИмпортСлужебный.НайтиПеречисление_СборкаПодДеятельность(деф.СборкаПодДеятельность);
	//ОбъектДанных.Сделка = ксп_ИмпортСлужебный.НайтиСделка(деф.Сделка);
	//ОбъектДанных.Серия = ксп_ИмпортСлужебный.НайтиСерия(деф.Серия);

	ОбъектДанных.Склад = ксп_ИмпортСлужебный.НайтиСклад(деф.Склад, мВнешняяСистема);
	ОбъектДанных.Статус = Перечисления.СтатусыСборокТоваров.СобраноРазобрано;
	ОбъектДанных.СтатусУказанияСерий = 0;	
	//ОбъектДанных.СторнируемыйДокумент = ксп_ИмпортСлужебный.НайтиСторнируемыйДокумент(деф.СторнируемыйДокумент);
	//ОбъектДанных.Упаковка = ксп_ИмпортСлужебный.НайтиУпаковка(деф.Упаковка);
	ОбъектДанных.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(деф.ХарактеристикаНоменклатуры);
	//ОбъектДанных.ХарактеристикаОсновногоКомпонента = ксп_ИмпортСлужебный.НайтиХарактеристикаОсновногоКомпонента(деф.ХарактеристикаОсновногоКомпонента);
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.СборкаТоваров;




	//------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТЧКомплектующие.Количество()-1 Цикл
		стрк = деф.ТЧКомплектующие[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();


		//СтрокаТЧ.АналитикаУчетаНоменклатуры = ксп_ИмпортСлужебный.НайтиАналитикаУчетаНоменклатуры(стрк.АналитикаУчетаНоменклатуры);

		СтрокаТЧ.ДоляСтоимости = стрк.ДоляСтоимости;
		СтрокаТЧ.ИдентификаторСтроки = Строка(Новый УникальныйИдентификатор());
		СтрокаТЧ.КодСтроки = счТовары + 1;
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;

		//СтрокаТЧ.Назначение = ксп_ИмпортСлужебный.НайтиНазначение(стрк.Назначение);

		//////////////////////////////////////////         НЕНАЙДЕННАЯ НОМЕНКЛАТУРА (НАЧАЛО)
 
        _Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);
         
        Если ТипЗнч(_Номенклатура) = Тип("СправочникСсылка.Номенклатура") И
            НЕ ЗначениеЗаполнено(_Номенклатура.ВерсияДанных) Тогда
             
            мНеНайденнаяНоменклатураМассив.Добавить(стрк.Номенклатура.Ref);
             
        КонецЕсли;
         
        СтрокаТЧ.Номенклатура = _Номенклатура;
 
		///////////////////////////////////////////         НЕНАЙДЕННАЯ НОМЕНКЛАТУРА (КОНЕЦ)

		//СтрокаТЧ.Серия = ксп_ИмпортСлужебный.НайтиСерия(стрк.Серия);

		СтрокаТЧ.СтатусУказанияСерий = 0;

		//СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиУпаковка(стрк.Упаковка);

		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);

	КонецЦикла;
	//------------------------------------------------------     ТЧ ДополнительныеРеквизиты






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
	Возврат ЗагрузитьОбъект(СтруктураОбъекта, , СкладЕРП);
	
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
//	ГУИД 	- строка - 36 симв
//
// Возвращаемое значение:
//	Тип: Тип_значения
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

 мВнешняяСистема = "UPP";
 
 ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
 
 