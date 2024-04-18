﻿Перем НЕ_ЗАГРУЖАТЬ;
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
Перем мСкладОтправитель;
Перем мСкладПолучатель;


#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.3");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","СубПлагин_док_ПеремещениеТоваров_В_Магазин_ч1");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","СубПлагин_док_ПеремещениеТоваров_В_Магазин_ч1");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : СубПлагин_док_ПеремещениеТоваров_В_Магазин_ч1",
		"Форма_СубПлагин_док_ПеремещениеТоваров_В_Магазин_ч1",
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

Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "", СкладЕРПОтправитель = Неопределено, СкладЕРППолучатель = Неопределено ) Экспорт
	
	мЛоггер = Вычислить("мис_ЛоггерСервер.getLogger(мИдВызова, ""Субплагин Импорт документов из УПП: ПеремещениеТоваров_В_Магазин_ч1"")");
	
	мЛоггер.Инфо("Субплагин. Версия "+строка(СведенияОВнешнейОбработке().Версия)+". Импорт док. УПП ПеремещениеТоваров_В_Магазин_ч1 №"+СтруктураОбъекта.definition.Number);
	
	мСкладОтправитель = СкладЕРПОтправитель;
	мСкладПолучатель = СкладЕРППолучатель;
	
	Попытка
		
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			Возврат Неопределено;
		КонецЕсли;
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ПеремещениеТоваров") Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		def = СтруктураОбъекта.definition;
		
		Рез = СоздатьДокументыПоСхемеПеремещения_1(СтруктураОбъекта);
		
		//*************************** Экспорт ненайденной номенклатуры ****************
		Попытка
			ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовНоменклатуры(НеНайденнаяНоменклатураМассив);
			Сообщить("Выполнен экспорт ненайденной номенклатуры - " + Строка(НеНайденнаяНоменклатураМассив.Количество()) + " позиций");
		Исключение
			ТекстОшибки = ОписаниеОшибки();
			Сообщить("Ошибка экспорта ненайденной номенклатуры в УПП.");
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение,,,
				"Ошибка экспорта ненайденной номенклатуры в УПП. Подробности: " + ТекстОшибки);
		КонецПопытки;
		//***************************
		
		Возврат Рез;
		
	Исключение
		
		мЛоггер.ерр("Субплагин ПеремещениеТоваров_В_Магазин_ч1 - Ошибка. Номер "+строка(def.Номер)+". Подробности: "+ОписаниеОшибки());
		ВызватьИсключение;// для помещения в retry
		
	КонецПопытки;
	
КонецФункции

#КонецОбласти 	


#Область Схема_Перемещение_1

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: структура
//
Функция СоздатьДокументыПоСхемеПеремещения_1(СтруктураОбъекта)
	
	Рез = Новый Структура;
	Рез.Вставить("ЗаказНаПеремещение", Неопределено);
	Рез.Вставить("РО", Неопределено);
	Рез.Вставить("Перемещение", Неопределено);

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ПредставлениеДокументаИзУПП = "ПеремещениеТоваров (УПП) № "+деф.Number+" от "+строка(деф.Date);
	
	
	СуществующийЗаказСсылка 		= Документы["ЗаказНаПеремещение"].ПолучитьСсылку(Новый УникальныйИдентификатор(id.ref));
	СуществующийРОСсылка 			= Документы["РасходныйОрдерНаТовары"].ПолучитьСсылку(Новый УникальныйИдентификатор(id.ref));
	СуществующийПеремещениеСсылка 	= Документы["ПеремещениеТоваров"].ПолучитьСсылку(Новый УникальныйИдентификатор(id.ref));

	Рез.Вставить("ЗаказНаПеремещение", СуществующийЗаказСсылка);
	Рез.Вставить("РО", СуществующийРОСсылка);
	Рез.Вставить("Перемещение", СуществующийПеремещениеСсылка);
	
	ЭтоНовый = Истина;
	Если ЗначениеЗаполнено(СуществующийЗаказСсылка.ВерсияДанных) Тогда
		ЭтоНовый = Ложь;
	КонецЕсли;
	
	МассивСсылок = Новый Массив;
	Если НЕ ЭтоНовый Тогда
		МассивСсылок.Добавить(СуществующийЗаказСсылка);
		МассивСсылок.Добавить(СуществующийРОСсылка);
		МассивСсылок.Добавить(СуществующийПеремещениеСсылка);
		Блокировка = ксп_Блокировки.СоздатьБлокировкуНесколькихОбъектов(МассивСсылок);
	КонецЕсли;
	
	
	
	// -------------------------------------------- БЛОКИРОВКА
	
	НачатьТранзакцию();
	
	Если НЕ ЭтоНовый Тогда
		Попытка
			Блокировка.Заблокировать();
		Исключение
			СообщениеОбОшибке=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка блокировки цепочки документов для "+ПредставлениеДокументаИзУПП+". Подробности: "+СообщениеОбОшибке);
			ОтменитьТранзакцию();
			
			мЛоггер.ерр("Ошибка загрузки документа (УПП): %1. Подробности: %2", ПредставлениеДокументаИзУПП, СообщениеОбОшибке);
			
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
	
	// -------------------------------------------- СОБЫТИЕ ДОКУМЕНТА
	
	Попытка
		Действие = ДействиеСДокументом(ЭтоНовый, СуществующийЗаказСсылка, деф);
		
		Если Действие = НЕ_ЗАГРУЖАТЬ Тогда
			ОтменитьТранзакцию();                                             
			мЛоггер.инфо("Действие = НЕ Загружать. Документ пропущен: %1", ПредставлениеДокументаИзУПП);
			Возврат Рез;
		КонецЕсли;
		
		Если Действие = ОТМЕНИТЬ_ПРОВЕДЕНИЕ Тогда
			ЗаказНаПеремещениеОбъект = СуществующийЗаказСсылка.ПолучитьОбъект();
			ЗаказНаПеремещениеОбъект.Записать(РежимЗаписиДокумента.ОтменаПроведения);

			РООбъект = СуществующийРОСсылка.ПолучитьОбъект();
			РООбъект.Записать(РежимЗаписиДокумента.ОтменаПроведения);
			
			ПеремещениеОбъект = СуществующийПеремещениеСсылка.ПолучитьОбъект();
			ПеремещениеОбъект.Записать(РежимЗаписиДокумента.ОтменаПроведения);
			
			ЗафиксироватьТранзакцию();
			мЛоггер.инфо("Действие = Отменить проведение. Документ: %1", ПредставлениеДокументаИзУПП);
			
			Возврат Рез;
		КонецЕсли;
		
		Если Действие = ОБНОВИТЬ Тогда
			ЗаказНаПеремещениеОбъект 	= СуществующийЗаказСсылка.ПолучитьОбъект();
			РООбъект 					= СуществующийРОСсылка.ПолучитьОбъект();
			ПеремещениеОбъект 			= СуществующийПеремещениеСсылка.ПолучитьОбъект();
			
			мЛоггер.инфо("Действие = Обновить. Документы будут обновлены: %1", ПредставлениеДокументаИзУПП);
			
		ИначеЕсли Действие = СОЗДАТЬ Тогда
			ЗаказНаПеремещениеОбъект 	= Документы.ЗаказНаПеремещение.СоздатьДокумент();
			СсылкаНового 				= Документы.ЗаказНаПеремещение.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			ЗаказНаПеремещениеОбъект.УстановитьСсылкуНового(СсылкаНового);

			РООбъект 					= Документы.РасходныйОрдерНаТовары.СоздатьДокумент();
			СсылкаНового 				= Документы.РасходныйОрдерНаТовары.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			РООбъект.УстановитьСсылкуНового(СсылкаНового);

			ПеремещениеОбъект 			= Документы.ПеремещениеТоваров.СоздатьДокумент();
			СсылкаНового 				= Документы.ПеремещениеТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			ПеремещениеОбъект.УстановитьСсылкуНового(СсылкаНового);
			
			мЛоггер.инфо("Действие = Создать. Документы будут созданы: %1", ПредставлениеДокументаИзУПП);
		Иначе 
			ОтменитьТранзакцию();
			ТекстСообщения = "Действие = Неизвестое действие: "+Строка(Действие)+". Документ: " + ПредставлениеДокументаИзУПП;
			мЛоггер.ерр(ТекстСообщения);
			ВызватьИсключение ТекстСообщения;
			
		КонецЕсли;
		
		// -------------------------------------------- ЗАКАЗ НА ПЕРЕМЕЩЕНИЕ
		
		ЗаполнитьРеквизиты_ЗаказНаПеремещение(СтруктураОбъекта, ЗаказНаПеремещениеОбъект);
		
		ЗаказНаПеремещениеОбъект.ОбменДанными.Загрузка = Ложь;
		ЗаказНаПеремещениеОбъект.Записать();
		
		// Документ будет помещен в Отложенное проведение
		jsonText = "";
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ЗаказНаПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ЗаказНаПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ЗаказНаПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ЗаказНаПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ЗаказНаПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		
		// -------------------------------------------- РАСХОДНЫЙ ОРДЕР
		
		
		ЗаполнитьРеквизиты_РасходныйОрдер(СтруктураОбъекта, РООбъект, ЗаказНаПеремещениеОбъект);

		РООбъект.ОбменДанными.Загрузка = Ложь;
		РООбъект.Записать();
		
		// Документ будет помещен в Отложенное проведение
		jsonText = "";
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(РООбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(РООбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(РООбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(РООбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(РООбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		
		// -------------------------------------------- ПЕРЕМЕЩЕНИЕ
		
		ЗаполнитьРеквизиты_Перемещение(СтруктураОбъекта, ПеремещениеОбъект, РООбъект, ЗаказНаПеремещениеОбъект);
		
		ПеремещениеОбъект.ОбменДанными.Загрузка = Ложь;
		ПеремещениеОбъект.Записать();
		
		// Документ будет помещен в Отложенное проведение
		jsonText = "";
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ПеремещениеОбъект, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		
		
		
		// -------------------------------------------- ПОСТ ОБРАБОТКА
		
		#Область Справочник_КСП_РезультатыИмпортаУПП
		СтруктураПараметры = Справочники.КСП_РезультатыИмпортаУПП.СтруктураПараметров();
	
		СтруктураПараметры.Вставить("ВидДокумента", "Документ.ПеремещениеТоваров");
		СтруктураПараметры.Вставить("Номер", деф.Number);
		СтруктураПараметры.Вставить("Дата", деф.Date);
		СтруктураПараметры.Вставить("ГУИД", id.ref);
		СтруктураПараметры.Вставить("Проведен", деф.IsPosted);
		МассивДокументов = Новый Массив;
		МассивДокументов.Добавить(ЗаказНаПеремещениеОбъект.Ссылка);
		МассивДокументов.Добавить(РООбъект.Ссылка);
		МассивДокументов.Добавить(ПеремещениеОбъект.Ссылка);
		
		СтруктураПараметры.Вставить("МассивДокументов", МассивДокументов);
		
		Справочники.КСП_РезультатыИмпортаУПП.ДобавитьЗапись(СтруктураПараметры);
        #конецОбласти
		
		ЗафиксироватьТранзакцию();
		
		мЛоггер.инфо("Записан Документ : %1. Исходный док. УПП: %2", ЗаказНаПеремещениеОбъект, ПредставлениеДокументаИзУПП);
		мЛоггер.инфо("Записан Документ : %1. Исходный док. УПП: %2", РООбъект, ПредставлениеДокументаИзУПП);
		мЛоггер.инфо("Записан Документ : %1. Исходный док. УПП: %2", ПеремещениеОбъект, ПредставлениеДокументаИзУПП);
		
		Рез.Вставить("ЗаказНаПеремещение", ЗаказНаПеремещениеОбъект.Ссылка);
		Рез.Вставить("РО", РООбъект.Ссылка);
		Рез.Вставить("Перемещение", ПеремещениеОбъект.Ссылка);
		
		Возврат Рез;
		
	Исключение
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ошибка = "Объект не загружен! Ошибка в процессе загрузки документа " + ПредставлениеДокументаИзУПП + ". Подробности: " + т;
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,ошибка);
		мЛоггер.ерр(ошибка);
		
	КонецПопытки;	
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗаполнитьРеквизиты_ЗаказНаПеремещение(СтруктураОбъекта, ЗаказНаПеремещениеОбъект)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	
	//------------------------------------- Заполнение реквизитов
	
	//ЗаказНаПеремещениеОбъект.Номер = деф.Number;
	ЗаказНаПеремещениеОбъект.Дата = деф.Date;
	ЗаказНаПеремещениеОбъект.ПометкаУдаления = деф.DeletionMark;
	ЗаказНаПеремещениеОбъект.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	ЗаказНаПеремещениеОбъект.СкладОтправитель = мСкладОтправитель;
	ЗаказНаПеремещениеОбъект.СкладПолучатель = мСкладПолучатель;
	ЗаказНаПеремещениеОбъект.ЖелаемаяДатаПоступления = ЗаказНаПеремещениеОбъект.Дата;
	ЗаказНаПеремещениеОбъект.ВариантПриемкиТоваров = перечисления.ВариантыПриемкиТоваров.МожетПроисходитьБезЗаказовИНакладных;
	ЗаказНаПеремещениеОбъект.Комментарий = "[УПП ПеремещениеТоваров № "+строка(деф.number)+" от "+строка(деф.date)+" ] Оригинальный комментарий: "+деф.Комментарий;
	
	//гуид="";
	//ЕстьАтрибут = деф.ДокументОснование.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ЗаказНаПеремещениеОбъект.ДокументОснование = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ДокументОснование.Ref ) );
	//Иначе
	//	ЗаказНаПеремещениеОбъект.ДокументОснование = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ЗаказНаПеремещениеОбъект.ДокументОснование = ксп_ИмпортСлужебный.НайтиДокументОснование(деф.ДокументОснование);
	
	//ЗаказНаПеремещениеОбъект.ДополнительнаяИнформацияПоДоставке = деф.ДополнительнаяИнформацияПоДоставке;
	

	
	ЗаказНаПеремещениеОбъект.Приоритет = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций.Настройка(
	"ПриоритетДляРТУ_схема1_УПП", мВнешняяСистема);
	ЗаказНаПеремещениеОбъект.Статус = Перечисления.СтатусыВнутреннихЗаказов.КВыполнению;
	ЗаказНаПеремещениеОбъект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПеремещениеТоваров;
	
	
	////------------------------------------------------------     ТЧ Товары
	
	
	ЗаказНаПеремещениеОбъект.Товары.Очистить();
	
	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ЗаказНаПеремещениеОбъект.Товары.Добавить();
		
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
		СтрокаТЧ.НачалоОтгрузки = ЗаказНаПеремещениеОбъект.Дата;
		// пока не надо
		//СтрокаТЧ.Упаковка = СтрокаТЧ.Номенклатура.ЕдиницаИзмерения;
		
		//	СтрокаТЧ.КодСтроки = стрк.КодСтроки;
			
	КонецЦикла;
	
		
	//------------------------------------------------------ ФИНАЛ	
	
	

	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗаполнитьРеквизиты_РасходныйОрдер(СтруктураОбъекта, РООбъект, ЗаказНаПеремещениеОбъект)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
		
		
	РООбъект.Дата = деф.Date;
	РООбъект.ПометкаУдаления = деф.DeletionMark;
	
	РООбъект.Склад = мСкладОтправитель;
	РООбъект.Получатель = мСкладПолучатель;
	
	РООбъект.СкладскаяОперация = перечисления.СкладскиеОперации.ОтгрузкаПоПеремещению;
	РООбъект.Статус = Перечисления.СтатусыРасходныхОрдеров.Отгружен;
	
	РООбъект.Комментарий = "[УПП ПеремещениеТоваров № "+строка(деф.number)+" от "+строка(деф.date)+" ] Оригинальный комментарий: "+деф.Комментарий;
	
	РООбъект.ДатаОтгрузки = деф.Date;
	
	РООбъект.Приоритет = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций
	.Настройка("ПриоритетДляРТУ_схема1_УПП", мВнешняяСистема);
	
	
	
	////------------------------------------------------------     ТЧ ТоварыПоРаспоряжениям
	
	
	
	РООбъект.ТоварыПоРаспоряжениям.Очистить();
	
	
	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = РООбъект.ТоварыПоРаспоряжениям.Добавить();
		
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
		СтрокаТЧ.Распоряжение = ЗаказНаПеремещениеОбъект.Ссылка;
		
	КонецЦикла;
	
	////------------------------------------------------------     ТЧ ОтгружаемыеТовары
	
	
	
	РООбъект.ОтгружаемыеТовары.Очистить();
	
	
	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = РООбъект.ОтгружаемыеТовары.Добавить();
		
		СтрокаТЧ.Номенклатура 		= ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);
		СтрокаТЧ.Характеристика 	= ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
		СтрокаТЧ.Количество 		= стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;
		СтрокаТЧ.Действие 			= Перечисления.ДействияСоСтрокамиОрдеровНаОтгрузку.Отгрузить;
		
	КонецЦикла;
			
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗаполнитьРеквизиты_Перемещение(СтруктураОбъекта, ПеремещениеОбъект, РООбъект, ЗаказНаПеремещениеОбъект)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	
	//ПеремещениеОбъект.Номер = деф.Number;
	ПеремещениеОбъект.Дата = деф.Date;
	ПеремещениеОбъект.ПометкаУдаления = деф.DeletionMark;
	
	ПеремещениеОбъект.ПеремещениеПоЗаказам = Истина;
	ПеремещениеОбъект.ЗаказНаПеремещение = ЗаказНаПеремещениеОбъект.Ссылка;
	
	ПеремещениеОбъект.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	
	ПеремещениеОбъект.СкладОтправитель = мСкладОтправитель;
	
	ПеремещениеОбъект.СкладПолучатель = мСкладПолучатель;
	
	ПеремещениеОбъект.ПеремещениеПоЗаказам = Истина;
	
	// ЕНС пока не заполняем. Нужно изучить поведение документов в режиме отладки
	//ПеремещениеОбъект.Статус = Перечисления.СтатусыПеремещенийТоваров.Принято;
	
	ПеремещениеОбъект.ХозяйственнаяОперация = перечисления.ХозяйственныеОперации.ПеремещениеТоваров;
	
	ПеремещениеОбъект.Комментарий = "[УПП ПеремещениеТоваров № "+строка(деф.number)+" от "+строка(деф.date)+" ] Оригинальный комментарий: "+деф.Комментарий;
	
	
	
	//------------------------------------------------------     ТЧ Товары

	ПеремещениеОбъект.Товары.Очистить();
	
	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ПеремещениеОбъект.Товары.Добавить();
		
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
		СтрокаТЧ.ЗаказНаПеремещение = ЗаказНаПеремещениеОбъект.Ссылка;	
		
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

#КонецОбласти


#Область Служебные

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
	//мРеквизиты.Добавить("Номенклатура");
	//мРеквизиты.Добавить("Характеристика");
	//мРеквизиты.Добавить("Склад");
	//мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
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
