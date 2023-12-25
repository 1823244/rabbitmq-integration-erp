
; /* Start:/bitrix/templates/.default/js/highlight1c.js*/
///////////////////////////////////////////////////////////////////////
var highlight1c_inited = false;
function highlight1c(prm_id){


var reg_words_1C_77=/^(Если|If|Тогда|Then|ИначеЕсли|ElsIf|Иначе|Else|КонецЕсли|EndIf|Цикл|Do|Для|For|По|To|Пока|While|КонецЦикла|EndDo|Процедура|Procedure|КонецПроцедуры|EndProcedure|Функция|Function|КонецФункции|EndFunction|Перем|Var|Экспорт|Export|Перейти|Goto|И|And|Или|Or|Не|Not|Знач|Val|Прервать|Break|Продолжить|Continue|Возврат|Return|Контекст|Context|Далее|Forward|Попытка|Try|Исключение|Except|КонецПопытки|EndTry|ВызватьИсключение|Raise|ОписаниеОшибки|GetErrorDescription|ТекущаяИБКод|CurrentIBCode|ТекущаяИБНаименование|CurrentIBDescr|ТекущаяИБСтатус|CurrentIBStatus|ТекущаяИБЦентральная|IsCurrentIBCenter|ИБСозданияОбъекта|BirthIBOfObject|ЦентральнаяИБКод|CentralIBCode|ТекущаяИБТолькоПолучатель|IsCurrentIBRecepientOnly|ФС|FS|ЗагрузитьВнешнююКомпоненту|LoadAddIn|ПодключитьВнешнююКомпоненту|AttachAddIn|СоздатьОбъект|CreateObject|СтатусВозврата|ReturnStatus|РазделительСтраниц|PageBreak|РазделительСтрок|LineBreak|СимволТабуляции|TabSymbol|Перечисление|Enum|Константа|Const|ПланыСчетов|ChartsOfAccounts|ВидыСубконто|SubcontoKinds|ВидРасчета|CalculationKind|ГруппаРасчетов|CalculationGroup|Регистр|Register|Окр|Round|Цел|Int|Мин|Min|Макс|Max|Лог10|Log10|Лог|Ln|СтрДлина|StrLen|ПустаяСтрока|IsBlankString|СокрЛ|TrimL|СокрП|TrimR|СокрЛП|TrimAll|Лев|Left|Прав|Right|Сред|Mid|Найти|Find|СтрЗаменить|StrReplace|СтрЧислоВхождений|StrCountOccur|СтрКоличествоСтрок|StrLineCount|СтрПолучитьСтроку|StrGetLine|Врег|Upper|Нрег|Lower|OemToAnsi|AnsiToOem|Симв|Chr|КодСимв|Asc|РабочаяДата|WorkingDate|ТекущаяДата|CurDate|ДобавитьМесяц|AddMonth|НачМесяца|BegOfMonth|КонМесяца|EndOfMonth|НачКвартала|BegOfQuart|КонКвартала|EndOfQuart|НачГода|BegOfYear|КонГода|EndOfYear|НачНедели|BegOfWeek|КонНедели|EndOfWeek|ДатаГод|GetYear|ДатаМесяц|GetMonth|ДатаЧисло|GetDay|НомерНеделиГода|GetWeekOfYear|НомерДняГода|GetDayOfYear|НомерДняНедели|GetDayOfWeek|ПериодСтр|PeriodStr|НачалоСтандартногоИнтервала|BegOfStandardRange|КонецСтандартногоИнтервала|EndOfStandardRange|ТекущееВремя|CurrentTime|СформироватьПозициюДокумента|MakeDocPosition|РазобратьПозициюДокумента|SplitDocPosition|Дата|Date|Строка|String|Число|Number|Пропись|Spelling|Формат|Format|Шаблон|Template|ФиксШаблон|FixTemplate|ВвестиЗначение|InputValue|ВвестиЧисло|InputNumeric|ВвестиСтроку|InputString|ВвестиДату|InputDate|ВвестиПериод|InputPeriod|ВвестиПеречисление|InputEnum|Вопрос|DoQueryBox|Предупреждение|DoMessageBox|Сообщить|Message|ОчиститьОкноСообщений|ClearMessageWindow|Состояние|Status|Сигнал|Beep|Разм|Dim|ЗаголовокСистемы|SystemCaption|ИмяКомпьютера|ComputerName|ИмяПользователя|UserName|ПолноеИмяПользователя|UserFullName|НазваниеНабораПрав|RightName|ПравоДоступа|AccessRight|НазваниеИнтерфейса|UserInterfaceName|КаталогПользователя|UserDir|КаталогИБ|IBDir|КаталогПрограммы|BinDir|КаталогВременныхФайлов|TempFilesDir|КаталогБазыДанных|DBDir|МонопольныйРежим|ExclusiveMode|ОсновнойЯзык|GeneralLanguage|НачатьТранзакцию|BeginTransaction|ЗафиксироватьТранзакцию|CommitTransaсtion|ОтменитьТранзакцию|RollBackTransaction|ЗначениеВСтрокуВнутр|ValueToStringInternal|ЗначениеИзСтрокиВнутр|ValueFromStringInternal|ЗначениеВСтроку|ValueToString|ЗначениеИзСтроки|ValueFromString|ЗначениеВФайл|ValueToFile|ЗначениеИзФайла|ValueFromFile|СохранитьЗначение|SaveValue|ВосстановитьЗначение|RestoreValue|ПолучитьТА|GetAP|ПолучитьДатуТА|GetDateOfAP|ПолучитьВремяТА|GetTimeOfAP|ПолучитьДокументТА|GetDocOfAP|ПолучитьПозициюТА|GetAPPosition|УстановитьТАна|SetAPToBeg|УстановитьТАпо|SetAPToEnd|РассчитатьРегистрыНа|CalcRegsOnBeg|РассчитатьРегистрыПо|CalcRegsOnEnd|ВыбранныйПланСчетов|DefaultChartOfAccounts|ОсновнойПланСчетов|MainChartOfAccounts|СчетПоКоду|AccountByCode|НачалоПериодаБИ|BeginOfPeriodBT|КонецПериодаБИ|EndOfPeriodBT|КонецРассчитанногоПериодаБИ|EndOfCalculatedPeriodBT|МаксимальноеКоличествоСубконто|MaxSubcontoCount|НазначитьСчет|SetAccount|ВвестиПланСчетов|InputChartOfAccounts|ВвестиВидСубконто|InputSubcontoKind|ОсновнойЖурналРасчетов|BasicCalcJournal|ТипЗначения|ValueType|ТипЗначенияСтр|ValueTypeStr|ПустоеЗначение|EmptyValue|ПолучитьПустоеЗначение|GetEmptyValue|НазначитьВид|SetKind|ПрефиксАвтоНумерации|AutoNumPrefix|ПолучитьЗначенияОтбора|GetSelectionValues|ЗаписьЖурналаРегистрации|LogMessageWrite|КомандаСистемы|System|ЗапуститьПриложение|RunApp|ЗавершитьРаботуСистемы|ExitSystem|НайтиПомеченныеНаУдаление|FindMarkedForDelete|НайтиСсылки|FindReferences|УдалитьОбъекты|DeleteObjects|ОбработкаОжидания|IdleProcessing|ОткрытьФорму|OpenForm|ОткрытьФормуМодально|OpenFormModal|_IdToStr|_StrToID|_GetPerformanceCounter|Календари|Calendars|Метаданные|Metadata|Последовательность|Sequence|ПравилоПерерасчета|RecalculationRule)$/i


var reg_words_1C_v8=/^(Если|If|Тогда|Then|ИначеЕсли|ElsIf|Иначе|Else|КонецЕсли|EndIf|Цикл|Do|Для|For|По|To|Пока|While|КонецЦикла|EndDo|Процедура|Procedure|КонецПроцедуры|EndProcedure|Функция|Function|КонецФункции|EndFunction|Перем|Var|Экспорт|Export|Перейти|Goto|И|And|Или|Or|Не|Not|Знач|Val|Прервать|Break|Продолжить|Continue|Возврат|Return|Попытка|Try|Исключение|Except|КонецПопытки|EndTry|ВызватьИсключение|Raise|Из|In|Каждого|Each|Истина|True|Ложь|False|Null|Неопределено|Undefined|Новый|New)$/i

var reg_words_1C_v8_amp_dc=/^(НаКлиенте|НаСервере|НаСервереБезКонтекста|НаКлиентеНаСервере|НаКлиентеНаСервереБезКонтекста)(\s+)?$/i

var reg_words_1C_v8_amp_pre=/^(Если|Иначе|ИначеЕсли|КонецЕсли)/i

///////////////////////////////////////////////////////////////////////
//Окрашивает слово 1С
function colorWord(s, version){
	var kw=0;
    if(version==7){
		kw=reg_words_1C_77.test(s);
	}else if(version==8){
		kw=reg_words_1C_v8.test(s);
	}

	if(kw){
		//alert('colorWords1: '+s);
		return '<font color=red>'+s+'</font>';
	}else{
		//alert('colorWords2: '+s);
		return '<font color=blue>'+s+'</font>';
	}
}

///////////////////////////////////////////////////////////////////////
//Окрашивает код 1С, который не является словами
function colorNoWords(s){
	//alert('colorNoWords: '+s);
	s=''+s;
   	s=s.replace( /([\.\;\/\+\-\*\/\%\=\(\)\?\[\]\,]+)/g, "<font color=red>$1</font>");

	//alert('colorNoWords_: '+s);
	return s;
}

///////////////////////////////////////////////////////////////////////
//Окрашивает код 1С, который не включает комментарии, текстовые строки, даты, символы вида &gt;
function colorCode1C(s, version){
	//alert('colorCode1C: '+s);
	if(s.search(/[А-Яа-яA-Za-z_][А-Яа-яA-Za-z_0-9]*/)==-1){
		return colorNoWords(s);
	}

	var reg=/[А-Яа-яA-Za-z_][А-Яа-яA-Za-z_0-9]*/g
	var res='';
	s=' '+s+' ';
	var arr_w=s.match(reg);//Все слова 1С
	var arr_n=s.split(reg); //Все последовательности, отличные от слов

	for(var i=0; i<arr_w.length; i++){
		var n=arr_n[i];
		var w=arr_w[i];
		if(i==0) n=n.substr(1, n.length-1);//Убираем левый пробел
		res+=colorNoWords(n)+colorWord(w, version);
	}
	n=arr_n[arr_w.length];
	//alert('lastn='+n);
	n=n.substr(0, n.length-1);//Убираем правый пробел
	//alert('lastn_='+n);
	res+=colorNoWords(n);

	//alert('colorCode1C_: '+res);
	return res;
}

///////////////////////////////////////////////////////////////////////
//Окрашивает строку кода 1С
function colorString1C(s, version){
	var res='';
	var el='';
	var c='';
	var ok=0;

	if(s==''){
	//Вырожденный случай - пустая строка
		return '';
	}

	//window.status=s;
	//if(s.search(/Процедура/)!=-1){
	//   alert(s);
	//}

	s=s.replace(/\t/g, "    ");

	for(var i=0; i<s.length; i++){
		c=s.charAt(i);
		if(c>" "){
			ok=1;
			break;
		}else{
			el=el+c;
		}
	}
	res+=el;
	if(ok==0){
	//Вырожденный случай - в строке только пробелы
		return res;
	}

	s=s.replace(/\&quot\;/gi, '"');
	s=s.replace(/\&apos\;/gi, "'");
	s=s.replace(/\>\;/g, "&gt;");
	s=s.replace(/\<\;/g, "&lt;");

	if(c=="|"){
		//Строковый литерал, который начинается символом | ("труба") в начале строки
		p=s.indexOf('"', i+1);
		if(p==-1){
			//Строковый литерал, который начинается символом "труба" и не заканчивается в этой строке
			res+=s.substr(i);
			return res;
		} else {
			//Нашли закрывающую кавычку - теперь найденный строковый литерал надо поместить в массив
			res+=s.substr(i, p-i+1);
			i=p+1;
		}
	}else if(c=="#"){
		//Директива препроцессора
		var dpre = reg_words_1C_v8_amp_pre.test(s.substr(i+1));
		if (dpre) {
			res += '<font color=brown>'+s.substr(i)+'</font>';
		} else {
			res+=s.substr(i);
		}
		return res;
	}else if(c=="&"){
		var reg_words_amp = /^\&amp\;/i
		var marp = 1;

		if (reg_words_amp.test(s.substr(i))) {
			marp = 5;
		}

		var dc = reg_words_1C_v8_amp_dc.test(s.substr(i+marp));

		if (dc !== false) {
			res += '<font color=brown>'+s.substr(i)+'</font>';
			return res;
		}
	}

	while(i<s.length){

	//Теперь i указывает на позицию, которая заведомо не является строковым литералом или директивой
		var pstr=s.indexOf('"', i);
		var pcom=s.indexOf('//', i);
		var pdat=s.indexOf("'", i);
		var pspec=s.indexOf("&", i); //последовательности наподобие &lt; &gt; &amp; и т.д.

		//Выявляем наименьшее неотрицательное значение, остальным присваиваем -1

		if(pcom!=-1 && pdat!=-1){
			if(pcom<pdat){pdat=-1} else {pcom=-1};
		}
		if(pcom!=-1 && pstr!=-1){
			if(pcom<pstr){pstr=-1} else {pcom=-1};
		}
		if(pcom!=-1 && pspec!=-1){
			if(pcom<pspec){pspec=-1} else {pcom=-1};
		}

		if(pdat!=-1 && pstr!=-1){
			if(pdat<pstr){pstr=-1} else {pdat=-1};
		}
		if(pdat!=-1 && pspec!=-1){
			if(pdat<pspec){pspec=-1} else {pdat=-1};
		}

		if(pstr!=-1 && pspec!=-1){
			if(pstr<pspec){pspec=-1} else {pstr=-1};
		}

		if(pcom!=-1){
			//Обнаружен комментарий
			//строка, предш. комментарию
			res+=colorCode1C(s.substr(i, pcom-i), version);
			//сам комментарий
			res+='<font color=green>'+s.substr(pcom)+'</font>';
			return res;
		} else if(pstr!=-1){
			//Найден строковый литерал
			//строка, предш. литералу
			res+=colorCode1C(s.substr(i, pstr-i), version);
			var p=s.indexOf('"', pstr+1);
			if(p==-1){
				//Строковый литерал, который не заканчивается в этой строке
				res+=s.substr(pstr);
				return res;
			} else {
				//Нашли закрывающую кавычку
				el=s.substr(pstr, p-pstr+1);
				//alert(el);
				res+=el;
				i=p+1;
			}
		} else if(pdat!=-1){
			//Найден литерал даты, например, '01.01.2008'
			res+=colorCode1C(s.substr(i, pdat-i), version);//строка, предш. литералу
			var p=s.indexOf("'", pdat+1);
			if(p==-1){
				//Ошибочный литерал даты, который не завершается на этой строке
				res+=s.substr(pdat);
				return res;
			} else {
				//Нашли закрывающую кавычку
				res+=s.substr(pdat, p-pdat+1);
				i=p+1;
			}
		} else if(pspec!=-1){
			res+=colorCode1C(s.substr(i, pspec-i), version);//строка, предш. литералу

			var p=s.indexOf(";", pspec+1);

			//Отследим ошибочные случаи
			var p1=s.indexOf(" ", pspec+1);
			if(p1!=-1){
				if(p1<p) p=p1;
			}
			var p1=s.indexOf("\t", pspec+1);
			if(p1!=-1){
				if(p1<p) p=p1;
			}

			if(p==-1){
				//Ошибочный литерал
				el=s.substr(i);
				arr.push(el);
				return arr;
			} else {
				//Нашли закрывающий ; или (при ошибке) пробел
				el=s.substr(pspec, p-pspec+1);
				if(el=='&gt;' || el=='&lt;'){
					res+='<font color=red>'+el+'</font>';
				}else{
					res+=el;
				}
				i=p+1;
			}
		} else {
			//Не найден ни строковый литерал, ни комментарий, ни дата, ни спецсимвол
			res+=colorCode1C(s.substr(i), version);
			return res;
		}

    }
	return res;
}

///////////////////////////////////////////////////////////////////////
function colorAllCode1C(s, version){


	var arr1=s.split("\n");
	var res='';
	for (var i=0; i<arr1.length; i++){
		var s1=arr1[i];
		//alert(s1);
		res+=colorString1C(s1, version)+"\n";
	}
	return res;
}

///////////////////////////////////////////////////////////////////////
function colorObj(obj){
	if(!obj) return;
	var attr=obj.getAttribute("LANG");
    if($(obj).hasClass("hightlight-1c")){
        $(obj).find("br").remove();
    }
	if(attr=="1Cv77"){

		var s=obj.innerHTML;
		obj.innerHTML="<PRE>"+colorAllCode1C(s,7)+"</PRE>";

	}else if(attr=="1Cv8" || $(obj).hasClass("hightlight-1c")){
		var s=obj.innerHTML;
		obj.innerHTML="<PRE>"+colorAllCode1C(s,8)+"</PRE>";
	}
}


///////////////////////////////////////////////////////////////////////
//Основной код функции окраски кода 1С

	if (highlight1c_inited === false) {
		if(prm_id==""){
			var arr = document.getElementsByTagName('PRE');
			for(var i=0; i<arr.length; i++){
				var obj=arr[i];
				colorObj(obj);
			}
		} else {
			var obj=document.getElementById(prm_id);
			colorObj(obj);
		}
		highlight1c_inited = true;
	}
}

/* End */
;
; /* Start:/bitrix/templates/.default/components/infostart/public.detail.new/adaptive/script.js*/
$(document).ready(function () {


    $( ".videoSelector" ).click(function(){
        frame = $(this).data("frame");
        start = $(this).data("start");
        stop  = $(this).data("stop");
        src = $('#'+frame).attr("src");
        var a = document.createElement('a');
        a.href = src;
        base_url = a.protocol + '//' + a.hostname + a.pathname
        str = '';
        if(start){
            str = '?start=' + start;
            if(stop){
                str += '&stop=' + stop;
            }
        }
        else{
            if(stop){
                str = '?stop=' + stop;
            }
        }
        if(str){
            url = base_url + str;
            //console.log(url)
            document.getElementById(frame).src = url;
        }
        return false;
    });


    $(".open-share").hover(function(){
        var el = $(this);
        if(el.hasClass('have-ref')){
            return;
        }

        var p = el.find('.popover');
        if(p.length == 0) {
            el.append('<div class="popover popover-share bottom" role="tooltip"  style=""><div class="arrow"></div><div class="popover-content">Агентское вознаграждение до 25% от суммы покупок ваших пользователей без ограничения по времени. <a href="/profile/partner/web/about/" target="_blank">Подробнее о программе.</a></div></div>');
            p = el.find('.popover');
        }
        p.show();
    });
    $(".open-share").mouseleave(function(){
        var el = $(this);
        var p = el.find('.popover');
        if(p)
            p.hide();
    });

    $(".open-share").on('click', 'a', function(event){
        event.stopPropagation();
    });

    function ticket_modal_form(title, type){
        if(type === undefined){
            type = '';
        }

        var new_div = $('form[name="support_edit"]').parent().clone();
        new_div.find('form').attr('name','support_edit_modal').prepend("<input type='hidden' name='TICKET_TYPE' value='"+type+"'>");
        new_div.find('[name=TITLE]').parents('tr').remove();
        new_div.find('h1').html(title);
        new_div.find('#TRANSLIT').remove();
		$recaptcha = new_div.find('.g-recaptcha');
		if ($recaptcha.length > 0) {
			new_div.find('.g-recaptcha').html("").attr("id", "g-recaptcha-up");
		}
        var html = new_div.html();
        html = html.replace(new RegExp("document.forms\\['support_edit'\].elements\\['MESSAGE'\]\\)", 'ig'), "document.forms['support_edit_modal'].elements['MESSAGE'], 'support_edit_modal')");
        $('#modal-ticket .modal-body-content').html(html);
        $('#btn-modal-ticket').click();
		if ($recaptcha.length > 0) {
			grecaptcha.render('g-recaptcha-up', {sitekey: $recaptcha.data('sitekey')});
		}
		$('#modal-ticket .modal-body-content').find('form').validate({
			rules: {
				NEW_EMAIL: {
					required: true,
					email: true
				},
				USER_PASSWORD: "required",
				MESSAGE_INPUB: "required"
			},
			messages: {
				NEW_EMAIL: {
					email: 'Укажите корректный E-mail'
				}
			},
			errorPlacement: function (error, element) {
				error.insertAfter(element.parent());
			},
			submitHandler: function (form) {
				if (window.form_Pauth_lock)
					return;
				window.form_Pauth_lock = true;
				let $objAuth = $(".AUTHFINGER");
				if ($objAuth.length > 0 && $objAuth.val() == "" && typeof Fingerprint2 == "function") {
					Fingerprint2.getV18({}, function (result, components) {
						$objAuth.val(result);
						form.submit();
					});
				} else {
					form.submit();
				}
			}
		});

    }

    $('.right-side').on('click', '.btn-public-ticket-ask-question', function(){
        ticket_modal_form('Новый вопрос', 'public_question');
        return false;
    }).on('click', '.btn-public-ticket-support', function(){
        ticket_modal_form('Новый тикет', 'public_support');
        return false;
    });

	$('.detail-public-wrap').on('click', '.AddToBlock', function (){
		var bid = $(this).attr('data-bid');
		$.ajax({
			url: '/bitrix/ajax/kurs_blocks.php?ACTION=ADD_TO_FREE_BLOCK',
			type: 'get',
			data: {BLOCK_ID: bid, sessid: BX.bitrix_sessid()},
			success: function(arResult){
				if(arResult.ERROR){
					$.smallBox({
						title : "Ошибка!",
						content : arResult.ERROR,
						color : "#C46A69",
						icon : "fa fa-warning shake animated",
						timeout : 10000
					});
				}else{
					$.smallBox({
						title : "Спасибо!",
						content : "Вы успешно зпаписаны.",
						color : "#659265",
						icon : "fa fa-check fadeInRight animated",
						timeout : 4000
					});
				}
			}
		});
		return false;
	});
	window.partform_sended = false;
	$(document).on("click", "#btn-submit-partform", function() {
		if (window.partform_sended)
			return false;
		window.partform_sended = true;
		$('#form-request-wrap-iwp').submit();
		return false;
	});
    $("#form-request-wrap-iwp").submit(function(){
        $("#form-request-wrap-iwp input, #form-request-wrap-iwp textarea").css('border-color','');
        formData = new FormData($("#form-request-wrap-iwp").get(0));
        $.ajax({
            url: '/ajax/send_landing_form.php?ACTION=SEND_FORM&RESPONS=IWP-REQUEST',
            type: 'post',
            contentType: false,
            processData: false,
            data: formData,
            dataType: 'json',
            success: function(arResult){
                if(arResult.ERROR){
                    $("#form-request-wrap-iwp input[name="+arResult.FIELD+"], #form-request-wrap-iwp textarea[name="+arResult.FIELD+"]").css('border-color','#e4aeae');
                }else{
                    $(".send-request-body .form-wrap").hide();
                    $(".send-request-body .success-message").show().find('p.message-success').append('Ваше обращение зарегистрировано и ему присвоен номер <b>'+arResult.OK+'</b>. Дальнейшие инструкции отправлены на ваш email адрес.');
                }
			},
			complete: function () {
				window.partform_sended = false;
			}
        });
        return false;
    });
    $(".scroll-to").click(function() {
        $('html, body').animate({
            scrollTop: $("#tbl-prods").offset().top
        }, 1000);
        return;
    });
    $(".open-modal-feedback").click(function () {
        $("#form-request-wrap-iwp [name=PRODUCT_NAME]").val($("h1.main-title").text());
        $("#form-request-wrap-iwp [name=PUB_ID]").val($("#id").val());
        $("#form-request-wrap-iwp textarea").val($("#form-request-wrap-iwp textarea").val()+($("#form-request-wrap-iwp textarea").val().length>1?'\r':'')+$(this).parents('tr').children("td.name").children(".posts_txt").text());
        $("[data-target='.send-request-form-partner']").click();
        return false;
    });


	window.fileform_sended = false;
	$(document).on("click", "#btn-submit-fileform", function() {
		if (window.fileform_sended)
			return false;
		window.fileform_sended = true;
		$('#form-request-wrap-file').submit();
		return false;
	});
	$("#form-request-wrap-file").submit(function(){
		$("#form-request-wrap-file input, #form-request-wrap-file textarea").css('border-color','');
		formData = new FormData($("#form-request-wrap-file").get(0));
		$.ajax({
			url: '/ajax/send_landing_form.php?ACTION=SEND_FORM&DETAIL_PAGE=Y&RESPONS=landing-gifts',
			type: 'post',
			contentType: false,
			processData: false,
			data: formData,
			dataType: 'json',
			success: function(arResult){
				if(arResult.ERROR){
					$(".send-request-form-file input[name="+arResult.FIELD+"], #form-request-wrap-file textarea[name="+arResult.FIELD+"]").css('border-color','#e4aeae');
				}else{
					$(".send-request-form-file .send-request-body .form-wrap").hide();
					$(".send-request-form-file .send-request-body .success-message").show().find('p.message-success').append('Ваше обращение зарегистрировано и ему присвоен номер <b>'+arResult.OK+'</b>. Дальнейшие инструкции отправлены на ваш email адрес.');
				}
			},
			complete: function () {
				window.fileform_sended = false;
			}
		});
		return false;
	});

	$(".open-modal-feedback-file").on("click", function () {
		var NewName = $(this).parents('tr').find("td.name .posts_txt").text();
		if(NewName.length > 0)
			$("#form-request-wrap-file [name=PRODUCT_NAME]").val(NewName);

		var addText = $("#form-request-wrap-file textarea").val();
		if ($("#form-request-wrap-file textarea").val().length>1)
			addText = addText + '\r';
		$("#form-request-wrap-file textarea").val(addText + NewName);
		$(".send-request-form-file").modal();
		return false;
	});

	$('.js-add-friend:not(".disabled")').on("click", function(){
		var UID = $(this).data('uid');
		var $OBJ = $(this);
		var ACTION = $OBJ.data("action");

		if (!UID) {
			return;
		}

		$(this).addClass('disabled');
		$.post('/bitrix/ajax/friends.php',
			{ACTION:ACTION, UID:UID, SESSID:BX.bitrix_sessid()},
			function(arResult){
				if (arResult.TYPE == 'SUCCESS') {
					$OBJ.children(".button-text").html(arResult.MESSAGE);
				} else {
					$.smallBox({
						title: "Ошибка",
						content: arResult.MESSAGE,
						color: "#C46A69",
						icon: "fa fa-warning animated",
						timeout: 4000
					});
					$OBJ.removeClass('disabled');
				}
		}, 'json');
	});

    initSurfLink($("#id").val());

	$(".add-to-marketplace-request-demo").on("click", function () {
		let obj = $(this);
		$.post(
			"",
			{
				"SESSID": BX.bitrix_sessid(),
				"ACTION": "addToMarketplaceRequestDemo",
				"AJAX": "Y",
				"PRODUCT_ID": obj.data("marketplace_product_id"),
				"SILENT": obj.data("marketplace_silent"),
                "UF_BTN_TYPE": Number(obj.data("type-btn") !== 'request_demo')
			},
			function (arAnswer) {
				if (arAnswer.TYPE === "SUCCESS" && arAnswer.MESSAGE.length > 0) {
					$.smallBox({
						title: "Успешно!",
						content: arAnswer.MESSAGE,
						color: "#659265",
						icon: "fa fa-check fadeInRight animated",
						timeout: 4000
					});
				}
			},
			"json"
		);
	});

    $('a[href^="#"]').click(function() {
        var el = $(this).attr('href');
        var spoiler = $(el).closest('.spoiler');
        var spoilerToggle = $(spoiler).find('.spoiler-toggle');
        if ($(spoilerToggle).hasClass('show-icon')) {
            $(spoiler).find('.spoiler-content').show();
            $(spoilerToggle).removeClass('show-icon');
            $(spoilerToggle).addClass('hide-icon');
        }
        $('body').scrollTo(el);
        return false;
    });
});


function initSurfLink(curVal){

    curVal =  (curVal === undefined) ? false : 1*curVal;
    let arSurfJson = $.cookie('FilterResultLast');
    let arSurf = false;
    let htmlStr = '';
    try { arSurf = JSON.parse(arSurfJson); } catch(e) { arSurf = false; }
    let curKey = 0;

    if(!!curVal && !!arSurf){
        curKey = arSurf.indexOf(curVal);
    }

    if(!!arSurf) {
        htmlStr += '<div id="surflink" style="padding:0;transform: translateY(-50%);position: absolute;right: 0;top: 50%;"><div style="z-index:100;background: rgba(255, 255, 255, 0.9);padding:3px;">';
        if (arSurf[curKey - 1] !== undefined) {
            htmlStr += '<a class="btn btn-default btn-sm" title="Предыдущая публикация из поиска" href="/public/' + arSurf[curKey - 1] + '/"><i class="fa fa-angle-left" aria-hidden="true"></i></a> ';
        }
        if (arSurf[curKey + 1] !== undefined) {
            htmlStr += '<a class="btn btn-default btn-sm" title="Следующая публикация из поиска" href="/public/' + arSurf[curKey + 1] + '/"><i class="fa fa-angle-right" aria-hidden="true"></i></a>';
        }
        htmlStr += '</div></div>';

        $("[data-place-surflink]").attr("style", "position:relative").append(htmlStr);
    }

    $(document).on("keydown", function(e){
        if(!e) return;
        if (false && e.shiftKey && (e.keyCode === 37 || e.keyCode === 39))
        {
            if(e.keyCode === 37){

                // prevLink
                if(arSurf[curKey-1] !== undefined){
                    $.smallBox({
                        title : "Переход",
                        content : "К предыдущей публикации",
                        color : "#739E73",
                        icon : "fa fa-check",
                        timeout : 1000
                    },function(){
                        location.href = '/public/'+arSurf[curKey-1];
                    });
                }

            } else if(e.keyCode === 39){
                // nextLink
                if(arSurf[curKey + 1] !== undefined) {

                    $.smallBox({
                        title: "Переход",
                        content: "К следующей публикации",
                        color: "#739E73",
                        icon: "fa fa-check",
                        timeout: 1000
                    }, function () {
                        location.href = '/public/' + arSurf[curKey + 1];
                    });
                }
            }
            //console.log(e.keyCode);
            //$.cookie('ShowGrid'+window.COMPONENT_ID, TYPE, { expires: 666, path: '/' });
        }
    });


}



var ActiveDwonloadButton = false;
function CheckDownloadResult(data){
    if(data.search(/\<iframe/) > -1){
        $("#DownloadFileModal, .modal-backdrop").remove();
        $('body').append(data);
        $(ActiveDwonloadButton).removeClass("btn-default btn-default btn-default btn-default").addClass("btn-default disabled").attr('href','javascript:void(0);').find(".button-text").html("Отправлено на email");
        $('body').removeClass("modal-open");
        return true;
    }

    return false;
}
$(document).ready(function(){

        $(".download-ajax").click(function () {
            ActiveDwonloadButton = $(this);
            $("#DownloadFileModal").remove();
            var href = $(this).attr('href').replace('/public/download.php',"/bitrix/ajax/download_page.php");
            $.get(href,function(data){
                $(data).modal();
                CheckDownloadResult(data);
            });
            return false;
        });

    $(document).on('click','#DownloadFileModal a',function(e){
        if($(this).attr("data-pub_id")) {
            $("#DownloadFileModal, .modal-backdrop").remove();
            return;
        }
        if(!$(this).attr("data-noajax")) {
            var href = $(this).attr('href');
            $.get(href, function (data) {
                if (data == "AUTH_PAY"){
                    $('#modal').modal('toggle');
                    location.href = '/public/download/?p=auth_pay'
                        +($("input[name=pub]").val()?'&pub='+$("input[name=pub]").val():'')
                        +($("input[name=file]").val()?'&file='+$("input[name=file]").val():'');
                    return;
                }
                if (data == "AUTH_OLD_PAY"){
                    $('#modal').modal('toggle');
                    location.href = '/public/download/?p=auth_old_pay'
                        +($("input[name=pub]").val()?'&pub='+$("input[name=pub]").val():'')
                        +($("input[name=file]").val()?'&file='+$("input[name=file]").val():'');
                    return;
                }
                $("#DownloadFileModal .modal-content").html($(data).find(".modal-content"));
                CheckDownloadResult(data);

            });
            return false;
        }

    });
    $(document).on('submit','#DownloadFileModal form',function(e){
        var FormData = $("#DownloadFileModal form").serialize()
        var href = $("#DownloadFileModal #CurrentPage").val()+'&'+FormData;
        $.get(href,function(data){
            if (data == "AUTH_OLD_PAY"){
                $('#modal').modal('toggle');
                location.href = '/public/download/?p=auth_old_pay'
                    +($("input[name=pub]").val()?'&pub='+$("input[name=pub]").val():'')
                    +($("input[name=file]").val()?'&file='+$("input[name=file]").val():'');
                return;
            }
            if (data == "AUTH_PAY"){
                $('#modal').modal('toggle');
                location.href = '/public/download/?p=auth_pay'
                    +($("input[name=pub]").val()?'&pub='+$("input[name=pub]").val():'')
                    +($("input[name=file]").val()?'&file='+$("input[name=file]").val():'');
                return;
            }
            $("#DownloadFileModal .modal-content").html($(data).find(".modal-content"));
            CheckDownloadResult(data);
        });
        return false;
    });


    $(".rate-need-auth, .onec-adm-need-auth").click(function(e){
        var backurl = $(this).attr("data-backurl");
        $.smallBox({
            title : "Ошибка!",
            content : "Необходимо авторизоваться для использования данного функционала. Хотите сделать это прямо сейчас?<p class='text-align-right'><a href='/auth/?backurl="+backurl+"' class='btn btn-default btn-sm'>Да</a> <a href='javascript:void(0);' class='btn btn-default btn-sm'>Нет</a></p>",
            color : "#C46A69",
            icon : "fa fa-warning shake animated",
            timeout : 10000
        });

        e.preventDefault();
        return false;
    });
    $(".onec-adm-need-abon").click(function(e){
        if($(this).hasClass('onec-adm-need-auth')) return false;
        $.smallBox({
            title : "Ошибка!",
            content : "Подключите сервис 1С-Администратор. Хотите сделать это прямо сейчас?<p class='text-align-right'><a href='https://its.1c.ru/db/aboutitsnew/content/23/hdoc' class='btn btn-default btn-sm'>Да</a> <a href='javascript:void(0);' class='btn btn-default btn-sm'>Нет</a></p>",
            color : "#C46A69",
            icon : "fa fa-warning shake animated",
            timeout : 10000
        });

        e.preventDefault();
        return false;
    });
    $(".rate-personal-public").click(function(){
        var backurl = $(this).attr("data-backurl");
        $.smallBox({
            title : "Ошибка!",
            content : "Вы не можете проголосовать за свою публикацию.",
            color : "#C46A69",
            icon : "fa fa-warning shake animated",
            timeout : 10000
        });

        e.preventDefault();
        return false;
    });

	$(".price-size").hover(function(){
		$(this).next(".cont_none").show();
	},function(){
		$(this).next(".cont_none").hide();

	});
	$('[data-id="button-copy-link"]').click(function(event) {
        $(this).next().toggle();
        $(this).next().find('[data-id="copylink"]').select().focus();
		return false;
    });

	$('[data-id="copylink"]').click(function() {
		$(this).select();
    });

	$('[data-id="copylinkhtml"]').click(function() {
		$(this).select();
    });
    $(document).click(function (event) {
        if ($(event.target).closest('[data-id="copy-link-block"]').length == 0 && $(event.target).attr('data-id') != 'button-copy-link') {
            $('[data-id="copy-link-block"]').hide();
        }
    });

    $(".show-all-props").click(function(){
        $(".properties.hidden2").slideToggle();
        var NewVal = $(this).html();
        var OldVal = $(this).attr("data-text");
        $(this).html(OldVal).attr("data-text",NewVal);
    });
    $(".other-public-pagen > a.show").click(function(){
        $(".other-public-wrap > a.hidden2").css('display', 'inline-block').hide().slice(0, 3).slideDown("fast").removeClass("hidden2");
        if($(".other-public-wrap > a.hidden2").length <= 0){
            $(this).parent().hide();
        }
    });

    $(".screen-additional li").click(function(){
        $(".screen-wrap .sreen-main").css("background-image","url('"+$(this).attr("data-bigurl")+"')");
        $(".screen-wrap .screen-main-zoom").attr({"data-nn":$(this).attr("data-nn")});
    });
    $(".screen-main-zoom").click(function(){
        var screens  = new Array();
        $(".gallery-image").each(function(){
            href = $(this).attr("href");
            title = $(this).attr("title");
            screens.push({'href': href, 'title': title})
        });
        var Count = $(this).attr("data-nn");
        $.fancybox(screens,{
            index		: Count,
            prevEffect 	: 'elastic',
            nextEffect 	: 'elastic',
            nextClick 	: true,
            padding		: 0,
            closeBtn  	: true,
            helpers 	: {
                thumbs : {
                    width  : 100,
                    height : 100
                }
            }
        });
    });

    $(".open-demo").click(function(){
        $.fancybox({type: 'iframe',href:$(this).attr("data-url"),padding:0,width:'90%',height: '90%', minWidth:1000, minHeight: 600,});
    });

    //$("#requisition-demo-btn").modal();

    $(".open-edit-box").click(function(){
        $(".edit-props-wrap").hide();
        $(this).prev(".edit-props-wrap").fadeToggle();
        $(this).hide();
    });

    $(".save-props-pub").click(function(){
        var select = $(this).prev("select");
        var name = select.attr("name");
        var stringToWrap = '';
        var stringToEdit = '';
        const validateSelect = checkSelectParams(select);

        if (validateSelect.result === 'error') {
            $.smallBox({
                title: "Ошибка!",
                content: validateSelect.error_text,
                color: "#C46A69",
                icon: "fa fa-warning fadeInRight animated",
                timeout: 4000
            });
            return false;
        }

        $(this).prev("select").children("option:selected").each(function(){
            switch (name){
                case 'SECTION_ID':
                    stringToWrap += '<a href="/public/?rubric='+$(this).attr("value")+'">'+$(this).html().replace(/ \. /g,'')+'</a>,<br/> ';
                    break
                case 'checked':
                    stringToWrap += '<a>'+$(this).html()+'</a>';
                    break
                default:
                    stringToWrap += '<a href="/public/?'+ name +'['+$(this).attr("value")+']='+$(this).attr("value")+'">'+$(this).html()+'</a>,<br/> ';
            }
            stringToEdit += $(this).attr("value")+',';
        });
	    $("body").append("<div id='overlay-loading-fixed'><i class='fa fa-spinner fa-spin'></i></div>");
	    $.get("/ajax/edit_prop.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&code="+name+"&val="+stringToEdit+"&type=pub",function(){
		    $("body").find('#overlay-loading-fixed').remove();
	    });
	    $(this).parent().prev(".props-list-wrap").html(stringToWrap);
        $(this).parent(".edit-props-wrap").next(".open-edit-box").show();
        $(this).parent(".edit-props-wrap").fadeOut();
    });

    $('#class_not_mater').click(function(){
        var newVal = {};
        $.each($('.edit-props-wrap option[data-code=no]'), function(){
                $(this).parent().val($(this).val());
                name = $(this).parent().attr('name');
                if(name == "CONFIG"){
                    stringToWrap = '<a href="/public/?class_'+ name +'['+$(this).val()+']='+$(this).val()+'">'+$(this).html()+'</a>';
                }else{
                    stringToWrap = '<a href="/public/?'+ name +'['+$(this).val()+']='+$(this).val()+'">'+$(this).html()+'</a>';
                }
                $(this).parent().parent().prev(".props-list-wrap").html(stringToWrap);
                newVal[name] = $(this).val();
        });
        $.get('/ajax/edit_prop.php', {
            id: $("#id").val(),
            sessid: $("#ssid").val(),
            codeAr: newVal
        });
        $(this).parent("li").remove();
        return false;
    });

    $(".slide-to-comment").click(function(){
        $('html, body').animate({scrollTop: $(".comments-title").offset().top - 48}, 500);
		return false;
    });
    $(".down-to-comment").click(function(){
        $('html, body').animate({scrollTop: $("#com0").offset().top - 48}, 500);
        return false;
    });
    $(".down-public-link").click(function(){
        $('html, body').animate({scrollTop: $("#REPLIER").offset().top - 48}, 500);
		return false;
    });

/*
	window.ButtLock = false;
    window.buttonRateInAction = false;
    window.lastRate = 0;

    function reloadPopover(obj){
        $.ajax({
            type: "GET",
            cache: false,
            url: '/bitrix/ajax/user_fav_folders.php',
            data: {pid: $("input#id").val()},
            success: function(data){
                if($(document).find('.popover-fav').length > 0){
                    $(document).find('.popover-fav .popover-content').html(data);
                }else{
					obj.popover('destroy');
					obj.popover({
                        html : true,
                        placement : 'bottom',
                        sanitize : false,
                        content : data,
                        template: '<div class="popover popover-fav" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
                        trigger: 'manual',
                    }).on('shown.bs.popover', function () {
						window.ButtLock = true;

					}).on('hidden.bs.popover', function () {
						window.ButtLock = false;
					});

					obj.popover('show');
                }
            }
        });
    }

    $('body').on('click', function (e) {
        if (
            $('.popover-fav.in').length > 0 && !$(e.target).hasClass('js-popover')
            && $(e.target).parents('.js-popover').length === 0 && $(e.target).parents('.popover-fav.in').length === 0
            && !$(e.target).hasClass('divMessageBox') && $(e.target).parents('.divMessageBox').length === 0) {
			$('.js-popover').popover('hide');
        }
    });



    $(document).on('click ontouchstart', '.add-fav', function(){
            if(!window.buttonRateInAction) {
                window.buttonRateInAction = true;
                $.get("/ajax/pub_rate.php?id=" + $("#id").val() + "&sessid=" + $("#ssid").val() + "&type=p&folder_id=" + $(this).attr('data-id'), function (answer) {
                    if (answer == "ok") {
                        if(window.lastRate <= 0) {
                            window.lastRate += 1;
                            $(".open-rating-table").html(parseInt($(".open-rating-table").html(), 10) + 1);
                        }
                        $.smallBox({
                            title: "Спасибо!",
                            content: "Ваш голос принят.",
                            color: "#659265",
                            icon: "fa fa-check fadeInRight animated",
                            timeout: 4000
                        });
                        $(".soc-butt-infostart,.soc-butt-infostart2").addClass("rated");
                        $(".soc-btn-unrate").removeClass("rated");

                    } else {
                        $.smallBox({
                            title: "Ошибка!",
                            content: answer,
                            color: "#C46A69",
                            icon: "fa fa-warning fadeInRight animated",
                            timeout: 4000
                        });
                    }
                    $('.js-popover.auth').popover('hide');
                    window.buttonRateInAction = false;
                });
            }
    });

    $(document).on('click', '.add-fav-folder', function(){
        $.SmartMessageBox(
            {
                title : "Внимание!",
                content : "Создать новую папку?",
                buttons : '[Нет][Да]',
                input : "text",
                inputValue : '',
                placeholder : "Имя папки"
            },
            function(ButtonPressed, Value) {
                if (ButtonPressed === "Да") {
                    if(!Value){
                        return false;
                    }
                    if(!window.buttonRateInAction) {
                        window.buttonRateInAction = true;
                        $.get("/ajax/pub_rate.php?id=" + $("#id").val() + "&sessid=" + $("#ssid").val() + "&type=p&new_folder=" + Value, function (answer) {
                            if (answer == "ok") {
                                if(window.lastRate <= 0) {
                                    window.lastRate += 1;
                                    $(".open-rating-table").html(parseInt($(".open-rating-table").html(), 10) + 1);
                                }
                                $.smallBox({
                                    title: "Спасибо!",
                                    content: "Ваш голос принят.",
                                    color: "#659265",
                                    icon: "fa fa-check fadeInRight animated",
                                    timeout: 4000
                                });
                                $(".js-popover").addClass("rated");
                                $(".soc-btn-unrate").removeClass("rated");
                            } else {

                                $.smallBox({
                                    title: "Ошибка!",
                                    content: answer,
                                    color: "#C46A69",
                                    icon: "fa fa-warning fadeInRight animated",
                                    timeout: 4000
                                });
                            }
                            window.buttonRateInAction = false;
                        });
                    }
                }
                if (ButtonPressed === "Нет") {
                    return false;
                }
				$('.js-popover.auth').popover('hide');
            }
        )
    });


    $(".js-popover.auth").on('click', function(){
        if(!window.ButtLock){
            if($(this).hasClass("rated")){
                $.get("/ajax/pub_rate.php?id="+$("#id").val()+"&sessid="+BX.bitrix_sessid()+"&type=m",function(answer){
                    if(answer == "ok"){
                        if(window.lastRate >= 0) {
                            window.lastRate -= 1;
                            $(".open-rating-table").html(parseInt($(".open-rating-table").html(), 10) -1);
                        }
                        $.smallBox({
                                title : "Спасибо!",
                                content : "Ваш голос отменен.",
                                color : "#659265",
                                icon : "fa fa-check fadeInRight animated",
                                timeout : 4000
                            });
						$(".js-popover").removeClass("rated");
                    } else {
						$.smallBox({
							title : "Ошибка!",
							content : answer,
							color : "#C46A69",
							icon : "fa fa-warning fadeInRight animated",
							timeout : 4000
						});
					}
					$('.js-popover.auth').popover('hide');
                });
            }else{
				reloadPopover($(this));
            }
        }
    });

    var uButtLock = false;
    $(".soc-btn-unrate.auth").click(function(){
        if(!uButtLock){
			uButtLock = true;
            $.get("/ajax/pub_rate.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&type=m",function(answer){

                    if(answer == "ok"){
                        if(window.lastRate >= 0) {
                            window.lastRate -= 1;
                            $(".open-rating-table").html(parseInt($(".open-rating-table").html(), 10) -1);
                        }
						$(".soc-butt-infostart,.soc-butt-infostart2").removeClass("rated");
						$(".soc-btn-unrate").addClass("rated");
						$.smallBox({
                            title : "Спасибо!",
                            content : "Ваш отрицательный голос принят.",
                            color : "#659265",
                            icon : "fa fa-check fadeInRight animated",
                            timeout : 4000
                        });

					} else {

						$.smallBox({
							title : "Ошибка!",
							content : answer,
							color : "#C46A69",
							icon : "fa fa-warning fadeInRight animated",
							timeout : 4000
						});

					}

				uButtLock = false;
            });
        }
    });
	*/



    $(".open-share").click(function(){
        var w = 640;
        var h = 480;
        var left = Number((screen.width/2)-(w/2));
        var tops = Number((screen.height/2)-(h/2));
        window.open(this.href, '', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+tops+', left='+left);
        return false;
    });

    $(".send-message").click(function(){
        if (BX.IM){
            BXIM.openMessenger(parseInt($(this).attr("data-uid"),10));
        }
        return false;
    });
    $(".open-showed-table").click(function(){
        $.fancybox({type: 'iframe',href:'/ajax/public_tables.php?id='+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=showed",padding:0});
        return false;
    });
    $(".open-downloads-table").click(function(){
        $.fancybox({type: 'iframe',href:'/ajax/public_tables.php?id='+$("#id").val()+"&sessid="+$("#ssid").val()+"&fid="+$(this).attr("data-fid")+"&action=downloads",padding:0});
        return false;
    });
    $(".open-rating-table").click(function(){
        $.fancybox({type: 'iframe',href:'/ajax/public_tables.php?id='+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=rating",padding:0});
        return false;
    });
    /*--Menu Handlers--*/
    $(document).on("click", "a.invite-to-friends", function() {
        $.get("/ajax/friends.php?id="+$(this).attr("data-uid")+"&sessid="+$("#ssid").val()+"&type=a");
        $(this).html("Запрос дружбы").removeClass("invite-to-friends").addClass("delete-from-friends");
        return false;
    });

    $(document).on("click", "a.delete-from-friends", function() {
        $.get("/ajax/friends.php?id="+$(this).attr("data-uid")+"&sessid="+$("#ssid").val()+"&type=d");
        $(this).html("+ Добавить в друзья").removeClass("delete-from-friends").addClass("invite-to-friends");
        return false;
    });

    $(document).on("click", "a.add-expert-choose", function() {
        selected_date = $('#date_from').val();
        $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sdate="+selected_date+"&sessid="+$("#ssid").val()+"&action=add_expert_choose");
        $(this).html("Убрать выбор экспертов").removeClass("add-expert-choose").addClass("del-expert-choose");
    });

    $(document).on("click", "a.del-expert-choose", function() {
        $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=del_expert_choose");
        $(this).html("Выставить выбор экспертов").removeClass("del-expert-choose").addClass("add-expert-choose");
    });

    $(document).on("click", "a.set-public-m", function() {
        $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=set_public_m");
        $(this).html("Опубликовать").removeClass("set-public-m").addClass("set-public-y");
    });

    $(document).on("click", "a.set-public-y", function() {
        $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=set_public_y");
        $(this).html("Отправить на модерирование").removeClass("set-public-y").addClass("set-public-m");
    });

    $(document).on("click", "a.send-to-m", function() {
        $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=send_to_m");
        $(this).html("Отправлено на модерацию").removeClass("send-to-m").removeAttr("href");
    });

    $(document).on("click","#setSpecialPublic",function () {
        var stringToWrap = '';
        var stringToEdit = '';
        $(this).prev("select").children("option:selected").each(function(){
            stringToWrap += '<a href="'+$(this).attr("data-link")+'">'+$(this).html()+'</a>,<br/>';
            stringToEdit += $(this).attr("value")+',';
        });
        $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=setSpecial&specialId="+stringToEdit,function(){});
        $(this).parent().prev(".props-list-wrap").html(stringToWrap);
        $(this).parent(".edit-props-wrap").next(".open-edit-box").show();
        $(this).parent(".edit-props-wrap").fadeOut();
    });
    /*
    $(document).on("change","#setSpecialPublic select",function () {
        $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=setSpecial&specialId="+$(this).val().join(','));
    });
    */




    $(document).on("click", "a.send-to-h", function() {
        $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=send_to_h");
        $(this).html("Переведено в черновик").removeClass("send-to-h").removeAttr("href");
    });
    $(document).on("click", "a.send-to-d", function() {
        $.SmartMessageBox({
            title : "Внимание!",
            content : "Публикация будет удалена, Вы хотите продолжить?",
            buttons : '[Нет][Да]'
        }, function(ButtonPressed) {
            if (ButtonPressed === "Да") {
                $.get("/ajax/edit_public.php?id="+$("#id").val()+"&sessid="+$("#ssid").val()+"&action=send_to_d",function(){
                    location.reload();
                });
            }
            if (ButtonPressed === "Нет") {

            }

        });
        return false;



    });

    // s11 2016.05.10
    var ButtLock = false;
    $(document).on("click", "a.up-to-sm", function() {
        if (!ButtLock) {
            $.SmartMessageBox({
                title: "Внимание!",
                content: "С вашего счета будет списано 10Sm, Вы хотите продолжить?",
                buttons: '[Нет][Да]'
            }, function (ButtonPressed) {
                if (ButtonPressed === "Да") {
                    if (!ButtLock) {
                        ButtLock = true;
                        $.get("/ajax/edit_public.php?id=" + $("#id").val() + "&sessid=" + $("#ssid").val() + "&action=up_to_sm", function (data) {
                            if (data.length >= 2) {
                                $.smallBox({
                                    title: "Спасибо!",
                                    content: " <i>Публикация успешно поднята.</i>",
                                    color: "#659265",
                                    icon: "fa fa-check fadeInRight animated",
                                    timeout: 4000
                                });
                                setTimeout(function () {
                                    ButtLock = false;
                                }, 4000)
                            } else {
                                $.smallBox({
                                    title: "Ошибка!",
                                    content: "<i class='fa fa-clock-o'></i> <i>На вашем счету недостаточно $m для поднятия.</i>",
                                    color: "#C46A69",
                                    icon: "fa fa-minus-circle fadeInRight animated",
                                    timeout: 4000
                                })
                                setTimeout(function () {
                                    ButtLock = false;
                                }, 4000)
                            }
                        });
                    }
                }
                if (ButtonPressed === "Нет") {

                }
            });
        }
        return false;
    });

    $(document).on("click", "a.color-public", function() {
        if (!ButtLock) {
            $.SmartMessageBox({
                title: "Внимание!",
                content: "Публикация будет выделена в списках в течении 7 дней и с вашего счета будет списано 10Sm. Вы хотите продолжить?",
                buttons: '[Нет][Да]'
            }, function (ButtonPressed) {
                if (ButtonPressed === "Да") {
                    if (!ButtLock) {
                        ButtLock = true;
                        $.get("/ajax/edit_public.php?id=" + $("#id").val() + "&sessid=" + $("#ssid").val() + "&action=color", function (data) {
                            if (data.length >= 2) {
                                $.smallBox({
                                    title: "Спасибо!",
                                    content: " <i>Публикация успешно выделена.</i>",
                                    color: "#659265",
                                    icon: "fa fa-check fadeInRight animated",
                                    timeout: 4000
                                });
                                setTimeout(function () {
                                    ButtLock = false;
                                }, 4000)
                            } else {
                                $.smallBox({
                                    title: "Ошибка!",
                                    content: "<i class='fa fa-clock-o'></i> <i>На вашем счету недостаточно $m.</i>",
                                    color: "#C46A69",
                                    icon: "fa fa-minus-circle fadeInRight animated",
                                    timeout: 4000
                                });
                                setTimeout(function () {
                                    ButtLock = false;
                                }, 4000)
                            }
                        });

                    }
                }
                if (ButtonPressed === "Нет") {

                }
            });
        }
        return false;
    });

	window.demoform_sended = false;
	$(document).on("click", "#btn-submit-demoform", function() {
		if (window.demoform_sended)
			return false;
		window.demoform_sended = true;
		$('#form-request-wrap').submit();
		return false;
	});
    $("#form-request-wrap").submit(function(){
        $("#form-request-wrap input, #form-request-wrap textarea").css('border-color','');
        $("#form-request-wrap input, #form-request-wrap textarea").css('border-width','1');
        formData = new FormData($("#form-request-wrap").get(0));
        $.ajax({
            url: '/ajax/send_landing_form.php?ACTION=SEND_FORM&RESPONS=requisition_demo',
            type: 'post',
            contentType: false,
            processData: false,
            data: formData,
            dataType: 'json',
            success: function(arResult){
                if(arResult.ERROR){
                    $("#form-request-wrap input[name="+arResult.FIELD+"], #form-request-wrap textarea[name="+arResult.FIELD+"]").css('border-color','#e4aeae');
                    $("#form-request-wrap input[name="+arResult.FIELD+"], #form-request-wrap textarea[name="+arResult.FIELD+"]").css('border-width','3');
                }else{
                    $(".send-request-body .form-wrap").hide();
                    $(".send-request-body .success-message").show().find('p.message-success').append('Ваше обращение зарегистрировано и ему присвоен номер <b>'+arResult.OK+'</b>. Дальнейшие инструкции отправлены на ваш email адрес.');
                }
            },
			complete: function () {
				window.demoform_sended = false;
			}
        });
        return false;
    });

    highlight1c('');


    // s11 2016.06.15
    $(window).on('load', function() {
        var hash = window.location.hash.substr(1);
        var target = $("[name='"+hash+"']");
        if (target.length === 0 && hash.length > 0){
            target = $("#"+hash);
        }
        if (target.length !== 0) {
            $(document).scrollTop(target.offset().top - 48);
        }
    });
    $('a[data-target][data-toggle="tab"]').on("click", function() {
        $(this).parent().parent('.nav-tabs').find('li').removeClass('active');
        $(this).parent().addClass('active');
        var id = $(this).attr('data-target');

        if($("#"+id).parent(".tab-content").length > 0){
            $("#"+id).parent(".tab-content").find(".tab-pane").hide().removeClass("active in");
            $("#"+id).show().addClass("active in");
        }
        return false;
    });
    $('.main-wrap a[href^="#"][data-toggle!="collapse"]').on( "click", function() {
        if ($(this).attr('href').length > 1) {
            /*console.log('onclick anchor');*/
            window.location.hash = $(this).attr('href');
            var hash = $(this).attr('href').substr(1);
            var target = $("[name='" + hash + "']");
            if (target.length === 0 && hash.length > 0){
                target = $("#" + hash);
            }
            if (target.length !== 0) {
                $(document).scrollTop(target.offset().top - 48);
            }
            return false;
        }
    });

});

/*--Init carousel screens--*/
$.fn.cycle.defaults.autoSelector = '.screen-carousel';
$.fn.cycle.defaults.maxZ = 32;


$(document).on("change", "#AUTO_UP select", function() {
    var LIMIT = $(this).val();
    $.get("/ajax/edit_public.php?id=" + $("#id").val() + "&sessid=" + $("#ssid").val() + "&action=auto_up&period="+LIMIT, function (data) {
        if (data.length >= 2) {
            $.smallBox({
                title: "Спасибо!",
                content: " <i>Период автоподнятия успешно изменен.</i>",
                color: "#659265",
                icon: "fa fa-check fadeInRight animated",
                timeout: 4000
            });
        } else {
            $.smallBox({
                title: "Ошибка!",
                content: "<i class='fa fa-clock-o'></i> <i>Произошла ошибка при изменении периода автоподнятия, обновите страницу и повторите попытку снова.</i>",
                color: "#C46A69",
                icon: "fa fa-minus-circle fadeInRight animated",
                timeout: 4000
            });

        }
    });
});

$(function(){
    let right_side = $(".right-side");
    let author_block = right_side.find(".author_block");
    let banner_vertical = $('.banner-vertical');

/*
    // Social Buttons
    let soc_butt_wrap = $('.left-side .soc-butt-wrap');
    let topPosButt = soc_butt_wrap.offset().top;
    let heightButt = soc_butt_wrap.outerHeight();
*/
    // Author Block
    let topPosRightSide = right_side.offset().top;
    let heightRightSide = right_side.outerHeight();
    let heightAuthorBlock = author_block.outerHeight();

    // Banner Vertical
    let topPosBannerVertical = 0;
    let heightBannerVertical = 0;
    if(banner_vertical.length > 0){
        topPosBannerVertical = banner_vertical.offset().top;
        heightBannerVertical = banner_vertical.outerHeight();
    }

    // for all
    let pip = $('#EndSroll').offset().top - 28;

    $(window).scroll(function() {
        let top = $(window).scrollTop() + 60;
        /*
            // Social Buttons
            if (top > topPosButt && top < pip - heightButt) {
                soc_butt_wrap.addClass('fixed').removeAttr("style");
            }else{
                soc_butt_wrap.removeClass('fixed');
            }
*/
        // Author Block
        if(right_side.hasClass("is_pay")) {
            if (top > topPosRightSide + heightRightSide && top < pip - heightAuthorBlock) {
                author_block.addClass('fixed');
            } else {
                author_block.removeClass('fixed');
            }
        }

        // Banner Vertical
        //console.log(banner_vertical.length);
        if(banner_vertical.length > 0){
            if (heightBannerVertical == 0) {
                heightBannerVertical = banner_vertical.length * 400; //AdFox height -mparameter rarely is too late
            }
            if (top > topPosBannerVertical && top < pip - heightBannerVertical) {
                banner_vertical.addClass('fixed').removeAttr("style");
            }else{
                banner_vertical.removeClass('fixed');
            }
        }
    });
});



$(document).on("click",".linked-ticket-wrap .getMessages a:not('.locked')",function () {
    var CurrLi = $(this).parents(".ticket-body-row-name");
    var Wrap = $("<ul class='linked-ticket-body'></ul>");
    var obj = $(this);
    obj.addClass('locked');
    var jqxhr = $.getJSON("/bitrix/ajax/getTicketMessage.php",
        {
            PUBLICATION_ID:	$(this).attr("data-public"),
            TICKET_ID:		$(this).attr("data-id"),
            SESSID:         BX.bitrix_sessid()
        },
        function (arAnswer) {
            $.each(arAnswer.MESSAGE.DATA,function ($k,$v) {
				var liclass = 'li-support-answer2';
            	if ($v.AUTHOR == 'Y')
					liclass = 'li-support-author2';
				$(Wrap).append('<li class="'+liclass+'">'+$v.MESSAGE+"</li>");
            });
                CurrLi.append(Wrap).removeClass("getMessages");

        }
    )
	.fail(function() {
		obj.removeClass('locked');
	});
    return false;

});
$(document).on("click",".linked-ticket-wrap li:not(.getMessages) a[data-id]",function () {
    $(this).parents(".linked-ticket-body-row").next("ul").toggle();
    return false;

});
$(document).on("click",".kurs-spoiler .kurs-spoiler-title",function () {
    $(".kurs-spoiler .kurs-spoiler-body").slideToggle(400);
    $(".kurs-spoiler .kurs-spoiler-icon").toggleClass("fa-plus-square-o").toggleClass("fa-minus-square-o");
    return false;
});

$(function () {
	$(".btn-request-demo").on("click", function () {
		let fa = $(this).find(".btn-label i.fa");
		let buttonText = $(this).find(".button-text");
		let oldText = buttonText.text();
		buttonText.text("Загрузка...");
		fa.toggleClass("fa-external-link-square").toggleClass("fa-cog").toggleClass("fa-spin");
		$.ajax({
			method: "GET",
			url: "/bitrix/ajax/1c/request_demo.php",
			cache: false,
			data: {pid: $(this).data("pid"), fid: $(this).data("fid")},
			dataType: 'json',
			success: function (result) {
				window.open(result.url);
			},
			error: function () {
				$.smallBox({
					title: "Ошибка",
					content: "Не удалось открыть демо. Обратитесь в техподдержку.",
					color: "#C46A69",
					icon: "fa fa-warning animated",
					timeout: 10000
				});
			},
			complete: function () {
				fa.toggleClass("fa-external-link-square").toggleClass("fa-cog").toggleClass("fa-spin");
				buttonText.text(oldText);
			},
		})
		return false;
	});
})

function checkSelectParams(select) {
    let result = { result: 'ok' };
    const maxCount = select.data('max-count');
    const options = select.find('option');
    if (maxCount) {
        let countSelected = 0;
        options.each((key, option) => {
            if (option.selected) countSelected++;
        });
        if (countSelected > maxCount) {
            result.result = 'error';
            result.error_text = 'Максимальное количество выбранных значений должно быть не более ' + maxCount;
        }
    }

    return result;
}
/* End */
;
; /* Start:/bitrix/templates/.default/js/spoiler.js*/
$(function() {
	$('div.spoiler-title').click(function() {
		$(this)
			.children()
			.first()
			.toggleClass('show-icon')
			.toggleClass('hide-icon');
		$(this)
			.parent().children().last().toggle();
	});
});
/* End */
;
; /* Start:/bitrix/templates/adaptive/js/ckeditor/plugins/codesnippet/lib/highlight/highlight.pack.js*/
// %LEAVE_UNMINIFIED% %REMOVE_LINE%
var hljs = new function () {
    function k(v) {
        return v.replace(/&/gm, "&amp;").replace(/</gm, "&lt;").replace(/>/gm, "&gt;")
    }

    function t(v) {
        return v.nodeName.toLowerCase()
    }

    function i(w, x) {
        var v = w && w.exec(x);
        return v && v.index == 0
    }

    function d(v) {
        return Array.prototype.map.call(v.childNodes, function (w) {
            if (w.nodeType == 3) {
                return b.useBR ? w.nodeValue.replace(/\n/g, "") : w.nodeValue
            }
            if (t(w) == "br") {
                return "\n"
            }
            return d(w)
        }).join("")
    }

    function r(w) {
        var v = (w.className + " " + (w.parentNode ? w.parentNode.className : "")).split(/\s+/);
        v = v.map(function (x) {
            return x.replace(/^language-/, "")
        });
        return v.filter(function (x) {
            return j(x) || x == "no-highlight"
        })[0]
    }

    function o(x, y) {
        var v = {};
        for (var w in x) {
            v[w] = x[w]
        }
        if (y) {
            for (var w in y) {
                v[w] = y[w]
            }
        }
        return v
    }

    function u(x) {
        var v = [];
        (function w(y, z) {
            for (var A = y.firstChild; A; A = A.nextSibling) {
                if (A.nodeType == 3) {
                    z += A.nodeValue.length
                } else {
                    if (t(A) == "br") {
                        z += 1
                    } else {
                        if (A.nodeType == 1) {
                            v.push({event: "start", offset: z, node: A});
                            z = w(A, z);
                            v.push({event: "stop", offset: z, node: A})
                        }
                    }
                }
            }
            return z
        })(x, 0);
        return v
    }

    function q(w, y, C) {
        var x = 0;
        var F = "";
        var z = [];

        function B() {
            if (!w.length || !y.length) {
                return w.length ? w : y
            }
            if (w[0].offset != y[0].offset) {
                return (w[0].offset < y[0].offset) ? w : y
            }
            return y[0].event == "start" ? w : y
        }

        function A(H) {
            function G(I) {
                return " " + I.nodeName + '="' + k(I.value) + '"'
            }

            F += "<" + t(H) + Array.prototype.map.call(H.attributes, G).join("") + ">"
        }

        function E(G) {
            F += "</" + t(G) + ">"
        }

        function v(G) {
            (G.event == "start" ? A : E)(G.node)
        }

        while (w.length || y.length) {
            var D = B();
            F += k(C.substr(x, D[0].offset - x));
            x = D[0].offset;
            if (D == w) {
                z.reverse().forEach(E);
                do {
                    v(D.splice(0, 1)[0]);
                    D = B()
                } while (D == w && D.length && D[0].offset == x);
                z.reverse().forEach(A)
            } else {
                if (D[0].event == "start") {
                    z.push(D[0].node)
                } else {
                    z.pop()
                }
                v(D.splice(0, 1)[0])
            }
        }
        return F + k(C.substr(x))
    }

    function m(y) {
        function v(z) {
            return (z && z.source) || z
        }

        function w(A, z) {
            return RegExp(v(A), "m" + (y.cI ? "i" : "") + (z ? "g" : ""))
        }

        function x(D, C) {
            if (D.compiled) {
                return
            }
            D.compiled = true;
            D.k = D.k || D.bK;
            if (D.k) {
                var z = {};

                function E(G, F) {
                    if (y.cI) {
                        F = F.toLowerCase()
                    }
                    F.split(" ").forEach(function (H) {
                        var I = H.split("|");
                        z[I[0]] = [G, I[1] ? Number(I[1]) : 1]
                    })
                }

                if (typeof D.k == "string") {
                    E("keyword", D.k)
                } else {
                    Object.keys(D.k).forEach(function (F) {
                        E(F, D.k[F])
                    })
                }
                D.k = z
            }
            D.lR = w(D.l || /\b[A-Za-z0-9_]+\b/, true);
            if (C) {
                if (D.bK) {
                    D.b = D.bK.split(" ").join("|")
                }
                if (!D.b) {
                    D.b = /\B|\b/
                }
                D.bR = w(D.b);
                if (!D.e && !D.eW) {
                    D.e = /\B|\b/
                }
                if (D.e) {
                    D.eR = w(D.e)
                }
                D.tE = v(D.e) || "";
                if (D.eW && C.tE) {
                    D.tE += (D.e ? "|" : "") + C.tE
                }
            }
            if (D.i) {
                D.iR = w(D.i)
            }
            if (D.r === undefined) {
                D.r = 1
            }
            if (!D.c) {
                D.c = []
            }
            var B = [];
            D.c.forEach(function (F) {
                if (F.v) {
                    F.v.forEach(function (G) {
                        B.push(o(F, G))
                    })
                } else {
                    B.push(F == "self" ? D : F)
                }
            });
            D.c = B;
            D.c.forEach(function (F) {
                x(F, D)
            });
            if (D.starts) {
                x(D.starts, C)
            }
            var A = D.c.map(function (F) {
                return F.bK ? "\\.?\\b(" + F.b + ")\\b\\.?" : F.b
            }).concat([D.tE]).concat([D.i]).map(v).filter(Boolean);
            D.t = A.length ? w(A.join("|"), true) : {
                exec: function (F) {
                    return null
                }
            };
            D.continuation = {}
        }

        x(y)
    }

    function c(S, L, J, R) {
        function v(U, V) {
            for (var T = 0; T < V.c.length; T++) {
                if (i(V.c[T].bR, U)) {
                    return V.c[T]
                }
            }
        }

        function z(U, T) {
            if (i(U.eR, T)) {
                return U
            }
            if (U.eW) {
                return z(U.parent, T)
            }
        }

        function A(T, U) {
            return !J && i(U.iR, T)
        }

        function E(V, T) {
            var U = M.cI ? T[0].toLowerCase() : T[0];
            return V.k.hasOwnProperty(U) && V.k[U]
        }

        function w(Z, X, W, V) {
            var T = V ? "" : b.classPrefix, U = '<span class="' + T, Y = W ? "" : "</span>";
            U += Z + '">';
            return U + X + Y
        }

        function N() {
            var U = k(C);
            if (!I.k) {
                return U
            }
            var T = "";
            var X = 0;
            I.lR.lastIndex = 0;
            var V = I.lR.exec(U);
            while (V) {
                T += U.substr(X, V.index - X);
                var W = E(I, V);
                if (W) {
                    H += W[1];
                    T += w(W[0], V[0])
                } else {
                    T += V[0]
                }
                X = I.lR.lastIndex;
                V = I.lR.exec(U)
            }
            return T + U.substr(X)
        }

        function F() {
            if (I.sL && !f[I.sL]) {
                return k(C)
            }
            var T = I.sL ? c(I.sL, C, true, I.continuation.top) : g(C);
            if (I.r > 0) {
                H += T.r
            }
            if (I.subLanguageMode == "continuous") {
                I.continuation.top = T.top
            }
            return w(T.language, T.value, false, true)
        }

        function Q() {
            return I.sL !== undefined ? F() : N()
        }

        function P(V, U) {
            var T = V.cN ? w(V.cN, "", true) : "";
            if (V.rB) {
                D += T;
                C = ""
            } else {
                if (V.eB) {
                    D += k(U) + T;
                    C = ""
                } else {
                    D += T;
                    C = U
                }
            }
            I = Object.create(V, {parent: {value: I}})
        }

        function G(T, X) {
            C += T;
            if (X === undefined) {
                D += Q();
                return 0
            }
            var V = v(X, I);
            if (V) {
                D += Q();
                P(V, X);
                return V.rB ? 0 : X.length
            }
            var W = z(I, X);
            if (W) {
                var U = I;
                if (!(U.rE || U.eE)) {
                    C += X
                }
                D += Q();
                do {
                    if (I.cN) {
                        D += "</span>"
                    }
                    H += I.r;
                    I = I.parent
                } while (I != W.parent);
                if (U.eE) {
                    D += k(X)
                }
                C = "";
                if (W.starts) {
                    P(W.starts, "")
                }
                return U.rE ? 0 : X.length
            }
            if (A(X, I)) {
                throw new Error('Illegal lexeme "' + X + '" for mode "' + (I.cN || "<unnamed>") + '"')
            }
            C += X;
            return X.length || 1
        }

        var M = j(S);
        if (!M) {
            throw new Error('Unknown language: "' + S + '"')
        }
        m(M);
        var I = R || M;
        var D = "";
        for (var K = I; K != M; K = K.parent) {
            if (K.cN) {
                D = w(K.cN, D, true)
            }
        }
        var C = "";
        var H = 0;
        try {
            var B, y, x = 0;
            while (true) {
                I.t.lastIndex = x;
                B = I.t.exec(L);
                if (!B) {
                    break
                }
                y = G(L.substr(x, B.index - x), B[0]);
                x = B.index + y
            }
            G(L.substr(x));
            for (var K = I; K.parent; K = K.parent) {
                if (K.cN) {
                    D += "</span>"
                }
            }
            return {r: H, value: D, language: S, top: I}
        } catch (O) {
            if (O.message.indexOf("Illegal") != -1) {
                return {r: 0, value: k(L)}
            } else {
                throw O
            }
        }
    }

    function g(y, x) {
        x = x || b.languages || Object.keys(f);
        var v = {r: 0, value: k(y)};
        var w = v;
        x.forEach(function (z) {
            if (!j(z)) {
                return
            }
            var A = c(z, y, false);
            A.language = z;
            if (A.r > w.r) {
                w = A
            }
            if (A.r > v.r) {
                w = v;
                v = A
            }
        });
        if (w.language) {
            v.second_best = w
        }
        return v
    }

    function h(v) {
        if (b.tabReplace) {
            v = v.replace(/^((<[^>]+>|\t)+)/gm, function (w, z, y, x) {
                return z.replace(/\t/g, b.tabReplace)
            })
        }
        if (b.useBR) {
            v = v.replace(/\n/g, "<br>")
        }
        return v
    }

    function p(z) {
        var y = d(z);
        var A = r(z);
        if (A == "no-highlight") {
            return
        }
        if(z.getAttribute("highlight-set") === 1) {
            return;
        }
        z.setAttribute("highlight-set", "1");
        var v = A ? c(A, y, true) : g(y);
        var w = u(z);
        if (w.length) {
            var x = document.createElementNS("http://www.w3.org/1999/xhtml", "pre");
            x.innerHTML = v.value;
            v.value = q(w, u(x), y)
        }
        v.value = h(v.value);
        z.innerHTML = v.value;
        z.className += " hljs " + (!A && v.language || "");
        z.result = {language: v.language, re: v.r};
        if (v.second_best) {
            z.second_best = {language: v.second_best.language, re: v.second_best.r}
        }
    }

    var b = {classPrefix: "hljs-", tabReplace: null, useBR: false, languages: undefined};

    function s(v) {
        b = o(b, v)
    }

    function l() {
        var v = document.querySelectorAll("pre code");
        Array.prototype.forEach.call(v, p)
    }

    function a() {
        addEventListener("DOMContentLoaded", l, false);
        addEventListener("load", l, false)
    }

    var f = {};
    var n = {};

    function e(v, x) {
        var w = f[v] = x(this);
        if (w.aliases) {
            w.aliases.forEach(function (y) {
                n[y] = v
            })
        }
    }

    function j(v) {
        return f[v] || f[n[v]]
    }

    this.highlight = c;
    this.highlightAuto = g;
    this.fixMarkup = h;
    this.highlightBlock = p;
    this.configure = s;
    this.initHighlighting = l;
    this.initHighlightingOnLoad = a;
    this.registerLanguage = e;
    this.getLanguage = j;
    this.inherit = o;
    this.IR = "[a-zA-Z][a-zA-Z0-9_]*";
    this.UIR = "[a-zA-Z_][a-zA-Z0-9_]*";
    this.NR = "\\b\\d+(\\.\\d+)?";
    this.CNR = "(\\b0[xX][a-fA-F0-9]+|(\\b\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?\\d+)?)";
    this.BNR = "\\b(0b[01]+)";
    this.RSR = "!|!=|!==|%|%=|&|&&|&=|\\*|\\*=|\\+|\\+=|,|-|-=|/=|/|:|;|<<|<<=|<=|<|===|==|=|>>>=|>>=|>=|>>>|>>|>|\\?|\\[|\\{|\\(|\\^|\\^=|\\||\\|=|\\|\\||~";
    this.BE = {b: "\\\\[\\s\\S]", r: 0};
    this.ASM = {cN: "string", b: "'", e: "'", i: "\\n", c: [this.BE]};
    this.QSM = {cN: "string", b: '"', e: '"', i: "\\n", c: [this.BE]};
    this.CLCM = {cN: "comment", b: "//", e: "$"};
    this.CBLCLM = {cN: "comment", b: "/\\*", e: "\\*/"};
    this.HCM = {cN: "comment", b: "#", e: "$"};
    this.NM = {cN: "number", b: this.NR, r: 0};
    this.CNM = {cN: "number", b: this.CNR, r: 0};
    this.BNM = {cN: "number", b: this.BNR, r: 0};
    this.REGEXP_MODE = {
        cN: "regexp",
        b: /\//,
        e: /\/[gim]*/,
        i: /\n/,
        c: [this.BE, {b: /\[/, e: /\]/, r: 0, c: [this.BE]}]
    };
    this.TM = {cN: "title", b: this.IR, r: 0};
    this.UTM = {cN: "title", b: this.UIR, r: 0}
}();
hljs.registerLanguage("onec7", function (c) {
    var e = "[a-zA-Zа-яА-Я][a-zA-Z0-9_а-яА-Я]*",
        n = "Если If Тогда Then ИначеЕсли ElsIf Иначе Else КонецЕсли EndIf Цикл Do Для For По To Пока While КонецЦикла EndDo Процедура Procedure КонецПроцедуры EndProcedure Функция Function КонецФункции EndFunction Перем Var Экспорт Export Перейти Goto И And Или Or Не Not Знач Val Прервать Break Продолжить Continue Возврат Return Контекст Context Далее Forward Попытка Try Исключение Except КонецПопытки EndTry ВызватьИсключение Raise ОписаниеОшибки GetErrorDescription ТекущаяИБКод CurrentIBCode ТекущаяИБНаименование CurrentIBDescr ТекущаяИБСтатус CurrentIBStatus ТекущаяИБЦентральная IsCurrentIBCenter ИБСозданияОбъекта BirthIBOfObject ЦентральнаяИБКод CentralIBCode ТекущаяИБТолькоПолучатель IsCurrentIBRecepientOnly ФС FS ЗагрузитьВнешнююКомпоненту LoadAddIn ПодключитьВнешнююКомпоненту AttachAddIn СоздатьОбъект CreateObject СтатусВозврата ReturnStatus РазделительСтраниц PageBreak РазделительСтрок LineBreak СимволТабуляции TabSymbol Перечисление Enum Константа Const ПланыСчетов ChartsOfAccounts ВидыСубконто SubcontoKinds ВидРасчета CalculationKind ГруппаРасчетов CalculationGroup Регистр Register Окр Round Цел Int Мин Min Макс Max Лог10 Log10 Лог Ln СтрДлина StrLen ПустаяСтрока IsBlankString СокрЛ TrimL СокрП TrimR СокрЛП TrimAll Лев Left Прав Right Сред Mid Найти Find СтрЗаменить StrReplace СтрЧислоВхождений StrCountOccur СтрКоличествоСтрок StrLineCount СтрПолучитьСтроку StrGetLine Врег Upper Нрег Lower OemToAnsi AnsiToOem Симв Chr КодСимв Asc РабочаяДата WorkingDate ТекущаяДата CurDate ДобавитьМесяц AddMonth НачМесяца BegOfMonth КонМесяца EndOfMonth НачКвартала BegOfQuart КонКвартала EndOfQuart НачГода BegOfYear КонГода EndOfYear НачНедели BegOfWeek КонНедели EndOfWeek ДатаГод GetYear ДатаМесяц GetMonth ДатаЧисло GetDay НомерНеделиГода GetWeekOfYear НомерДняГода GetDayOfYear НомерДняНедели GetDayOfWeek ПериодСтр PeriodStr НачалоСтандартногоИнтервала BegOfStandardRange КонецСтандартногоИнтервала EndOfStandardRange ТекущееВремя CurrentTime СформироватьПозициюДокумента MakeDocPosition РазобратьПозициюДокумента SplitDocPosition Дата Date Строка String Число Number Пропись Spelling Формат Format Шаблон Template ФиксШаблон FixTemplate ВвестиЗначение InputValue ВвестиЧисло InputNumeric ВвестиСтроку InputString ВвестиДату InputDate ВвестиПериод InputPeriod ВвестиПеречисление InputEnum Вопрос DoQueryBox Предупреждение DoMessageBox Сообщить Message ОчиститьОкноСообщений ClearMessageWindow Состояние Status Сигнал Beep Разм Dim ЗаголовокСистемы SystemCaption ИмяКомпьютера ComputerName ИмяПользователя UserName ПолноеИмяПользователя UserFullName НазваниеНабораПрав RightName ПравоДоступа AccessRight НазваниеИнтерфейса UserInterfaceName КаталогПользователя UserDir КаталогИБ IBDir КаталогПрограммы BinDir КаталогВременныхФайлов TempFilesDir КаталогБазыДанных DBDir МонопольныйРежим ExclusiveMode ОсновнойЯзык GeneralLanguage НачатьТранзакцию BeginTransaction ЗафиксироватьТранзакцию CommitTransaсtion ОтменитьТранзакцию RollBackTransaction ЗначениеВСтрокуВнутр ValueToStringInternal ЗначениеИзСтрокиВнутр ValueFromStringInternal ЗначениеВСтроку ValueToString ЗначениеИзСтроки ValueFromString ЗначениеВФайл ValueToFile ЗначениеИзФайла ValueFromFile СохранитьЗначение SaveValue ВосстановитьЗначение RestoreValue ПолучитьТА GetAP ПолучитьДатуТА GetDateOfAP ПолучитьВремяТА GetTimeOfAP ПолучитьДокументТА GetDocOfAP ПолучитьПозициюТА GetAPPosition УстановитьТАна SetAPToBeg УстановитьТАпо SetAPToEnd РассчитатьРегистрыНа CalcRegsOnBeg РассчитатьРегистрыПо CalcRegsOnEnd ВыбранныйПланСчетов DefaultChartOfAccounts ОсновнойПланСчетов MainChartOfAccounts СчетПоКоду AccountByCode НачалоПериодаБИ BeginOfPeriodBT КонецПериодаБИ EndOfPeriodBT КонецРассчитанногоПериодаБИ EndOfCalculatedPeriodBT МаксимальноеКоличествоСубконто MaxSubcontoCount НазначитьСчет SetAccount ВвестиПланСчетов InputChartOfAccounts ВвестиВидСубконто InputSubcontoKind ОсновнойЖурналРасчетов BasicCalcJournal ТипЗначения ValueType ТипЗначенияСтр ValueTypeStr ПустоеЗначение EmptyValue ПолучитьПустоеЗначение GetEmptyValue НазначитьВид SetKind ПрефиксАвтоНумерации AutoNumPrefix ПолучитьЗначенияОтбора GetSelectionValues ЗаписьЖурналаРегистрации LogMessageWrite КомандаСистемы System ЗапуститьПриложение RunApp ЗавершитьРаботуСистемы ExitSystem НайтиПомеченныеНаУдаление FindMarkedForDelete НайтиСсылки FindReferences УдалитьОбъекты DeleteObjects ОбработкаОжидания IdleProcessing ОткрытьФорму OpenForm ОткрытьФормуМодально OpenFormModal _IdToStr _StrToID _GetPerformanceCounter Календари Calendars Метаданные Metadata Последовательность Sequence ПравилоПерерасчета RecalculationRule",
        b = "",
        i = {b: '""'},
        r = {cN: "string", b: '"', e: '"|$',  c: [i]},
        t = {cN: "string", b: "\\|", e: '"|$', c: [i]};
    return {
        cI: !0,
        l: e,
        k: n,
        c: [c.CLCM, c.NM, r, t, {
            cN: "function",
            b: "(процедура|функция)",
            e: "$",
            l: e,
            k: "процедура функция",
            c: [{b: "экспорт", eW: !0, l: e, k: "экспорт", c: [c.CLCM]}, {
                cN: "params",
                b: "\\(",
                e: "\\)",
                l: e,
                k: "знач",
                c: [r, t]
            }, c.CLCM, c.inherit(c.TM, {b: e})]
        }, {cN: "meta", b: "#", e: "$"}, {cN: "number", b: "\\d{2}\\.\\d{2}\\.(\\d{2}|\\d{4})"},{cN: "special_symbols", b: "\\(|\\)|=|,|;|\\*|\\/|\\>|\\<|\\-|\\?|\\+"}]
    }
});
hljs.registerLanguage("onec8", function (c) {
    var e = "[a-zA-Zа-яА-Я][a-zA-Z0-9_а-яА-Я]*",
        n = "Если If Тогда Then ИначеЕсли ElsIf Иначе Else КонецЕсли EndIf Цикл Do Для For По To Пока While КонецЦикла EndDo Процедура Procedure КонецПроцедуры EndProcedure Функция Function КонецФункции EndFunction Перем Var Экспорт Export Перейти Goto И And Или Or Не Not Знач Val Прервать Break Продолжить Continue Возврат Return Попытка Try Исключение Except КонецПопытки EndTry ВызватьИсключение Raise Из In Каждого Each Истина True Ложь False Null Неопределено Undefined Новый New НаКлиенте НаСервере НаСервереБезКонтекста НаКлиентеНаСервере НаКлиентеНаСервереБезКонтекста",
        b = "ЕСЛИ НаКлиенте НаСервере НаСервереБезКонтекста НаКлиентеНаСервере НаКлиентеНаСервереБезКонтекста",
        i = {b: '""'},
        r = {cN: "string", b: '"', e: '"|$', c: [i]},
        t = {cN: "string", b: "\\|", e: '"|$', c: [i]};
    return {
        cI: !0,
        l: e,
        k: n,
        c: [c.CLCM, c.NM, r, t, {cN: "meta", b: "#", e: "$"}, {cN: "number", b: "\\d{2}\\.\\d{2}\\.(\\d{2}|\\d{4})"},{cN: "preprocessor", b: "&", e: "$"},{cN: "special_symbols", b: "\\(|\\)|=|,|;|\\*|\\/|\\>|\\<|\\-|\\?|\\+"}]
    }
});

//c: [c.CLCM, c.NM, r, t, {
//    cN: "function",
//    b: "(процедура|функция)",
//    e: "$",
//    l: e,
//    k: "процедура функция",
//    c: [{b: "экспорт", eW: !0, l: e, k: "экспорт", c: [c.CLCM]}, {
//        cN: "params",
//        b: "\\(",
//        e: "\\)",
//        l: e,
//        k: "знач",
//        c: [r, t]
//    }, c.CLCM, c.inherit(c.TM, {b: e})]
//}, {cN: "meta", b: "#", e: "$"}, {cN: "number", b: "'\\d{2}\\.\\d{2}\\.(\\d{2}|\\d{4})'"},{cN: "preprocessor", b: "&", e: "$"},{cN: "special_symbols", b: "\\(|\\)|=|,"}]

hljs.registerLanguage("bash", function (b) {
    var a = {cN: "variable", v: [{b: /\$[\w\d#@][\w\d_]*/}, {b: /\$\{(.*?)\}/}]};
    var d = {cN: "string", b: /"/, e: /"/, c: [b.BE, a, {cN: "variable", b: /\$\(/, e: /\)/, c: [b.BE]}]};
    var c = {cN: "string", b: /'/, e: /'/};
    return {
        l: /-?[a-z\.]+/,
        k: {
            keyword: "if then else elif fi for break continue while in do done exit return set declare case esac export exec",
            literal: "true false",
            built_in: "printf echo read cd pwd pushd popd dirs let eval unset typeset readonly getopts source shopt caller type hash bind help sudo",
            operator: "-ne -eq -lt -gt -f -d -e -s -l -a"
        },
        c: [{cN: "shebang", b: /^#![^\n]+sh\s*$/, r: 10}, {
            cN: "function",
            b: /\w[\w\d_]*\s*\(\s*\)\s*\{/,
            rB: true,
            c: [b.inherit(b.TM, {b: /\w[\w\d_]*/})],
            r: 0
        }, b.HCM, b.NM, d, c, a]
    }
});
hljs.registerLanguage("cs", function (b) {
    var a = "abstract as base bool break byte case catch char checked const continue decimal default delegate do double else enum event explicit extern false finally fixed float for foreach goto if implicit in int interface internal is lock long new null object operator out override params private protected public readonly ref return sbyte sealed short sizeof stackalloc static string struct switch this throw true try typeof uint ulong unchecked unsafe ushort using virtual volatile void while async await ascending descending from get group into join let orderby partial select set value var where yield";
    return {
        k: a,
        c: [{
            cN: "comment",
            b: "///",
            e: "$",
            rB: true,
            c: [{cN: "xmlDocTag", b: "///|<!--|-->"}, {cN: "xmlDocTag", b: "</?", e: ">"}]
        }, b.CLCM, b.CBLCLM, {
            cN: "preprocessor",
            b: "#",
            e: "$",
            k: "if else elif endif define undef warning error line region endregion pragma checksum"
        }, {
            cN: "string",
            b: '@"',
            e: '"',
            c: [{b: '""'}]
        }, b.ASM, b.QSM, b.CNM, {
            bK: "protected public private internal",
            e: /[{;=]/,
            k: a,
            c: [{bK: "class namespace interface", starts: {c: [b.TM]}}, {b: b.IR + "\\s*\\(", rB: true, c: [b.TM]}]
        }]
    }
});
hljs.registerLanguage("ruby", function (e) {
    var h = "[a-zA-Z_]\\w*[!?=]?|[-+~]\\@|<<|>>|=~|===?|<=>|[<>]=?|\\*\\*|[-/+%^&*~`|]|\\[\\]=?";
    var g = "and false then defined module in return redo if BEGIN retry end for true self when next until do begin unless END rescue nil else break undef not super class case require yield alias while ensure elsif or include attr_reader attr_writer attr_accessor";
    var a = {cN: "yardoctag", b: "@[A-Za-z]+"};
    var i = {
        cN: "comment",
        v: [{b: "#", e: "$", c: [a]}, {b: "^\\=begin", e: "^\\=end", c: [a], r: 10}, {b: "^__END__", e: "\\n$"}]
    };
    var c = {cN: "subst", b: "#\\{", e: "}", k: g};
    var d = {
        cN: "string",
        c: [e.BE, c],
        v: [{b: /'/, e: /'/}, {b: /"/, e: /"/}, {b: "%[qw]?\\(", e: "\\)"}, {b: "%[qw]?\\[", e: "\\]"}, {
            b: "%[qw]?{",
            e: "}"
        }, {b: "%[qw]?<", e: ">", r: 10}, {b: "%[qw]?/", e: "/", r: 10}, {b: "%[qw]?%", e: "%", r: 10}, {
            b: "%[qw]?-",
            e: "-",
            r: 10
        }, {b: "%[qw]?\\|", e: "\\|", r: 10}, {b: /\B\?(\\\d{1,3}|\\x[A-Fa-f0-9]{1,2}|\\u[A-Fa-f0-9]{4}|\\?\S)\b/}]
    };
    var b = {cN: "params", b: "\\(", e: "\\)", k: g};
    var f = [d, i, {
        cN: "class",
        bK: "class module",
        e: "$|;",
        i: /=/,
        c: [e.inherit(e.TM, {b: "[A-Za-z_]\\w*(::\\w+)*(\\?|\\!)?"}), {
            cN: "inheritance",
            b: "<\\s*",
            c: [{cN: "parent", b: "(" + e.IR + "::)?" + e.IR}]
        }, i]
    }, {cN: "function", bK: "def", e: " |$|;", r: 0, c: [e.inherit(e.TM, {b: h}), b, i]}, {
        cN: "constant",
        b: "(::)?(\\b[A-Z]\\w*(::)?)+",
        r: 0
    }, {cN: "symbol", b: ":", c: [d, {b: h}], r: 0}, {cN: "symbol", b: e.UIR + "(\\!|\\?)?:", r: 0}, {
        cN: "number",
        b: "(\\b0[0-7_]+)|(\\b0x[0-9a-fA-F_]+)|(\\b[1-9][0-9_]*(\\.[0-9_]+)?)|[0_]\\b",
        r: 0
    }, {cN: "variable", b: "(\\$\\W)|((\\$|\\@\\@?)(\\w+))"}, {
        b: "(" + e.RSR + ")\\s*",
        c: [i, {
            cN: "regexp",
            c: [e.BE, c],
            i: /\n/,
            v: [{b: "/", e: "/[a-z]*"}, {b: "%r{", e: "}[a-z]*"}, {b: "%r\\(", e: "\\)[a-z]*"}, {
                b: "%r!",
                e: "![a-z]*"
            }, {b: "%r\\[", e: "\\][a-z]*"}]
        }],
        r: 0
    }];
    c.c = f;
    b.c = f;
    return {k: g, c: f}
});
hljs.registerLanguage("diff", function (a) {
    return {
        c: [{
            cN: "chunk",
            r: 10,
            v: [{b: /^\@\@ +\-\d+,\d+ +\+\d+,\d+ +\@\@$/}, {b: /^\*\*\* +\d+,\d+ +\*\*\*\*$/}, {b: /^\-\-\- +\d+,\d+ +\-\-\-\-$/}]
        }, {
            cN: "header",
            v: [{b: /Index: /, e: /$/}, {b: /=====/, e: /=====$/}, {b: /^\-\-\-/, e: /$/}, {
                b: /^\*{3} /,
                e: /$/
            }, {b: /^\+\+\+/, e: /$/}, {b: /\*{5}/, e: /\*{5}$/}]
        }, {cN: "addition", b: "^\\+", e: "$"}, {cN: "deletion", b: "^\\-", e: "$"}, {cN: "change", b: "^\\!", e: "$"}]
    }
});
hljs.registerLanguage("javascript", function (a) {
    return {
        aliases: ["js"],
        k: {
            keyword: "in if for while finally var new function do return void else break catch instanceof with throw case default try this switch continue typeof delete let yield const class",
            literal: "true false null undefined NaN Infinity",
            built_in: "eval isFinite isNaN parseFloat parseInt decodeURI decodeURIComponent encodeURI encodeURIComponent escape unescape Object Function Boolean Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError Number Math Date String RegExp Array Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray ArrayBuffer DataView JSON Intl arguments require"
        },
        c: [{
            cN: "pi",
            b: /^\s*('|")use strict('|")/,
            r: 10
        }, a.ASM, a.QSM, a.CLCM, a.CBLCLM, a.CNM, {
            b: "(" + a.RSR + "|\\b(case|return|throw)\\b)\\s*",
            k: "return throw case",
            c: [a.CLCM, a.CBLCLM, a.REGEXP_MODE, {b: /</, e: />;/, r: 0, sL: "xml"}],
            r: 0
        }, {
            cN: "function",
            bK: "function",
            e: /\{/,
            c: [a.inherit(a.TM, {b: /[A-Za-z$_][0-9A-Za-z$_]*/}), {
                cN: "params",
                b: /\(/,
                e: /\)/,
                c: [a.CLCM, a.CBLCLM],
                i: /["'\(]/
            }],
            i: /\[|%/
        }, {b: /\$[(.]/}, {b: "\\." + a.IR, r: 0}]
    }
});
hljs.registerLanguage("xml", function (a) {
    var c = "[A-Za-z0-9\\._:-]+";
    var d = {b: /<\?(php)?(?!\w)/, e: /\?>/, sL: "php", subLanguageMode: "continuous"};
    var b = {
        eW: true,
        i: /</,
        r: 0,
        c: [d, {cN: "attribute", b: c, r: 0}, {
            b: "=",
            r: 0,
            c: [{cN: "value", v: [{b: /"/, e: /"/}, {b: /'/, e: /'/}, {b: /[^\s\/>]+/}]}]
        }]
    };
    return {
        aliases: ["html"],
        cI: true,
        c: [{cN: "doctype", b: "<!DOCTYPE", e: ">", r: 10, c: [{b: "\\[", e: "\\]"}]}, {
            cN: "comment",
            b: "<!--",
            e: "-->",
            r: 10
        }, {cN: "cdata", b: "<\\!\\[CDATA\\[", e: "\\]\\]>", r: 10}, {
            cN: "tag",
            b: "<style(?=\\s|>|$)",
            e: ">",
            k: {title: "style"},
            c: [b],
            starts: {e: "</style>", rE: true, sL: "css"}
        }, {
            cN: "tag",
            b: "<script(?=\\s|>|$)",
            e: ">",
            k: {title: "script"},
            c: [b],
            starts: {e: "<\/script>", rE: true, sL: "javascript"}
        }, {b: "<%", e: "%>", sL: "vbscript"}, d, {cN: "pi", b: /<\?\w+/, e: /\?>/, r: 10}, {
            cN: "tag",
            b: "</?",
            e: "/?>",
            c: [{cN: "title", b: "[^ /><]+", r: 0}, b]
        }]
    }
});
hljs.registerLanguage("markdown", function (a) {
    return {
        c: [{cN: "header", v: [{b: "^#{1,6}", e: "$"}, {b: "^.+?\\n[=-]{2,}$"}]}, {
            b: "<",
            e: ">",
            sL: "xml",
            r: 0
        }, {cN: "bullet", b: "^([*+-]|(\\d+\\.))\\s+"}, {cN: "strong", b: "[*_]{2}.+?[*_]{2}"}, {
            cN: "emphasis",
            v: [{b: "\\*.+?\\*"}, {b: "_.+?_", r: 0}]
        }, {cN: "blockquote", b: "^>\\s+", e: "$"}, {
            cN: "code",
            v: [{b: "`.+?`"}, {b: "^( {4}|\t)", e: "$", r: 0}]
        }, {cN: "horizontal_rule", b: "^[-\\*]{3,}", e: "$"}, {
            b: "\\[.+?\\][\\(\\[].+?[\\)\\]]",
            rB: true,
            c: [{cN: "link_label", b: "\\[", e: "\\]", eB: true, rE: true, r: 0}, {
                cN: "link_url",
                b: "\\]\\(",
                e: "\\)",
                eB: true,
                eE: true
            }, {cN: "link_reference", b: "\\]\\[", e: "\\]", eB: true, eE: true,}],
            r: 10
        }, {
            b: "^\\[.+\\]:",
            e: "$",
            rB: true,
            c: [{cN: "link_reference", b: "\\[", e: "\\]", eB: true, eE: true}, {cN: "link_url", b: "\\s", e: "$"}]
        }]
    }
});
hljs.registerLanguage("css", function (a) {
    var b = "[a-zA-Z-][a-zA-Z0-9_-]*";
    var c = {cN: "function", b: b + "\\(", e: "\\)", c: ["self", a.NM, a.ASM, a.QSM]};
    return {
        cI: true,
        i: "[=/|']",
        c: [a.CBLCLM, {cN: "id", b: "\\#[A-Za-z0-9_-]+"}, {
            cN: "class",
            b: "\\.[A-Za-z0-9_-]+",
            r: 0
        }, {cN: "attr_selector", b: "\\[", e: "\\]", i: "$"}, {
            cN: "pseudo",
            b: ":(:)?[a-zA-Z0-9\\_\\-\\+\\(\\)\\\"\\']+"
        }, {cN: "at_rule", b: "@(font-face|page)", l: "[a-z-]+", k: "font-face page"}, {
            cN: "at_rule",
            b: "@",
            e: "[{;]",
            c: [{cN: "keyword", b: /\S+/}, {b: /\s/, eW: true, eE: true, r: 0, c: [c, a.ASM, a.QSM, a.NM]}]
        }, {cN: "tag", b: b, r: 0}, {
            cN: "rules",
            b: "{",
            e: "}",
            i: "[^\\s]",
            r: 0,
            c: [a.CBLCLM, {
                cN: "rule",
                b: "[^\\s]",
                rB: true,
                e: ";",
                eW: true,
                c: [{
                    cN: "attribute",
                    b: "[A-Z\\_\\.\\-]+",
                    e: ":",
                    eE: true,
                    i: "[^\\s]",
                    starts: {
                        cN: "value",
                        eW: true,
                        eE: true,
                        c: [c, a.NM, a.QSM, a.ASM, a.CBLCLM, {cN: "hexcolor", b: "#[0-9A-Fa-f]+"}, {
                            cN: "important",
                            b: "!important"
                        }]
                    }
                }]
            }]
        }]
    }
});
hljs.registerLanguage("http", function (a) {
    return {
        i: "\\S",
        c: [{cN: "status", b: "^HTTP/[0-9\\.]+", e: "$", c: [{cN: "number", b: "\\b\\d{3}\\b"}]}, {
            cN: "request",
            b: "^[A-Z]+ (.*?) HTTP/[0-9\\.]+$",
            rB: true,
            e: "$",
            c: [{cN: "string", b: " ", e: " ", eB: true, eE: true}]
        }, {
            cN: "attribute",
            b: "^\\w",
            e: ": ",
            eE: true,
            i: "\\n|\\s|=",
            starts: {cN: "string", e: "$"}
        }, {b: "\\n\\n", starts: {sL: "", eW: true}}]
    }
});
hljs.registerLanguage("java", function (b) {
    var a = "false synchronized int abstract float private char boolean static null if const for true while long throw strictfp finally protected import native final return void enum else break transient new catch instanceof byte super volatile case assert short package default double public try this switch continue throws";
    return {
        k: a,
        i: /<\//,
        c: [{
            cN: "javadoc",
            b: "/\\*\\*",
            e: "\\*/",
            c: [{cN: "javadoctag", b: "(^|\\s)@[A-Za-z]+"}],
            r: 10
        }, b.CLCM, b.CBLCLM, b.ASM, b.QSM, {
            bK: "protected public private",
            e: /[{;=]/,
            k: a,
            c: [{
                cN: "class",
                bK: "class interface",
                eW: true,
                i: /[:"<>]/,
                c: [{bK: "extends implements", r: 10}, b.UTM]
            }, {b: b.UIR + "\\s*\\(", rB: true, c: [b.UTM]}]
        }, b.CNM, {cN: "annotation", b: "@[A-Za-z]+"}]
    }
});
hljs.registerLanguage("php", function (b) {
    var e = {cN: "variable", b: "\\$+[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*"};
    var a = {cN: "preprocessor", b: /<\?(php)?|\?>/};
    var c = {
        cN: "string",
        c: [b.BE, a],
        v: [{b: 'b"', e: '"'}, {b: "b'", e: "'"}, b.inherit(b.ASM, {i: null}), b.inherit(b.QSM, {i: null})]
    };
    var d = {v: [b.BNM, b.CNM]};
    return {
        cI: true,
        k: "and include_once list abstract global private echo interface as static endswitch array null if endwhile or const for endforeach self var while isset public protected exit foreach throw elseif include __FILE__ empty require_once do xor return parent clone use __CLASS__ __LINE__ else break print eval new catch __METHOD__ case exception default die require __FUNCTION__ enddeclare final try switch continue endfor endif declare unset true false trait goto instanceof insteadof __DIR__ __NAMESPACE__ yield finally",
        c: [b.CLCM, b.HCM, {
            cN: "comment",
            b: "/\\*",
            e: "\\*/",
            c: [{cN: "phpdoc", b: "\\s@[A-Za-z]+"}, a]
        }, {cN: "comment", b: "__halt_compiler.+?;", eW: true, k: "__halt_compiler", l: b.UIR}, {
            cN: "string",
            b: "<<<['\"]?\\w+['\"]?$",
            e: "^\\w+;",
            c: [b.BE]
        }, a, e, {
            cN: "function",
            bK: "function",
            e: /[;{]/,
            i: "\\$|\\[|%",
            c: [b.UTM, {cN: "params", b: "\\(", e: "\\)", c: ["self", e, b.CBLCLM, c, d]}]
        }, {
            cN: "class",
            bK: "class interface",
            e: "{",
            i: /[:\(\$"]/,
            c: [{bK: "extends implements", r: 10}, b.UTM]
        }, {bK: "namespace", e: ";", i: /[\.']/, c: [b.UTM]}, {bK: "use", e: ";", c: [b.UTM]}, {b: "=>"}, c, d]
    }
});
hljs.registerLanguage("python", function (a) {
    var f = {cN: "prompt", b: /^(>>>|\.\.\.) /};
    var b = {
        cN: "string",
        c: [a.BE],
        v: [{b: /(u|b)?r?'''/, e: /'''/, c: [f], r: 10}, {b: /(u|b)?r?"""/, e: /"""/, c: [f], r: 10}, {
            b: /(u|r|ur)'/,
            e: /'/,
            r: 10
        }, {b: /(u|r|ur)"/, e: /"/, r: 10}, {b: /(b|br)'/, e: /'/,}, {b: /(b|br)"/, e: /"/,}, a.ASM, a.QSM]
    };
    var d = {cN: "number", r: 0, v: [{b: a.BNR + "[lLjJ]?"}, {b: "\\b(0o[0-7]+)[lLjJ]?"}, {b: a.CNR + "[lLjJ]?"}]};
    var e = {cN: "params", b: /\(/, e: /\)/, c: ["self", f, d, b]};
    var c = {e: /:/, i: /[${=;\n]/, c: [a.UTM, e]};
    return {
        k: {
            keyword: "and elif is global as in if from raise for except finally print import pass return exec else break not with class assert yield try while continue del or def lambda nonlocal|10 None True False",
            built_in: "Ellipsis NotImplemented"
        },
        i: /(<\/|->|\?)/,
        c: [f, d, b, a.HCM, a.inherit(c, {cN: "function", bK: "def", r: 10}), a.inherit(c, {
            cN: "class",
            bK: "class"
        }), {cN: "decorator", b: /@/, e: /$/}, {b: /\b(print|exec)\(/}]
    }
});
hljs.registerLanguage("sql", function (a) {
    return {
        cI: true,
        i: /[<>]/,
        c: [{
            cN: "operator",
            b: "\\b(begin|end|start|commit|rollback|savepoint|lock|alter|create|drop|rename|call|delete|do|handler|insert|load|replace|select|truncate|update|set|show|pragma|grant|merge)\\b(?!:)",
            e: ";",
            eW: true,
            k: {
                keyword: "all partial global month current_timestamp using go revoke smallint indicator end-exec disconnect zone with character assertion to add current_user usage input local alter match collate real then rollback get read timestamp session_user not integer bit unique day minute desc insert execute like ilike|2 level decimal drop continue isolation found where constraints domain right national some module transaction relative second connect escape close system_user for deferred section cast current sqlstate allocate intersect deallocate numeric public preserve full goto initially asc no key output collation group by union session both last language constraint column of space foreign deferrable prior connection unknown action commit view or first into float year primary cascaded except restrict set references names table outer open select size are rows from prepare distinct leading create only next inner authorization schema corresponding option declare precision immediate else timezone_minute external varying translation true case exception join hour default double scroll value cursor descriptor values dec fetch procedure delete and false int is describe char as at in varchar null trailing any absolute current_time end grant privileges when cross check write current_date pad begin temporary exec time update catalog user sql date on identity timezone_hour natural whenever interval work order cascade diagnostics nchar having left call do handler load replace truncate start lock show pragma exists number trigger if before after each row merge matched database",
                aggregate: "count sum min max avg"
            },
            c: [{cN: "string", b: "'", e: "'", c: [a.BE, {b: "''"}]}, {
                cN: "string",
                b: '"',
                e: '"',
                c: [a.BE, {b: '""'}]
            }, {cN: "string", b: "`", e: "`", c: [a.BE]}, a.CNM]
        }, a.CBLCLM, {cN: "comment", b: "--", e: "$"}]
    }
});
hljs.registerLanguage("ini", function (a) {
    return {
        cI: true,
        i: /\S/,
        c: [{cN: "comment", b: ";", e: "$"}, {cN: "title", b: "^\\[", e: "\\]"}, {
            cN: "setting",
            b: "^[a-z0-9\\[\\]_-]+[ \\t]*=[ \\t]*",
            e: "$",
            c: [{cN: "value", eW: true, k: "on off true false yes no", c: [a.QSM, a.NM], r: 0}]
        }]
    }
});
hljs.registerLanguage("perl", function (c) {
    var d = "getpwent getservent quotemeta msgrcv scalar kill dbmclose undef lc ma syswrite tr send umask sysopen shmwrite vec qx utime local oct semctl localtime readpipe do return format read sprintf dbmopen pop getpgrp not getpwnam rewinddir qqfileno qw endprotoent wait sethostent bless s|0 opendir continue each sleep endgrent shutdown dump chomp connect getsockname die socketpair close flock exists index shmgetsub for endpwent redo lstat msgctl setpgrp abs exit select print ref gethostbyaddr unshift fcntl syscall goto getnetbyaddr join gmtime symlink semget splice x|0 getpeername recv log setsockopt cos last reverse gethostbyname getgrnam study formline endhostent times chop length gethostent getnetent pack getprotoent getservbyname rand mkdir pos chmod y|0 substr endnetent printf next open msgsnd readdir use unlink getsockopt getpriority rindex wantarray hex system getservbyport endservent int chr untie rmdir prototype tell listen fork shmread ucfirst setprotoent else sysseek link getgrgid shmctl waitpid unpack getnetbyname reset chdir grep split require caller lcfirst until warn while values shift telldir getpwuid my getprotobynumber delete and sort uc defined srand accept package seekdir getprotobyname semop our rename seek if q|0 chroot sysread setpwent no crypt getc chown sqrt write setnetent setpriority foreach tie sin msgget map stat getlogin unless elsif truncate exec keys glob tied closedirioctl socket readlink eval xor readline binmode setservent eof ord bind alarm pipe atan2 getgrent exp time push setgrent gt lt or ne m|0 break given say state when";
    var f = {cN: "subst", b: "[$@]\\{", e: "\\}", k: d};
    var g = {b: "->{", e: "}"};
    var a = {
        cN: "variable",
        v: [{b: /\$\d/}, {b: /[\$\%\@\*](\^\w\b|#\w+(\:\:\w+)*|{\w+}|\w+(\:\:\w*)*)/}, {b: /[\$\%\@\*][^\s\w{]/, r: 0}]
    };
    var e = {cN: "comment", b: "^(__END__|__DATA__)", e: "\\n$", r: 5};
    var h = [c.BE, f, a];
    var b = [a, c.HCM, e, {cN: "comment", b: "^\\=\\w", e: "\\=cut", eW: true}, g, {
        cN: "string",
        c: h,
        v: [{b: "q[qwxr]?\\s*\\(", e: "\\)", r: 5}, {b: "q[qwxr]?\\s*\\[", e: "\\]", r: 5}, {
            b: "q[qwxr]?\\s*\\{",
            e: "\\}",
            r: 5
        }, {b: "q[qwxr]?\\s*\\|", e: "\\|", r: 5}, {b: "q[qwxr]?\\s*\\<", e: "\\>", r: 5}, {
            b: "qw\\s+q",
            e: "q",
            r: 5
        }, {b: "'", e: "'", c: [c.BE]}, {b: '"', e: '"'}, {b: "`", e: "`", c: [c.BE]}, {
            b: "{\\w+}",
            c: [],
            r: 0
        }, {b: "-?\\w+\\s*\\=\\>", c: [], r: 0}]
    }, {
        cN: "number",
        b: "(\\b0[0-7_]+)|(\\b0x[0-9a-fA-F_]+)|(\\b[1-9][0-9_]*(\\.[0-9_]+)?)|[0_]\\b",
        r: 0
    }, {
        b: "(\\/\\/|" + c.RSR + "|\\b(split|return|print|reverse|grep)\\b)\\s*",
        k: "split return print reverse grep",
        r: 0,
        c: [c.HCM, e, {cN: "regexp", b: "(s|tr|y)/(\\\\.|[^/])*/(\\\\.|[^/])*/[a-z]*", r: 10}, {
            cN: "regexp",
            b: "(m|qr)?/",
            e: "/[a-z]*",
            c: [c.BE],
            r: 0
        }]
    }, {cN: "sub", bK: "sub", e: "(\\s*\\(.*?\\))?[;{]", r: 5}, {cN: "operator", b: "-\\w\\b", r: 0}];
    f.c = b;
    g.c = b;
    return {k: d, c: b}
});
hljs.registerLanguage("objectivec", function (a) {
    var d = {
        keyword: "int float while char export sizeof typedef const struct for union unsigned long volatile static bool mutable if do return goto void enum else break extern asm case short default double register explicit signed typename this switch continue wchar_t inline readonly assign self synchronized id nonatomic super unichar IBOutlet IBAction strong weak @private @protected @public @try @property @end @throw @catch @finally @synthesize @dynamic @selector @optional @required",
        literal: "false true FALSE TRUE nil YES NO NULL",
        built_in: "NSString NSDictionary CGRect CGPoint UIButton UILabel UITextView UIWebView MKMapView UISegmentedControl NSObject UITableViewDelegate UITableViewDataSource NSThread UIActivityIndicator UITabbar UIToolBar UIBarButtonItem UIImageView NSAutoreleasePool UITableView BOOL NSInteger CGFloat NSException NSLog NSMutableString NSMutableArray NSMutableDictionary NSURL NSIndexPath CGSize UITableViewCell UIView UIViewController UINavigationBar UINavigationController UITabBarController UIPopoverController UIPopoverControllerDelegate UIImage NSNumber UISearchBar NSFetchedResultsController NSFetchedResultsChangeType UIScrollView UIScrollViewDelegate UIEdgeInsets UIColor UIFont UIApplication NSNotFound NSNotificationCenter NSNotification UILocalNotification NSBundle NSFileManager NSTimeInterval NSDate NSCalendar NSUserDefaults UIWindow NSRange NSArray NSError NSURLRequest NSURLConnection UIInterfaceOrientation MPMoviePlayerController dispatch_once_t dispatch_queue_t dispatch_sync dispatch_async dispatch_once"
    };
    var c = /[a-zA-Z@][a-zA-Z0-9_]*/;
    var b = "@interface @class @protocol @implementation";
    return {
        k: d,
        l: c,
        i: "</",
        c: [a.CLCM, a.CBLCLM, a.CNM, a.QSM, {
            cN: "string",
            b: "'",
            e: "[^\\\\]'",
            i: "[^\\\\][^']"
        }, {
            cN: "preprocessor",
            b: "#import",
            e: "$",
            c: [{cN: "title", b: '"', e: '"'}, {cN: "title", b: "<", e: ">"}]
        }, {cN: "preprocessor", b: "#", e: "$"}, {
            cN: "class",
            b: "(" + b.split(" ").join("|") + ")\\b",
            e: "({|$)",
            k: b,
            l: c,
            c: [a.UTM]
        }, {cN: "variable", b: "\\." + a.UIR, r: 0}]
    }
});
hljs.registerLanguage("coffeescript", function (c) {
    var b = {
        keyword: "in if for while finally new do return else break catch instanceof throw try this switch continue typeof delete debugger super then unless until loop of by when and or is isnt not",
        literal: "true false null undefined yes no on off",
        reserved: "case default function var void with const let enum export import native __hasProp __extends __slice __bind __indexOf",
        built_in: "npm require console print module exports global window document"
    };
    var a = "[A-Za-z$_][0-9A-Za-z$_]*";
    var f = c.inherit(c.TM, {b: a});
    var e = {cN: "subst", b: /#\{/, e: /}/, k: b};
    var d = [c.BNM, c.inherit(c.CNM, {starts: {e: "(\\s*/)?", r: 0}}), {
        cN: "string",
        v: [{b: /'''/, e: /'''/, c: [c.BE]}, {b: /'/, e: /'/, c: [c.BE]}, {b: /"""/, e: /"""/, c: [c.BE, e]}, {
            b: /"/,
            e: /"/,
            c: [c.BE, e]
        }]
    }, {
        cN: "regexp",
        v: [{b: "///", e: "///", c: [e, c.HCM]}, {b: "//[gim]*", r: 0}, {b: "/\\S(\\\\.|[^\\n])*?/[gim]*(?=\\s|\\W|$)"}]
    }, {cN: "property", b: "@" + a}, {b: "`", e: "`", eB: true, eE: true, sL: "javascript"}];
    e.c = d;
    return {
        k: b,
        c: d.concat([{cN: "comment", b: "###", e: "###"}, c.HCM, {
            cN: "function",
            b: "(" + a + "\\s*=\\s*)?(\\(.*\\))?\\s*\\B[-=]>",
            e: "[-=]>",
            rB: true,
            c: [f, {cN: "params", b: "\\(", rB: true, c: [{b: /\(/, e: /\)/, k: b, c: ["self"].concat(d)}]}]
        }, {
            cN: "class",
            bK: "class",
            e: "$",
            i: /[:="\[\]]/,
            c: [{bK: "extends", eW: true, i: /[:="\[\]]/, c: [f]}, f]
        }, {cN: "attribute", b: a + ":", e: ":", rB: true, eE: true, r: 0}])
    }
});
hljs.registerLanguage("nginx", function (c) {
    var b = {cN: "variable", v: [{b: /\$\d+/}, {b: /\$\{/, e: /}/}, {b: "[\\$\\@]" + c.UIR}]};
    var a = {
        eW: true,
        l: "[a-z/_]+",
        k: {built_in: "on off yes no true false none blocked debug info notice warn error crit select break last permanent redirect kqueue rtsig epoll poll /dev/poll"},
        r: 0,
        i: "=>",
        c: [c.HCM, {cN: "string", c: [c.BE, b], v: [{b: /"/, e: /"/}, {b: /'/, e: /'/}]}, {
            cN: "url",
            b: "([a-z]+):/",
            e: "\\s",
            eW: true,
            eE: true
        }, {
            cN: "regexp",
            c: [c.BE, b],
            v: [{b: "\\s\\^", e: "\\s|{|;", rE: true}, {
                b: "~\\*?\\s+",
                e: "\\s|{|;",
                rE: true
            }, {b: "\\*(\\.[a-z\\-]+)+"}, {b: "([a-z\\-]+\\.)+\\*"}]
        }, {cN: "number", b: "\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}(:\\d{1,5})?\\b"}, {
            cN: "number",
            b: "\\b\\d+[kKmMgGdshdwy]*\\b",
            r: 0
        }, b]
    };
    return {
        c: [c.HCM, {b: c.UIR + "\\s", e: ";|{", rB: true, c: [c.inherit(c.UTM, {starts: a})], r: 0}],
        i: "[^\\s\\}]"
    }
});
hljs.registerLanguage("json", function (a) {
    var e = {literal: "true false null"};
    var d = [a.QSM, a.CNM];
    var c = {cN: "value", e: ",", eW: true, eE: true, c: d, k: e};
    var b = {
        b: "{",
        e: "}",
        c: [{cN: "attribute", b: '\\s*"', e: '"\\s*:\\s*', eB: true, eE: true, c: [a.BE], i: "\\n", starts: c}],
        i: "\\S"
    };
    var f = {b: "\\[", e: "\\]", c: [a.inherit(c, {cN: null})], i: "\\S"};
    d.splice(d.length, 0, b, f);
    return {c: d, k: e, i: "\\S"}
});
hljs.registerLanguage("apache", function (a) {
    var b = {cN: "number", b: "[\\$%]\\d+"};
    return {
        cI: true,
        c: [a.HCM, {cN: "tag", b: "</?", e: ">"}, {
            cN: "keyword",
            b: /\w+/,
            r: 0,
            k: {common: "order deny allow setenv rewriterule rewriteengine rewritecond documentroot sethandler errordocument loadmodule options header listen serverroot servername"},
            starts: {
                e: /$/,
                r: 0,
                k: {literal: "on off all"},
                c: [{cN: "sqbracket", b: "\\s\\[", e: "\\]$"}, {
                    cN: "cbracket",
                    b: "[\\$%]\\{",
                    e: "\\}",
                    c: ["self", b]
                }, b, a.QSM]
            }
        }],
        i: /\S/
    }
});
hljs.registerLanguage("cpp", function (a) {
    var b = {
        keyword: "false int float while private char catch export virtual operator sizeof dynamic_cast|10 typedef const_cast|10 const struct for static_cast|10 union namespace unsigned long throw volatile static protected bool template mutable if public friend do return goto auto void enum else break new extern using true class asm case typeid short reinterpret_cast|10 default double register explicit signed typename try this switch continue wchar_t inline delete alignof char16_t char32_t constexpr decltype noexcept nullptr static_assert thread_local restrict _Bool complex _Complex _Imaginary",
        built_in: "std string cin cout cerr clog stringstream istringstream ostringstream auto_ptr deque list queue stack vector map set bitset multiset multimap unordered_set unordered_map unordered_multiset unordered_multimap array shared_ptr abort abs acos asin atan2 atan calloc ceil cosh cos exit exp fabs floor fmod fprintf fputs free frexp fscanf isalnum isalpha iscntrl isdigit isgraph islower isprint ispunct isspace isupper isxdigit tolower toupper labs ldexp log10 log malloc memchr memcmp memcpy memset modf pow printf putchar puts scanf sinh sin snprintf sprintf sqrt sscanf strcat strchr strcmp strcpy strcspn strlen strncat strncmp strncpy strpbrk strrchr strspn strstr tanh tan vfprintf vprintf vsprintf"
    };
    return {
        aliases: ["c"],
        k: b,
        i: "</",
        c: [a.CLCM, a.CBLCLM, a.QSM, {cN: "string", b: "'\\\\?.", e: "'", i: "."}, {
            cN: "number",
            b: "\\b(\\d+(\\.\\d*)?|\\.\\d+)(u|U|l|L|ul|UL|f|F)"
        }, a.CNM, {
            cN: "preprocessor",
            b: "#",
            e: "$",
            c: [{b: "include\\s*<", e: ">", i: "\\n"}, a.CLCM]
        }, {
            cN: "stl_container",
            b: "\\b(deque|list|queue|stack|vector|map|set|bitset|multiset|multimap|unordered_map|unordered_set|unordered_multiset|unordered_multimap|array)\\s*<",
            e: ">",
            k: b,
            r: 10,
            c: ["self"]
        }]
    }
});
hljs.registerLanguage("makefile", function (a) {
    var b = {cN: "variable", b: /\$\(/, e: /\)/, c: [a.BE]};
    return {
        c: [a.HCM, {
            b: /^\w+\s*\W*=/,
            rB: true,
            r: 0,
            starts: {cN: "constant", e: /\s*\W*=/, eE: true, starts: {e: /$/, r: 0, c: [b],}}
        }, {cN: "title", b: /^[\w]+:\s*$/}, {cN: "phony", b: /^\.PHONY:/, e: /$/, k: ".PHONY", l: /[\.\w]+/}, {
            b: /^\t+/,
            e: /$/,
            c: [a.QSM, b]
        }]
    }
});
/* End */
;
; /* Start:/bitrix/templates/adaptive/include/public_&_object_list/public_&_object_list.js*/
$(document).on("click",".public-change-view",function () {
    var TYPE = $(this).attr("data-type");
    const isObjectList = (typeof arrSettingComponentJS !== 'undefined') && $.isArray(arrSettingComponentJS) && ($.inArray('object_list', arrSettingComponentJS) !== -1);

    $.cookie('ShowGrid'+window.COMPONENT_ID, TYPE, { expires: 666, path: '/' });

    $(".public-change-view").parent('li').removeClass("active");
    $(".public-change-view[data-type="+TYPE+"]").parent('li').addClass("active");

    if(TYPE == "L"){
        $(".publication-item > .col-md-3").show();
        $(".publication-item > .col-md-9").show();
        $(".publication-item > .view-table").hide();
        $(".publication-item").removeClass("view-ls");
        if (isObjectList) {
            $('.publication-item .text-muted').css('display', 'block');
        }
        DestroyGrid();
    }else if (TYPE == "LS"){
        $(".publication-item > .col-md-3").hide();
        $(".publication-item > .col-md-9").hide();
        $(".publication-item > .view-table").show();
        $(".publication-item").addClass("view-ls");
        if (isObjectList) {
            $('.publication-item .text-muted').css('display', 'block');
        }
        DestroyGrid();
    }else if (TYPE == "G"){
        $(".publication-item > .col-md-3").show();
        $(".publication-item > .col-md-9").show();
        $(".publication-item > .view-table").hide();
        $(".publication-item").removeClass("view-ls");
        if (isObjectList) {
            $('.publication-item .text-muted').css('display', 'none');
        }
        ShowGrid();
    }

    if ((typeof arrSettingComponentJS !== 'undefined') && $.isArray(arrSettingComponentJS) && ($.inArray('profile', arrSettingComponentJS) !== -1)){
        SetMasonry();
    }
});

function ShowGrid($NoChangeClass,$bfirst){
    if($('.grid-boxes').hasClass("active") && !$bfirst)
        return false;

    $('.grid-boxes').addClass('active view-g');
    /*$('.grid-boxes').masonry({
        isFitWidth: true,
        itemSelector: '.publication-item'
    });*/
}
function DestroyGrid($NoChangeClass){
    if(!$('.grid-boxes').hasClass("active"))
        return false;

    /*$('.grid-boxes').masonry('destroy');*/
    $('.grid-boxes').removeClass('active view-g').attr("style","");
}
/* End */
;
; /* Start:/bitrix/components/infostart/new.public.list/templates/.default/script.js*/


$(document).ready(function(){

    $(".public-filter-change-section").click(function(){
        if(parseInt($(this).attr("data-id")) > 0){
            $('#select-text-section').addClass("select2-unactive");
            $('#select-text-section').html($(this).html());
        }else{
            $('#select-text-section').removeClass("select2-unactive");
            $('#select-text-section').html("Категория");
        }

        $(".section-select-box a").removeClass('selected-option');
        $(this).addClass('selected-option');
        $('#section_id').val($(this).attr("data-id"));

        // $(".submit-button").removeClass("pulse-grow limited");
        // setTimeout(function(){$(".submit-button").addClass("pulse-grow limited");},1);
    });



    $(".open-additional-filter").click(function () {
        $(this).children('i').toggleClass('fa-arrow-up fa-arrow-down');
        $('.hidden-filter-props').slideToggle(700,'easeOutBack');
    });

    $(".public-filter-save-site").click(function(){
        var Button = $(this).closest('ul').prev('a');
        var FormString = $("#public-filter-form").serialize();
        Button.addClass("disabled");
        $.get("/bitrix/templates/adaptive/ajax/handlers.php?"+FormString+"&action=save_site_filter&sessid="+$("#public-filter-search").attr("data-sessid")).done(function(data) {
            if(data.length > 0){
                var ObAnswer = $.parseJSON(data);
                if (ObAnswer.DATA) {
                    $.smallBox({
                        title : "Фильтр успешно сохранен",
                        content : "Для удаления фильтра, необходимо его сохранить пустым.",
                        color : "#739E73",
                        icon : "fa fa-check",
                        timeout : 3000
                    });
                }
            }
            Button.removeClass("disabled");
        }).fail(function() {
            $.smallBox({
                title : "Ошибка сохранения",
                content : "<i class='fa fa-clock-o'></i> <i>Обновите страницу и повторите процедуру.</i>",
                color : "#C46A69",
                iconSmall : "fa fa-minus-circle",
                timeout : 3000
            });
            Button.removeClass("disabled");
        });
    });

    $('#public-filter-form').on("submit", function () {
        $("#public-filter-form input, #public-filter-form select").each(function() {
            let formObj = $("#public-filter-form");
            let obj = $(this);
            let objName = obj.get(0).name;
            let objVal = obj.val();

            if (
                obj.hasClass("disableOnSubmit")
                || objVal === ""
                || (obj.is("select") && objVal == 0)
            ) {
                obj.prop("disabled", true);
            }

            if (objName === "section_id" && obj.attr("data-new-urls") == 1) {
                let url = obj.find(":selected").attr("data-url");
                if (
                    typeof(url) != "undefined"
                ) {
                    if (url !== "") {
                        formObj.get(0).action = formObj.attr("data-url") + url + "/";
                    } else {
                        formObj.get(0).action = formObj.attr("data-url");
                    }
                    obj.prop("disabled", true);
                }
            }
        });

        if ($(this).serialize() === "") {
            document.location.href = $(this).get(0).action;
            return false;
        }
    });

    $("#public-filter-form input, #public-filter-form select").change(function(){
        // $(".submit-button").removeClass("pulse-grow limited");
        // setTimeout(function(){$(".submit-button").addClass("pulse-grow limited");},1);
        if (!this.classList.contains('noAutoSubmit')) {
            $('#public-filter-form').submit();
        }
    });

/*
    var AjaxPublicStatus = "ready";
    var TimeoutPublic    =   false;
    function GetSearchResultPublic(){
        AjaxPublicStatus = "request";
        $.get("/bitrix/templates/adaptive/ajax/handlers.php?action=search&sessid="+$("#public-filter-search").attr("data-sessid")+"&q="+$("#public-filter-search").val()).done(function(data) {
            AjaxPublicStatus = 'ready';
            $("#public-filter-search + .fa-spinner").addClass("hidden");
            if(data.length > 0) {
                var ObAnswer = $.parseJSON(data);
                if (ObAnswer.HTML_TO_INSERT) {
                    $("#public-filter-search-data").html(ObAnswer.HTML_TO_INSERT);
                    $("#public-filter-search").parent().addClass("open");
                }
            }
        }).fail(function() {
            AjaxPublicStatus = 'ready';
            $("#public-filter-search + .fa-spinner").addClass("hidden");
            $("#public-filter-search").parent().addClass("open");
        });
    }*/
    /*$("#public-filter-search").blur(function() {
        $("#public-filter-search-data").parent().removeClass("open");
    });
    $("#public-filter-search").focus(function() {
        if($("#public-filter-search-data > li").length > 0) {
            $("#public-filter-search-data").parent().addClass("open");
        }
    });*/
    /*$("#public-filter-search").keyup(function(){
        if(AjaxPublicStatus == "ready"){
            $("#public-filter-search + .fa-spinner").removeClass("hidden");
            AjaxPublicStatus = 'typing';
            TimeoutPublic = setTimeout(function(){
                GetSearchResultPublic();
            },1000);
        }else if(AjaxPublicStatus == 'typing'){
            clearTimeout(TimeoutPublic);
            TimeoutPublic = setTimeout(function(){
                GetSearchResultPublic();
            },1000);
        }else if(AjaxPublicStatus == "request"){
            return false;
        }

    });*/

    $("#public-filter-form").bind("reset", function() {
        $('#public-filter-form .select2').select2('val', 0);

    });
    $('.carousel').on('slid.bs.carousel', function () {
        $(".current-slide-number[data-slider="+$(this).attr("id")+"]").html($(this).find(".item.active").index() + 1);
    });
    $(".show-error-filter-save").click(function(){
        var url = $("#BACKURL").val();
            $.smallBox({
                title : "Ошибка!",
                content : "Необходимо авторизоваться для использования данного функционала. Хотите сделать это прямо сейчас?<p class='text-align-right'><a href='"+url+"' class='btn btn-default btn-sm'>Да</a> <a href='javascript:void(0);' class='btn btn-default btn-sm'>Нет</a></p>",
                color : "#C46A69",
                icon : "fa fa-warning shake animated",
                timeout : 10000
            });

            e.preventDefault();
        return false;
    });



    $('.add-to-cart').click(function() {
        var Pname = $(this).attr("data-name");
        $.get("/bitrix/templates/adaptive/ajax/handlers.php?action=add_to_cart&sessid="+$(this).attr("data-sessid")+"&id="+$(this).attr("data-pid"))
        .done(function(data) {

                var error = true;
                if(data.length > 0){
                    var ObAnswer = $.parseJSON(data);
                    if(ObAnswer.DATA){
                        $(".cart-count > em").remove();
                        $(".cart-count").append('<em>'+parseInt(ObAnswer.DATA)+'</em>');
                        $(".cart-count > i").addClass("icon-animated-wrench");
                        $.smallBox({
                            title : Pname + " добавлен в корзину",
                            content : "Для оформления заказа вы можете перейти в корзину, сделать это сейчас? <p class='text-align-right'><a href='/store/basket/' class='btn btn-default btn-sm'>Да</a> <a href='javascript:void(0);' class='btn btn-default btn-sm'>Нет</a></p>",
                            color : "#739E73",
                            timeout: 60000,
                            icon : "fa fa-shopping-cart icon-animated-wrench"
                        });
                        error = false;
                    }

                }

                if(error == true) {
                    $.smallBox({
                        title: "Ошибка",
                        content: "Произошла неизвестная ошибка при добавлении товара в корзину. Обновите страницу и попробуйте повторить операцию, или обратитесь к нам за помощью.",
                        color: "#C46A69",
                        //timeout: 60000,
                        icon: "fa fa-minus-circle"
                    });
                }

        }).fail(function() {
                $.smallBox({
                    title : "Ошибка",
                    content : "Произошла неизвестная ошибка при добавлении товара в корзину. Обновите страницу и попробуйте повторить операцию, или обратитесь к нам за помощью.",
                    color : "#C46A69",
                    //timeout: 60000,
                    icon : "fa fa-minus-circle"
                });
        });
        return false;
    });

/*
    function reloadPopover($ID){
        $.ajax({
            type: "GET",
            cache: false,
            url: '/bitrix/ajax/user_fav_folders.php',
            data: {pid: $ID},
            success: function(data){
                var _popover = $('.popover-fav');
                if(_popover.length > 0 && _popover.attr('data-pid') == $ID){
                    $(document).find('.popover-fav .popover-content').html(data);
                }else{
                    if(_popover.length > 0 && _popover.attr('data-pid') != $ID){
                        $('.popover-fav').popover('destroy');
                    }
                    $('.is-rating-but[data-pid="' + $ID + '"]').popover({
                        html : true,
                        sanitize : false,
                        placement : 'bottom',
                        content : data,
                        template: '<div class="popover popover-fav" data-pid="' + $ID + '" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
                    });
                    $('.is-rating-but[data-pid="' + $ID + '"]').popover('show');
                }
            }
        });
    }

    $('body').on('click', function (e) {
        if (
            !$(e.target).hasClass('is-rating-but') && $(e.target).parents('.popover-fav.in').length === 0 &&
            !$(e.target).hasClass('divMessageBox') && $(e.target).parents('.divMessageBox').length === 0 &&
            !$(e.target).hasClass('is-rating-but') && $(e.target).parents('.is-rating-but').length === 0
        ) {
            $('.popover-fav').popover('destroy');
        }
    });

    $(document).on('click', '.add-fav', function(){
        var pid = $(this).attr('data-pid');
        var fid = $(this).attr('data-id');
        if(!ButtLock) {
            $.get("/ajax/pub_rate.php?id=" + pid + "&sessid=" + BX.bitrix_sessid() + "&type=p&folder_id=" + fid, function (answer) {
                if (answer == "ok") {
                    $(".open-rating-table").html(parseInt($(".open-rating-table").html(), 10) + 1);
                    $.smallBox({
                        title: "Спасибо!",
                        content: "Ваш голос принят.",
                        color: "#659265",
                        icon: "fa fa-check fadeInRight animated",
                        timeout: 4000
                    });
                    $('.is-rating-but[data-pid="' + pid + '"]').addClass("is-voted");
                    var rating = $('.is-rating-count' + pid);
                    rating.html(parseInt(rating.attr('data-rating'),10)+1);
                } else {
                    $.smallBox({
                        title: "Ошибка!",
                        content: answer,
                        color: "#C46A69",
                        icon: "fa fa-warning fadeInRight animated",
                        timeout: 4000
                    });
                }
                reloadPopover(pid);
                ButtLock = false;
            });
        }
        ButtLock = true;
    });

    $(document).on('click', '.add-fav-folder', function(){
        var pid = $(this).attr('data-pid');
        $.SmartMessageBox(
            {
                title : "Внимание!",
                content : "Создать новую папку?",
                buttons : '[Нет][Да]',
                input : "text",
                inputValue : '',
                placeholder : "Имя папки"
            },
            function(ButtonPressed, Value) {
                if (ButtonPressed === "Да") {
                    if(!Value){
                        return false;
                    }
                    $.get("/ajax/pub_rate.php?id="+ pid  +"&sessid="+ BX.bitrix_sessid() +"&type=p&new_folder="+Value,function(answer){
                        if(answer == "ok"){
                            $(".open-rating-table").html(parseInt($(".open-rating-table").html(),10)+1);
                            $.smallBox({
                                title : "Спасибо!",
                                content : "Ваш голос принят.",
                                color : "#659265",
                                icon : "fa fa-check fadeInRight animated",
                                timeout : 4000
                            });
                            $('.is-rating-but[data-pid="' + pid + '"]').addClass("is-voted");
                            var rating = $('.is-rating-count' + pid);
                            rating.html(parseInt(rating.attr('data-rating'),10)+1);
                        } else {

                            $.smallBox({
                                title : "Ошибка!",
                                content : answer,
                                color : "#C46A69",
                                icon : "fa fa-warning fadeInRight animated",
                                timeout : 4000
                            });
                        }
                        reloadPopover(pid);
                    });
                }
                if (ButtonPressed === "Нет") {
                    return false;
                }
            }
        )
    });

    //VP 2015-11-18 favorites
    var ButtLock = false;
    $(document).on('click',".is-rating-but", function(e) {
        var type = 'p',
        PID = $(this).data('pid');
        if (!ButtLock && PID) {
            ButtLock = true;
            if($(this).hasClass("is-voted")){
                type = 'm';
            }
            var obj = this;
            if(type == 'm'){
                $.get("/ajax/pub_rate.php?id=" + PID + "&sessid=" + $(this).data('sessid') + "&type=" + type, function(response){
                    if (response == "ok") {
                        $(".is-rating-count" + PID).html(parseInt($(".is-rating-count" + PID).html(), 10) - 1);
                        $.smallBox({
                            title : "Спасибо!",
                            content : "Ваш голос отменен.",
                            color : "#659265",
                            icon : "fa fa-check fadeInRight animated",
                            timeout : 4000
                        });
                        $(obj).toggleClass("is-voted");
                    } else {
                        $.smallBox({
                            title : "Ошибка!",
                            content : response,
                            color : "#C46A69",
                            icon : "fa fa-warning fadeInRight animated",
                            timeout : 4000
                        });
                    }
                    ButtLock = false;
                });
            }else{
                reloadPopover(PID);
                ButtLock = false;
            }

        }
        e.preventDefault();
    });
*/

    $("li.active .public-change-view:first").click();
});

function advancedSearchGetClearedValue(name) {
    let val = $('#advancedSearch').find('input[name="' + name + '"]').val();
    val = val.replace(/\s\s+/g, ' ').replace(/[^A-Za-zА-яа-я0-9ёЁ\s.,-]/g,'').replace(/-/g, ' ').trim();
    if (val != "") {
        val = val.split(" ");;
    }
    return val;
}

function advancedSearchConstruct() {
    let q = "";

    let allContains = advancedSearchGetClearedValue("allContains");
    if (Array.isArray(allContains) && allContains.length) {
        q += ' (';
        allContains.forEach(function(item) {
            q += item + ' ';
        });
        q = q.replace(/.$/,')');
    }

    let allPhrase = advancedSearchGetClearedValue("allPhrase");
    if (Array.isArray(allPhrase) && allPhrase.length) {
        q += ' ("';
        allPhrase.forEach(function(item) {
            q += item + ' ';
        });
        q = q.replace(/.$/,'")');
    }

    let allNot = advancedSearchGetClearedValue("allNot");
    if (Array.isArray(allNot) && allNot.length) {
        q += ' (';
        allNot.forEach(function(item) {
            q += '-' + item + ' ';
        });
        q = q.replace(/.$/,')');
    }

    let allOr = advancedSearchGetClearedValue("allOr");
    if (Array.isArray(allOr) && allOr.length) {
        let i = 0;
        q += ' (';
        allOr.forEach(function(item) {
            i++;
            if (i == 1) {
                q += item + ' ';
            } else {
                q += '| ' + item + ' ';
            }
        });
        q = q.replace(/.$/,')');
    }


    let titleContains = advancedSearchGetClearedValue("titleContains");
    if (Array.isArray(titleContains) && titleContains.length) {
        q += ' @title (';
        titleContains.forEach(function(item) {
            q += item + ' ';
        });
        q = q.replace(/.$/,')');
    }

    let titlePhrase = advancedSearchGetClearedValue("titlePhrase");
    if (Array.isArray(titlePhrase) && titlePhrase.length) {
        q += ' @title ("';
        titlePhrase.forEach(function(item) {
            q += item + ' ';
        });
        q = q.replace(/.$/,'")');
    }

    let titleNot = advancedSearchGetClearedValue("titleNot");
    if (Array.isArray(titleNot) && titleNot.length) {
        q += ' @title (';
        titleNot.forEach(function(item) {
            q += '-' + item + ' ';
        });
        q = q.replace(/.$/,')');
    }

    let titleOr = advancedSearchGetClearedValue("titleOr");
    if (Array.isArray(titleOr) && titleOr.length) {
        let i = 0;
        q += ' @title (';
        titleOr.forEach(function(item) {
            i++;
            if (i == 1) {
                q += item + ' ';
            } else {
                q += '| ' + item + ' ';
            }
        });
        q = q.replace(/.$/,')');
    }

    let bodyContains = advancedSearchGetClearedValue("bodyContains");
    if (Array.isArray(bodyContains) && bodyContains.length) {
        q += ' @body (';
        bodyContains.forEach(function(item) {
            q += item + ' ';
        });
        q = q.replace(/.$/,')');
    }

    let bodyPhrase = advancedSearchGetClearedValue("bodyPhrase");
    if (Array.isArray(bodyPhrase) && bodyPhrase.length) {
        q += ' @body ("';
        bodyPhrase.forEach(function(item) {
            q += item + ' ';
        });
        q = q.replace(/.$/,'")');
    }

    let bodyNot = advancedSearchGetClearedValue("bodyNot");
    if (Array.isArray(bodyNot) && bodyNot.length) {
        q += ' @body (';
        bodyNot.forEach(function(item) {
            q += '-' + item + ' ';
        });
        q = q.replace(/.$/,')');
    }

    let bodyOr = advancedSearchGetClearedValue("bodyOr");
    if (Array.isArray(bodyOr) && bodyOr.length) {
        let i = 0;
        q += ' @body (';
        bodyOr.forEach(function(item) {
            i++;
            if (i == 1) {
                q += item + ' ';
            } else {
                q += '| ' + item + ' ';
            }
        });
        q = q.replace(/.$/,')');
    }


    if (q != "") {
        q = '/' + q;
        $('#public-filter-search-data').addClass('hidden');
        $('#public-filter-search').val(q);
    } else {
        $('#public-filter-search').val(q);
        $('#public-filter-search-data').removeClass('hidden');
    }
}
/* End */
;
; /* Start:/bitrix/components/infostart/asd.forum.mess.list/templates/redesign_adpt/script.js*/
!function(e){if("object"==typeof exports&&"undefined"!=typeof module)module.exports=e();else if("function"==typeof define&&define.amd)define([],e);else{var t;t="undefined"!=typeof window?window:"undefined"!=typeof global?global:"undefined"!=typeof self?self:this,t.Clipboard=e()}}(function(){var e,t,n;return function e(t,n,i){function o(a,c){if(!n[a]){if(!t[a]){var l="function"==typeof require&&require;if(!c&&l)return l(a,!0);if(r)return r(a,!0);var s=new Error("Cannot find module '"+a+"'");throw s.code="MODULE_NOT_FOUND",s}var u=n[a]={exports:{}};t[a][0].call(u.exports,function(e){var n=t[a][1][e];return o(n?n:e)},u,u.exports,e,t,n,i)}return n[a].exports}for(var r="function"==typeof require&&require,a=0;a<i.length;a++)o(i[a]);return o}({1:[function(e,t,n){function i(e,t){for(;e&&e!==document;){if(e.matches(t))return e;e=e.parentNode}}if(Element&&!Element.prototype.matches){var o=Element.prototype;o.matches=o.matchesSelector||o.mozMatchesSelector||o.msMatchesSelector||o.oMatchesSelector||o.webkitMatchesSelector}t.exports=i},{}],2:[function(e,t,n){function i(e,t,n,i,r){var a=o.apply(this,arguments);return e.addEventListener(n,a,r),{destroy:function(){e.removeEventListener(n,a,r)}}}function o(e,t,n,i){return function(n){n.delegateTarget=r(n.target,t),n.delegateTarget&&i.call(e,n)}}var r=e("./closest");t.exports=i},{"./closest":1}],3:[function(e,t,n){n.node=function(e){return void 0!==e&&e instanceof HTMLElement&&1===e.nodeType},n.nodeList=function(e){var t=Object.prototype.toString.call(e);return void 0!==e&&("[object NodeList]"===t||"[object HTMLCollection]"===t)&&"length"in e&&(0===e.length||n.node(e[0]))},n.string=function(e){return"string"==typeof e||e instanceof String},n.fn=function(e){var t=Object.prototype.toString.call(e);return"[object Function]"===t}},{}],4:[function(e,t,n){function i(e,t,n){if(!e&&!t&&!n)throw new Error("Missing required arguments");if(!c.string(t))throw new TypeError("Second argument must be a String");if(!c.fn(n))throw new TypeError("Third argument must be a Function");if(c.node(e))return o(e,t,n);if(c.nodeList(e))return r(e,t,n);if(c.string(e))return a(e,t,n);throw new TypeError("First argument must be a String, HTMLElement, HTMLCollection, or NodeList")}function o(e,t,n){return e.addEventListener(t,n),{destroy:function(){e.removeEventListener(t,n)}}}function r(e,t,n){return Array.prototype.forEach.call(e,function(e){e.addEventListener(t,n)}),{destroy:function(){Array.prototype.forEach.call(e,function(e){e.removeEventListener(t,n)})}}}function a(e,t,n){return l(document.body,e,t,n)}var c=e("./is"),l=e("delegate");t.exports=i},{"./is":3,delegate:2}],5:[function(e,t,n){function i(e){var t;if("SELECT"===e.nodeName)e.focus(),t=e.value;else if("INPUT"===e.nodeName||"TEXTAREA"===e.nodeName)e.focus(),e.setSelectionRange(0,e.value.length),t=e.value;else{e.hasAttribute("contenteditable")&&e.focus();var n=window.getSelection(),i=document.createRange();i.selectNodeContents(e),n.removeAllRanges(),n.addRange(i),t=n.toString()}return t}t.exports=i},{}],6:[function(e,t,n){function i(){}i.prototype={on:function(e,t,n){var i=this.e||(this.e={});return(i[e]||(i[e]=[])).push({fn:t,ctx:n}),this},once:function(e,t,n){function i(){o.off(e,i),t.apply(n,arguments)}var o=this;return i._=t,this.on(e,i,n)},emit:function(e){var t=[].slice.call(arguments,1),n=((this.e||(this.e={}))[e]||[]).slice(),i=0,o=n.length;for(i;i<o;i++)n[i].fn.apply(n[i].ctx,t);return this},off:function(e,t){var n=this.e||(this.e={}),i=n[e],o=[];if(i&&t)for(var r=0,a=i.length;r<a;r++)i[r].fn!==t&&i[r].fn._!==t&&o.push(i[r]);return o.length?n[e]=o:delete n[e],this}},t.exports=i},{}],7:[function(t,n,i){!function(o,r){if("function"==typeof e&&e.amd)e(["module","select"],r);else if("undefined"!=typeof i)r(n,t("select"));else{var a={exports:{}};r(a,o.select),o.clipboardAction=a.exports}}(this,function(e,t){"use strict";function n(e){return e&&e.__esModule?e:{default:e}}function i(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}var o=n(t),r="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(e){return typeof e}:function(e){return e&&"function"==typeof Symbol&&e.constructor===Symbol&&e!==Symbol.prototype?"symbol":typeof e},a=function(){function e(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}return function(t,n,i){return n&&e(t.prototype,n),i&&e(t,i),t}}(),c=function(){function e(t){i(this,e),this.resolveOptions(t),this.initSelection()}return a(e,[{key:"resolveOptions",value:function e(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{};this.action=t.action,this.emitter=t.emitter,this.target=t.target,this.text=t.text,this.trigger=t.trigger,this.selectedText=""}},{key:"initSelection",value:function e(){this.text?this.selectFake():this.target&&this.selectTarget()}},{key:"selectFake",value:function e(){var t=this,n="rtl"==document.documentElement.getAttribute("dir");this.removeFake(),this.fakeHandlerCallback=function(){return t.removeFake()},this.fakeHandler=document.body.addEventListener("click",this.fakeHandlerCallback)||!0,this.fakeElem=document.createElement("textarea"),this.fakeElem.style.fontSize="12pt",this.fakeElem.style.border="0",this.fakeElem.style.padding="0",this.fakeElem.style.margin="0",this.fakeElem.style.position="absolute",this.fakeElem.style[n?"right":"left"]="-9999px";var i=window.pageYOffset||document.documentElement.scrollTop;this.fakeElem.addEventListener("focus",window.scrollTo(0,i)),this.fakeElem.style.top=i+"px",this.fakeElem.setAttribute("readonly",""),this.fakeElem.value=this.text,document.body.appendChild(this.fakeElem),this.selectedText=(0,o.default)(this.fakeElem),this.copyText()}},{key:"removeFake",value:function e(){this.fakeHandler&&(document.body.removeEventListener("click",this.fakeHandlerCallback),this.fakeHandler=null,this.fakeHandlerCallback=null),this.fakeElem&&(document.body.removeChild(this.fakeElem),this.fakeElem=null)}},{key:"selectTarget",value:function e(){this.selectedText=(0,o.default)(this.target),this.copyText()}},{key:"copyText",value:function e(){var t=void 0;try{t=document.execCommand(this.action)}catch(e){t=!1}this.handleResult(t)}},{key:"handleResult",value:function e(t){this.emitter.emit(t?"success":"error",{action:this.action,text:this.selectedText,trigger:this.trigger,clearSelection:this.clearSelection.bind(this)})}},{key:"clearSelection",value:function e(){this.target&&this.target.blur(),window.getSelection().removeAllRanges()}},{key:"destroy",value:function e(){this.removeFake()}},{key:"action",set:function e(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:"copy";if(this._action=t,"copy"!==this._action&&"cut"!==this._action)throw new Error('Invalid "action" value, use either "copy" or "cut"')},get:function e(){return this._action}},{key:"target",set:function e(t){if(void 0!==t){if(!t||"object"!==("undefined"==typeof t?"undefined":r(t))||1!==t.nodeType)throw new Error('Invalid "target" value, use a valid Element');if("copy"===this.action&&t.hasAttribute("disabled"))throw new Error('Invalid "target" attribute. Please use "readonly" instead of "disabled" attribute');if("cut"===this.action&&(t.hasAttribute("readonly")||t.hasAttribute("disabled")))throw new Error('Invalid "target" attribute. You can\'t cut text from elements with "readonly" or "disabled" attributes');this._target=t}},get:function e(){return this._target}}]),e}();e.exports=c})},{select:5}],8:[function(t,n,i){!function(o,r){if("function"==typeof e&&e.amd)e(["module","./clipboard-action","tiny-emitter","good-listener"],r);else if("undefined"!=typeof i)r(n,t("./clipboard-action"),t("tiny-emitter"),t("good-listener"));else{var a={exports:{}};r(a,o.clipboardAction,o.tinyEmitter,o.goodListener),o.clipboard=a.exports}}(this,function(e,t,n,i){"use strict";function o(e){return e&&e.__esModule?e:{default:e}}function r(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function a(e,t){if(!e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return!t||"object"!=typeof t&&"function"!=typeof t?e:t}function c(e,t){if("function"!=typeof t&&null!==t)throw new TypeError("Super expression must either be null or a function, not "+typeof t);e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,enumerable:!1,writable:!0,configurable:!0}}),t&&(Object.setPrototypeOf?Object.setPrototypeOf(e,t):e.__proto__=t)}function l(e,t){var n="data-clipboard-"+e;if(t.hasAttribute(n))return t.getAttribute(n)}var s=o(t),u=o(n),f=o(i),d=function(){function e(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}return function(t,n,i){return n&&e(t.prototype,n),i&&e(t,i),t}}(),h=function(e){function t(e,n){r(this,t);var i=a(this,(t.__proto__||Object.getPrototypeOf(t)).call(this));return i.resolveOptions(n),i.listenClick(e),i}return c(t,e),d(t,[{key:"resolveOptions",value:function e(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{};this.action="function"==typeof t.action?t.action:this.defaultAction,this.target="function"==typeof t.target?t.target:this.defaultTarget,this.text="function"==typeof t.text?t.text:this.defaultText}},{key:"listenClick",value:function e(t){var n=this;this.listener=(0,f.default)(t,"click",function(e){return n.onClick(e)})}},{key:"onClick",value:function e(t){var n=t.delegateTarget||t.currentTarget;this.clipboardAction&&(this.clipboardAction=null),this.clipboardAction=new s.default({action:this.action(n),target:this.target(n),text:this.text(n),trigger:n,emitter:this})}},{key:"defaultAction",value:function e(t){return l("action",t)}},{key:"defaultTarget",value:function e(t){var n=l("target",t);if(n)return document.querySelector(n)}},{key:"defaultText",value:function e(t){return l("text",t)}},{key:"destroy",value:function e(){this.listener.destroy(),this.clipboardAction&&(this.clipboardAction.destroy(),this.clipboardAction=null)}}]),t}(u.default);e.exports=h})},{"./clipboard-action":7,"good-listener":4,"tiny-emitter":6}]},{},[8])(8)});
function reply2comment(number) {
	$(".post-form-wrap").parent();
	$(window).scrollTop($("textarea[name=POST_MESSAGE]").offset().top-130);
	if ($("textarea[name=POST_MESSAGE]").length > 0)
	{
		$("textarea[name=POST_MESSAGE]").val($("textarea[name=POST_MESSAGE]").val()+'('+number+')' + ' ') ;
	}

	return false;
}
$(document).on("click",".noauth",function () {
	$.smallBox({
		title : "Ошибка!",
		content : "Для продолжения необходимо авторизоваться.",
		color : "#C46A69",
		icon : "fa fa-warning shake animated",
		timeout : 10000
	});
	return false;
});
$(document).on("change",".input-multi-items", function () {
	if ($(".input-multi-items:checked").length > 0) {
		$(".block-multi-action").show();
		$(".btn-multi-action").attr('disabled', false);
	} else {
		$(".block-multi-action").hide();
		$(".btn-multi-action").attr('disabled', true);
	}
});
$(document).on("click",".ddmenu-item-onclick", function () {
	var action = $(this).data('action');
    var path = '?ACTION=' + action + '&sessid=' + BX.bitrix_sessid() + '&' + $('.input-multi-items').serialize();
    var ACTION_URL = $(this).data('href') + path;
	if(action == "MSDEL"){
        $.SmartMessageBox({
            title : "Внимание! Операция не имеет обратного действия.",
            content : "Вы уверены, что хотите продолжить?",
            buttons : "[Отмена][Да]",
        }, function(ButtonPress, Value) {
            if(ButtonPress == 'Да'){
                location = ACTION_URL;
            }else{
                return false;
            }
        });
        return false;
	}
	else if (action == 'MHIDE') {
		var modal = $("#sendHideMsg");
		modal.modal('show');
		var inputComment = modal.find("[name='COMMENT']");
		var comment = '';

		var ClickHandler = function (event){
			event.preventDefault();
			comment = $(inputComment).val().trim();
			ACTION_URL = ACTION_URL + "&COMMENT=" + comment;
			modal.find("[type='submit']").attr("disabled", "disabled").text('Выполнение, ожидайте.');
			location = ACTION_URL;
		};
		var Submithandler = function (event) {
			event.preventDefault();
		};

		modal.find('form').on('submit', Submithandler);
		modal.find('[type="submit"]').on('click', ClickHandler);

		return false;
	}

	location = ACTION_URL;
});
$(document).on("click",".fm-open-answer:not(.opened)",function () {
	if($(this).attr("data-aid")) {
		var Btn = $(this);
		var CurrMess = $(this).parents(".show-hide-props");
		Btn.addClass("opened");
		$(this).html('<i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i>');
		if ($(this).attr("data-aid").length > 0) {
			$.post("?ACTION=GET_LAST_MESSAGE&MIDs=" + $(this).attr("data-aid"), function (data) {
				var messData = $(data);
				CurrMess.after("<div class='fm-answers-wrap'></div>");
				CurrMess.next().html(messData);
				$(messData).css({"background-color": "#ebf4eb"}).animate({"background-color": ""}, 1500, function () {
					$(this).css("background-color", "");
				});
				Btn.parents(".well").css({"border-bottom": "none", "box-shadow": "none"});
				Btn.remove();
				$('.comment-ref').cluetip({
					activation: 'click',
					width: 350,
					attribute: 'href',
					closeText: '<i class="fa fa-times"></i>',
					closePosition: 'title',
					sticky: true,
					ajaxCache: false,
				});
			});
		}
		return false;
	}
});
$(document).ready(function () {
	new Clipboard(".fm-mess-lnk");
	ReplaceLinkToImg();

	$(".post-form-wrap").find(".fm-cancel-post-form").css("visibility", "hidden");

	const urlParams = new URLSearchParams(window.location.search);
    const reply_comment = urlParams.get('reply_comment');
	if (reply_comment) reply2comment(reply_comment);
});
$(document).on("click",".fm-mess-lnk",function () {
	return false;
});
function infostart_rate_comment(comm_id, vote) {

	$.get("/bitrix/ajax/ajax_rate.php", {CID:comm_id, TYPE:vote}, function(answer) {
		var numPlus = (isNaN(parseInt($(".counter-plus[data-id=" + comm_id + "]:first").text()))) ? 0 : parseInt($(".counter-plus[data-id=" + comm_id + "]:first").text());
		var numMinus = (isNaN(parseInt($(".counter-minus[data-id=" + comm_id + "]:first").text()))) ? 0 : parseInt($(".counter-minus[data-id=" + comm_id + "]:first").text());
		if(answer == "Спасибо. Ваш голос принят.") {
			if (vote === 1) {
				$(".counter-plus[data-id=" + comm_id + "]").html(numPlus + 1);
				$(".counter-plus[data-id=" + comm_id + "]").parent().addClass('color');
			} else {
				$(".counter-minus[data-id=" + comm_id + "]").html(numMinus + 1);
				$(".counter-minus[data-id=" + comm_id + "]").parent().addClass('color');
			}

		}else if (answer == "Ваш голос отменен."){
			if (vote === 1) {
				$(".counter-minus[data-id=" + comm_id + "]").html((numMinus - 1)==0?'':(numMinus - 1));
				if((numMinus - 1)==0)
					$(".counter-minus[data-id=" + comm_id + "]").parent().removeClass('color');
			} else {
				$(".counter-plus[data-id=" + comm_id + "]").html((numPlus - 1)==0?'':(numPlus - 1));
				if((numPlus - 1)==0)
					$(".counter-plus[data-id=" + comm_id + "]").parent().removeClass('color');
			}
		}else {
			$.smallBox({
				title: answer,
				content: '<br/>',
				color: "#5384AF",
				icon: "fa fa-info bounce animated",
				timeout: 4000
			});
		}
		var numPlus = (isNaN(parseInt($(".counter-plus[data-id=" + comm_id + "]:first").text()))) ? 0 : parseInt($(".counter-plus[data-id=" + comm_id + "]:first").text());
		var numMinus = (isNaN(parseInt($(".counter-minus[data-id=" + comm_id + "]:first").text()))) ? 0 : parseInt($(".counter-minus[data-id=" + comm_id + "]:first").text());
		if((numPlus - numMinus)<0)
			$(".counter-plus[data-id=" + comm_id + "]").parents(".show-hide-props").addClass("unrated");
		else
			$(".counter-plus[data-id=" + comm_id + "]").parents(".show-hide-props").removeClass("unrated");

	});
}
function reply2author(name) {
    name = name.replace(/&lt;/gi, "<").replace(/&gt;/gi, ">").replace(/&quot;/gi, "\"");
	if ($("textarea[name=POST_MESSAGE]").length > 0)
	{
		$("textarea[name=POST_MESSAGE]").val($("textarea[name=POST_MESSAGE]").val() + name + " \n");
	}
	return false;
}
$(document).ready(function(){
        $("body").on('click','.spoilerCaption',function () {
			$(this).parent().children('.low-height').height('auto');
               $(this).parent().children(".spoilerCaption").hide();
               $(this).parent().children(".spoilerCaptionSlide").show();
               $(this).blur();
               return false;
       });
		$("body").on('click','.spoilerCaptionSlide',function () {
			$(this).parent().children('.low-height').height('');
			$(this).parent().children(".spoilerCaption").show();
			$(this).parent().children(".spoilerCaptionSlide").hide();
			$(this).blur();
			return false;
		});
        $("body").on('click','.show-all-code',function () {
            $(this).children('i').toggleClass('fa-arrow-up fa-arrow-down');
            if($(this).children('i').hasClass('fa-arrow-up')){
                $(this).find('.text-btn').html('Скрыть');
			}else{
                $(this).find('.text-btn').html('Показать');
			}
			$(this).parent().parent().children('.begin').toggleClass('low-height');
       });
        $("body").on('click','.show-all-quote',function () {
            $(this).children('i').toggleClass('fa-arrow-up fa-arrow-down');
            if($(this).children('i').hasClass('fa-arrow-up')){
                $(this).find('.text-btn').html('Скрыть');
            }else{
                $(this).find('.text-btn').html('Показать');
            }
			$(this).parent().parent().children('.quote').toggleClass('low-height');
       });

		$("body").on('click','.do_hide_forum_message',function () {
			$(this).parent().children('.hide_forum_message').toggle('normal');
			$(this).blur();
			return false;
		});
		$("body").on('click','[data-type=SUBSCRIBE]',function () {
			var ACTION = $(this).attr("data-action");

			var ajaxSubscribeUrl = "./";
			if(location.pathname.startsWith("/connect_mobile/")){
                ajaxSubscribeUrl = "";
			}
			$.get(ajaxSubscribeUrl,
				{
					ACTION: ACTION,
					change_subscribe: "Y",
					sessid: BX.bitrix_sessid(),
				},
				'text'
			).done(function( data ) {
					$("#subscribe_button").before(data).remove();
				});
			return false;
		});
		$(".moderate-btn a.text-danger").click(function () {
			var HREF = $(this).attr("href");
			$.SmartMessageBox({
				title : "Внимание! Операция не имеет обратного действия.",
				content : "Вы уверены, что хотите продолжить?",
				buttons : "[Отмена][Да]",
			}, function(ButtonPress, Value) {
				if(ButtonPress == 'Да'){
					location = HREF;
				}else{
					return false;
				}



			});
			return false;
		});
	if ($(".donat-wrap").length > 0) {
		var maxHeightDW = $(".donate-pay-wrap").css("max-height");
		if ($(".donate-pay-wrap>section").height > maxHeightDW) {
			$(".btn-toggle-height-wrap").addClass("vp-shown");
		}
		$("body").on("click", ".btn-toggle-height", function () {
			$(".block-pay-wrap").toggleClass("vp-toggled");
			$(this).children('i').toggleClass('fa-arrow-up fa-arrow-down');
		});
	}
	$(document).on('click',".SendMoney",function () {
		var Uname = $(this).attr("data-name");
		var MaxSumm = $(this).attr("data-summ");
		var MID = $(this).attr("data-mid");
		var UID = $(this).attr("data-uid");

		var parentNodeAward = $(this).parents(".mes-block-out");
		$.SmartMessageBox({
			title : "Указанная сумма будет переведена пользователю "+Uname,
			content : "Укажите сумму $m для перевода, или переведите все средства.",
			buttons : "[Отмена][Отправить все][Отправить]",
			input : "text",
			inputValue: '',
			placeholder : "Максимум: "+MaxSumm+' $m'
		}, function(ButtonPress, Value) {
			if(ButtonPress == 'Отправить все'){
				$.get('?SESSID='+BX.bitrix_sessid()+'&UID='+UID+'&MID='+MID+"&ACTION=AWARD_PAY_ALL",function (data) {
					var arResult = $.parseJSON(data);
					if(arResult.ERROR){
						$.smallBox({
							title : "Ошибка!",
							content : arResult.ERROR,
							color : "#C46A69",
							icon : "fa fa-warning shake animated",
							timeout : 10000
						});
					}else{
						$.smallBox({
							title: "Спасибо!",
							content: arResult.OK,
							color: "#659265",
							icon: "fa fa-check fadeInRight animated",
							timeout: 4000
						});
						if (parentNodeAward.length > 0) {
							parentNodeAward.find('.user-sum-award').html('<b class="label label-sm">+' + MaxSumm + ' $m</b>');
							$(".SendMoney").attr("data-summ", 0);
						}
					}
				});
			}else if (ButtonPress == "Отправить"){
				$.get('?SESSID='+BX.bitrix_sessid()+'&SUMM='+Value+'&UID='+UID+'&MID='+MID+"&ACTION=AWARD_PAY_PART",function (data) {
					var arResult = $.parseJSON(data);
					if(arResult.ERROR){
						$.smallBox({
							title : "Ошибка!",
							content : arResult.ERROR,
							color : "#C46A69",
							icon : "fa fa-warning shake animated",
							timeout : 10000
						});
					}else{
						$.smallBox({
							title: "Спасибо!",
							content: arResult.OK,
							color: "#659265",
							icon: "fa fa-check fadeInRight animated",
							timeout: 4000
						});
						if (parentNodeAward.length > 0) {
							var sumAward = (Math.round(Value * 100) / 100);
							parentNodeAward.find('.user-sum-award').html('<b class="label label-sm">+' + sumAward + ' $m</b>');
							$(".SendMoney").attr("data-summ", (MaxSumm - sumAward).toFixed(2));
						}
					}
				});
			}



		});
		return false;
	});
	$(document).on('click',"#payed_topic_link",function () {
		var MaxSumm = $(this).attr("data-summ");
		$.SmartMessageBox({
			title : "Добавить вознаграждение в тему",
			content : "Укажите количество $m <small>(будет списано с вашего счета)</small>",
			buttons : "[Отмена][Добавить]",
			input : "text",
			inputValue: '',
			placeholder : "Максимум: "+MaxSumm+' $m'
		}, function(ButtonPress, Value) {
			if (ButtonPress == "Добавить"){
				$.get('?SESSID='+BX.bitrix_sessid()+'&SUMM='+Value+'&ACTION=ADD_PAY_FOR_DECISION',function (data) {
					var arResult = $.parseJSON(data);
					if(arResult.ERROR){
						$.smallBox({
							title : "Ошибка!",
							content : arResult.ERROR,
							color : "#C46A69",
							icon : "fa fa-warning shake animated",
							timeout : 10000
						});
					}else{
						$.smallBox({
							title: "Спасибо!",
							content: arResult.OK,
							color: "#659265",
							icon: "fa fa-check fadeInRight animated",
							timeout: 4000
						});
					}
				});
			}

		});
		return false;
	});
	$(document).on('click',".BestAnswer",function () {
		var MID = $(this).attr("data-mid");
			MID = (!MID?$(this).attr("mid"):MID);
		var BEST = $(this).attr("data-best");
			BEST = (!BEST?$(this).attr("best"):BEST);

		$.get('?SESSID='+BX.bitrix_sessid()+'&MID='+MID+'&BEST_ANSWER='+BEST+'&ACTION=BEST_ANSWER',function (data) {
			var arResult = $.parseJSON(data);
			if(arResult.ERROR){
				$.smallBox({
					title : "Ошибка!",
					content : arResult.ERROR,
					color : "#C46A69",
					icon : "fa fa-warning shake animated",
					timeout : 10000
				});
			}else{
				$.smallBox({
					title: "Спасибо!",
					content: arResult.OK,
					color: "#659265",
					icon: "fa fa-check fadeInRight animated",
					timeout: 4000
				});
			}
		});
		return false;
	});
	/*$('#payed_topic_link').click(function(){
		$('#payed_topic_block').show();
		$(this).hide();
		return false;
	});*/
	$('#payed_topic_cancel').click(function(){
		$('#payed_topic_block').hide();
		$('.main-donat-footer').show();
		$('#payed_topic_link').show();
		$('#pay_for_decision').val('');
		return false;
	});
	$('#payed_topic_submit').click(function(){
		$(this).attr('disabled', 'disabled');
		$('#payed_topic_form').submit();
	});
	$('#payed_topic_link_return').click(function(){
		$('#return_payed_topic_block').show();
		$('#payed_topic_link').show();
		$('#payed_topic_link_return').slideUp();
		return false;
	});
	$('#return_payed_topic_cancel').click(function(){
		$('#return_payed_topic_block').hide();
		$('#payed_topic_link_return').show();
		$('#return_pay_for_decision').val('');
		return false;
	});
	$('#return_payed_topic_max').click(function(){
		$('#return_pay_for_decision').val($('span', this).html());
		return false;
	});
	$('#return_payed_topic_submit').click(function(){
		$(this).attr('disabled', 'disabled');
		$('#payed_topic_link_return').submit();
	});
});
$(document).on("click",".ConfirmDel",function () {
	var BTN = $(this);
	var HREF = $(this).attr("href");
	$.SmartMessageBox({
		title : "Сообщение будет безвозвратно удалено.",
		content : "Вы уверены, что хотите продолжить?",
		buttons : "[Отмена][Да]",
	}, function(ButtonPress, Value) {
		if(ButtonPress == 'Да'){
			if(BTN.hasClass("fm-del-message")){
				$.get(HREF);
				BTN.parents(".show-hide-props").fadeOut(400,function(){
					BTN.parents(".show-hide-props").remove();
				});
			}else
				location = HREF;
		}else{
			return false;
		}
	});
	return false;
});
$(document).on("click",".forum-message-wrap [data-bx-viewer=image]", function(){
	var IconArr = [];
	var MessID = $(this).parents(".show-hide-props").attr("data-id");
	$(".show-hide-props[data-id="+MessID+"] [data-bx-viewer=image]").each(function($k,$v){
		IconArr[$k] = {href:$(this).attr("src")}
	});
	$.fancybox.open(IconArr,{
		padding:0,
		type : "image",
		helpers:  {
			thumbs : {
				width: 50,
				height: 50,
			}
		}
	});
	return false;
});
$(document).on("mouseup",".forum-message-wrap .forum-message-text",function (e) {
	var select = false;
	if (window.getSelection) {
		select = window.getSelection().toString();
	} else if (document.getSelection) {
		select = document.getSelection();
	} else if (document.selection) {
		select = document.selection.createRange().text;
	}

	if (select && select.length > 3) {
		$(".fm-reply-btn .fa-quote-right").remove();
		$("#fm-quote").remove();
		$(this).parents(".show-hide-props").find(".fm-reply-btn").append('<i class="fa fa-quote-right"></i>');

		$("body").append('<div id="fm-quote" style="display:none;">'+select.replace(/(<([^>]+)>)/ig,"")+'</div>');

	}
});
$(document).on("click",".fm-reply-btn",function () {
	var Quote = '';
    $("#IS_COUNTER_MESS").remove();
	if($("textarea[name=POST_MESSAGE]").length > 0) {
		if($("#fm-quote").length > 0 && $(this).children(".fa-quote-right").length > 0){
			Quote = ' [QUOTE]'+$("#fm-quote").text()+'[/QUOTE]';
			$(this).children(".fa-quote-right").remove();
			$("#fm-quote").remove();
		}


		if($("textarea[name=POST_MESSAGE]").val().length > 0){
			$("textarea[name=POST_MESSAGE]").val($("textarea[name=POST_MESSAGE]").val()+'\r\n');
		}
		$("textarea[name=POST_MESSAGE]").val($("textarea[name=POST_MESSAGE]").val()+'('+$(this).attr("data-cnt")+')' + Quote) ;

        $("#REPLIER").append('<input type="hidden" id="IS_COUNTER_MESS" name="IS_COUNTER_MESS" value="'+$(this).attr("data-cnt")+'"/>');
		var CurBtn = $(this);
		var prevTop = $(".post-form-wrap").parent().offset().top;
		CurBtn.parents(".show-hide-props").after($(".post-form-wrap").parent());
        $(".post-form-wrap").find(".fm-cancel-post-form").css("visibility", "visible");

	}
	return false;
});

$(document).on("click",".fm-cancel-post-form",function () {
    $(".post-form-wrap").find(".fm-cancel-post-form").css("visibility", "hidden");
});

$(document).on("click",".fm-select-menu",function(){
	return false;
});
$(document).on("click",".fm-select-btn",function(){
	$(this).attr("href",$(this).attr("href")+"&PERIOD="+$(this).children("select").val());
});
function ReplaceLinkToImg() {
	$(".forum-message-text a").each(function(){
		var MessID = $(this).parents(".show-hide-props").attr("data-id");
		var URL = null;
		var pattern = /^https?:\/\/.*\.(?:jpe?g|gif|png)$/i;
		URL = pattern.exec($(this).text());
		if(URL !== null){
			$(this).after("<div><img rel='m"+MessID+"' data-bx-viewer='image' data-bx-src='"+URL+"' src='"+URL+"' /></div>");
		}
	});
}

BX.ready(function(){
	BX.addCustomEvent("onPullEvent", function(module_id,command,params) {
		if(module_id == 'forum'){
			if(command == 'new-message' && window.TID == params.TID && window.UID != params.UID) {
				var forum_sort = $('a.ft-save-sort').attr('data-param')
				if(forum_sort == "tree"){
                    var MID = 1;
                    var mess_list = $('div.row.show-hide-props').map(function(){return $(this).attr('data-id');}).get();
                    MID = Math.max.apply(null, mess_list);
				}else{
                    if($("#postjectior-board .show-hide-props:last").length > 0)
                        var MID = $("#postjectior-board .show-hide-props:last").attr("data-id");
                    else
                        var MID = $(".well .show-hide-props:last").attr("data-id");
                    if(isNaN(parseInt(MID,10)))
                        MID = 1;
				}

				$.post("?ACTION=GET_LAST_MESSAGE&MID="+MID+"&sort="+forum_sort+"&ONLY_LAST=Y",function (data) {
                    if(forum_sort == "tree"){
                        var messData = $(data);
                        var messWrap;
                        var messDiv = $('<div>').addClass('fm-answers-wrap').html(messWrap);

                        if(messData.hasClass('row')){
                            messWrap = messData;
                        }else{
                            messWrap = messData.find('.row');
                        }

                        var new_counter = messWrap.attr('data-cnt-2').split('.');
                        if(DecodeCharVersion(new_counter[new_counter.length - 1]) === 1){
                            new_counter.splice(-1,1);
                            messDiv = $('<div>').addClass('fm-answers-wrap').html(messWrap);
                        }else{
                            new_counter[new_counter.length - 1] = EncodeCharVersion(DecodeCharVersion(new_counter[new_counter.length - 1]) - 1);
                            messDiv = messWrap;
                        }
                        new_counter = new_counter.join('.');
                        var prev_mess = $('div.row[data-cnt-2="' + new_counter + '"]');
                        var tmp = prev_mess.next('div.fm-answers-wrap');
                        if(tmp.length === 1){
                            prev_mess = tmp;
                        }

                        if(new_counter === '1'){
                            $("#postjectior-board").append(messDiv);
                        }else{
                            prev_mess.after(messDiv);
                        }
                        prev_mess.find(".alert").remove();
                    }else{
                        var messData = $(data);
                        $("#postjectior-board").append(messData).find(".alert").remove();
                    }


					$(messData).css({"background-color": "#ebf4eb"}).animate({"background-color": ""}, 1500,function () {
						$(this).css("background-color","");
					});
					$(".show-hide-props[data-id]").each(function () {
						if($(".show-hide-props[data-id="+$(this).attr("data-id")+"]").length > 1){
							$(".show-hide-props[data-id="+$(this).attr("data-id")+"]:last").remove();
						}
					});
					$(document).ready(function(){
						$('.comment-ref').cluetip({
							activation: 'click',
							width: 350,
							attribute: 'href',
							closeText: '<i class="fa fa-times"></i>',
							closePosition: 'title',
							sticky: true,
							ajaxCache: false,
						});

					});
				});
			}
		}
	});
});



$(document).on("click",".ft-save-sort",function () {
    var date = new Date(new Date().getTime() + 365*24*60*60* 1000);
	var smesslist = $(this).attr('data-param');
	if(typeof smesslist == 'undefined') {
		smesslist = $(this).attr('param');
	}
    $.cookie('smesslist', smesslist, { expires: 7, path: '/' });
});

/*$(document).on("click",".ConvertTopicToTicket",function () {
	var ID = $(this).attr("data-id");
    var Title = $(".show-hide-props[data-id='"+ID+"'] .forum-message-text").text().trim().split(".");
	$("#ConvertTopicToTicket [name=TICKET_TITLE]").val(Title[0]);
	$("#ConvertTopicToTicket [name=MESSAGE_ID]").val(ID);
    $('#ConvertTopicToTicket').modal();

    return false;

});

$(document).on("click","#ConvertTopicToTicket .create",function () {
	$.getJSON("/bitrix/ajax/topic2ticket.php",
        {
            PUBLICATION_ID:$("#ConvertTopicToTicket [name=PUBLICATION_ID]").val(),
            MESSAGE_ID:$("#ConvertTopicToTicket [name=MESSAGE_ID]").val(),
            SESSID: BX.bitrix_sessid(),
            TICKET_VISIBLE:($("#ConvertTopicToTicket [name=TICKET_VISIBLE]:checked").length > 0?"Y":''),
            TICKET_TITLE:$("#ConvertTopicToTicket [name=TICKET_TITLE]").val(),
        },
        function (arAnswer) {
            $('#ConvertTopicToTicket').modal('toggle');
        }
    )

});*/

$(document).on("click",".ConvertMsgToTicket",function () {
	var ID = $(this).attr("data-id");
	var Title = $(".show-hide-props[data-id='"+ID+"'] .forum-message-text").text().trim().split(".");
	$("#ConvertMsgToTicket [name=TICKET_TITLE]").val(Title[0]);
	$("#ConvertMsgToTicket [name=MESSAGE_ID]").val(ID);
	$('#ConvertMsgToTicket').modal();
	$('[name="UF_DIRECTION"]').select2({
		showSearchInput: true,
		width: "100%",
	});
	$('[name="UF_DIRECTION"]').on('change', function (e) {
		$('#select option[value=' + e.val + ']').prop('selected', true);
	});

	return false;
});

$(document).on("click","#ConvertMsgToTicket .create",function () {
	const btnCreate = $(this);
	btnCreate.prop('disabled', true);

	const body = {
		PUBLICATION_ID:$("#ConvertMsgToTicket [name=PUBLICATION_ID]").val(),
		MESSAGE_ID:$("#ConvertMsgToTicket [name=MESSAGE_ID]").val(),
		SESSID: BX.bitrix_sessid(),
		TICKET_TITLE:$("#ConvertMsgToTicket [name=TICKET_TITLE]").val(),
		UF_DIRECTION:$("#ConvertMsgToTicket [name=UF_DIRECTION]").val(),
	};

	$.post("/bitrix/ajax/msgForum2ticket.php", body, function (response) {
		const data = $.parseJSON(response);

		if (data.TYPE === "ERROR") {
			btnCreate.prop('disabled', false);
			let textError = 'Неизвестная ошибка.';
			const NFRD = "NOT_FULL_REQUEST_DATA: ";

			if (data.MESSAGE === (NFRD + "UF_DIRECTION")) {
				textError = "Не выбрана услуга";
			} else if (data.MESSAGE === (NFRD + "MESSAGE_ID") || data.MESSAGE === "MESSAGE_NOT_FOUND") {
				textError = "Нет данных о сообщении, возможно оно удалено.";
			} else if (data.MESSAGE === (NFRD + "TICKET_TITLE")) {
				textError = "Укажите заголовок для тикета.";
			} else if (data.MESSAGE === "ACCESS_DENIED") {
				textError = "Доступ запрещён.";
			} else if (data.MESSAGE === "TICKET_NOT_CREATED") {
				textError = "Не удалось создать тикет.";
			} else {
				console.info(data.MESSAGE);
			}

			$.smallBox({
				title: "Ошибка!",
				content: textError,
				color: "#C46A69",
				icon: "fa fa-warning shake animated",
				timeout: 4000
			});
		} else if (data.TYPE === "SUCCESS") {
			$.smallBox({
				title: "Тикет успешно создан!",
				content: "Тикет - " + "#[ " + data.MESSAGE + " ]",
				color: "#659265",
				icon: "fa fa-check fadeInRight animated",
				timeout: 8000
			});
			/* Обработка обращений 59012 */
			$('[name="UF_DIRECTION"]').val(59012).trigger('change');
			$('#ConvertMsgToTicket').modal('toggle');
			btnCreate.prop('disabled', false);
		}
	});
});


$(document).ready(function () {
	prepareForSlide();
});

$(document).on("click",".m-tree-p-btn",function () {
	let ch	= $(this).parents('.m-tree-p').next(".m-tree-c");
	let markBtn = $(this).find('i');
	if(ch.length > 0){
		if(ch.hasClass('open')){
			ch.slideUp();
			//markBtn.removeClass('fa-comments-o').addClass('fa-comments');
			ch.removeClass('open');
		} else {
			ch.slideDown();
			//markBtn.removeClass('fa-comments').addClass('fa-comments-o');
			ch.addClass('open');
		}
	}
});

function prepareForSlide(){
	var faclass = ($(".m-tree-open").length > 0) ? 'fa-comments-o' : 'fa-comments';
	$(".m-tree-c").each(function (c) {
		let parentBlock  = $(this).prev('.m-tree-p');
		if(parentBlock.length > 0){
			if(parentBlock.parent().prev('.m-tree-p').length <= 0){
				parentBlock.msgcnt = $(this).find(".show-hide-props").length;
				//parentBlock.append("<div class='btn-xs m-tree-p-btn'  href='/'><i class='fa "+faclass+"'></i> <span>"+parentBlock.msgcnt+"</span></div>");

				parentBlock.find('.forum-action-reply').append('<a class="btn btn-default btn-xs fm-open-answer m-tree-p-btn" rel="nofollow" title="Ответы"><i class="fa fa-comment-o" aria-hidden="true"></i> '+parentBlock.msgcnt+'</a>');
				parentBlock.addClass('uses');
				$(this).addClass('uses');
			}
		}
	});


	if (window.location.hash.substr(0, 8) == '#message')
	{
		let messName = window.location.hash.replace("#", "");
		let messAnchor = $("[name='" + messName + "']");
		let messWraps = messAnchor.parents(".m-tree-c.uses");
		messWraps.each(function () {
			let btnWrap = $(this).prev('.m-tree-p.uses');
			if(btnWrap.length){
				if(!$(this).hasClass("open")){
					$(this).slideDown();
					//btnWrap.find(".m-tree-p-btn i").removeClass('fa-comments').addClass('fa-comments-o');
					$(this).addClass('open');
				}
				setTimeout(function () {
					$("html,body").animate({scrollTop: messAnchor.offset().top - 60}, 1);
				}, 400);
			}
		});
	}
}

$(document).on('click', ".m-tree-toogle", function () {
	let parentsBtn =  $(".m-tree-p-btn");
	let childTree =  $(".m-tree-c.uses");
	if($(this).hasClass("open")){
		//скрываем
		//parentsBtn.find("i").removeClass('fa-comments-o').addClass('fa-comments');
		childTree.slideUp().removeClass("open");
		$(this).removeClass("open");
		$(this).html('Развернуть все');
		$.cookie('collapse_m-tree', 'Y', {expires: 365,path : '/' });
	} else {
		//открываем
		//parentsBtn.find("i").removeClass('fa-comments').addClass('fa-comments-o');
		childTree.slideDown().addClass("open");
		$(this).addClass("open");
		$(this).html('Свернуть все');
		$.cookie('collapse_m-tree','', {expires: 365,path : '/' });
	}
});


/* End */
;
; /* Start:/bitrix/templates/.default/components/infostart/super.component/forum_complaints_list/script.js*/
$(document).ready(function () {
    $(".del-complaint").on("click", function () {
        var mid = $(this).data("mid");
        if (!mid) {
            return false;
        }
        $.ajax({
            url: "/bitrix/ajax/forum_complaints.php",
            type: 'post',
            data: "ACTION=COMPLAINT_DEL&MID="+mid+"&sessid=" + BX.bitrix_sessid(),
            dataType: 'json',
            success: function(data){
                console.log(data);
                if (data.STATUS == 'OK'){
                    $(".fc-item" + mid).css("background-color", "#FFFAF2").hide(300);
                    $(".fc-icon" + mid).remove();
                }
            }
        });
        return false;
    });
	$(document).on("click", ".open-modal-form-complaint", function () {
        $(".send-request-body .success-message").hide();
        $(".send-request-body .form-wrap-c").show();
        $('#f_mess_id').val("");

        if ($(this).data('mid')) {
            $('#f_mess_id').val($(this).data('mid'));
        } else {
            return false;
        }
        $("#complaint-comment").removeClass('f-required').val('');
        $("#sendComplaint").modal();
        return false;
    });
    $('#sendComplaint').on('shown.bs.modal', function () {
        $("#complaint-comment").focus();
    });
});
function submitComplaintForm(){
    if (!$("#complaint-comment").val()) {
        $("#complaint-comment").addClass('f-required');
        return false;
    }
    formData = new FormData($("#form-request-c-wrap").get(0));
    $.ajax({
        url: "/bitrix/ajax/forum_complaints.php",
        type: 'post',
        contentType: false,
        processData: false,
        dataType: 'json',
        data: formData,
        success: function(data){
            $("#complaint-comment").removeClass('f-required');
            if (data.STATUS == 'OK'){
                $(".send-request-body .form-wrap-c").hide();
                $(".send-request-body .success-message").text("Ваша жалоба отправлена.").show();

                // GA4
                const dataGa4 = {
                    event: 'send_compliant'
                };
                window.dataLayer.push(dataGa4);

                setTimeout(function() {$('#sendComplaint').modal('hide');}, 700);
            } else {
                $(".send-request-body .success-message").text("Произошла ошибка. Попробуйте позже.").show();
            }
        }
    });
    return false;
};

/* End */
;
; /* Start:/bitrix/templates/.default/components/infostart/forum_main.post_form/adaptive/script.js*/
if (typeof oForumForm != "object")
	var oForumForm = {};
var MessageMax = 64000;

function quoteMessageEx(author, mid)
{
	if (typeof document.forms["REPLIER"] != "object" || document.forms["REPLIER"] == null)
		return false;
	init_form(document.forms["REPLIER"]);
	oForumForm[document.forms["REPLIER"].id].quote(author, mid);
}

function CreatePalette()
{
	if (oForumForm['PALETTE'])
		return oForumForm['PALETTE'];
	var color_range = {0 : "00", 1 : "33", 2 : "66", 3 : "99", 4 : "BB", 5 : "FF"};
	var rgb = {'R' : 0, 'G' : 0, 'B' : 0, 'color' : ''};
	var oDiv = document.body.appendChild(document.createElement("DIV"));
	oDiv.id = 'palette';
	oDiv.className = 'palette';
	oDiv.style.position = 'absolute';
	oDiv.style.width = '199px';
	oDiv.style.height = '133px';
	oDiv.style.border = 'none';
	oDiv.style.visibility = 'hidden';
	var table = document.createElement("TABLE");
	table.className = 'palette';
	var tbody = table.appendChild(document.createElement('TBODY'));
	for (var ii = 0; ii < 216; ii++)
	{
		if (ii%18 == 0)
			var row = tbody.appendChild(document.createElement('TR'));
		rgb['R'] = ii%6; rgb['G'] = Math.round(ii/36)%6; rgb['B'] = Math.round(ii/6)%6;
		rgb['color'] = '' + color_range[rgb['R']] + '' + color_range[rgb['G']] + '' + color_range[rgb['B']];
		var cell = row.appendChild(document.createElement('TD'));
		var img = cell.appendChild(document.createElement('IMG'));
		img.src = '/bitrix/components/bitrix/forum.post_form/templates/.default/images/bbcode/empty_for_ie.gif';
		cell.id = 'color_' + rgb['color'];
		cell.style.backgroundColor = '#' + rgb['color'];
		cell.onmousedown = function(e){
				e = (jsUtils.IsIE() || !e ? window.event : e);
				jsUtils.PreventDefault(e);
				window.color_palette = '#' + this.id.replace('color_', '');}
	}
	oDiv.appendChild(table);
	oForumForm['PALETTE'] = oDiv;
	return oForumForm['PALETTE'];
}

/* Form functions */
function init_form(form)
{
	if (typeof(form) != "object")
		return false;
	if (!oForumForm[form.id] || typeof(oForumForm[form.id]) != "object")
	{
		oForumForm[form.id] = new PostForm(form);
		oForumForm[form.id].Init(form);
		oForumForm[form.id].onkeydown = function(e){};
		oForumForm[form.id].onmouseover = function(e){};
	}
	return;
}

function PostForm()
{
	this.real_tags = {};
	this.form = false;
	this.stack = [];
	this.tags =  {
		"SPOILER" : "tag_spoiler",
		"B" : "simple_tag",
		"I" : "simple_tag",
		"U" : "simple_tag",
		"S" : "simple_tag",
		"CODE" : "simple_tag",
		"QUOTE" : "simple_tag",
		"COLOR" : "simple_tag",
		"FONT" : "simple_tag",
		"SIZE" : "simple_tag",
		"PALETTE" : "show_palette",
		"URL" : "tag_url",
		"IMG" : "tag_image",
		"LIST" : "tag_list",
		"VIDEO" : "tag_video",
		"TRANSLIT" : "translit",
		"SMILES_DINAMIC" : "show_smiles_dinamic",
		"SMILES_STATIC" : "show_smiles_static"};
	this.template = '<form class="forum-form" id="forum_#ID#_form" name="forum_#ID#_form" onsubmit="return false;">' +
		'<table class="forum-popup" cellpadding="0" cellspacing="0" border="0"><thead><tr><td>' +
			'<div class="close" onmousedown="oForumForm[\'#FORM_ID#\'].check_submit(event, \'C\', \'#ID#\');" return false;">' +
				'<img src="/bitrix/components/bitrix/forum.post_form/templates/.default/images/bbcode/empty_for_ie.gif" /></div>' +
			'#TITLE#</td></tr></thead>' +
		'<tbody><tr><td>#BODY#</td></tr></tbody>' +
		'<tfoot><tr><td>' +
			'<button type="button" name="ok" onclick="oForumForm[\'#FORM_ID#\'].check_submit(event, \'OK\', \'#ID#\');">' +
				oText['BUTTON_OK'] + '</button>' +
			'<button type="button" name="cancel" onclick="oForumForm[\'#FORM_ID#\'].check_submit(event, \'C\', \'#ID#\');">' +
				oText['BUTTON_CANCEL'] + '</button>' +
		'</td></tr></tfoot></table></form>';
	this.item_template = '<div class="forum-field"><span class="title">#TITLE#</span>#BODY#</div>';


	this.additional_params = {"translit" : 0};
	this.oCursor = {"text" : "", "start" : 0, "end" : 0};
	this.nav = 'none';
	var t = this;
	this.popupMenu = false;
	this.bTranslited = false;
	this.active = null;

	this.Init = function(form)
	{
		if (this.form)
			return true;
		if (typeof(form) != "object" || typeof(form["POST_MESSAGE"]) != "object")
			return false;
		this.form = form;
		/* Simple tags */
		var oDivs = this.form.getElementsByTagName('A');
		if (oDivs && oDivs.length > 0)
		{
			for (var ii = 0; ii < oDivs.length; ii++)
			{
				if (!(oDivs[ii] && oDivs[ii].id && oDivs[ii].id.substring(0, 5) == "form_"))
					continue;
				oDiv = oDivs[ii];
				if (!oDiv.id || oDiv.name == "smiles")
					continue;
				id = oDiv.id.substring(5).toUpperCase();

				oDiv.onclick = oDiv.onmousedown = function(e){
					e = (jsUtils.IsIE() || !e ? window.event : e);
					jsUtils.PreventDefault(e);
					if (e.type == 'mousedown' && jsUtils.IsOpera())
					{
						t.saveSelection = t.GetSelection();
					}
					if (e.type == 'click')
					{
						t.format_text(this, e);
						t.saveSelection = false;
					}
				}
				oDiv.onmouseover = function(){this.className += ' marked';};
				oDiv.onmouseout = function(){this.className = this.className.replace(/marked/, '').replace('  ', ' ');};

				if (jsUtils.IsOpera() && oDiv.title)
					oDiv.title = oDiv.title.replace(/\(alt+([^)])+\)/gi, '');
				this.real_tags[id] = oDiv;
			}
		}
		if (this.form['FONT'])
		{
			this.form['FONT'].onmousedown = function(e){t.saveSelection = t.GetSelection();};
			this.form['FONT'].onchange = function(e){t.format_text(this, e)};
			this.form['FONT'].onmouseover = function(){this.className += ' marked';};
			this.form['FONT'].onmouseout = function(){this.className = this.className.replace(/marked/, '').replace('  ', ' ');};
		}
		// Smiles
		var image = this.form.getElementsByTagName("img");
		if (image && image.length > 0)
		{
			for (var ii = 0; ii < image.length; ii++ )
			{
				if (image[ii].className == "smiles" || image[ii].className == "smiles-list")
				{
					image[ii].onclick = image[ii].onmousedown = function(e){
						e = (jsUtils.IsIE() || !e ? window.event : e);
						jsUtils.PreventDefault(e);
						if (e.type == 'click')
						{
							t.emoticon(this);
						}
					}
//					this.real_tags["SMILES"] = true;
				}
			}
		}
		this.form["POST_MESSAGE"].onkeyup = t.check_keyup;
		this.form["POST_MESSAGE"].onkeypress = t.check_ctrl_enter;
		this.form["POST_MESSAGE"].onfocus = function(e){this.hasfocus = true};
		this.form["POST_MESSAGE"].onblur = function(e){this.hasfocus = false;};
		this.template = this.template.replace(/\#FORM_ID\#/g, this.form.id);
		return true;
	},
	this.check_submit = function(e, action, id)
	{
		e = (jsUtils.IsIE() || !e ? window.event : e);
		if (e)
			jsUtils.PreventDefault(e);
		id = (id == false ? t.active : id);
		var close = true;
		if (action == 'OK')
		{
			close = t["tag_" + id]('format_text');
		}
		if (close)
			t.Hide();
	},
	this.check_keypress = function(e)
	{
		if(!e) e = window.event
		if(!e) return false;
		if(e.keyCode == 27)
			t.check_submit(false, 'C', false);
		return;
	},
	this.check_keyup = function(e)
	{
		if(!e) e = window.event
		if(!e) return;
		if(!e.altKey) return;
		if(e.keyCode == 73)
			t.format_text({'id' : 'form_i', 'value' : ''}, e);
		else if(e.keyCode == 85)
			t.format_text({'id' : 'form_u', 'value' : ''}, e);
		else if(e.keyCode == 66)
			t.format_text({'id' : 'form_b', 'value' : ''}, e);
		else if(e.keyCode == 81)
			t.format_text({'id' : 'form_quote', 'value' : ''}, e);
		else if(e.keyCode == 80)
			t.format_text({'id' : 'form_code', 'value' : ''}, e);
		else if(e.keyCode == 71)
			t.tag_image();
		else if(e.keyCode == 72)
			t.tag_url(true);
		else if(e.keyCode == 76)
			t.tag_list();
	},

	this.check_ctrl_enter = function(e)
	{
		if(!e)
			e = window.event;
		if((e.keyCode == 13 || e.keyCode == 10) && e.ctrlKey){
			$("#REPLIER [type=submit]").click();
		}
	},

	this.GetSelection = function()
	{
		if (this.form["POST_MESSAGE"].hasfocus == true && typeof(this.form["POST_MESSAGE"].selectionStart) != 'undefined')
		{
			return this.form["POST_MESSAGE"].value.substr(this.form["POST_MESSAGE"].selectionStart,
				this.form["POST_MESSAGE"].selectionEnd - this.form["POST_MESSAGE"].selectionStart);
		}
		else if (this.saveSelection)
		{
			return this.saveSelection;
		}
		else if (document.selection && document.selection.createRange)
		{
			return document.selection.createRange().text;
		}
		else if (window.getSelection)
		{
			return window.getSelection() + '';
		}
		else
		{
			return false;
		}
	},

	this.Show = function(id, data)
	{
		if (!data)
			return false;
		var oDiv = document.getElementById('forum_popup_' + this.form.id + '_post_form');
		if (!oDiv)
		{
			oDiv = document.body.appendChild(document.createElement("DIV"));
			oDiv.id = 'forum_popup_' + this.form.id + '_post_form';
		}
		oDiv.style.visible = 'hidden';
		oDiv.className = "forum-popup-postform";
		oDiv.style.position = 'absolute';
		oDiv.innerHTML = data;

		jsUtils.addEvent(document, "keypress", t.check_keypress);
		var res = jsUtils.GetWindowSize();
		var pos = {};
		if (t.active != id)
		{
			this.Hide();
			t.active = id;
			pos['top'] = parseInt(res["scrollTop"] + res["innerHeight"]/2 - oDiv.offsetHeight/2);
			pos['left'] = parseInt(res["scrollLeft"] + res["innerWidth"]/2 - oDiv.offsetWidth/2);
			FJCFloatDiv.Show(oDiv, pos["left"], pos["top"], false, true, true);
		}

		return false;
	},
	this.Hide = function()
	{
		if (t.active == null)
			return false;
		t.active = null;
		var oDiv = document.getElementById('forum_popup_' + t.form.id + '_post_form');
		FJCFloatDiv.Close(oDiv);
		jsUtils.removeEvent(document, "keypress", t.check_keypress);
		return false;
	},

	this.Insert = function (ibTag, ibClsTag, postText)
	{
		ibTag = (ibTag && ibTag.length > 0 ? ibTag : "");
		ibClsTag = (ibClsTag && ibClsTag.length > 0 ? ibClsTag : "");
		postText = (postText && postText.length > 0 ? postText : "");
		if (ibTag.length <= 0 && ibClsTag.length <= 0 && postText.length <= 0)
			return true;
		var bReplaceText = (!postText ? false : true);
		var sSelectionText = this.GetSelection();

		if (!this.form["POST_MESSAGE"].hasfocus)
		{
			this.form["POST_MESSAGE"].focus();
		}

		var isSelect = (sSelectionText ? 'select' : bReplaceText ? 'after' : 'in');
		if (bReplaceText)
			postText = ibTag + postText + ibClsTag;
		else if (sSelectionText)
			postText = ibTag + sSelectionText + ibClsTag;
		else
			postText = ibTag + ibClsTag;

		if (typeof(this.form["POST_MESSAGE"].selectionStart) != 'undefined')
		{
			var currentScroll = this.form["POST_MESSAGE"].scrollTop;
			var selection = {
				"start" : this.form["POST_MESSAGE"].selectionStart,
				"end" : this.form["POST_MESSAGE"].selectionEnd};

			this.form["POST_MESSAGE"].value = this.form["POST_MESSAGE"].value.substr(0, selection["start"]) +
				postText + this.form["POST_MESSAGE"].value.substr(selection["end"]);

			if (isSelect == 'select')
			{
				this.form["POST_MESSAGE"].selectionStart = selection["start"];
				this.form["POST_MESSAGE"].selectionEnd = selection["start"] + postText.length;
			}
			else if (isSelect == 'in')
			{
				this.form["POST_MESSAGE"].selectionStart = selection["start"] + ibTag.length;
				this.form["POST_MESSAGE"].selectionEnd = selection["start"] + ibTag.length;
			}
			else
			{
				this.form["POST_MESSAGE"].selectionStart = selection["start"] + postText.length;
				this.form["POST_MESSAGE"].selectionEnd = selection["start"] + postText.length;
			}
			this.form["POST_MESSAGE"].scrollTop = currentScroll;
		}
		else if (document.selection && document.selection.createRange)
		{
			var sel = document.selection.createRange();
			var selection_copy = sel.duplicate();
			postText = postText.replace(/\r?\n/g, '\r\n');
			sel.text = postText;
			sel.setEndPoint('StartToStart', selection_copy);
			sel.setEndPoint('EndToEnd', selection_copy);
			if (isSelect == 'select')
			{
				sel.collapse(true);
				postText = postText.replace(/\r\n/g, '1');
				sel.moveEnd('character', postText.length);

			}
			else if (isSelect == 'in')
			{
				sel.collapse(false);
				sel.moveEnd('character', ibTag.length);
				sel.collapse(false);
			}
			else
			{
				sel.collapse(false);
				sel.moveEnd('character', postText.length);
				sel.collapse(false);
			}
			sel.select();
		}
		else
		{
			// failed - just stuff it at the end of the message
			this.form["POST_MESSAGE"].value += text;
		}
		return true;
	},

	this.format_text = function(oObj, e)
	{
		e = (jsUtils.IsIE() || !e ? window.event : e);
		jsUtils.PreventDefault(e);
		if (!oObj || !oObj.id)
			return false;
		var id = oObj.id.substring(5).toUpperCase();

		if (this.tags[id] == 'simple_tag')
		{
			var tag_start = tag_name = id;
			if (tag_name == 'FONT' || tag_name == 'COLOR')
				tag_start += "=" + oObj.value;

			if ((!jsUtils.in_array(tag_name, this.stack) || this.GetSelection()) &&
				 !(tag_name == 'FONT' && oObj.value == 'none'))
			{
				if (!this.Insert("[" + tag_start + "]", "[/" + tag_name + "]"))
				{
					this.stack.push(tag_name);
					if (this.real_tags[id])
						this.real_tags[id].className += ' opened';
				}
			}
			else
			{
				var res = false;
				while (res = this.stack.pop())
				{
					this.Insert("[/" + res + "]", "");
					if (this.real_tags[res])
						this.real_tags[res].className = this.real_tags[res].className.replace(/opened/, '').replace('  ', ' ');
					if (res == tag_name)
						break;
				}
			}
		}
		else if (this.tags[id] == 'show_palette')
		{
			this.show_palette(oObj);
		}
		else if (this.tags[id] == 'show_smiles_dinamic')
		{
			this.show_smiles_dinamic(oObj);
		}
		else if (this.tags[id] == 'show_smiles_static')
		{
			this.show_smiles_static(oObj);
		}
		else if (this.tags[id] == 'translit')
		{
			res = this.translit();
			if (this.real_tags[id])
			{
				if (res)
					this.real_tags[id].className += ' opened translited';
				else
					this.real_tags[id].className = this.real_tags[id].className.replace(/opened/, '').replace(/translited/, '').replace('  ', ' ');
			}
		}
		else if (this.tags[id])
		{
			this[this.tags[id]](true);
		}
	},

	this.emoticon = function(element)
	{
		this.Insert(" ", " ", element.alt);
	},

	this.tag_image = function()
	{
		var FoundErrors = '';
		var need_loop = true;
		var oFields = {
			"URL" : {
				"text" : oText['enter_image'],
				"default" : "http://",
				"error" : oErrors['no_url'],
				"value" : ""}};
		var selection = t.GetSelection();
		if (selection != false && selection.search(/^(http|https|news|ftp|aim|mailto)\:\/\//gi) > -1)
		{
			oFields["URL"]["default"] = selection;
		}
		else
		{
			selection = false;
		}

		for (var ii in oFields)
		{
			need_loop = true;
			do
			{
				var res = prompt(oFields[ii]["text"], oFields[ii]["default"]);
				if (res == null)
				{
					need_loop = false;
					return false;
				}
				else if (res.length <= 0)
				{
				}
				else
				{
					oFields[ii]["value"] = res;
					need_loop = false;
				}
			}
			while(need_loop);
		}
		this.Insert("[IMG]", "[/IMG]", oFields["URL"]["value"]);
	},

	this.tag_video = function(action)
	{
		action = (action == 'format_text' ? 'format_text' : 'show_data');
		var sError = "";
		var path = "";
		var selection = t.GetSelection();
		if (selection != false && selection.search(/^(http|https|news|ftp|aim|mailto)\:\/\//gi) > -1)
			path = selection.replace(/[\<\>]/gi, "");
		var sBody = "";
		if (action == 'format_text')
		{
			var form = false;
			for(var ii in document.forms)
			{
				if (document.forms[ii].name == 'forum_video_form')
					form = document.forms[ii];
			}
			if (!form)
				return true;
			var width = parseInt(form["width"].value);
			var height = parseInt(form["height"].value);
			var path = form["path"].value;
			var preview = form["preview"].value;
			if (path.length <= 0)
			{
				action = 'show_data';
				sBody = "<div class='forum-error'>" + oErrors['no_path'] + "</div>";
			}
		}
		if (action == 'show_data')
		{
			sBody = sBody +
				this.item_template.replace(/\#TITLE\#/g, oText["path"]).replace(/\#BODY\#/g, '<input type="text" name="path" value="' + path + '">') +
				this.item_template.replace(/\#TITLE\#/g, oText["preview"]).replace(/\#BODY\#/g, '<input type="text" name="preview" value="">') +
				this.item_template.replace(/\#TITLE\#/g, oText["width"]).replace(/\#BODY\#/g, '<input type="text" name="width" value="400">') +
				this.item_template.replace(/\#TITLE\#/g, oText["height"]).replace(/\#BODY\#/g, '<input type="text" name="height" value="300">');
			var sData = this.template.replace(/\#ID\#/g, "video").replace(/\#TITLE\#/g, oText["video"]).replace(/\#BODY\#/g, sBody);
			this.Show('video', sData);
			return false;
		}
		this.Insert("[VIDEO WIDTH=" + width + " HEIGHT=" + height +
			(preview.length > 0 ? ' PREVIEW="' + preview + '"' : '') + "]", "[/VIDEO]", path);
		return true;
	},

	this.tag_list = function()
	{
		var thelist = "";
		var need_loop = true;
		do
		{
			var res = prompt(oText['list_prompt'], "");
			if (res == null)
			{
				need_loop = false;
			}
			else if (res.replace(/^\s\s*/, '').replace(/\s\s*$/, '').length <= 0)
			{
				need_loop = false;
			}
			else
			{
				thelist = thelist + "[*]" + res + "\n";
			}
		}
		while(need_loop);
		this.Insert("[LIST]\n", "[/LIST]\n", thelist);
	},

	this.closeall = function()
	{
		var res = false;
		while(res = this.stack.pop())
		{
			this.Insert("[/" + res + "]", "");
			if (this.real_tags[res])
				this.real_tags[res].className = this.real_tags[res].className.replace(/opened/, '').replace('  ', ' ');
		}
	},

	this.tag_url = function()
	{
		var FoundErrors = '';
		var need_loop = true;
		var oFields = {
			"URL" : {
				"text" : oText['enter_url'],
				"default" : "http://",
				"error" : oErrors['no_url'],
				"value" : ""},
			"TITLE" : {
				"text" : oText['enter_url_name'],
				"default" : "My Webpage",
				"error" : oErrors['no_title'],
				"value" : ""}};
		var selection = t.GetSelection();
		if (selection != false)
		{
			if (selection.search(/^(http|https|news|ftp|aim|mailto)\:\/\//gi) > -1)
			{
				oFields["URL"]["default"] = selection;
			}
			else
			{
				oFields["TITLE"]["default"] = selection;
			}
		}

		for (var ii in oFields)
		{
			need_loop = true;
			do
			{
				var res = prompt(oFields[ii]["text"], oFields[ii]["default"]);
				if (res == null)
				{
					need_loop = false;
					return false;
				}
				else if (res.length <= 0)
				{
				}
				else
				{
					oFields[ii]["value"] = res;
					need_loop = false;
				}
			}
			while(need_loop);
		}
		this.Insert("[URL=" + oFields["URL"]["value"] + "]", "[/URL]", oFields["TITLE"]["value"]);
		return false;
	},

	this.tag_spoiler = function()
	{
		var FoundErrors = '';
		var need_loop = true;
		var oFields = {
			"URL" : {
				"text" : 'Введите подпись к спойлеру',
				"default" : "Скрытый текст",
				"error" : 'Укажите текст',
				"value" : ""},
			"TITLE" : {
				"text" : 'Введите скрытый текст',
				"default" : "Скрытый текст",
				"error" : 'Укажите текст',
				"value" : ""}};
		var selection = t.GetSelection();
		if (selection != false)
		{

			oFields["TITLE"]["default"] = selection;

		}

		for (var ii in oFields)
		{
			need_loop = true;
			do
			{
				if(ii == 'TITLE')
					var res = oFields["TITLE"]["default"];
				else
					var res = prompt(oFields[ii]["text"], oFields[ii]["default"]);

				if (res == null)
				{
					need_loop = false;
					return false;
				}
				else if (res.length <= 0)
				{
					alert("Error! " + oFields[ii]["error"]);
				}
				else
				{
					oFields[ii]["value"] = res;
					need_loop = false;
				}
			}
			while(need_loop);
		}
		this.Insert("[spoiler=" + oFields["URL"]["value"] + "]", "[/spoiler]", oFields["TITLE"]["value"]);
		return false;
	},

	this.translit = function()
	{
		var i = 0;
		var textbody = this.form['POST_MESSAGE'].value;
		var selection = this.GetSelection();
		if (selection != false)
		{
			textbody = selection;
		}

		if (this.bTranslited == false)
		{
			for (i=0; i<capitEngLettersReg.length; i++) textbody = textbody.replace(capitEngLettersReg[i], capitRusLetters[i]);
			for (i=0; i<smallEngLettersReg.length; i++) textbody = textbody.replace(smallEngLettersReg[i], smallRusLetters[i]);
			this.bTranslited = true;
		}
		else
		{
			for (i=0; i<capitRusLetters.length; i++) textbody = textbody.replace(capitRusLettersReg[i], capitEngLetters[i]);
			for (i=0; i<smallRusLetters.length; i++) textbody = textbody.replace(smallRusLettersReg[i], smallEngLetters[i]);
			this.bTranslited = false;
		}

		if (selection != false)
		{
			this.Insert("", "", textbody);
		}
		else
		{
			this.form['POST_MESSAGE'].value = textbody;
		}
		return this.bTranslited;
	},

	this.quote = function (author, mid)
	{
		var selection = "";
		var message_id = 0;
		selection = this.GetSelection();
		if (document.getSelection)
		{
			selection = selection.replace(/\r\n\r\n/gi, "_newstringhere_").replace(/\r\n/gi, " ");
			selection = selection.replace(/  /gi, "").replace(/_newstringhere_/gi, "\r\n\r\n");
		}
		if (selection == "" && mid)
		{
			message_id = parseInt(mid.replace(/message_text_/gi, ""));
			if (message_id > 0)
			{
				var message = document.getElementById(mid);
				if (typeof(message) == "object" && message)
				{
					selection = message.innerHTML;
					selection = selection.replace(/\<br(\s)*(\/)*\>/gi, "\n").replace(/\<script[^\>]*>/gi, '\001').replace(/\<\/script[^\>]*>/gi, '\002');
					selection = selection.replace(/\<noscript[^\>]*>/gi, '\003').replace(/\<\/noscript[^\>]*>/gi, '\004');
					selection = selection.replace(/\001([^\002]*)\002/gi, " ").replace(/\003([^\004]*)\004/gi, " ");
					// Quote & Code
					selection = selection.replace(/\<table class\=\"forum-quote\"\>\<thead\>\<tr\>\<th\>([^<]+)\<\/th\>\<\/tr\>\<\/thead\>\<tbody\>\<tr\>\<td\>/gi, "\001").replace(/\<table class\=\"forum-code\"\>\<thead\>\<tr\>\<th\>([^<]+)\<\/th\>\<\/tr\>\<\/thead\>\<tbody\>\<tr\>\<td\>/gi, "\002").replace(/\<\/td\>\<\/tr\>\<\/tbody\>\<\/table\>/gi, "\003");
					var ii = 0;
					while(ii < 50 && (selection.search(/\002([^\002\003]*)\003/gi) >= 0 || selection.search(/\001([^\001\003]*)\003/gi) >= 0))
					{
						ii++;
						selection = selection.replace(/\002([^\002\003]*)\003/gi, "[CODE]$1[/CODE]").replace(/\001([^\001\003]*)\003/gi, "[QUOTE]$1[/QUOTE]");
					}
					selection = selection.replace(/[\001\002]/gi, "");
					// Cut
					selection = selection.replace(/\<table class=(\'|\")forum-spoiler(\'|\")\>\<thead([^>]+)\>\<tr\>\<th\>\<div\>/gi, "\001").replace(/\<\/div\>\<\/th\>\<\/tr\>\<\/thead\>\<tbody([^>]+)class=(\'|\")forum-spoiler(\'|\")([^>]*)\>\<tr\>\<td\>/gi, "\002");
					var patt1 = /\001([^\002]+)\002([^\001\O02\003]+)\003/g;
					var patt2 = /\001\002([^\001\O02\003]+)\003/g;
					var counter = 1;

					while (patt1.test(selection) == true || patt2.test(selection) == true)
					{
						if (patt1.test(selection) == true)
						{
							selection = selection.replace(patt1, "[CUT=$1]$2[/CUT]");
						}
						if (patt2.test(selection) == true)
						{
							selection = selection.replace(patt2, "[CUT]$1[/CUT]");
						}
						counter++;
						if (counter >= 10)
							break;
					}
					selection = selection.replace(/[\001\002\003]/gi, "");
					// Smiles
					if (this.real_tags["SMILES"])
						selection = selection.replace(/\<img[^>]+alt=\"smile([^\"]+)\"[^>]+\>/gi, "$1");
					// Hrefs
					if (this.real_tags["URL"])
					{
						selection = selection.replace(/\<a[^>]+href=[\"]([^\"]+)\"[^>]+\>([^<]+)\<\/a\>/gi, "[URL=$1]$2[/URL]");
						selection = selection.replace(/\<a[^>]+href=[\']([^\']+)\'[^>]+\>([^<]+)\<\/a\>/gi, "[URL=$1]$2[/URL]");
					}
					selection = selection.replace(/\<[^\>]+\>/gi, " ").replace(/&lt;/gi, "<").replace(/&gt;/gi, ">").replace(/&quot;/gi, "\"");
				}
			}
			else if (mid.length > 0)
			{
				selection = mid;
			}
		}
		if (selection != "")
		{
			selection = selection.replace(/\&shy;/gi, "");
			if (author != null && author)
            {
                author = author.replace(/\<[^\>]+\>/gi, " ").replace(/&lt;/gi, "<").replace(/&gt;/gi, ">").replace(/&quot;/gi, "\"");
				selection = author + oText['author'] + selection;
            }
			this.Insert("[QUOTE]", "[/QUOTE]", selection);
			return true;
		}
		return false;
	},

	this.show_palette = function(oObj)
	{
		if (!oObj){return false};
		var oPalette = CreatePalette();
		if (!this.popupMenu)
		{
			window.ForumPopupMenu.prototype.ShowMenu = function(control, div)
			{
				var pos = {"top" : 20, "left" : 20};
				this.PopupHide();
				if (typeof(control) == "object")
				{
					id = control.id;
					pos = jsUtils.GetRealPos(control);
					this.ControlPos = pos;
					this.oControl = control;
				}

				this.oDiv = div;
				if (this.oDiv)
				{
					pos["top"] = pos["bottom"];
					this.PopupShow(pos, this.oDiv);
				}
			}
			window.ForumPopupMenu.prototype.CheckClick = function(e)
			{
				if(!this.oDiv){return;}
				if (this.oDiv.style.visibility != 'visible' || this.oDiv.style.display == 'none')
					return;
		        var windowSize = jsUtils.GetWindowSize();
		        var x = e.clientX + windowSize.scrollLeft;
		        var y = e.clientY + windowSize.scrollTop;

				/*menu region*/
				pos = jsUtils.GetRealPos(this.oDiv);
				var posLeft = parseInt(pos["left"]);
				var posTop = parseInt(pos["top"])
				var posRight = posLeft + this.oDiv.offsetWidth;
				var posBottom = posTop + this.oDiv.offsetHeight;
				if(x >= posLeft && x <= posRight && y >= posTop && y <= posBottom)
				{
					if (window.color_palette)
					{
						t.format_text({'id' : 'form_color', 'value' : window.color_palette, 'className' : ''}, e);
						this.PopupHide();
					}
				}

				if(this.ControlPos)
				{
					var pos = this.ControlPos;
					if(x >= pos['left'] && x <= pos['right'] && y >= pos['top'] && y <= pos['bottom'])
						return;
				}
				this.PopupHide();
			}

			this.popupMenu = new ForumPopupMenu();
		}
		this.popupMenu.ShowMenu(oObj, oPalette);
	},

	this.show_smiles_dinamic = function(oObj, status, send_data)
	{
		if (!oObj || !this.form){return false};
		status = (status == 'hide' ? 'hide' : 'show');
		send_data = (send_data == "N" ? "N" : "Y");
		var index = this.form.name.replace("REPLIER", "");
		if (!this.oDivSmiles)
		{
			this.oDivSmiles = document.getElementById('forum_smiles_line' + index);
			this.real_tags['SMILES_DINAMIC'].style.visibility = 'hidden';
			this.real_tags['SMILES_DINAMIC'].style.display = '';
			this.params_smiles = {'passive':{'width' : (this.form.POST_MESSAGE.offsetWidth - this.real_tags['SMILES_DINAMIC'].offsetWidth)},
				'active' : {'width' : this.form.POST_MESSAGE.offsetWidth}};
			this.real_tags['SMILES_DINAMIC'].style.display = 'none';
			this.real_tags['SMILES_DINAMIC'].style.visibility = 'visible';

			var res = this.real_tags['SMILES_DINAMIC'].cloneNode(true);
			res.innerHTML = oText['smile_hide'];
			res.id = res.id + '_hide';
			res.onclick = function(){t.show_smiles_dinamic(this, 'hide'); return false;}
			res.style.display = 'block';

			var res1 = document.createElement('DIV');
			res1.className = "forum-reply-field forum-reply-field-hidesmiles";
			res1.appendChild(res);
			this.oDivSmiles.appendChild(res1);
		}
		if (status == 'show')
		{
			this.oDivSmiles.className = this.oDivSmiles.className.replace(/forum\-smiles\-corrected/gi, "");
			this.oDivSmiles.style.width = this.params_smiles['active']['width'] + 'px';
			this.real_tags['SMILES_DINAMIC'].style.display = 'none';
		}
		else
		{
			this.oDivSmiles.className += " forum-smiles-corrected";
			this.oDivSmiles.style.width = this.params_smiles['passive']['width'] + 'px';
			this.real_tags['SMILES_DINAMIC'].style.display = '';
		}
		if (phpVars['isAuthorized'] == "Y" && send_data == "Y")
		{
			var TID = CPHttpRequest.InitThread();
			CPHttpRequest.SetAction(TID, function(){});
			CPHttpRequest.Send(TID, '/bitrix/components/bitrix/forum/templates/.default/user_settings.php',
			{"save":'smiles_position', "value":status, "sessid":t.form.sessid.value});
		}
		return false;
	},

	this.show_smiles_static = function(oObj, send_data)
	{
		if (!oObj || !this.form){return false};
		send_data = (send_data == "N" ? "N" : "Y");

		var index = this.form.name.replace("REPLIER", "");
		if (oObj.name == 'smile_hide')
		{
			oObj.parentNode.parentNode.previousSibling.style.display = 'block';
			oObj.parentNode.parentNode.style.display = 'none';
		}
		else
		{
			oObj.parentNode.parentNode.style.display = 'none';
			oObj.parentNode.parentNode.nextSibling.style.display = 'block';
		}
		if (phpVars['isAuthorized'] == "Y" && send_data == "Y")
		{
			var TID = CPHttpRequest.InitThread();
			CPHttpRequest.SetAction(TID, function(){});
			CPHttpRequest.Send(TID, '/bitrix/components/bitrix/forum/templates/.default/user_settings.php',
			{"save":'smiles_position', "value":(oObj.name == 'smile_hide' ? 'hide' : 'show'), "sessid":t.form.sessid.value});
		}
		return false;
	}
}
var ValidateFormACTIVE = false;
$(document).ready(function () {
	$(document).on("submit", "#REPLIER", function (e) {
		let $Form = $(this);

		$("#REPLIER [required]:visible").each(function() {
			$(this).valid();
		});

		$("#REPLIER").css({"opacity":".4"});

		$("#REPLIER [type=submit]").attr("disabled","disabled").html("Загрузка...");

		$("#selectr_newtopic").parents('td').find(".state-success,.state-error").removeClass("state-success state-error").next('em').remove();
		if($("#selectr_newtopic").length > 0 && $("#selectr_newtopic").val() < 1) {
			$("#selectr_newtopic").parent('label').addClass("state-error");
			$("#selectr_newtopic").parents('.state-error').after('<em style="display: block" class="invalids">Выберите раздел</em>');
		}

		$("[name='TAGS[]']").parents('td').find(".state-success,.state-error").removeClass("state-success state-error").next('em').remove();
		if($("[name='TAGS[]']").length > 0 && ($("[name='TAGS[]']").val() != null && $("[name='TAGS[]']").val().length > 5)){
			$("[name='TAGS[]']").parents('label').addClass("state-error");
			$("[name='TAGS[]']").parents('.state-error:first').after('<em style="display: block" class="invalids">Можно указать максимум 5 тегов</em>');
		}

		if($("#REPLIER .invalid:visible:first, #REPLIER .select2-error:visible:first, #REPLIER .state-error:visible").length > 0){
			return false;
		}else{
			$("#REPLIER").validate().settings.ignore = "*";
		}
	});
});
function ValidateForm(form, ajax_type)
{
	if (ValidateFormACTIVE)return false;


	if($("#REPLIER .invalid:visible:first, #REPLIER .select2-error:visible:first, #REPLIER .state-error:visible").length > 0){
		$('html,body').animate({
			scrollTop: (parseInt($('#REPLIER .invalid:visible, #REPLIER .select2-error:visible, #REPLIER .state-error:visible').first().offset().top-100, 10))
		}, 400);
	}


	if (typeof form != "object" || typeof form.POST_MESSAGE != "object")
		return false;
	MessageMax = 64000;

	var errors = "";
	var MessageLength = form.POST_MESSAGE.value.length;

	if (form.TITLE && (form.TITLE.value.length < 2))
		errors += oErrors['no_topic_name'];

	if (MessageLength < 2)
		errors += oErrors['no_message'];
    else if ((MessageMax != 0) && (MessageLength > MessageMax))
		errors += oErrors['max_len'].replace(/\#MAX_LENGTH\#/gi, MessageMax).replace(/\#LENGTH\#/gi, MessageLength);

	if (errors != "")
	{
		return false;
	}

	var arr = form.getElementsByTagName("submit");
	for (var butt in arr)
		butt.disabled = true;

	ValidateFormACTIVE = true;

	if (ajax_type == 'Y' && window['ForumPostMessage'])
	{
		ForumPostMessage(form);
	}

	return true;
}
function ShowLastEditReason(checked, div)
{
	if (div)
	{
		if (checked)
			div.style.display = 'block';
		else
			div.style.display = 'none';
	}
}
function ShowVote(oObj)
{
	if (oObj)
	{
		if (oObj.name == 'from_tag')
		{
			oObj.parentNode.removeChild(oObj);
			document.getElementById('vote_switcher').parentNode.removeChild(document.getElementById('vote_switcher'));
		}
		else
		{
			oObj.parentNode.parentNode.removeChild(oObj.parentNode);
		}
		document.getElementById('vote_params').style.display = '';
	}
	return false;
}

function vote_remove_answer(anchor, iQuestion, permanent)
{
	if (typeof anchor != "object" || anchor == null)
		return false;
	else if (!confirm(oText['vote_drop_answer_confirm']))
		return false;
	$(anchor).parents('li').remove();
	return false;
}

function vote_add_answer(oLi, iQuestion, iAnswer)
{
	iQuestion = parseInt(iQuestion);
	iAnswer = parseInt(iAnswer);
	vote_init_question(iQuestion);

	iAnswer = (arVoteParams[iQuestion]['max_a'] > iAnswer ? arVoteParams[iQuestion]['max_a'] : iAnswer);
	iAnswer++;
	arVoteParams[iQuestion]['max_a'] = iAnswer;
	arVoteParams[iQuestion]['count_a']++;

	var answer = document.createElement('LI');

	answer.innerHTML = arVoteParams['template_answer'].replace(/\#Q\#/g, iQuestion).replace(/\#A\#/g, iAnswer);
	oLi.parentNode.insertBefore(answer, oLi);

	if (arVoteParams[iQuestion]['count_a'] >= arVoteParams['count_max_a'])
	{
		oLi.style.display = 'none';
	}
	return false;
}
function vote_init_question(iQuestion, oData)
{
	if (typeof arVoteParams[iQuestion] == "object" && arVoteParams[iQuestion] != null) {
		return true; }
	else if (typeof oData == "object" && oData != null) {
		arVoteParams[iQuestion] = oData;
		return true;}
	arVoteParams[iQuestion] = {'count_a' : 0, 'max_a' : 0};
	try
	{
		arVoteParams[iQuestion]['count_a'] = document.getElementById('MULTI_' + iQuestion).parentNode.nextSibling.getElementsByTagName('li').length;
		arVoteParams[iQuestion]['count_a']--;
	}
	catch(e){}
	return true;
}
function vote_remove_question(anchor, permanent)
{
	if (typeof anchor != "object" || anchor == null)
		return false;
	else if (!confirm(oText['vote_drop_question_confirm']))
		return false;

	$(anchor).parents(".forum-reply-field-vote-question").remove();
	$(".forum-reply-header-main").remove();
	return false;
}
function vote_add_question(iQuestion, oObj)
{
	iQuestion = parseInt(iQuestion);
	iQuestion = (arVoteParams['max_q'] > iQuestion ? arVoteParams['max_q'] : iQuestion);
	iQuestion++;
	arVoteParams['max_q'] = iQuestion;
	var question = jsUtils.CreateElement("DIV", {"class": "forum-reply-field-vote-question"});
	question.innerHTML = arVoteParams['template_question'].replace(/\#Q\#/g, iQuestion);
	oObj.parentNode.insertBefore(question, oObj);
	arVoteParams['count_q']++;
	if (arVoteParams['count_q'] >= arVoteParams['coun_max_q'])
	{
		document.getElementById("vote_question_add").style.display = 'none';
	}
	return false;
}

$(document).on("click",".fm-cancel-post-form",function () {
    $(".post-form-wrap").parent().find('.alert.alert-danger.fade.in').remove();
	if($(".main-wrap-postform .post-form-wrap").length < 1) {
		$(".main-wrap-postform").html($(".post-form-wrap").parent());
	}

	return false;
});
$(document).ready(function(){
	$('#poster_selector input').click(function(){
		$('.special-blocks').hide('medium');
		if ($(this).val() == 'G') {
			$('#anon_block').show('medium');
		} else if ($(this).val() == 'E') {
			$('#signature_block').show('medium');
		}
	});
	$('#selectr_newtopic').change(function(){
		if ($(this).val().substr(0, 3) == 'GID')
			$(this).val(iCurrentFID);
		else
			iCurrentFID = $(this).val();
	});
	$('#payed_topic_link a').click(function(){
		$('#payed_topic_block').show();
		$('#payed_topic_link').hide();
		return false;
	});
	$('#payed_topic_cancel').click(function(){
		$('#payed_topic_block').hide();
		$('#payed_topic_link').show();
		$('#pay_for_decision').val('');
		return false;
	});
	$('#payed_topic_max').click(function(){
		if(confirm("С вашего счета будут списаны все Sm, продолжить?")){
			$('#pay_for_decision').val($('span', this).html());
		}
		return false;
	});
	$('.forum_avatar_change a').click(function(){
		$(this).remove();
		$('#forum_avatar_load').show();
		if (!$.browser.msie) {
			$('#forum_avatar_load').click();
		}
		return false;
	});
});





$(document).ready(function(){

	$("#selectr_newtopic").trigger("change");

	if(typeof $("#REPLIER").validate != 'undefined') {
       $("#REPLIER").validate({
            rules: {
                NEW_EMAIL: {
                    required: true,
					email: true
                },
				TITLE: {
					required: true
				},
                USER_PASSWORD: {
					/*required: true,*/
                    minlength: 3,
                    maxlength: 20
                },
                POST_MESSAGE: {
                    required: true,
					checkNoImgTagInComment: true
                }
            },
            messages: {
				NEW_EMAIL: {
                    required: 'Введите E-mail',
					email: 'Укажите корректный E-mail'
                },
                USER_PASSWORD: {
                    required: 'Введите пароль'
                },
                POST_MESSAGE: {
                    required: 'Небходимо заполнить поле "Сообщение"'
                }
            },
            errorPlacement: function (error, element) {
                error.insertAfter(element.parent());
            },
			submitHandler : function(form) {
				if (window.form_Sauth_lock)
					return;
				window.form_Sauth_lock = true;
				let $objAuth = $(".AUTHFINGER");
				if ($objAuth.length > 0 && $objAuth.val() == "" && typeof Fingerprint2 == "function") {
					Fingerprint2.getV18({}, function (result, components) {
						$objAuth.val(result);
						form.submit();
					});
				} else {
					form.submit();
				}
			}
        });
    }
	$.validator.messages.required   = 'Поле обязательно для заполнения';

	// Добавляем проверку наличия в теле комментария ссылок на изображения
	$.validator.addMethod("checkNoImgTagInComment", function(value, element) {
		return !value.match(/<img/ig) && !value.match(/\[img/ig) && !value.match(/\.(gif|jpe?g|tiff?|png|webp|bmp)$/ig);
	}, 'В тексте не должно быть ссылок на изображения, Вы можете загрузить картинку как файл.');

	$( "textarea[name=POST_MESSAGE]" ).focusin(function() {
		$('.forum_bbcode_line').show();
	});
	$( "textarea[name=POST_MESSAGE]" ).focusout(function() {
		$('.forum_bbcode_line').hide();
	});

	if(supports_html5_storage() && $("textarea[name=POST_MESSAGE]").length > 0 && !location.pathname.startsWith("/connect_mobile/")){
		var ID = (isNaN(parseInt($("textarea[name=POST_MESSAGE]").attr("data-id"),10))?0:parseInt($("textarea[name=POST_MESSAGE]").attr("data-id"),10));
		if (ID < 1) {
			var POST_MESSAGE = localStorage.getItem('POST_MESSAGE' + ID);
			if (POST_MESSAGE && POST_MESSAGE.length > 0)
				$("textarea[name=POST_MESSAGE]").val(POST_MESSAGE);
		}
	}

	if ($(".js-fmain-post .NEW_EMAIL").val()) {
		$(".js-fmain-post .NEW_EMAIL").trigger("change");
	}

});
$(document).on("keyup","textarea[name=POST_MESSAGE]",function(){
	if(supports_html5_storage()){
		var ID = (isNaN(parseInt($(this).attr("data-id"),10))?0:parseInt($(this).attr("data-id"),10));
		localStorage.setItem('POST_MESSAGE'+ID, $(this).val());
	}
})
function supports_html5_storage() {try{return 'localStorage' in window && window['localStorage'] !== null;} catch (e) {return false;}}


$(document).on("click", ".js-fmain-post .js-btn-send-code", function() {
    let SESSID = BX.bitrix_sessid();
    let $PARENT = $(this).parents("form");
    let EMAIL = $PARENT.find(".NEW_EMAIL");
	let NEW_EMAIL  = EMAIL.val();
	if(EMAIL.valid()) {
		$.post("/bitrix/ajax/check_email.php",{"ACTION": "SEND_CODE","sessid": SESSID,"NEW_EMAIL": NEW_EMAIL}, function (arResult) {
			$PARENT.find(".js-block-result-scode").hide().html("").removeClass("text-danger text-success");
			if (arResult.OK) {
				$PARENT.find(".js-block-result-scode").html(arResult.MESSAGE).addClass("text-success").show();
			} else {
				$PARENT.find(".js-block-result-scode").html(arResult.ERROR).addClass("text-danger").show();
			}
		}, "json");
	}
});
//проверка нового email

$(document).on("change",".js-fmain-post .NEW_EMAIL", function() {
	let SESSID = BX.bitrix_sessid();
	let $PARENT = $(this).parents("form");
	let EMAIL = $(this);
	let NEW_EMAIL  = EMAIL.val();

	$PARENT.find(".new-email-result, .wrap-for-auth").hide();
	$PARENT.find(".new-email-result").html('');
	$PARENT.find(".PASSWORD").val('');
	$PARENT.find(".action-rez").html('').removeClass("text-danger text-success");

	if(EMAIL.valid()) {
		$.post("/bitrix/ajax/check_email.php?NEW_EMAIL=" + NEW_EMAIL, {"ACTION": "NEW_EMAIL", "sessid": SESSID, "INIT":'forum'}, function (strResult) {
			let arResult = $.parseJSON(strResult);
			if (arResult.ERROR) {
				$PARENT.find(".new-email-result").html(arResult.ERROR).show();
				if (arResult.ACTION) {
					switch (arResult.ACTION) {
						case "SHOW_AUTH":
                            $PARENT.find(".wrap-for-auth-pass").show();
							//$PARENT.find(".wrap_use_code").hide();
							if (arResult.ACTION_DOP == 'SHOW_CAPTCHA') {
								if(arResult.CAPTCHA_SID && arResult.SRC) {
									$PARENT.find(".wrap_use_captcha img.CAPTCHA_IMG").attr("src", arResult.SRC);
									$PARENT.find(".wrap_use_captcha .CAPTCHA_SID").val(arResult.CAPTCHA_SID);
								}
								$PARENT.find(".wrap_use_captcha").show();
							}
							break;
						case "SHOW_CODE":
							$PARENT.find(".wrap_use_code").show();
							$PARENT.find(".wrap-for-auth-pass").hide();
							if (arResult.ACTION_DOP == 'SHOW_CAPTCHA') {
								if(arResult.CAPTCHA_SID && arResult.SRC) {
									$PARENT.find(".wrap_use_captcha img.CAPTCHA_IMG").attr("src", arResult.SRC);
									$PARENT.find(".wrap_use_captcha .CAPTCHA_SID").val(arResult.CAPTCHA_SID);
								}
								$PARENT.find(".wrap_use_captcha").show();
							}
							break;
					}
				}
			} else {
					$PARENT.find(".new-email-result").hide().html('');
				if (arResult.MESSAGE) {
					var mText = arResult.MESSAGE;
					if (arResult.OK) {
						arResult.MESSAGE += "<br/> Сообщение будет опубликовано после подтверждения E-mail";
					}
					$PARENT.find(".new-email-result").html(arResult.MESSAGE).fadeIn();
				}
				if (arResult.SETINPUT) {
					$('<input type="hidden" name="CHFORREG" value="pub" />').insertAfter(EMAIL);
				}
				if (arResult.RELOAD) {
					window.location.href = window.location.href + '#postform';
					window.location.reload();
				}
			}
		});
	}
});

$(document).on("change",".js-fmain-post .CAPTCHA_WORD",function(){
	let SESSID = BX.bitrix_sessid();
	let $PARENT = $(this).parents("form");
	let $PARENT_CAPTCHA = $(this).parents(".captcha-check");
	let CAPTCHA_WORD  = $(this).val();
	let CAPTCHA_SID  = $PARENT_CAPTCHA.find(".CAPTCHA_SID").val();
	$PARENT_CAPTCHA.find("i.stat-check").hide();
	$PARENT.find(".action-rez").html('').removeClass("text-danger text-success");
	if(!!CAPTCHA_SID  && CAPTCHA_WORD.length == 5){
		$.post("/bitrix/ajax/check_email.php?ACTION=CHECK_CAPTCHA", {"sessid": SESSID, "CAPTCHA_WORD": CAPTCHA_WORD, 'CAPTCHA_SID': CAPTCHA_SID}, function (strResult) {
			let arResult = $.parseJSON(strResult);
			if (arResult.ERROR) {
				$PARENT_CAPTCHA.find("i.text-danger").fadeIn();
				$PARENT.find(".action-rez").addClass('text-danger').html(arResult.ERROR);
				if (arResult.CAPTCHA_SID && arResult.SRC) {
					$PARENT_CAPTCHA.find("img").attr("src", arResult.SRC);
					$PARENT_CAPTCHA.find(".CAPTCHA_SID").val(arResult.CAPTCHA_SID);
				}
			} else {
				$PARENT_CAPTCHA.find("i.text-success").fadeIn();
				$(this).css('border-color', '');
			}
		});
	}

});

/* End */
;
; /* Start:/bitrix/templates/adaptive/js/libs/auth.js*/
/*
* Fingerprintjs2 2.1.0 - Modern & flexible browser fingerprint library v2
* https://github.com/Valve/fingerprintjs2
* Copyright (c) 2015 Valentin Vasilyev (valentin.vasilyev@outlook.com)
* Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
* ARE DISCLAIMED. IN NO EVENT SHALL VALENTIN VASILYEV BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
* THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*
* This software contains code from open-source projects:
* MurmurHash3 by Karan Lyons (https://github.com/karanlyons/murmurHash3.js)
*/

/* global define */
(function (name, context, definition) {
  'use strict'
  if (typeof window !== 'undefined' && typeof define === 'function' && define.amd) { define(definition) } else if (typeof module !== 'undefined' && module.exports) { module.exports = definition() } else if (context.exports) { context.exports = definition() } else { context[name] = definition() }
})('Fingerprint2', this, function () {
  'use strict'

  // detect if object is array
  // only implement if no native implementation is available
  if (typeof Array.isArray === 'undefined') {
    Array.isArray = function (obj) {
      return Object.prototype.toString.call(obj) === '[object Array]'
    }
  };

  /// MurmurHash3 related functions

  //
  // Given two 64bit ints (as an array of two 32bit ints) returns the two
  // added together as a 64bit int (as an array of two 32bit ints).
  //
  var x64Add = function (m, n) {
    m = [m[0] >>> 16, m[0] & 0xffff, m[1] >>> 16, m[1] & 0xffff]
    n = [n[0] >>> 16, n[0] & 0xffff, n[1] >>> 16, n[1] & 0xffff]
    var o = [0, 0, 0, 0]
    o[3] += m[3] + n[3]
    o[2] += o[3] >>> 16
    o[3] &= 0xffff
    o[2] += m[2] + n[2]
    o[1] += o[2] >>> 16
    o[2] &= 0xffff
    o[1] += m[1] + n[1]
    o[0] += o[1] >>> 16
    o[1] &= 0xffff
    o[0] += m[0] + n[0]
    o[0] &= 0xffff
    return [(o[0] << 16) | o[1], (o[2] << 16) | o[3]]
  }

  //
  // Given two 64bit ints (as an array of two 32bit ints) returns the two
  // multiplied together as a 64bit int (as an array of two 32bit ints).
  //
  var x64Multiply = function (m, n) {
    m = [m[0] >>> 16, m[0] & 0xffff, m[1] >>> 16, m[1] & 0xffff]
    n = [n[0] >>> 16, n[0] & 0xffff, n[1] >>> 16, n[1] & 0xffff]
    var o = [0, 0, 0, 0]
    o[3] += m[3] * n[3]
    o[2] += o[3] >>> 16
    o[3] &= 0xffff
    o[2] += m[2] * n[3]
    o[1] += o[2] >>> 16
    o[2] &= 0xffff
    o[2] += m[3] * n[2]
    o[1] += o[2] >>> 16
    o[2] &= 0xffff
    o[1] += m[1] * n[3]
    o[0] += o[1] >>> 16
    o[1] &= 0xffff
    o[1] += m[2] * n[2]
    o[0] += o[1] >>> 16
    o[1] &= 0xffff
    o[1] += m[3] * n[1]
    o[0] += o[1] >>> 16
    o[1] &= 0xffff
    o[0] += (m[0] * n[3]) + (m[1] * n[2]) + (m[2] * n[1]) + (m[3] * n[0])
    o[0] &= 0xffff
    return [(o[0] << 16) | o[1], (o[2] << 16) | o[3]]
  }
  //
  // Given a 64bit int (as an array of two 32bit ints) and an int
  // representing a number of bit positions, returns the 64bit int (as an
  // array of two 32bit ints) rotated left by that number of positions.
  //
  var x64Rotl = function (m, n) {
    n %= 64
    if (n === 32) {
      return [m[1], m[0]]
    } else if (n < 32) {
      return [(m[0] << n) | (m[1] >>> (32 - n)), (m[1] << n) | (m[0] >>> (32 - n))]
    } else {
      n -= 32
      return [(m[1] << n) | (m[0] >>> (32 - n)), (m[0] << n) | (m[1] >>> (32 - n))]
    }
  }
  //
  // Given a 64bit int (as an array of two 32bit ints) and an int
  // representing a number of bit positions, returns the 64bit int (as an
  // array of two 32bit ints) shifted left by that number of positions.
  //
  var x64LeftShift = function (m, n) {
    n %= 64
    if (n === 0) {
      return m
    } else if (n < 32) {
      return [(m[0] << n) | (m[1] >>> (32 - n)), m[1] << n]
    } else {
      return [m[1] << (n - 32), 0]
    }
  }
  //
  // Given two 64bit ints (as an array of two 32bit ints) returns the two
  // xored together as a 64bit int (as an array of two 32bit ints).
  //
  var x64Xor = function (m, n) {
    return [m[0] ^ n[0], m[1] ^ n[1]]
  }
  //
  // Given a block, returns murmurHash3's final x64 mix of that block.
  // (`[0, h[0] >>> 1]` is a 33 bit unsigned right shift. This is the
  // only place where we need to right shift 64bit ints.)
  //
  var x64Fmix = function (h) {
    h = x64Xor(h, [0, h[0] >>> 1])
    h = x64Multiply(h, [0xff51afd7, 0xed558ccd])
    h = x64Xor(h, [0, h[0] >>> 1])
    h = x64Multiply(h, [0xc4ceb9fe, 0x1a85ec53])
    h = x64Xor(h, [0, h[0] >>> 1])
    return h
  }

  //
  // Given a string and an optional seed as an int, returns a 128 bit
  // hash using the x64 flavor of MurmurHash3, as an unsigned hex.
  //
  var x64hash128 = function (key, seed) {
    key = key || ''
    seed = seed || 0
    var remainder = key.length % 16
    var bytes = key.length - remainder
    var h1 = [0, seed]
    var h2 = [0, seed]
    var k1 = [0, 0]
    var k2 = [0, 0]
    var c1 = [0x87c37b91, 0x114253d5]
    var c2 = [0x4cf5ad43, 0x2745937f]
    for (var i = 0; i < bytes; i = i + 16) {
      k1 = [((key.charCodeAt(i + 4) & 0xff)) | ((key.charCodeAt(i + 5) & 0xff) << 8) | ((key.charCodeAt(i + 6) & 0xff) << 16) | ((key.charCodeAt(i + 7) & 0xff) << 24), ((key.charCodeAt(i) & 0xff)) | ((key.charCodeAt(i + 1) & 0xff) << 8) | ((key.charCodeAt(i + 2) & 0xff) << 16) | ((key.charCodeAt(i + 3) & 0xff) << 24)]
      k2 = [((key.charCodeAt(i + 12) & 0xff)) | ((key.charCodeAt(i + 13) & 0xff) << 8) | ((key.charCodeAt(i + 14) & 0xff) << 16) | ((key.charCodeAt(i + 15) & 0xff) << 24), ((key.charCodeAt(i + 8) & 0xff)) | ((key.charCodeAt(i + 9) & 0xff) << 8) | ((key.charCodeAt(i + 10) & 0xff) << 16) | ((key.charCodeAt(i + 11) & 0xff) << 24)]
      k1 = x64Multiply(k1, c1)
      k1 = x64Rotl(k1, 31)
      k1 = x64Multiply(k1, c2)
      h1 = x64Xor(h1, k1)
      h1 = x64Rotl(h1, 27)
      h1 = x64Add(h1, h2)
      h1 = x64Add(x64Multiply(h1, [0, 5]), [0, 0x52dce729])
      k2 = x64Multiply(k2, c2)
      k2 = x64Rotl(k2, 33)
      k2 = x64Multiply(k2, c1)
      h2 = x64Xor(h2, k2)
      h2 = x64Rotl(h2, 31)
      h2 = x64Add(h2, h1)
      h2 = x64Add(x64Multiply(h2, [0, 5]), [0, 0x38495ab5])
    }
    k1 = [0, 0]
    k2 = [0, 0]
    switch (remainder) {
      case 15:
        k2 = x64Xor(k2, x64LeftShift([0, key.charCodeAt(i + 14)], 48))
      // fallthrough
      case 14:
        k2 = x64Xor(k2, x64LeftShift([0, key.charCodeAt(i + 13)], 40))
      // fallthrough
      case 13:
        k2 = x64Xor(k2, x64LeftShift([0, key.charCodeAt(i + 12)], 32))
      // fallthrough
      case 12:
        k2 = x64Xor(k2, x64LeftShift([0, key.charCodeAt(i + 11)], 24))
      // fallthrough
      case 11:
        k2 = x64Xor(k2, x64LeftShift([0, key.charCodeAt(i + 10)], 16))
      // fallthrough
      case 10:
        k2 = x64Xor(k2, x64LeftShift([0, key.charCodeAt(i + 9)], 8))
      // fallthrough
      case 9:
        k2 = x64Xor(k2, [0, key.charCodeAt(i + 8)])
        k2 = x64Multiply(k2, c2)
        k2 = x64Rotl(k2, 33)
        k2 = x64Multiply(k2, c1)
        h2 = x64Xor(h2, k2)
      // fallthrough
      case 8:
        k1 = x64Xor(k1, x64LeftShift([0, key.charCodeAt(i + 7)], 56))
      // fallthrough
      case 7:
        k1 = x64Xor(k1, x64LeftShift([0, key.charCodeAt(i + 6)], 48))
      // fallthrough
      case 6:
        k1 = x64Xor(k1, x64LeftShift([0, key.charCodeAt(i + 5)], 40))
      // fallthrough
      case 5:
        k1 = x64Xor(k1, x64LeftShift([0, key.charCodeAt(i + 4)], 32))
      // fallthrough
      case 4:
        k1 = x64Xor(k1, x64LeftShift([0, key.charCodeAt(i + 3)], 24))
      // fallthrough
      case 3:
        k1 = x64Xor(k1, x64LeftShift([0, key.charCodeAt(i + 2)], 16))
      // fallthrough
      case 2:
        k1 = x64Xor(k1, x64LeftShift([0, key.charCodeAt(i + 1)], 8))
      // fallthrough
      case 1:
        k1 = x64Xor(k1, [0, key.charCodeAt(i)])
        k1 = x64Multiply(k1, c1)
        k1 = x64Rotl(k1, 31)
        k1 = x64Multiply(k1, c2)
        h1 = x64Xor(h1, k1)
      // fallthrough
    }
    h1 = x64Xor(h1, [0, key.length])
    h2 = x64Xor(h2, [0, key.length])
    h1 = x64Add(h1, h2)
    h2 = x64Add(h2, h1)
    h1 = x64Fmix(h1)
    h2 = x64Fmix(h2)
    h1 = x64Add(h1, h2)
    h2 = x64Add(h2, h1)
    return ('00000000' + (h1[0] >>> 0).toString(16)).slice(-8) + ('00000000' + (h1[1] >>> 0).toString(16)).slice(-8) + ('00000000' + (h2[0] >>> 0).toString(16)).slice(-8) + ('00000000' + (h2[1] >>> 0).toString(16)).slice(-8)
  }

  var defaultOptions = {
    preprocessor: null,
    audio: {
      timeout: 1000,
      // On iOS 11, audio context can only be used in response to user interaction.
      // We require users to explicitly enable audio fingerprinting on iOS 11.
      // See https://stackoverflow.com/questions/46363048/onaudioprocess-not-called-on-ios11#46534088
      excludeIOS11: true
    },
    fonts: {
      swfContainerId: 'fingerprintjs2',
      swfPath: 'flash/compiled/FontList.swf',
      userDefinedFonts: [],
      extendedJsFonts: false
    },
    screen: {
      // To ensure consistent fingerprints when users rotate their mobile devices
      detectScreenOrientation: true
    },
    plugins: {
      sortPluginsFor: [/palemoon/i],
      excludeIE: false
    },
    extraComponents: [],
    excludes: {
      // Unreliable on Windows, see https://github.com/Valve/fingerprintjs2/issues/375
      'enumerateDevices': true,
      // devicePixelRatio depends on browser zoom, and it's impossible to detect browser zoom
      'pixelRatio': true,
      // DNT depends on incognito mode for some browsers (Chrome) and it's impossible to detect incognito mode
      'doNotTrack': true,
      // uses js fonts already
      'fontsFlash': true
    },
    NOT_AVAILABLE: 'not available',
    ERROR: 'error',
    EXCLUDED: 'excluded'
  }

  var each = function (obj, iterator) {
    if (Array.prototype.forEach && obj.forEach === Array.prototype.forEach) {
      obj.forEach(iterator)
    } else if (obj.length === +obj.length) {
      for (var i = 0, l = obj.length; i < l; i++) {
        iterator(obj[i], i, obj)
      }
    } else {
      for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
          iterator(obj[key], key, obj)
        }
      }
    }
  }

  var map = function (obj, iterator) {
    var results = []
    // Not using strict equality so that this acts as a
    // shortcut to checking for `null` and `undefined`.
    if (obj == null) {
      return results
    }
    if (Array.prototype.map && obj.map === Array.prototype.map) { return obj.map(iterator) }
    each(obj, function (value, index, list) {
      results.push(iterator(value, index, list))
    })
    return results
  }

  var extendSoft = function (target, source) {
    if (source == null) { return target }
    var value
    var key
    for (key in source) {
      value = source[key]
      if (value != null && !(Object.prototype.hasOwnProperty.call(target, key))) {
        target[key] = value
      }
    }
    return target
  }

  // https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/enumerateDevices
  var enumerateDevicesKey = function (done, options) {
    if (!isEnumerateDevicesSupported()) {
      return done(options.NOT_AVAILABLE)
    }
    navigator.mediaDevices.enumerateDevices().then(function (devices) {
      done(devices.map(function (device) {
        return 'id=' + device.deviceId + ';gid=' + device.groupId + ';' + device.kind + ';' + device.label
      }))
    })['catch'](function (error) {
      done(error)
    })
  }

  var isEnumerateDevicesSupported = function () {
    return (navigator.mediaDevices && navigator.mediaDevices.enumerateDevices)
  }
  // Inspired by and based on https://github.com/cozylife/audio-fingerprint
  var audioKey = function (done, options) {
    var audioOptions = options.audio
    if (audioOptions.excludeIOS11 && navigator.userAgent.match(/OS 11.+Version\/11.+Safari/)) {
      // See comment for excludeUserAgent and https://stackoverflow.com/questions/46363048/onaudioprocess-not-called-on-ios11#46534088
      return done(options.EXCLUDED)
    }

    var AudioContext = window.OfflineAudioContext || window.webkitOfflineAudioContext

    if (AudioContext == null) {
      return done(options.NOT_AVAILABLE)
    }

    var context = new AudioContext(1, 44100, 44100)

    var oscillator = context.createOscillator()
    oscillator.type = 'triangle'
    oscillator.frequency.setValueAtTime(10000, context.currentTime)

    var compressor = context.createDynamicsCompressor()
    each([
      ['threshold', -50],
      ['knee', 40],
      ['ratio', 12],
      ['reduction', -20],
      ['attack', 0],
      ['release', 0.25]
    ], function (item) {
      if (compressor[item[0]] !== undefined && typeof compressor[item[0]].setValueAtTime === 'function') {
        compressor[item[0]].setValueAtTime(item[1], context.currentTime)
      }
    })

    oscillator.connect(compressor)
    compressor.connect(context.destination)
    oscillator.start(0)
    context.startRendering()

    var audioTimeoutId = setTimeout(function () {
      console.warn('Audio fingerprint timed out. Please report bug at https://github.com/Valve/fingerprintjs2 with your user agent: "' + navigator.userAgent + '".')
      context.oncomplete = function () { }
      context = null
      return done('audioTimeout')
    }, audioOptions.timeout)

    context.oncomplete = function (event) {
      var fingerprint
      try {
        clearTimeout(audioTimeoutId)
        fingerprint = event.renderedBuffer.getChannelData(0)
          .slice(4500, 5000)
          .reduce(function (acc, val) { return acc + Math.abs(val) }, 0)
          .toString()
        oscillator.disconnect()
        compressor.disconnect()
      } catch (error) {
        done(error)
        return
      }
      done(fingerprint)
    }
  }
  var UserAgent = function (done) {
    done(navigator.userAgent)
  }
  var webdriver = function (done, options) {
    done(navigator.webdriver == null ? options.NOT_AVAILABLE : navigator.webdriver)
  }
  var languageKey = function (done, options) {
    done(navigator.language || navigator.userLanguage || navigator.browserLanguage || navigator.systemLanguage || options.NOT_AVAILABLE)
  }
  var colorDepthKey = function (done, options) {
    done(window.screen.colorDepth || options.NOT_AVAILABLE)
  }
  var deviceMemoryKey = function (done, options) {
    done(navigator.deviceMemory || options.NOT_AVAILABLE)
  }
  var pixelRatioKey = function (done, options) {
    done(window.devicePixelRatio || options.NOT_AVAILABLE)
  }
  var screenResolutionKey = function (done, options) {
    done(getScreenResolution(options))
  }
  var getScreenResolution = function (options) {
    var resolution = [window.screen.width, window.screen.height]
    if (options.screen.detectScreenOrientation) {
      resolution.sort().reverse()
    }
    return resolution
  }
  var availableScreenResolutionKey = function (done, options) {
    done(getAvailableScreenResolution(options))
  }
  var getAvailableScreenResolution = function (options) {
    if (window.screen.availWidth && window.screen.availHeight) {
      var available = [window.screen.availHeight, window.screen.availWidth]
      if (options.screen.detectScreenOrientation) {
        available.sort().reverse()
      }
      return available
    }
    // headless browsers
    return options.NOT_AVAILABLE
  }
  var timezoneOffset = function (done) {
    done(new Date().getTimezoneOffset())
  }
  var timezone = function (done, options) {
    if (window.Intl && window.Intl.DateTimeFormat) {
      done(new window.Intl.DateTimeFormat().resolvedOptions().timeZone)
      return
    }
    done(options.NOT_AVAILABLE)
  }
  var sessionStorageKey = function (done, options) {
    done(hasSessionStorage(options))
  }
  var localStorageKey = function (done, options) {
    done(hasLocalStorage(options))
  }
  var indexedDbKey = function (done, options) {
    done(hasIndexedDB(options))
  }
  var addBehaviorKey = function (done) {
    // body might not be defined at this point or removed programmatically
    done(!!(document.body && document.body.addBehavior))
  }
  var openDatabaseKey = function (done) {
    done(!!window.openDatabase)
  }
  var cpuClassKey = function (done, options) {
    done(getNavigatorCpuClass(options))
  }
  var platformKey = function (done, options) {
    done(getNavigatorPlatform(options))
  }
  var doNotTrackKey = function (done, options) {
    done(getDoNotTrack(options))
  }
  var canvasKey = function (done, options) {
    if (isCanvasSupported()) {
      done(getCanvasFp(options))
      return
    }
    done(options.NOT_AVAILABLE)
  }
  var webglKey = function (done, options) {
    if (isWebGlSupported()) {
      done(getWebglFp())
      return
    }
    done(options.NOT_AVAILABLE)
  }
  var webglVendorAndRendererKey = function (done) {
    if (isWebGlSupported()) {
      done(getWebglVendorAndRenderer())
      return
    }
    done()
  }
  var adBlockKey = function (done) {
    done(getAdBlock())
  }
  var hasLiedLanguagesKey = function (done) {
    done(getHasLiedLanguages())
  }
  var hasLiedResolutionKey = function (done) {
    done(getHasLiedResolution())
  }
  var hasLiedOsKey = function (done) {
    done(getHasLiedOs())
  }
  var hasLiedBrowserKey = function (done) {
    done(getHasLiedBrowser())
  }
  // flash fonts (will increase fingerprinting time 20X to ~ 130-150ms)
  var flashFontsKey = function (done, options) {
    // we do flash if swfobject is loaded
    if (!hasSwfObjectLoaded()) {
      return done('swf object not loaded')
    }
    if (!hasMinFlashInstalled()) {
      return done('flash not installed')
    }
    if (!options.fonts.swfPath) {
      return done('missing options.fonts.swfPath')
    }
    loadSwfAndDetectFonts(function (fonts) {
      done(fonts)
    }, options)
  }
  // kudos to http://www.lalit.org/lab/javascript-css-font-detect/
  var jsFontsKey = function (done, options) {
    // a font will be compared against all the three default fonts.
    // and if it doesn't match all 3 then that font is not available.
    var baseFonts = ['monospace', 'sans-serif', 'serif']

    var fontList = [
      'Andale Mono', 'Arial', 'Arial Black', 'Arial Hebrew', 'Arial MT', 'Arial Narrow', 'Arial Rounded MT Bold', 'Arial Unicode MS',
      'Bitstream Vera Sans Mono', 'Book Antiqua', 'Bookman Old Style',
      'Calibri', 'Cambria', 'Cambria Math', 'Century', 'Century Gothic', 'Century Schoolbook', 'Comic Sans', 'Comic Sans MS', 'Consolas', 'Courier', 'Courier New',
      'Geneva', 'Georgia',
      'Helvetica', 'Helvetica Neue',
      'Impact',
      'Lucida Bright', 'Lucida Calligraphy', 'Lucida Console', 'Lucida Fax', 'LUCIDA GRANDE', 'Lucida Handwriting', 'Lucida Sans', 'Lucida Sans Typewriter', 'Lucida Sans Unicode',
      'Microsoft Sans Serif', 'Monaco', 'Monotype Corsiva', 'MS Gothic', 'MS Outlook', 'MS PGothic', 'MS Reference Sans Serif', 'MS Sans Serif', 'MS Serif', 'MYRIAD', 'MYRIAD PRO',
      'Palatino', 'Palatino Linotype',
      'Segoe Print', 'Segoe Script', 'Segoe UI', 'Segoe UI Light', 'Segoe UI Semibold', 'Segoe UI Symbol',
      'Tahoma', 'Times', 'Times New Roman', 'Times New Roman PS', 'Trebuchet MS',
      'Verdana', 'Wingdings', 'Wingdings 2', 'Wingdings 3'
    ]

    if (options.fonts.extendedJsFonts) {
      var extendedFontList = [
        'Abadi MT Condensed Light', 'Academy Engraved LET', 'ADOBE CASLON PRO', 'Adobe Garamond', 'ADOBE GARAMOND PRO', 'Agency FB', 'Aharoni', 'Albertus Extra Bold', 'Albertus Medium', 'Algerian', 'Amazone BT', 'American Typewriter',
        'American Typewriter Condensed', 'AmerType Md BT', 'Andalus', 'Angsana New', 'AngsanaUPC', 'Antique Olive', 'Aparajita', 'Apple Chancery', 'Apple Color Emoji', 'Apple SD Gothic Neo', 'Arabic Typesetting', 'ARCHER',
        'ARNO PRO', 'Arrus BT', 'Aurora Cn BT', 'AvantGarde Bk BT', 'AvantGarde Md BT', 'AVENIR', 'Ayuthaya', 'Bandy', 'Bangla Sangam MN', 'Bank Gothic', 'BankGothic Md BT', 'Baskerville',
        'Baskerville Old Face', 'Batang', 'BatangChe', 'Bauer Bodoni', 'Bauhaus 93', 'Bazooka', 'Bell MT', 'Bembo', 'Benguiat Bk BT', 'Berlin Sans FB', 'Berlin Sans FB Demi', 'Bernard MT Condensed', 'BernhardFashion BT', 'BernhardMod BT', 'Big Caslon', 'BinnerD',
        'Blackadder ITC', 'BlairMdITC TT', 'Bodoni 72', 'Bodoni 72 Oldstyle', 'Bodoni 72 Smallcaps', 'Bodoni MT', 'Bodoni MT Black', 'Bodoni MT Condensed', 'Bodoni MT Poster Compressed',
        'Bookshelf Symbol 7', 'Boulder', 'Bradley Hand', 'Bradley Hand ITC', 'Bremen Bd BT', 'Britannic Bold', 'Broadway', 'Browallia New', 'BrowalliaUPC', 'Brush Script MT', 'Californian FB', 'Calisto MT', 'Calligrapher', 'Candara',
        'CaslonOpnface BT', 'Castellar', 'Centaur', 'Cezanne', 'CG Omega', 'CG Times', 'Chalkboard', 'Chalkboard SE', 'Chalkduster', 'Charlesworth', 'Charter Bd BT', 'Charter BT', 'Chaucer',
        'ChelthmITC Bk BT', 'Chiller', 'Clarendon', 'Clarendon Condensed', 'CloisterBlack BT', 'Cochin', 'Colonna MT', 'Constantia', 'Cooper Black', 'Copperplate', 'Copperplate Gothic', 'Copperplate Gothic Bold',
        'Copperplate Gothic Light', 'CopperplGoth Bd BT', 'Corbel', 'Cordia New', 'CordiaUPC', 'Cornerstone', 'Coronet', 'Cuckoo', 'Curlz MT', 'DaunPenh', 'Dauphin', 'David', 'DB LCD Temp', 'DELICIOUS', 'Denmark',
        'DFKai-SB', 'Didot', 'DilleniaUPC', 'DIN', 'DokChampa', 'Dotum', 'DotumChe', 'Ebrima', 'Edwardian Script ITC', 'Elephant', 'English 111 Vivace BT', 'Engravers MT', 'EngraversGothic BT', 'Eras Bold ITC', 'Eras Demi ITC', 'Eras Light ITC', 'Eras Medium ITC',
        'EucrosiaUPC', 'Euphemia', 'Euphemia UCAS', 'EUROSTILE', 'Exotc350 Bd BT', 'FangSong', 'Felix Titling', 'Fixedsys', 'FONTIN', 'Footlight MT Light', 'Forte',
        'FrankRuehl', 'Fransiscan', 'Freefrm721 Blk BT', 'FreesiaUPC', 'Freestyle Script', 'French Script MT', 'FrnkGothITC Bk BT', 'Fruitger', 'FRUTIGER',
        'Futura', 'Futura Bk BT', 'Futura Lt BT', 'Futura Md BT', 'Futura ZBlk BT', 'FuturaBlack BT', 'Gabriola', 'Galliard BT', 'Gautami', 'Geeza Pro', 'Geometr231 BT', 'Geometr231 Hv BT', 'Geometr231 Lt BT', 'GeoSlab 703 Lt BT',
        'GeoSlab 703 XBd BT', 'Gigi', 'Gill Sans', 'Gill Sans MT', 'Gill Sans MT Condensed', 'Gill Sans MT Ext Condensed Bold', 'Gill Sans Ultra Bold', 'Gill Sans Ultra Bold Condensed', 'Gisha', 'Gloucester MT Extra Condensed', 'GOTHAM', 'GOTHAM BOLD',
        'Goudy Old Style', 'Goudy Stout', 'GoudyHandtooled BT', 'GoudyOLSt BT', 'Gujarati Sangam MN', 'Gulim', 'GulimChe', 'Gungsuh', 'GungsuhChe', 'Gurmukhi MN', 'Haettenschweiler', 'Harlow Solid Italic', 'Harrington', 'Heather', 'Heiti SC', 'Heiti TC', 'HELV',
        'Herald', 'High Tower Text', 'Hiragino Kaku Gothic ProN', 'Hiragino Mincho ProN', 'Hoefler Text', 'Humanst 521 Cn BT', 'Humanst521 BT', 'Humanst521 Lt BT', 'Imprint MT Shadow', 'Incised901 Bd BT', 'Incised901 BT',
        'Incised901 Lt BT', 'INCONSOLATA', 'Informal Roman', 'Informal011 BT', 'INTERSTATE', 'IrisUPC', 'Iskoola Pota', 'JasmineUPC', 'Jazz LET', 'Jenson', 'Jester', 'Jokerman', 'Juice ITC', 'Kabel Bk BT', 'Kabel Ult BT', 'Kailasa', 'KaiTi', 'Kalinga', 'Kannada Sangam MN',
        'Kartika', 'Kaufmann Bd BT', 'Kaufmann BT', 'Khmer UI', 'KodchiangUPC', 'Kokila', 'Korinna BT', 'Kristen ITC', 'Krungthep', 'Kunstler Script', 'Lao UI', 'Latha', 'Leelawadee', 'Letter Gothic', 'Levenim MT', 'LilyUPC', 'Lithograph', 'Lithograph Light', 'Long Island',
        'Lydian BT', 'Magneto', 'Maiandra GD', 'Malayalam Sangam MN', 'Malgun Gothic',
        'Mangal', 'Marigold', 'Marion', 'Marker Felt', 'Market', 'Marlett', 'Matisse ITC', 'Matura MT Script Capitals', 'Meiryo', 'Meiryo UI', 'Microsoft Himalaya', 'Microsoft JhengHei', 'Microsoft New Tai Lue', 'Microsoft PhagsPa', 'Microsoft Tai Le',
        'Microsoft Uighur', 'Microsoft YaHei', 'Microsoft Yi Baiti', 'MingLiU', 'MingLiU_HKSCS', 'MingLiU_HKSCS-ExtB', 'MingLiU-ExtB', 'Minion', 'Minion Pro', 'Miriam', 'Miriam Fixed', 'Mistral', 'Modern', 'Modern No. 20', 'Mona Lisa Solid ITC TT', 'Mongolian Baiti',
        'MONO', 'MoolBoran', 'Mrs Eaves', 'MS LineDraw', 'MS Mincho', 'MS PMincho', 'MS Reference Specialty', 'MS UI Gothic', 'MT Extra', 'MUSEO', 'MV Boli',
        'Nadeem', 'Narkisim', 'NEVIS', 'News Gothic', 'News GothicMT', 'NewsGoth BT', 'Niagara Engraved', 'Niagara Solid', 'Noteworthy', 'NSimSun', 'Nyala', 'OCR A Extended', 'Old Century', 'Old English Text MT', 'Onyx', 'Onyx BT', 'OPTIMA', 'Oriya Sangam MN',
        'OSAKA', 'OzHandicraft BT', 'Palace Script MT', 'Papyrus', 'Parchment', 'Party LET', 'Pegasus', 'Perpetua', 'Perpetua Titling MT', 'PetitaBold', 'Pickwick', 'Plantagenet Cherokee', 'Playbill', 'PMingLiU', 'PMingLiU-ExtB',
        'Poor Richard', 'Poster', 'PosterBodoni BT', 'PRINCETOWN LET', 'Pristina', 'PTBarnum BT', 'Pythagoras', 'Raavi', 'Rage Italic', 'Ravie', 'Ribbon131 Bd BT', 'Rockwell', 'Rockwell Condensed', 'Rockwell Extra Bold', 'Rod', 'Roman', 'Sakkal Majalla',
        'Santa Fe LET', 'Savoye LET', 'Sceptre', 'Script', 'Script MT Bold', 'SCRIPTINA', 'Serifa', 'Serifa BT', 'Serifa Th BT', 'ShelleyVolante BT', 'Sherwood',
        'Shonar Bangla', 'Showcard Gothic', 'Shruti', 'Signboard', 'SILKSCREEN', 'SimHei', 'Simplified Arabic', 'Simplified Arabic Fixed', 'SimSun', 'SimSun-ExtB', 'Sinhala Sangam MN', 'Sketch Rockwell', 'Skia', 'Small Fonts', 'Snap ITC', 'Snell Roundhand', 'Socket',
        'Souvenir Lt BT', 'Staccato222 BT', 'Steamer', 'Stencil', 'Storybook', 'Styllo', 'Subway', 'Swis721 BlkEx BT', 'Swiss911 XCm BT', 'Sylfaen', 'Synchro LET', 'System', 'Tamil Sangam MN', 'Technical', 'Teletype', 'Telugu Sangam MN', 'Tempus Sans ITC',
        'Terminal', 'Thonburi', 'Traditional Arabic', 'Trajan', 'TRAJAN PRO', 'Tristan', 'Tubular', 'Tunga', 'Tw Cen MT', 'Tw Cen MT Condensed', 'Tw Cen MT Condensed Extra Bold',
        'TypoUpright BT', 'Unicorn', 'Univers', 'Univers CE 55 Medium', 'Univers Condensed', 'Utsaah', 'Vagabond', 'Vani', 'Vijaya', 'Viner Hand ITC', 'VisualUI', 'Vivaldi', 'Vladimir Script', 'Vrinda', 'Westminster', 'WHITNEY', 'Wide Latin',
        'ZapfEllipt BT', 'ZapfHumnst BT', 'ZapfHumnst Dm BT', 'Zapfino', 'Zurich BlkEx BT', 'Zurich Ex BT', 'ZWAdobeF']
      fontList = fontList.concat(extendedFontList)
    }

    fontList = fontList.concat(options.fonts.userDefinedFonts)

    // remove duplicate fonts
    fontList = fontList.filter(function (font, position) {
      return fontList.indexOf(font) === position
    })

    // we use m or w because these two characters take up the maximum width.
    // And we use a LLi so that the same matching fonts can get separated
    var testString = 'mmmmmmmmmmlli'

    // we test using 72px font size, we may use any size. I guess larger the better.
    var testSize = '72px'

    var h = document.getElementsByTagName('body')[0]

    // div to load spans for the base fonts
    var baseFontsDiv = document.createElement('div')

    // div to load spans for the fonts to detect
    var fontsDiv = document.createElement('div')

    var defaultWidth = {}
    var defaultHeight = {}

    // creates a span where the fonts will be loaded
    var createSpan = function () {
      var s = document.createElement('span')
      /*
       * We need this css as in some weird browser this
       * span elements shows up for a microSec which creates a
       * bad user experience
       */
      s.style.position = 'absolute'
      s.style.left = '-9999px'
      s.style.fontSize = testSize

      // css font reset to reset external styles
      s.style.fontStyle = 'normal'
      s.style.fontWeight = 'normal'
      s.style.letterSpacing = 'normal'
      s.style.lineBreak = 'auto'
      s.style.lineHeight = 'normal'
      s.style.textTransform = 'none'
      s.style.textAlign = 'left'
      s.style.textDecoration = 'none'
      s.style.textShadow = 'none'
      s.style.whiteSpace = 'normal'
      s.style.wordBreak = 'normal'
      s.style.wordSpacing = 'normal'

      s.innerHTML = testString
      return s
    }

    // creates a span and load the font to detect and a base font for fallback
    var createSpanWithFonts = function (fontToDetect, baseFont) {
      var s = createSpan()
      s.style.fontFamily = "'" + fontToDetect + "'," + baseFont
      return s
    }

    // creates spans for the base fonts and adds them to baseFontsDiv
    var initializeBaseFontsSpans = function () {
      var spans = []
      for (var index = 0, length = baseFonts.length; index < length; index++) {
        var s = createSpan()
        s.style.fontFamily = baseFonts[index]
        baseFontsDiv.appendChild(s)
        spans.push(s)
      }
      return spans
    }

    // creates spans for the fonts to detect and adds them to fontsDiv
    var initializeFontsSpans = function () {
      var spans = {}
      for (var i = 0, l = fontList.length; i < l; i++) {
        var fontSpans = []
        for (var j = 0, numDefaultFonts = baseFonts.length; j < numDefaultFonts; j++) {
          var s = createSpanWithFonts(fontList[i], baseFonts[j])
          fontsDiv.appendChild(s)
          fontSpans.push(s)
        }
        spans[fontList[i]] = fontSpans // Stores {fontName : [spans for that font]}
      }
      return spans
    }

    // checks if a font is available
    var isFontAvailable = function (fontSpans) {
      var detected = false
      for (var i = 0; i < baseFonts.length; i++) {
        detected = (fontSpans[i].offsetWidth !== defaultWidth[baseFonts[i]] || fontSpans[i].offsetHeight !== defaultHeight[baseFonts[i]])
        if (detected) {
          return detected
        }
      }
      return detected
    }

    // create spans for base fonts
    var baseFontsSpans = initializeBaseFontsSpans()

    // add the spans to the DOM
    h.appendChild(baseFontsDiv)

    // get the default width for the three base fonts
    for (var index = 0, length = baseFonts.length; index < length; index++) {
      defaultWidth[baseFonts[index]] = baseFontsSpans[index].offsetWidth // width for the default font
      defaultHeight[baseFonts[index]] = baseFontsSpans[index].offsetHeight // height for the default font
    }

    // create spans for fonts to detect
    var fontsSpans = initializeFontsSpans()

    // add all the spans to the DOM
    h.appendChild(fontsDiv)

    // check available fonts
    var available = []
    for (var i = 0, l = fontList.length; i < l; i++) {
      if (isFontAvailable(fontsSpans[fontList[i]])) {
        available.push(fontList[i])
      }
    }

    // remove spans from DOM
    h.removeChild(fontsDiv)
    h.removeChild(baseFontsDiv)
    done(available)
  }
  var pluginsComponent = function (done, options) {
    if (isIE()) {
      if (!options.plugins.excludeIE) {
        done(getIEPlugins(options))
      } else {
        done(options.EXCLUDED)
      }
    } else {
      done(getRegularPlugins(options))
    }
  }
  var getRegularPlugins = function (options) {
    if (navigator.plugins == null) {
      return options.NOT_AVAILABLE
    }

    var plugins = []
    // plugins isn't defined in Node envs.
    for (var i = 0, l = navigator.plugins.length; i < l; i++) {
      if (navigator.plugins[i]) { plugins.push(navigator.plugins[i]) }
    }

    // sorting plugins only for those user agents, that we know randomize the plugins
    // every time we try to enumerate them
    if (pluginsShouldBeSorted(options)) {
      plugins = plugins.sort(function (a, b) {
        if (a.name > b.name) { return 1 }
        if (a.name < b.name) { return -1 }
        return 0
      })
    }
    return map(plugins, function (p) {
      var mimeTypes = map(p, function (mt) {
        return [mt.type, mt.suffixes]
      })
      return [p.name, p.description, mimeTypes]
    })
  }
  var getIEPlugins = function (options) {
    var result = []
    if ((Object.getOwnPropertyDescriptor && Object.getOwnPropertyDescriptor(window, 'ActiveXObject')) || ('ActiveXObject' in window)) {
      var names = [
        'AcroPDF.PDF', // Adobe PDF reader 7+
        'Adodb.Stream',
        'AgControl.AgControl', // Silverlight
        'DevalVRXCtrl.DevalVRXCtrl.1',
        'MacromediaFlashPaper.MacromediaFlashPaper',
        'Msxml2.DOMDocument',
        'Msxml2.XMLHTTP',
        'PDF.PdfCtrl', // Adobe PDF reader 6 and earlier, brrr
        'QuickTime.QuickTime', // QuickTime
        'QuickTimeCheckObject.QuickTimeCheck.1',
        'RealPlayer',
        'RealPlayer.RealPlayer(tm) ActiveX Control (32-bit)',
        'RealVideo.RealVideo(tm) ActiveX Control (32-bit)',
        'Scripting.Dictionary',
        'SWCtl.SWCtl', // ShockWave player
        'Shell.UIHelper',
        'ShockwaveFlash.ShockwaveFlash', // flash plugin
        'Skype.Detection',
        'TDCCtl.TDCCtl',
        'WMPlayer.OCX', // Windows media player
        'rmocx.RealPlayer G2 Control',
        'rmocx.RealPlayer G2 Control.1'
      ]
      // starting to detect plugins in IE
      result = map(names, function (name) {
        try {
          // eslint-disable-next-line no-new
          new window.ActiveXObject(name)
          return name
        } catch (e) {
          return options.ERROR
        }
      })
    } else {
      result.push(options.NOT_AVAILABLE)
    }
    if (navigator.plugins) {
      result = result.concat(getRegularPlugins(options))
    }
    return result
  }
  var pluginsShouldBeSorted = function (options) {
    var should = false
    for (var i = 0, l = options.plugins.sortPluginsFor.length; i < l; i++) {
      var re = options.plugins.sortPluginsFor[i]
      if (navigator.userAgent.match(re)) {
        should = true
        break
      }
    }
    return should
  }
  var touchSupportKey = function (done) {
    done(getTouchSupport())
  }
  var hardwareConcurrencyKey = function (done, options) {
    done(getHardwareConcurrency(options))
  }
  var hasSessionStorage = function (options) {
    try {
      return !!window.sessionStorage
    } catch (e) {
      return options.ERROR // SecurityError when referencing it means it exists
    }
  }

  // https://bugzilla.mozilla.org/show_bug.cgi?id=781447
  var hasLocalStorage = function (options) {
    try {
      return !!window.localStorage
    } catch (e) {
      return options.ERROR // SecurityError when referencing it means it exists
    }
  }
  var hasIndexedDB = function (options) {
    try {
      return !!window.indexedDB
    } catch (e) {
      return options.ERROR // SecurityError when referencing it means it exists
    }
  }
  var getHardwareConcurrency = function (options) {
    if (navigator.hardwareConcurrency) {
      return navigator.hardwareConcurrency
    }
    return options.NOT_AVAILABLE
  }
  var getNavigatorCpuClass = function (options) {
    return navigator.cpuClass || options.NOT_AVAILABLE
  }
  var getNavigatorPlatform = function (options) {
    if (navigator.platform) {
      return navigator.platform
    } else {
      return options.NOT_AVAILABLE
    }
  }
  var getDoNotTrack = function (options) {
    if (navigator.doNotTrack) {
      return navigator.doNotTrack
    } else if (navigator.msDoNotTrack) {
      return navigator.msDoNotTrack
    } else if (window.doNotTrack) {
      return window.doNotTrack
    } else {
      return options.NOT_AVAILABLE
    }
  }
  // This is a crude and primitive touch screen detection.
  // It's not possible to currently reliably detect the  availability of a touch screen
  // with a JS, without actually subscribing to a touch event.
  // http://www.stucox.com/blog/you-cant-detect-a-touchscreen/
  // https://github.com/Modernizr/Modernizr/issues/548
  // method returns an array of 3 values:
  // maxTouchPoints, the success or failure of creating a TouchEvent,
  // and the availability of the 'ontouchstart' property

  var getTouchSupport = function () {
    var maxTouchPoints = 0
    var touchEvent
    if (typeof navigator.maxTouchPoints !== 'undefined') {
      maxTouchPoints = navigator.maxTouchPoints
    } else if (typeof navigator.msMaxTouchPoints !== 'undefined') {
      maxTouchPoints = navigator.msMaxTouchPoints
    }
    try {
      document.createEvent('TouchEvent')
      touchEvent = true
    } catch (_) {
      touchEvent = false
    }
    var touchStart = 'ontouchstart' in window
    return [maxTouchPoints, touchEvent, touchStart]
  }
  // https://www.browserleaks.com/canvas#how-does-it-work

  var getCanvasFp = function (options) {
    var result = []
    // Very simple now, need to make it more complex (geo shapes etc)
    var canvas = document.createElement('canvas')
    canvas.width = 2000
    canvas.height = 200
    canvas.style.display = 'inline'
    var ctx = canvas.getContext('2d')
    // detect browser support of canvas winding
    // http://blogs.adobe.com/webplatform/2013/01/30/winding-rules-in-canvas/
    // https://github.com/Modernizr/Modernizr/blob/master/feature-detects/canvas/winding.js
    ctx.rect(0, 0, 10, 10)
    ctx.rect(2, 2, 6, 6)
    result.push('canvas winding:' + ((ctx.isPointInPath(5, 5, 'evenodd') === false) ? 'yes' : 'no'))

    ctx.textBaseline = 'alphabetic'
    ctx.fillStyle = '#f60'
    ctx.fillRect(125, 1, 62, 20)
    ctx.fillStyle = '#069'
    // https://github.com/Valve/fingerprintjs2/issues/66
    if (options.dontUseFakeFontInCanvas) {
      ctx.font = '11pt Arial'
    } else {
      ctx.font = '11pt no-real-font-123'
    }
    ctx.fillText('Cwm fjordbank glyphs vext quiz, \ud83d\ude03', 2, 15)
    ctx.fillStyle = 'rgba(102, 204, 0, 0.2)'
    ctx.font = '18pt Arial'
    ctx.fillText('Cwm fjordbank glyphs vext quiz, \ud83d\ude03', 4, 45)

    // canvas blending
    // http://blogs.adobe.com/webplatform/2013/01/28/blending-features-in-canvas/
    // http://jsfiddle.net/NDYV8/16/
    ctx.globalCompositeOperation = 'multiply'
    ctx.fillStyle = 'rgb(255,0,255)'
    ctx.beginPath()
    ctx.arc(50, 50, 50, 0, Math.PI * 2, true)
    ctx.closePath()
    ctx.fill()
    ctx.fillStyle = 'rgb(0,255,255)'
    ctx.beginPath()
    ctx.arc(100, 50, 50, 0, Math.PI * 2, true)
    ctx.closePath()
    ctx.fill()
    ctx.fillStyle = 'rgb(255,255,0)'
    ctx.beginPath()
    ctx.arc(75, 100, 50, 0, Math.PI * 2, true)
    ctx.closePath()
    ctx.fill()
    ctx.fillStyle = 'rgb(255,0,255)'
    // canvas winding
    // http://blogs.adobe.com/webplatform/2013/01/30/winding-rules-in-canvas/
    // http://jsfiddle.net/NDYV8/19/
    ctx.arc(75, 75, 75, 0, Math.PI * 2, true)
    ctx.arc(75, 75, 25, 0, Math.PI * 2, true)
    ctx.fill('evenodd')

    if (canvas.toDataURL) { result.push('canvas fp:' + canvas.toDataURL()) }
    return result
  }
  var getWebglFp = function () {
    var gl
    var fa2s = function (fa) {
      gl.clearColor(0.0, 0.0, 0.0, 1.0)
      gl.enable(gl.DEPTH_TEST)
      gl.depthFunc(gl.LEQUAL)
      gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
      return '[' + fa[0] + ', ' + fa[1] + ']'
    }
    var maxAnisotropy = function (gl) {
      var ext = gl.getExtension('EXT_texture_filter_anisotropic') || gl.getExtension('WEBKIT_EXT_texture_filter_anisotropic') || gl.getExtension('MOZ_EXT_texture_filter_anisotropic')
      if (ext) {
        var anisotropy = gl.getParameter(ext.MAX_TEXTURE_MAX_ANISOTROPY_EXT)
        if (anisotropy === 0) {
          anisotropy = 2
        }
        return anisotropy
      } else {
        return null
      }
    }

    gl = getWebglCanvas()
    if (!gl) { return null }
    // WebGL fingerprinting is a combination of techniques, found in MaxMind antifraud script & Augur fingerprinting.
    // First it draws a gradient object with shaders and convers the image to the Base64 string.
    // Then it enumerates all WebGL extensions & capabilities and appends them to the Base64 string, resulting in a huge WebGL string, potentially very unique on each device
    // Since iOS supports webgl starting from version 8.1 and 8.1 runs on several graphics chips, the results may be different across ios devices, but we need to verify it.
    var result = []
    var vShaderTemplate = 'attribute vec2 attrVertex;varying vec2 varyinTexCoordinate;uniform vec2 uniformOffset;void main(){varyinTexCoordinate=attrVertex+uniformOffset;gl_Position=vec4(attrVertex,0,1);}'
    var fShaderTemplate = 'precision mediump float;varying vec2 varyinTexCoordinate;void main() {gl_FragColor=vec4(varyinTexCoordinate,0,1);}'
    var vertexPosBuffer = gl.createBuffer()
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexPosBuffer)
    var vertices = new Float32Array([-0.2, -0.9, 0, 0.4, -0.26, 0, 0, 0.732134444, 0])
    gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW)
    vertexPosBuffer.itemSize = 3
    vertexPosBuffer.numItems = 3
    var program = gl.createProgram()
    var vshader = gl.createShader(gl.VERTEX_SHADER)
    gl.shaderSource(vshader, vShaderTemplate)
    gl.compileShader(vshader)
    var fshader = gl.createShader(gl.FRAGMENT_SHADER)
    gl.shaderSource(fshader, fShaderTemplate)
    gl.compileShader(fshader)
    gl.attachShader(program, vshader)
    gl.attachShader(program, fshader)
    gl.linkProgram(program)
    gl.useProgram(program)
    program.vertexPosAttrib = gl.getAttribLocation(program, 'attrVertex')
    program.offsetUniform = gl.getUniformLocation(program, 'uniformOffset')
    gl.enableVertexAttribArray(program.vertexPosArray)
    gl.vertexAttribPointer(program.vertexPosAttrib, vertexPosBuffer.itemSize, gl.FLOAT, !1, 0, 0)
    gl.uniform2f(program.offsetUniform, 1, 1)
    gl.drawArrays(gl.TRIANGLE_STRIP, 0, vertexPosBuffer.numItems)
    try {
      result.push(gl.canvas.toDataURL())
    } catch (e) {
      /* .toDataURL may be absent or broken (blocked by extension) */
    }
    result.push('extensions:' + (gl.getSupportedExtensions() || []).join(';'))
    result.push('webgl aliased line width range:' + fa2s(gl.getParameter(gl.ALIASED_LINE_WIDTH_RANGE)))
    result.push('webgl aliased point size range:' + fa2s(gl.getParameter(gl.ALIASED_POINT_SIZE_RANGE)))
    result.push('webgl alpha bits:' + gl.getParameter(gl.ALPHA_BITS))
    result.push('webgl antialiasing:' + (gl.getContextAttributes().antialias ? 'yes' : 'no'))
    result.push('webgl blue bits:' + gl.getParameter(gl.BLUE_BITS))
    result.push('webgl depth bits:' + gl.getParameter(gl.DEPTH_BITS))
    result.push('webgl green bits:' + gl.getParameter(gl.GREEN_BITS))
    result.push('webgl max anisotropy:' + maxAnisotropy(gl))
    result.push('webgl max combined texture image units:' + gl.getParameter(gl.MAX_COMBINED_TEXTURE_IMAGE_UNITS))
    result.push('webgl max cube map texture size:' + gl.getParameter(gl.MAX_CUBE_MAP_TEXTURE_SIZE))
    result.push('webgl max fragment uniform vectors:' + gl.getParameter(gl.MAX_FRAGMENT_UNIFORM_VECTORS))
    result.push('webgl max render buffer size:' + gl.getParameter(gl.MAX_RENDERBUFFER_SIZE))
    result.push('webgl max texture image units:' + gl.getParameter(gl.MAX_TEXTURE_IMAGE_UNITS))
    result.push('webgl max texture size:' + gl.getParameter(gl.MAX_TEXTURE_SIZE))
    result.push('webgl max varying vectors:' + gl.getParameter(gl.MAX_VARYING_VECTORS))
    result.push('webgl max vertex attribs:' + gl.getParameter(gl.MAX_VERTEX_ATTRIBS))
    result.push('webgl max vertex texture image units:' + gl.getParameter(gl.MAX_VERTEX_TEXTURE_IMAGE_UNITS))
    result.push('webgl max vertex uniform vectors:' + gl.getParameter(gl.MAX_VERTEX_UNIFORM_VECTORS))
    result.push('webgl max viewport dims:' + fa2s(gl.getParameter(gl.MAX_VIEWPORT_DIMS)))
    result.push('webgl red bits:' + gl.getParameter(gl.RED_BITS))
    result.push('webgl renderer:' + gl.getParameter(gl.RENDERER))
    result.push('webgl shading language version:' + gl.getParameter(gl.SHADING_LANGUAGE_VERSION))
    result.push('webgl stencil bits:' + gl.getParameter(gl.STENCIL_BITS))
    result.push('webgl vendor:' + gl.getParameter(gl.VENDOR))
    result.push('webgl version:' + gl.getParameter(gl.VERSION))

    try {
      // Add the unmasked vendor and unmasked renderer if the debug_renderer_info extension is available
      var extensionDebugRendererInfo = gl.getExtension('WEBGL_debug_renderer_info')
      if (extensionDebugRendererInfo) {
        result.push('webgl unmasked vendor:' + gl.getParameter(extensionDebugRendererInfo.UNMASKED_VENDOR_WEBGL))
        result.push('webgl unmasked renderer:' + gl.getParameter(extensionDebugRendererInfo.UNMASKED_RENDERER_WEBGL))
      }
    } catch (e) { /* squelch */ }

    if (!gl.getShaderPrecisionFormat) {
      loseWebglContext(gl)
      return result
    }

    each(['FLOAT', 'INT'], function (numType) {
      each(['VERTEX', 'FRAGMENT'], function (shader) {
        each(['HIGH', 'MEDIUM', 'LOW'], function (numSize) {
          each(['precision', 'rangeMin', 'rangeMax'], function (key) {
            var format = gl.getShaderPrecisionFormat(gl[shader + '_SHADER'], gl[numSize + '_' + numType])[key]
            if (key !== 'precision') {
              key = 'precision ' + key
            }
            var line = ['webgl ', shader.toLowerCase(), ' shader ', numSize.toLowerCase(), ' ', numType.toLowerCase(), ' ', key, ':', format].join('')
            result.push(line)
          })
        })
      })
    })
    loseWebglContext(gl)
    return result
  }
  var getWebglVendorAndRenderer = function () {
    /* This a subset of the WebGL fingerprint with a lot of entropy, while being reasonably browser-independent */
    try {
      var glContext = getWebglCanvas()
      var extensionDebugRendererInfo = glContext.getExtension('WEBGL_debug_renderer_info')
      var params = glContext.getParameter(extensionDebugRendererInfo.UNMASKED_VENDOR_WEBGL) + '~' + glContext.getParameter(extensionDebugRendererInfo.UNMASKED_RENDERER_WEBGL)
      loseWebglContext(glContext)
      return params
    } catch (e) {
      return null
    }
  }
  var getAdBlock = function () {
    var ads = document.createElement('div')
    ads.innerHTML = '&nbsp;'
    ads.className = 'adsbox'
    var result = false
    try {
      // body may not exist, that's why we need try/catch
      document.body.appendChild(ads)
      result = document.getElementsByClassName('adsbox')[0].offsetHeight === 0
      document.body.removeChild(ads)
    } catch (e) {
      result = false
    }
    return result
  }
  var getHasLiedLanguages = function () {
    // We check if navigator.language is equal to the first language of navigator.languages
    // navigator.languages is undefined on IE11 (and potentially older IEs)
    if (typeof navigator.languages !== 'undefined') {
      try {
        var firstLanguages = navigator.languages[0].substr(0, 2)
        if (firstLanguages !== navigator.language.substr(0, 2)) {
          return true
        }
      } catch (err) {
        return true
      }
    }
    return false
  }
  var getHasLiedResolution = function () {
    return window.screen.width < window.screen.availWidth || window.screen.height < window.screen.availHeight
  }
  var getHasLiedOs = function () {
    var userAgent = navigator.userAgent.toLowerCase()
    var oscpu = navigator.oscpu
    var platform = navigator.platform.toLowerCase()
    var os
    // We extract the OS from the user agent (respect the order of the if else if statement)
    if (userAgent.indexOf('windows phone') >= 0) {
      os = 'Windows Phone'
    } else if (userAgent.indexOf('windows') >= 0 || userAgent.indexOf('win16') >= 0 || userAgent.indexOf('win32') >= 0 || userAgent.indexOf('win64') >= 0 || userAgent.indexOf('win95') >= 0 || userAgent.indexOf('win98') >= 0 || userAgent.indexOf('winnt') >= 0 || userAgent.indexOf('wow64') >= 0) {
      os = 'Windows'
    } else if (userAgent.indexOf('android') >= 0) {
      os = 'Android'
    } else if (userAgent.indexOf('linux') >= 0 || userAgent.indexOf('cros') >= 0 || userAgent.indexOf('x11') >= 0) {
      os = 'Linux'
    } else if (userAgent.indexOf('iphone') >= 0 || userAgent.indexOf('ipad') >= 0 || userAgent.indexOf('ipod') >= 0 || userAgent.indexOf('crios') >= 0 || userAgent.indexOf('fxios') >= 0) {
      os = 'iOS'
    } else if (userAgent.indexOf('macintosh') >= 0 || userAgent.indexOf('mac_powerpc)') >= 0) {
      os = 'Mac'
    } else {
      os = 'Other'
    }
    // We detect if the person uses a touch device
    var mobileDevice = (('ontouchstart' in window) ||
      (navigator.maxTouchPoints > 0) ||
      (navigator.msMaxTouchPoints > 0))

    if (mobileDevice && os !== 'Windows' && os !== 'Windows Phone' && os !== 'Android' && os !== 'iOS' && os !== 'Other' && userAgent.indexOf('cros') === -1) {
      return true
    }

    // We compare oscpu with the OS extracted from the UA
    if (typeof oscpu !== 'undefined') {
      oscpu = oscpu.toLowerCase()
      if (oscpu.indexOf('win') >= 0 && os !== 'Windows' && os !== 'Windows Phone') {
        return true
      } else if (oscpu.indexOf('linux') >= 0 && os !== 'Linux' && os !== 'Android') {
        return true
      } else if (oscpu.indexOf('mac') >= 0 && os !== 'Mac' && os !== 'iOS') {
        return true
      } else if ((oscpu.indexOf('win') === -1 && oscpu.indexOf('linux') === -1 && oscpu.indexOf('mac') === -1) !== (os === 'Other')) {
        return true
      }
    }

    // We compare platform with the OS extracted from the UA
    if (platform.indexOf('win') >= 0 && os !== 'Windows' && os !== 'Windows Phone') {
      return true
    } else if ((platform.indexOf('linux') >= 0 || platform.indexOf('android') >= 0 || platform.indexOf('pike') >= 0) && os !== 'Linux' && os !== 'Android') {
      return true
    } else if ((platform.indexOf('mac') >= 0 || platform.indexOf('ipad') >= 0 || platform.indexOf('ipod') >= 0 || platform.indexOf('iphone') >= 0) && os !== 'Mac' && os !== 'iOS') {
      return true
    } else if (platform.indexOf('arm') >= 0 && os === 'Windows Phone') {
      return false
    } else if (platform.indexOf('pike') >= 0 && userAgent.indexOf('opera mini') >= 0) {
      return false
    } else {
      var platformIsOther = platform.indexOf('win') < 0 &&
        platform.indexOf('linux') < 0 &&
        platform.indexOf('mac') < 0 &&
        platform.indexOf('iphone') < 0 &&
        platform.indexOf('ipad') < 0 &&
        platform.indexOf('ipod') < 0
      if (platformIsOther !== (os === 'Other')) {
        return true
      }
    }

    return typeof navigator.plugins === 'undefined' && os !== 'Windows' && os !== 'Windows Phone'
  }
  var getHasLiedBrowser = function () {
    var userAgent = navigator.userAgent.toLowerCase()
    var productSub = navigator.productSub

    // we extract the browser from the user agent (respect the order of the tests)
    var browser
    if (userAgent.indexOf('edge/') >= 0 || userAgent.indexOf('iemobile/') >= 0) {
      // Unreliable, different versions use EdgeHTML, Webkit, Blink, etc.
      return false
    } else if (userAgent.indexOf('opera mini') >= 0) {
      // Unreliable, different modes use Presto, WebView, Webkit, etc.
      return false
    } else if (userAgent.indexOf('firefox/') >= 0) {
      browser = 'Firefox'
    } else if (userAgent.indexOf('opera/') >= 0 || userAgent.indexOf(' opr/') >= 0) {
      browser = 'Opera'
    } else if (userAgent.indexOf('chrome/') >= 0) {
      browser = 'Chrome'
    } else if (userAgent.indexOf('safari/') >= 0) {
      if (userAgent.indexOf('android 1.') >= 0 || userAgent.indexOf('android 2.') >= 0 || userAgent.indexOf('android 3.') >= 0 || userAgent.indexOf('android 4.') >= 0) {
        browser = 'AOSP'
      } else {
        browser = 'Safari'
      }
    } else if (userAgent.indexOf('trident/') >= 0) {
      browser = 'Internet Explorer'
    } else {
      browser = 'Other'
    }

    if ((browser === 'Chrome' || browser === 'Safari' || browser === 'Opera') && productSub !== '20030107') {
      return true
    }

    // eslint-disable-next-line no-eval
    var tempRes = eval.toString().length
    if (tempRes === 37 && browser !== 'Safari' && browser !== 'Firefox' && browser !== 'Other') {
      return true
    } else if (tempRes === 39 && browser !== 'Internet Explorer' && browser !== 'Other') {
      return true
    } else if (tempRes === 33 && browser !== 'Chrome' && browser !== 'AOSP' && browser !== 'Opera' && browser !== 'Other') {
      return true
    }

    // We create an error to see how it is handled
    var errFirefox
    try {
      // eslint-disable-next-line no-throw-literal
      throw 'a'
    } catch (err) {
      try {
        err.toSource()
        errFirefox = true
      } catch (errOfErr) {
        errFirefox = false
      }
    }
    return errFirefox && browser !== 'Firefox' && browser !== 'Other'
  }
  var isCanvasSupported = function () {
    var elem = document.createElement('canvas')
    return !!(elem.getContext && elem.getContext('2d'))
  }
  var isWebGlSupported = function () {
    // code taken from Modernizr
    if (!isCanvasSupported()) {
      return false
    }

    var glContext = getWebglCanvas()
    var isSupported = !!window.WebGLRenderingContext && !!glContext
    loseWebglContext(glContext)
    return isSupported
  }
  var isIE = function () {
    if (navigator.appName === 'Microsoft Internet Explorer') {
      return true
    } else if (navigator.appName === 'Netscape' && /Trident/.test(navigator.userAgent)) { // IE 11
      return true
    }
    return false
  }
  var hasSwfObjectLoaded = function () {
    return typeof window.swfobject !== 'undefined'
  }
  var hasMinFlashInstalled = function () {
    return window.swfobject.hasFlashPlayerVersion('9.0.0')
  }
  var addFlashDivNode = function (options) {
    var node = document.createElement('div')
    node.setAttribute('id', options.fonts.swfContainerId)
    document.body.appendChild(node)
  }
  var loadSwfAndDetectFonts = function (done, options) {
    var hiddenCallback = '___fp_swf_loaded'
    window[hiddenCallback] = function (fonts) {
      done(fonts)
    }
    var id = options.fonts.swfContainerId
    addFlashDivNode()
    var flashvars = { onReady: hiddenCallback }
    var flashparams = { allowScriptAccess: 'always', menu: 'false' }
    window.swfobject.embedSWF(options.fonts.swfPath, id, '1', '1', '9.0.0', false, flashvars, flashparams, {})
  }
  var getWebglCanvas = function () {
    var canvas = document.createElement('canvas')
    var gl = null
    try {
      gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl')
    } catch (e) { /* squelch */ }
    if (!gl) { gl = null }
    return gl
  }
  var loseWebglContext = function (context) {
    var loseContextExtension = context.getExtension('WEBGL_lose_context')
    if (loseContextExtension != null) {
      loseContextExtension.loseContext()
    }
  }

  var components = [
    { key: 'userAgent', getData: UserAgent },
    { key: 'webdriver', getData: webdriver },
    { key: 'language', getData: languageKey },
    { key: 'colorDepth', getData: colorDepthKey },
    { key: 'deviceMemory', getData: deviceMemoryKey },
    { key: 'pixelRatio', getData: pixelRatioKey },
    { key: 'hardwareConcurrency', getData: hardwareConcurrencyKey },
    { key: 'screenResolution', getData: screenResolutionKey },
    { key: 'availableScreenResolution', getData: availableScreenResolutionKey },
    { key: 'timezoneOffset', getData: timezoneOffset },
    { key: 'timezone', getData: timezone },
    { key: 'sessionStorage', getData: sessionStorageKey },
    { key: 'localStorage', getData: localStorageKey },
    { key: 'indexedDb', getData: indexedDbKey },
    { key: 'addBehavior', getData: addBehaviorKey },
    { key: 'openDatabase', getData: openDatabaseKey },
    { key: 'cpuClass', getData: cpuClassKey },
    { key: 'platform', getData: platformKey },
    { key: 'doNotTrack', getData: doNotTrackKey },
    { key: 'plugins', getData: pluginsComponent },
    { key: 'canvas', getData: canvasKey },
    { key: 'webgl', getData: webglKey },
    { key: 'webglVendorAndRenderer', getData: webglVendorAndRendererKey },
    { key: 'adBlock', getData: adBlockKey },
    { key: 'hasLiedLanguages', getData: hasLiedLanguagesKey },
    { key: 'hasLiedResolution', getData: hasLiedResolutionKey },
    { key: 'hasLiedOs', getData: hasLiedOsKey },
    { key: 'hasLiedBrowser', getData: hasLiedBrowserKey },
    { key: 'touchSupport', getData: touchSupportKey },
    { key: 'fonts', getData: jsFontsKey, pauseBefore: true },
    { key: 'fontsFlash', getData: flashFontsKey, pauseBefore: true },
    { key: 'audio', getData: audioKey },
    { key: 'enumerateDevices', getData: enumerateDevicesKey }
  ]

  var Fingerprint2 = function (options) {
    throw new Error("'new Fingerprint()' is deprecated, see https://github.com/Valve/fingerprintjs2#upgrade-guide-from-182-to-200")
  }

  Fingerprint2.get = function (options, callback) {
    if (!callback) {
      callback = options
      options = {}
    } else if (!options) {
      options = {}
    }
    extendSoft(options, defaultOptions)
    options.components = options.extraComponents.concat(components)

    var keys = {
      data: [],
      addPreprocessedComponent: function (key, value) {
        if (typeof options.preprocessor === 'function') {
          value = options.preprocessor(key, value)
        }
        keys.data.push({ key: key, value: value })
      }
    }

    var i = -1
    var chainComponents = function (alreadyWaited) {
      i += 1
      if (i >= options.components.length) { // on finish
        callback(keys.data)
        return
      }
      var component = options.components[i]

      if (options.excludes[component.key]) {
        chainComponents(false) // skip
        return
      }

      if (!alreadyWaited && component.pauseBefore) {
        i -= 1
        setTimeout(function () {
          chainComponents(true)
        }, 1)
        return
      }

      try {
        component.getData(function (value) {
          keys.addPreprocessedComponent(component.key, value)
          chainComponents(false)
        }, options)
      } catch (error) {
        // main body error
        keys.addPreprocessedComponent(component.key, String(error))
        chainComponents(false)
      }
    }

    chainComponents(false)
  }

  Fingerprint2.getPromise = function (options) {
    return new Promise(function (resolve, reject) {
      Fingerprint2.get(options, resolve)
    })
  }

  Fingerprint2.getV18 = function (options, callback) {
    if (callback == null) {
      callback = options
      options = {}
    }
    return Fingerprint2.get(options, function (components) {
      var newComponents = []
      for (var i = 0; i < components.length; i++) {
        var component = components[i]
        if (component.value === (options.NOT_AVAILABLE || 'not available')) {
          newComponents.push({ key: component.key, value: 'unknown' })
        } else if (component.key === 'plugins') {
          newComponents.push({
            key: 'plugins',
            value: map(component.value, function (p) {
              var mimeTypes = map(p[2], function (mt) {
                if (mt.join) { return mt.join('~') }
                return mt
              }).join(',')
              return [p[0], p[1], mimeTypes].join('::')
            })
          })
        } else if (['canvas', 'webgl'].indexOf(component.key) !== -1 && Array.isArray(component.value)) {
          // sometimes WebGL returns error in headless browsers (during CI testing for example)
          // so we need to join only if the values are array
          newComponents.push({ key: component.key, value: component.value.join('~') })
        } else if (['sessionStorage', 'localStorage', 'indexedDb', 'addBehavior', 'openDatabase'].indexOf(component.key) !== -1) {
          if (component.value) {
            newComponents.push({ key: component.key, value: 1 })
          } else {
            // skip
            continue
          }
        } else {
          if (component.value) {
            newComponents.push(component.value.join ? { key: component.key, value: component.value.join(';') } : component)
          } else {
            newComponents.push({ key: component.key, value: component.value })
          }
        }
      }
      var murmur = x64hash128(map(newComponents, function (component) { return component.value }).join('~~~'), 31)
      callback(murmur, newComponents)
    })
  }

  Fingerprint2.x64hash128 = x64hash128
  Fingerprint2.VERSION = '2.1.0'
  return Fingerprint2
})

/* End */
;; /* /bitrix/templates/.default/js/highlight1c.js*/
; /* /bitrix/templates/.default/components/infostart/public.detail.new/adaptive/script.js*/
; /* /bitrix/templates/.default/js/spoiler.js*/
; /* /bitrix/templates/adaptive/js/ckeditor/plugins/codesnippet/lib/highlight/highlight.pack.js*/
; /* /bitrix/templates/adaptive/include/public_&_object_list/public_&_object_list.js*/
; /* /bitrix/components/infostart/new.public.list/templates/.default/script.js*/
; /* /bitrix/components/infostart/asd.forum.mess.list/templates/redesign_adpt/script.js*/
; /* /bitrix/templates/.default/components/infostart/super.component/forum_complaints_list/script.js*/
; /* /bitrix/templates/.default/components/infostart/forum_main.post_form/adaptive/script.js*/
; /* /bitrix/templates/adaptive/js/libs/auth.js*/
