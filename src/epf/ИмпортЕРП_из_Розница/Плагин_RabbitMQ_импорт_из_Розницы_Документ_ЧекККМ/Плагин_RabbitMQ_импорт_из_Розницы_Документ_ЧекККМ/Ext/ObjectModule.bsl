﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.5");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ЧекККМ");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ЧекККМ");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Документ_ЧекККМ",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Документ_ЧекККМ",
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
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.ЧекККМ") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	СуществующийОбъект = Документы.ЧекККМ.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		
	Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = Документы.ЧекККМ.СоздатьДокумент();
		СсылкаНового = Документы.ЧекККМ.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
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

	
	
	
//	ОбъектДанных.Архивный = деф.Архивный;

//	гуид="";
//	ЕстьАтрибут = деф.Валюта.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.Валюта = деф.Валюта.Ref;
//	Иначе
//		ОбъектДанных.Валюта = Неопределено;
//	КонецЕсли;
	ОбъектДанных.Валюта = константы.ВалютаРегламентированногоУчета.Получить();
//	гуид="";
//	ЕстьАтрибут = деф.ВидЦены.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.ВидЦены = деф.ВидЦены.Ref;
//	Иначе
//		ОбъектДанных.ВидЦены = Неопределено;
//	КонецЕсли;
//	гуид="";
//	ЕстьАтрибут = деф.ГруппаФинансовогоУчета.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.ГруппаФинансовогоУчета = деф.ГруппаФинансовогоУчета.Ref;
//	Иначе
//		ОбъектДанных.ГруппаФинансовогоУчета = Неопределено;
//	КонецЕсли;
//	ОбъектДанных.ИдентификаторДокумента = деф.ИдентификаторДокумента;
//	ОбъектДанных.ИспользоватьОплатуБонуснымиБаллами = деф.ИспользоватьОплатуБонуснымиБаллами;

	гуид="";
	ЕстьАтрибут = деф.ДисконтнаяКарта.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.КартаЛояльности = Справочники.КартыЛояльности.ПолучитьСсылку(
			Новый УникальныйИдентификатор(деф.ДисконтнаяКарта.Ref));
	Иначе
		ОбъектДанных.КартаЛояльности = Неопределено;
	КонецЕсли;

	ОбъектДанных.КассаККМ = ксп_ИмпортСлужебный.НайтиКассуККМ(деф.КассаККМ);

//	гуид="";
//	ЕстьАтрибут = деф.Кассир.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.Кассир = деф.Кассир.Ref;
//	Иначе
//		ОбъектДанных.Кассир = Неопределено;
//	КонецЕсли;

//	гуид="";
//	ЕстьАтрибут = деф.КассоваяСмена.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.КассоваяСмена = деф.КассоваяСмена.Ref;
//	Иначе
//		ОбъектДанных.КассоваяСмена = Неопределено;
//	КонецЕсли;

	ОбъектДанных.Комментарий = деф.Комментарий;

	ОбъектДанных.Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, мВнешняяСистема);

//	_знч = "";
//	ЕстьЗначение = деф.НалогообложениеНДС.свойство("Значение",_знч);
//	Если ЕстьЗначение Тогда
//		ОбъектДанных.НалогообложениеНДС = деф.НалогообложениеНДС.Значение;
//	Иначе
//		ОбъектДанных.НалогообложениеНДС = Неопределено;
//	КонецЕсли;

	ОбъектДанных.НалогообложениеНДС = перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
	
//	гуид="";
//	ЕстьАтрибут = деф.НаправлениеДеятельности.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.НаправлениеДеятельности = деф.НаправлениеДеятельности.Ref;
//	Иначе
//		ОбъектДанных.НаправлениеДеятельности = Неопределено;
//	КонецЕсли;

	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация,мВнешняяСистема);

//	гуид="";
//	ЕстьАтрибут = деф.ОрганизацияЕГАИС.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.ОрганизацияЕГАИС = деф.ОрганизацияЕГАИС.Ref;
//	Иначе
//		ОбъектДанных.ОрганизацияЕГАИС = Неопределено;
//	КонецЕсли;

//	ОбъектДанных.ОтложенДо = деф.ОтложенДо;

//	гуид="";
//	ЕстьАтрибут = деф.Партнер.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.Партнер = деф.Партнер.Ref;
//	Иначе
//		ОбъектДанных.Партнер = Неопределено;
//	КонецЕсли;
	ОбъектДанных.Партнер = ОбъектДанных.Контрагент.Партнер;

//	гуид="";
//	ЕстьАтрибут = деф.Подразделение.свойство("Ref",гуид);
//	Если ЕстьАтрибут Тогда
//		ОбъектДанных.Подразделение = деф.Подразделение.Ref;
//	Иначе
//		ОбъектДанных.Подразделение = Неопределено;
//	КонецЕсли;

	ОбъектДанных.ПолученоНаличными = деф.ВыручкаНаличными;

//	_знч = "";
//	ЕстьЗначение = деф.ПорядокРасчетов.свойство("Значение",_знч);
//	Если ЕстьЗначение Тогда
//		ОбъектДанных.ПорядокРасчетов = деф.ПорядокРасчетов.Значение;
//	Иначе
//		ОбъектДанных.ПорядокРасчетов = Неопределено;
//	КонецЕсли;

	ОбъектДанных.СкидкиРассчитаны = деф.СкидкиРассчитаны;
	
	гуид="";
	ЕстьАтрибут = деф.Магазин.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.Склад = регистрыСведений.ксп_МэппингМагазинСклад.ПоМэппингу(гуид, мВнешняяСистема);
	Иначе
		ОбъектДанных.Склад = Неопределено;
	КонецЕсли;
	
//	_знч = "";
//	ЕстьЗначение = деф.Статус.свойство("Значение",_знч);
//	Если ЕстьЗначение Тогда
//		ОбъектДанных.Статус = деф.Статус.Значение;
//	Иначе
//		ОбъектДанных.Статус = Неопределено;
//	КонецЕсли;
	ОбъектДанных.Статус = Перечисления.СтатусыЧековККМ.Пробит;
	
	ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;
	
//	_знч = "";
//	ЕстьЗначение = деф.ФормаОплаты.свойство("Значение",_знч);
//	Если ЕстьЗначение Тогда
//		ОбъектДанных.ФормаОплаты = деф.ФормаОплаты.Значение;
//	Иначе
//		ОбъектДанных.ФормаОплаты = Неопределено;
//	КонецЕсли;

	ОбъектДанных.ЦенаВключаетНДС = деф.ЦенаВключаетНДС;




//	//------------------------------------------------------     ТЧ Товары


	ОбъектДанных.Товары.Очистить();

	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];

		СтрокаТЧ = ОбъектДанных.Товары.Добавить();


//		СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

		СтрокаТЧ.КлючСвязи = стрк.КлючСвязи;
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;

		СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);

//		гуид="";
//		ЕстьАтрибут = стрк.НоменклатураЕГАИС.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.НоменклатураЕГАИС = стрк.НоменклатураЕГАИС.Ref;
//		Иначе
//			СтрокаТЧ.НоменклатураЕГАИС = Неопределено;
//		КонецЕсли;

//		гуид="";
//		ЕстьАтрибут = стрк.НоменклатураНабора.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.НоменклатураНабора = стрк.НоменклатураНабора.Ref;
//		Иначе
//			СтрокаТЧ.НоменклатураНабора = Неопределено;
//		КонецЕсли;

//		гуид="";
//		ЕстьАтрибут = стрк.Помещение.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Помещение = стрк.Помещение.Ref;
//		Иначе
//			СтрокаТЧ.Помещение = Неопределено;
//		КонецЕсли;

//		гуид="";
//		ЕстьАтрибут = стрк.Продавец.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Продавец = стрк.Продавец.Ref;
//		Иначе
//			СтрокаТЧ.Продавец = Неопределено;
//		КонецЕсли;

		СтрокаТЧ.ПроцентАвтоматическойСкидки = стрк.ПроцентАвтоматическойСкидки;
		СтрокаТЧ.ПроцентРучнойСкидки = стрк.ПроцентРучнойСкидки;

//		гуид="";
//		ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Серия = стрк.Серия.Ref;
//		Иначе
//			СтрокаТЧ.Серия = Неопределено;
//		КонецЕсли;

//		гуид="";
//		ЕстьАтрибут = стрк.СтавкаНДС.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.СтавкаНДС = стрк.СтавкаНДС.Ref;
//		Иначе
//			СтрокаТЧ.СтавкаНДС = Неопределено;
//		КонецЕсли;
		СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.ОпределитьСтавкуНДСПоПеречислениюРозницы(стрк.СтавкаНДС);
		СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;
		СтрокаТЧ.Сумма = стрк.Сумма;
		СтрокаТЧ.СуммаАвтоматическойСкидки = стрк.СуммаАвтоматическойСкидки;

//		СтрокаТЧ.СуммаБонусныхБалловКСписанию = стрк.СуммаБонусныхБалловКСписанию;

//		СтрокаТЧ.СуммаБонусныхБалловКСписаниюВВалюте = стрк.СуммаБонусныхБалловКСписаниюВВалюте;

//		СтрокаТЧ.СуммаНачисленныхБонусныхБалловВВалюте = стрк.СуммаНачисленныхБонусныхБалловВВалюте;

		СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;
		СтрокаТЧ.СуммаРучнойСкидки = стрк.СуммаРучнойСкидки;

//		_знч = "";
//		ЕстьЗначение = стрк.УдалитьСтавкаНДС.свойство("Значение",_знч);
//		Если ЕстьЗначение Тогда
//			СтрокаТЧ.УдалитьСтавкаНДС = стрк.УдалитьСтавкаНДС.Значение;
//		Иначе
//			СтрокаТЧ.УдалитьСтавкаНДС = Неопределено;
//		КонецЕсли;

//		гуид="";
//		ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Упаковка = стрк.Упаковка.Ref;
//		Иначе
//			СтрокаТЧ.Упаковка = Неопределено;
//		КонецЕсли;

		СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиЕдиницуИзмерения(
			стрк.Упаковка, стрк.Номенклатура);

		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.Характеристика);

//		гуид="";
//		ЕстьАтрибут = стрк.ХарактеристикаНабора.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.ХарактеристикаНабора = стрк.ХарактеристикаНабора.Ref;
//		Иначе
//			СтрокаТЧ.ХарактеристикаНабора = Неопределено;
//		КонецЕсли;

		СтрокаТЧ.Цена = стрк.Цена;
		СтрокаТЧ.Штрихкод = стрк.Штрихкод;

	КонецЦикла;


	//------------------------------------------------------     ТЧ ОплатаПлатежнымиКартами


	Для сч = 0 По деф.ТЧОплата.Количество()-1 Цикл

		стрк = деф.ТЧОплата[сч];
		
		// В Рознице:
		//	спр.ВидыОплатЧекаККМ, рек. ТипОплаты, тип ПеречислениеСсылка.ТипыОплатЧекаККМ
		//	Значения:
		//Наличные
		//ПлатежнаяКарта
		//БанковскийКредит
		//ПодарочныйСертификат
		//Бонусы
		//ЗачетАванса
		//ВРассрочку
		//ПлатежнаяСистема
		//БанковскийПлатеж
		
		// в ЕРП
		// реквизит ВидОплаты, тип  ПеречислениеСсылка.ТипыПлатежнойСистемыККТ
		// Значения
		//	СистемаБыстрыхПлатежей
		//	SWiP
		//	СертификатНСПК
		//	ЮКасса
		//	ПлатежнаяКарта
		
		
		
		гуид = "";
		ЕстьЗначение = стрк.ВидОплаты.свойство("Ref", гуид);
		Если ЕстьЗначение Тогда
			ВидОплаты = РегистрыСведений.ксп_МэппингПеречислениеТипыПлатежнойСистемыККТ
				.ПоМэппингу( гуид, мВнешняяСистема );
		Иначе
			ВидОплаты = Неопределено;
		КонецЕсли;

		Если ВидОплаты <> перечисления.ТипыПлатежнойСистемыККТ.ПлатежнаяКарта Тогда
			Продолжить;
		КонецЕсли;     
		
		СтрокаТЧ = ОбъектДанных.ОплатаПлатежнымиКартами.Добавить(); 
		
		СтрокаТЧ.ВидОплаты = ВидОплаты;
		
		//		гуид="";
//		ЕстьАтрибут = стрк.ДоговорПодключения.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.ДоговорПодключения = стрк.ДоговорПодключения.Ref;
//		Иначе
//			СтрокаТЧ.ДоговорПодключения = Неопределено;
//		КонецЕсли;
//		СтрокаТЧ.ИдентификаторКорзины = стрк.ИдентификаторКорзины;

//		СтрокаТЧ.ИдентификаторПлатежнойСистемы = стрк.ИдентификаторПлатежнойСистемы;

//		СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

//		СтрокаТЧ.КодАвторизации = стрк.КодАвторизации;

		СтрокаТЧ.НомерПлатежнойКарты = стрк.НомерПлатежнойКарты;

		СтрокаТЧ.НомерЧекаЭТ = стрк.НомерЧекаЭТ;

		СтрокаТЧ.СсылочныйНомер = стрк.СсылочныйНомер;

//		_знч = "";
//		ЕстьЗначение = стрк.СтатусОплатыСБП.свойство("Значение",_знч);
//		Если ЕстьЗначение Тогда
//			СтрокаТЧ.СтатусОплатыСБП = стрк.СтатусОплатыСБП.Значение;
//		Иначе
			СтрокаТЧ.СтатусОплатыСБП = Неопределено;
//		КонецЕсли;

		СтрокаТЧ.Сумма = стрк.Сумма;

//		СтрокаТЧ.ТекстОшибки = стрк.ТекстОшибки;

		СтрокаТЧ.ЭквайринговыйТерминал = ксп_ИмпортСлужебный.
			НайтиЭквайринговыйТерминал(стрк.ЭквайринговыйТерминал, мВнешняяСистема);


	КонецЦикла;

//	//------------------------------------------------------     ТЧ СкидкиНаценки



//	НаборЗаписей_ТЧСкидкиНаценки = РегистрыСведений.ЧекККМ_ТЧ_СкидкиНаценки__.СоздатьНаборЗаписей();
//	НаборЗаписей_ТЧСкидкиНаценки.Отбор.ГУИД.установить(id.Ref);
//	НаборЗаписей_ТЧСкидкиНаценки.Отбор.ВнешняяСистема.установить(мВнешняяСистема);


//	счНомерСтроки = 0;

//	Для сч = 0 По деф.ТЧСкидкиНаценки.Количество()-1 Цикл

//		стрк = деф.ТЧСкидкиНаценки[сч];

//		СтрокаТЧ = НаборЗаписей_ТЧСкидкиНаценки.Добавить();
//	СтрокаТЧ.ГУИД = id.Ref;
//	СтрокаТЧ.ВнешняяСистема = мВнешняяСистема;
//		СтрокаТЧ.КлючСвязи = стрк.КлючСвязи;

//		СтрокаТЧ.НапомнитьПозже = стрк.НапомнитьПозже;

//		гуид="";
//		ЕстьАтрибут = стрк.СкидкаНаценка.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.СкидкаНаценка = стрк.СкидкаНаценка.Ref;
//		Иначе
//			СтрокаТЧ.СкидкаНаценка = Неопределено;
//		КонецЕсли;
//		СтрокаТЧ.Сумма = стрк.Сумма;

//		СтрокаТЧ._НомерСтроки = счНомерСтроки;

//		счНомерСтроки = счНомерСтроки + 1;

//	КонецЦикла;

//	НаборЗаписей_ТЧСкидкиНаценки.Записать();
//	//------------------------------------------------------     ТЧ Серии



//	НаборЗаписей_ТЧСерии = РегистрыСведений.ЧекККМ_ТЧ_Серии__.СоздатьНаборЗаписей();
//	НаборЗаписей_ТЧСерии.Отбор.ГУИД.установить(id.Ref);
//	НаборЗаписей_ТЧСерии.Отбор.ВнешняяСистема.установить(мВнешняяСистема);


//	счНомерСтроки = 0;

//	Для сч = 0 По деф.ТЧСерии.Количество()-1 Цикл

//		стрк = деф.ТЧСерии[сч];

//		СтрокаТЧ = НаборЗаписей_ТЧСерии.Добавить();
//	СтрокаТЧ.ГУИД = id.Ref;
//	СтрокаТЧ.ВнешняяСистема = мВнешняяСистема;
//		СтрокаТЧ.Количество = стрк.Количество;

//		гуид="";
//		ЕстьАтрибут = стрк.Номенклатура.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Номенклатура = стрк.Номенклатура.Ref;
//		Иначе
//			СтрокаТЧ.Номенклатура = Неопределено;
//		КонецЕсли;
//		гуид="";
//		ЕстьАтрибут = стрк.Помещение.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Помещение = стрк.Помещение.Ref;
//		Иначе
//			СтрокаТЧ.Помещение = Неопределено;
//		КонецЕсли;
//		гуид="";
//		ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Серия = стрк.Серия.Ref;
//		Иначе
//			СтрокаТЧ.Серия = Неопределено;
//		КонецЕсли;
//		гуид="";
//		ЕстьАтрибут = стрк.Характеристика.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Характеристика = стрк.Характеристика.Ref;
//		Иначе
//			СтрокаТЧ.Характеристика = Неопределено;
//		КонецЕсли;
//		СтрокаТЧ._НомерСтроки = счНомерСтроки;

//		счНомерСтроки = счНомерСтроки + 1;

//	КонецЦикла;

//	НаборЗаписей_ТЧСерии.Записать();
//	//------------------------------------------------------     ТЧ ПодарочныеСертификаты



//	НаборЗаписей_ТЧПодарочныеСертификаты = РегистрыСведений.ЧекККМ_ТЧ_ПодарочныеСертификаты__.СоздатьНаборЗаписей();
//	НаборЗаписей_ТЧПодарочныеСертификаты.Отбор.ГУИД.установить(id.Ref);
//	НаборЗаписей_ТЧПодарочныеСертификаты.Отбор.ВнешняяСистема.установить(мВнешняяСистема);


//	счНомерСтроки = 0;

//	Для сч = 0 По деф.ТЧПодарочныеСертификаты.Количество()-1 Цикл

//		стрк = деф.ТЧПодарочныеСертификаты[сч];

//		СтрокаТЧ = НаборЗаписей_ТЧПодарочныеСертификаты.Добавить();
//	СтрокаТЧ.ГУИД = id.Ref;
//	СтрокаТЧ.ВнешняяСистема = мВнешняяСистема;
//		СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

//		гуид="";
//		ЕстьАтрибут = стрк.ОбъектРасчетов.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.ОбъектРасчетов = стрк.ОбъектРасчетов.Ref;
//		Иначе
//			СтрокаТЧ.ОбъектРасчетов = Неопределено;
//		КонецЕсли;
//		гуид="";
//		ЕстьАтрибут = стрк.ПодарочныйСертификат.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.ПодарочныйСертификат = стрк.ПодарочныйСертификат.Ref;
//		Иначе
//			СтрокаТЧ.ПодарочныйСертификат = Неопределено;
//		КонецЕсли;
//		СтрокаТЧ.Сумма = стрк.Сумма;

//		СтрокаТЧ.СуммаВВалютеСертификата = стрк.СуммаВВалютеСертификата;

//		СтрокаТЧ.СуммаВзаиморасчетов = стрк.СуммаВзаиморасчетов;

//		СтрокаТЧ._НомерСтроки = счНомерСтроки;

//		счНомерСтроки = счНомерСтроки + 1;

//	КонецЦикла;

//	НаборЗаписей_ТЧПодарочныеСертификаты.Записать();
//	//------------------------------------------------------     ТЧ БонусныеБаллы



//	НаборЗаписей_ТЧБонусныеБаллы = РегистрыСведений.ЧекККМ_ТЧ_БонусныеБаллы__.СоздатьНаборЗаписей();
//	НаборЗаписей_ТЧБонусныеБаллы.Отбор.ГУИД.установить(id.Ref);
//	НаборЗаписей_ТЧБонусныеБаллы.Отбор.ВнешняяСистема.установить(мВнешняяСистема);


//	счНомерСтроки = 0;

//	Для сч = 0 По деф.ТЧБонусныеБаллы.Количество()-1 Цикл

//		стрк = деф.ТЧБонусныеБаллы[сч];

//		СтрокаТЧ = НаборЗаписей_ТЧБонусныеБаллы.Добавить();
//	СтрокаТЧ.ГУИД = id.Ref;
//	СтрокаТЧ.ВнешняяСистема = мВнешняяСистема;
//		гуид="";
//		ЕстьАтрибут = стрк.БонуснаяПрограммаЛояльности.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.БонуснаяПрограммаЛояльности = стрк.БонуснаяПрограммаЛояльности.Ref;
//		Иначе
//			СтрокаТЧ.БонуснаяПрограммаЛояльности = Неопределено;
//		КонецЕсли;
//		СтрокаТЧ.ДатаНачисления = стрк.ДатаНачисления;

//		СтрокаТЧ.ДатаСписания = стрк.ДатаСписания;

//		СтрокаТЧ.СуммаБонусныхБаллов = стрк.СуммаБонусныхБаллов;

//		СтрокаТЧ._НомерСтроки = счНомерСтроки;

//		счНомерСтроки = счНомерСтроки + 1;

//	КонецЦикла;

//	НаборЗаписей_ТЧБонусныеБаллы.Записать();
//	//------------------------------------------------------     ТЧ АкцизныеМарки



//	НаборЗаписей_ТЧАкцизныеМарки = РегистрыСведений.ЧекККМ_ТЧ_АкцизныеМарки__.СоздатьНаборЗаписей();
//	НаборЗаписей_ТЧАкцизныеМарки.Отбор.ГУИД.установить(id.Ref);
//	НаборЗаписей_ТЧАкцизныеМарки.Отбор.ВнешняяСистема.установить(мВнешняяСистема);


//	счНомерСтроки = 0;

//	Для сч = 0 По деф.ТЧАкцизныеМарки.Количество()-1 Цикл

//		стрк = деф.ТЧАкцизныеМарки[сч];

//		СтрокаТЧ = НаборЗаписей_ТЧАкцизныеМарки.Добавить();
//	СтрокаТЧ.ГУИД = id.Ref;
//	СтрокаТЧ.ВнешняяСистема = мВнешняяСистема;
//		гуид="";
//		ЕстьАтрибут = стрк.АкцизнаяМарка.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.АкцизнаяМарка = стрк.АкцизнаяМарка.Ref;
//		Иначе
//			СтрокаТЧ.АкцизнаяМарка = Неопределено;
//		КонецЕсли;
//		СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

//		СтрокаТЧ.КодАкцизнойМарки = стрк.КодАкцизнойМарки;

//		гуид="";
//		ЕстьАтрибут = стрк.Справка2.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Справка2 = стрк.Справка2.Ref;
//		Иначе
//			СтрокаТЧ.Справка2 = Неопределено;
//		КонецЕсли;
//		_знч = "";
//		ЕстьЗначение = стрк.ЧастичноеВыбытиеВариантУчета.свойство("Значение",_знч);
//		Если ЕстьЗначение Тогда
//			СтрокаТЧ.ЧастичноеВыбытиеВариантУчета = стрк.ЧастичноеВыбытиеВариантУчета.Значение;
//		Иначе
//			СтрокаТЧ.ЧастичноеВыбытиеВариантУчета = Неопределено;
//		КонецЕсли;
//		СтрокаТЧ.ЧастичноеВыбытиеКоличество = стрк.ЧастичноеВыбытиеКоличество;

//		гуид="";
//		ЕстьАтрибут = стрк.ЧастичноеВыбытиеНоменклатура.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.ЧастичноеВыбытиеНоменклатура = стрк.ЧастичноеВыбытиеНоменклатура.Ref;
//		Иначе
//			СтрокаТЧ.ЧастичноеВыбытиеНоменклатура = Неопределено;
//		КонецЕсли;
//		гуид="";
//		ЕстьАтрибут = стрк.ЧастичноеВыбытиеХарактеристика.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.ЧастичноеВыбытиеХарактеристика = стрк.ЧастичноеВыбытиеХарактеристика.Ref;
//		Иначе
//			СтрокаТЧ.ЧастичноеВыбытиеХарактеристика = Неопределено;
//		КонецЕсли;
//		гуид="";
//		ЕстьАтрибут = стрк.ШтрихкодУпаковки.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.ШтрихкодУпаковки = стрк.ШтрихкодУпаковки.Ref;
//		Иначе
//			СтрокаТЧ.ШтрихкодУпаковки = Неопределено;
//		КонецЕсли;
//		СтрокаТЧ._НомерСтроки = счНомерСтроки;

//		счНомерСтроки = счНомерСтроки + 1;

//	КонецЦикла;

//	НаборЗаписей_ТЧАкцизныеМарки.Записать();






	//------------------------------------------------------ ФИНАЛ

		
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	

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
 
 