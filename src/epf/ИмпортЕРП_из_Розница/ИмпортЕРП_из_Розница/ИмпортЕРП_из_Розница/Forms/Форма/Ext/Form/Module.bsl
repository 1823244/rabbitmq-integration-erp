﻿

&НаСервере
Процедура ВыполнитьИмпортНаСервере()
	РеквизитФормыВЗначение("Объект").ВыполнитьИмпорт();
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьИмпорт(Команда)
	ВыполнитьИмпортНаСервере();
	ПоказатьПредупреждение(,"Импорт завершен");
КонецПроцедуры
