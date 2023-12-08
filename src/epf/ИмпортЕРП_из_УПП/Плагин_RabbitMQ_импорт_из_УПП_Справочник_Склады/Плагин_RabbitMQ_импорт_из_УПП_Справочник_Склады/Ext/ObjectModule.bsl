﻿
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Справочник_Склады");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Справочник_Склады");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Справочник_Склады",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Справочник_Склады",
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
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("справочник.Склады") Тогда
		Возврат Неопределено;
	КонецЕсли;

	ИмяСобытияЖР = "Импорт_из_RabbitMQ_Розница";

	id 	= СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
    ВидОбъекта 			= "Склады";
	ВидРегистраМэппинга = "ксп_МэппингСправочникСклады";
	// фильтры
	
	Если деф.DeletionMark = Истина Тогда
		Возврат Неопределено
	КонецЕсли;
	Если СтрНайти(НРег(деф.description), "в пути") <> 0 Тогда
		Возврат Неопределено
	КонецЕсли;
	Если СтрНайти(НРег(деф.description), "брак") <> 0 Тогда
		Возврат Неопределено
	КонецЕсли;
	Если СтрНайти(НРег(деф.description), "закрыт") <> 0 Тогда
		Возврат Неопределено
	КонецЕсли;

	//------------------------------------- работа с мэппингом
	
	// Если нашли по мэппингу - выходим.
	// Если такого ГУИДа в регистре еще нет - добавляем
	
	НаименованиеДляМэппинга = деф.Description+?(ЗначениеЗаполнено(деф.code),", Код: "+деф.code,"");
	
	ПоМэппингу = Неопределено;
	Если РегистрыСведений[ВидРегистраМэппинга].ЕстьГУИД(id.Ref, мВнешняяСистема) Тогда
		ПоМэппингу = РегистрыСведений[ВидРегистраМэппинга].ПоМэппингу(id.Ref, мВнешняяСистема);
	Иначе 
		РегистрыСведений[ВидРегистраМэппинга].ДобавитьГУИД(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема);
		// здесь идеально было бы отправить алерт, чтобы пользователь проставил мэппинг
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПоМэппингу) Тогда
		Возврат ПоМэппингу;
	КонецЕсли;
	
	//------------------------------------- работа с GUID	
	ОбъектДанных = Неопределено;
	ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	ПредставлениеОбъекта = Строка(ДанныеСсылка);
	ЭтоНовый = Ложь;
	Если НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных) Тогда
		
		Если деф.Свойство("isFolder") И деф.isFolder = Истина Тогда
			ОбъектДанных = Справочники[ВидОбъекта].СоздатьГруппу();
		Иначе 
			ОбъектДанных = Справочники[ВидОбъекта].СоздатьЭлемент();
		КонецЕсли;
		
		СсылкаНового = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		ЭтоНовый = Истина;
	КонецЕсли; 
	
	// -------------------------------------------- БЛОКИРОВКА
	Если НЕ ЭтоНовый Тогда
		Блокировка = ксп_Блокировки.СоздатьБлокировкуОдногоОбъекта(ДанныеСсылка);
	КонецЕсли;

	НачатьТранзакцию();
	
	Если НЕ ЭтоНовый Тогда
		Попытка
			Блокировка.Заблокировать();
			ОбъектДанных = ДанныеСсылка.ПолучитьОбъект();
		Исключение
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ОбъектДанных.Ссылка,
				"Объект не загружен! Ошибка блокировки объекта <"+ПредставлениеОбъекта+">. Подробности: "+т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
		
	//------------------------------------- Заполнение реквизитов
	Попытка			    
		
		Если деф.Свойство("isFolder") И деф.isFolder = Истина Тогда
			ЗаполнитьРеквизитыГруппы(ОбъектДанных, СтруктураОбъекта, jsonText);
		Иначе 
			ЗаполнитьРеквизитыЭлемента(ОбъектДанных, СтруктураОбъекта, jsonText);
			
			// Созданный элемент добавляем в регистр мэппингов (если есть), т.к. это выглядит логичным для пользователя
			РегистрыСведений[ВидРегистраМэппинга].ДобавитьЗапись(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема, ОбъектДанных.Ссылка);	
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();          		
		Возврат ДанныеСсылка;		
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ДанныеСсылка,
			"Объект не загружен! Ошибка в процессе загрузки объекта: <"+ПредставлениеОбъекта+">. Подробности: "+т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;	
			
КонецФункции



// Заполняет реквизиты объекта и пишет сопутствующие данные. Должна вызываться в транзакции.
Функция ЗаполнитьРеквизитыЭлемента(ОбъектДанных, СтруктураОбъекта, jsonText = "") Экспорт

	деф = СтруктураОбъекта.definition;
	
	// нет кода в ЕРП
	//ОбъектДанных.Код = id.code;
	
	ОбъектДанных.Наименование = деф.description;
	ParentRef = "";
	Если деф.parent.Свойство("Ref", ParentRef) Тогда
		ОбъектДанных.Родитель = Справочники.Склады.ПолучитьСсылку(Новый УникальныйИдентификатор(ParentRef));
	КонецЕсли;
	
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
	Если ТИпЗнч(деф.ТипСклада) = Тип("Структура") Тогда
		Если деф.ТипСклада.Свойство("Значение") Тогда
			Если НРег(деф.ТипСклада.Значение) = Нрег( "ТорговыйЗал" ) Тогда
				ОбъектДанных.ТипСклада = Перечисления.ТипыСкладов.РозничныйМагазин;
			ИначеЕсли НРег(деф.ТипСклада.Значение) = Нрег( "СкладскоеПомещение" ) Тогда
				ОбъектДанных.ТипСклада = Перечисления.ТипыСкладов.ОптовыйСклад;
			КонецЕсли;
		Иначе 
			ОбъектДанных.ТипСклада = Перечисления.ТипыСкладов.ОптовыйСклад;
		КонецЕсли;
	Иначе 
		ОбъектДанных.ТипСклада = Перечисления.ТипыСкладов.ОптовыйСклад;
	КонецЕсли;

	// Переопределяем родителя
	//Кожемякин:
	//3. группируем в справочнике 2 склада в папке с названием магазина 
	//и связку берем из розницы склад\магазин
	//ЕНС:
	// У нас есть мэппинг Магазин (Розн) - Склад (ЕРП)
	// Оттуда можно взять название магазина, чтобы создать группу в спр Склады

	Если деф.свойство("Магазин") И деф.Магазин.свойство("Ref") Тогда
		Если РегистрыСведений.ксп_МэппингМагазинСклад.ЕстьГуид(деф.Магазин.Ref, мВнешняяСистема) Тогда
			НаименованиеМагазина = РегистрыСведений.ксп_МэппингМагазинСклад.НаименованиеМагазина(деф.Магазин.Ref, мВнешняяСистема);
			// в регистре в наименовании магазина есть лишний для этой задачи текст. уберем его.
			Поз = СтрНайти(НаименованиеМагазина, ", Код");
			Если Поз > 0 Тогда
				НаименованиеМагазина = Лев(НаименованиеМагазина, Поз-1);
			КонецЕсли;
			
			ГруппаСкладов = НайтиГруппуСкладовПоИмениМагазина(НаименованиеМагазина);
			Если НЕ ЗначениеЗаполнено(ГруппаСкладов) Тогда
				ГруппаСкладов = СоздатьГруппуСкладов(НаименованиеМагазина);
			КонецЕсли;
			
			ОбъектДанных.Родитель = ГруппаСкладов;
			
		КонецЕсли;
	КонецЕсли;

	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);

КонецФункции

Функция ЗаполнитьРеквизитыГруппы(ОбъектДанных, СтруктураОбъекта, jsonText = "") Экспорт

	деф = СтруктураОбъекта.definition;
	
	// нет кода в ЕРП
	//ОбъектДанных.Код = id.code;
	
	ОбъектДанных.Наименование = деф.description;
	ParentRef = "";
	Если деф.parent.Свойство("Ref", ParentRef) Тогда
		ОбъектДанных.Родитель = Справочники.Склады.ПолучитьСсылку(Новый УникальныйИдентификатор(ParentRef));
	КонецЕсли;
	
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
	ОбъектДанных.ВыборГруппы = Перечисления.ВыборГруппыСкладов.Запретить;

	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);

КонецФункции



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиГруппуСкладовПоИмениМагазина(Наименование)
		//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Склады.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Склады КАК Склады
		|ГДЕ
		|	Склады.Наименование = &Наименование
		|	И Склады.ЭтоГруппа = &ЭтоГруппа";
	
	Запрос.УстановитьПараметр("Наименование", Наименование);
	Запрос.УстановитьПараметр("ЭтоГруппа", Истина);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
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
Функция СоздатьГруппуСкладов(НаименованиеМагазина)
	
	обк = Справочники.Склады.СоздатьГруппу();
	обк.Наименование = НаименованиеМагазина;
	обк.Записать();
		
	Возврат обк.Ссылка;
	
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

	
	
	Возврат ЗагрузитьОбъект(СтруктураОбъекта, json);
	
КонецФункции

Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Сумма" Тогда
		Возврат XMLЗначение(Тип("Число"),Значение);
	КонецЕсли;
	Если Свойство = "Валюта" Тогда
		Возврат Справочники.Валюты.НайтиПоКоду(Значение);
	КонецЕсли;
	
КонецФункции


#КонецОбласти 	

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



мВнешняяСистема = "upp";

