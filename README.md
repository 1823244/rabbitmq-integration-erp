# rabbitmq-integration-erp

rabbitmq-integration - это название проекта по интеграции ЕРП и других конфигураций 1С через RabbitMQ  

Данный подпроект - это разработка алгоритмов обмена для конфигурации ЕРП.  

# Экспорт_из_ЕРП.epf

Это оркестратор экспорта.  
Он читает узел плана обмена и, используя плагины, выгружает данные в json и отправляет их в RabbitMQ.  

test