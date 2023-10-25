﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ЧекККМКоррекции");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ЧекККМКоррекции");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Документ_ЧекККМКоррекции",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Документ_ЧекККМКоррекции",
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
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.чекккмкоррекции") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Документы.ЧекККМКоррекции.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		ОбъектДанных = Документы.ЧекККМКоррекции.СоздатьДокумент();
		СсылкаНового = Документы.ЧекККМКоррекции.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.НомерДокумента = id.Number;
	ОбъектДанных.ДатаДокумента = id.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	//ОбъектДанных.Архивный = деф.Архивный;

	//гуид="";
	//ЕстьАтрибут = деф.Валюта.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Валюта = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Валюта.Ref ) );
	//Иначе
	//	ОбъектДанных.Валюта = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Валюта = ксп_ИмпортСлужебный.НайтиВалюта(деф.Валюта);

	//ОбъектДанных.ВидКоррекции = деф.ВидКоррекции;

	//гуид="";
	//ЕстьАтрибут = деф.ВидЦены.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ВидЦены = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ВидЦены.Ref ) );
	//Иначе
	//	ОбъектДанных.ВидЦены = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ВидЦены = ксп_ИмпортСлужебный.НайтиВидЦены(деф.ВидЦены);

	//ОбъектДанных.ДатаИсходнойПродажи = деф.ДатаИсходнойПродажи;

	//ОбъектДанных.ДатаСовершенияКорректируемогоРасчета = деф.ДатаСовершенияКорректируемогоРасчета;

	//ОбъектДанных.ИспользоватьОплатуБонуснымиБаллами = деф.ИспользоватьОплатуБонуснымиБаллами;

	//гуид="";
	//ЕстьАтрибут = деф.КартаЛояльности.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.КартаЛояльности = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.КартаЛояльности.Ref ) );
	//Иначе
	//	ОбъектДанных.КартаЛояльности = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.КартаЛояльности = ксп_ИмпортСлужебный.НайтиКартаЛояльности(деф.КартаЛояльности);

	//гуид="";
	//ЕстьАтрибут = деф.КассаККМ.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.КассаККМ = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.КассаККМ.Ref ) );
	//Иначе
	//	ОбъектДанных.КассаККМ = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.КассаККМ = ксп_ИмпортСлужебный.НайтиКассаККМ(деф.КассаККМ);

	//гуид="";
	//ЕстьАтрибут = деф.Кассир.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Кассир = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Кассир.Ref ) );
	//Иначе
	//	ОбъектДанных.Кассир = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Кассир = ксп_ИмпортСлужебный.НайтиКассир(деф.Кассир);

	//гуид="";
	//ЕстьАтрибут = деф.КассоваяСмена.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.КассоваяСмена = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.КассоваяСмена.Ref ) );
	//Иначе
	//	ОбъектДанных.КассоваяСмена = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.КассоваяСмена = ксп_ИмпортСлужебный.НайтиКассоваяСмена(деф.КассоваяСмена);

	//ОбъектДанных.Комментарий = деф.Комментарий;

	//_знч = "";
	//ЕстьЗначение = деф.НалогообложениеНДС.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.НалогообложениеНДС = деф.НалогообложениеНДС.Значение;
	//Иначе
	//	ОбъектДанных.НалогообложениеНДС = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.НалогообложениеНДС = ксп_ИмпортСлужебный.НайтиПеречисление_НалогообложениеНДС(деф.НалогообложениеНДС);

	//ОбъектДанных.НомерПредписанияНалоговогоОргана = деф.НомерПредписанияНалоговогоОргана;

	//ОбъектДанных.ОписаниеКоррекции = деф.ОписаниеКоррекции;

	//гуид="";
	//ЕстьАтрибут = деф.Организация.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Организация = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Организация.Ref ) );
	//Иначе
	//	ОбъектДанных.Организация = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизация(деф.Организация);

	//гуид="";
	//ЕстьАтрибут = деф.ОрганизацияЕГАИС.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ОрганизацияЕГАИС = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ОрганизацияЕГАИС.Ref ) );
	//Иначе
	//	ОбъектДанных.ОрганизацияЕГАИС = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ОрганизацияЕГАИС = ксп_ИмпортСлужебный.НайтиОрганизацияЕГАИС(деф.ОрганизацияЕГАИС);

	//ОбъектДанных.ОтложенДо = деф.ОтложенДо;

	//гуид="";
	//ЕстьАтрибут = деф.Партнер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Партнер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Партнер.Ref ) );
	//Иначе
	//	ОбъектДанных.Партнер = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Партнер = ксп_ИмпортСлужебный.НайтиПартнер(деф.Партнер);

	// перенесено после ТЧ Товары
	//ОбъектДанных.ПолученоНаличными = деф.ПолученоНаличными;

	ОбъектДанных.СкидкиРассчитаны = Истина;

	гуид="";
	ЕстьАтрибут = деф.Склад.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.Склад = регистрыСведений.ксп_МэппингМагазинСклад.ПоМэппингу(гуид, мВнешняяСистема);
	Иначе
		ОбъектДанных.Склад = Неопределено;
	КонецЕсли;

	ОбъектДанных.Статус = Перечисления.СтатусыЧековККМ.Пробит;

	// перенесено в конец, после заполнения ТЧ Товары
	//ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;

	//todo Вернуться
	Если деф.ТипКоррекции = 1 Тогда
		//ОбъектДанных.ТипКоррекции = что-то;
	КонецЕсли;
	

	ОбъектДанных.ФормаОплаты = перечисления.ФормыОплаты.Наличная;//нет в источнике

	ОбъектДанных.ЦенаВключаетНДС = Истина;

	гуид="";
	ЕстьАтрибут = деф.ЧекККМ.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.ЧекККМ = Документы.ЧекККМ.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ЧекККМ.Ref ) );
	Иначе
		ОбъектДанных.ЧекККМ = Неопределено;
	КонецЕсли;



	//------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();


		//СтрокаТЧ.ЕстьРазличие = стрк.ЕстьРазличие;

		//СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

		//СтрокаТЧ.КлючСвязи = стрк.КлючСвязи;

		СтрокаТЧ.Количество = стрк.Количество;

		СтрокаТЧ.КоличествоУпаковок = 0;

		ОбъектДанных.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);

		//гуид="";
		//ЕстьАтрибут = стрк.НоменклатураЕГАИС.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.НоменклатураЕГАИС = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НоменклатураЕГАИС.Ref ) );
		//Иначе
		//	СтрокаТЧ.НоменклатураЕГАИС = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.НоменклатураЕГАИС = ксп_ИмпортСлужебный.НайтиНоменклатураЕГАИС(стрк.НоменклатураЕГАИС);

		//гуид="";
		//ЕстьАтрибут = стрк.НоменклатураНабора.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.НоменклатураНабора = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НоменклатураНабора.Ref ) );
		//Иначе
		//	СтрокаТЧ.НоменклатураНабора = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.НоменклатураНабора = ксп_ИмпортСлужебный.НайтиНоменклатураНабора(стрк.НоменклатураНабора);

		//гуид="";
		//ЕстьАтрибут = стрк.Помещение.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Помещение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Помещение.Ref ) );
		//Иначе
		//	СтрокаТЧ.Помещение = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.Помещение = ксп_ИмпортСлужебный.НайтиПомещение(стрк.Помещение);

		//гуид="";
		//ЕстьАтрибут = стрк.Продавец.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Продавец = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Продавец.Ref ) );
		//Иначе
		//	СтрокаТЧ.Продавец = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.Продавец = ксп_ИмпортСлужебный.НайтиПродавец(стрк.Продавец);

		СтрокаТЧ.ПроцентАвтоматическойСкидки = 0;//todo Вернуться позже

		СтрокаТЧ.ПроцентРучнойСкидки = 0;

		//гуид="";
		//ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Серия = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Серия.Ref ) );
		//Иначе
		//	СтрокаТЧ.Серия = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.Серия = ксп_ИмпортСлужебный.НайтиСерия(стрк.Серия);

		ОбъектДанных.СтавкаНДС = ксп_ИмпортСлужебный.ОпределитьСтавкуНДСПоПеречислениюРозницы(стрк.СтавкаНДС);

		//СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;

		СтрокаТЧ.Сумма = стрк.СуммаСоСкидками;

		СтрокаТЧ.СуммаАвтоматическойСкидки = стрк.СуммаСкидок;

		СтрокаТЧ.СуммаБонусныхБалловКСписанию = 0;

		СтрокаТЧ.СуммаБонусныхБалловКСписаниюВВалюте = 0;

		СтрокаТЧ.СуммаНачисленныхБонусныхБалловВВалюте = 0;

		СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;

		СтрокаТЧ.СуммаРучнойСкидки = 0;

		ОбъектДанных.Упаковка = ксп_ИмпортСлужебный.НайтиЕдиницуИзмерения(стрк.ЕдиницаИзмерения, стрк.Номенклатура);

		ОбъектДанных.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.Характеристика);

		//гуид="";
		//ЕстьАтрибут = стрк.ХарактеристикаНабора.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ХарактеристикаНабора = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ХарактеристикаНабора.Ref ) );
		//Иначе
		//	СтрокаТЧ.ХарактеристикаНабора = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.ХарактеристикаНабора = ксп_ИмпортСлужебный.НайтиХарактеристикаНабора(стрк.ХарактеристикаНабора);

		СтрокаТЧ.Цена = стрк.ЦенаСоСкидками;

		СтрокаТЧ.Штрихкод = стрк.Штрихкод;

	КонецЦикла;

	ОбъектДанных.СуммаДокумента = ОбъектДанных.Товары.Итог("Сумма");
	ОбъектДанных.ПолученоНаличными = ОбъектДанных.СуммаДокумента;	
	
	//------------------------------------------------------     ТЧ ОплатаПлатежнымиКартами



	ОбъектДанных.ОплатаПлатежнымиКартами.Очистить();


	Для счТовары = 0 По деф.ТЧОплатаПлатежнымиКартами.Количество()-1 Цикл
		//стрк = деф.ТЧОплатаПлатежнымиКартами[счТовары];
		//СтрокаТЧ = ОбъектДанных.ОплатаПлатежнымиКартами.Добавить();


		//_знч = "";
		//ЕстьЗначение = стрк.ВидОплаты.свойство("Значение",_знч);
		//Если ЕстьЗначение Тогда
		//	СтрокаТЧ.ВидОплаты = стрк.ВидОплаты.Значение;
		//Иначе
		//	СтрокаТЧ.ВидОплаты = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.ВидОплаты = ксп_ИмпортСлужебный.НайтиПеречисление_ВидОплаты(стрк.ВидОплаты);

		//гуид="";
		//ЕстьАтрибут = стрк.ДоговорПодключения.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ДоговорПодключения = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ДоговорПодключения.Ref ) );
		//Иначе
		//	СтрокаТЧ.ДоговорПодключения = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.ДоговорПодключения = ксп_ИмпортСлужебный.НайтиДоговорПодключения(стрк.ДоговорПодключения);

		//СтрокаТЧ.ИдентификаторКорзины = стрк.ИдентификаторКорзины;

		//СтрокаТЧ.ИдентификаторПлатежнойСистемы = стрк.ИдентификаторПлатежнойСистемы;

		//СтрокаТЧ.КодАвторизации = стрк.КодАвторизации;

		//СтрокаТЧ.НомерПлатежнойКарты = стрк.НомерПлатежнойКарты;

		//СтрокаТЧ.НомерЧекаЭТ = стрк.НомерЧекаЭТ;

		//СтрокаТЧ.СсылочныйНомер = стрк.СсылочныйНомер;

		//СтрокаТЧ.Сумма = стрк.Сумма;

		//гуид="";
		//ЕстьАтрибут = стрк.ЭквайринговыйТерминал.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ЭквайринговыйТерминал = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ЭквайринговыйТерминал.Ref ) );
		//Иначе
		//	СтрокаТЧ.ЭквайринговыйТерминал = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//ОбъектДанных.ЭквайринговыйТерминал = ксп_ИмпортСлужебный.НайтиЭквайринговыйТерминал(стрк.ЭквайринговыйТерминал);

	КонецЦикла;






	//------------------------------------------------------ ФИНАЛ


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


 мВнешняяСистема = "retail";
 
 