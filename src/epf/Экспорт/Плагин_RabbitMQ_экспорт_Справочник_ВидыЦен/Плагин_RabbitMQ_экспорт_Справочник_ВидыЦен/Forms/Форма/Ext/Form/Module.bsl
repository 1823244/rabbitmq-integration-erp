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
Процедура создатьТестовыйОбъектНаСервере()
	НачатьТранзакцию();
	
	ТестовыйОбъект = Справочники.ВидыЦен.СоздатьЭлемент();
	
	ТестовыйОбъект.ВлияющиеВидыЦен.Добавить();
	ТестовыйОбъект.ДополнительныеРеквизиты.Добавить();
	ТестовыйОбъект.ЦеновыеГруппы.Добавить();
	ТестовыйОбъект.ПравилаОкругленияЦены.Добавить();
	ТестовыйОбъект.ПорогиСрабатывания.Добавить();
	ТестовыйОбъект.Валюты.Добавить();

	ТестовыйОбъект.ОбменДанными.Загрузка = Истина;
	ТестовыйОбъект.Записать();
	
	СсылочныйТип = ТестовыйОбъект.Ссылка;
	
	сообщить(ВыгрузитьОбъектНаСервере());
	
	ОтменитьТранзакцию();
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура создатьТестовыйОбъект(Команда)
	создатьТестовыйОбъектНаСервере();
КонецПроцедуры
