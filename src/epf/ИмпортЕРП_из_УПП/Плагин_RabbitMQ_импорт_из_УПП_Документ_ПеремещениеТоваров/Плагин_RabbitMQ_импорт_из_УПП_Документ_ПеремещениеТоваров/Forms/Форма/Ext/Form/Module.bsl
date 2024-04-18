﻿&НаСервере
Функция ЗагрузитьИзJsonНаСервере()
	идВызова = мис_ЛоггерСервер.СоздатьИдВызова(Неопределено, "Импорт перемещения товаров. Интерактивно", ТекущаяДатаСеанса(),"", Неопределено, Неопределено);
	Об = РеквизитФормыВЗначение("Объект");
	об.сетИдВызова(ИдВызова);
	Ссылка = Об.ЗагрузитьИзJsonНаСервере(JsonText);
	СсылочныйТип = Ссылка;
    Возврат Ссылка;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьИзJson(Команда)
	Ссылка = ЗагрузитьИзJsonНаСервере();
	Сообщить(НСтр("ru = '"+строка(ссылка)+"'"), СтатусСообщения.БезСтатуса);
КонецПроцедуры


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.Версия.Заголовок = "Версия :"+Строка(
		РеквизитФормыВЗначение("Объект").СведенияОВнешнейОбработке().Версия
	);
КонецПроцедуры


&НаКлиенте
Процедура ПоказатьЛог(Команда)
	мис_ЛоггерКлиент.ОткрытьОтчетПоЛогу(ИдВызова, Ложь, ЭтаФорма);
КонецПроцедуры


&НаКлиенте
Процедура ИдВызоваНажатие(Элемент, СтандартнаяОбработка)
	ПоказатьЗначение(,идвызова);
КонецПроцедуры

