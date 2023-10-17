﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПриходныйОрдерНаТовары");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПриходныйОрдерНаТовары");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПриходныйОрдерНаТовары",
		"Форма_Плагин_Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПриходныйОрдерНаТовары",
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
//	jsonText 			- строка - оригинальное сообщение из брокера
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	
	ЗагрузитьОбъект_ВДокумент(СтруктураОбъекта, jsonText);
	
	
КонецФункции


Функция ЗагрузитьОбъект_ВДокумент(СтруктураОбъекта, jsonText = "") Экспорт
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.приходныйордернатовары") Тогда
		Возврат Неопределено;
	КонецЕсли;

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	СуществующийОбъект = Документы.ПриходныйОрдерНаТовары.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		
	Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = Документы.ПриходныйОрдерНаТовары.СоздатьДокумент();
		СсылкаНового = Документы.ПриходныйОрдерНаТовары.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	Иначе 
		// а вот здесь вопрос - надо обновлять документ или нет?
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		КонецЕсли;
	КонецЕсли;
		
	ОбъектДанных.Номер = id.Number;
	ОбъектДанных.Дата = id.Date;
	
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	


	//-------------------- ЗАПОЛНЕНИЕ РЕКВИЗИТОВ

	//															ЕРП
	ОбъектДанных.ВсегоМест	= 0;
	ОбъектДанных.ДатаВходящегоДокумента	= Неопределено;
	ОбъектДанных.ЗонаПриемки	= Неопределено;
	ОбъектДанных.Исполнитель	= ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию();
	ОбъектДанных.Комментарий	= деф.Комментарий;
	ОбъектДанных.НомерВходящегоДокумента	= Неопределено;
	ОбъектДанных.Ответственный	= ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию();
	ОбъектДанных.Отправитель	= Неопределено;
	ОбъектДанных.Помещение	= Неопределено;
	
	ОбъектДанных.Распоряжение	= НайтиЗаказНаПеремещение(деф.ДокументОснование);
	
	ОбъектДанных.РаспоряжениеНаНесколькоСкладов	= Ложь;
	ОбъектДанных.РежимПросмотраПоТоварам	= 0;	
	ОбъектДанных.Склад	= ксп_ИмпортСлужебный.НайтиСклад(деф.Склад, мВнешняяСистема);
	ОбъектДанных.СкладскаяОперация	= Перечисления.СкладскиеОперации.ПриемкаПоПеремещению;
	ОбъектДанных.СостояниеЗаполненияМногооборотнойТары	= Неопределено;
	ОбъектДанных.Статус	= Перечисления.СтатусыПриходныхОрдеров.Принят;                       
	ОбъектДанных.ХозяйственнаяОперация	= Перечисления.ХозяйственныеОперации.ПеремещениеТоваров;





	//------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();
	
	Для сч = 0 По деф.ТЧТовары.Количество()-1 Цикл

		стрк = деф.ТЧТовары[сч];

		СтрокаТЧ = ОбъектДанных.Товары.Добавить();
		
		СтрокаТЧ.ДокументОтгрузки =  Неопределено;
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;
		СтрокаТЧ.Комментарий	= Неопределено;
		СтрокаТЧ.Назначение	 = Неопределено;
		СтрокаТЧ.Номенклатура	= ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);
		СтрокаТЧ.Серия	= Неопределено;
		СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;
		СтрокаТЧ.Упаковка	= ксп_ИмпортСлужебный.НайтиЕдиницуИзмерения(стрк.Упаковка, стрк.Номенклатура);
		СтрокаТЧ.УпаковочныйЛист	= Неопределено;
		СтрокаТЧ.УпаковочныйЛистРодитель = Неопределено;
		СтрокаТЧ.Характеристика	= ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.Характеристика);
		СтрокаТЧ.Штрихкод	= "";
		СтрокаТЧ.ЭтоСлужебнаяСтрокаПустогоУпаковочногоЛиста	= 0;
		СтрокаТЧ.ЭтоУпаковочныйЛист	= Ложь;


	КонецЦикла;

	
	


	//------------------------------------------------------ ФИНАЛ
		
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();

	
	// сохранить исходное сообщение
	
//	РегистрыСведений.ксп_ИсходныеДанныеСообщений.ДобавитьЗапись(ОбъектДанных.Ссылка, jsonText);
	
	
	// добавить документ в РС для проведения
	
	ксп_ИмпортСлужебный.ПроверитьКачествоДанных(ОбъектДанных, ЭтотОбъект);
	
	

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

#КонецОбласти 	


Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Сумма" Тогда
		Если ТипЗнч(Значение) = Тип("Число") Тогда
			Возврат Значение;
		Иначе
			Возврат XMLЗначение(Тип("Число"),Значение);
		КонецЕсли;
	КонецЕсли;
	
КонецФункции



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция МассивРеквизитовШапкиДляПроверки() Экспорт
	
	мРеквизиты = Новый Массив;
	//мРеквизиты.Добавить("Склад");
	//мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиЗаказНаПеремещение(УзелДокументОснование)
	
	гуид="";
	ЕстьАтрибут = УзелДокументОснование.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ДокументОснование = Документы.ЗаказНаПеремещение.ПолучитьСсылку(
			Новый УникальныйИдентификатор(гуид));
		Возврат ДокументОснование;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции


 мВнешняяСистема = "retail";
 
 