**Зависимости:**
- `pip install -r requiremets.txt`


**Конфигурация**
Пример конфигурации находится в `Configs/partner_config_example.yml`.
Для работы тестов необходимо скопировать конфиг и заполнить необходимые urls:  
`cp Configs/partner_config_example.yml Configs/partner_config.yml`


**Запуск тестов:**
- `robot -P Libraries Tests/Partners/Orders.robot`


**Методы API**
1. Orders
   * createOrder -
   * cancelOrder -
   * getOrder -
   * getOrdersStatus -
   * updateOrderItems -
2. Inbound
    * putInbound - https://yandex.ru/dev/market/movement-control/doc/dg/reference/put-inbound.html
    

**Валидация**
Во время прохождения тестов все ответы (xml) проходят валидацию.
Схемы валидаций xml ответов лежат в `Data/Responses/Schemas`.
