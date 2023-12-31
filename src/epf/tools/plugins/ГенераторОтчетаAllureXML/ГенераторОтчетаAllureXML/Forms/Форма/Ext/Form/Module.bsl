﻿&НаКлиенте
Перем КонтекстЯдра;

// { Plugin interface

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
КонецПроцедуры

&НаКлиенте
Функция ОписаниеПлагина(КонтекстЯдра, ВозможныеТипыПлагинов) Экспорт
	Возврат ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов);
КонецФункции

&НаСервере
Функция ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов)
	КонтекстЯдраНаСервере = ВнешниеОбработки.Создать("xddTestRunner");
	Возврат ЭтотОбъектНаСервере().ОписаниеПлагина(КонтекстЯдраНаСервере, ВозможныеТипыПлагинов);
КонецФункции
// } Plugin interface

// { Report generator interface
&НаКлиенте
Функция СоздатьОтчет(КонтекстЯдра, РезультатыТестирования) Экспорт
	Объект.ТипыУзловДереваТестов = КонтекстЯдра.Плагин("ПостроительДереваТестов").Объект.ТипыУзловДереваТестов;
	Объект.ИконкиУзловДереваТестов = КонтекстЯдра.Плагин("ПостроительДереваТестов").Объект.ИконкиУзловДереваТестов;
	Объект.СостоянияТестов = КонтекстЯдра.Объект.СостоянияТестов;
	Возврат СоздатьОтчетНаСервере(РезультатыТестирования);
КонецФункции

&НаСервере
Функция СоздатьОтчетНаСервере(РезультатыТестирования)
	Возврат ЭтотОбъектНаСервере().СоздатьОтчетНаСервере(РезультатыТестирования);
КонецФункции

&НаКлиенте
Процедура Показать(Отчет) Экспорт
	Отчет.Показать();
КонецПроцедуры

&НаКлиенте
Процедура Экспортировать(Отчет, ПутьКОтчету, ОписаниеЗавершения = Неопределено) Экспорт

	Если КонтекстЯдра.ЕстьПоддержкаАсинхронныхВызовов Тогда
		
		НачатьПолучениеИмениФайла(Отчет, ПутьКОтчету, ОписаниеЗавершения);
		
	Иначе
		
		ИмяФайла = ПолучитьУникальноеИмяФайла(ПутьКОтчету);
		НачатьСохранениеОтчета(Отчет, ИмяФайла, ОписаниеЗавершения);
	КонецЕсли;

КонецПроцедуры
// } Report generator interface

&НаКлиенте
Процедура НачатьСохранениеОтчета(Отчет, ИмяФайла, ОписаниеОповещения)
	
	СтрокаXML = Отчет.ПолучитьТекст();
	
	ПроверитьИмяФайлаРезультатаAllureСервер(ИмяФайла);
	
	// Запись файла с кодировкой "UTF-8", а не "UTF-8 with BOM"
	ЗаписьТекста = Новый ЗаписьТекста(ИмяФайла, КодировкаТекста.ANSI);
	ЗаписьТекста.Закрыть();
	
	ЗаписьТекста = Новый ЗаписьТекста(ИмяФайла,,, Истина);
	КоличествоСтрок = СтрЧислоСтрок(СтрокаXML);
	Для НомерСтроки = 1 По КоличествоСтрок Цикл
		Стр = СтрПолучитьСтроку(СтрокаXML, НомерСтроки);
		ЗаписьТекста.ЗаписатьСтроку(Стр);
	КонецЦикла;
	ЗаписьТекста.Закрыть();
	
	Если ОписаниеОповещения <> Неопределено Тогда
		
		ВыполнитьОбработкуОповещения(ОписаниеОповещения);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьЭкспорт(ОбработкаОповещения, Отчет, ПолныйПутьФайла) Экспорт

	Экспортировать(Отчет, ПолныйПутьФайла, ОбработкаОповещения);

КонецПроцедуры

// { Helpers
&НаКлиенте
Процедура НачатьПолучениеИмениФайла(Отчет, ПутьКОтчету, ОписаниеЗавершения)
	Файл = Новый Файл(ПутьКОтчету);
	Файл.НачатьПроверкуСуществования(Новый ОписаниеОповещения("НачатьПроверкуСуществованияЗавершение", ЭтаФорма, Новый Структура("Файл,Отчет,ОписаниеЗавершения", Файл, Отчет, ОписаниеЗавершения)));
КонецПроцедуры

&НаКлиенте
Процедура НачатьПроверкуСуществованияЗавершение(Существует, ДополнительныеПараметры) Экспорт
	
	Файл = ДополнительныеПараметры.Файл;
	ОписаниеЗавершения = ДополнительныеПараметры.ОписаниеЗавершения;
	Отчет = ДополнительныеПараметры.Отчет;
	Если Существует Тогда
		
		Файл.НачатьПроверкуЭтоКаталог(Новый ОписаниеОповещения("НачатьПроверкуЭтоКаталогЗавершение", ЭтаФорма, Новый Структура("Файл,Отчет,ОписаниеЗавершения", Файл, Отчет, ОписаниеЗавершения)));
		
	Иначе
		
		ИмяФайла =  СформироватьИмя(Файл.Путь, Файл.ИмяБезРасширения);
		
		НачатьСохранениеОтчета(Отчет, ИмяФайла, ОписаниеЗавершения);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьПроверкуЭтоКаталогЗавершение(ЭтоКаталог, ДополнительныеПараметры) Экспорт
	
	Файл = ДополнительныеПараметры.Файл;
	ОписаниеЗавершения = ДополнительныеПараметры.ОписаниеЗавершения;
	Отчет = ДополнительныеПараметры.Отчет;
	
	Если ЭтоКаталог Тогда
		
		ПутьОтчета = Файл.ПолноеИмя;
		МаскаИмени	= "";
		
	Иначе
		
		ПутьОтчета =  Файл.Путь;
		МаскаИмени = Файл.ИмяБезРасширения;
		
	КонецЕсли;
	
	ИмяФайла = СформироватьИмя(ПутьОтчета, МаскаИмени);
	НачатьСохранениеОтчета(Отчет, ИмяФайла, ОписаниеЗавершения);
	
КонецПроцедуры

&НаКлиенте
// задаю уникальное имя для возможности получения одного отчета allure по разным тестовым наборам
Функция ПолучитьУникальноеИмяФайла(Знач ПутьКОтчету)
	
	Файл = Новый Файл(ПутьКОтчету);
	
	Если Файл.Существует() И Файл.ЭтоКаталог() Тогда
		
		ПутьКаталога = Файл.ПолноеИмя;
		МаскаИмени	= "";
		
	Иначе
		
		ПутьКаталога = Файл.Путь;
		МаскаИмени = Файл.ИмяБезРасширения;
		
	КонецЕсли;
	
	Возврат СформироватьИмя(ПутьКаталога, МаскаИмени);
		
КонецФункции

&НаКлиенте
Функция СформироватьИмя(Путь, МаскаИмени = "")
	
	ГУИД = Новый УникальныйИдентификатор;
	
	ИмяФайла = СтрЗаменить("%1-%2-testsuite.xml", "%1", ГУИД);
	ИмяФайла = СтрЗаменить(ИмяФайла, "%2", МаскаИмени);
	
	ИмяФайла = Путь + "/" + ИмяФайла; 
	
	Возврат ИмяФайла;
	
КонецФункции

&НаСервере
Процедура ПроверитьИмяФайлаРезультатаAllureСервер(ИмяФайла) Экспорт
	
	Сообщение = "Уникальное имя файла " + ИмяФайла;
	ЗаписьЖурналаРегистрации("xUnitFor1C.ГенераторОтчетаAllureXML", УровеньЖурналаРегистрации.Информация, , , Сообщение);
	
	ЭтотОбъектНаСервере().ПроверитьИмяФайлаРезультатаAllure(ИмяФайла);
КонецПроцедуры

&НаСервере
Функция ЭтотОбъектНаСервере()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
// } Helpers

