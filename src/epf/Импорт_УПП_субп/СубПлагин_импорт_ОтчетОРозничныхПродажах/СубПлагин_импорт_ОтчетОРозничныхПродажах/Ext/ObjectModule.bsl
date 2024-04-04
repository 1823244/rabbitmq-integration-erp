﻿Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем jsonText;

Перем мСкладОтправитель;
Перем мСкладПолучатель;
Перем мДоговор;

Перем СобиратьНенайденнуюНоменклатуру Экспорт;
Перем мНеНайденнаяНоменклатураМассив;

Перем мЛоггер;
Перем мИдВызова;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.8");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","СубПлагин_импорт_ОтчетОРозничныхПродажах");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","СубПлагин_импорт_ОтчетОРозничныхПродажах");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Импорт документа Отчет о розничных продажах",
		"СубПлагин_импорт_ОтчетОРозничныхПродажах",
		ТипКоманды, 
		Ложь) ;
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")

	НоваяКоманда = ТаблицаКоманд.Добавить() ;
	НоваяКоманда.Представление = Представление ;
	НоваяКоманда.Идентификатор = Идентификатор ;
	НоваяКоманда.Использование = Использование ;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение ;
	НоваяКоманда.Модификатор = Модификатор ;
КонецПроцедуры


#КонецОбласти 	


// Возвращает структуру. Поля различаются в зависимости от режима загрузки.
// Это нужно для отладки, а не для обычного режима работы.
//
Функция ЗагрузитьОбъект(СтруктураОбъекта, пjsonText = "", СкладЕРП) Экспорт

	мЛоггер = мис_ЛоггерСервер.getLogger(мИдВызова, "Импорт документов из УПП: Оприходование товаров");
	
	Попытка
		Если НЕ СтруктураОбъекта.Свойство("type") Тогда // на случай, если передадут пустой объект
			Возврат Неопределено;
		КонецЕсли;
		
		Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ОтчетОРозничныхПродажах") Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

		id = СтруктураОбъекта.identification;
		деф = СтруктураОбъекта.definition;
				
		ВидОперации = "";
		_знч = "";
		ЕстьЗначение = деф.ВидОперации.свойство("Значение",_знч);
		Если ЕстьЗначение Тогда
			ВидОперации = _знч;
		КонецЕсли;
		
		Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, мВнешняяСистема);
		УзелКонтрагента = Неопределено;
		
		//Сарычев
		Если деф.Склад.Свойство("Ref") Тогда 
			СкладУПП = Справочники.ксп_СкладыУПП.ПолучитьСсылку(Новый УникальныйИдентификатор(деф.Склад.Ref));
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение, ,,"Нашли склад УПП: "+ строка(СкладУПП));
			мСкладОтправитель = Справочники.КСП_ВидыОперацийПоСкладамУПП.ПоМэппингу(СкладУПП);
		Иначе	                                 
			СкладУПП = Справочники.ксп_СкладыУПП.ПустаяСсылка();
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Предупреждение, ,,"Склад УПП не заполнен ");
			мСкладОтправитель = Справочники.КСП_ВидыОперацийПоСкладамУПП.ПустаяСсылка();
		КонецЕсли; 
		//--

		////ЕНС. 2024-01-16. Договор теперь хранится в РС "КСП_КомиссионерыДляРеализацийУПП" для каждого контрагента
		//*ДоговорКонтрагента = ксп_ИмпортСлужебный.НайтиДоговор(деф.ДоговорКонтрагента, УзелКонтрагента, Контрагент);
		//ЭтоКомиссионер = РегистрыСведений.КСП_КомиссионерыДляРеализацийУПП.ЭтоКомиссионер(мВнешняяСистема, Контрагент, ДоговорКонтрагента, деф.date); 
		//*мСкладПолучатель = РегистрыСведений.КСП_КомиссионерыДляРеализацийУПП.СкладПолучатель(мВнешняяСистема, Контрагент, ДоговорКонтрагента, деф.date);
		//мДоговор = РегистрыСведений.КСП_КомиссионерыДляРеализацийУПП.Договор(мВнешняяСистема, Контрагент, деф.date);
		
		мНеНайденнаяНоменклатураМассив = Новый Массив;
		
		Попытка
			Рез = Схема_1_ОтчетОРозничныхПродажах(СтруктураОбъекта);	
		Исключение
			т = ОписаниеОшибки();
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР, УровеньЖурналаРегистрации.Ошибка, ,,т);
			ВызватьИсключение т;
		КонецПопытки;
		
		
		ксп_ЭкспортСлужебный.ВыполнитьЭкспорт_ГуидовНоменклатуры( мНеНайденнаяНоменклатураМассив );
		
		Возврат Рез;
	Исключение
		т = ОписаниеОшибки();
		мЛоггер.ерр("Плагин: Плагин_RabbitMQ_импорт_из_УПП_Документ_ОтчетОРозничныхПродажах . Подробности: " + т);
		
		ВызватьИсключение т;
		
	КонецПопытки;
	
	
КонецФункции


#Область Схема_1_ОтчетОРозничныхПродажах


Функция Схема_1_ОтчетОРозничныхПродажах(СтруктураОбъекта) Экспорт

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ДокументИзУПП = "Отчет о розничных продажах (УПП) № " + деф.Number + " от " + строка(деф.Date);
	
	СуществующийОтчетСсылка 	   = СоздатьПолучитьСсылкуДокумента(id.Ref, "ОтчетОРозничныхПродажах");
	
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(СуществующийОтчетСсылка);

	Комментарий = "";
	
	// -------------------------------------------- БЛОКИРОВКА
	// не будем различать ситуации Новый/НеНовый
	//Если НЕ ЭтоНовый Тогда
		Блокировка = ксп_Блокировки.СоздатьБлокировкуНесколькихОбъектов(МассивСсылок);
	//КонецЕсли;
	
	НачатьТранзакцию();
	
	//Если НЕ ЭтоНовый Тогда
		Попытка
			Блокировка.Заблокировать();
		Исключение
			т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
				"Объект не загружен! Ошибка блокировки цепочки документов для " + ДокументИзУПП + ". Подробности: " + т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	//КонецЕсли;
		
	//------------------------------------- Заполнение реквизитов
	Попытка			
		ОтчетОРОзничныхПродажах = СоздатьОтчетОРозничныхПродажах(СтруктураОбъекта, СуществующийОтчетСсылка);		
		
		ЗафиксироватьТранзакцию();          		
		
		Рез = Новый Структура;
		Рез.Вставить("ОтчетОРОзничныхПродажах", ОтчетОРОзничныхПродажах.Ссылка);
		
	Исключение
		т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа " + ДокументИзУПП + ". Подробности: " + т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;	

	Возврат Рез;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
//Функция СоздатьЗаказНаПеремещение(СтруктураОбъекта, СуществующийЗаказСсылка)
Функция СоздатьОтчетОРозничныхПродажах(СтруктураОбъекта, СуществующийЗаказСсылка)
	
	ОбъектДанных = Неопределено;
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	Если ЗначениеЗаполнено(СуществующийЗаказСсылка.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийЗаказСсылка.ПолучитьОбъект();
		ПредставлениеОбъекта = Строка(СуществующийЗаказСсылка);
	Иначе   
		//Сарычев
		//ОбъектДанных = Документы.ЗаказНаПеремещение.СоздатьДокумент();
		//СсылкаНового = Документы.ЗаказНаПеремещение.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		//ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		//ПредставлениеОбъекта = Строка(ОбъектДанных);
		
		ОбъектДанных = Документы.ОтчетОРозничныхПродажах.СоздатьДокумент();
		СсылкаНового = Документы.ОтчетОРозничныхПродажах.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов -----------------------------------
	//ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	
	ОбъектДанных.ВидЦены = ксп_ИмпортСлужебный.НайтиВидЦены(деф.ТипЦен, мВнешняяСистема);  
	Если НЕ ЗначениеЗаполнено(ОбъектДанных.ВидЦены) Тогда
		ОбъектДанных.ВидЦены = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций.Настройка("ДокументОтчетОРозничныхПродажах_ВидЦены", мВнешняяСистема);
	КонецЕсли;
	
	ОбъектДанных.Валюта = сПРАВОЧНИКИ.Валюты.НайтиПоКоду("643");  
	
	ОбъектДанных.КассаККМ = ксп_ИмпортСлужебный.НайтиКассуККМ(деф.КассаККМ);   
	
	ОбъектДанных.Комментарий = "[УПП №" + деф.Number + " от " + деф.Date + " ]. Оригинальный коммент.: "+деф.Комментарий;
	
	Если деф.УчитыватьНДС Тогда
		ОбъектДанных.НалогообложениеНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
	Иначе
		ОбъектДанных.НалогообложениеНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаНеОблагаетсяНДС;
	КонецЕсли;	
	ОбъектДанных.СуммаДокумента  = деф.СуммаДокумента;
	ОбъектДанных.ЦенаВключаетНДС = деф.СуммаВключаетНДС;
	
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	ОбъектДанных.Склад       = ксп_ИмпортСлужебный.НайтиСклад(деф.Склад, мВнешняяСистема);
	
	ОбъектДанных.ПоРезультатамИнвентаризации = Ложь;
	ОбъектДанных.ВидыЗапасовУказаныВручную = Ложь;
	ОбъектДанных.ЕстьМаркируемаяПродукцияГИСМ = Ложь;
	ОбъектДанных.ПорядокРасчетов = Перечисления.ПорядокРасчетов.ПоДоговорамКонтрагентов;
	ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию();
	ОбъектДанных.Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, мВнешняяСистема);
	ОбъектДанных.ФормаОплаты = Перечисления.ФормыОплаты.Безналичная;
	
	//------------------------------------------------------     ТЧ Товары
	Если деф.ТЧТовары.Количество()> 0 Тогда
		
		ОбъектДанных.Товары.Очистить();  
		
		//	СкидкаВсего = 0;
		Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
			стрк = деф.ТЧТовары[счТовары];
			СтрокаТЧ = ОбъектДанных.Товары.Добавить();
			
			_Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);
			
			Если СобиратьНенайденнуюНоменклатуру Тогда
				Если ТипЗнч(_Номенклатура) = Тип("СправочникСсылка.Номенклатура") И НЕ ЗначениеЗаполнено(_Номенклатура.ВерсияДанных) Тогда
					
					Если Стрк.Номенклатура.Свойство("identification") Тогда
						// полный тэг. больше не используется. оставлено для совместимости
						ГУИД = "";
						Если стрк.Номенклатура.identification.Свойство("ref", ГУИД) Тогда
							Если НЕ мНеНайденнаяНоменклатураМассив.Найти(ГУИД) = "" Тогда
								мНеНайденнаяНоменклатураМассив.Добавить(ГУИД);
							КонецЕсли;
						КонецЕсли;
						
					Иначе 
						ГУИД = "";
						Если стрк.Номенклатура.Свойство("ref", ГУИД) Тогда
							Если НЕ мНеНайденнаяНоменклатураМассив.Найти(ГУИД) = "" Тогда
								мНеНайденнаяНоменклатураМассив.Добавить(ГУИД);
							КонецЕсли;
						КонецЕсли;
					КонецЕсли;
					
				КонецЕсли;
			КонецЕсли;
			
			СтрокаТЧ.Номенклатура = _Номенклатура;
			СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
			//СтрокаТЧ.Упаковка = СтрокаТЧ.Номенклатура.ЕдиницаИзмерения;
			//СтрокаТЧ.Упаковка = СправочникСсылка.УпаковкиЕдиницыИзмерения;
			СтрокаТЧ.Количество = стрк.Количество;
			СтрокаТЧ.КоличествоУпаковок = стрк.Количество;
			
			АвтСкидка = 0;
			Если ЗначениеЗаполнено (стрк.ПроцентАвтоматическихСкидок) Тогда
				Если стрк.ПроцентАвтоматическихСкидок<>"" Тогда
					АвтСкидка = Число(стрк.ПроцентАвтоматическихСкидок);
				КонецЕсли;
			КонецЕсли;
			
			СтрокаТЧ.ПроцентРучнойСкидки = АвтСкидка;
			СтрокаТЧ.Цена = Число(стрк.Цена) * (100-АвтСкидка) / 100; 
			СтрокаТЧ.СуммаРучнойСкидки = Число(стрк.Цена) * АвтСкидка / 100;
			СтрокаТЧ.Сумма = стрк.Сумма ;      
			СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.ОпределитьСтавкуНДСПоПеречислениюУПП(стрк.СтавкаНДС);
			СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;
			СтрокаТЧ.Партнер = Справочники.Партнеры.НайтиПоНаименованию(Строка(ОбъектДанных.Контрагент));   //клиент    
		КонецЦикла;	
		
	КонецЕсли;
	
	
	Если деф.ТЧОплатаплатежнымикартами.Количество()> 0 Тогда
		
		ОбъектДанных.Оплатаплатежнымикартами.Очистить();
		
		Для счТовары = 0 По деф.ТЧОплатаплатежнымикартами.Количество()-1 Цикл
			стрк = деф.ТЧОплатаплатежнымикартами[счТовары];
			СтрокаТЧ = ОбъектДанных.Оплатаплатежнымикартами.Добавить();
			СтрокаТЧ.Сумма = стрк.Сумма;           
			СтрокаТЧ.ВидОплаты = РегистрыСведений.ксп_МэппингПеречислениеТипыПлатежнойСистемыККТ.ПоМэппингу(стрк.ВидОплаты.Ref,"retail");
		КонецЦикла;	
		
	КонецЕсли;	
	
	
	//------------------------------------------------------ ФИНАЛ	
	
	ОбъектДанных.ОбменДанными.Загрузка = Ложь; 
	
	Если ОбъектДанных.Проведен Тогда
		ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
	Иначе 
		ОбъектДанных.Записать();
	КонецЕсли;
	
	
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);	
	
	Возврат ОбъектДанных;
	
КонецФункции

#КонецОбласти


#Область Тестирование

// вызывается из формы
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервере(JsonText) export

	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.УстановитьСтроку(JsonText);	
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	//Если ТипЗнч(СтруктураОбъекта) = Тип("Массив") Тогда  //Сарычев
	Если ТипЗнч(СтруктураОбъекта) = Тип("Структура") Тогда //Сарычев
		
		мНеНайденнаяНоменклатураМассив = Новый Массив;
		
		//Для Каждого эл из СтруктураОбъекта Цикл
		//	ЗагрузитьОбъект(эл);
		//КонецЦикла;
		
		Рез = Новый Структура;		
	    Рез = ЗагрузитьОбъект(СтруктураОбъекта,,); //Сарычев
		Рез.Вставить("НеНайденнаяНоменклатураМассив", мНеНайденнаяНоменклатураМассив);
		Возврат Рез; 
		
	Иначе       
		Рез = Новый Структура;
		Рез = ЗагрузитьОбъект(СтруктураОбъекта,,);
	    Возврат Рез;
	КонецЕсли;
	
	
КонецФункции 

#КонецОбласти 	

// Описание_метода
//
// Параметры:
//	ГУИД 	- строка - 36 симв
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьПолучитьСсылкуДокумента(ГУИД, ВидОбъекта)

	СуществующийОбъект = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
	
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		Возврат СуществующийОбъект;
	Иначе 
		
		ОбъектДанных = Документы[ВидОбъекта].СоздатьДокумент();
		СсылкаНового = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(ГУИД));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);

		Возврат ОбъектДанных.Ссылка;
	КонецЕсли;	
    
КонецФункции

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

 Функция сетИдВызова(пИдВызова) Экспорт
     
    мИдВызова = пИдВызова;
    Возврат ЭтотОбъект;
     
КонецФункции

мВнешняяСистема = "upp";        

 СобиратьНенайденнуюНоменклатуру = Истина;
 мНеНайденнаяНоменклатураМассив = Новый Массив;
 
 
 