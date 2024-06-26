﻿Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем jsonText;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_мэппинг_ВидыЦен");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_мэппинг_ВидыЦен");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_мэппинг_ВидыЦен",
		"Плагин_RabbitMQ_импорт_из_УПП_мэппинг_ВидыЦен",
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

	ЧислоЭлементов = 0;
	ЧислоНовыхЭлементов = 0;

	Если типзнч(СтруктураОбъекта) = тип("Массив") Тогда
		Для каждого эл Из СтруктураОбъекта Цикл
			Рез = Загрузить_Справочник_ТипыЦенНоменклатурыRTL(эл);
			Если Рез <> Неопределено Тогда 
				ЧислоЭлементов = ЧислоЭлементов + 1;
				Если Рез = 2 Тогда
					ЧислоНовыхЭлементов = ЧислоНовыхЭлементов + 1;
				КонецЕсли;						
			КонецЕсли;	
		КонецЦикла;
	КонецЕсли; 
	Рез = Строка(ЧислоЭлементов) + "-" + Строка(ЧислоНовыхЭлементов);
	Возврат Рез;
КонецФункции

#Область ЗагрузкаВСправочник

Функция Загрузить_Справочник_ТипыЦенНоменклатурыRTL(СтруктураОбъекта, jsonText = "") Экспорт
	
	//ИмяСобытияЖР = "Импорт_из_RabbitMQ_Розница"; 
	ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП в р-р МэппингВидыЦен";

	Если НЕ НРег(СтруктураОбъекта.type) = НРег("справочник.ТипыЦенНоменклатуры") Тогда
		Сообщить("Тип объекта для импорта: " + СтруктураОбъекта.type);
		Возврат Неопределено;
	КонецЕсли;

	id 	= СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
    ВидОбъекта 			= "ВидыЦен";
	
	ВидРегистраМэппинга = "ксп_МэппингСправочникВидыЦен";

	//------------------------------------- работа с мэппингом
	
	// Если нашли по мэппингу - выходим.
	// Если такого ГУИДа в регистре еще нет - добавляем
	
	НаименованиеДляМэппинга = id.Description + ?(ЗначениеЗаполнено(деф.code),", Код: " + деф.code,"");
	
	ПоМэппингу = 1;
	Если РегистрыСведений[ВидРегистраМэппинга].ЕстьГУИД(id.Ref, мВнешняяСистема) Тогда
		ПоМэппингу = РегистрыСведений[ВидРегистраМэппинга].ПоМэппингу(id.Ref, мВнешняяСистема);
		ПоМэппингу = 1;
	Иначе 
		ПоМэппингу = 2;
		РегистрыСведений[ВидРегистраМэппинга].ДобавитьГУИД(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема);
		// здесь идеально было бы отправить алерт, чтобы пользователь проставил мэппинг
	КонецЕсли;
	
	//Если ЗначениеЗаполнено(ПоМэппингу) Тогда
	//	Возврат ПоМэппингу;
	//КонецЕсли;
	
	//------------------------------------- работа с GUID	
	ОбъектДанных = Неопределено;
	ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	ПредставлениеОбъекта = Строка(ДанныеСсылка);
	ЭтоНовый = Ложь;
	
	Если ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных) Тогда
		 Сообщить("Запись уже есть в Спр-ке Видов цен");
	Иначе	
		
		//Если деф.Свойство("isFolder") И деф.isFolder = Истина Тогда
		//Если деф.Свойство("группа") Тогда 
		//	Если ЗначениеЗаполнено(деф.группа) Тогда
		//		ОбъектДанных = Справочники[ВидОбъекта].СоздатьГруппу();
		//	Иначе 
				ОбъектДанных = Справочники[ВидОбъекта].СоздатьЭлемент();
		//	КонецЕсли;
		//КонецЕсли;
		
		СсылкаНового = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		ЭтоНовый = Истина;
		Сообщить("создаем новый э-т спр-ка");
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
			т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ОбъектДанных.Ссылка,
				"Объект не загружен! Ошибка блокировки объекта <"+ПредставлениеОбъекта+">. Подробности: " + т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
	
//										  ДобавитьЗапись(GUID,   Наименование,            ВнешняяСистема, ВидЦеныСсылка) 
	РегистрыСведений[ВидРегистраМэппинга].ДобавитьЗапись(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема, ОбъектДанных.Ссылка);
	
	
	ЗафиксироватьТранзакцию();          		
	Возврат ПоМэппингу;
//------------------------------------- Заполнение реквизитов СПРАВОЧНИКа
	Попытка			    
		
//	Если деф.Свойство("isFolder") И деф.isFolder = Истина Тогда
//	Если деф.Свойство("группа") Тогда 
//		Если ЗначениеЗаполнено(деф.группа) Тогда
//			ЗаполнитьРеквизитыГруппы(ОбъектДанных, СтруктураОбъекта, jsonText);
//		Иначе 
			//Заполняем реквизиты эл-та справочника
			//Рез = ЗаполнитьРеквизитыЭлемента(ОбъектДанных, СтруктураОбъекта, jsonText);
			// Созданный элемент добавляем в регистр мэппингов (если есть), т.к. это выглядит логичным для пользователя
			РегистрыСведений[ВидРегистраМэппинга].ДобавитьЗапись(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема, ОбъектДанных.Ссылка);
//		КонецЕсли;
		
		ЗафиксироватьТранзакцию();          		
		Возврат ДанныеСсылка;
		
	//КонецЕсли;
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

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
//  ОбъектДанных.Идентификатор = деф.Идентификатор;
//	ОбъектДанных.Наименование = деф.Description;

	ОбъектДанных.Наименование = id.Description;
	ОбъектДанных.БазовыйВидЦены = Неопределено;
//	ОбъектДанных.ВалютаЦены = Справочники.Валюты.НайтиПоКоду(деф.ВалютаЦены);
	ОбъектДанных.ВалютаЦены = Справочники.Валюты.НайтиПоКоду(деф.Валюта); 
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
	ОбъектДанных.ВариантОкругления = Перечисления.ВариантыОкругления.ПоАрифметическимПравилам;
	ОбъектДанных.Статус = Перечисления.СтатусыДействияВидовЦен.Действует;
	ОбъектДанных.ТочностьОкругления = 0.01;
	
	//ОбъектДанных.ВспомогательнаяЦена = деф.ВспомогательнаяЦена;
	//ОбъектДанных.ЗапретитьРедактированиеЦеныЗаПределамиОтбора = деф.ЗапретитьРедактированиеЦеныЗаПределамиОтбора;

	//ОбъектДанных.ИспользоватьПриВыпускеПродукции = деф.ИспользоватьПриВыпускеПродукции;	
	//ОбъектДанных.ИспользоватьПриОптовойПродаже = деф.ИспользоватьПриПродаже;
	//ОбъектДанных.ИспользоватьПриПередачеМеждуОрганизациями = деф.ИспользоватьПриПередачеМеждуОрганизациями;	
	//ОбъектДанных.ИспользоватьПриПередачеПродукцииДавальцу = деф.ИспользоватьПриПередачеПродукцииДавальцу;
	//ОбъектДанных.ИспользоватьПриПродаже = деф.ИспользоватьПриПродаже;
	//ОбъектДанных.ИспользоватьПриРозничнойПродаже = деф.ИспользоватьПриПродаже;
	
	//_знч = "";
	//ЕстьЗначение = деф.Назначение.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.Назначение = деф.Назначение.Значение;
	//Иначе
	//	ОбъектДанных.Назначение = Неопределено;
	//КонецЕсли;
	
	//ОбъектДанных.Наценка = деф.Наценка;
	//ОбъектДанных.ОграничиватьОтборНоменклатуры = деф.ОграничиватьОтборНоменклатуры;
	
	//ОбъектДанных.Округлять = деф.ОкруглятьВБольшуюСторону;	
	//ОбъектДанных.ОкруглятьВБольшуюСторону = деф.ОкруглятьВБольшуюСторону;
	//ОбъектДанных.ПорогСрабатывания = деф.ПорогСрабатывания;
	//ОбъектДанных.РеквизитДопУпорядочивания = деф.РеквизитДопУпорядочивания;
	
	//ОбъектДанных.ПорогСрабатыванияПриУменьшении = деф.ПорогСрабатыванияПриУменьшении;
	
	//_знч = "";
	//ЕстьЗначение = деф.СпособЗаданияЦены.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	Если _знч = "ЗадаватьВручную" Тогда
	//		ОбъектДанных.СпособЗаданияЦены = перечисления.СпособыЗаданияЦен.Вручную;
	//	ИначеЕсли _знч = "ЗаполнятьПоДаннымИБ" Тогда
	//		ОбъектДанных.СпособЗаданияЦены = перечисления.СпособыЗаданияЦен.ЗаполнятьПоДаннымИБ;
	//	ИначеЕсли _знч = "ЗаполнятьПоДаннымИБПриПоступлении" Тогда
	//		ОбъектДанных.СпособЗаданияЦены = перечисления.СпособыЗаданияЦен.ЗаполнятьПоДаннымИБПриПоступлении;
	//	ИначеЕсли _знч = "РассчитыватьПоДругимВидамЦен" Тогда
	//		ОбъектДанных.СпособЗаданияЦены = перечисления.СпособыЗаданияЦен.РассчитыватьПоФормуламОтДругихВидовЦен;
	//	КонецЕсли;
	//Иначе
	//	ОбъектДанных.СпособЗаданияЦены = Неопределено;
	//КонецЕсли;
	
	//ОбъектДанных.СхемаКомпоновкиДанных = деф.СхемаКомпоновкиДанных;
	//ОбъектДанных.УстанавливатьЦенуПриВводеНаОсновании = деф.УстанавливатьЦенуПриВводеНаОсновании;
	//ОбъектДанных.Формула = деф.Формула;
	//ОбъектДанных.ЦенаВключаетНДС = деф.ЦенаВключаетНДС;
	// todo Доделать табличные части
	
	//------------------------------------------------------ ФИНАЛ	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	
	Возврат ОбъектДанных;	
	
КонецФункции

Функция ЗаполнитьРеквизитыГруппы(ОбъектДанных, СтруктураОбъекта, jsonText = "") Экспорт

	деф = СтруктураОбъекта.definition;
	
	//ОбъектДанных.Наименование = деф.Description;
	ОбъектДанных.Наименование = деф.группа;

	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);

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
	
	Рез = ЗагрузитьОбъект(СтруктураОбъекта, json);
	Возврат Рез;
	
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


//мВнешняяСистема = "retail";
мВнешняяСистема = "upp";

