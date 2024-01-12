﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ДвиженияКМФулфилмент = ПредопределенноеЗначение("Документ.ДвиженияКМФулфилмент.пустаяСсылка");
КонецПроцедуры


// В основном для отладки. Отправляет в ЧЗ документ с формы обработки
&НаСервере
Процедура ОтправитьЗапросВЧестныйЗнакНаСервере()

	НастройкаПодключения = Константы.ксп_ПодключениеКЧестномуЗнаку.Получить();
	Если НЕ ЗначениеЗаполнено(НастройкаПодключения) Тогда
		ВызватьИсключение "Не установлена константа ксп_ПодключениеКЧестномуЗнаку!";
	КонецЕсли;
	
	Сервер 			= НастройкаПодключения.Сервер;
	ГруппаТоваров 	= НастройкаПодключения.ТоварнаяГруппа;
	Сертификат 		= НастройкаПодключения.Сертификат;
	ИННУчастника	= НастройкаПодключения.Организация.ИНН;
    Токен 			= ксп_Элис_ОбщегоНазначения.ПолучитьТокенНаСервере(Сервер, Сертификат);
	сообщить("Токен=см. следующее сообщение");
	сообщить(""+строка(Токен));
	ДатаВыбытия 	= ДвиженияКМФулфилмент.Дата;
	НомерВыбытия 	= ДвиженияКМФулфилмент.Номер;

	ОбъектЭтойОбработки = РеквизитФормыВЗначение("Объект");
	
	ОбъектЭтойОбработки.ВывестиИзОборота(ИННУчастника, ДвиженияКМФулфилмент.Ссылка, ДатаВыбытия, НомерВыбытия, Сервер, ГруппаТоваров, Токен, Сертификат);
	
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьЗапросВЧестныйЗнак(Команда)
	ОтправитьЗапросВЧестныйЗнакНаСервере();
КонецПроцедуры


#Область ПроверкаДокумента 

&НаСервере
Процедура ПроверитьДокументНаСервере()
	НастройкаПодключения = Константы.ксп_ПодключениеКЧестномуЗнаку.Получить();
	Если НЕ ЗначениеЗаполнено(НастройкаПодключения) Тогда
		ВызватьИсключение "Не установлена константа ксп_ПодключениеКЧестномуЗнаку!";
	КонецЕсли;
	
	Сервер 			= НастройкаПодключения.Сервер;
	ГруппаТоваров 	= НастройкаПодключения.ТоварнаяГруппа;
	Сертификат 		= НастройкаПодключения.Сертификат;
	ИННУчастника	= НастройкаПодключения.Организация.ИНН;
    Токен 			= ксп_Элис_ОбщегоНазначения.ПолучитьТокенНаСервере(Сервер, Сертификат);
	сообщить("Токен=см. следующее сообщение");
	сообщить(""+строка(Токен));
	ДатаВыбытия 	= ДвиженияКМФулфилмент.Дата;
	НомерВыбытия 	= ДвиженияКМФулфилмент.Номер;

	ОбъектЭтойОбработки = РеквизитФормыВЗначение("Объект");
	
	Рез = ОбъектЭтойОбработки.ПроверитьДокумент(ИННУчастника, ДвиженияКМФулфилмент.Ссылка, Сервер, ГруппаТоваров, Токен, Сертификат);
	
	сообщить(Рез);

	
КонецПроцедуры


&НаКлиенте
Процедура ПроверитьДокумент(Команда)
	ПроверитьДокументНаСервере();
КонецПроцедуры


#КонецОбласти




