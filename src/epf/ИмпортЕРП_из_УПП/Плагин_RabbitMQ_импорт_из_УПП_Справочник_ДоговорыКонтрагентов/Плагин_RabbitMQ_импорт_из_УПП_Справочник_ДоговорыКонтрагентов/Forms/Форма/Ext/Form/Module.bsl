﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	НадписьВерсия = РеквизитФормыВЗначение("Объект").СведенияОВнешнейОбработке().Версия;
	идВызова = мис_логгерСервер.СоздатьИдВызова(Неопределено, "Импорт номенклатуры из файлов интерактивно",
	ТекущаяДата(),
	"Внеш обраотка Плагин УПП",Неопределено, Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ИмяКаталога = "c:\1C\УПП_Выгрузка_Один_Вид_Справ";
КонецПроцедуры


&НаСервере
Процедура ЗагрузитьИзJsonНаСервере()

	Ссылка = РеквизитФормыВЗначение("Объект").ЗагрузитьИзJsonНаСервере(JsonText);
	Сообщить(НСтр("ru = '"+строка(ссылка)+"'"), СтатусСообщения.БезСтатуса);
	договор = ссылка;

КонецПроцедуры   






&НаКлиенте
Процедура ЗагрузитьИзJson(Команда)
	
		
	Если ИмяКаталога <> "" Тогда        
		Колбэк = Новый ОписаниеОповещения("НачатьИмпорт", ЭтотОбъект);
		
		ОписанияПередаваемыхФайлов = Новый Массив;   
		
		сч = 0;
		массивФайлов = НайтиФайлы(ИмяКаталога, "*.json", Ложь);   
		
		Если массивФайлов.Количество() = 0 Тогда
			ПоказатьПредупреждение(, "Файлы закончились!");
			Возврат;
			
		КонецЕсли;  
		
		Для каждого одинФайл Из массивФайлов Цикл
			ОдноОписание = Новый ОписаниеПередаваемогоФайла(одинФайл.ПолноеИмя);
			ОписанияПередаваемыхФайлов.Добавить(ОдноОписание);
			сч=сч+1;
			Если сч = РазмерПорцииФайлов Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		
		НачатьПомещениеФайловНаСервер(Колбэк,,,ОписанияПередаваемыхФайлов,ЭтаФорма.УникальныйИдентификатор);
		
	
	Иначе 
		
		ЗагрузитьИзJsonНаСервере();
		
	КонецЕсли;
	
КонецПроцедуры



// отсюда уходим на ТОЧКА ВХОДА после обработки очередной порции файлов
&НаКлиенте
Процедура ЗагрузитьИзJsonКолБэк(Параметр = Неопределено, ДопПараметры = Неопределено) Экспорт  

	ЗагрузитьИзJson(Неопределено);
	
КонецПроцедуры  

// оповещение из ЗагрузитьИзJson()
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

	МассивАдресов = Новый Массив;
	Для каждого ОписаниеПомещенногоФайла Из МассивФайлов Цикл	
		МассивАдресов.Добавить(ОписаниеПомещенногоФайла.Адрес);
	КонецЦикла;        
	
	ЗагрузитьИзJsonНаСервереИзКаталога(МассивАдресов);
	
	ПереместитьФайлыВПапкуОбработанных(МассивФайлов);
	
		Колбэк = Новый ОписаниеОповещения("ЗагрузитьИзJsonКолБэк", ЭтотОбъект);
	
	ВыполнитьОбработкуОповещения(колбэк);
	
КонецПроцедуры   

&НаСервере
Процедура ЗагрузитьИзJsonНаСервереИзКаталога(МассивАдресов)
	
	ПараметрыВызова = Неопределено;
	_идВызова = мис_ЛоггерСервер.СоздатьИдВызова(ИдВызова, "Импорт номенклатуры. Интерактивный", ТекущаяДатаСеанса(),"Плагин", , Неопределено);
	обк=РеквизитФормыВЗначение("Объект");	
	Попытка
		обк.сетИдВызова(_идВызова);
	Исключение
	    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
	КонецПопытки;
	

	//Для каждого Адрес Из МассивАдресов Цикл
	//	обк.ЗагрузитьИзJsonНаСервереИзФайла(Адрес, ВидНоменклатуры, Обновлять);
	//КонецЦикла;
	
	обк.ЗагрузитьИзJsonНаСервереИзМассиваАдресов(МассивАдресов, Обновлять);
	

КонецПроцедуры

&НаКлиенте
// Описание_метода
//
// Параметры:
//	МассивФайлов 	- массив -  массив объектов Новый ОписаниеПередаваемогоФайла(одинФайл.ПолноеИмя);
//
Процедура ПереместитьФайлыВПапкуОбработанных(МассивФайлов)
//ОписаниеПомещенногоФайла.Адрес
//ОписаниеПомещенногоФайла.СсылкаНаФайл
//	ИдентификаторФайла (FileID)
//	Имя (Name)
//	Расширение (Extension)
//	Файл (File)

	Для каждого ОписаниеПомещенногоФайла Из МассивФайлов Цикл	
		//МассивАдресов.Добавить(ОписаниеПомещенногоФайла.Адрес);
		Источник = ИмяКаталога + "\"+ОписаниеПомещенногоФайла.СсылкаНаФайл.Имя;
		Приемник = ИмяКаталога + "\processed\"+ОписаниеПомещенногоФайла.СсылкаНаФайл.Имя;
		ПереместитьФайл(Источник, Приемник);
	КонецЦикла;        

		
КонецПроцедуры





