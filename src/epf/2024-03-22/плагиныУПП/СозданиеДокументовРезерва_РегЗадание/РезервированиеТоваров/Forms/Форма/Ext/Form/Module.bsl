﻿
&НаСервере
Процедура ВыполнитьЗагрузкуИзРегистровНаСервере()
	РеквизитФормыВЗначение("Объект").СоздатьМодифицироватьДокументРезервирования();
КонецПроцедуры


&НаКлиенте
Процедура ВыполнитьЗагрузкуИзРегистров(Команда)
	ВыполнитьЗагрузкуИзРегистровНаСервере();
КонецПроцедуры

