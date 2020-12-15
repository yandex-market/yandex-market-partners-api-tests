**Зависимости:**
- `pip install -r requiremets.txt`


**Конфигурация**
Пример конфигурации находится в `Configs/partner_config_example.yml`.
Для работы тестов необходимо скопировать конфиг и заполнить необходимые urls:  
`cp Configs/partner_config_example.yml Configs/{config name}.yml`


**Запуск тестов:**
- `robot -P Libraries -V Config/{config name} Tests/Partners/Orders.robot`


**Методы API**
1. Delivery
   * createOrder - https://yandex.ru/dev/market/delivery-service/doc/dg/reference/create-order.html
   * cancelOrder - https://yandex.ru/dev/market/delivery-service/doc/dg/reference/cancel-order.html
   * getOrder - https://yandex.ru/dev/market/delivery-service/doc/dg/reference/get-order.html
   * getOrdersStatus - https://yandex.ru/dev/market/delivery-service/doc/dg/reference/get-orders-status.html
   * updateOrderItems - https://yandex.ru/dev/market/delivery-service/doc/dg/reference/update-order-items.html
2. Movement
   * putInbound - https://yandex.ru/dev/market/movement-control/doc/dg/reference/put-inbound.html
   * getInbound - https://yandex.ru/dev/market/movement-control/doc/dg/reference/get-inbound.html
    

**Валидация**
Во время прохождения тестов все ответы (xml) проходят валидацию.
Схемы валидаций xml ответов лежат в `Data/Responses/Schemas`.
