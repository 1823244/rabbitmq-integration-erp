﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	      
	ОписаниеТипа = Новый ОписаниеТипов("ПланВидовХарактеристикСсылка.КСП_НастройкиФулфилмент"); 
	Элементы.НастройкиПодключения.ОграничениеТипа = ОписаниеТипа; 
	//НастройкиПодключения = ПланыВидовХарактеристик.КСП_НастройкиФулфилмент.ПустаяСсылка();
	Элементы.НастройкиПодключения.ВыборГруппИЭлементов = ГруппыИЭлементы.Группы; 
				
КонецПроцедуры



&НаСервере
Процедура СозданиеДвиженийКМНаСервере()
	ВыводитьСообщения = Ложь;//иначе слишком долго приходится ждать вывода после завершения импорта
	ОбменСФулфилментСервер.ЗагрузкаДанныхКМ(ВыводитьСообщения, НастройкиПодключения);
КонецПроцедуры

&НаКлиенте
Процедура СозданиеДвиженийКМ(Команда)
	СозданиеДвиженийКМНаСервере();  
	ПоказатьПредупреждение(, "Обмен с Оператором фулфилмента завершен!");
КонецПроцедуры



