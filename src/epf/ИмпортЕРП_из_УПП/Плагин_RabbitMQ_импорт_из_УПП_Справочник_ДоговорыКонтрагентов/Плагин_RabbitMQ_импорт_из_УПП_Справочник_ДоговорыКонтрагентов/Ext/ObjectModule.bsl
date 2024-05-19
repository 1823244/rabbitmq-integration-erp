﻿Перем мЛоггер;
Перем мИдВызова;
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.5");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Справочник_ДоговорыКонтрагентов");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Справочник_ДоговорыКонтрагентов");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Справочник_ДоговорыКонтрагентов",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Справочник_ДоговорыКонтрагентов",
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
Функция ЗагрузитьОбъект(СтруктураОбъекта) Экспорт
	мЛоггер = Вычислить("мис_ЛоггерСервер.getLogger(мИдВызова, ""Импорт из УПП: справочник Договоры контрагентов"")");
     
    Попытка
	
		Если НЕ НРег(СтруктураОбъекта.type) = "справочник.договорыконтрагентов" Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		def = СтруктураОбъекта.definition;
		Если def.isFolder = Истина Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		
		
		СуществующийОбъект = Справочники.ДоговорыКонтрагентов.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			
		Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
			ОбъектДанных = Справочники.ДоговорыКонтрагентов.СоздатьЭлемент();
			СсылкаНового = Справочники.ДоговорыКонтрагентов.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		Иначе 
			ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		КонецЕсли;
			
		ОбъектДанных.Наименование = def.description;  
			
		ОбъектДанных.ПометкаУдаления = def.DeletionMark;       
		
		Если def.УчетАгентскогоНДС = true Тогда
			ОбъектДанных.УчетАгентскогоНДС = ИСТИНА;
		Иначе
			ОбъектДанных.УчетАгентскогоНДС = ЛОЖЬ;
		КонецЕсли;
		
		объектДанных.Дата = def.Дата;
		
		ОбъектДанных.Номер = def.Номер;
		
		ОбъектДанных.ДатаНачалаДействия = def.Дата;
		
		ОбъектДанных.ДатаОкончанияДействия = def.СрокДействия;
		
		Если def.Владелец.Свойство("Ref") Тогда
			Контрагент = Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(def.Владелец.ref)); 	
		КонецЕсли;

		ОбъектДанных.Контрагент = Контрагент;
		Если ЗначениеЗаполнено(Контрагент.ВерсияДанных) Тогда
			ОбъектДанных.Партнер = Контрагент.Партнер;
		КонецЕсли;
			
		Если def.Организация.Свойство("Ref") Тогда
			Организация = Справочники.Организации.ПолучитьСсылку(Новый УникальныйИдентификатор(def.Организация.ref));
			ОбъектДанных.Организация = Организация;
		КонецЕсли;
		
		Если def.ВалютаВзаиморасчетов.Свойство("currencyCode") Тогда
			ОбъектДанных.ВалютаВзаиморасчетов = Справочники.Валюты.НайтиПоКоду(def.ВалютаВзаиморасчетов.currencyCode);
		КонецЕсли;
		
		Если def.ВидДоговора.Свойство("Значение") Тогда
			Если def.ВидДоговора.Значение = "СПокупателем" Тогда
				ОбъектДанных.ТипДоговора = Перечисления.ТипыДоговоров.СПокупателем;
			ИначеЕсли def.ВидДоговора.Значение = "СПоставщиком" Тогда
				ОбъектДанных.ТипДоговора = Перечисления.ТипыДоговоров.СПоставщиком;
			ИначеЕсли def.ВидДоговора.Значение = "СКомиссионером" Тогда
				ОбъектДанных.ТипДоговора = Перечисления.ТипыДоговоров.СКомиссионером;
			КонецЕсли;	
		КонецЕсли;
		
		ОбъектДанных.ВидЦенПродажи = ксп_ИмпортСлужебный.НайтиВидЦены(def.ТипЦен, мВнешняяСистема);
		ОбъектДанных.ВидЦенУчетный = ОбъектДанных.ВидЦенПродажи;
		
		Если def.ВедениеВзаиморасчетов.Значение = "ПоДоговоруВЦелом" Тогда
			ОбъектДанных.ПорядокРасчетов = Перечисления.ПорядокРасчетов.ПоДоговорамКонтрагентов;
		ИначеЕсли def.ВедениеВзаиморасчетов.Значение = "ПоЗаказам" Тогда
			ОбъектДанных.ПорядокРасчетов = Перечисления.ПорядокРасчетов.ПоЗаказам;
		КонецЕсли;               
		
		Если Не ОбъектДанных.ДатаОкончанияДействия = Дата(1,1,1) Тогда
			Если ОбъектДанных.ДатаОкончанияДействия < НачалоДня(ТекущаяДата()) Тогда
				ОбъектДанных.Статус = Перечисления.СтатусыДоговоровКонтрагентов.Закрыт;
			Иначе
				ОбъектДанных.Статус = Перечисления.СтатусыДоговоровКонтрагентов.Действует;
			КонецЕсли;
		Иначе 
			ОбъектДанных.Статус = Перечисления.СтатусыДоговоровКонтрагентов.Действует;
		КонецЕсли;
		
		ОбъектДанных.НалогообложениеНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
		ОбъектДанных.СтавкаНДС = Справочники.СтавкиНДС.НайтиПоРеквизиту("ПеречислениеСтавкаНДС", перечисления.СтавкиНДС.НДС20);
		
		ОбъектДанных.ОбменДанными.Загрузка = Истина;
		
		ОбъектДанных.Записать();
			
		Возврат ОбъектДанных.Ссылка;
		
    Исключение
          т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
          мЛоггер.ерр("Плагин импорта договоров контрагентов УПП. Подробности: " + т);
           
          //    ОБЯЗАТЕЛЬНО!!! Потому что в оркестраторе вызов плагина в попытке. и если была ошибка, надо сделать BasicReject()
          ВызватьИсключение т;
 
    КонецПопытки;
	
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

	
	
	Возврат ЗагрузитьОбъект(СтруктураОбъекта);
	
КонецФункции

Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	//Если Свойство = "Сумма" Тогда
	//	Возврат XMLЗначение(Тип("Число"),Значение);
	//КонецЕсли;
	//Если Свойство = "Валюта" Тогда
	//	Возврат Справочники.Валюты.НайтиПоКоду(Значение);
	//КонецЕсли;
	
КонецФункции


#КонецОбласти 	



Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервереИзМассиваАдресов(МассивАдресов, Обновлять = Истина) Экспорт
	
	мОбновлять = Обновлять;
	млоггер = мис_логгерСервер.getLogger(мИдВызова);
	
	млоггер.инфо("НАЧАЛИ пакет из "+строка(МассивАдресов.Количество())+" файлов");

	сч_обраотано = 0;       
	сч_ошибок = 0;
	
	Для каждого Адрес Из МассивАдресов Цикл

		
		ДвоичныеДанные  = ПолучитьИзВременногоХранилища(Адрес);
		Если 1=0 Тогда
			ДвоичныеДанные = новый ДвоичныеДанные("");
		КонецЕсли;                                
		
		ИмяФайла = ПолучитьИмяВременногоФайла("json");
		ДвоичныеДанные.Записать(ИмяФайла);
		
		мЧтениеJSON = Новый ЧтениеJSON;
		мЧтениеJSON.ОткрытьФайл(ИмяФайла);
		
		Попытка
			СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
		Исключение
			т = ОписаниеОшибки();
			Если СтрНайти(т, "Непредвиденный символ при чтении JSON") > 0 Тогда
				тт = новый ТекстовыйДокумент; 
				тт.Прочитать(ИмяФайла);
				
				мЛоггер.ерр(т+". Сообщение с ошибкой: "+тт.ПолучитьТекст());
				Продолжить;
			КонецЕсли;
		КонецПопытки;
		
		
		Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда
			Для Каждого эл из СтруктураОбъекта Цикл
				
				Попытка
					ЗагрузитьОбъект(эл);
					сч_обраотано = сч_обраотано +1;
				Исключение
				    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
					сч_ошибок = сч_ошибок + 1;
				КонецПопытки;
				
			КонецЦикла;
		Иначе 
			
			Попытка
				ЗагрузитьОбъект(СтруктураОбъекта);
				сч_обраотано = сч_обраотано +1;
			Исключение
			    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
				сч_ошибок = сч_ошибок + 1;
			КонецПопытки;
		    
			
		КонецЕсли;

	КонецЦикла;
	
	млоггер.инфо("ЗАВЕРШИЛИ пакет из "+строка(МассивАдресов.Количество())+" файлов. УСпешно обработано = "+строка(сч_обраотано)
	+", ошибок = "+Строка(сч_ошибок));
	
	Возврат Неопределено;
	
КонецФункции





мВнешняяСистема = "upp";


