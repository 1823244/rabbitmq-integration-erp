﻿
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_Склады");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_Склады");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Справочник_Склады",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Справочник_Склады",
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


// Описание_метода
//
// Параметры:
//	СтруктураОбъекта	- структура - после метода тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	
	Если НЕ НРег(СтруктураОбъекта.type) = "справочник.склады" Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	id = СтруктураОбъекта.identification;
	def = СтруктураОбъекта.definition;  
	
	// фильтры
	
	Если def.DeletionMark = Истина Тогда
		Возврат Неопределено
	КонецЕсли;
	Если СтрНайти(НРег(def.description), "в пути") <> 0 Тогда
		Возврат Неопределено
	КонецЕсли;
	Если СтрНайти(НРег(def.description), "брак") <> 0 Тогда
		Возврат Неопределено
	КонецЕсли;
	Если СтрНайти(НРег(def.description), "закрыт") <> 0 Тогда
		Возврат Неопределено
	КонецЕсли;

	//------------------------------------- работа с мэппингом
	
	// Если нашли склад по мэппингу - выходим.
	// Если такого ГУИДа в регистре еще нет - добавляем
	
	НаименованиеДляМэппинга = def.Description+", Код: "+id.code;
	СкладПоМэппингу = Неопределено;
	Если РегистрыСведений.ксп_МэппингСправочникСклады.ЕстьГУИД(id.Ref, мВнешняяСистема) Тогда
		СкладПоМэппингу = РегистрыСведений.ксп_МэппингСправочникСклады.ПоМэппингу(id.Ref, мВнешняяСистема);
	Иначе 
		РегистрыСведений.ксп_МэппингСправочникСклады.ДобавитьГУИД(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема);
		// здесь идеально было бы отправить алерт, чтобы пользователь проставил мэппинг
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СкладПоМэппингу) Тогда
		Возврат СкладПоМэппингу;
	КонецЕсли;
	
	//------------------------------------- работа с GUID
	
	// Созданный склад не добавляем в регистр мэппингов, т.к. функция поиска сможет найти его по ГУИДу
	
	СуществующийОбъект = Справочники.Склады.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		Если id.isFolder Тогда
			ОбъектДанных = Справочники.Склады.СоздатьГруппу();
		Иначе 
			ОбъектДанных = Справочники.Склады.СоздатьЭлемент();
		КонецЕсли;
		СсылкаНового = Справочники.Склады.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	// нет кода в ЕРП
	//ОбъектДанных.Код = id.code;
	
	ОбъектДанных.Наименование = def.description;
	ParentRef = "";
	Если id.parent.Свойство("Ref", ParentRef) Тогда
		ОбъектДанных.Родитель = Справочники.Склады.ПолучитьСсылку(Новый УникальныйИдентификатор(ParentRef));
	КонецЕсли;
	
	ОбъектДанных.ПометкаУдаления = def.DeletionMark;
	

	Если id.isFolder Тогда
		ОбъектДанных.ВыборГруппы = Перечисления.ВыборГруппыСкладов.Запретить;
	Иначе 
		Если ТИпЗнч(def.ТипСклада) = Тип("Структура") Тогда
			Если def.ТипСклада.Свойство("Значение") Тогда
				Если НРег(def.ТипСклада.Значение) = Нрег( "ТорговыйЗал" ) Тогда
					ОбъектДанных.ТипСклада = Перечисления.ТипыСкладов.РозничныйМагазин;
				ИначеЕсли НРег(def.ТипСклада.Значение) = Нрег( "СкладскоеПомещение" ) Тогда
					ОбъектДанных.ТипСклада = Перечисления.ТипыСкладов.ОптовыйСклад;
				КонецЕсли;
			Иначе 
				ОбъектДанных.ТипСклада = Перечисления.ТипыСкладов.ОптовыйСклад;
			КонецЕсли;
		Иначе 
			ОбъектДанных.ТипСклада = Перечисления.ТипыСкладов.ОптовыйСклад;
		КонецЕсли;

	КонецЕсли;
	
	// Переопределяем родителя
	//Кожемякин:
	//3. группируем в справочнике 2 склада в папке с названием магазина 
	//и связку берем из розницы склад\магазин
	//ЕНС:
	// У нас есть мэппинг Магазин (Розн) - Склад (ЕРП)
	// Оттуда можно взять название магазина, чтобы создать группу в спр Склады

	Если id.isFolder = Ложь Тогда
		Если def.свойство("Магазин") И def.Магазин.свойство("Ref") Тогда
			Если РегистрыСведений.ксп_МэппингМагазинСклад.ЕстьГуид(def.Магазин.Ref, мВнешняяСистема) Тогда
				НаименованиеМагазина = РегистрыСведений.ксп_МэппингМагазинСклад.НаименованиеМагазина(def.Магазин.Ref, мВнешняяСистема);
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
	КонецЕсли;
	
	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();
	
	// Созданный элемент добавляем в регистр мэппингов (если есть), т.к. это выглядит логичным для пользователя
	РегистрыСведений.ксп_МэппингСправочникСклады.ДобавитьЗапись(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема, ОбъектДанных.Ссылка);	

	// сохранить исходный json
	//РегистрыСведений.ксп_ИсходныеДанныеСообщений.ДобавитьЗапись(ОбъектДанных.Ссылка, jsonText);
	
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


мВнешняяСистема = "retail";

