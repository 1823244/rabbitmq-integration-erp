﻿ 
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Версия = ""+РеквизитФормыВЗначение("Объект").getVersion();
КонецПроцедуры


&НаСервере
Процедура ВыполнитьЭкспортНаСервере()
	РеквизитФормыВЗначение("Объект").ВыполнитьНастройкаRabbitMQ();
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьЭкспорт(Команда)
	ВыполнитьЭкспортНаСервере();
	ПоказатьПредупреждение(,"Настройка завершена!");
КонецПроцедуры

  