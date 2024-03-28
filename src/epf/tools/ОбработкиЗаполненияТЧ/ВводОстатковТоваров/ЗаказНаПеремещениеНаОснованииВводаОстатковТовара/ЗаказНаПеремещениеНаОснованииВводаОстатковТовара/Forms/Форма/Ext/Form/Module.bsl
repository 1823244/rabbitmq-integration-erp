﻿Перем ОбъектЗаполнения Экспорт;

&НаКлиенте
Процедура ВыполнитьКоманду(ИдентификаторКоманды, ОбъектыНазначенияМассив) Экспорт
	Если НЕ ЗначениеЗаполнено(Объект.Документ) Тогда 
         Объект.Документ = ВладелецФормы.Объект.Ссылка;
    КонецЕсли;
    ОбъектЗаполнения=Объект.Документ;
	СоздатьДокументЗаказНаПеремещение(ОбъектЗаполнения);
	
КонецПроцедуры



&НаСервере
Процедура СоздатьДокументЗаказНаПеремещение(ВводОстатковСсылкаОбъект)
	
	
	ОбъектДанных = Документы.ЗаказНаПеремещение.СоздатьДокумент();
	ЗаполнитьЗначенияСвойств(ОбъектДанных, ВводОстатковСсылкаОбъект, , "Номер,Дата");
	
	ОбъектДанных.Дата = ТекущаяДатаСеанса();
	
	ОбъектДанных.ПометкаУдаления = Ложь;
	
	ОбъектДанных.Комментарий = "Ввод остатков №"+строка(ВводОстатковСсылкаОбъект.Номер)+" от "+строка(ВводОстатковСсылкаОбъект.Дата);
	//ОбъектДанных.Номер = деф.Number;
	
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПеремещениеТоваров;
	ОбъектДанных.Статус = Перечисления.СтатусыВнутреннихЗаказов.КВыполнению; 
	
	ОбъектДанных.СкладОтправитель = ВводОстатковСсылкаОбъект.Склад;

	ОбъектДанных.Приоритет = Справочники.Приоритеты.НайтиПоНаименованию("Средний");
	
	ОбъектДанных.ЖелаемаяДатаПоступления = ОбъектДанных.Дата;
	
	ОбъектДанных.СпособДоставки = Перечисления.СпособыДоставки.Самовывоз;
	
	
	
	ОбъектДанных.ВариантПриемкиТоваров = Перечисления.ВариантыПриемкиТоваров.РазделенаПоЗаказамИНакладным;
	
	ОбъектДанных.Товары.Очистить();
	
	счКодСтроки = 1;
	Для каждого строка из ВводОстатковСсылкаОбъект.Товары Цикл
		
		НоваяСтрока = ОбъектДанных.Товары.Добавить();
		
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
		//Если ЗаполненаСсылка(строка.Номенклатура) Тогда
		//	НоваяСтрока.Номенклатура = ПолучитьСсылкуСправочникаПоДаннымID(строка.Номенклатура, "Номенклатура");
		//КонецЕсли;
		//Если ЗаполненаСсылка(строка.Номенклатура) Тогда
		//	НоваяСтрока.Характеристика = ПолучитьСсылкуСправочникаПоДаннымID(строка.ХарактеристикаНоменклатуры, "ХарактеристикиНоменклатуры");
		//КонецЕсли;
		//
		//НоваяСтрока.Количество = строка.Количество; 
		//НоваяСтрока.КоличествоУпаковок = строка.Количество; 
		                    
		НоваяСтрока.НачалоОтгрузки = ОбъектДанных.Дата;
		
		НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.СоСклада;

		НоваяСтрока.КодСтроки = счКодСтроки;
		счКодСтроки = счКодСтроки + 1;
	КонецЦикла; 
	
	ОбъектДанных.ОбменДанными.Загрузка = ложь;
	Успешно = Ложь;
	Попытка
		ОбъектДанных.Записать(РежимЗаписиДокумента.Проведение);
		Успешно = Истина;
	Исключение
		т = ОписаниеОшибки();
	    сообщить("Ошибка проведения документа Заказ на перемещение: "+т);
	КонецПопытки;
	
	Если не успешно Тогда
		ОбъектДанных.Записать(РежимЗаписиДокумента.запись);
	КонецЕсли;
	
	сообщить("Создан документ Заказ на перемещение: "+строка(ОбъектДанных));
	
КонецПроцедуры


