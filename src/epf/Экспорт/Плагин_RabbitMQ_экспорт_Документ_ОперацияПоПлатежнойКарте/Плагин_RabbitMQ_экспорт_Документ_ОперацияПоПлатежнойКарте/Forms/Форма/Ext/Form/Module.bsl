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
	ДокОбк = Документы.ОперацияПоПлатежнойКарте.СоздатьДокумент();
	
	ДокОбк.Дата = ТекущаяДатаСеанса();
	
	Докобк.Организация = справочники.Организации.ОрганизацияПоУмолчанию();
	
	// Табл части
	
	//РасшифровкаПлатежа
	новСтр = докОбк.РасшифровкаПлатежа.Добавить();
	

	// ФИНАЛ
	
	Докобк.ОбменДанными.Загрузка = Истина;
	ДокОбк.Записать();
	
	СсылочныйТип = ДокОбк.Ссылка;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьТестовыйДокумент(Команда)
	СоздатьТестовыйДокументНаСервере();
КонецПроцедуры
