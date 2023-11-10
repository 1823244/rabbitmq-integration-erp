﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ОприходованиеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_Розницы_Документ_ОприходованиеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_Розницы_Документ_ОприходованиеТоваров",
		"Форма_Плагин_RabbitMQ_импорт_из_Розницы_Документ_ОприходованиеТоваров",
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



// ///////////   ИМПОРТ  В ОБЪЕКТ ////////////


Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.оприходованиетоваров") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Документы.ОприходованиеИзлишковТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		ОбъектДанных = Документы.ОприходованиеИзлишковТоваров.СоздатьДокумент();
		СсылкаНового = Документы.ОприходованиеИзлишковТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
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

	//гуид="";
	//ЕстьАтрибут = деф.АналитикаДоходов.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.АналитикаДоходов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.АналитикаДоходов.Ref ) );
	//Иначе
	//	ОбъектДанных.АналитикаДоходов = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.АналитикаДоходов = ксп_ИмпортСлужебный.НайтиАналитикаДоходов(деф.АналитикаДоходов);

	//гуид="";
	//ЕстьАтрибут = деф.Валюта.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Валюта = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Валюта.Ref ) );
	//Иначе
	//	ОбъектДанных.Валюта = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	ОбъектДанных.Валюта = Константы.ВалютаРегламентированногоУчета.Получить();

	//гуид="";
	//ЕстьАтрибут = деф.ВидЦены.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ВидЦены = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ВидЦены.Ref ) );
	//Иначе
	//	ОбъектДанных.ВидЦены = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ВидЦены = ксп_ИмпортСлужебный.НайтиВидЦены(деф.ВидЦены);

	//ОбъектДанных.Исправление = деф.Исправление;

	//гуид="";
	//ЕстьАтрибут = деф.ИсправляемыйДокумент.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ИсправляемыйДокумент = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ИсправляемыйДокумент.Ref ) );
	//Иначе
	//	ОбъектДанных.ИсправляемыйДокумент = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ИсправляемыйДокумент = ксп_ИмпортСлужебный.НайтиИсправляемыйДокумент(деф.ИсправляемыйДокумент);

	ОбъектДанных.Комментарий = деф.Комментарий;

	//гуид="";
	//ЕстьАтрибут = деф.НаправлениеДеятельности.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.НаправлениеДеятельности = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.НаправлениеДеятельности.Ref ) );
	//Иначе
	//	ОбъектДанных.НаправлениеДеятельности = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.НаправлениеДеятельности = ксп_ИмпортСлужебный.НайтиНаправлениеДеятельности(деф.НаправлениеДеятельности);

	//гуид="";
	//ЕстьАтрибут = деф.Организация.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Организация = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Организация.Ref ) );
	//Иначе
	//	ОбъектДанных.Организация = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);

	//гуид="";
	//ЕстьАтрибут = деф.Основание.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Основание = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Основание.Ref ) );
	//Иначе
	//	ОбъектДанных.Основание = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Основание = ксп_ИмпортСлужебный.НайтиОснование(деф.Основание);

	ОбъектДанных.Ответственный = Пользователи.ТекущийПользователь();
	
	// ЕНС - ???
	//гуид="";
	//ЕстьАтрибут = деф.ПересчетТоваров.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ПересчетТоваров = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ПересчетТоваров.Ref ) );
	//Иначе
	//	ОбъектДанных.ПересчетТоваров = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ПересчетТоваров = ксп_ИмпортСлужебный.НайтиПересчетТоваров(деф.ПересчетТоваров);

	//гуид="";
	//ЕстьАтрибут = деф.Подразделение.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Подразделение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Подразделение.Ref ) );
	//Иначе
	//	ОбъектДанных.Подразделение = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Подразделение = ксп_ИмпортСлужебный.НайтиПодразделение(деф.Подразделение);

	//гуид="";
	//ЕстьАтрибут = деф.Склад.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Склад = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Склад.Ref ) );
	//Иначе
	//	ОбъектДанных.Склад = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	ОбъектДанных.Склад = ксп_ИмпортСлужебный.НайтиСклад(деф.Склад, мВнешняяСистема);

	//гуид="";
	//ЕстьАтрибут = деф.СтатьяДоходов.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.СтатьяДоходов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.СтатьяДоходов.Ref ) );
	//Иначе
	//	ОбъектДанных.СтатьяДоходов = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:        
	//ПланВидовХарактеристикСсылка.СтатьиДоходов
	ОбъектДанных.СтатьяДоходов = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций.Настройка("СтатьяДоходовДляОприходованияТоваров", мВнешняяСистема);

	//гуид="";
	//ЕстьАтрибут = деф.СторнируемыйДокумент.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.СторнируемыйДокумент = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.СторнируемыйДокумент.Ref ) );
	//Иначе
	//	ОбъектДанных.СторнируемыйДокумент = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СторнируемыйДокумент = ксп_ИмпортСлужебный.НайтиСторнируемыйДокумент(деф.СторнируемыйДокумент);




	//------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();



		//гуид="";
		//ЕстьАтрибут = стрк.ВидЗапасов.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.ВидЗапасов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ВидЗапасов.Ref ) );
		//Иначе
		//	СтрокаТЧ.ВидЗапасов = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.ВидЗапасов = ксп_ИмпортСлужебный.НайтиВидЗапасов(стрк.ВидЗапасов);

		//СтрокаТЧ.ИдентификаторСтроки = стрк.ИдентификаторСтроки;

		СтрокаТЧ.Количество = стрк.Количество;

		СтрокаТЧ.КоличествоПоРНПТ = стрк.КоличествоПоРНПТ;

		//гуид="";
		//ЕстьАтрибут = стрк.Назначение.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.Назначение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Назначение.Ref ) );
		//Иначе
		//	СтрокаТЧ.Назначение = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.Назначение = ксп_ИмпортСлужебный.НайтиНазначение(стрк.Назначение);

		СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);

		//
		//гуид="";
		//ЕстьАтрибут = стрк.НомерГТД.свойство("Ref",гуид);
		//Если ЕстьАтрибут Тогда
		//	СтрокаТЧ.НомерГТД = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НомерГТД.Ref ) );
		//Иначе
		//	СтрокаТЧ.НомерГТД = Неопределено;
		//КонецЕсли;
		//// на случай, если есть метод поиска ссылки:
		//СтрокаТЧ.НомерГТД = ксп_ИмпортСлужебный.НайтиНомерГТД(стрк.НомерГТД);

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

		СтрокаТЧ.Сумма = стрк.Сумма;

		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.Характеристика);

		СтрокаТЧ.Цена = стрк.Цена;     
		
		СтрокаТЧ.АналитикаУчетаНоменклатуры = ксп_ИмпортСлужебный.НайтиСоздатьКлючАналитикиНом(СтрокаТЧ.Номенклатура, ОбъектДанных.Склад);
		

	КонецЦикла;

	//------------------------------------------------------     ТЧ ДополнительныеРеквизиты



	ОбъектДанных.ДополнительныеРеквизиты.Очистить();


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

	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	Если деф.isPosted Тогда 
		ОбъектДанных.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
	КонецЕсли;

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
 
 