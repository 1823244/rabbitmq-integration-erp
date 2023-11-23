﻿
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_ВидыЦен");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_ВидыЦен");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Справочник_ВидыЦен",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Справочник_ВидыЦен",
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
	
	Если НЕ НРег(СтруктураОбъекта.type) = "справочник.видыцен" Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;                                                    
	def = СтруктураОбъекта.definition;                                                    

	//------------------------------------- работа с мэппингом
	
	// Если нашли скидку по мэппингу - выходим.
	// Если такого ГУИДа в регистре еще нет - добавляем
	
	НаименованиеДляМэппинга = деф.Description+", Код: "+деф.code;
	
	ПоМэппингу = Неопределено;
	Если РегистрыСведений.ксп_МэппингСправочникВидыЦен.ЕстьГУИД(id.Ref, мВнешняяСистема) Тогда
		ПоМэппингу = РегистрыСведений.ксп_МэппингСправочникВидыЦен.ПоМэппингу(id.Ref, мВнешняяСистема);
	Иначе 
		
		РегистрыСведений.ксп_МэппингСправочникВидыЦен.ДобавитьГУИД(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема);
		// здесь идеально было бы отправить алерт, чтобы пользователь проставил мэппинг
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПоМэппингу) Тогда
		Возврат ПоМэппингу;
	КонецЕсли;
	
	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Справочники.ВидыЦен.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		Если деф.isFolder Тогда
			ОбъектДанных = Справочники.ВидыЦен.СоздатьГруппу();
		Иначе 
			ОбъектДанных = Справочники.ВидыЦен.СоздатьЭлемент();
		КонецЕсли;
		СсылкаНового = Справочники.ВидыЦен.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	// кода нет!
	
	ОбъектДанных.Наименование = деф.Description;

	ОбъектДанных.БазовыйВидЦены = Неопределено;

	ОбъектДанных.ВалютаЦены = Справочники.Валюты.НайтиПоКоду(деф.ВалютаЦены);
	
	ОбъектДанных.ВариантОкругления = Перечисления.ВариантыОкругления.ПоАрифметическимПравилам;
	
	//ОбъектДанных.ВспомогательнаяЦена = деф.ВспомогательнаяЦена;
	//ОбъектДанных.ЗапретитьРедактированиеЦеныЗаПределамиОтбора = деф.ЗапретитьРедактированиеЦеныЗаПределамиОтбора;
	ОбъектДанных.Идентификатор = деф.Идентификатор;
	//ОбъектДанных.ИспользоватьПриВыпускеПродукции = деф.ИспользоватьПриВыпускеПродукции;
	
	ОбъектДанных.ИспользоватьПриОптовойПродаже = деф.ИспользоватьПриПродаже;
	
	ОбъектДанных.ИспользоватьПриПередачеМеждуОрганизациями = деф.ИспользоватьПриПередачеМеждуОрганизациями;
	
	//ОбъектДанных.ИспользоватьПриПередачеПродукцииДавальцу = деф.ИспользоватьПриПередачеПродукцииДавальцу;
	ОбъектДанных.ИспользоватьПриПродаже = деф.ИспользоватьПриПродаже;
	
	ОбъектДанных.ИспользоватьПриРозничнойПродаже = деф.ИспользоватьПриПродаже;
	
	//_знч = "";
	//ЕстьЗначение = деф.Назначение.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.Назначение = деф.Назначение.Значение;
	//Иначе
	//	ОбъектДанных.Назначение = Неопределено;
	//КонецЕсли;
	
	//ОбъектДанных.Наценка = деф.Наценка;
	
	//ОбъектДанных.ОграничиватьОтборНоменклатуры = деф.ОграничиватьОтборНоменклатуры;
	
	ОбъектДанных.Округлять = деф.ОкруглятьВБольшуюСторону;
	
	ОбъектДанных.ОкруглятьВБольшуюСторону = деф.ОкруглятьВБольшуюСторону;
	
	ОбъектДанных.ПорогСрабатывания = деф.ПорогСрабатывания;
	
	//ОбъектДанных.ПорогСрабатыванияПриУменьшении = деф.ПорогСрабатыванияПриУменьшении;
	
	ОбъектДанных.РеквизитДопУпорядочивания = деф.РеквизитДопУпорядочивания;
	
	_знч = "";
	ЕстьЗначение = деф.СпособЗаданияЦены.свойство("Значение",_знч);
	Если ЕстьЗначение Тогда
		Если _знч = "ЗадаватьВручную" Тогда
			ОбъектДанных.СпособЗаданияЦены = перечисления.СпособыЗаданияЦен.Вручную;
		ИначеЕсли _знч = "ЗаполнятьПоДаннымИБ" Тогда
			ОбъектДанных.СпособЗаданияЦены = перечисления.СпособыЗаданияЦен.ЗаполнятьПоДаннымИБ;
		ИначеЕсли _знч = "ЗаполнятьПоДаннымИБПриПоступлении" Тогда
			ОбъектДанных.СпособЗаданияЦены = перечисления.СпособыЗаданияЦен.ЗаполнятьПоДаннымИБПриПоступлении;
		ИначеЕсли _знч = "РассчитыватьПоДругимВидамЦен" Тогда
			ОбъектДанных.СпособЗаданияЦены = перечисления.СпособыЗаданияЦен.РассчитыватьПоФормуламОтДругихВидовЦен;
		КонецЕсли;
		
	Иначе
		ОбъектДанных.СпособЗаданияЦены = Неопределено;
	КонецЕсли;
	
	ОбъектДанных.Статус = Перечисления.СтатусыДействияВидовЦен.Действует;

	//ОбъектДанных.СхемаКомпоновкиДанных = деф.СхемаКомпоновкиДанных;
	ОбъектДанных.ТочностьОкругления = 0.01;
	//ОбъектДанных.УстанавливатьЦенуПриВводеНаОсновании = деф.УстанавливатьЦенуПриВводеНаОсновании;
	//ОбъектДанных.Формула = деф.Формула;
	ОбъектДанных.ЦенаВключаетНДС = деф.ЦенаВключаетНДС;

	
	
	// todo Доделать табличные части
	
	
	
	
		
	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();
	
	// Созданный элемент добавляем в регистр мэппингов (если есть), т.к. это выглядит логичным для пользователя
	РегистрыСведений.ксп_МэппингСправочникВидыЦен.ДобавитьЗапись(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема, ОбъектДанных.Ссылка);	

	// сохранить исходный json
	//РегистрыСведений.ксп_ИсходныеДанныеСообщений.ДобавитьЗапись(ОбъектДанных.Ссылка, jsonText);
	
	Возврат ОбъектДанных.Ссылка;
	
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


мВнешняяСистема = "retail";

