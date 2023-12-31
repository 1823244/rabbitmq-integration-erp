﻿
&НаСервере
Функция ВыгрузитьОбъектНаСервере()
	json = РеквизитФормыВЗначение("Объект").ВыгрузитьОбъект(СсылочныйТип);
	return json;
КонецФункции

&НаКлиенте
Процедура ВыгрузитьОбъект(Команда)
	json = ВыгрузитьОбъектНаСервере();
	message(json);
КонецПроцедуры





&НаСервере
Процедура СоздатьТестовыйДокументНаСервере()
	ДокОбк = Документы.ВыемкаДенежныхСредствИзКассыККМ.СоздатьДокумент();
	
	ДокОбк.Дата = ТекущаяДатаСеанса();
	
	Докобк.Организация = справочники.Организации.ОрганизацияПоУмолчанию();


	// ФИНАЛ
	
	Докобк.ОбменДанными.Загрузка = Истина;
	ДокОбк.Записать();
	
	СсылочныйТип = ДокОбк.Ссылка;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьТестовыйДокумент(Команда)
	СоздатьТестовыйДокументНаСервере();
КонецПроцедуры
