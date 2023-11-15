﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Документ_ВозвратТоваровОтКлиента");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Документ_ВозвратТоваровОтКлиента");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Документ_ВозвратТоваровОтКлиента",
		"Форма_Плагин_RabbitMQ_экспорт_Документ_ВозвратТоваровОтКлиента",
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
//	Номенклатура	- СправочникСсылка.Номенклатура / СправочникОбъект.Номенклатура - при чтении узла обмена сюда будут приходить именно объекты
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ВыгрузитьОбъект(Ссылка) Экспорт
	
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.ВозвратТоваровОтКлиента") Тогда
		Обк = Ссылка.ПолучитьОбъект(); 
	Иначе 
		Обк = Ссылка; 
	КонецЕсли;

	
	
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, Символы.Таб);
	ЗаписьJson = Новый ЗаписьJSON;
	ЗаписьJson.УстановитьСтроку(ПараметрыЗаписиJSON);
	
	// Это основной объект json-сообщения
	СтруктураОбъекта = Новый Структура;
	
	СтруктураОбъекта.Вставить("source", "ERP");
	СтруктураОбъекта.Вставить("type", Обк.метаданные().ПолноеИмя());
	СтруктураОбъекта.Вставить("datetime", XMLСтрока(ТекущаяДатаСеанса()));
	
	identification = ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Ссылка);
	СтруктураОбъекта.Вставить("identification", identification);
	
	//	DEFINITION
	
	definition = ксп_ЭкспортСлужебный.СоздатьУзелDefinition(Обк.Ссылка);
	
	//Таблица:	Шапка	
	
	
	definition.Вставить("Автор", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Автор));
	definition.Вставить("Валюта", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Валюта));
	definition.Вставить("ВариантПриемкиТоваров", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВариантПриемкиТоваров));
	definition.Вставить("ВидДокументаПокупателя", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВидДокументаПокупателя));
	definition.Вставить("ВидыЗапасовУказаныВручную", Обк.ВидыЗапасовУказаныВручную);
	definition.Вставить("ВозвратПереданнойМногооборотнойТары", Обк.ВозвратПереданнойМногооборотнойТары);
	definition.Вставить("ВозвратПорчи", Обк.ВозвратПорчи);
	definition.Вставить("ВыданыДенежныеСредства", Обк.ВыданыДенежныеСредства);
	definition.Вставить("ГруппаФинансовогоУчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ГруппаФинансовогоУчета));
	definition.Вставить("ДатаВходящегоДокумента", XMLСтрока(Обк.ДатаВходящегоДокумента));
	definition.Вставить("ДатаВыдачиДокументаПокупателя", XMLСтрока(Обк.ДатаВыдачиДокументаПокупателя));
	definition.Вставить("ДатаПоступления", XMLСтрока(Обк.ДатаПоступления));
	definition.Вставить("ДатаРасходногоКассовогоОрдера", XMLСтрока(Обк.ДатаРасходногоКассовогоОрдера));
	definition.Вставить("ДатаРожденияПокупателя", XMLСтрока(Обк.ДатаРожденияПокупателя));
	definition.Вставить("ДовозвратПоВозврату", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДовозвратПоВозврату));
	definition.Вставить("Договор", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Договор));
	definition.Вставить("ДокументРеализации", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДокументРеализации));
	definition.Вставить("ЕстьМаркируемаяПродукцияГИСМ", Обк.ЕстьМаркируемаяПродукцияГИСМ);
	definition.Вставить("ЗаявкаНаВозвратТоваровОтКлиента", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ЗаявкаНаВозвратТоваровОтКлиента));
	definition.Вставить("КемВыданДокументПокупателя", Обк.КемВыданДокументПокупателя);
	definition.Вставить("КлиентДоговор", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КлиентДоговор));
	definition.Вставить("КлиентКонтрагент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КлиентКонтрагент));
	definition.Вставить("КлиентПартнер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КлиентПартнер));
	definition.Вставить("КодПодразделенияДокументаПокупателя", Обк.КодПодразделенияДокументаПокупателя);
	definition.Вставить("Комментарий", Обк.Комментарий);
	definition.Вставить("КонтактноеЛицо", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КонтактноеЛицо));
	definition.Вставить("Контрагент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Контрагент));
	definition.Вставить("Менеджер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Менеджер));
	definition.Вставить("НаименованиеВходящегоДокумента", Обк.НаименованиеВходящегоДокумента);
	definition.Вставить("НалогообложениеНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.НалогообложениеНДС));
	definition.Вставить("НаправлениеДеятельности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.НаправлениеДеятельности));
	definition.Вставить("НомерВходящегоДокумента", Обк.НомерВходящегоДокумента);
	definition.Вставить("НомерДокументаПокупателя", Обк.НомерДокументаПокупателя);
	definition.Вставить("НомерРасходногоКассовогоОрдера", Обк.НомерРасходногоКассовогоОрдера);
	definition.Вставить("ОбъектРасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ОбъектРасчетов));
	definition.Вставить("ОплатаВВалюте", Обк.ОплатаВВалюте);
	definition.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Организация));
	definition.Вставить("Партнер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Партнер));
	definition.Вставить("Подразделение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Подразделение));
	definition.Вставить("Покупатель", Обк.Покупатель);
	definition.Вставить("ПокупательНеПлательщикНДС", Обк.ПокупательНеПлательщикНДС);
	definition.Вставить("ПорядокРасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ПорядокРасчетов));
	definition.Вставить("ПредусмотренЗалогЗаТару", Обк.ПредусмотренЗалогЗаТару);
	definition.Вставить("ПричинаВозврата", Обк.ПричинаВозврата);
	definition.Вставить("Сделка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Сделка));
	definition.Вставить("СерияДокументаПокупателя", Обк.СерияДокументаПокупателя);
	definition.Вставить("Склад", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Склад));
	definition.Вставить("Соглашение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Соглашение));
	definition.Вставить("СостояниеЗаполненияМногооборотнойТары", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СостояниеЗаполненияМногооборотнойТары));
	definition.Вставить("СпособКомпенсации", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СпособКомпенсации));
	definition.Вставить("СрокДействияДокументаПокупателя", Обк.СрокДействияДокументаПокупателя);
	definition.Вставить("СуммаДокумента", Обк.СуммаДокумента);
	definition.Вставить("УдалитьПорядокОплаты", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьПорядокОплаты));
	definition.Вставить("УдалитьРуководитель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьРуководитель));
	definition.Вставить("ХозяйственнаяОперация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ХозяйственнаяОперация));
	definition.Вставить("ЦенаВключаетНДС", Обк.ЦенаВключаетНДС);
	definition.Вставить("ЧекККМ", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ЧекККМ));


	// Таблица: ТОВАРЫ
	
	ТЧТовары = Новый Массив;     
	
	Для сч = 0 По обк.товары.Количество()-1 Цикл
		
		стрк = обк.товары[сч];
		
		НовСтр = Новый Структура;   
		
		НовСтр.Вставить("АналитикаУчетаНаборов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаУчетаНаборов));
		НовСтр.Вставить("АналитикаУчетаНоменклатуры", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаУчетаНоменклатуры));
		НовСтр.Вставить("ВидЦеныСебестоимости", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВидЦеныСебестоимости));
		НовСтр.Вставить("ДатаЗаполненияСебестоимостиПоВидуЦены", стрк.ДатаЗаполненияСебестоимостиПоВидуЦены);
		НовСтр.Вставить("ДокументРеализации", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДокументРеализации));
		НовСтр.Вставить("ИдентификаторСтроки", стрк.ИдентификаторСтроки);
		НовСтр.Вставить("КодСтроки", стрк.КодСтроки);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("КоличествоПоРНПТ", стрк.КоличествоПоРНПТ);
		НовСтр.Вставить("КоличествоУпаковок", стрк.КоличествоУпаковок);
		НовСтр.Вставить("Назначение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Назначение));
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("НоменклатураНабора", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НоменклатураНабора));
		НовСтр.Вставить("НоменклатураОприходование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НоменклатураОприходование));
		НовСтр.Вставить("НомерГТД", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НомерГТД));
		НовСтр.Вставить("Порча", стрк.Порча);
		НовСтр.Вставить("Себестоимость", стрк.Себестоимость);
		НовСтр.Вставить("СебестоимостьБезНДС", стрк.СебестоимостьБезНДС);
		НовСтр.Вставить("СебестоимостьВР", стрк.СебестоимостьВР);
		НовСтр.Вставить("СебестоимостьПР", стрк.СебестоимостьПР);
		НовСтр.Вставить("СебестоимостьРегл", стрк.СебестоимостьРегл);
		НовСтр.Вставить("Серия", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Серия));
		НовСтр.Вставить("СпособОпределенияСебестоимости", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СпособОпределенияСебестоимости));
		НовСтр.Вставить("СтавкаНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтавкаНДС));
		НовСтр.Вставить("СтатусУказанияСерий", стрк.СтатусУказанияСерий);
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("СуммаНДС", стрк.СуммаНДС);
		НовСтр.Вставить("СуммаСНДС", стрк.СуммаСНДС);
		НовСтр.Вставить("УдалитьСтавкаНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.УдалитьСтавкаНДС));
		НовСтр.Вставить("Упаковка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Упаковка));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		НовСтр.Вставить("ХарактеристикаНабора", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ХарактеристикаНабора));
		НовСтр.Вставить("ХарактеристикаОприходование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ХарактеристикаОприходование));
		НовСтр.Вставить("Цена", стрк.Цена);
		НовСтр.Вставить("Штрихкод", стрк.Штрихкод);

		ТЧТовары.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧТовары", ТЧТовары);

	
	//Таблица:	ВидыЗапасов	
	
	ТЧВидыЗапасов = Новый Массив;
	
	Для сч = 0 По обк.видыЗапасов.Количество()-1 Цикл
		
		стрк = обк.видыЗапасов[сч];
		
		НовСтр = Новый Структура;   
				
		НовСтр.Вставить("АналитикаУчетаНаборов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаУчетаНаборов));
		НовСтр.Вставить("АналитикаУчетаНоменклатуры", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаУчетаНоменклатуры));
		НовСтр.Вставить("АналитикаУчетаНоменклатурыОтгрузки", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АналитикаУчетаНоменклатурыОтгрузки));
		НовСтр.Вставить("ВидЗапасов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВидЗапасов));
		НовСтр.Вставить("ВидЗапасовОтгрузки", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВидЗапасовОтгрузки));
		НовСтр.Вставить("ДокументРеализации", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДокументРеализации));
		НовСтр.Вставить("ИдентификаторСтроки", стрк.ИдентификаторСтроки);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("КоличествоПоРНПТ", стрк.КоличествоПоРНПТ);
		НовСтр.Вставить("КоличествоУпаковок", стрк.КоличествоУпаковок);
		НовСтр.Вставить("НоменклатураОприходование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НоменклатураОприходование));
		НовСтр.Вставить("НомерГТД", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НомерГТД));
		НовСтр.Вставить("Себестоимость", стрк.Себестоимость);
		НовСтр.Вставить("СебестоимостьБезНДС", стрк.СебестоимостьБезНДС);
		НовСтр.Вставить("СебестоимостьВР", стрк.СебестоимостьВР);
		НовСтр.Вставить("СебестоимостьПР", стрк.СебестоимостьПР);
		НовСтр.Вставить("СебестоимостьРегл", стрк.СебестоимостьРегл);
		НовСтр.Вставить("Серия", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Серия));
		НовСтр.Вставить("СпособОпределенияСебестоимости", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СпособОпределенияСебестоимости));
		НовСтр.Вставить("СтавкаНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтавкаНДС));
		НовСтр.Вставить("СуммаНДС", стрк.СуммаНДС);
		НовСтр.Вставить("СуммаСНДС", стрк.СуммаСНДС);
		НовСтр.Вставить("УдалитьСтавкаНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.УдалитьСтавкаНДС));
		НовСтр.Вставить("Упаковка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Упаковка));
		НовСтр.Вставить("ХарактеристикаОприходование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ХарактеристикаОприходование));
				
		ТЧВидыЗапасов.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧВидыЗапасов", ТЧВидыЗапасов);

	
	
	//Таблица:	ДополнительныеРеквизиты	
	//		
	

	ТЧДополнительныеРеквизиты = Новый Массив;
	
    Для сч = 0 По обк.ДополнительныеРеквизиты.Количество()-1 Цикл
		
		стрк = обк.ДополнительныеРеквизиты[сч];
		
		СтрокаТовары = Новый Структура;

		СтрокаТовары.Вставить("Значение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Значение)); 	
		СтрокаТовары.Вставить("Свойство", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Свойство)); 	
		СтрокаТовары.Вставить("ТекстоваяСтрока", стрк.ТекстоваяСтрока); 	

		ТЧДополнительныеРеквизиты.Добавить(СтрокаТовары);
	КонецЦикла;
	
	definition.Вставить("ТЧДополнительныеРеквизиты", ТЧДополнительныеРеквизиты);


	//Таблица:	РасшифровкаПлатежа	
	
	ТЧРасшифровкаПлатежа = Новый Массив;
	
	Для сч = 0 По обк.РасшифровкаПлатежа.Количество()-1 Цикл
		
		стрк = обк.РасшифровкаПлатежа[сч];
		
		НовСтр = Новый Структура;   
				
		НовСтр.Вставить("ВалютаВзаиморасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВалютаВзаиморасчетов));
		НовСтр.Вставить("ОбъектРасчетов", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ОбъектРасчетов));
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("СуммаВзаиморасчетов", стрк.СуммаВзаиморасчетов);
		НовСтр.Вставить("УдалитьЗаказ", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.УдалитьЗаказ));
		
		ТЧРасшифровкаПлатежа.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧРасшифровкаПлатежа", ТЧРасшифровкаПлатежа);
	

	
	//Таблица:	Серии	
	
	ТЧСерии = Новый Массив;
	
	Для сч = 0 По обк.Серии.Количество()-1 Цикл
		
		стрк = обк.Серии[сч];
		
		НовСтр = Новый Структура;   
				
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("Назначение", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Назначение));
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("НоменклатураОприходование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НоменклатураОприходование));
		НовСтр.Вставить("Серия", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Серия));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		НовСтр.Вставить("ХарактеристикаОприходование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ХарактеристикаОприходование));
				
		ТЧСерии.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧСерии", ТЧСерии);
	
	
	
	//Таблица:	ШтрихкодыУпаковок
	
	ТЧШтрихкодыУпаковок = Новый Массив;
	
	Для сч = 0 По обк.ШтрихкодыУпаковок.Количество()-1 Цикл
		
		стрк = обк.ШтрихкодыУпаковок[сч];
		
		НовСтр = Новый Структура;   
				
		НовСтр.Вставить("ЗначениеШтрихкода", стрк.ЗначениеШтрихкода);
		НовСтр.Вставить("ЧастичноеВыбытиеВариантУчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЧастичноеВыбытиеВариантУчета));
		НовСтр.Вставить("ЧастичноеВыбытиеКоличество", стрк.ЧастичноеВыбытиеКоличество);
		НовСтр.Вставить("ЧастичноеВыбытиеНоменклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЧастичноеВыбытиеНоменклатура));
		НовСтр.Вставить("ЧастичноеВыбытиеХарактеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЧастичноеВыбытиеХарактеристика));
		НовСтр.Вставить("ШтрихкодУпаковки", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ШтрихкодУпаковки));

		ТЧШтрихкодыУпаковок.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧШтрихкодыУпаковок", ТЧШтрихкодыУпаковок);

	
	
	//Таблица:	НачислениеБонусныхБаллов
	
	ТЧНачислениеБонусныхБаллов = Новый Массив;
	
	Для сч = 0 По обк.НачислениеБонусныхБаллов.Количество()-1 Цикл
		
		стрк = обк.НачислениеБонусныхБаллов[сч];
		
		НовСтр = Новый Структура;   
				
		НовСтр.Вставить("БонуснаяПрограммаЛояльности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.БонуснаяПрограммаЛояльности));
		НовСтр.Вставить("ДатаНачисления", стрк.ДатаНачисления);
		НовСтр.Вставить("ДатаСписания", стрк.ДатаСписания);
		НовСтр.Вставить("СуммаБонусныхБаллов", стрк.СуммаБонусныхБаллов);
		
		ТЧНачислениеБонусныхБаллов.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧНачислениеБонусныхБаллов", ТЧНачислениеБонусныхБаллов);
	

	//Таблица:	ОплатаБонуснымиБаллами
	
	ТЧОплатаБонуснымиБаллами = Новый Массив;
	
	Для сч = 0 По обк.ОплатаБонуснымиБаллами.Количество()-1 Цикл
		
		стрк = обк.ОплатаБонуснымиБаллами[сч];
		
		НовСтр = Новый Структура;   
				
		НовСтр.Вставить("БонуснаяПрограммаЛояльности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.БонуснаяПрограммаЛояльности));
		НовСтр.Вставить("ДатаОплаты", стрк.ДатаОплаты);
		НовСтр.Вставить("СуммаБонусныхБаллов", стрк.СуммаБонусныхБаллов);
		
		ТЧОплатаБонуснымиБаллами.Добавить(НовСтр);
	КонецЦикла;
	
	definition.Вставить("ТЧОплатаБонуснымиБаллами", ТЧОплатаБонуснымиБаллами);
	
	
	
	//------------------------------------------------------
	
	СтруктураОбъекта.Вставить("definition", definition);
	
	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
	json = ЗаписьJson.Закрыть();
	
	Возврат json;
	
	
	Возврат Неопределено;
	
КонецФункции

Функция ПолучитьОбъектыДляВыгрузки(Узел) Экспорт
	Возврат Неопределено;
КонецФункции

Функция getRoutingKey() Экспорт
	Возврат "doc";
КонецФункции




