﻿
Перем НЕ_ЗАГРУЖАТЬ;
Перем СОЗДАТЬ;
Перем ОБНОВИТЬ;
Перем ОТМЕНИТЬ_ПРОВЕДЕНИЕ;

Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем jsonText;
Перем СобиратьНенайденнуюНоменклатуру Экспорт;
Перем НеНайденнаяНоменклатураМассив;

Перем мЛоггер;
Перем мИдВызова;



#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт
	
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();
	
	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","2.9");
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

Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "", СкладЕРП = Неопределено) Экспорт
	
	мЛоггер = Вычислить("мис_ЛоггерСервер.getLogger(мИдВызова, ""Импорт документов из УПП: ОприходованиеТоваров (УПП)"")");
	
	
	
	мЛоггер.инфо("Субплагин. Импорт док. УПП Оприходование товаров №"+СтруктураОбъекта.definition.Number);
	
	Попытка
		
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			Возврат Неопределено;
		КонецЕсли;
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ОприходованиеТоваров") Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
		
		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;
		
		Рез = СоздатьОбновитьДокумент(СтруктураОбъекта, СкладЕРП);
		
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
		//***************************
		
		Возврат Рез;
		
	Исключение
		мЛоггер.ерр("Плагин: Импорт Документ.ОрдерНаОтражениеИзлишковТоваров. Подробности: "+ОписаниеОшибки());
		ВызватьИсключение;// для помещения в retry
	КонецПопытки;
	
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
//	Тип: Тип_значения
//
Функция СоздатьОбновитьДокумент(СтруктураОбъекта, СкладЕРП) Экспорт
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;   
	
	ПустойДокумент = Документы.ОрдерНаОтражениеИзлишковТоваров.ПустаяСсылка();
	
	ДокументИзУПП = "ОприходованиеТоваров (УПП) № " + деф.Number + " от " + строка(деф.Date);
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition; 
	
	УИД = Новый УникальныйИдентификатор(id.Ref);
	СуществующийДокСсылка = Документы.ОрдерНаОтражениеИзлишковТоваров.ПолучитьСсылку(УИД);
	
	
	Если ЗначениеЗаполнено(СуществующийДокСсылка.ВерсияДанных) Тогда
		ЭтоНовый = Ложь;
	Иначе   
		ЭтоНовый = Истина;
	КонецЕсли;
	
	Комментарий = "";
	
	ПредставлениеДокументаУПП = "ОприходованиеТоваров (УПП) № " + строка(деф.number) + " от " + Строка(деф.date);
	
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
			"Объект не загружен! Ошибка блокировки цепочки документов для " + ДокументИзУПП + ". Подробности: " + т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
	
	Рез = Новый Структура;
	Рез.Вставить("Оприходование", "");
	
	//------------------------------------- Заполнение реквизитов
	
	Попытка			
		
		Действие = ДействиеСДокументом(ЭтоНовый, СуществующийДокСсылка, деф);
		Если Действие = НЕ_ЗАГРУЖАТЬ Тогда
			ОтменитьТранзакцию();                                             
			мЛоггер.инфо("Действие = НЕ Загружать. Документ пропущен: %1", ДокументИзУПП);
			Рез.Вставить("Списание", СуществующийДокСсылка);
			Возврат Рез;
		КонецЕсли;
		
		Если Действие = ОТМЕНИТЬ_ПРОВЕДЕНИЕ Тогда
			ОбъектДанных = СуществующийДокСсылка.ПолучитьОбъект();
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
			ЗафиксироватьТранзакцию();
			мЛоггер.инфо("Действие = Отменить проведение. Документ: %1", ДокументИзУПП);
			Рез.Вставить("Списание", СуществующийДокСсылка);
			Возврат Рез;
		КонецЕсли;
		
		Если Действие = ОБНОВИТЬ Тогда
			ОбъектДанных = СуществующийДокСсылка.ПолучитьОбъект();
			мЛоггер.инфо("Действие = Обновить. Документ будет обновлен: %1", ДокументИзУПП);
		ИначеЕсли Действие = СОЗДАТЬ Тогда
			ОбъектДанных = Документы.ОрдерНаОтражениеНедостачТоваров.СоздатьДокумент();
			СсылкаНового = Документы.ОрдерНаОтражениеНедостачТоваров.ПолучитьСсылку(УИД);
			ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
			мЛоггер.инфо("Действие = Создать. Документ будет создан: %1", ДокументИзУПП);
		Иначе 
			ОтменитьТранзакцию();
			т = "Действие = Неизвестое действие: "+Строка(Действие)+". Документ: " + ДокументИзУПП;
			мЛоггер.ерр(т);
			ВызватьИсключение т;
			
		КонецЕсли;
		
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		
		ЗаполнитьРеквизиты(СтруктураОбъекта, ОбъектДанных, СкладЕРП);
		
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
		
		мЛоггер.инфо("Записан Документ : %1. Исходный док. УПП: %2", ОбъектДанных, ДокументИзУПП);
		
		Рез.Вставить("Оприходование", ОбъектДанных.Ссылка);
		
	Исключение
		
		
		СообщениеОбОшибке = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа " + ДокументИзУПП + ". Подробности: " + СообщениеОбОшибке);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		мЛоггер.ерр("Ошибка загрузки документа (УПП): %1. Подробности: %2", ДокументИзУПП, СообщениеОбОшибке);		
		
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
Функция ЗаполнитьРеквизиты(СтруктураОбъекта, ОбъектДанных, СкладЕРП)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition; 
	
	//------------------------------------- Заполнение реквизитов -----------------------------------
	
	ОбъектДанных.Дата = деф.Date;
	
	ОбъектДанных.Склад = СкладЕРП;
	ОбъектДанных.Комментарий = "[УПП № "+Строка(деф.Number)+" от "+Строка(ОбъектДанных.Дата)+"]"+деф.Комментарий;

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
