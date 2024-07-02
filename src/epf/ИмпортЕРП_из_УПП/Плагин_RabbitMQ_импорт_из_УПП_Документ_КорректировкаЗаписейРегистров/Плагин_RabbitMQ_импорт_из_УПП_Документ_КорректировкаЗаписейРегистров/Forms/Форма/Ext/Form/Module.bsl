﻿&НаСервере
Функция ЗагрузитьИзJsonНаСервере()
	Об = РеквизитФормыВЗначение("Объект");
	об.сетИдВызова(ИдВызоваФорма);
	РезультатСтруктура = Об.ЗагрузитьИзJsonНаСервере(JsonText);
	ВводОстатков = РезультатСтруктура.ВводОстатков;  
	ЗаказНаВнутрПотр = РезультатСтруктура.ЗаказНаВнутрПотр;  
	
    Возврат "";
КонецФункции

&НаКлиенте
Процедура ЗагрузитьИзJson(Команда)

	идВызова = СоздатьИдВызова();    
	ИдВызоваФорма = ИдВызова;

	Адрес = "";
	Если ИмяКаталога <> "" Тогда        
		Колбэк = Новый ОписаниеОповещения("НачатьИмпорт", ЭтотОбъект);
		
		ОписанияПередаваемыхФайлов = Новый Массив;             
		
		массивФайлов = НайтиФАйлы(ИмяКаталога, "*.json", Ложь);
		Для каждого одинФайл Из массивФайлов Цикл
			ОдноОписание = Новый ОписаниеПередаваемогоФайла(одинФайл.ПолноеИмя);
			ОписанияПередаваемыхФайлов.Добавить(ОдноОписание);
		КонецЦикла;
		
		
		НачатьПомещениеФайловНаСервер(Колбэк,,,ОписанияПередаваемыхФайлов,ЭтаФорма.УникальныйИдентификатор);
		
	
	Иначе 
		
		Ссылка = ЗагрузитьИзJsonНаСервере();
		Сообщить("Импорт выполнен! " + ТекущаяДата());
		
	КонецЕсли;
	
	
КонецПроцедуры

// параметры
//	МассивФайлов -  Массив объектов типа ОписаниеПомещенногоФайла, либо Неопределено, если помещение файлов было отменено.
 &НаКлиенте
Процедура НачатьИмпорт(МассивФайлов, Доп)  Экспорт 
	

	 
	Если МассивФайлов = Неопределено Тогда
		Возврат;
	КонецЕсли;    

	//ОписаниеПомещенногоФайла.Адрес
	//ОписаниеПомещенногоФайла.СсылкаНаФайл
	//	ИдентификаторФайла (FileID)
	//	Имя (Name)
	//	Расширение (Extension)
	//	Файл (File)
	
	сч = 0;
	Для каждого ОписаниеПомещенногоФайла Из МассивФайлов Цикл  
		
		Попытка
			ЗагрузитьИзJsonНаСервереИзФайла(ИдВызоваФорма, ОписаниеПомещенногоФайла.Адрес);
			сч = сч + 1;
		Исключение
		    т = ОписаниеОшибки();
			мис_ЛоггерСервер.Ошибка(ИдВызоваФорма, "файл "+строка(ОписаниеПомещенногоФайла.СсылкаНаФайл.Имя), т);
		КонецПопытки;
		
	КонецЦикла;         
	
	мис_ЛоггерСервер.информация(ИдВызоваФорма, "", "успешно загружено файлов "+строка(сч));
	
	//
	//Попытка
	//	Объект.ИдВызоваФорма = ИдВызова;
	//Исключение
	//    Сообщить("лог обработки смотрите в этом ИДВызова: "+Строка(ИдВызова))
	//КонецПопытки;
	
	
КонецПроцедуры   

&НаСервере
Процедура ЗагрузитьИзJsonНаСервереИзФайла(идВызоваРодитель, Адрес)
	
	//идВызова = мис_ЛоггерСервер.СоздатьИдВызова(идВызоваРодитель, "Импорт ввода остатков товаров. Один документ. Интерактивный", ТекущаяДатаСеанса(),"Плагин", , Неопределено);

	обк=РеквизитФормыВЗначение("Объект");	
	Попытка
		ИдВызова = мис_ЛоггерСервер.СоздатьИдВызова(ИдВызоваФорма, "Импорт одного документа", ТекущаяДатаСеанса(),
			"", Неопределено, Неопределено);
		обк.сетИдВызова(ИдВызова);
	Исключение
	    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
	КонецПопытки;

	
	
	Ссылка = обк.ЗагрузитьИзJsonНаСервереИзФайла(Адрес);
	
	
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.ВводОстатковТоваров") Тогда
		Сообщить(НСтр("ru = '"+строка(ссылка)+"'"), СтатусСообщения.БезСтатуса);
	КонецЕсли;
	

КонецПроцедуры    

&НаСервере
// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьИдВызова()
	
	идВызова = мис_ЛоггерСервер.СоздатьИдВызова(Неопределено, "Импорт ввода остатков товаров. Интерактивный", ТекущаяДатаСеанса(),"Плагин", , Неопределено);
	
	возврат идВызова;
		
КонецФункции

