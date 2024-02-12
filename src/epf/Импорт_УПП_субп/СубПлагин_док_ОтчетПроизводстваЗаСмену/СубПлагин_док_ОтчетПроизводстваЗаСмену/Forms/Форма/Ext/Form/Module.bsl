﻿&НаСервере
Функция ЗагрузитьИзJsonНаСервере()
	Об = РеквизитФормыВЗначение("Объект");
	Ссылка = Об.ЗагрузитьИзJsonНаСервере(JsonText);
	СсылочныйТип = Ссылка;
    Возврат Ссылка;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьИзJson(Команда)
	Рез = ЗагрузитьИзJsonНаСервере();
	
	Если ТипЗнч(Рез) = Тип("Структура") Тогда
		
		//Сообщить(НСтр("ru = ' Заказ на производство: "+строка(Рез.ЗаказНаПроизводство)+"'"), СтатусСообщения.БезСтатуса);
		//Сообщить(НСтр("ru = ' Заказ на перемещение: "+строка(Рез.ЗаказНаПеремещение)+"'"), СтатусСообщения.БезСтатуса);
		//Сообщить(НСтр("ru = ' Приходный ордер на товары: "+строка(Рез.ПО)+"'"), СтатусСообщения.БезСтатуса);
		//Сообщить(НСтр("ru = ' Перемещение товаров: "+строка(Рез.Перемещение)+"'"), СтатусСообщения.БезСтатуса);
		
		ТаблицаДокументов.Добавить().ДокСсылка = Рез.ЗаказНаПроизводство;
		ТаблицаДокументов.Добавить().ДокСсылка = Рез.ЗаказНаПеремещение;
		ТаблицаДокументов.Добавить().ДокСсылка = Рез.ПО;
		ТаблицаДокументов.Добавить().ДокСсылка = Рез.Перемещение;
	Иначе 
		Сообщить(НСтр("ru = '"+строка(Рез)+"'"), СтатусСообщения.БезСтатуса);
	КонецЕсли;

КонецПроцедуры

