Перем КэшНоменклатуры;
Перем КэшХарактеристик;
	
Перем КэшНоменклатурыБинСКЛ;
Перем КэшХарактеристикБинСКЛ;

var adoConnection;	// COM-объект соединения
var connString;		// строка - строка подключения / СправочникСсылка.мис_СтрокиКоннектов
var username;		// строка - имя пользователя
var password;		// строка - пароль
var queryText;		// строка - текст запроса
var recordSet;		// COM-объект ADORecordset
var command;		// COM-объект ADOCommand
var commandTimeout;	// число. по-умолчанию 30 сек




#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.8");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Импорт_Из_УПП_AdoConnection");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Импорт_Из_УПП_AdoConnection");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Импорт_Из_УПП_AdoConnection",
		"Форма_Импорт_Из_УПП_AdoConnection",
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



// Этот класс создает подключение к базе SQL

// Использование
//	конн 			= Обработки.мис_AdoConnection.Создать();
//	connString 		= Справочники.мис_СтрокиКоннектов.ПолучитьСтрокуПодключения(Объект.Ссылка);
//	конн.setConnectionString(connString);
//	конн.connect();


//	// Выполнение запроса

//	// Вариант 1
//	ADOConnection 	= конн.getConnection();
//	Recordset = ADOConnection.execute(ТекстЗапроса);

//	// Вариант 2
//	конн.setQueryText(ТекстЗапроса);
//	Recordset = конн.exec();
//	конн.disconnect();
//
// Вариант 3. flow-стиль
//
//конн = Обработки.мис_AdoConnection
//				.Создать()
//				.setConnectionString( СправочникСсылка.мис_СтрокиКоннектов )
//				.connect()
//				.setQueryText( ТекстЗапроса() )
//				.exec();
//				
//recordSet = конн.getRecordset();
//...
//конн.disconnect();



//									PUBLIC


function exec() export
	
	//recordSet = adoConnection.execute(queryText);
	if command = undefined then
		command = newCommand();
	endIf; 
	
	recordSet = command.execute(queryText);
	
	return thisObject;
	
endFunction
 
function close() export
	
	if ТипЗнч(adoConnection) = Тип("COMОбъект") then
		adoConnection.close();
	endIf; 
	
	return thisObject;
	
endFunction

function connect() export
	
	if adoConnection = undefined then
		adoConnection = newConnection();
	endIf; 
	
	return thisObject;
	
endFunction

function disconnect() export
	
	if adoConnection = undefined then
		return thisObject;
	endIf;
		
	adoConnection.close();
		
	return thisObject;
	
endFunction

function newCommand()
	
	_Command 					= Новый COMОбъект("ADODB.Command"); 
	_Command.ActiveConnection 	= adoConnection;
	_Command.CommandTimeout		= commandTimeout;
	_Command.CommandText 		= queryText; 
    _Command.CommandType 		= 8;//adCmdUnknown(8)    //adCmdStoredProc(4) 	- хранимая процедура. 
	
	return _Command;
	
endFunction
 

//
function recordsetToValTable() export
	
	//valTable = new valueTable;
	//while not recordSet.eof() do
	//	ns = valTable.Добавить();
	//	ns[col] = recordSet.items(col).value;
	//	recordSet.moveNext();
	//endDo;
	//return valTable;
	
endFunction
 

//									GETTERS

function getConnection() export
	
	if adoConnection = undefined then
		
		adoConnection = newConnection();
		
	endIf; 
	
	return adoConnection;
	
endFunction

// Возвращает строку подключения (тип данных - строка)
function getConnectionString() export
	
	return connString;
	
endFunction

function getUsername() export
	
	return username;
	
endFunction

function getRecordset() export
	
	return recordSet;
	
endFunction

function getCommand() export
	
	return command;
	
endFunction

//									SETTERS

// connStringParam - СправочникСсылка.мис_СтрокиКоннектов / строка
function setConnectionString(Val connStringParam) export
	
	//example
	//Provider=SQLNCLI11;Server=localhost;Database=MIS_SERVICE;
	
	connString = TrimAll(Справочники.мис_СтрокиКоннектов.ПолучитьСтрокуПодключения( connStringParam ));
	if Прав(connString,1) <> ";" then
		connString = connString + ";";
	endif; 
	return thisObject;
	
endFunction
 
function setUsername(usernameParam) export
		
	username = usernameParam;
	return thisObject;
	
endFunction

function setPassword(passwordParam) export
		
	password = passwordParam;
	return thisObject;
	
endFunction

function setQueryText(queryTextParam) export
		
	queryText = queryTextParam;
	return thisObject;
	
endFunction

function setCommandTimeout(commandTimeoutParam) export
		
	commandTimeout = commandTimeoutParam;
	return thisObject;
	
endFunction

//									PRIVATE

// Описание_метода
//
// Параметры:
//	СтрокаСоединенияПарам - строка
//	Пользователь - строка
//	Пароль - строка
//
// Возвращаемое значение:
//	Тип: ADODB.Connection
//
Функция newConnection()  
	
	//Если НЕ ЗначениеЗаполнено(connString) ИЛИ connString = ";" Тогда
	//	connString = "Provider=SQLNCLI11;Server=localhost;Database=databaseName;"; 
	//КонецЕсли; 
	//Если НЕ ЗначениеЗаполнено(password) Тогда
	//	Password = "";
	//КонецЕсли;
	//Если СтрНайти(НРег(connString), "password") = 0 И ЗначениеЗаполнено(СокрЛП(password)) Тогда
	//connString = connString + "Password="+СокрЛП(password)+";";
	//КонецЕсли;
	//Если НЕ ЗначениеЗаполнено(username) Тогда
	//	Username = "sa";
	//КонецЕсли; 
	//Если СтрНайти(НРег(connString), "user id") = 0 И ЗначениеЗаполнено(СокрЛП(username)) Тогда
	//	connString = connString + "User Id="+СокрЛП(username)+";";
	//КонецЕсли; 	
	adoConnection = Новый COMОбъект("ADODB.Connection"); 
		adoConnection.Open(connString);

	Возврат adoConnection;
	
КонецФункции

///////////////////////////////////////
// from manager module

//типы данных ADO 
//https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/datatypeenum?view=sql-server-2016

#Область ПараметрыЗапроса

//СУУ_ЕНС функция создает таб значений "Параметры", в которую помещаются параметры,
//предназначенные для передачи СОМОбъекту ADODB.Command
//Параметры:
//	ИДВызова - объект справочника СУУ_ИндексЛога
//Возвращаемое значение:
//	пустая таблица значений
//
Функция СУУ_СоздатьТЗПараметры() Экспорт

	Параметры 	= Новый ТаблицаЗначений;
	Параметры.Колонки.Добавить("Имя");
	Параметры.Колонки.Добавить("Тип");
	Параметры.Колонки.Добавить("Размер");
	Параметры.Колонки.Добавить("Направление");
	Параметры.Колонки.Добавить("Значение");

	Возврат Параметры;
	
КонецФункции

//СУУ_ЕНС Функция добавляет параметр в таб значений "Параметры", созданную в функции СоздатьТЗПараметры()
//Параметры:
//	ИДВызова - объект справочника СУУ_ИндексЛога
//	ТЗ - таб значений "Параметры"
//	Имя - имя параметра, например @dateUpdate
//	Тип - строка, возможные значений "Дата", "Число", "Строка"
//	Направление - направление параметра, возможные значения:
//		Входной, Выходной, ВходнойВыходной, ВозвращаемоеЗначение
//	Значение - значение параметра
//Возвращаемое значение:
//	булево. не используется.
//
Функция СУУ_ДобавитьПараметрВТЗ(ТЗ, Имя, Тип, Размер=0, Направление, Значение) Экспорт

	НовСтр = ТЗ.Добавить();
	НовСтр.Имя = Имя;
	НовСтр.Тип = Тип;
	НовСтр.Размер = Размер;
	НовСтр.Направление = Направление;
	
	// СУУ_ТЕА распишем по типам
	Если ТипЗнч(Значение) = Тип("Число") Тогда
		НовСтр.Значение = Значение;
	ИначеЕсли ТипЗнч(Значение) = Тип("Дата") или НРЕГ(Тип) = "дата" Тогда
		НовСтр.Значение = Формат(Значение, "ДФ=гггг-ММ-дд")
	Иначе
		Если Не ЗначениеЗаполнено(Значение) Тогда
			//СУУ_ЕНС для пустых значений будем передавать NULL Объекту ADODB.Command
			НовСтр.Значение = NULL;
			Возврат Истина;
		Иначе
			НовСтр.Значение = Значение;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Истина;

КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Создает типизированную ТЗ
Функция ПолучитьПустойТЗРекордсетИзАДОРекордсета(RecordSet) Экспорт
	
	КолвоКолонок = RecordSet.Fields.Count;

	ТЗРекордсет = Новый ТаблицаЗначений;
	Для сч = 0 по КолвоКолонок-1 Цикл
		ТЗРекордсет.Колонки.Добавить(
			RecordSet.fields(сч).Name,
			ПолучитьТипДанныхADO(RecordSet.fields(сч))
			);
	КонецЦикла;
	
	Возврат ТЗРекордсет;
	
КонецФункции


// Добавляет строку в ТЗ и заполняет ее из рекордсета АДО
//
// Параметры:
//	ТЗРекордсет 	- Таблица значений - 
//	Recordset		- АДО рекордсет - 
//
// Возвращаемое значение:
//	Тип: строка ТЗ
//
Функция ДобавитьСтрокуВТЗРекордсет(ТЗРекордсет, Recordset) Экспорт
	
	КолвоКолонок = RecordSet.Fields.Count;
	
	НовСтр = ТЗРекордсет.Добавить();
	Для сч = 0 по КолвоКолонок-1 Цикл
		НовСтр[сч] 		 = RecordSet.Fields.Item(сч).Value;
	КонецЦикла;
	
	Возврат НовСтр;
	
КонецФункции


// Создает ТЗ и перекладывает в нее рекордсет АДО
//
// Параметры:
//	Recordset		- АДО рекордсет - 
//
// Возвращаемое значение:
//	Тип: ТЗ
//
Функция ПереложиьРекордсетАДОвТаблицуЗначений(RecordSet) Экспорт
	
	ТЗ = ПолучитьПустойТЗРекордсетИзАДОРекордсета(RecordSet);
	
	Пока НЕ RecordSet.EOF Цикл
		
		ДобавитьСтрокуВТЗРекордсет(ТЗ, RecordSet);//добавить и заполнить
		
		RecordSet.MoveNext();
		
	КонецЦикла;
	
	Возврат ТЗ;
	
КонецФункции
 

#КонецОбласти

//СУУ_ЕНС Выполняет SQL-запрос, и возвращает recordset 
//Параметры:
//	ТекстЗапроса	- строка - текст на языке TSQL (имя хранимой процедуры)
//	Параметры 		- строка - входящие параметры, таблица значений с параметрами запроса
//	ADOConnection 	- строка - COMОбъект типа ADODB.Connection
//	ХранимаяПроцедура - булево - определяет тип параметра команды
//Возвращаемое значение:
//	Булево, Истина в случае успешного выполнения
//
Функция ВыполнитьКомандуSQL(ТекстЗапроса, Параметры, ADOConnection, ХранимаяПроцедура=Ложь) Экспорт
	
	Command = Новый COMОбъект("ADODB.Command"); 
	Command.ActiveConnection 	= ADOConnection;
	Command.CommandTimeout		= 0;
	Command.CommandText 		= ТекстЗапроса; 
    Command.CommandType 		= ?(ХранимаяПроцедура = Истина, 4, 8);//adCmdUnknown(8)    //adCmdStoredProc(4) 	- хранимая процедура. 
	
	УстановитьПараметрыADOCommand(Command, Параметры);
	
	RecordSet = Command.Execute(); 
	
	Возврат RecordSet;
	
КонецФункции

//@deprecated
//@ see ВыполнитьКомандуSQL()
//@ причина: нелогичное имя метода
//
//СУУ_ЕНС Выполняет SQL-запрос, и возвращает recordset 
//Параметры:
//	ТекстЗапроса	- строка - текст на языке TSQL (имя хранимой процедуры)
//	Параметры 		- строка - входящие параметры, таблица значений с параметрами запроса
//	ADOConnection 	- строка - COMОбъект типа ADODB.Connection
//	ХранимаяПроцедура - булево - определяет тип параметра команды
//Возвращаемое значение:
//	Булево, Истина в случае успешного выполнения
//
Функция СУУ_SELECT(ТекстЗапроса, Параметры, ADOConnection, ХранимаяПроцедура=Ложь) Экспорт
	
	Command = Новый COMОбъект("ADODB.Command"); 
	Command.ActiveConnection 	= ADOConnection;
	Command.CommandTimeout		= 0;
	Command.CommandText 		= ТекстЗапроса; 
    Command.CommandType 		= ?(ХранимаяПроцедура = Истина, 4, 8);//adCmdUnknown(8)    //adCmdStoredProc(4) 	- хранимая процедура. 
	
	УстановитьПараметрыADOCommand(Command, Параметры);
	
	RecordSet = Command.Execute(); 
	
	Возврат RecordSet;
	
КонецФункции

//Параметры:
//	Параметры - таблица значений - см. СУУ_СоздатьТЗПараметры
Процедура УстановитьПараметрыADOCommand(Command, Параметры) Экспорт
	
	Если ТипЗнч(Параметры) <> Тип("ТаблицаЗначений") Тогда
		Возврат;
	КонецЕсли; 
	Для Каждого Стр Из Параметры Цикл
		Тип 		= СУУ_ПолучитьТипПараметраХранимойПроцедуры(Стр.Тип);
		Направление = СУУ_ПолучитьНаправлениеПараметра(Стр.Направление);
		Parameter = Command.CreateParameter(
							Стр.Имя, 
							Тип, 
							Направление, 
							?(Стр.Размер<>0,Стр.Размер,Неопределено),
							?(Стр.Значение=NULL,NULL,Стр.Значение)
						);
		Command.Parameters.Append(Parameter);
	КонецЦикла;
	
КонецПроцедуры
 
//СУУ_ЕНС Определяет числовой тип параметра по переданному имени
//Параметры:
//	ИДВызова - объект справочника СУУ_ИндексЛога
//	ТипПараметра - строка, например "Дата", "Число", "Строка"
//Возвращаемое значение:
//	Число, числовая константа для метода CreateParameter() СОМОбъекта ADODB.Command
//
Функция СУУ_ПолучитьТипПараметраХранимойПроцедуры(ТипПараметра) Экспорт
	
	Т = НРег(СокрЛП(ТипПараметра));
	
	Если Т = "дата" Тогда //adDBTimeStamp
		Возврат 135;	
	ИначеЕсли Т = "число" Тогда //adDouble
		Возврат 5;
	ИначеЕсли Т = "строка" Тогда //adVarChar
		Возврат 200;
	ИначеЕсли Т = "varchar" Тогда //adVarChar
		Возврат 200;
	Иначе           			
		Возврат 200; //adVarChar
	КонецЕсли;
	
	
	//AdArray 		0x2000 	A flag value, always combined with another data type constant, that indicates an array of the other data type. Does not apply to ADOX
	//adBigInt 		20 		Indicates an eight-byte signed integer (DBTYPE_I8).
	//adBinary 		128 	Indicates a binary value (DBTYPE_BYTES).
	//adBoolean 	11 		Indicates a Boolean value (DBTYPE_BOOL).
	//adBSTR 		8 		Indicates a null-terminated character string (Unicode) (DBTYPE_BSTR).
	//adChapter 	136 	Indicates a four-byte chapter value that identifies rows in a child rowset (DBTYPE_HCHAPTER).
	//adChar 		129 	Indicates a string value (DBTYPE_STR).
	//adCurrency 	6 		Indicates a currency value (DBTYPE_CY). Currency is a fixed-point number with four digits to the right of the decimal point. It is stored in an eight-byte signed integer scaled by 10,000.
	//adDate 		7 		Indicates a date value (DBTYPE_DATE). A date is stored as a double, the whole part of which is the number of days since December 30, 1899, and the fractional part of which is the fraction of a day.
	//adDBDate 		133 	Indicates a date value (yyyymmdd) (DBTYPE_DBDATE).
	//adDBTime 		134 	Indicates a time value (hhmmss) (DBTYPE_DBTIME).
	//adDBTimeStamp 135 	Indicates a date/time stamp (yyyymmddhhmmss plus a fraction in billionths) (DBTYPE_DBTIMESTAMP).
	//adDecimal 	14 		Indicates an exact numeric value with a fixed precision and scale (DBTYPE_DECIMAL).
	//adDouble 		5 		Indicates a double-precision floating-point value (DBTYPE_R8).
	//adEmpty 		0 		Specifies no value (DBTYPE_EMPTY).
	//adError 		10 		Indicates a 32-bit error code (DBTYPE_ERROR).
	//adFileTime 	64 		Indicates a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (DBTYPE_FILETIME).
	//adGUID 		72 		Indicates a globally unique identifier (GUID) (DBTYPE_GUID).
	//adIDispatch 	9 		Indicates a pointer to an IDispatch interface on a COM object (DBTYPE_IDISPATCH).
	//						Note   This data type is currently not supported by ADO. Usage may cause unpredictable results.
	//adInteger 	3 		Indicates a four-byte signed integer (DBTYPE_I4).
	//adIUnknown 	13 		Indicates a pointer to an IUnknown interface on a COM object (DBTYPE_IUNKNOWN).
	//						Note    This data type is currently not supported by ADO. Usage may cause unpredictable results.
	//adLongVarBinary 205 	Indicates a long binary value.
	//adLongVarChar 201 	Indicates a long string value.
	//adLongVarWChar 203 	Indicates a long null-terminated Unicode string value.
	//adNumeric 	131 	Indicates an exact numeric value with a fixed precision and scale (DBTYPE_NUMERIC).
	//adPropVariant 138 	Indicates an Automation PROPVARIANT (DBTYPE_PROP_VARIANT).
	//adSingle 		4 		Indicates a single-precision floating-point value (DBTYPE_R4).
	//adSmallInt 	2 		Indicates a two-byte signed integer (DBTYPE_I2).
	//adTinyInt 	16 		Indicates a one-byte signed integer (DBTYPE_I1).
	//adUnsignedBigInt 21 	Indicates an eight-byte unsigned integer (DBTYPE_UI8).
	//adUnsignedInt 19 		Indicates a four-byte unsigned integer (DBTYPE_UI4).
	//adUnsignedSmallInt 18 Indicates a two-byte unsigned integer (DBTYPE_UI2).
	//adUnsignedTinyInt 17 	Indicates a one-byte unsigned integer (DBTYPE_UI1).
	//adUserDefined 132 	Indicates a user-defined variable (DBTYPE_UDT).
	//adVarBinary 	204 	Indicates a binary value.
	//adVarChar 	200 	Indicates a string value.
	//adVariant 	12 		Indicates an Automation Variant (DBTYPE_VARIANT).
	//						Note    This data type is currently not supported by ADO. Usage may cause unpredictable results.
	//adVarNumeric 	139 	Indicates a numeric value.
	//adVarWChar 	202 	Indicates a null-terminated Unicode character string.
	//adWChar 		130 	Indicates a null-terminated Unicode character string (DBTYPE_WSTR).
	
КонецФункции

//СУУ_ЕНС определяет числовое значение направления параметра из переданной строки
//Параметры:
//	ИДВызова - объект справочника СУУ_ИндексЛога
//	Направление - тип "Строка". Возможные значения:
//	Входной
//	Выходной
//	ВходнойВыходной
//	ВозвращаемоеЗначение
//
//Возвращаемое значение:
//	Число, числовая константа для метода CreateParameter() СОМОбъекта ADODB.Command
//
Функция СУУ_ПолучитьНаправлениеПараметра(Направление) Экспорт
	//СУУ_ЕНС 
	//Direction - целое число (long), "направление" параметра. Возможные значения: 
	//	adParamUnknown(0) - направление параметра неизвестно. 
	//	adParamInput(1) - по умолчанию, входной параметр. 
	//	adParamOutput(2) - выходной параметр. 
	//	adParamInputOutput(3) - параметр представляет собой и входной, и выходной параметр 
	//	adParamReturnValue(4) - параметр представляет собой возвращаемое значение. 

	Если Направление = "Входной" Тогда
		Возврат 1;
	ИначеЕсли Направление = "Выходной" Тогда
		Возврат 2;
	ИначеЕсли Направление = "ВходнойВыходной" Тогда
		Возврат 3;
	ИначеЕсли Направление = "ВозвращаемоеЗначение" Тогда
		Возврат 4;
	Иначе
		Возврат 0;
	КонецЕсли;

КонецФункции

//СУУ_ЛЕВ http://www.sql.ru/forum/678251/1s-8-1-i-ado-datatypeenum-constants-tipy-dannyh-i-preobrazovanie 
// Параметры
//	Поле - поле рекордсета - RecordSet.fields(сч)
//
Функция ПолучитьТипДанныхADO(Поле) Экспорт
	
	Т = Поле.Type;
	
	Если Т = 20 Тогда				//adBigInt 		20 		Indicates an eight-byte signed integer (DBTYPE_I8).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(20, 0, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 11 Тогда				//adBoolean 	11 		Indicates a Boolean value (DBTYPE_BOOL).
		Возврат Новый ОписаниеТипов("Булево");
	ИначеЕсли Т = 8 Тогда				//adBSTR 		8 		Indicates a null-terminated character string (Unicode) (DBTYPE_BSTR).
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 136 Тогда				//adChapter 	136 	Indicates a four-byte chapter value that identifies rows in a child rowset (DBTYPE_HCHAPTER).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 129 Тогда				//adChar 		129 	Indicates a string value (DBTYPE_STR).
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 6 Тогда				//adCurrency 	6 		Indicates a currency value (DBTYPE_CY). Currency is a fixed-point number with four digits to the right of the decimal point. It is stored in an eight-byte signed integer scaled by 10,000.
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 7 Тогда				//adDate 		7 		Indicates a date value (DBTYPE_DATE). A date is stored as a double, the whole part of which is the number of days since December 30, 1899, and the fractional part of which is the fraction of a day.
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 133 Тогда				//adDBDate 		133 	Indicates a date value (yyyymmdd) (DBTYPE_DBDATE).
		Возврат Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя));
	ИначеЕсли Т = 134 Тогда				//adDBTime 		134 	Indicates a time value (hhmmss) (DBTYPE_DBTIME).
		Возврат Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя));
	ИначеЕсли Т = 135 Тогда				//adDBTimeStamp 135 	Indicates a date/time stamp (yyyymmddhhmmss plus a fraction in billionths) (DBTYPE_DBTIMESTAMP).
		Возврат Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя));
	ИначеЕсли Т = 14 Тогда				//adDecimal 	14 		Indicates an exact numeric value with a fixed precision and scale (DBTYPE_DECIMAL).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 5 Тогда				//adDouble 		5 		Indicates a double-precision floating-point value (DBTYPE_R8).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 0 Тогда				//adEmpty 		0 		Specifies no value (DBTYPE_EMPTY).
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 10 Тогда				//adError 		10 		Indicates a 32-bit error code (DBTYPE_ERROR).
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 64 Тогда				//adFileTime 	64 		Indicates a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (DBTYPE_FILETIME).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 72 Тогда				//adGUID 		72 		Indicates a globally unique identifier (GUID) (DBTYPE_GUID).
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 9 Тогда				//adIDispatch 	9 		Indicates a pointer to an IDispatch interface on a COM object (DBTYPE_IDISPATCH).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
										//Note   This data type is currently not supported by ADO. Usage may cause unpredictable results.
	ИначеЕсли Т = 3 Тогда				//adInteger 	3 		Indicates a four-byte signed integer (DBTYPE_I4).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(20, 0, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 13 Тогда				//adIUnknown 	13 		Indicates a pointer to an IUnknown interface on a COM object (DBTYPE_IUNKNOWN).
										//Note    This data type is currently not supported by ADO. Usage may cause unpredictable results.
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 205 Тогда				//adLongVarBinary 205 	Indicates a long binary value.
		Р = Тип("ДвоичныеДанные");
	ИначеЕсли Т = 201 Тогда				//adLongVarChar 201 	Indicates a long string value.
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 203 Тогда				//adLongVarWChar 203 	Indicates a long null-terminated Unicode string value.
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 131 Тогда				//adNumeric 	131 	Indicates an exact numeric value with a fixed precision and scale (DBTYPE_NUMERIC).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 138 Тогда				//adPropVariant 138 	Indicates an Automation PROPVARIANT (DBTYPE_PROP_VARIANT).
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 4 Тогда				//adSingle 		4 		Indicates a single-precision floating-point value (DBTYPE_R4).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 2 Тогда				//adSmallInt 	2 		Indicates a two-byte signed integer (DBTYPE_I2).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(20, 0, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 16 Тогда				//adTinyInt 	16 		Indicates a one-byte signed integer (DBTYPE_I1).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(20, 0, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 21 Тогда				//adUnsignedBigInt 21 	Indicates an eight-byte unsigned integer (DBTYPE_UI8).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(20, 0, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 19 Тогда				//adUnsignedInt 19 		Indicates a four-byte unsigned integer (DBTYPE_UI4).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(20, 0, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 18 Тогда				//adUnsignedSmallInt 18 Indicates a two-byte unsigned integer (DBTYPE_UI2).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(20, 0, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 17 Тогда				//adUnsignedTinyInt 17 	Indicates a one-byte unsigned integer (DBTYPE_UI1).
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(20, 0, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 132 Тогда				//adUserDefined 132 	Indicates a user-defined variable (DBTYPE_UDT).
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 204 Тогда				//adVarBinary 	204 	Indicates a binary value.
		Р = Тип("ДвоичныеДанные");
	ИначеЕсли Т = 200 Тогда				//adVarChar 	200 	Indicates a string value.
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 12 Тогда				//adVariant 	12 		Indicates an Automation Variant (DBTYPE_VARIANT).
										//Note    This data type is currently not supported by ADO. Usage may cause unpredictable results.
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 139 Тогда				//adVarNumeric 	139 	Indicates a numeric value.
		Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(19, 6, ДопустимыйЗнак.Любой), , );
	ИначеЕсли Т = 202 Тогда				//adVarWChar 	202 	Indicates a null-terminated Unicode character string.
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	ИначеЕсли Т = 130 Тогда				//adWChar 		130 	Indicates a null-terminated Unicode character string (DBTYPE_WSTR).
		Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(Поле.DefinedSize, ДопустимаяДлина.Переменная), );
	КонецЕсли;

    //Если тип не определен, то создаем текстовое поле
	Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(), );
	

КонецФункции // ПолучитьТипДанныхADO()
 
//СУУ_ЕНС конвертирует тип данных АДО в тип 1С
// https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/datatypeenum?view=sql-server-2016
//Параметры:
//	Т - число, тип данных АДО
//Возвращаемое значение:
//	Объект "Тип"
//
Функция СУУ_ТипИзАДОв1С(Т) Экспорт
	
	Перем Р;
	
	Если Т = 8192 Тогда					//AdArray 		0x2000 	A flag value, always combined with another data type constant, that indicates an array of the other data type. Does not apply to ADOX
		Р = Тип("Массив");
	ИначеЕсли Т = 20 Тогда				//adBigInt 		20 		Indicates an eight-byte signed integer (DBTYPE_I8).
		Р = Тип("Число");
	ИначеЕсли Т = 128 Тогда				//adBinary 		128 	Indicates a binary value (DBTYPE_BYTES).
		Р = Тип("ХранилищеЗначения");
	ИначеЕсли Т = 11 Тогда				//adBoolean 	11 		Indicates a Boolean value (DBTYPE_BOOL).
		Р = Тип("Булево");
	ИначеЕсли Т = 8 Тогда				//adBSTR 		8 		Indicates a null-terminated character string (Unicode) (DBTYPE_BSTR).
		Р = Тип("Строка");
	ИначеЕсли Т = 136 Тогда				//adChapter 	136 	Indicates a four-byte chapter value that identifies rows in a child rowset (DBTYPE_HCHAPTER).
		Р = Тип("Число");
	ИначеЕсли Т = 129 Тогда				//adChar 		129 	Indicates a string value (DBTYPE_STR).
		Р = Тип("Строка");
	ИначеЕсли Т = 6 Тогда				//adCurrency 	6 		Indicates a currency value (DBTYPE_CY). Currency is a fixed-point number with four digits to the right of the decimal point. It is stored in an eight-byte signed integer scaled by 10,000.
		Р = Тип("Число");
	ИначеЕсли Т = 7 Тогда				//adDate 		7 		Indicates a date value (DBTYPE_DATE). A date is stored as a double, the whole part of which is the number of days since December 30, 1899, and the fractional part of which is the fraction of a day.
		Р = Тип("Число");
	ИначеЕсли Т = 133 Тогда				//adDBDate 		133 	Indicates a date value (yyyymmdd) (DBTYPE_DBDATE).
		Р = Тип("Дата");
	ИначеЕсли Т = 134 Тогда				//adDBTime 		134 	Indicates a time value (hhmmss) (DBTYPE_DBTIME).
		Р = Тип("Дата");
	ИначеЕсли Т = 135 Тогда				//adDBTimeStamp 135 	Indicates a date/time stamp (yyyymmddhhmmss plus a fraction in billionths) (DBTYPE_DBTIMESTAMP).
		Р = Тип("Дата");
	ИначеЕсли Т = 14 Тогда				//adDecimal 	14 		Indicates an exact numeric value with a fixed precision and scale (DBTYPE_DECIMAL).
		Р = Тип("Число");
	ИначеЕсли Т = 5 Тогда				//adDouble 		5 		Indicates a double-precision floating-point value (DBTYPE_R8).
		Р = Тип("Число");
	ИначеЕсли Т = 0 Тогда				//adEmpty 		0 		Specifies no value (DBTYPE_EMPTY).
		Р = Тип("Строка");
	ИначеЕсли Т = 10 Тогда				//adError 		10 		Indicates a 32-bit error code (DBTYPE_ERROR).
		Р = Тип("Строка");
	ИначеЕсли Т = 64 Тогда				//adFileTime 	64 		Indicates a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (DBTYPE_FILETIME).
		Р = Тип("Число");
	ИначеЕсли Т = 72 Тогда				//adGUID 		72 		Indicates a globally unique identifier (GUID) (DBTYPE_GUID).
		Р = Тип("Строка");
	ИначеЕсли Т = 9 Тогда				//adIDispatch 	9 		Indicates a pointer to an IDispatch interface on a COM object (DBTYPE_IDISPATCH).
		Р = Тип("Число");
										//Note   This data type is currently not supported by ADO. Usage may cause unpredictable results.
	ИначеЕсли Т = 3 Тогда				//adInteger 	3 		Indicates a four-byte signed integer (DBTYPE_I4).
		Р = Тип("Число");
	ИначеЕсли Т = 13 Тогда				//adIUnknown 	13 		Indicates a pointer to an IUnknown interface on a COM object (DBTYPE_IUNKNOWN).
										//Note    This data type is currently not supported by ADO. Usage may cause unpredictable results.
		Р = Тип("Число");
	ИначеЕсли Т = 205 Тогда				//adLongVarBinary 205 	Indicates a long binary value.
		Р = Тип("ДвоичныеДанные");
	ИначеЕсли Т = 201 Тогда				//adLongVarChar 201 	Indicates a long string value.
		Р = Тип("Строка");
	ИначеЕсли Т = 203 Тогда				//adLongVarWChar 203 	Indicates a long null-terminated Unicode string value.
		Р = Тип("Строка");
	ИначеЕсли Т = 131 Тогда				//adNumeric 	131 	Indicates an exact numeric value with a fixed precision and scale (DBTYPE_NUMERIC).
		Р = Тип("Число");
	ИначеЕсли Т = 138 Тогда				//adPropVariant 138 	Indicates an Automation PROPVARIANT (DBTYPE_PROP_VARIANT).
		Р = Тип("Строка");
	ИначеЕсли Т = 4 Тогда				//adSingle 		4 		Indicates a single-precision floating-point value (DBTYPE_R4).
		Р = Тип("Число");
	ИначеЕсли Т = 2 Тогда				//adSmallInt 	2 		Indicates a two-byte signed integer (DBTYPE_I2).
		Р = Тип("Число");
	ИначеЕсли Т = 16 Тогда				//adTinyInt 	16 		Indicates a one-byte signed integer (DBTYPE_I1).
		Р = Тип("Число");
	ИначеЕсли Т = 21 Тогда				//adUnsignedBigInt 21 	Indicates an eight-byte unsigned integer (DBTYPE_UI8).
		Р = Тип("Число");
	ИначеЕсли Т = 19 Тогда				//adUnsignedInt 19 		Indicates a four-byte unsigned integer (DBTYPE_UI4).
		Р = Тип("Число");
	ИначеЕсли Т = 18 Тогда				//adUnsignedSmallInt 18 Indicates a two-byte unsigned integer (DBTYPE_UI2).
		Р = Тип("Число");
	ИначеЕсли Т = 17 Тогда				//adUnsignedTinyInt 17 	Indicates a one-byte unsigned integer (DBTYPE_UI1).
		Р = Тип("Число");
	ИначеЕсли Т = 132 Тогда				//adUserDefined 132 	Indicates a user-defined variable (DBTYPE_UDT).
		Р = Тип("Строка");
	ИначеЕсли Т = 204 Тогда				//adVarBinary 	204 	Indicates a binary value.
		Р = Тип("ДвоичныеДанные");
	ИначеЕсли Т = 200 Тогда				//adVarChar 	200 	Indicates a string value.
		Р = Тип("Строка");
	ИначеЕсли Т = 12 Тогда				//adVariant 	12 		Indicates an Automation Variant (DBTYPE_VARIANT).
										//Note    This data type is currently not supported by ADO. Usage may cause unpredictable results.
		Р = Тип("Строка");
	ИначеЕсли Т = 139 Тогда				//adVarNumeric 	139 	Indicates a numeric value.
		Р = Тип("Число");
	ИначеЕсли Т = 202 Тогда				//adVarWChar 	202 	Indicates a null-terminated Unicode character string.
		Р = Тип("Строка");
	ИначеЕсли Т = 130 Тогда				//adWChar 		130 	Indicates a null-terminated Unicode character string (DBTYPE_WSTR).
		Р = Тип("Строка");
	КонецЕсли;

	Возврат Р;
	
КонецФункции



// Описание_метода
//
// Параметры:
//	ТЗПараметров 	- таблица значений - см. СУУ_СоздатьТЗПараметры()
//
// Возвращаемое значение:
//	Тип: ADODB.Command
//
Функция prepareStatement(commandText, ADOConnection, ТЗПараметров) Export
	
	// подготовленная команда для чтения - проверки наличия id
	Command 					= Новый COMОбъект("ADODB.Command");
	Command.ActiveConnection 	= ADOConnection;
	Command.prepared 			= 1;
	Command.commandText 		= commandText;
	
	УстановитьПараметрыADOCommand(Command, ТЗПараметров);
	
	Возврат Command;
	
КонецФункции

// Примеры подключения
function adoQueryExample() Export
	// Linux:
	// https://infostart.ru/1c/articles/544232/
	// https://infostart.ru/1c/articles/522751/
	// ADO
	// https://www.script-coding.com/ADO.html

	// Create connection
	adoConnection 				= new COMObject("ADODB.Connection"); 
	// Connect
	connString = "Driver={PostgreSQL ANSI};Server=192.168.1.1;Port=5432;Database=kafkatest;Uid=postgres;Pwd=postgres;";
	adoConnection.Open(connString);
	// Create command
	command 					= new COMObject("ADODB.Command");
	// Set up the attributes
	command.activeConnection 	= ADOConnection;
	command.prepared 			= 1;// Variant - 0 if there is no parameters "?"
	command.commandText 		= "SELECT * FROM table WHERE field1=?";
	// Add parameters
	paramName = ""; // string
	paramType = 1;// int             //СУУ_ПолучитьТипПараметраХранимойПроцедуры(ТипПараметра) Экспорт
	paramDirection = 1; // int       //СУУ_ПолучитьНаправлениеПараметра(Направление) Экспорт 
	paramSize = 0;
	paramValue = NULL;
	parameter = command.createParameter(
						paramName,
						paramType,     
						paramDirection,
						?(paramSize=0, undefined, paramSize),
						?(paramValue=NULL, NULL, paramValue)
						);
	command.parameters.append(parameter);
	// Retrieve the data
	Recordset = command.execute(); // Variant - without returning RS if there is data modification query
	// Variant: if we do not have to set up many parameters
	//	Recordset = ADOConnection.execute(queryText);
	// Process the RecordSet
	while not Recordset.EOF() do
		// Read all the fields of a row
		for count = 0 to Recordset.Fields.Count - 1 do
													 	// https://docs.microsoft.com/en-us/sql/ado/reference/ado-api/datatypeenum?view=sql-server-2016
			fieldType = Recordset.fields(count).Type;	//ПолучитьТипДанныхADO()
			
			value = Recordset.fields.item(count).Value;
		enddo;
		Recordset.MoveNext();
	enddo;
	parameter 		= undefined;
	Recordset 		= undefined;
	command 		= undefined;
	adoConnection.close();
	adoConnection 	= undefined;
	return undefined;
	
	// using ADODB.Recordset
	
	Recordset = new COMObject("ADODB.Recordset");
	ServerName = "(local)"; //'имя или IP-адрес сервера
	DSN = "master"; // 'имя базы данных
	UID = "sa"; // 'логин пользователя SQL-сервера
	PWD = "111"; // 'пароль пользователя SQL-сервера
	ConnectString = "Provider=SQLOLEDB;Data Source="+ServerName+";Initial Catalog="+DSN+";UID="+UID+";PWD="+PWD;
	Recordset.ActiveConnection = ConnectString;
	// Variant
	//	Recordset.ActiveConnection = adoConnection;
	Recordset.Source = "SELECT name, filename FROM sysdatabases";
	Recordset.Open();
	while not Recordset.EOF() do
    	strRes = "";
    	for i=0 to Recordset.Fields.Count-1 do
        	strRes = strRes + string(Recordset.Fields(i).Value) + ",";
    	enddo;
    	message(strRes);
    	Recordset.MoveNext();
	enddo;
	Recordset.Close();
	Recordset = undefined;
	
	
	
	 
	
endFunction
 
	
	












// Параметры
//	МестоЗапуска - число - 0 - ноут XPS, 1 - периметр ЭЛИС
//
Процедура ЗагрузитьВсеНаСервере(ИдВызова,ИмяСервера,ИмяБазыДанных,
	ИмяПользователя,Пароль,Знач РазмерПакета, Обновлять,МестоЗапуска) Экспорт
	
	adoConnection = Новый COMОбъект("ADODB.Connection");
	Порт=1433;
	
	//ИмяСервера = "1c-dev";
	//ИмяПользователя = "eleg8-koderline";
	//Пароль="5820ApodPlotPreeExteType";
	//ИмяБазыДанных="eleg8-koderline";
	ДрайверMSSQL = "ODBC.17";
	connString = ConnectionString(ИмяСервера, Порт, ИмяПользователя, Пароль, ИмяБазыДанных, ДрайверMSSQL);
	adoConnection.Open(connString);
	
	
	
	Если МестоЗапуска = 0 Тогда 
		// ноут XPS
		queryText = "select _FLD35039RRef as Goods, 
		|_FLD35040RRef  as Chars, 
		|_FLD35041 as Barcode 
		|from _InfoRg35038";   
		
	ИначеЕсли МестоЗапуска = 1 Тогда
		// УПП
		queryText = "select _Fld15502_RRRef as Goods, 
		|_Fld15504RRef  as Chars, 
		|_Fld15501 as Barcode 
		|from _InfoRg15498"; 
		
	КонецЕсли;

	
	_Command 					= Новый COMОбъект("ADODB.Command"); 
	_Command.ActiveConnection 	= adoConnection;
	_Command.CommandTimeout		= 20;
	_Command.CommandText 		= queryText; 
    _Command.CommandType 		= 8;//adCmdUnknown(8)    //adCmdStoredProc(4) 	- хранимая процедура. 

	
	
	recordSet = _Command.execute();  
	                                   
	
	// конкретная стратегия импорта данных
	ИмяМетодаФонЗадания = "ксп_ВыполнениеКода.ОбработатьПакет_Фон";
	
	// параметры стратегии импорта (параметр ДопПараметры метода ИмяМетодФонЗадания);
	ПараметрыМетодаФонЗадания = Новый Структура;
	ПараметрыМетодаФонЗадания.Вставить("ИмяВнешнейОбработки",		"Импорт_Из_УПП_AdoConnection");
	ПараметрыМетодаФонЗадания.Вставить("ИдВызова",	идвызова);
	ПараметрыМетодаФонЗадания.Вставить("Обновлять",	Обновлять);

    Если не типзнч(РазмерПакета)=тип("Число") Тогда
		РазмерПакета = 10000;
	КонецЕсли;
	
	Обработки.мис_класс_ПараллельнаяОбработкаАлгоритма
		.Создать()
		.Конструктор(ИдВызова)
		.сетКоллекция(recordSet)
		.сетДопПараметры(ПараметрыМетодаФонЗадания)//четвертый параметр в прокси-методе фонового задания
		.сетОписаниеФоновогоЗадания("Параллельная загрузка ШК из УПП")
		.сетИмяМетодаФоновогоЗадания(ИмяМетодаФонЗадания)
		.сетРазмерПакета(РазмерПакета)
		.ОбработатьПараллельноADORecordset();
	
	
	//
	//
	//
	//ТЗРекордсет = ТЗРекордсет();    
	//СчЗаданий = 0;          
	//МассивПараметров = Новый массив;
	//
	//while not recordSet.eof do
	//	
	//	КолВПакете=0;
	//	ТЗРекордсет.Очистить();

	//	while not recordSet.eof И КолВПакете < 10000 do
	//		КолВПакете=КолВПакете+1;
	//		
	//		//пустой гуид в субд: 0x00000000000000000000000000000000
	//		//непустой: 0x80C14CCC6A0BFFF311E6C10D673B12C1
	//		
	//		НовСтр = ТЗРекордсет.добавить();      
	//		НовСтр.Штрихкод 		= recordSet.Fields.Item(2).value;
	//		ном = recordSet.Fields.Item(0).value;   //ComSafeArray       
	//		хар = recordSet.Fields.Item(1).value;   //ComSafeArray
	//		
	//		НовСтр.Номенклатура 	= ном.Выгрузить();  
	//		НовСтр.Характеристика 	= хар.Выгрузить();
	//		
	//		recordSet.moveNext();
	//		
	//	enddo;   
	//	
	//	СчЗаданий=СчЗаданий+1;
	//	МассивПараметров.Очистить();
	//	
	//	СтруктураПараметров = Новый структура;
	//	СтруктураПараметров.Вставить("ТЗРекордсет", ТЗРекордсет);
	//	СтруктураПараметров.Вставить("СчЗаданий", СчЗаданий);
	//	СтруктураПараметров.Вставить("ИдВызова", ИдВызова);
	//	
	//	МассивПараметров.Добавить(СтруктураПараметров);
	//	
	//	ОбработатьОдинПакет(ИдВызова, СчЗаданий, ТЗРекордсет);
	//	
	//enddo;
	
	adoConnection.close();
	adoConnection="";
	
КонецПроцедуры



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ОбработатьПакет_Фон(Знач ИдВызова, ТЗРекордсет, НомерЗадания, ДопПараметры) Экспорт	
	
	ВремяНач = ТекущаяУниверсальнаяДатаВМиллисекундах();

	ИдВызова = мис_логгерСервер.СоздатьИдВызова(ИдВызова, "Номер задания = "+Строка(НомерЗадания), ТекущаяДата(),"", Неопределено, Неопределено);
	мЛоггер = мис_логгерСервер.getLogger(ИдВызова);
	млоггер.инфо("ОбработатьОдинПакет запуск. Номер задания = %1 ",строка(НомерЗадания));
	
	
	Попытка
		
		Обновлять = ДопПараметры.Обновлять;
		
		НЗ = РегистрыСведений.ШтрихкодыНоменклатуры.СоздатьНаборЗаписей();
		
		сч = 0;  
		пропущено = 0;
		
		Для каждого стрк Из ТЗРекордсет Цикл
			
			НЗ.Отбор.Штрихкод.Установить(стрк.barcode);
			НЗ.Прочитать();
			Если НЗ.Количество() > 0 И Обновлять = ЛОЖЬ Тогда 
				пропущено=пропущено+1;
				Продолжить;
			КонецЕсли;
			
	//		НовСтр.Штрихкод 		= recordSet.Fields.Item(2).value;
	//		ном = recordSet.Fields.Item(0).value;   //ComSafeArray       
	//		хар = recordSet.Fields.Item(1).value;   //ComSafeArray
	//		
	//		НовСтр.Номенклатура 	= ном.Выгрузить();  
	//		НовСтр.Характеристика 	= хар.Выгрузить();
	//		
			Если НЗ.Количество() = 0  Тогда 
		
				НовСтр = НЗ.Добавить();
			Иначе 
				НовСтр = НЗ[0];
			КонецЕсли;
			
			НовСтр.Штрихкод = стрк.barcode;        
			мЛоггер.дебаг("Штрихкод: %1", стрк.barcode);
			
			
			Goods = стрк.Goods.Выгрузить();   //стрк.Goods - это ComSafeArray
			
			Бин = ПолучитьSQLBinaryFromComSafeArray2(Goods);
			мЛоггер.дебаг("Номенклатура БИН: %1, длина = %2", Бин, СтрДлина(Бин));
			гуидСтрока = БинариВГуидСтроку(Бин);  	
			мЛоггер.дебаг("номенклатура ГУИД: %1, длина = %2", гуидСтрока, СтрДлина(гуидСтрока));

			НовСтр.Номенклатура = НайтиНоменклатуруВКэше(гуидСтрока);      
			
			Characteristics = стрк.Chars.Выгрузить();  //стрк.Chars - это ComSafeArray

			Бин = ПолучитьSQLBinaryFromComSafeArray2(Characteristics);
			мЛоггер.дебаг("Характеристика БИН: %1, длина = %2", Бин, СтрДлина(Бин));
			гуидСтрока = БинариВГуидСтроку(Бин);  	
			мЛоггер.дебаг("Характеристика ГУИД: %1, длина = %2", гуидСтрока, СтрДлина(гуидСтрока));
			
			НовСтр.Характеристика = НайтиХарактеристикуВКэше(гуидСтрока);
			
			НЗ.Записать();                             
			
			сч = сч + 1;
			
		КонецЦикла;
		
		Время = ТекущаяУниверсальнаяДатаВМиллисекундах() - ВремяНач;
		млоггер.инфо("ОбработатьОдинПакет ЗАВЕРШЕНИЕ . Номер задания = %2, Время = %1 мс. "+
		"Загружено штрихкодов %4 из %3. Пропущено штрихкодов %5", 
			строка(Время), НомерЗадания, ТЗРекордсет.Количество(), сч, пропущено);
		
	Исключение
	    т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		млоггер.ерр(т);
	КонецПопытки;   
	
		
КонецПроцедуры 



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура Тест01_ОбработатьОдинПакет(Знач ИдВызова) Экспорт
	
	ТЗРекордсет = ТЗРекордсет();
	НовСтр = ТЗРекордсет.добавить();
	Новстр.штрихкод = "12345678";
	НовСтр.Номенклатура= "bc089036-0a05-11ef-8bfb-04ed33c124eb";
	НовСтр.Характеристика= "bc089038-0a05-11ef-8bfb-04ed33c124eb";
	НовСтр = ТЗРекордсет.добавить();
	Новстр.штрихкод = "987654321";
	НовСтр.Номенклатура= "bc089036-0a05-11ef-8bfb-04ed33c124eb";
	НовСтр.Характеристика= "bc089039-0a05-11ef-8bfb-04ed33c124eb";
	
	ОбработатьПакет_Фон(ИдВызова, ТЗРекордсет, 0, Неопределено);
	
КонецПроцедуры



//////////////////////////////////////////			СЛУЖЕБНЫЕ






// создает таблицу значений для перекладки в нее данных из ADO Recordset
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ТЗрекордсет() Экспорт
	
	ТЗРекордсет = Новый ТаблицаЗначений;
	ТЗРекордсет.Колонки.Добавить("Штрихкод");
	ТЗРекордсет.Колонки.Добавить("Номенклатура");  //справочникСсылка.Номенклатура
	ТЗРекордсет.Колонки.Добавить("Характеристика");//справочникСсылка.ХарактеристикиНоменклатуры
	возврат ТЗРекордсет;
		
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиНоменклатуруВКэше(гуидСтрока)
	стрк = КэшНоменклатуры.Найти(гуидСтрока,"гуид");
	Если стрк = Неопределено Тогда
		_спр = Справочники.Номенклатура.ПолучитьСсылку(
			Новый УникальныйИдентификатор(гуидСтрока));
		НовСтр = КэшНоменклатуры.Добавить();
		новСтр.гуид = гуидСтрока;
		новСтр.Ссылка = _спр;
		Возврат _спр;
	КонецЕсли;
	Возврат стрк.ссылка;
	
КонецФункции

Функция НайтиХарактеристикуВКэше(гуидСтрока)
		
	стрк = КэшХарактеристик.Найти(гуидСтрока,"гуид");
	Если стрк = Неопределено Тогда
		_спр = Справочники.ХарактеристикиНоменклатуры.ПолучитьСсылку(
			Новый УникальныйИдентификатор(гуидСтрока));
		НовСтр = КэшХарактеристик.Добавить();
		новСтр.гуид = гуидСтрока;
		новСтр.Ссылка = _спр;
		Возврат _спр;
	КонецЕсли;
	Возврат стрк.ссылка;
	
КонецФункции




// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ГуидВБинари(гуидСтрока)
	
//Конвертор гуида в binary представление ссылки в MSSQL

//--в файле
//--53a3863a-6ddd-11e7-9402-d89d67262ec2
//--в SQL (черточки надо убрать потом)
//--0x-9402-d89d67262ec2-11e7-6ddd-53a3863a
//--строка 	позицияSQL		позиция1С
//--9402          	1                                            4
//--d89d67262ec2  	2                                            5
//--11e7          	3                                            3
//--6ddd          	4                                            2
//--53a3863a      	5                                            1
//--т.е. берешь блоки из 1С в том порядке, в котором они должны быть в SQL

//Инструкция по запуску:

// >	oscript convertGuidToSQLBinary.os 53a3863a-6ddd-11e7-9402-d89d67262ec2

	мГуид = СтроковыеФункции.РазложитьСтрокуВМассивПодстрок(гуидСтрока, "-");
	SQLBinary = "0x"+ВРег(мГуид[3] + мГуид[4] + мГуид[2] + мГуид[1] + мГуид[0]);
		
	Возврат SQLBinary;
	
КонецФункции   


// Описание_метода
//
// Параметры:
//	Бин 	- строка - пример "0x80C14CCC6A0BFFF311E6C10D673B12C1"
//
// Возвращаемое значение:
//	Тип: строка, гуид в формате "53a3863a-6ddd-11e7-9402-d89d67262ec2"
//
Функция БинариВГуидСтроку(Знач Бин)
	
	Гуид = "";  
	
	Бин = сред(Бин,3);//уберем 0x слева 
	
	//53a3863a-6ddd-11e7-9402-d89d67262ec2
	//   0       1   2    3       4

	//SQLBinary = "0x"+ВРег(мГуид[3] + мГуид[4] + мГуид[2] + мГуид[1] + мГуид[0]);
	
	Гуид3 = Лев(Бин,4);
	гуид4 = сред(бин,5,12);
	гуид2 = сред(бин,17,4);
	гуид1 = сред(бин,21,4);
	гуид0 = сред(бин,25,8);
		
	Возврат гуид0+"-"+гуид1+"-"+гуид2+"-"+гуид3+"-"+гуид4;
	
КонецФункции

Функция Из_10_В_Любую(Знач Значение=0,Нотация=36) Экспорт
    Если Нотация<=0 Тогда Возврат("") КонецЕсли;
    Значение=Число(Значение);
    Если Значение<=0 Тогда Возврат("00") КонецЕсли;
    Значение=Цел(Значение);
    Результат="";
	Пока Значение>0 Цикл Результат=Сред("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",Значение%Нотация+1,1)+Результат;Значение=Цел(Значение/Нотация) ; КонецЦикла;
	Если СтрДлина(Результат) = 1 Тогда
		Результат = "0"+Результат;
	КонецЕсли;
    Возврат Результат;
КонецФункции

Функция Из_Любой_В_10(Знач Значение="0",Нотация=36) Экспорт
    Если Нотация<=0 Тогда Возврат(0) КонецЕсли;
    Значение=СокрЛП(Значение);
    Если Значение="0" Тогда Возврат(0) КонецЕсли;
    Результат=0;
    Длина=СтрДлина(Значение);
    Для Х=1 По Длина Цикл
        М=1;
        Для У=1 По Длина-Х Цикл М=М*Нотация КонецЦикла;
        Результат=Результат+(Найти("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",Сред(Значение,Х,1))-1)*М;
    КонецЦикла;
    Возврат Окр(Результат);
КонецФункции




// создает текстовую строку для подключения к MSSQL
Функция ConnectionString(ИмяСервера, Порт, ИмяПользователя, Пароль, ИмяБазыДанных, ДрайверMSSQL) Экспорт
	
	Если Врег(ДрайверMSSQL) = "OLEDB" Тогда
		// этот вариант дается на // https://www.connectionstrings.com/sql-server/
		Рез = "Provider=MSOLEDBSQL;Server=%1;Database=%2;UID=%3;PWD=%4;";
		// тоже рабочий вариант, но более старый
		//Рез = "Provider=Microsoft OLE DB Provider for SQL Server;Data Source=%1;Initial Catalog=%2;UID=%3;PWD=%4;";
	ИначеЕсли Врег(ДрайверMSSQL) = "ODBC.17" Тогда
		Рез = "Driver={ODBC Driver 17 for SQL Server};Server=%1;Database=%2;UID=%3;PWD=%4;";
	Иначе
		Рез = "Driver={ODBC Driver 17 for SQL Server};Server=%1;Database=%2;UID=%3;PWD=%4;";
	КонецЕсли; 
	
	Рез = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Рез,
		ИмяСервера,
		ИмяБазыДанных,
		ИмяПользователя,
		Пароль);
		
	Возврат Рез;

КонецФункции


// создает строку вида 0x80C14CCC6A0BFFF311E6C10D673B12C1 из бинарных данных колонки с типом SQLBinary (_FLDxxxRRef)
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: строка
//
Функция ПолучитьSQLBinaryFromComSafeArray(ComSafeArray)

	рез = "0x";            
	Для индекс=ComSafeArray.getLowerBound(0) По ComSafeArray.getUpperBound(0) Цикл
		времЗначение = ComSafeArray.getValue(индекс);
		
		гекс = Из_10_В_Любую(времЗначение,16);
        рез = рез+гекс;
		 
	КонецЦикла;

		
	Возврат рез;
	
КонецФункции

// параметры:
//	Массив - массив - получен из ComSafeArray методом Выгрузить()
Функция ПолучитьSQLBinaryFromComSafeArray2(Массив)

	рез = "0x";            
	Для индекс=0 По Массив.Количество()-1 Цикл
		
		гекс = Из_10_В_Любую(Массив[индекс],16);
        рез = рез+гекс;
		 
	КонецЦикла;
		
	Возврат рез;
	
КонецФункции



/////////////////////////////////////////////////////////////



КэшНоменклатуры = Новый ТаблицаЗначений;
КэшНоменклатуры.Колонки.Добавить("гуид");//строка 
КэшНоменклатуры.Колонки.Добавить("Ссылка");
КэшНоменклатуры.Индексы.Добавить("гуид");

КэшХарактеристик= Новый ТаблицаЗначений;
КэшХарактеристик.Колонки.Добавить("гуид");//строка 
КэшХарактеристик.Колонки.Добавить("Ссылка");  
КэшХарактеристик.Индексы.Добавить("гуид");

КэшНоменклатурыБинСКЛ = Новый ТаблицаЗначений;
КэшНоменклатурыБинСКЛ.Колонки.Добавить("хэш");//хэш от массива, который получен из ComSafeArray метдом Выгрузить() 
КэшНоменклатурыБинСКЛ.Колонки.Добавить("Ссылка");
КэшНоменклатурыБинСКЛ.Индексы.Добавить("хэш");

КэшХарактеристикБинСКЛ= Новый ТаблицаЗначений;
КэшХарактеристикБинСКЛ.Колонки.Добавить("хэш");//хэш от массива, который получен из ComSafeArray метдом Выгрузить()
КэшХарактеристикБинСКЛ.Колонки.Добавить("Ссылка");  
КэшХарактеристикБинСКЛ.Индексы.Добавить("хэш");


// начинаем отсюда
//ЗагрузитьВсеНаСервере()
// там выполняется запрос, открывается цикл по рекордсету






