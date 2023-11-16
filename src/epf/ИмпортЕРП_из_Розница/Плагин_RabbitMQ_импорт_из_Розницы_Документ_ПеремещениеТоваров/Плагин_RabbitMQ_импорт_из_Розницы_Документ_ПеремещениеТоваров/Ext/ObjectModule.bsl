﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПеремещениеТоваров",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Документ_ПеремещениеТоваров",
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
	
	Возврат ЗагрузитьОбъект_В_ЗаказНаПеремещение(СтруктураОбъекта, jsonText);
	
	
	
	
	
	
	Если НЕ НРег(СтруктураОбъекта.type) = "документ.перемещениетоваров" Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	СуществующийОбъект = Документы.ПеремещениеТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		
	Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = Документы.ПеремещениеТоваров.СоздатьДокумент();
		СсылкаНового = Документы.ПеремещениеТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	Иначе 
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
	КонецЕсли;
		
	ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;

	ОбъектДанных.СкладОтправитель = ксп_ИмпортСлужебный.НайтиСклад(деф.СкладОтправитель, мВнешняяСистема);
	ОбъектДанных.СкладПолучатель = ксп_ИмпортСлужебный.НайтиСклад(деф.СкладПолучатель, мВнешняяСистема);
	
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	ОбъектДанных.ОрганизацияПолучатель = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.ОрганизацияПолучатель, мВнешняяСистема);
	// под вопросом
	//Если не ЗначениеЗаполнено(ОбъектДанных.ОрганизацияПолучатель) Тогда
	//	ОбъектДанных.ОрганизацияПолучатель = ОбъектДанных.Организация;
	//КонецЕсли;
	
	//// вместо поиска в спр Пользователи
	//гуид="";
	//ЕстьАтрибут = деф.Ответственный.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Ответственный = Справочники.Пользователи.ПолучитьСсылку(деф.Ответственный.Ref);
	//Иначе
	//	ОбъектДанных.Ответственный = Неопределено;
	//КонецЕсли;
	//// будет это:
	ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию();
	
	
	
	// начало всех реквизитов ЕРП		
	
	
	//// нет источника
	//гуид="";
	//ЕстьАтрибут = деф.БанковскийСчетОрганизации.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.БанковскийСчетОрганизации = деф.БанковскийСчетОрганизации.Ref;
	//Иначе
	//	ОбъектДанных.БанковскийСчетОрганизации = Неопределено;
	//КонецЕсли;
	
	//_знч = "";
	//ЕстьЗначение = деф.ВариантПриемкиТоваров.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ВариантПриемкиТоваров = деф.ВариантПриемкиТоваров.Значение;
	//Иначе
	//	ОбъектДанных.ВариантПриемкиТоваров = Неопределено;
	//КонецЕсли;
	// todo Обсудить с Сергеем К.
	ОбъектДанных.ВариантПриемкиТоваров = Перечисления.ВариантыПриемкиТоваров.МожетПроисходитьБезЗаказовИНакладных;
	
	//гуид="";
	//ЕстьАтрибут = деф.ВидЦены.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ВидЦены = деф.ВидЦены.Ref;
	//Иначе
	//	ОбъектДанных.ВидЦены = Неопределено;
	//КонецЕсли;
	// todo Обсудить с Сергеем К.
	ОбъектДанных.ВидЦены = Справочники.ВидыЦен.ВидЦеныПоУмолчанию(,);
	
	// похоже на связь с ТЧ ВидыЗапасов
	ОбъектДанных.ВидыЗапасовУказаныВручную = Ложь;
	
	ОбъектДанных.ВремяДоставкиПо = "";
	ОбъектДанных.ВремяДоставкиС = "";
	
	//// нет источника
	//гуид="";
	//ЕстьАтрибут = деф.ГлавныйБухгалтер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ГлавныйБухгалтер = деф.ГлавныйБухгалтер.Ref;
	//Иначе
	//	ОбъектДанных.ГлавныйБухгалтер = Неопределено;
	//КонецЕсли;

	// todo Обсудить с Сергеем К.
	ОбъектДанных.ДатаПоступления = ОбъектДанных.Дата;

	//гуид="";
	//ЕстьАтрибут = деф.ДокументОснование.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ДокументОснование = деф.ДокументОснование.Ref;
	//Иначе
	//	ОбъектДанных.ДокументОснование = Неопределено;
	//КонецЕсли;
	// типы основания в Рознице:
	//ВозвратИзРегистра2ЕГАИС
	//ЗаказНаПеремещение
	//ИзменениеАссортимента
	//ОприходованиеТоваров
	//ПередачаТоваровМеждуОрганизациями
	//ПеремещениеТоваров
	//ПоступлениеТоваров
	
	// todo Обсудить с Сергеем К.
	ОбъектДанных.ДокументОснование = Неопределено;
	
	ОбъектДанных.ДополнительнаяИнформацияПоДоставке = "";
	
	гуид="";
	ЕстьАтрибут = деф.ДокументОснование.свойство("Ref",гуид);
	ОбъектДанных.ЗаказНаПеремещение = Неопределено;
	Если ЕстьАтрибут Тогда
		ТипОснования = "";
		деф.ДокументОснование.свойство("type",ТипОснования);
		Если НРег(ТипОснования) = "документ.заказнаперемещение" Тогда
			ЗаказНаПеремещение = Документы.ЗаказНаПеремещение.ПолучитьСсылку(
				Новый УникальныйИдентификатор(деф.ДокументОснование.Ref));
				
			ОбъектДанных.ЗаказНаПеремещение = ЗаказНаПеремещение;
		КонецЕсли;
	КонецЕсли;
	
	//гуид="";
	//ЕстьАтрибут = деф.ЗонаДоставки.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ЗонаДоставки = деф.ЗонаДоставки.Ref;
	//Иначе
	//	ОбъектДанных.ЗонаДоставки = Неопределено;
	//КонецЕсли;
	ОбъектДанных.ЗонаДоставки = Неопределено;
	
	
	ОбъектДанных.Исправление = Ложь;
	
	//гуид="";
	//ЕстьАтрибут = деф.ИсправляемыйДокумент.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ИсправляемыйДокумент = деф.ИсправляемыйДокумент.Ref;
	//Иначе
	//	ОбъектДанных.ИсправляемыйДокумент = Неопределено;
	//КонецЕсли;
	ОбъектДанных.ИсправляемыйДокумент = Неопределено;
	
	
	ОбъектДанных.Комментарий = деф.Комментарий;
	
	//гуид="";
	//ЕстьАтрибут = деф.НаправлениеДеятельности.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.НаправлениеДеятельности = деф.НаправлениеДеятельности.Ref;
	//Иначе
	//	ОбъектДанных.НаправлениеДеятельности = Неопределено;
	//КонецЕсли;
	
	// todo Обсудить с Сергеем К.
	ОбъектДанных.НаправлениеДеятельности = Неопределено;

	ОбъектДанных.ОсобыеУсловияПеревозки = Ложь;
	ОбъектДанных.ОсобыеУсловияПеревозкиОписание = Неопределено;
	
	//гуид="";
	//ЕстьАтрибут = деф.ПеревозчикПартнер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ПеревозчикПартнер = деф.ПеревозчикПартнер.Ref;
	//Иначе
	//	ОбъектДанных.ПеревозчикПартнер = Неопределено;
	//КонецЕсли;
	ОбъектДанных.ПеревозчикПартнер = Неопределено;
	
	//ЕНС. это документ ПеремещениеТоваров
	//гуид="";
	//ЕстьАтрибут = деф.ПеремещениеАктаОРасхождениях.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ПеремещениеАктаОРасхождениях = деф.ПеремещениеАктаОРасхождениях.Ref;
	//Иначе
	//	ОбъектДанных.ПеремещениеАктаОРасхождениях = Неопределено;
	//КонецЕсли;
	ОбъектДанных.ПеремещениеАктаОРасхождениях = Неопределено;
	
	//_знч = "";
	//ЕстьЗначение = деф.ПеремещениеПодДеятельность.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ПеремещениеПодДеятельность = деф.ПеремещениеПодДеятельность.Значение;
	//Иначе
	//	ОбъектДанных.ПеремещениеПодДеятельность = Неопределено;
	//КонецЕсли;
	
	// todo Обсудить с Сергеем К.
	ОбъектДанных.ПеремещениеПодДеятельность = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
	
	ОбъектДанных.ПеремещениеПоЗаказам = ложь;
	
	//гуид="";
	//ЕстьАтрибут = деф.Подразделение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Подразделение = деф.Подразделение.Ref;
	//Иначе
	//	ОбъектДанных.Подразделение = Неопределено;
	//КонецЕсли;
	ОбъектДанных.Подразделение = Неопределено;
	
	//гуид="";
	//ЕстьАтрибут = деф.Руководитель.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Руководитель = деф.Руководитель.Ref;
	//Иначе
	//	ОбъектДанных.Руководитель = Неопределено;
	//КонецЕсли;
	ОбъектДанных.Руководитель = Неопределено;
	
	//справочник СделкиСКлиентами
	//гуид="";
	//ЕстьАтрибут = деф.Сделка.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Сделка = деф.Сделка.Ref;
	//Иначе
	//	ОбъектДанных.Сделка = Неопределено;
	//КонецЕсли;
	ОбъектДанных.Сделка = Неопределено;

	//_знч = "";
	//ЕстьЗначение = деф.СостояниеЗаполненияМногооборотнойТары.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.СостояниеЗаполненияМногооборотнойТары = деф.СостояниеЗаполненияМногооборотнойТары.Значение;
	//Иначе
	//	ОбъектДанных.СостояниеЗаполненияМногооборотнойТары = Неопределено;
	//КонецЕсли;
	ОбъектДанных.СостояниеЗаполненияМногооборотнойТары = 
		Перечисления.СостоянияЗаполненияМногооборотнойТары.НеПредлагатьЗаполнить;
	
	//_знч = "";
	//ЕстьЗначение = деф.СпособДоставки.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.СпособДоставки = деф.СпособДоставки.Значение;
	//Иначе
	//	ОбъектДанных.СпособДоставки = Неопределено;
	//КонецЕсли;
	
	// todo Обсудить с Сергеем К.
	ОбъектДанных.СпособДоставки = Перечисления.СпособыДоставки.Самовывоз;
	
	//_знч = "";
	//ЕстьЗначение = деф.Статус.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.Статус = деф.Статус.Значение;
	//Иначе
	//	ОбъектДанных.Статус = Неопределено;
	//КонецЕсли;
	ОбъектДанных.Статус = Перечисления.СтатусыПеремещенийТоваров.Отгружено;
	
	//гуид="";
	//ЕстьАтрибут = деф.СторнируемыйДокумент.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.СторнируемыйДокумент = деф.СторнируемыйДокумент.Ref;
	//Иначе
	//	ОбъектДанных.СторнируемыйДокумент = Неопределено;
	//КонецЕсли;
	ОбъектДанных.СторнируемыйДокумент = Неопределено;
	
	ОбъектДанных.УдалитьДатаРаспоряжения = Неопределено;
	
	//_знч = "";
	//ЕстьЗначение = деф.ХозяйственнаяОперация.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ХозяйственнаяОперация = деф.ХозяйственнаяОперация.Значение;
	//Иначе
	//	ОбъектДанных.ХозяйственнаяОперация = Неопределено;
	//КонецЕсли;
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПеремещениеТоваров;
	
	
	// конец всех реквизитов ЕРП
	
	
	
	
	ОбъектДанных.Товары.Очистить();
	

	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];

		СтрокаТЧ = ОбъектДанных.Товары.Добавить();

		СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);
		
		//гуид="";
		//ЕстьАтрибут = стрк.АналитикаУчетаНаборов.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.АналитикаУчетаНаборов = стрк.АналитикаУчетаНаборов.Ref;
		//Иначе
		//	СтрокаТЧ.АналитикаУчетаНаборов = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.АналитикаУчетаНаборов = Неопределено;
		
		
		//гуид="";
		//ЕстьАтрибут = стрк.АналитикаУчетаНоменклатуры.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.АналитикаУчетаНоменклатуры = стрк.АналитикаУчетаНоменклатуры.Ref;
		//Иначе
		//	СтрокаТЧ.АналитикаУчетаНоменклатуры = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.АналитикаУчетаНоменклатуры = ксп_ИмпортСлужебный
			.НайтиСоздатьКлючАналитикиНом(СтрокаТЧ.Номенклатура, ОбъектДанных.СкладОтправитель);
		
		//гуид="";
		//ЕстьАтрибут = стрк.ЗаказНаПеремещение.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ЗаказНаПеремещение = стрк.ЗаказНаПеремещение.Ref;
		//Иначе
		//	СтрокаТЧ.ЗаказНаПеремещение = Неопределено;
		//КонецЕсли;
		
		СтрокаТЧ.ИдентификаторСтроки = строка(Новый УникальныйИдентификатор);

		СтрокаТЧ.КодСтроки = Неопределено;

		СтрокаТЧ.Количество = стрк.Количество;

		СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;

		//гуид="";
		//ЕстьАтрибут = стрк.Назначение.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Назначение = стрк.Назначение.Ref;
		//Иначе
		//	СтрокаТЧ.Назначение = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.Назначение = Неопределено;
		
		//гуид="";
		//ЕстьАтрибут = стрк.НазначениеОтправителя.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.НазначениеОтправителя = стрк.НазначениеОтправителя.Ref;
		//Иначе
		//	СтрокаТЧ.НазначениеОтправителя = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.НазначениеОтправителя = Неопределено;

		//гуид="";
		//ЕстьАтрибут = стрк.НоменклатураНабора.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.НоменклатураНабора = стрк.НоменклатураНабора.Ref;
		//Иначе
		//	СтрокаТЧ.НоменклатураНабора = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.НоменклатураНабора = Неопределено;
		
		//гуид="";
		//ЕстьАтрибут = стрк.Сделка.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Сделка = стрк.Сделка.Ref;
		//Иначе
		//	СтрокаТЧ.Сделка = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.Сделка = Неопределено;
		
		//гуид="";
		//ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Серия = стрк.Серия.Ref;
		//Иначе
		//	СтрокаТЧ.Серия = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.Серия = Неопределено;
		
		//todo доделать
		СтрокаТЧ.СтатусУказанияСерий = 0;
		СтрокаТЧ.СтатусУказанияСерийОтправитель = 0;
		СтрокаТЧ.СтатусУказанияСерийПолучатель = 0;

		//гуид="";
		//ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Упаковка = стрк.Упаковка.Ref;
		//Иначе
		//	СтрокаТЧ.Упаковка = Неопределено;
		//КонецЕсли;                           
		
		// todo Разобраться, как это работает. Почему не заполняется при интерактивном создании?
		СтрокаТЧ.Упаковка = Неопределено;
		
		//гуид="";
		//ЕстьАтрибут = стрк.Характеристика.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Характеристика = стрк.Характеристика.Ref;
		//Иначе
		//	СтрокаТЧ.Характеристика = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.Характеристика);
		
		//гуид="";
		//ЕстьАтрибут = стрк.ХарактеристикаНабора.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ХарактеристикаНабора = стрк.ХарактеристикаНабора.Ref;
		//Иначе
		//	СтрокаТЧ.ХарактеристикаНабора = Неопределено;
		//КонецЕсли;
		СтрокаТЧ.ХарактеристикаНабора = Неопределено;
		
		
		//// ------------------ ТЧ ВИДЫ ЗАПАСОВ
		//
		//СтрокаВЗ = ОбъектДанных.ВидыЗапасов.Добавить();

		//СтрокаВЗ.АналитикаУчетаНоменклатуры = СтрокаТЧ.АналитикаУчетаНоменклатуры;
		////СтрокаВЗ.ВидЗапасов = Справочники.ВидыЗапасов.
		//
		//гуид="";
		//ЕстьАтрибут = стрк.ВидЗапасов.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаВЗ.ВидЗапасов = стрк.ВидЗапасов.Ref;
		//Иначе
		//	СтрокаВЗ.ВидЗапасов = Неопределено;
		//КонецЕсли;
		//гуид="";
		//ЕстьАтрибут = стрк.ВидЗапасовПолучателя.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаВЗ.ВидЗапасовПолучателя = стрк.ВидЗапасовПолучателя.Ref;
		//Иначе
		//	СтрокаВЗ.ВидЗапасовПолучателя = Неопределено;
		//КонецЕсли;
		//СтрокаВЗ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

		//СтрокаВЗ.Количество = стрк.Количество;

		//СтрокаВЗ.КоличествоПоРНПТ = стрк.КоличествоПоРНПТ;

		//гуид="";
		//ЕстьАтрибут = стрк.Назначение.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаВЗ.Назначение = стрк.Назначение.Ref;
		//Иначе
		//	СтрокаВЗ.Назначение = Неопределено;
		//КонецЕсли;
		//гуид="";
		//ЕстьАтрибут = стрк.НомерГТД.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаВЗ.НомерГТД = стрк.НомерГТД.Ref;
		//Иначе
		//	СтрокаВЗ.НомерГТД = Неопределено;
		//КонецЕсли;
		//гуид="";
		//ЕстьАтрибут = стрк.Сделка.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаВЗ.Сделка = стрк.Сделка.Ref;
		//Иначе
		//	СтрокаВЗ.Сделка = Неопределено;
		//КонецЕсли;
		//гуид="";
		//ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаВЗ.Серия = стрк.Серия.Ref;
		//Иначе
		//	СтрокаВЗ.Серия = Неопределено;
		//КонецЕсли;
		
		
	КонецЦикла;
	
	
	ОбъектДанных.ВидыЗапасов.Очистить();
	ОбъектДанных.Серии.Очистить();
	ОбъектДанных.ДополнительныеРеквизиты.Очистить();

	
	
	
	
	
	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();
	
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);

	

	Возврат ОбъектДанных.Ссылка;
	
КонецФункции



// ///////////   ИМПОРТ  В ЗаказНаПеремещение ////////////


Функция ЗагрузитьОбъект_В_ЗаказНаПеремещение(СтруктураОбъекта, jsonText = "") Экспорт
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.перемещениетоваров") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Документы.ЗаказНаПеремещение.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		ОбъектДанных = Документы.ЗаказНаПеремещение.СоздатьДокумент();
		СсылкаНового = Документы.ЗаказНаПеремещение.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Номер = id.Number;
	ОбъектДанных.Дата = id.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	//гуид="";
	//ЕстьАтрибут = деф.Автор.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Автор = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Автор.Ref ) );
	//Иначе
	//	ОбъектДанных.Автор = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Автор = ксп_ИмпортСлужебный.НайтиАвтор(деф.Автор);

	//_знч = "";
	//ЕстьЗначение = деф.ВариантПриемкиТоваров.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ВариантПриемкиТоваров = деф.ВариантПриемкиТоваров.Значение;
	//Иначе
	//	ОбъектДанных.ВариантПриемкиТоваров = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ВариантПриемкиТоваров = ксп_ИмпортСлужебный.НайтиПеречисление_ВариантПриемкиТоваров(деф.ВариантПриемкиТоваров);
	ОбъектДанных.ВариантПриемкиТоваров = Перечисления.ВариантыПриемкиТоваров.РазделенаПоЗаказамИНакладным;
	
	//------- 					ДокументОснование
	// типы ЕРП
//ВнутреннееПотребление
//ДвижениеПродукцииИМатериалов
//ЗаказКлиента
//ЗаказМатериаловВПроизводство
//ЗаказНаВнутреннееПотребление
//ЗаказНаСборку
//ЗаявкаНаВозвратТоваровОтКлиента
//ПередачаМатериаловВПроизводство
//ПоступлениеТоваровНаСклад
//ПриемкаТоваровНаХранение
//ПриобретениеТоваровУслуг    

	// типы Розницы
//ВозвратИзРегистра2ЕГАИС
//ЗаказНаПеремещение
//ИзменениеАссортимента
//ОприходованиеТоваров
//ПередачаТоваровМеждуОрганизациями
//ПеремещениеТоваров
//ПоступлениеТоваров	

	//гуид="";
	//ЕстьАтрибут = деф.ДокументОснование.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ДокументОснование = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ДокументОснование.Ref ) );
	//Иначе
	//	ОбъектДанных.ДокументОснование = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ДокументОснование = ксп_ИмпортСлужебный.НайтиДокументОснование(деф.ДокументОснование);

	//ОбъектДанных.ЖелаемаяДатаПоступления = деф.ЖелаемаяДатаПоступления;

	ОбъектДанных.Комментарий = деф.Комментарий;

	//гуид="";
	//ЕстьАтрибут = деф.Назначение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Назначение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Назначение.Ref ) );
	//Иначе
	//	ОбъектДанных.Назначение = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Назначение = ксп_ИмпортСлужебный.НайтиНазначение(деф.Назначение);

	//гуид="";
	//ЕстьАтрибут = деф.НаправлениеДеятельности.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.НаправлениеДеятельности = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.НаправлениеДеятельности.Ref ) );
	//Иначе
	//	ОбъектДанных.НаправлениеДеятельности = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.НаправлениеДеятельности = ксп_ИмпортСлужебный.НайтиНаправлениеДеятельности(деф.НаправлениеДеятельности);

	//ОбъектДанных.ОбосабливатьПоНазначениюЗаказа = деф.ОбосабливатьПоНазначениюЗаказа;

	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);

	гуид="";
	ЕстьАтрибут = деф.ОрганизацияПолучатель.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.ОрганизацияПолучатель = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.ОрганизацияПолучатель, мВнешняяСистема);
	Иначе
		ОбъектДанных.ОрганизацияПолучатель = Неопределено;
	КонецЕсли;

	//ОбъектДанных.ОсобыеУсловияПеревозки = деф.ОсобыеУсловияПеревозки;

	//ОбъектДанных.ОсобыеУсловияПеревозкиОписание = деф.ОсобыеУсловияПеревозкиОписание;

	//гуид="";
	//ЕстьАтрибут = деф.Ответственный.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Ответственный = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Ответственный.Ref ) );
	ОбъектДанных.Ответственный = Пользователи.ТекущийПользователь();
	//Иначе
	//	ОбъектДанных.Ответственный = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.НайтиОтветственный(деф.Ответственный);

	//гуид="";
	//ЕстьАтрибут = деф.ПеревозчикПартнер.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ПеревозчикПартнер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ПеревозчикПартнер.Ref ) );
	//Иначе
	//	ОбъектДанных.ПеревозчикПартнер = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ПеревозчикПартнер = ксп_ИмпортСлужебный.НайтиПеревозчикПартнер(деф.ПеревозчикПартнер);

	//_знч = "";
	//ЕстьЗначение = деф.ПеремещениеПодДеятельность.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ПеремещениеПодДеятельность = деф.ПеремещениеПодДеятельность.Значение;
	//Иначе
	//	ОбъектДанных.ПеремещениеПодДеятельность = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ПеремещениеПодДеятельность = ксп_ИмпортСлужебный.НайтиПеречисление_ПеремещениеПодДеятельность(деф.ПеремещениеПодДеятельность);

	//гуид="";
	//ЕстьАтрибут = деф.Подразделение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Подразделение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Подразделение.Ref ) );
	//Иначе
	//	ОбъектДанных.Подразделение = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Подразделение = ксп_ИмпортСлужебный.НайтиПодразделение(деф.Подразделение);

	ОбъектДанных.Приоритет = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций
		.Настройка("ПриоритетЗаказаНаПеремещение_ИмпортПеремещенияИзРозница", мВнешняяСистема);

	//гуид="";
	//ЕстьАтрибут = деф.Сделка.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Сделка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Сделка.Ref ) );
	//Иначе
	//	ОбъектДанных.Сделка = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Сделка = ксп_ИмпортСлужебный.НайтиСделка(деф.Сделка);

	ОбъектДанных.СкладОтправитель = ксп_ИмпортСлужебный.НайтиСклад(деф.СкладОтправитель, мВнешняяСистема);
	ОбъектДанных.СкладПолучатель = ксп_ИмпортСлужебный.НайтиСклад(деф.СкладПолучатель, мВнешняяСистема);

	//_знч = "";
	//ЕстьЗначение = деф.СостояниеЗаполненияМногооборотнойТары.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.СостояниеЗаполненияМногооборотнойТары = деф.СостояниеЗаполненияМногооборотнойТары.Значение;
	//Иначе
	//	ОбъектДанных.СостояниеЗаполненияМногооборотнойТары = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СостояниеЗаполненияМногооборотнойТары = ксп_ИмпортСлужебный.НайтиПеречисление_СостояниеЗаполненияМногооборотнойТары(деф.СостояниеЗаполненияМногооборотнойТары);

	//_знч = "";
	//ЕстьЗначение = деф.СпособДоставки.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.СпособДоставки = деф.СпособДоставки.Значение;
	//Иначе
	//	ОбъектДанных.СпособДоставки = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СпособДоставки = ксп_ИмпортСлужебный.НайтиПеречисление_СпособДоставки(деф.СпособДоставки);

	ОбъектДанных.Статус = Перечисления.СтатусыВнутреннихЗаказов.КВыполнению;

	ОбъектДанных.ХозяйственнаяОперация = перечисления.ХозяйственныеОперации.ПеремещениеТоваров;




	//------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();


		СтрокаТЧ.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Отгрузить;
		
		//_знч = "";
		//ЕстьЗначение = стрк.ВариантОбеспеченияДоИзмененияОбновлениемИБ.свойство("Значение",_знч);
		//Если ЕстьЗначение Тогда
		//	СтрокаТЧ.ВариантОбеспеченияДоИзмененияОбновлениемИБ = стрк.ВариантОбеспеченияДоИзмененияОбновлениемИБ.Значение;
		//Иначе
		//	СтрокаТЧ.ВариантОбеспеченияДоИзмененияОбновлениемИБ = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.ВариантОбеспеченияДоИзмененияОбновлениемИБ = ксп_ИмпортСлужебный.НайтиПеречисление_ВариантОбеспеченияДоИзмененияОбновлениемИБ(стрк.ВариантОбеспеченияДоИзмененияОбновлениемИБ);

		//СтрокаТЧ.КодСтроки = стрк.КодСтроки;

		СтрокаТЧ.Количество = стрк.Количество;

		СтрокаТЧ.КоличествоУпаковок = стрк.КоличествоУпаковок;

		//гуид="";
		//ЕстьАтрибут = стрк.Назначение.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Назначение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Назначение.Ref ) );
		//Иначе
		//	СтрокаТЧ.Назначение = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.Назначение = ксп_ИмпортСлужебный.НайтиНазначение(стрк.Назначение);
		
		// без включенного флага "ИспользоватьДлительностьПеремещения" это будет колонка с заголовком "Дата отгрузки"
		СтрокаТЧ.НачалоОтгрузки = ОбъектДанных.Дата;

		СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);

		//гуид="";
		//ЕстьАтрибут = стрк.НоменклатураНабора.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.НоменклатураНабора = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НоменклатураНабора.Ref ) );
		//Иначе
		//	СтрокаТЧ.НоменклатураНабора = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.НоменклатураНабора = ксп_ИмпортСлужебный.НайтиНоменклатураНабора(стрк.НоменклатураНабора);

		//СтрокаТЧ.Обособленно = стрк.Обособленно;

		//СтрокаТЧ.ОкончаниеПоступления = стрк.ОкончаниеПоступления;

		//СтрокаТЧ.Отменено = стрк.Отменено;

		//гуид="";
		//ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Серия = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Серия.Ref ) );
		//Иначе
		//	СтрокаТЧ.Серия = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.Серия = ксп_ИмпортСлужебный.НайтиСерия(стрк.Серия);

		СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;

		СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиЕдиницуИзмерения(стрк.Упаковка, стрк.Номенклатура);

		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.Характеристика);

		//гуид="";
		//ЕстьАтрибут = стрк.ХарактеристикаНабора.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ХарактеристикаНабора = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ХарактеристикаНабора.Ref ) );
		//Иначе
		//	СтрокаТЧ.ХарактеристикаНабора = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.ХарактеристикаНабора = ксп_ИмпортСлужебный.НайтиХарактеристикаНабора(стрк.ХарактеристикаНабора);

	КонецЦикла;

	//------------------------------------------------------     ТЧ ДополнительныеРеквизиты



	//ОбъектДанных.ДополнительныеРеквизиты.Очистить();


	//Для счТовары = 0 По деф.ТЧДополнительныеРеквизиты.Количество()-1 Цикл
	//	стрк = деф.ТЧДополнительныеРеквизиты[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ДополнительныеРеквизиты.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.Значение.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Значение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Значение.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Значение = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Значение = ксп_ИмпортСлужебный.НайтиЗначение(стрк.Значение);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Свойство.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Свойство = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Свойство.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Свойство = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Свойство = ксп_ИмпортСлужебный.НайтиСвойство(стрк.Свойство);

	//	СтрокаТЧ.ТекстоваяСтрока = стрк.ТекстоваяСтрока;

	//КонецЦикла;




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
		Если ТипЗнч(Значение) = Тип("Строка") Тогда
			Возврат XMLЗначение(Тип("Число"),Значение);
		Иначе 
			Возврат Значение;
		КонецЕсли;
	КонецЕсли;
	Если Свойство = "Валюта" Тогда
		Возврат Справочники.Валюты.НайтиПоКоду(Значение);
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
Функция ПроверитьКачествоДанных(ДокументОбъект)
	
	// проверить шапку
	
	Для каждого рек Из МассивРеквизитовШапкиДляПроверки() Цикл
		
		Если НЕ ЗначениеЗаполнено(ДокументОбъект[рек]) Тогда
			
			ксп_ИмпортСлужебный.ДобавитьПроблемуОтложенногоПроведения(
				ДокументОбъект.Ссылка, рек, Неопределено, 0, 
				Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения);
				
		ИначеЕсли ЗначениеЗаполнено(ДокументОбъект[рек]) 
			И НЕ ЗначениеЗаполнено(ДокументОбъект[рек].ВерсияДанных) Тогда

			ксп_ИмпортСлужебный.ДобавитьПроблемуОтложенногоПроведения(
				ДокументОбъект.Ссылка, рек, Неопределено, 0, 
				Перечисления.ксп_ВидыПроблемКачестваДокументов.БитаяСсылка);
		КонецЕсли;
		
	КонецЦикла;
	
	// проверить все Табл Части
	
		
	Возврат Неопределено;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция МассивРеквизитовШапкиДляПроверки()
	
	мРеквизиты = Новый Массив;
	мРеквизиты.Добавить("СкладОтправитель");
	мРеквизиты.Добавить("СкладПолучатель");
	мРеквизиты.Добавить("Организация");
	//мРеквизиты.Добавить("ОрганизацияПолучатель");
	мРеквизиты.Добавить("Ответственный");
	Возврат мРеквизиты;
	
КонецФункции





мВнешняяСистема = "retail";

