﻿Перем мЛоггер;
Перем мИдВызова;
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","24май15-02");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_БП_Справочник_ДоговорыКонтрагентов");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_БП_Справочник_ДоговорыКонтрагентов");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_БП_Справочник_ДоговорыКонтрагентов",
		"Форма_Плагин_RabbitMQ_импорт_из_БП_Справочник_ДоговорыКонтрагентов",
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
	
	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт НСИ из БазаПоказов: договоры контрагентов");

	Попытка
		
	
		Если НЕ НРег(СтруктураОбъекта.type) = "справочник.договорыконтрагентов" Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		id = СтруктураОбъекта.identification;
		def = СтруктураОбъекта.definition;
		
		СуществующийОбъект = Справочники.ДоговорыКонтрагентов.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			
		Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
			ОбъектДанных = Справочники.ДоговорыКонтрагентов.СоздатьЭлемент();
			СсылкаНового = Справочники.ДоговорыКонтрагентов.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
			ОбъектДанных.УстановитьНовыйКод();
		Иначе 
			ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		КонецЕсли;
			
		//ОбъектДанных.Код = id.code;
		
		ОбъектДанных.Наименование = def.description;  
			
		ParentRef = "";
		Если def.Свойство("parent") И def.parent.Свойство("Ref", ParentRef) Тогда
			ОбъектДанных.Родитель = Справочники.ДоговорыКонтрагентов.ПолучитьСсылку(Новый УникальныйИдентификатор(ParentRef));
		КонецЕсли;
	
	
		ОбъектДанных.ПометкаУдаления = def.DeletionMark;       
				
		объектДанных.Дата = def.Дата;
		
		ОбъектДанных.Номер = def.Номер;
		
		ОбъектДанных.ДатаНачалаДействия = def.Дата;

		Если def.Владелец.Свойство("ref") Тогда
			Контрагент = Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(def.Владелец.ref)); 	

			ОбъектДанных.Контрагент = Контрагент;
			ОбъектДанных.Партнер 	= Контрагент.Партнер;
		КонецЕсли;
					
			
		Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(def.Организация, мВнешняяСистема);
		ОбъектДанных.Организация = Организация;
		
		Если def.ВалютаВзаиморасчетов.Свойство("currencyCode") Тогда
			ОбъектДанных.ВалютаВзаиморасчетов = ксп_ИмпортСлужебный.НайтиВалюту(def.ВалютаВзаиморасчетов.currencyCode);
		КонецЕсли;
		
		
		ОбъектДанных.ТипДоговора = Перечисления.ТипыДоговоров.СПокупателем;
	
		
		Если def.Свойство("ТипЦен") И def.ТипЦен.Свойство("Ref") Тогда
			ВидЦены = ксп_ИмпортСлужебный.НайтиВидЦены(def.ТипЦен, мВнешняяСистема);
			ОбъектДанных.ВидЦенПродажи = ВидЦены;			
			ОбъектДанных.ВидЦенУчетный = ВидЦены;
		КонецЕсли;
			                                                 		
		ОбъектДанных.ПорядокРасчетов = Перечисления.ПорядокРасчетов.ПоЗаказам;
		              
		ОбъектДанных.Статус = Перечисления.СтатусыДоговоровКонтрагентов.Действует;
			
		ОбъектДанных.ОбменДанными.Загрузка = Истина;
		
		ОбъектДанных.Записать();
		
		Возврат ОбъектДанных.Ссылка;
    Исключение
        мЛоггер.ерр("Плагин: Импорт Договоры контрагентов. Подробности: "+ОписаниеОшибки());
		ВызватьИсключение;// для помещения в retry
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
//  Параметр1   - Тип1 -
//
Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции




мВнешняяСистема = "bazap";

