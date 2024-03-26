﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	ТипДокументаСлужебногоРезерва = перечисления.КСП_ТипДокументаСлужебногоРезерва.РаспределениеГотовойПродукции;
КонецПроцедуры


&НаСервере
Процедура ВыполнитьНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьДействие(Команда)
	ВыполнитьНаСервере();    
    Парам = Новый Структура("ОбъектДляЗаполнения,ТипДокументаСлужебногоРезерва");
    Парам.ОбъектДляЗаполнения = ВладелецФормы;
    Парам.ТипДокументаСлужебногоРезерва = ЭтаФорма.ТипДокументаСлужебногоРезерва;
    
    ЭтаФорма.Закрыть(Парам);
КонецПроцедуры


&НаСервере
Процедура ОтменаНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	ОтменаНаСервере();
	ЭтаФорма.Закрыть(Неопределено);
КонецПроцедуры


