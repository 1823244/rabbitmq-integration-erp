полезные ссылки

Статья 2020 года. Обзорная
https://infostart.ru/1c/articles/1274026/?ysclid=lqku4nwd9x98003328


Клиент API ГИС МТ (ИС МП) "Честный знак". Чтение данных и отправка документов. Работа на стороне сервера.
07.05.21 
https://infostart.ru/1c/tools/1315710/?ysclid=lqkixqjl2n928588944


Маркировка - расширение для конфигурации "INFOSTART ERP community edition"
(ЕНС - здесь неплохо описан порядок работы с маркировкой)
https://infostart.ru/marketplace/1398924/?ysclid=lqknshesu3499156256
цена расширения - 126 000


Обмен через API с Честный знак (Система маркировки товаров) 
https://infostart.ru/1c/tools/1276725/?ysclid=lqku2ljlxm993425850
ЕНС: довольно неплохо описаны примеры применения АПИ


Запрос кодов маркировки товаров через API Честный знак 
(Система маркировки товаров) по заданным фильтрам и списание 
https://infostart.ru/1c/tools/1923573/?ysclid=lqku1vbuvx987263184
Обновляет примеры АПИ из предыдущей статьи - 1276725



ГИСМ - Государственная информационная система маркировки (ГИСМ) для меховых изделий;  Источник https://buh.ru/articles/gosudarstvennye-informatsionnye-sistemy-kak-s-nimi-rabotat-.html#briefly_98369

ИСМП (ИС МП) (Честный знак) - Маркировка табачной продукции (Информационная система мониторинга оборота табачной продукции, ИС МОТП) и обуви (Информационная система маркировки и прослеживания, ИС МП) производится в рамках национальной системы цифровой маркировки «Честный знак».   Источник https://buh.ru/articles/gosudarstvennye-informatsionnye-sistemy-kak-s-nimi-rabotat-.html#briefly_98369


--------------------------------------------------------------------------------
ИНСТРУКЦИЯ КАК ПОЛУЧИТЬ ПЕСОЧНИЦУ
https://forum.mista.ru/topic/891352
--------------------------------------------------------------------------------

1. Создаете тестовую ЭЦП своей организации.
http://testca2012.cryptopro.ru/ui/Default.aspx

Вход по ЭЦП в IE Win10 без антивируса (закрыть, приостановить не поможет), у меня Win11, поэтому после окончания действия ЭЦП повторяю данные действия в виртуалке.
Добавляете 2 сертификата в нужные ветки, на сайте написано что куда (корневой и промежуточный).

Ставите Крипто-Про без ключа на 90 дней.
Подойдет "КриптоПро CSP 5.0 R3 (релиз-кандидат)"
https://cryptopro.ru/products/csp/downloads

При выпуске ЭЦП пишете себя как ген.директора или его действительную ФИО, ИНН своей организации.
Должность (это важно для ЧЗ): генеральный директор

2. Заходите в песочницу ЧЗ с тестовой ЭЦП
https://markirovka.sandbox.crptech.ru/

Заполняете анкету, баланс в тестовом контуре пополняется автоматически при запросе выставления счета. 

ipeliseev.2024
5256111867

ipivanov.2024
4137222890

akcionernoeofr.2024
8831914898

пароль подписи: 3gbTrd!

ошибки сертификатов и способы решения

https://markirovka.ru/knowledge/tovarnye-gruppy/obschie-voprosy-gis/tsepochka-sertifikatov-obrabotana-no-obrabotka-prervana-na-kornevom-sertifikate-u-kotorogo-otsutstvu-gis

https://markirovka.ru/knowledge/tovarnye-gruppy/obschie-voprosy-gis/oshibka-pri-registratsii-oshibka-ispolneniya-funktsii

https://docs.yandex.ru/docs/view?url=ya-browser%3A%2F%2F4DT1uXEPRrJRXlUFoewruFlsnl96XF6VkVL2BJfB04K_8Shv2XLOudffIzrQ9-6wWBEdWeQywMMpZGqJW1J3NyMys886JMRxy9pKGAywXipo7NQlMkMmnrfEnT63uub9iz8YU1MhPkWnLh7uYld_tQ%3D%3D%3Fsign%3DdlBAuzMStJNJwKpiXJIEI36CXL78Y-GVhjQrWM6N49I%3D&name=p0zvfvkgvpfyxon7q1w3o2apdu6wdbys.docx

https://markirovka.ru/knowledge/lekarstva/api-mdlp/instruktsiya-po-ustanovke-kornevykh-sertifikatov-obrabotana-no-obrabotka-prervana-na-kornevom-sertifikate-u-kotorogo-otsutstvu-gis

Я установил в корневые оба сертификата, которые есть в составе личного от Крипто про (в текущего пользователя)
certmgr.msc\личное\тестовый сертификат:

[3]Доступ к сведениям центра сертификации
     Метод доступа=Поставщик центра сертификации (1.3.6.1.5.5.7.48.2)
     Дополнительное имя:
          URL=http://testgost2012.cryptopro.ru/CertEnroll/testgost2012(5).crt
[4]Доступ к сведениям центра сертификации
     Метод доступа=Поставщик центра сертификации (1.3.6.1.5.5.7.48.2)
     Дополнительное имя:
          URL=http://testgost2012.cryptopro.ru/CertEnroll/root2023-5.crt

------------------------------------------------------------------------------------------

Браузерный плагин CAdESCOM

https://www.cryptopro.ru/products/cades/plugin

Проверить работу браузерного плагина

https://www.cryptopro.ru/sites/default/files/products/cades/demopage/cades_bes_sample.html