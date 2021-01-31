**Необходимо**
- Установленный `python v3.6`
- Скачанный проект с тестами
- Нужно открыть консоль в папке с проектом

**Виртуальное окружение**
- `python3 -m venv venv`
- `source venv/bin/activate`

**Зависимости:**
- `python -m pip install -r requirements.txt`

**Конфигурация:**  
Пример конфигурации находится в `Configs/partner_config_example.yml`.
Для работы тестов необходимо скопировать конфиг и заполнить необходимые urls:  
`cp Configs/partner_config_example.yml Configs/{config name}.yml`

**Запуск тестовых наборов:**
- `robot -P Libraries -V Configs/{config name} Tests/Orders.robot`
- `robot -P Libraries -V Configs/{config name} Tests/Inbound.robot`
- `robot -P Libraries -V Configs/{config name} Tests/Outbound.robot`
- `robot -P Libraries -V Configs/{config name} Tests/Movement.robot`

**Запуск отдельных тестов:** 
- `robot -P Libraries -V Configs/{config name} -t "{test name}" Tests`

**Валидация:**  
Во время прохождения тестов все ответы (xml) проходят валидацию.
Схемы валидаций xml ответов лежат в `Data/Schemas/Responses`.
