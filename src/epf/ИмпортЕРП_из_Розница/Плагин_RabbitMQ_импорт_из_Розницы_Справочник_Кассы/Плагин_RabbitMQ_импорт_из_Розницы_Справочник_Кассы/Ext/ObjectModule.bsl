﻿
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_Кассы");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Справочник_Кассы");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Справочник_Кассы",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Справочник_Кассы",
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


Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("справочник.кассы") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с мэппингом
	
	// Если нашли кассу по мэппингу - выходим.
	// Если такого ГУИДа в регистре еще нет - добавляем
	
	НаименованиеДляМэппинга = деф.Description+", Код: "+id.code;
	Касса = Неопределено;
	Если РегистрыСведений.ксп_МэппингСправочникКассы.ЕстьГУИД(id.Ref, мВнешняяСистема) Тогда
		Касса = РегистрыСведений.ксп_МэппингСправочникКассы.ПоМэппингу(id.Ref, мВнешняяСистема);
	Иначе 
		РегистрыСведений.ксп_МэппингСправочникКассы.ДобавитьГУИД(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема);
		// здесь идеально было бы отправить алерт, чтобы пользователь проставил мэппинг
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Касса) Тогда
		Возврат Касса;
	КонецЕсли;
	
	//------------------------------------- работа с GUID
	
	// Созданный склад не добавляем в регистр мэппингов, т.к. функция поиска сможет найти его по ГУИДу
	
	СуществующийОбъект = Справочники.Кассы.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		ОбъектДанных = Справочники.Кассы.СоздатьЭлемент();
		СсылкаНового = Справочники.Кассы.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов

	//ОбъектДанных.Код = id.Code; нет кода
	
	
	ОбъектДанных.Наименование = деф.Description;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;


	ОбъектДанных.ВалютаДенежныхСредств = Константы.ВалютаРегламентированногоУчета.Получить();

	//гуид="";
	//ЕстьАтрибут = деф.ГруппаФинансовогоУчета.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ГруппаФинансовогоУчета = деф.ГруппаФинансовогоУчета.Ref;
	//Иначе
	//	ОбъектДанных.ГруппаФинансовогоУчета = Неопределено;
	//КонецЕсли;

	//гуид="";
	//ЕстьАтрибут = деф.КассоваяКнига.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.КассоваяКнига = деф.КассоваяКнига.Ref;
	//Иначе
	//	ОбъектДанных.КассоваяКнига = Неопределено;
	//КонецЕсли;

	//гуид="";
	//ЕстьАтрибут = деф.НаправлениеДеятельности.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.НаправлениеДеятельности = деф.НаправлениеДеятельности.Ref;
	//Иначе
	//	ОбъектДанных.НаправлениеДеятельности = Неопределено;
	//КонецЕсли;

	//ОбъектДанных.ОперационнаяКасса = деф.ОперационнаяКасса;
	//гуид="";
	//ЕстьАтрибут = деф.Подразделение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Подразделение = деф.Подразделение.Ref;
	//Иначе
	//	ОбъектДанных.Подразделение = Неопределено;
	//КонецЕсли;

	//ОбъектДанных.РазрешитьПлатежиБезУказанияЗаявок = деф.РазрешитьПлатежиБезУказанияЗаявок;
	//ОбъектДанных.СрокИнкассации = деф.СрокИнкассации;

	//гуид="";
	//ЕстьАтрибут = деф.ФизическоеЛицо.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ФизическоеЛицо = деф.ФизическоеЛицо.Ref;
	//Иначе
	//	ОбъектДанных.ФизическоеЛицо = Неопределено;
	//КонецЕсли;

	//ОбъектДанных.ЭтоКассаОбособленногоПодразделения = деф.ЭтоКассаОбособленногоПодразделения;




	//------------------------------------------------------ ФИНАЛ
	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();
	
	// Созданный элемент добавляем в регистр мэппингов (если есть), т.к. это выглядит логичным для пользователя
	РегистрыСведений.ксп_МэппингСправочникКассы.ДобавитьЗапись(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема, ОбъектДанных.Ссылка);	

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

