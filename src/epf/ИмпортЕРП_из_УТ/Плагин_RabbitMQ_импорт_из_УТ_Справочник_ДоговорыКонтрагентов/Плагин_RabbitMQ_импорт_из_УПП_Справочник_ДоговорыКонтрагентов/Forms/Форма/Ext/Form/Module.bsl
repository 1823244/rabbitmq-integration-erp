﻿
&НаКлиенте
Процедура ЗагрузитьИзJson(Команда)
	
	ЗагрузитьИзJsonНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьИзJsonНаСервере()

	Ссылка = РеквизитФормыВЗначение("Объект").ЗагрузитьИзJsonНаСервере(JsonText);
	Сообщить(НСтр("ru = '"+строка(ссылка)+"'"), СтатусСообщения.БезСтатуса);

КонецПроцедуры