﻿Перем мЛоггер;
Перем мИдВызова;
Перем мВнешняяСистема;
Перем мВерсия;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.7");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Справочник_БанковскиеСчета");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Справочник_БанковскиеСчета");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Справочник_БанковскиеСчета",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Справочник_БанковскиеСчета",
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


// Описание_метода
//
// Параметры:
//	СтруктураОбъекта	- структура - после метода тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьОбъект(СтруктураОбъекта) Экспорт
	мЛоггер = Вычислить("мис_ЛоггерСервер.getLogger(мИдВызова, ""Импорт из УПП: справочник Банковские счета"")");
     
    Попытка
	
		Если НЕ НРег(СтруктураОбъекта.type) = "справочник.банковскиесчета" Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		мЛоггер.Инфо("Плагин Банковские счета. Версия плагина: "+мВерсия);
		
		id = СтруктураОбъекта.identification;
		def = СтруктураОбъекта.definition;
		
		СуществующийОбъект = Справочники.БанковскиеСчетаКонтрагентов.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			
		Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
			ОбъектДанных = Справочники.БанковскиеСчетаКонтрагентов.СоздатьЭлемент();
			СсылкаНового = Справочники.БанковскиеСчетаКонтрагентов.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
			ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		Иначе 
			ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		КонецЕсли;
			
		ОбъектДанных.Наименование = def.description;  
		ОбъектДанных.ПометкаУдаления = def.DeletionMark;       
		
		Контрагент = Неопределено;
		Если def.Owner.Свойство("Ref") Тогда
			Контрагент = Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(def.Owner.ref)); 	
		КонецЕсли;

		ОбъектДанных.Владелец = Контрагент;
			
		Если def.ВалютаДенежныхСредств.Свойство("currencyCode") Тогда
			ОбъектДанных.ВалютаДенежныхСредств = Справочники.Валюты.НайтиПоКоду(def.ВалютаДенежныхСредств.currencyCode);
		КонецЕсли;
		
		Если def.Банк.Свойство("БИК") Тогда
			ОбъектДанных.Банк = Справочники.КлассификаторБанков.НайтиПоКоду(def.Банк.БИК);
			ОбъектДанных.БИКБанка = def.Банк.БИК;
		КонецЕсли;
		
		
		
		ОбъектДанных.НомерСчета = def.НомерСчета;

		ОбъектДанных.ОбменДанными.Загрузка = Истина;
		
		ОбъектДанных.Записать();
			
		Возврат ОбъектДанных.Ссылка;
		
    Исключение
          т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
          мЛоггер.ерр("Плагин импорта банковских счетов УПП. Подробности: " + т);
           
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
	
	мЛоггер = Вычислить("мис_ЛоггерСервер.getLogger(мИдВызова, ""Импорт из УПП: справочник Банковские счета"")");
	
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

мВерсия = СведенияОВнешнейОбработке().Версия;
