**Зависимости:**
- `pip install -r requiremets.txt`


**Конфигурация**
Пример конфигурации находится в `Configs/partner_config_example.yml`.
Для работы тестов необходимо скопировать конфиг и заполнить необходимые urls:  
`cp Configs/partner_config_example.yml Configs/{config name}.yml`


**Запуск тестов:**
- `robot -P Libraries -V Configs/{config name} Tests/Orders.robot`
- `robot -P Libraries -V Configs/{config name} Tests/Inbound.robot`


**Валидация:**  
Во время прохождения тестов все ответы (xml) проходят валидацию.
Схемы валидаций xml ответов лежат в `Data/Schemas/Responses`.
