﻿
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_ИнформационныеКарты");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_ИнформационныеКарты");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Справочник_ИнформационныеКарты",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Справочник_ИнформационныеКарты",
		ТипКоманды, 
		Ложь) ;
	
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")

	//ТаблицаКоманд.Колонки.Добавить("Представление", РеквизитыТабличнойЧасти.Представление.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Идентификатор", РеквизитыТабличнойЧасти.Идентификатор.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	//ТаблицаКоманд.Колонки.Добавить("ПоказыватьОповещение", РеквизитыТабличнойЧасти.ПоказыватьОповещение.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Модификатор", РеквизитыТабличнойЧасти.Модификатор.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Скрыть",      РеквизитыТабличнойЧасти.Скрыть.Тип);
	//ТаблицаКоманд.Колонки.Добавить("ЗаменяемыеКоманды", РеквизитыТабличнойЧасти.ЗаменяемыеКоманды.Тип);
	
//           ** Использование - Строка - тип команды:
//               "ВызовКлиентскогоМетода",
//               "ВызовСерверногоМетода",
//               "ЗаполнениеФормы",
//               "ОткрытиеФормы" или
//               "СценарийВБезопасномРежиме".
//               Для получения типов команд рекомендуется использовать функции
//               ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКоманды<ИмяТипа>.
//               В комментариях к этим функциям также даны шаблоны процедур-обработчиков команд.

	НоваяКоманда = ТаблицаКоманд.Добавить() ;
	НоваяКоманда.Представление = Представление ;
	НоваяКоманда.Идентификатор = Идентификатор ;
	НоваяКоманда.Использование = Использование ;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение ;
	НоваяКоманда.Модификатор = Модификатор ;
КонецПроцедуры


#КонецОбласти 	


// Описание_метода
//
// Параметры:
//	СтруктураОбъекта	- структура - после метода тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	
	Если НЕ НРег(СтруктураОбъекта.type) = "справочник.информационныекарты" Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;                                                    

	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Справочники.КартыЛояльности.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		Если деф.isFolder Тогда
			ОбъектДанных = Справочники.КартыЛояльности.СоздатьГруппу();
		Иначе 
			ОбъектДанных = Справочники.КартыЛояльности.СоздатьЭлемент();
		КонецЕсли;
		СсылкаНового = Справочники.КартыЛояльности.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- РЕКВИЗИТЫ
	
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	ОбъектДанных.Наименование = деф.Description;


	//гуид="";
	//ЕстьАтрибут = деф.Контрагент.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Контрагент = деф.Контрагент.Ref;
	//Иначе
	//	ОбъектДанных.Контрагент = Неопределено;
	//КонецЕсли;
	
	ОбъектДанных.МагнитныйКод = деф.КодКарты;
	
	//гуид="";
	//ЕстьАтрибут = деф.Партнер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Партнер = деф.Партнер.Ref;
	//Иначе
	//	ОбъектДанных.Партнер = Неопределено;
	//КонецЕсли;
	
	//гуид="";
	//ЕстьАтрибут = деф.Соглашение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Соглашение = деф.Соглашение.Ref;
	//Иначе
	//	ОбъектДанных.Соглашение = Неопределено;
	//КонецЕсли;
	
	//_знч = "";
	//ЕстьЗначение = деф.Статус.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.Статус = деф.Статус.Значение;
	//Иначе
	//	ОбъектДанных.Статус = Неопределено;
	//КонецЕсли;
	
	ОбъектДанных.Статус = перечисления.СтатусыКартЛояльности.Действует;
	
	ОбъектДанных.Штрихкод = деф.КодКарты;

	
	//------------------------------------- ФИНАЛ
	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();
	

	// сохранить исходный json
	//РегистрыСведений.ксп_ИсходныеДанныеСообщений.ДобавитьЗапись(ОбъектДанных.Ссылка, jsonText);
	
	Возврат ОбъектДанных.Ссылка;
	
	
КонецФункции


#Область Тестирование

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервере(Json) export


	мЧтениеJSON = Новый ЧтениеJSON;

	
	мЧтениеJSON.УстановитьСтроку(Json);
		
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура

	
	
	Возврат ЗагрузитьОбъект(СтруктураОбъекта, json);
	
КонецФункции

Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Сумма" Тогда
		Возврат XMLЗначение(Тип("Число"),Значение);
	КонецЕсли;
	Если Свойство = "Валюта" Тогда
		Возврат Справочники.Валюты.НайтиПоКоду(Значение);
	КонецЕсли;
	
КонецФункции


#КонецОбласти 	


мВнешняяСистема = "retail";

