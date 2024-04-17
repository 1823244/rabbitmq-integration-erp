﻿Перем мВнешняяСистема;
Перем ИмяСобытияЖР;
Перем мСкладОтправитель;


#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт
	
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();
	
	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.6");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","СубПлагин_док_ПеремещениеТоваров_Резервирование_регистр_опт");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","СубПлагин_док_ПеремещениеТоваров_Резервирование_регистр_опт");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
	"Открыть форму : СубПлагин_док_ПеремещениеТоваров_Резервирование_регистр_опт",
	"СубПлагин_док_ПеремещениеТоваров_Резервирование_регистр_опт",
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

#Область ЗагрузитьОбъект_

Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "" ) Экспорт
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("Документ.ПеремещениеТоваров") Тогда
		Возврат Неопределено;
	КонецЕсли; 
	
	ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ПредставлениеДокументаУПП 			= "ПеремещениеТоваров (УПП) №"+деф.Number+" от "+строка(деф.Date);
	
	//СкладУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладОтправитель, "КСП_СкладыУПП");
	//СкладХраненияУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладПолучатель, "КСП_СкладыХраненияУПП");
	
	
	НачатьТранзакцию();
	
	Попытка
		
		//ГУИД = Новый УникальныйИдентификатор(id.Ref);	
		
		СсылкаНаЗапись = СоздатьПолучитьСсылкуДокумента(id.Ref);
		
		
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.КСП_ЗагрузкаДокументовПеремещений");
		ЭлементБлокировки.УстановитьЗначение("Ссылка", СсылкаНаЗапись);  
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
		Блокировка.Заблокировать();
		
		// установить блокировку на регистр	
		
		//----------------------------- Заполнение реквизитов шапки в регистр ------------------------
		
		НаборЗаписейШапка = РегистрыСведений.КСП_ЗагрузкаДокументовПеремещений.СоздатьНаборЗаписей(); 
		НаборЗаписейШапка.Отбор.Ссылка.Установить(СсылкаНаЗапись);  
		
		НоваяЗаписьШапка = НаборЗаписейШапка.Добавить();
		
		НоваяЗаписьШапка.Ссылка = СсылкаНаЗапись;
		НоваяЗаписьШапка.Номер = деф.Number;
		НоваяЗаписьШапка.Дата = деф.Date;
		НоваяЗаписьШапка.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
		НоваяЗаписьШапка.Склад = мСкладОтправитель;
		
		НоваяЗаписьШапка.Комментарий =  деф.Комментарий + " Получено обменом из УПП";
		
		НоваяЗаписьШапка.Ответственный = ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию(); 
		
		//ОбъектДанных.Подразделение = ксп_ИмпортСлужебный.НайтиПодразделение(деф.Подразделение); ?
		НоваяЗаписьШапка.Подразделение = Справочники.СтруктураПредприятия.НайтиПоНаименованию("Оптовые торговые подразделения (ОТП)"); 
		НоваяЗаписьШапка.Склад = Справочники.Склады.НайтиПоНаименованию("Щепкин");
		
		НоваяЗаписьШапка.Статус = Перечисления.СтатусыВнутреннихЗаказов.КВыполнению;;
		НоваяЗаписьШапка.Согласован = Истина;
		
		
		НоваяЗаписьШапка.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.СписаниеТоваровПоТребованию;
		НоваяЗаписьШапка.ДатаОтгрузки = деф.Date;
		НоваяЗаписьШапка.НеОтгружатьЧастями = Ложь;
		
		НоваяЗаписьШапка.Приоритет = Справочники.Приоритеты.НайтиПоНаименованию("Средний"); 
		
		НоваяЗаписьШапка.Ответственный = Справочники.Пользователи.НайтиПоНаименованию("admin");
		НоваяЗаписьШапка.Автор = Справочники.Пользователи.НайтиПоНаименованию("admin");
		
		
		// Реквизиты КСП
		НоваяЗаписьШапка.КСП_Коллекция = Справочники.КоллекцииНоменклатуры.НайтиПоНаименованию("Весна 2023");
		НоваяЗаписьШапка.КСП_ТипДокументаСлужебногоРезерва = Перечисления.КСП_ТипДокументаСлужебногоРезерва.РаспределениеГотовойПродукции;
		
		НаборЗаписейШапка.Записать(Истина);
		
		
		////------------------------------ Заполнение регистра ТЧ Товары ----------------------------------
		
		// Установить блокировку регистра таб части   
		
		
		ТаблицаНоменклатуры = СоздатьТабДокТЧ(); 
		
		Для счТовары = 0 По деф.ТабличнаяЧасть_Товары.Количество()-1 Цикл 
			
			ДанныеСтроки = деф.ТабличнаяЧасть_Товары[счТовары];
			СтрокаТаб = ТаблицаНоменклатуры.Добавить();
			СтрокаТаб.Ссылка = СсылкаНаЗапись;
			_Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(ДанныеСтроки.Номенклатура);
			СтрокаТаб.Номенклатура = _Номенклатура;
			СтрокаТаб.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(ДанныеСтроки.ХарактеристикаНоменклатуры);
			
			//СтрокаТЧ.Упаковка = Стрк.Номенклатура.ЕдиницаИзмерения;
			СтрокаТаб.КоличествоУпаковок = ДанныеСтроки.Количество;
			СтрокаТаб.Количество = ДанныеСтроки.Количество;
			СтрокаТаб.ДатаОтгрузки = деф.Date;
			
			// Отменено
			СтрокаТаб.СтатьяРасходов = ПланыВидовХарактеристик.СтатьиРасходов.НайтиПоНаименованию("Отклонение в стоимости товаров");		
			СтрокаТаб.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.СоСклада;	
			
		КонецЦикла;	
		
		// Блокировка регистра хранения табличной части
		БлокировкаТЧ = Новый БлокировкаДанных;
		ЭлементБлокировкиТЧ = Блокировка.Добавить("РегистрСведений.КСП_ЗагрузкаДокументовПеремещенийТабЧасть");
		ЭлементБлокировкиТЧ.УстановитьЗначение("Ссылка", СсылкаНаЗапись);
		ЭлементБлокировкиТЧ.Режим = РежимБлокировкиДанных.Разделяемый;
		ЭлементБлокировкиТЧ.ИсточникДанных = ТаблицаНоменклатуры;
		ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Номенклатура", "Номенклатура");
		ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Характеристика", "Характеристика");
		БлокировкаТЧ.Заблокировать();
		
		
		НаборЗаписейТабЧасть = РегистрыСведений.КСП_ЗагрузкаДокументовПеремещенийТабЧасть.СоздатьНаборЗаписей(); 
		НаборЗаписейТабЧасть.Отбор.Ссылка.Установить(СсылкаНаЗапись);  
		
		
		
		Для Каждого Строка Из ТаблицаНоменклатуры Цикл
			НоваяЗапись = НаборЗаписейТабЧасть.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяЗапись, Строка);
		КонецЦикла; 
		
		НаборЗаписейТабЧасть.Записать(Истина);
		
		
		
		СоздатьДокументыПоСхемеРезервирования_Опт(СтруктураОбъекта);
		
		
		
		ЗафиксироватьТранзакцию();
		
	Исключение                	
		
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
		"Объект не загружен! Ошибка в процессе загрузки документа "+ПредставлениеДокументаУПП+". Подробности: "+т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		
		
	КонецПопытки;
	
	jsonText = "";
	
	//ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	//ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	//ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	//ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	//ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);	
	
	Возврат Истина;
	
					
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
Функция СоздатьПолучитьСсылкуДокумента(ГУИД)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	КСП_ЗагрузкаДокументовПеремещений.Ссылка КАК Ссылка
	|ИЗ
	|	РегистрСведений.КСП_ЗагрузкаДокументовПеремещений КАК КСП_ЗагрузкаДокументовПеремещений
	|ГДЕ
	|	КСП_ЗагрузкаДокументовПеремещений.Ссылка = &Ссылка";	
	
	СсылкаНаЗапись = Новый УникальныйИдентификатор(ГУИД); 
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаЗапись);
	Результат = Запрос.Выполнить().Выбрать();
	
	Если Результат.Следующий() Тогда
		Возврат Результат.Ссылка;
	Иначе 
		Возврат Неопределено;
	КонецЕсли;	
	
КонецФункции


#Область СлужебныеЗаполненияИПолученияСсылок

Функция СоздатьТабДокТЧ()
	
	НоменклатураТЗ = Новый ТаблицаЗначений;
	НоменклатураТЗ.Колонки.Добавить("Ссылка");
	НоменклатураТЗ.Колонки.Добавить("Номенклатура");
	НоменклатураТЗ.Колонки.Добавить("Характеристика");
	НоменклатураТЗ.Колонки.Добавить("Упаковка");
	НоменклатураТЗ.Колонки.Добавить("СтатьяРасходов");
	НоменклатураТЗ.Колонки.Добавить("ВариантОбеспечения");
	НоменклатураТЗ.Колонки.Добавить("Серия");
	НоменклатураТЗ.Колонки.Добавить("Обособленно");
	НоменклатураТЗ.Колонки.Добавить("ВариантОбеспеченияДоИзмененияОбновлениемИБ");
	НоменклатураТЗ.Колонки.Добавить("КоличествоУпаковок");
	НоменклатураТЗ.Колонки.Добавить("Количество");
	НоменклатураТЗ.Колонки.Добавить("ДатаОтгрузки");

	Возврат НоменклатураТЗ;	
	
КонецФункции	


Функция ПолучитьСсылкаНаДопОбработку(id,деф,СтруктураОбъекта,jsonText)
	Ответ = Новый Структура;
	СкладОтправительУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладОтправитель, "КСП_СкладыУПП");
	СкладПолучательУПП = ПолучитьСсылкуСправочникаПоДаннымID(деф.СкладПолучатель, "КСП_СкладыУПП");
	Если ЗначениеЗаполнено(СкладОтправительУПП) и ЗначениеЗаполнено(СкладПолучательУПП) Тогда
		ЛогикаОбработкиСкладОтправительУПП = ПолучитьЛогикуСклада(СкладОтправительУПП);
		ЛогикаОбработкиСкладПолучательУПП = ПолучитьЛогикуСклада(СкладПолучательУПП);
		Если ЗначениеЗаполнено(ЛогикаОбработкиСкладОтправительУПП) и ЗначениеЗаполнено(ЛогикаОбработкиСкладПолучательУПП) Тогда
			Запрос = Новый Запрос;
			Запрос.УстановитьПараметр("ЛогикаСкладПолучатель", ЛогикаОбработкиСкладПолучательУПП);
			Запрос.УстановитьПараметр("ЛогикаСкладОтправитель", ЛогикаОбработкиСкладОтправительУПП);
			Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
				|	КСП_ЛогикаОбработкиПеремещений.СсылкаНаДопОбработку КАК СсылкаНаДопОбработку
				|ИЗ
				|	Справочник.КСП_ЛогикаОбработкиПеремещений КАК КСП_ЛогикаОбработкиПеремещений
				|ГДЕ
				|	КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладОтправитель = &ЛогикаСкладОтправитель
				|	И КСП_ЛогикаОбработкиПеремещений.ЛогикаСкладПолучатель = &ЛогикаСкладПолучатель";

			Результат = Запрос.Выполнить();
			Если Результат.Пустой() Тогда
				Возврат Неопределено;
			КонецЕсли;
			Выборка = Результат.Выбрать();
			Выборка.Следующий();
			Возврат Выборка.СсылкаНаДопОбработку;
		Иначе
			Возврат Неопределено;	
		КонецЕсли;
	Иначе
		Возврат Неопределено;
	КонецЕсли;	
КонецФункции

Функция ПолучитьСкладERP(СкладУПП) 

	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП КАК СкладУПП,
	|	КСП_ВидыОперацийПоСкладамУПП.СкладЕРП КАК СкладЕРП,
	|	КСП_ВидыОперацийПоСкладамУПП.Ссылка КАК Ссылка,
	|	КСП_ВидыОперацийПоСкладамУПП.ЛогикаОбработкиВШапке КАК ЛогикаОбработки
	|ИЗ
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП КАК КСП_ВидыОперацийПоСкладамУПП
	|ГДЕ
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП = &СкладУПП";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат СкладУПП;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.СкладЕРП;

КонецФункции

Функция ПолучитьЛогикуСклада(СкладУПП) 

	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	|	КСП_ВидыОперацийПоСкладамУПП.ЛогикаОбработкиВШапке КАК ЛогикаОбработки
	|ИЗ
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП КАК КСП_ВидыОперацийПоСкладамУПП
	|ГДЕ
	|	КСП_ВидыОперацийПоСкладамУПП.СкладУПП = &СкладУПП";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.ЛогикаОбработки;

КонецФункции

Функция ЗаполненаСсылка(СтруктураID) 
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Ложь;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если ЗначениеЗаполнено(Ref) Тогда
			Возврат Истина;
		КонецЕсли;
	Исключение
		Возврат Ложь;
	КонецПопытки;
КонецФункции

Функция ПолучитьСсылкуДокументаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
			Возврат Неопределено;
		КонецЕсли;
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	ДанныеСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	Возврат ДанныеСсылка;
КонецФункции

Функция ПолучитьСсылкуСправочникаПоДаннымID(СтруктураID, ВидОбъекта) Экспорт
	Если не ТипЗнч(СтруктураID) = Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	Попытка
		Ref = СтруктураID.Ref;	
		Если не ЗначениеЗаполнено(СтруктураID.Ref) Тогда
			Возврат Неопределено;
		КонецЕсли;
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	ДанныеСсылка = Справочники[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(СтруктураID.Ref));
	Возврат ДанныеСсылка;
КонецФункции


// Ищет Вид операции по складу по
//- складу УПП в шапке
//- складу хранения в ТЧ Получатели
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: спр Виды операций по складам УПП
//
Функция Найти_в_спр_КСП_ВидыОперацийПоСкладамУПП_Получатели(СкладУПП, СкладХраненияУПП)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("СкладУПП", СкладУПП);
	Запрос.УстановитьПараметр("СкладХраненияУПП", СкладХраненияУПП);
	
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ТЧ.Ссылка как ВидОперацииПоСкладу
	|
	|ИЗ 
	|	Справочник.КСП_ВидыОперацийПоСкладамУПП.Получатели КАК ТЧ
	|	left join Справочник.КСП_ВидыОперацийПоСкладамУПП КАК шапка
	|	ПО шапка.ссылка = ТЧ.ссылка
	|ГДЕ 
	|	ТЧ.СкладХраненияУПП = &СкладХраненияУПП
	|	И шапка.СкладУПП = &СкладУПП
	|   И Шапка.Отключено = ЛОЖЬ";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	МассивОперацийПоСкладу = Новый массив;
	
	Рез = Неопределено;
	сч = 0;
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		Рез = Выборка.ВидОперацииПоСкладу;
		МассивОперацийПоСкладу.Добавить(Рез);
		сч = сч + 1;
	КонецЦикла;
	
	
	Если сч > 1 Тогда
		
		т = "";
		Для сч = 0 По МассивОперацийПоСкладу.Количество() - 1 Цикл
			
			т = т + строка(МассивОперацийПоСкладу[сч])+" код "+МассивОперацийПоСкладу[сч].Код+", ";
			
		КонецЦикла;
		//ВызватьИсключение "Найдено более одного вида операции по складу! Список операций: "+т;
	КонецЕсли;
	
	Возврат МассивОперацийПоСкладу;
	
КонецФункции



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиВидДокументаУПП(ВидДокумента)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ТТ.Ссылка КАК ВидДок
		|ИЗ
		|	Справочник.КСП_ВидыДокументовУПП КАК ТТ
		|ГДЕ
		|	
		|	ТТ.Наименование = &ВидДокумента";
	
	Запрос.УстановитьПараметр("ВидДокумента", ВидДокумента);
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		ВызватьИсключение "Не найден вид документа УПП в спр. видов документов: "+Строка(ВидДокумента);
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	ВидДок = Неопределено;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ВидДок = ВыборкаДетальныеЗаписи.ВидДок;
	КонецЦикла;
	
		
	Возврат ВидДок;
	
КонецФункции

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиЛогикуПоВидуДокумента(ВидОперации, СкладХраненияУПП, ВидДокументаУППСсылка)
	
	ЛогикаОбработки = Неопределено;
	
	Для каждого стрк Из ВидОперации.ПОлучатели Цикл
		
		Если НЕ стрк.СкладХраненияУПП = СкладХраненияУПП Тогда
			Продолжить;
		КонецЕсли;
		
		ТекущаяЛогика = стрк.ЛогикаОбработкиВТЧ;
		
		Для каждого стркОбработчик Из ТекущаяЛогика.ОбработчикиТиповДокументов Цикл
			
			Если стркОбработчик.ВидДокументаУПП = ВидДокументаУППСсылка Тогда
				
				Возврат ТекущаяЛогика;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;	
	
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
Функция НайтиСубПлагинВЛогикеПоВидуДокумента(ЛогикаОбработки, ВидДокументаУППСсылка)
	
	Для каждого стркОбработчик Из ЛогикаОбработки.ОбработчикиТиповДокументов Цикл
		
		Если стркОбработчик.ВидДокументаУПП = ВидДокументаУППСсылка Тогда
			
			Возврат стркОбработчик.СсылкаНаДопОбработку;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;

КонецФункции 


#КонецОбласти


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
	
	Если Свойство = "Date" Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период" Тогда
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
	мРеквизиты.Добавить("Склад");
	мРеквизиты.Добавить("Организация");
	Возврат мРеквизиты;
	
КонецФункции



Функция СоздатьДокументыПоСхемеРезервирования_Опт(СтруктураОбъекта)
	
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
	ДокументИзУПП = "ПеремещениеТоваров (УПП) № "+деф.Number+" от "+строка(деф.Date);
	
	СуществующийДокумент	= Документы["ЗаказНаВнутреннееПотребление"].ПолучитьСсылку(Новый УникальныйИдентификатор(id.ref));
	
	Если ЗначениеЗаполнено(СуществующийДокумент.ВерсияДанных) Тогда
		ЭтоНовый = Ложь;
		ОбъектДанных = СуществующийДокумент.ПолучитьОбъект();
	Иначе 
		ЭтоНовый = Истина;
		ОбъектДанных = Документы["ЗаказНаВнутреннееПотребление"].СоздатьДокумент();
		СсылкаНового = Документы["ЗаказНаВнутреннееПотребление"].ПолучитьСсылку(Новый УникальныйИдентификатор(id.ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);

	КонецЕсли;	
	
	
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(СуществующийДокумент);
	
	Комментарий = "";
	
	// -------------------------------------------- БЛОКИРОВКА
	Если НЕ ЭтоНовый Тогда
		Блокировка = ксп_Блокировки.СоздатьБлокировкуНесколькихОбъектов(МассивСсылок);
	КонецЕсли;
	
	НачатьТранзакцию();
	
	Если НЕ ЭтоНовый Тогда
		Попытка
			Блокировка.Заблокировать();
		Исключение
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
				"Объект не загружен! Ошибка блокировки цепочки документов для "+ДокументИзУПП+". Подробности: "+т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
		
	//------------------------------------- Заполнение реквизитов
	Попытка			
		
		ЗаполнитьРеквизитыЗаказНаВутреннееПотребление(СтруктураОбъекта, ОбъектДанных);
		
		
		ОбъектДанных.ОбменДанными.Загрузка = Ложь;
		ОбъектДанных.Записать();
		
		jsonText = "";
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
		ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);	

		
		// справочник КСП_РезультатыИмпортаУПП
		
		СтруктураПараметры = Справочники.КСП_РезультатыИмпортаУПП.СтруктураПараметров();
	
		СтруктураПараметры.Вставить("ВидДокумента", "Документ.ПеремещениеТоваров");
		СтруктураПараметры.Вставить("Номер", деф.Number);
		СтруктураПараметры.Вставить("Дата", деф.Date);
		СтруктураПараметры.Вставить("ГУИД", id.ref);
		СтруктураПараметры.Вставить("Проведен", деф.IsPosted);
		МассивДокументов = Новый Массив;
		МассивДокументов.Добавить(ОбъектДанных.Ссылка);
		
		СтруктураПараметры.Вставить("МассивДокументов", МассивДокументов);
		
		Справочники.КСП_РезультатыИмпортаУПП.ДобавитьЗапись(СтруктураПараметры);
		
		
		// ФИНАЛ
		
		ЗафиксироватьТранзакцию();          		
		
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,,
			"Объект не загружен! Ошибка в процессе загрузки документа "+ДокументИзУПП+". Подробности: "+т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;	

	Возврат ОбъектДанных.Ссылка;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗаполнитьРеквизитыЗаказНаВутреннееПотребление(СтруктураОбъекта, ОбъектДанных)
	
		
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;

	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
    ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	ОбъектДанных.Склад = мСкладОтправитель;
	
	ОбъектДанных.Комментарий =  "[УПП №"+строка(деф.Number)+" от "+строка(деф.Date)+" ]."+деф.Комментарий + ". Получено обменом из УПП";
	
 	ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию(); 
	
	//ОбъектДанных.Подразделение = ксп_ИмпортСлужебный.НайтиПодразделение(деф.Подразделение);
	ОбъектДанных.Подразделение = Справочники.СтруктураПредприятия.НайтиПоНаименованию("Оптовые торговые подразделения (ОТП)"); 
	ОбъектДанных.Склад = Справочники.Склады.НайтиПоНаименованию("Щепкин");
	
	ОбъектДанных.Статус = Перечисления.СтатусыВнутреннихЗаказов.КВыполнению;;
	ОбъектДанных.Согласован = Истина;
	
 	
	ОбъектДанных.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.СписаниеТоваровПоТребованию;
	ОбъектДанных.ДатаОтгрузки = деф.Date;
	ОбъектДанных.НеОтгружатьЧастями = Ложь;
		
	ОбъектДанных.Приоритет = Справочники.Приоритеты.НайтиПоНаименованию("Средний"); 
	
	ОбъектДанных.Ответственный = Справочники.Пользователи.НайтиПоНаименованию("admin");
	ОбъектДанных.Автор = Справочники.Пользователи.НайтиПоНаименованию("admin");
	
	
	// Реквизиты КСП
	ОбъектДанных.КСП_Коллекция = Неопределено;//Справочники.КоллекцииНоменклатуры.НайтиПоНаименованию("Весна 2023");
	ОбъектДанных.КСП_ТипДокументаСлужебногоРезерва = Перечисления.КСП_ТипДокументаСлужебногоРезерва.РаспределениеГотовойПродукции;



	////------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТабличнаяЧасть_Товары.Количество()-1 Цикл
		стрк = деф.ТабличнаяЧасть_Товары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();

		_Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);
		
        СтрокаТЧ.Номенклатура = _Номенклатура;
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.ХарактеристикаНоменклатуры);
		//СтрокаТЧ.Упаковка = Стрк.Номенклатура.ЕдиницаИзмерения;
		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;
		СтрокаТЧ.Количество = стрк.Количество;
		СтрокаТЧ.ДатаОтгрузки = ОбъектДанных.Дата;
		
		// Отменено
		СтрокаТЧ.СтатьяРасходов = ПланыВидовХарактеристик.СтатьиРасходов.НайтиПоНаименованию("Отклонение в стоимости товаров");		
		СтрокаТЧ.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.СоСклада;	
 	

	КонецЦикла;

	////------------------------------------------------------     ТЧ ДополнительныеРеквизиты



	
КонецФункции



мВнешняяСистема = "UPP";

ИмяСобытияЖР = "Импорт_из_RabbitMQ_УПП";

