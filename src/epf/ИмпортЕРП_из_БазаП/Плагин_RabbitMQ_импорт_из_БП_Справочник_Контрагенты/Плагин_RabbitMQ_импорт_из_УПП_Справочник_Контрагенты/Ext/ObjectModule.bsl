﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_УПП_Справочник_Контрагенты");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_УПП_Справочник_Контрагенты");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_УПП_Справочник_Контрагенты",
		"Форма_Плагин_RabbitMQ_импорт_из_УПП_Справочник_Контрагенты",
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
Функция ЗагрузитьОбъект(СтруктураОбъекта) Экспорт
	
	Если НЕ НРег(СтруктураОбъекта.type) = "справочник.контрагенты" Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	id = СтруктураОбъекта.identification;
	def = СтруктураОбъекта.definition;
	
	СуществующийОбъект = Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	
	Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = Справочники.Контрагенты.СоздатьЭлемент();
		ОбъектДанныхПартнер = Справочники.Партнеры.СоздатьЭлемент();
		ОбъектДанных.УстановитьНовыйКод();
		ОбъектДанныхПартнер.УстановитьНовыйКод();
		СсылкаНового = Справочники.Контрагенты.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);	
	Иначе 
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		Если объектДанных.Партнер = Справочники.Партнеры.ПустаяСсылка() Тогда
			ОбъектДанныхПартнер = Справочники.Партнеры.СоздатьЭлемент(); 
		Иначе
			ОбъектДанныхПартнер = ОбъектДанных.Партнер.ПолучитьОбъект();
		КонецЕсли;	
	КонецЕсли;
		
	ОбъектДанных.Наименование = def.description;  
	
	Если ОбъектДанныхПартнер <> Справочники.Партнеры.ПустаяСсылка() Тогда
		ОбъектДанныхПартнер.Наименование = def.description;
	КонецЕсли;
		
	ОбъектДанных.ПометкаУдаления = def.DeletionMark;       	
	
	ОбъектДанных.НаименованиеПолное = def.НаименованиеПолное;
	
	
	Если ОбъектДанныхПартнер <> Справочники.Партнеры.ПустаяСсылка() Тогда
		ОбъектДанныхПартнер.НаименованиеПолное = def.НаименованиеПолное;
	КонецЕсли;
	
	ОбъектДанных.КПП = def.КПП;	
	
	ОбъектДанных.ИНН = def.ИНН;
	
	Попытка
	ОбъектДанных.СтранаРегистрации = Справочники.СтраныМира.НайтиПоКоду(def.Страна.code);
	Исключение
	КонецПопытки;
		
	ИП = Найти(def.description, "ИП");
	
	Если def.ЮрФизЛицо.Значение = "ЮрЛицо" Тогда
		ОбъектДанных.ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо;
		ОбъектДанных.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо;
		ОбъектДанныхПартнер.ЮрФизЛицо = Перечисления.КомпанияЧастноеЛицо.Компания;
	ИначеЕсли def.НеРезидент = true Тогда
		ОбъектДанных.ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо;
		ОбъектДанных.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицоНеРезидент;
		ОбъектДанныхПартнер.ЮрФизЛицо = Перечисления.КомпанияЧастноеЛицо.Компания;
	ИначеЕсли ИП > 0 Тогда
		ОбъектДанных.ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо;
		ОбъектДанных.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель;
		ОбъектДанныхПартнер.ЮрФизЛицо = Перечисления.КомпанияЧастноеЛицо.ЧастноеЛицо;
	Иначе
		ОбъектДанных.ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо;
		ОбъектДанныхПартнер.ЮрФизЛицо = Перечисления.КомпанияЧастноеЛицо.ЧастноеЛицо;
	КонецЕсли;
	
	ОбъектДанныхПартнер.Клиент = def.Покупатель;
	
	Попытка
		ОбъектДанныхПартнер.ДатаРегистрации = def.Date;
	Исключение
	КонецПопытки;

	ОбъектДанныхПартнер.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанныхПартнер.Записать(); 
	
	ОбъектДанных.Партнер = ОбъектДанныхПартнер.Ссылка;
	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать(); 
	
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

	
	
	Возврат ЗагрузитьОбъект(СтруктураОбъекта);
	
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