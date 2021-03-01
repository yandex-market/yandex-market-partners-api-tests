**Необходимо**
- Установить `python` не ниже версии 3.6.
  Скачать последню версию `python` можно на [тут](https://www.python.org/downloads/)
- Скачать проект с тестами
- Открыть консоль в папке с тестами `yandex-market-partners-api-tests`

**Установка виртуального окружения**
- `python3 -m venv venv`
- `source venv/bin/activate`

**Установка зависимостей:**
- `python -m pip install -r requirements.txt`

**Создание файла конфигурации:**  
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

**Видеоинструкция**
1) [Установка проекта](https://yadi.sk/d/gBJjD0pUDEJ3yQ/Скачиваем%20проект.mov?w=1)
2) [Установка окружения и зависимостей](https://yadi.sk/d/gBJjD0pUDEJ3yQ/Установк_окружения_и_зависимостей.mov?w=1)
3) [Создание файла конфигурации](https://yadi.sk/d/gBJjD0pUDEJ3yQ/Конфигурация.mov?w=1)
4) [Запуск тестовых наборов/Успех](https://yadi.sk/d/gBJjD0pUDEJ3yQ/Успех.mov?w=1)
5) [Запуск тестовых наборов/Ошибка](https://yadi.sk/d/gBJjD0pUDEJ3yQ/Неудача.mov?w=1)

**История запросов**  
История запросов пишется в отдельные файлы, названные именами запускаемых тест кейсов,
например `Create inbound registry.xml`, в виде `curl` запросов и ответов: 
```xml
curl -H "Content-Type: text/xml" http://test_url/ -d '
<root>
    <token>test01</token>
    <hash>b8e35cd2003c4ecf83f349ff3adc4d3b</hash>
    <uniq>b8e35cd2003c4ecf83f349ff3adc4d3b</uniq>
    <request type="getInboundStatusHistory">
        <inboundIds>
            <inboundId>
                <yandexId>0778974</yandexId>
                <partnerId>12345678</partnerId>
            </inboundId>
        </inboundIds>
    </request>
</root>
'

<?xml version="1.0" ?>
<root>
    <uniq>b8e35cd2003c4ecf83f349ff3adc4d3b</uniq>
    <requestState>
        <isError>false</isError>
    </requestState>
    <response type="getInboundStatusHistory">
        <inboundStatusHistories>
            <inboundStatusHistory>
                <inboundId>
                    <yandexId>0778974</yandexId>
                    <partnerId>12345678</partnerId>
                </inboundId>
                <history>
                    <status>
                        <statusCode>0</statusCode>
                        <setDate>2020-03-20T12:00:00+01:00</setDate>
                    </status>
                    <status>
                        <statusCode>1</statusCode>
                        <setDate>2020-03-20T14:00:00+01:00</setDate>
                    </status>
                </history>
            </inboundStatusHistory>
        </inboundStatusHistories>
    </response>
</root>
```
В каждый файл пишутся все запросы и ответы проделанные в соответсвующем тесте.
