﻿
Функция СведенияОВнешнейОбработке() Экспорт
	
	Версия = "1.0";
	
	ПараметрыРегистрации = Новый Структура;
	
	//МассивНазначений = Новый Массив;
	
	// Первый параметр, который мы должны указать - это какой вид обработки системе должна зарегистрировать.
	// Допустимые типы: ДополнительнаяОбработка, ДополнительныйОтчет, ЗаполнениеОбъекта, Отчет, ПечатнаяФорма, СозданиеСвязанныхОбъектов
	ПараметрыРегистрации.Вставить("Вид", "ДополнительнаяОбработка");
	ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование", "Загрузка заказов в 1С");
	
	// Зададим право обработке на использование безопасного режима. Более подробно можно узнать в справке к платформе (метод УстановитьБезопасныйРежим)
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	
	// Следующие два параметра играют больше информационную роль, т.е. это то, что будет видеть пользователь в информации к обработке
	ПараметрыРегистрации.Вставить("Версия", Версия);
	ПараметрыРегистрации.Вставить("Информация", "Загрузка заказов в 1С");
	
	// Создадим таблицу команд (подробнее смотрим ниже)
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	
	// Добавим команду в таблицу
	ДобавитьКоманду(ТаблицаКоманд, "Загрузка заказов в 1С", "BP", "ВызовСерверногоМетода", Ложь, "BP");
	
	// Сохраним таблицу команд в параметры регистрации обработки
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
	
	// Теперь вернем системе наши параметры
	Возврат ПараметрыРегистрации;
	
КонецФункции

Функция ПолучитьТаблицуКоманд()
	
	// Создадим пустую таблицу команд и колонки в ней
	Команды = Новый ТаблицаЗначений;
	
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	
	// Тут задается, как должна вызваться команда обработки
	// Возможные варианты:
	// - ОткрытиеФормы - в этом случае в колонке идентификатор должно быть указано имя формы, которое должна будет открыть система
	// - ВызовКлиентскогоМетода - вызвать клиентскую экспортную процедуру из модуля формы обработки
	// - ВызовСерверногоМетода - вызвать серверную экспортную процедуру из модуля объекта обработки
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	
	// Следующий параметр указывает, необходимо ли показывать оповещение при начале и завершению работы обработки. Не имеет смысла при открытии формы
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
	
	Возврат Команды;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
	
	// Добавляем команду в таблицу команд по переданному описанию.
	// Параметры и их значения можно посмотреть в функции ПолучитьТаблицуКоманд
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры

// Пощитаем коэффициенты и сделаем соответствие чтобы знать когда обновлять прогресс. 
Процедура ВыполнитьКоманду(Параметры) Экспорт
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.ИдентификаторНазначения = Новый УникальныйИдентификатор;
	Сообщение.Текст = "Фоновая выгрузка данных успешно началась.";
	Сообщение.Сообщить();
	
	ФоновоеЗадание = РасширенияКонфигурации.ВыполнитьФоновоеЗаданиеСРасширениямиБазыДанных("crm_RetailCRMОбщий.CRM_ЗагрузкаЗаказов",,,"Загрузка заказов в 1С"); 	
	
КонецПроцедуры

