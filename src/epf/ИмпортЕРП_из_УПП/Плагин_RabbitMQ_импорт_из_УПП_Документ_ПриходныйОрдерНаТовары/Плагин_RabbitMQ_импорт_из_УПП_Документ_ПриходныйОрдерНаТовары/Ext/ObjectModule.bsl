﻿Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем jsonText;
Перем мСкладПолучатель;
Перем мСкладОтправитель;
Перем мДоговор;
Перем СобиратьНенайденнуюНоменклатуру Экспорт; // дли интерактивного импорта
Перем НеНайденнаяНоменклатураМассив;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_ПриходныйОрдерНаТовары");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_ПоступлениеТоваровУслуг");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_ПриходныйОрдерНаТовары",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_ПриходныйОрдерНаТовары",
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


// Возвращает структуру. Поля различаются в зависимости от режима загрузки.
// Это нужно для отладки, а не для обычного режима работы.
//
Функция ЗагрузитьОбъект(СтруктураОбъекта, пjsonText = "") Экспорт

	Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
		Возврат Неопределено;
	КонецЕсли;
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ПриходныйОрдерНаТовары") Тогда
		Возврат Неопределено;
	КонецЕсли;

	ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	jsonText = пjsonText;
	
	ПредставлениеДокументаУПП = "Приходный ордер на товары №"+строка(деф.number)+" от "+Строка(деф.Date);
	
	//Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, мВнешняяСистема);
	УзелКонтрагента = Неопределено;
	
	//ЕНС. 2024-01-16. Договор теперь хранится в РС "КСП_КомиссионерыДляРеализацийУПП" для каждого контрагента
	//ДоговорКонтрагента = ксп_ИмпортСлужебный.НайтиДоговор(деф.ДоговорКонтрагента, УзелКонтрагента, Контрагент);
	ДоговорКонтрагента = Неопределено;
	
	
	//СкладУПП = Справочники.ксп_СкладыУПП.ПолучитьСсылку(Новый УникальныйИдентификатор(деф.Склад.Ref));
	//ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение, ,,"Нашли склад УПП: "+строка(складУПП));
	//мСкладОтправитель = Справочники.КСП_ВидыОперацийПоСкладамУПП.ПоМэппингу(СкладУПП);
	
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= Неопределено;
		СкладПолучатель 	= Неопределено;
		ТекстСообщения 		= "Приходный ордер на товары: Субплагины еще не реализованы!";
		ЛогикаСклад			= Неопределено;
		ЛогикаПеремещения 	= Неопределено;
		Обработчик 			= Неопределено;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
		деф.Number,
		деф.date,
		Ложь, // ошибки исправлены
		Id.ref);


	
	Возврат "";
	
	
КонецФункции



#Область Тестирование

// вызывается из формы
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервере(JsonText) export

	мЧтениеJSON = Новый ЧтениеJSON;

	
	мЧтениеJSON.УстановитьСтроку(JsonText);
		
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
		
		НеНайденнаяНоменклатураМассив = Новый Массив;
		
		Для Каждого эл из СтруктураОбъекта Цикл
			ЗагрузитьОбъект(эл);
		КонецЦикла;                       
		
		Рез = Новый Структура;
		Рез.Вставить("НеНайденнаяНоменклатураМассив", НеНайденнаяНоменклатураМассив);
		
		Возврат Рез;
		
	Иначе
	    Возврат ЗагрузитьОбъект(СтруктураОбъекта);
	КонецЕсли;
	
	
КонецФункции 

#КонецОбласти 	

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



Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
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
	//мРеквизиты.Добавить("Склад");
	//мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции


 мВнешняяСистема = "upp";
 
 ИмяСобытияЖР = "ИмпортИзУПП_РеализацияТоваровУслуг";
 
 СобиратьНенайденнуюНоменклатуру = Ложь;
 
 НеНайденнаяНоменклатураМассив = Новый Массив;
 