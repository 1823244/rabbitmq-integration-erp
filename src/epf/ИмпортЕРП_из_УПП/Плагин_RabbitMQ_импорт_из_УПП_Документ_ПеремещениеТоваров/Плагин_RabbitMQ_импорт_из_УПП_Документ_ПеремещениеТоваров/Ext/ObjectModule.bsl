﻿Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем мЛоггер;
Перем мИдВызова;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.12");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров",
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

Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	
	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт документов из УПП: Оприходование товаров");
	
	Попытка
	
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ПеремещениеТоваров") Тогда
			Возврат Неопределено;
		КонецЕсли;
	
		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;
		
		ПредставлениеДокументаУПП 			= "Перемещение товаров №"+деф.Number+" от "+строка(деф.Date);
		
		ВидДокументаУППСсылка = НайтиВидДокументаУПП("Документ.ПеремещениеТоваров");
		
		//Виды ошибок описаны здесь:
		//https://wiki.elis.ru/pages/viewpage.action?pageId=3964935
		
		// Этап 1
		
		СкладОтправительУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладОтправитель, "КСП_СкладыУПП");
		
		Если НЕ ЗначениеЗаполнено(СкладОтправительУПП) Тогда
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= Неопределено;
			СкладОтправитель 	= СкладОтправительУПП;
			СкладПолучатель 	= Неопределено;
			т = "Этап 01 Поиск складов УПП. Код 100. Не найден склад-отправитель!";
			ТекстСообщения 		= т;
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь, // ошибки исправлены
			Id.ref);
		
			мЛоггер.ерр("Документ не загружен! %2 %1", 
				ПредставлениеДокументаУПП, т);
		
			Возврат Неопределено;
		КонецЕсли;
		
		СкладПолучательУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладПолучатель, "КСП_СкладыУПП");
		
		Если НЕ ЗначениеЗаполнено(СкладПолучательУПП) Тогда
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= Неопределено;
			СкладОтправитель 	= СкладОтправительУПП;
			СкладПолучатель 	= СкладПолучательУПП;
			т = "Этап 01 Поиск складов УПП. Код 110. Не найден склад-получатель!";
			ТекстСообщения 		= т;
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь, // ошибки исправлены
			Id.ref);
		
			мЛоггер.ерр("Документ не загружен! %2, %1", 
				ПредставлениеДокументаУПП, т);
		
			Возврат Неопределено;
		КонецЕсли;
		
		// Этап 2
		
		// здесь так детально ищем "логику", потому что нужно писать ошибки в "лог"
		ВидОперацииПоСкладуОтправитель = Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП(СкладОтправительУПП);
		
		Если НЕ ЗначениеЗаполнено(ВидОперацииПоСкладуОтправитель) Тогда
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= Неопределено;
			СкладОтправитель 	= СкладОтправительУПП;
			СкладПолучатель 	= СкладПолучательУПП;
			т="Этап 02 Поиск видов операций УПП. Код 200. Не найден ВидОперацииПоСкладу-Отправитель!";
			ТекстСообщения 		= т;
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь, // ошибки исправлены
			Id.ref);
		
			мЛоггер.ерр("Документ не загружен! %2 %1", 
				ПредставлениеДокументаУПП, т);
		
			Возврат Неопределено;
		КонецЕсли;   
		
		// здесь так детально ищем "логику", потому что нужно писать ошибки в "лог"
		ВидОперацииПоСкладуПолучатель = Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП(СкладПолучательУПП);
		
		Если НЕ ЗначениеЗаполнено(ВидОперацииПоСкладуПолучатель) Тогда
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= Неопределено;
			СкладОтправитель 	= СкладОтправительУПП;
			СкладПолучатель 	= СкладПолучательУПП;
			т="Этап 02 Поиск видов операций УПП. Код 210. Не найден ВидОперацииПоСкладу-Получатель!";
			ТекстСообщения 		= т;
			ЛогикаСклад			= Неопределено;
			ЛогикаПеремещения 	= Неопределено;
			Обработчик 			= Неопределено;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь, // ошибки исправлены
			Id.ref);
		
			мЛоггер.ерр("Документ не загружен! %2 %1", 
				ПредставлениеДокументаУПП, т);
		
			Возврат Неопределено;
		КонецЕсли;
		
		//// Этап 3 Поиск строки в ТЧ Получатели/Отправители
		//
		//СтрокаТЧОтправитель = НайтиОтправителяВТЧОтправители( ВидОперацииПоСкладуОтправитель, СкладОтправительУПП); // это строка ТЧ
		//НашлиЛогикуОтправителя = Истина;
		//Если НЕ ЗначениеЗаполнено(СтрокаТЧОтправитель) Тогда
		//	НашлиЛогикуОтправителя = Ложь;
		//КонецЕсли;   
		//
		//СтрокаТЧПолучатель = НайтиПолучателяВТЧПолучатели( ВидОперацииПоСкладуПолучатель , СкладПолучательУПП); // это строка ТЧ
		//НашлиЛогикуПолучателя = Истина;
		//Если НЕ ЗначениеЗаполнено(СтрокаТЧПолучатель) Тогда
		//	НашлиЛогикуПолучателя = Ложь;
		//КонецЕсли;
		//
		//
		//Если НЕ НашлиЛогикуПолучателя И НЕ НашлиЛогикуОтправителя Тогда
		//	
		//	т = "Этап 03. Код 330. НЕ Найдены строки ни в одной из ТЧ: для получателя и для отправителя. Вид операции Отправитель: "+ВидОперацииПоСкладуОтправитель
		//		+", Вид операции получатель: " + ВидОперацииПоСкладуПолучатель ;
		//		
		//	ВидДокумента 		= СтруктураОбъекта.type;
		//	Склад 				= Неопределено;
		//	СкладОтправитель 	= СкладОтправительУПП;
		//	СкладПолучатель 	= СкладПолучательУПП;
		//	ТекстСообщения 		= т;
		//	ЛогикаСклад			= Неопределено;
		//	ЛогикаПеремещения 	= Неопределено;
		//	Обработчик 			= Неопределено;
		//	РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
		//						ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
		//	деф.Number,
		//	деф.date,
		//	Ложь, // ошибки исправлены
		//	Id.ref);
		//	
		//		
		//	мЛоггер.ерр("Документ не загружен! %2 %1", 
		//		ПредставлениеДокументаУПП, т);
		//
		//	Возврат Неопределено;
		//	
		//КонецЕсли;
		//
		//Если НашлиЛогикуПолучателя И НашлиЛогикуОтправителя Тогда
		//	
		//	ВидДокумента 		= СтруктураОбъекта.type;
		//	Склад 				= Неопределено;
		//	СкладОтправитель 	= СкладОтправительУПП;
		//	СкладПолучатель 	= СкладПолучательУПП;
		//	т = "Этап 03. Код 320. Найдены строки в обеих ТЧ: для получателя и для отправителя. Вид операции Отправитель: "+ВидОперацииПоСкладуОтправитель
		//		+", Вид операции получатель: " + ВидОперацииПоСкладуПолучатель ;
		//		
		//	ТекстСообщения 		= т;
		//	ЛогикаСклад			= Неопределено;
		//	ЛогикаПеремещения 	= Неопределено;
		//	Обработчик 			= Неопределено;
		//	РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
		//						ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
		//	деф.Number,
		//	деф.date,
		//	Ложь, // ошибки исправлены
		//	Id.ref);
		//	
		//	
		//	мЛоггер.ерр("Документ не загружен! %2  %1", 
		//		ПредставлениеДокументаУПП, т);
		//		
		//		
		//	Возврат Неопределено;
		//	
		//КонецЕсли;
		
		// Этап 4. Проверка , что колонка Логика заполнена
		
		
		СкладХраненияУПП_отправитель = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладХраненияОтправитель, "КСП_СкладыХраненияУПП");
		СкладХраненияУПП_Получатель = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладХраненияПолучатель, "КСП_СкладыХраненияУПП");
		
		Если СкладОтправительУПП <> СкладПолучательУПП Тогда
			
			// Склад хранения - одинаковый с двух сторон
			// Используем любой: СкладХраненияУПП_отправитель
			
			// для склада-отправителя логику ищем в ТЧ Получатели и наоборот. по складу-Получателю
			ЛогикаОтправителя = НайтиЛогикуПоВидуДокумента(ВидОперацииПоСкладуОтправитель.Получатели, СкладХраненияУПП_отправитель, ВидДокументаУППСсылка, СкладПолучательУПП);
			
			// для склада-Получателя логику ищем в ТЧ Отправители и наоборот. по складу-Отправителю
			ЛогикаПолучателя = НайтиЛогикуПоВидуДокумента(ВидОперацииПоСкладуПолучатель.Отправители, СкладХраненияУПП_отправитель, ВидДокументаУППСсылка, СкладОтправительУПП);
			
		ИначеЕсли СкладОтправительУПП = СкладПолучательУПП Тогда
			
			// Склады хранения - разные
			
			//// для склада-отправителя логику ищем в ТЧ Получатели и наоборот. по складу-Получателю
			//ЛогикаОтправителя = НайтиЛогикуПоВидуДокумента(ВидОперацииПоСкладуОтправитель.Получатели, СкладХраненияУПП_отправитель, ВидДокументаУППСсылка, СкладПолучательУПП);
			//
			//// для склада-Получателя логику ищем в ТЧ Отправители и наоборот. по складу-Отправителю
			//ЛогикаПолучателя = НайтиЛогикуПоВидуДокумента(ВидОперацииПоСкладуПолучатель.Отправители, СкладХраненияУПП_отправитель, ВидДокументаУППСсылка, СкладОтправительУПП);

		КонецЕсли;
		
		
		
		
		Если ЗначениеЗаполнено(ЛогикаОтправителя) И
			ЗначениеЗаполнено(ЛогикаПолучателя) И
			ЛогикаОтправителя = ЛогикаПолучателя Тогда
			
			// используем любую
			
			субплагин = НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаОтправителя, ВидДокументаУППСсылка);

		Иначе 
			
			
			Если НЕ ЗначениеЗаполнено(ЛогикаОтправителя) И НЕ ЗначениеЗаполнено(ЛогикаПолучателя) Тогда
				// ОШИБКА
				
				
			ИначеЕсли НЕ ЗначениеЗаполнено(ЛогикаОтправителя) И ЗначениеЗаполнено(ЛогикаПолучателя) Тогда
				
				субплагин = НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаПолучателя, ВидДокументаУППСсылка);
				
				
				
			ИначеЕсли ЗначениеЗаполнено(ЛогикаОтправителя) И НЕ ЗначениеЗаполнено(ЛогикаПолучателя) Тогда
				
				субплагин = НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаОтправителя, ВидДокументаУППСсылка);
				
			КонецЕсли;   
			
			
			
			
		КонецЕсли;
		
		
		
		
		//Если НЕ ЗначениеЗаполнено(ЛогикаОтправителя) Тогда
		//	ВидДокумента 		= СтруктураОбъекта.type;
		//	Склад 				= Неопределено;
		//	СкладОтправитель 	= СкладОтправительУПП;
		//	СкладПолучатель 	= СкладПолучательУПП;
		//	т = "Этап 04. Код 400. Строка в ТЧ Отправители по складу есть, но логика не заполнена! Вид операции по складу: "+строка(ВидОперацииПоСкладуОтправитель);
		//	ТекстСообщения 		= т;
		//	ЛогикаСклад			= Неопределено;
		//	ЛогикаПеремещения 	= ЛогикаОтправителя;
		//	Обработчик 			= Неопределено;
		//	РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
		//						ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
		//	деф.Number,
		//	деф.date,
		//	Ложь, // ошибки исправлены
		//	Id.ref);                                      

		//	мЛоггер.ерр("Документ не загружен! %2 %1", 
		//		ПредставлениеДокументаУПП, т);
		//	
		//	Возврат Неопределено;
		//	
		//
		//КонецЕсли;     

		//Если ЗначениеЗаполнено(ЛогикаОтправителя) Тогда
		//	
		//	ЛогикаОбработки = НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаОтправителя, ВидДокументаУППСсылка);
		//	
		//	
		//	СсылкаОбработчика = НайтиЛогикуВТЧПоВидуДокументаУПП(ЛогикаПеремещения, СтруктураОбъекта.type);
			
		//ИначеЕсли НашлиЛогикуПолучателя Тогда 
		//	ЛогикаПеремещения = СтрокаТЧПолучатель.ЛогикаОбработкиВТЧ;
		//	
		//	Если НЕ ЗначениеЗаполнено(ЛогикаПеремещения) Тогда
		//		ВидДокумента 		= СтруктураОбъекта.type;
		//		Склад 				= Неопределено;
		//		СкладОтправитель 	= СкладОтправительУПП;
		//		СкладПолучатель 	= СкладПолучательУПП;
		//		т = "Этап 04. Код 410. Строка в ТЧ Получатели по складу есть, но логика не заполнена! Вид операции по складу: "+строка(ВидОперацииПоСкладуПолучатель);
		//		ТекстСообщения 		= т;
		//		ЛогикаСклад			= Неопределено;
		//		//ЛогикаПеремещения 	= ЛогикаПеремещения;
		//		Обработчик 			= Неопределено;
		//		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
		//							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
		//		деф.Number,
		//		деф.date,
		//		Ложь, // ошибки исправлены
		//		Id.ref);                       
		//		
		//		мЛоггер.ерр("Документ не загружен! %2 %1", 
		//			ПредставлениеДокументаУПП, т);
		//
		//		Возврат Неопределено;
		//	КонецЕсли;     
		//	
		//	СсылкаОбработчика = НайтиЛогикуВТЧПоВидуДокументаУПП(ЛогикаПеремещения, СтруктураОбъекта.type);
		//	
		//КонецЕсли;
		
		//	
		//Если НЕ ЗначениеЗаполнено(СсылкаОбработчика) Тогда
		//	ВидДокумента 		= СтруктураОбъекта.type;
		//	Склад 				= Неопределено;
		//	СкладОтправитель 	= СкладОтправительУПП;
		//	СкладПолучатель 	= СкладПолучательУПП;
		//	т = "Этап 04. Код 420. Не найден субплагин в ТЧ элемента логики! Логика обработки: "+строка(ЛогикаПеремещения);
		//	ТекстСообщения 		= т;
		//	ЛогикаСклад			= Неопределено;
		//	//ЛогикаПеремещения 	= ЛогикаПеремещения;
		//	Обработчик 			= Неопределено;
		//	РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
		//						ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
		//	деф.Number,
		//	деф.date,
		//	Ложь, // ошибки исправлены
		//	Id.ref);                  

		//	мЛоггер.ерр("Документ не загружен! %2 %1", 
		//		ПредставлениеДокументаУПП, т);
		//	
		//	Возврат Неопределено;
		//КонецЕсли;
		//
		// создание объекта из эл спр "Доп отчеты и обработки"
		
		
		ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(субплагин);
		
		ОбъектОбработчика = ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(субплагин);
		
		Если ОбъектОбработчика = Неопределено Тогда
	
			ВидДокумента 		= СтруктураОбъекта.type;
			Склад 				= Неопределено;
			СкладОтправитель 	= СкладОтправительУПП;
			СкладПолучатель 	= СкладПолучательУПП;
			т = "Этап 04. Код 430. НЕ удалось подключить субплагин импорта! Логика "+строка(ЛогикаПеремещения)+" Субплагин: "+строка(субплагин);
			ТекстСообщения 		= т;
			//ЛогикаПеремещения 	= Неопределено;
			ЛогикаСклад 		= Неопределено;
			Обработчик 			= субплагин;
			РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
								ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
			деф.Number,
			деф.date,
			Ложь, // ошибки исправлены
			Id.ref);
			
			мЛоггер.ерр("Документ не загружен! %2 %1", 
				ПредставлениеДокументаУПП, т);

			Возврат Неопределено;
		КонецЕсли;
		
		// запуск импорта
		
		СсылкаПеремещение = ОбъектОбработчика.ЗагрузитьОбъект(СтруктураОбъекта);
		
		//успешно
	
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= СкладОтправительУПП;
		СкладПолучатель 	= СкладПолучательУПП;
		ТекстСообщения 		= "Успешно загружен";
		//ЛогикаПеремещения 	= Неопределено;
		ЛогикаСклад 		= Неопределено;
		Обработчик 			= субплагин;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
		деф.Number,
		деф.date,
		Истина, // ошибки исправлены
		Id.ref);      
		
			мЛоггер.инфо("Записан Документ! УПП: Документ: %1, ЕРП: %2", 
				ПредставлениеДокументаУПП, строка(СсылкаПеремещение));
		
		
	Исключение
		т = "Плагин: Плагин_RabbitMQ_импорт_из_УПП_Документ_ПеремещениеТоваров . Подробности: " + ОписаниеОшибки();

		ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Ошибка,,,т);
		
		ВидДокумента 		= СтруктураОбъекта.type;
		Склад 				= Неопределено;
		СкладОтправитель 	= СкладОтправительУПП;
		СкладПолучатель 	= СкладПолучательУПП;
		ТекстСообщения 		= "Ошибка загрузки: "+т;
		ЛогикаПеремещения 	= Неопределено;
		ЛогикаСклад 		= Неопределено;
		Обработчик 			= субплагин;
		РегистрыСведений.КСП_УПП_ОшибкиИмпорта.лог(ВидДокумента, Склад, СкладОтправитель, СкладПолучатель, 
							ТекстСообщения, ЛогикаСклад, ЛогикаПеремещения, Обработчик, ПредставлениеДокументаУПП,
		деф.Number,
		деф.date,
		Ложь, // ошибки исправлены
		Id.ref);			
		
		мЛоггер.ерр("Общая ошибка загрузки документа! УПП: Документ: %1, Подробности: %2", 
				ПредставлениеДокументаУПП, т);
		
		
		//    ОБЯЗАТЕЛЬНО!!! Потому что в оркестраторе вызов плагина в попытке. и если была ошибка, надо сделать BasicReject()
		ВызватьИсключение т;
		
	КонецПопытки;

		
	Возврат  СсылкаПеремещение;
	
КонецФункции

#КонецОбласти 	

#Область СлужебныеЗаполненияИПолученияСсылок

//Функция ПолучитьСсылкаНаДопОбработку(id,деф,СтруктураОбъекта,jsonText)
//	Ответ = Новый Структура;
//	СкладОтправительУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладОтправитель, "КСП_СкладыУПП");
//	СкладПолучательУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладПолучатель, "КСП_СкладыУПП");
//	Если ЗначениеЗаполнено(СкладОтправительУПП) и ЗначениеЗаполнено(СкладПолучательУПП) Тогда
//		ЛогикаОбработкиСкладОтправительУПП = ПолучитьЛогикуСклада(СкладОтправительУПП);
//		ЛогикаОбработкиСкладПолучательУПП = ПолучитьЛогикуСклада(СкладПолучательУПП);
//		Если ЗначениеЗаполнено(ЛогикаОбработкиСкладОтправительУПП) и ЗначениеЗаполнено(ЛогикаОбработкиСкладПолучательУПП) Тогда
//			Запрос = Новый Запрос;
//			Запрос.УстановитьПараметр("ЛогикаСкладПолучатель", ЛогикаОбработкиСкладПолучательУПП);
//			Запрос.УстановитьПараметр("ЛогикаСкладОтправитель", ЛогикаОбработкиСкладОтправительУПП);
//			Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
//				|	КСП_ЛогикаОбработкиПеремещений.СсылкаНаДопОбработку КАК СсылкаНаДопОбработку
//				|ИЗ
//				|	Справочник.КСП_ЛогикаОбработкиПеремещений КАК КСП_ЛогикаОбработкиПеремещений
//				|ГДЕ
//				|	КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладОтправитель = &ЛогикаСкладОтправитель
//				|	И КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладПолучатель = &ЛогикаСкладПолучатель";

//			Результат = Запрос.Выполнить();
//			Если Результат.Пустой() Тогда
//				Возврат Неопределено;
//			КонецЕсли;
//			Выборка = Результат.Выбрать();
//			Выборка.Следующий();
//			Возврат Выборка.СсылкаНаДопОбработку;
//		Иначе
//			Возврат Неопределено;	
//		КонецЕсли;
//	Иначе
//		Возврат Неопределено;
//	КонецЕсли;	
//КонецФункции

Функция ПолучитьСкладERP(СкладУПП) 

	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП КАК СкладУПП,
	|	КСП_ВидыОперацийПоСкладамУПП.СкладЕРП КАК СкладЕРП,
	|	КСП_ВидыОперацийПоСкладамУПП.Ссылка КАК Ссылка,
	|	КСП_ВидыОперацийПоСкладамУПП.ЛогикаОбработкиВШапке КАК ЛогикаОбработки
	|ИЗ
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП КАК КСП_ВидыОперацийПоСкладамУПП
	|ГДЕ
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП = &СкладУПП";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат СкладУПП;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.СкладЕРП;

КонецФункции

Функция ПолучитьЛогикуСклада(СкладУПП) 

	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	КСП_ВидыОперацийПоСкладамУПП.ЛогикаОбработкиВШапке КАК ЛогикаОбработки
	|ИЗ
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП КАК КСП_ВидыОперацийПоСкладамУПП
	|ГДЕ
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП = &СкладУПП";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.ЛогикаОбработки;

КонецФункции

Функция ЗаполненаСсылка(СтруктураID) 
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Ложь;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если ЗначениеЗаполнено(Ref) Тогда
			Возврат Истина;
		КонецЕсли;
	Исключение
		Возврат Ложь;
	КонецПопытки;
КонецФункции

Функция ПолучитьСсылкуДокументаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
			Возврат Неопределено;
		КонецЕсли;
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	ДанныеСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	Возврат ДанныеСсылка;
КонецФункции

Функция ПолучитьСсылкуСправочникаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
			Возврат Неопределено;
		КонецЕсли;
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	Если НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных) Тогда
		ОбъектДанных = Справочники[ВидОбъекта].СоздатьЭлемент();
		СсылкаНового = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		Попытка
			ОбъектДанных.Код = СтруктураID.code;
		Исключение
		КонецПопытки;
		Попытка
			ОбъектДанных.Наименование = СтруктураID.Description;
		Исключение
		КонецПопытки;
		ОбъектДанных.ОбменДанными.Загрузка = Истина;
		ОбъектДанных.Записать();
		Возврат СсылкаНового;
	Иначе
		Возврат ДанныеСсылка;
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
Функция Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП(СкладУППСсылка)
	
	Рез = Справочники.КСП_ВидыОперацийПоСкладамУПП.НайтиПоРеквизиту("СкладУПП", СкладУППСсылка);
	Возврат Рез;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: строка ТЧ Получатели справочника КСП_ВидыОперацийПоСкладамУПП
//
Функция НайтиПолучателяВТЧПолучатели( ВидОперацииПоСкладу , СкладУПП)
	
	СтрокаТЧ = ВидОперацииПоСкладу.Получатели.Найти(СкладУПП, "Склад");
	Возврат СтрокаТЧ;
	
		
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: строка ТЧ Получатели справочника КСП_ВидыОперацийПоСкладамУПП
//
Функция НайтиОтправителяВТЧОтправители( ВидОперацииПоСкладу , СкладУПП)
	
	СтрокаТЧ = ВидОперацииПоСкладу.Отправители.Найти(СкладУПП, "Склад");
	Возврат СтрокаТЧ;
	
		
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиЛогикуВТЧПоВидуДокументаУПП(ЛогикаПеремещения, ВидДокумента)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ТТ.Ссылка КАК ВидДок
		|Поместить ВТВидыДокументов
		|ИЗ
		|	Справочник.КСП_ВидыДокументовУПП КАК ТТ
		|ГДЕ
		|	
		|	ТТ.Наименование = &ВидДокумента
		|;
		|
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ТЧ.СсылкаНаДопОбработку КАК Логика
		|ИЗ
		|	Справочник.КСП_ЛогикаОбработкиДвиженияПоСкладуУПП.ОбработчикиТиповДокументов КАК ТЧ
		|ГДЕ
		|	ТЧ.Ссылка = &ЛогикаПеремещения
		|	И ТЧ.ВидДокументаУПП В (Выбрать ВидДок из ВТВидыДокументов)";
	
	Запрос.УстановитьПараметр("ВидДокумента", ВидДокумента);
	Запрос.УстановитьПараметр("ЛогикаПеремещения", ЛогикаПеремещения);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Логика;
	КонецЦикла;
	
КонецФункции      

#Область ПолучениеВнешнейОбработкиПоИмени

Функция ПолучитьОбъектВнешнейОбработкиПоНаименованию(Наименование)
	ТекСсылка = Справочники.ДополнительныеОтчетыИОбработки.НайтиПоНаименованию(Наименование);
	Если не ЗначениеЗаполнено(ТекСсылка) Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(ТекСсылка);
	Возврат ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(ТекСсылка);
КонецФункции

Функция ПолучитьОбъектВнешнейОбработкиПоСсылке(ТекСсылка)
	Если не ЗначениеЗаполнено(ТекСсылка) Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку(ТекСсылка);
	Возврат ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(ТекСсылка);
КонецФункции

#КонецОбласти


#КонецОбласти

// ЕНС. todo. Перенести в общий модуль ксп_ИмпортСлужебный
Функция ПолучитьСсылкаНаЛогикуПеремещения(ЛогикаОбработкиСкладОтправительУПП,
		ЛогикаОбработкиСкладПолучательУПП)
		
		Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ЛогикаСкладПолучатель", ЛогикаОбработкиСкладПолучательУПП);
	Запрос.УстановитьПараметр("ЛогикаСкладОтправитель", ЛогикаОбработкиСкладОтправительУПП);
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	КСП_ЛогикаОбработкиПеремещений.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.КСП_ЛогикаОбработкиПеремещений КАК КСП_ЛогикаОбработкиПеремещений
		|ГДЕ
		|	КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладОтправитель = &ЛогикаСкладОтправитель
		|	И КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладПолучатель = &ЛогикаСкладПолучатель";

	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.Ссылка;
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

#КонецОбласти 	

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
	мРеквизиты.Добавить("СкладОтправитель");
	мРеквизиты.Добавить("СкладПолучатель");
	мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции

Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции



// Ищет спр Вид документа УПП по строке - наименованию
//
// Параметры:
//	ВидДокумента 	- строка - 
//
// Возвращаемое значение:
//	Тип: спр ссылка КСП_ВидыДокументовУПП
//
Функция НайтиВидДокументаУПП(ВидДокумента)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ТТ.Ссылка КАК ВидДок
		|ИЗ
		|	Справочник.КСП_ВидыДокументовУПП КАК ТТ
		|ГДЕ
		|	
		|	ТТ.Наименование = &ВидДокумента";
	
	Запрос.УстановитьПараметр("ВидДокумента", ВидДокумента);
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		ВызватьИсключение "Не найден вид документа УПП в спр. видов документов: "+Строка(ВидДокумента);
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	ВидДок = Неопределено;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ВидДок = ВыборкаДетальныеЗаписи.ВидДок;
	КонецЦикла;
	
		
	Возврат ВидДок;
	
КонецФункции

// Ищет в ТЧ Получатели/Отправители "логику" с учетом вида документа и Склада и склада хранения
//
// Параметры:
//	ТЧПолучателиОтправители 	- таб часть справочника Виды операций по складам УПП - 
//
// Возвращаемое значение:
//	Тип: спр ссылка КСП_ЛогикаОбработкиДвиженияПоСкладуУПП
//
Функция НайтиЛогикуПоВидуДокумента(ТЧПолучателиОтправители, СкладХраненияУПП, ВидДокументаУППСсылка, СкладУПП)
	
	ЛогикаОбработки = Неопределено;
	
	//ЕНС. Найти все строки в ТЧ, где есть нужный склад и искомый вид документа в "логике" (там это ТЧ ОбработчикиТиповДокументов)
	// Если это одна строка - возвращаем логику
	// Если больше одной - ищем в них склад хранения УПП
	
	МассивСтрокТЧ = Новый Массив;   // строки ТЧ Получатели
	
	Для каждого стрк Из ТЧПолучателиОтправители Цикл
		Если НЕ ЗначениеЗаполнено(стрк.ЛогикаОбработкиВТЧ) Тогда
			Продолжить;
		КонецЕсли;
		Если НЕ стрк.Склад = СкладУПП Тогда
			Продолжить;
		КонецЕсли;
		
		Для каждого стркЛогика Из стрк.ЛогикаОбработкиВТЧ.ОбработчикиТиповДокументов Цикл
			Если стркЛогика.ВидДокументаУПП = ВидДокументаУППСсылка Тогда
				МассивСтрокТЧ.Добавить(стрк);
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;

	Если МассивСтрокТЧ.Количество() = 1 Тогда
		Возврат МассивСтрокТЧ[0].ЛогикаОбработкиВТЧ;
	КонецЕсли;
	
	// если нашли более 1 строки в ТЧ Получатели - ищем нужную по складу хранения УПП (если он заполнен)
	
	Если ЗначениеЗаполнено(СкладХраненияУПП) Тогда
		Для каждого стрк Из МассивСтрокТЧ Цикл
			Если стрк.СкладХраненияУПП = СкладХраненияУПП Тогда
				Возврат стрк.ЛогикаОбработкиВТЧ;
			КонецЕсли;
		КонецЦикла;
	Иначе 
		// если склад хранения не указан - поищем строку с пустым (не будем надеяться сравнение пустых значений)
		Для каждого стрк Из МассивСтрокТЧ Цикл
			Если НЕ ЗначениеЗаполнено(стрк.СкладХраненияУПП) Тогда
				Возврат стрк.ЛогикаОбработкиВТЧ;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	// вернем любой
	Для каждого стрк Из МассивСтрокТЧ Цикл
		Возврат стрк.ЛогикаОбработкиВТЧ;
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
Функция НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаОбработки, ВидДокументаУППСсылка)
	
	Для каждого стркОбработчик Из ЛогикаОбработки.ОбработчикиТиповДокументов Цикл
		
		Если стркОбработчик.ВидДокументаУПП = ВидДокументаУППСсылка Тогда
			
			Возврат стркОбработчик.СсылкаНаДопОбработку;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;

КонецФункции 


 мВнешняяСистема = "UPP";
 ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
 