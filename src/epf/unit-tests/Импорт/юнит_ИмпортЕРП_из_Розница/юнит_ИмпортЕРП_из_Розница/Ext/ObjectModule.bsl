﻿

Перем КонтекстЯдра;
Перем Ожидаем;
Перем ИнтеграцияРэббит;

Перем ЭтоЗначениеЗаполняетсяПередЗапускомТеста;
Перем ЭтоЗначениеЗаполняетсяПослеЗапускаТеста;
Перем ТекстИсключенияПадающегоТеста;

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	ИнтеграцияРэббит = КонтекстЯдра.Плагин("ИнтеграцияРэббит");
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	
	НаборТестов.Добавить("ТестОркестратораИмпорта");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьРезультатТестированияОтсутствующегоМетода");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьВызов_ПослеЗапускаТеста");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьВызов_ПослеЗапускаТеста_УПадающегоТеста");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьРезультатТеста_Когда_ПередЗапускаТеста_СОшибкой");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьРезультатТеста_Когда_ПослеЗапускаТеста_СОшибкой");
	
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	ЭтоЗначениеЗаполняетсяПередЗапускомТеста = Истина;
	ЭтоЗначениеЗаполняетсяПослеЗапускаТеста = Неопределено;
	
	НачатьТранзакцию();
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	ЭтоЗначениеЗаполняетсяПослеЗапускаТеста = Истина;
	
	ОтменитьТранзакцию();
КонецПроцедуры

Процедура ПередЗапускомТеста_СОшибкой() Экспорт
	ВызватьИсключение "ПередЗапускомТеста_СОшибкой";
КонецПроцедуры

Процедура ПослеЗапускаТеста_СОшибкой() Экспорт
	ВызватьИсключение "ПослеЗапускаТеста_СОшибкой";
КонецПроцедуры





// проверяет лишь факт выполнения метода плагина
Процедура ТестОркестратораИмпорта() Экспорт
	
	//Ожидаем.Что(
	//	Новый УникальныйИдентификатор(тДанные.identification.Ref))
	//	.Равно(
	//	Объект.Ссылка.УникальныйИдентификатор());
	
	
КонецПроцедуры


 