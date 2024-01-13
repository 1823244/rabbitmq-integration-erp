﻿
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.5");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_КассыККМ");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_КассыККМ");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Справочник_КассыККМ",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Справочник_КассыККМ",
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
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("справочник.КассыККМ") Тогда
		Возврат Неопределено;
	КонецЕсли;

	ИмяСобытияЖР = "Импорт_из_RabbitMQ_Розница";

	id 	= СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
    ВидОбъекта 			= "КассыККМ";
	ВидРегистраМэппинга = "ксп_МэппингСправочникКассыККМ";

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
	
	ОбъектДанных = Неопределено;
	ДанныеСсылка = Неопределено;
	ЭтоНовый = Ложь;
	Если ЗначениеЗаполнено(ПоМэппингу) Тогда
		ДанныеСсылка = ПоМэппингу;
		
	Иначе 
		
		//------------------------------------- работа с GUID	
		ОбъектДанных = Неопределено;
		ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ПредставлениеОбъекта = Строка(ДанныеСсылка);
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

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	//------------------------------------- Заполнение реквизитов
	// нет кода в ЕРП
	//ОбъектДанных.Код = id.code;
	
	ОбъектДанных.Наименование = деф.description;
	
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
	ОбъектДанных.Владелец = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.owner, мВнешняяСистема);
	ОбъектДанных.Склад = РегистрыСведений.ксп_МэппингМагазинСклад.ПоМэппингу(деф.Магазин, мВнешняяСистема);
	                             
	_ТипКассы = "";
	
	Если деф.ТипКассы.Свойство("Значение", _ТипКассы) Тогда
		Если _ТипКассы = "ФискальныйРегистратор" Тогда
			ОбъектДанных.ТипКассы = Перечисления.ТипыКассККМ.ФискальныйРегистратор;
		ИначеЕсли _ТипКассы = "АвтономнаяККМ" Тогда
			ОбъектДанных.ТипКассы = Перечисления.ТипыКассККМ.АвтономнаяККМ;
		ИначеЕсли _ТипКассы = "ККМOffline" Тогда
			ОбъектДанных.ТипКассы = Перечисления.ТипыКассККМ.ККМOffline;                          
		ИначеЕсли _ТипКассы = "ККМED" Тогда
			ОбъектДанных.ТипКассы = Перечисления.ТипыКассККМ.АвтономноеРМК;
			
		КонецЕсли;
	КонецЕсли;

	ОбъектДанных.ВалютаДенежныхСредств = Константы.ВалютаРегламентированногоУчета.Получить();

	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);

КонецФункции

Функция ЗаполнитьРеквизитыГруппы(ОбъектДанных, СтруктураОбъекта, jsonText = "") Экспорт

	//деф = СтруктураОбъекта.definition;
	//
	////...

	//ОбъектДанных.ОбменДанными.Загрузка = Истина;
	//ОбъектДанных.Записать();

	//ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	//ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	//ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	//ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	//ксп_ИмпортСлужебный.Справочники_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);

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

