﻿ // простой пример
 //https://programmist1s.ru/obrabotka-zapolneniya-tablichnoy-chasti-1s-8-3-upravlyaemyie-formyi-na-primere/?ysclid=lu9ksw15rz824662843
 // посложнее
 //https://infostart.ru/1c/articles/825702
 
 // ЕНС. Заполнение происходит в форме, без записи объекта. Включается флаг Модифицированность у формы.
 
 
Функция СведенияОВнешнейОбработке() Экспорт
    Назначения = Новый Массив;
    Назначения.Добавить("Документ.ВводОстатковТоваров");
     
    ПараметрыРегистрации = Новый Структура;
    ПараметрыРегистрации.Вставить("Вид","ЗаполнениеОбъекта");
    ПараметрыРегистрации.Вставить("Назначение",Назначения);
    ПараметрыРегистрации.Вставить("Наименование","Заполнение колонки ВидЗапасов в ТЧ Товары");
    ПараметрыРегистрации.Вставить("Версия","1.7");
    ПараметрыРегистрации.Вставить("Информация","Дополнительная обработка табличной части");
    ПараметрыРегистрации.Вставить("БезопасныйРежим",Истина);
     
    Команды = ПолучитьТаблицуКоманд();
    ДобавитьКоманду(Команды, "Заполнить колонку ВидЗапасов",
            "Заполнить","ВызовКлиентскогоМетода",Ложь,);
     
    ПараметрыРегистрации.Вставить("Команды",Команды);
     
    Возврат ПараметрыРегистрации;
     
КонецФункции
 
Функция ПолучитьТаблицуКоманд()
    Команды = Новый ТаблицаЗначений ;
    Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка")) ;
    Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка")) ;
    Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка")) ;
    Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево")) ;
    Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка")) ;
    Возврат Команды;
КонецФункции   
 
Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор,
                Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
    НоваяКоманда = ТаблицаКоманд.Добавить() ;
    НоваяКоманда.Представление = Представление ;
    НоваяКоманда.Идентификатор = Идентификатор ;
    НоваяКоманда.Использование = Использование ;
    НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение ;
    НоваяКоманда.Модификатор = Модификатор ;
КонецПроцедуры


