# Qravan 
Qravan _[карав`ан]_ — сервер для быстрого создания API обмена данными, консолидирующий различные источники с SQL-интерфейсами (СУБД или REST).

![](assets/images/qravan.png)
## Установка
Установить как GEM (**предпочтительно**):

    $ gem install qravan

**Или** добавить строку ниже в свой Gemfile:

```ruby
gem 'qravan'
```

Потом выполнить:

    $ bundle install


## Запуск
Запустить сервер Qravan:

    $ qravan

Сервер станет доступен по адресу `http://localhost:3300/`. В базовую поставку включены демонстрационные источники `postgres`, `prostore` и модель `vehicles`.

## Методы сервера
Сервер содержит следующие методы:
1. GET http://localhost:3300/ping — проверить запусщенность сервера (ответ PONG!)
2. GET http://localhost:3300/model — список загруженных моделей
3. GET http://localhost:3300/sources — список загруженных источников
4. POST http://localhost:3300/data — выполнить запрос


## Настройка моделей данных и ресурсов
### Модели
Модели данных описываются в соответствии со спецификацией в формате 
YAML в папке `models/[model_name]/[model_version x.x]/model.yaml`

Версионирование моделей должно осуществляться в двухразрядном формате. 
По-умолчанию сервер запускает модель по симлинку с `current`. 

### Ресурсы
Источники описывются также в соответствии со спецификацией в формате
YAML в папке `sources/[source_name]/[source_version x.x]/source.yaml`

Версионирование источников должно осуществляться в двухразрядном формате. 
По-умолчанию сервер запускает источники по симлинку с `current`.

```
qravan
│ README.md
│ credentials.yaml 
│      
└─models
│   └─base
│   │ │ current
│   │ └─1.0
│   │   │ model.yaml
│   │
│   └─vehicles
│     │ current
│     └─1.0
│     │ └─ model.yaml
│     └─2.0
│       └─ model.yaml
│     
└─sources
│   └─vehicles
│     │ current
│     └─1.0
│     │ └─ source.yaml
│     └─2.0
│       └─ source.yaml
```
## Пример использования

### Демо-данные
В составе Qravan описаны демо-модели и источники. Также в папке `examples` лежат дампы (`pg_dump`) Postgres, достаточные для проверок ниже. 

### Запросы к демо-данным
Запрос объединенных данных о владельце автомобиля из Prostore и Postgres:
```json
{
  "query":{
    "driver":{
      "conditions":{
        "driverlicensetype":"E",
        "drivermiddlename":"Александрович"
      },
      "attributes":[
        "DriverLastname",
        "DriverFirstname",
        "DriverMiddlename",
        "driverlicensetype"

      ]
    },
    "super_driver":{
      "conditions":{
        "driverlicensetype":"D",
        "driverfirstname": "Евгений"
      },
      "attributes":[
        "DriverLastname",
        "DriverFirstname",
        "DriverMiddlename",
        "driverlicensetype"

      ]
    },
    "driver_license":{
      "conditions":{
        "driverlicensetype":"C",
        "driverlicensetypeid": 1
      },
      "attributes":[
        "DriverLastname",
        "DriverFirstname",
        "DriverMiddlename",
        "Driverlicenseid"
      ]
    },
    "identity_document":{
      "conditions": {
        "driverlicensetypeid": 4
      },
      "attributes":[
        "driverlicenseissuer",
        "DriverLicenseSerNum",
        "driverlicensetype"

      ]
    }
  },
  "credentials":{
    "system":{
      "mnemonic":"117bed7f-1c07-4079-a446-1161588db4e5",
      "instance_id":"ccb4a88f-f44b-43e7-8a97-3e45c8345e90",
      "user_id":"5ed38461-0907-486a-930a-7b443482932c"
    },
    "request":{
      "id":"df5a0073-c6be-4d8c-8eb2-9b2f4188a429",
      "sub_id":"0cdb59ce-224b-4118-8da1-c5ea08a5d955",
      "name":"driver_data",
      "purpose_id":"ed1170f1-3caa-4985-aa38-c9c5a190b770",
      "audit":"false",
      "audit_id":"fc1048fe-323d-4eeb-92df-5710b3d1d100",
      "audit_token":"39e47aac-45d2-44c1-8c26-2d9b28b1703b"
    },
    "signature":{
      "digest": null,
      "signature": null
    }
  }
}
```

Ответ для данного запроса будет иметь вид:
```json
{
  "response": [
    {
      "driver": [
        [
          {
            "driverlastname": "Козлов",
            "driverfirstname": "Кирилл",
            "drivermiddlename": "Александрович",
            "driverlicensetype": "E"
          },
          {
            "driverlastname": "Фёдоров",
            "driverfirstname": "Михаил",
            "drivermiddlename": "Александрович",
            "driverlicensetype": "E"
          }
        ],
        {
          "time": "REST Duration: 0.21902s "
        }
      ]
    },
    {
      "super_driver": [
        [
          {
            "driverlastname": "Белов",
            "driverfirstname": "Евгений",
            "drivermiddlename": "Витальевич",
            "driverlicensetype": "D"
          },
          {
            "driverlastname": "Комаров",
            "driverfirstname": "Евгений",
            "drivermiddlename": "Александрович",
            "driverlicensetype": "D"
          }
        ],
        {
          "time": "REST Duration: 0.022836s "
        }
      ]
    },
    {
      "driver_license": [
        {
          "driverlastname": "Беляев",
          "driverfirstname": "Алексей",
          "drivermiddlename": "Николаевич",
          "driverlicenseid": 32
        },
        {
          "driverlastname": "Соловьёв",
          "driverfirstname": "Леонид",
          "drivermiddlename": "Иванович",
          "driverlicenseid": 26
        },
        {
          "driverlastname": "Михайлов",
          "driverfirstname": "Александр",
          "drivermiddlename": "Георгиевич",
          "driverlicenseid": 34
        },
        {
          "time": "DB Duration: 0.00319s"
        }
      ]
    },
    {
      "identity_document": [
        {
          "driverlicenseissuer": "44261",
          "driverlicensesernum": "32662",
          "driverlicensetype": "B"
        },
        {
          "driverlicenseissuer": "32203",
          "driverlicensesernum": "39303",
          "driverlicensetype": "A"
        },
        {
          "driverlicenseissuer": "43233",
          "driverlicensesernum": "30101",
          "driverlicensetype": "A"
        },
        {
          "driverlicenseissuer": "45275",
          "driverlicensesernum": "42336",
          "driverlicensetype": "B"
        },
        {
          "driverlicenseissuer": "46690",
          "driverlicensesernum": "31614",
          "driverlicensetype": "A"
        },
        {
          "driverlicenseissuer": "37435",
          "driverlicensesernum": "47250",
          "driverlicensetype": "B"
        },
        {
          "driverlicenseissuer": "36823",
          "driverlicensesernum": "45173",
          "driverlicensetype": "C"
        },
        {
          "driverlicenseissuer": "33728",
          "driverlicensesernum": "43290",
          "driverlicensetype": "C"
        },
        {
          "driverlicenseissuer": "41989",
          "driverlicensesernum": "47023",
          "driverlicensetype": "C"
        },
        {
          "time": "DB Duration: 0.001113s"
        }
      ]
    }
  ],
  "credentials": {
    "response": {
      "id": "4201414d-fa86-4221-9d15-f91c10356daa",
      "sub_id": "a59ea446-5dca-4705-bca5-53d6569e58a2",
      "started_at": "2023-01-20 12:34:25 +0300",
      "finished_at": "2023-01-20 12:34:25 +0300"
    },
    "system": {
      "mnemonic": "117bed7f-1c07-4079-a446-1161588db4e5",
      "instance_id": "ccb4a88f-f44b-43e7-8a97-3e45c8345e90",
      "user_id": "5ed38461-0907-486a-930a-7b443482932c"
    },
    "request": {
      "id": "df5a0073-c6be-4d8c-8eb2-9b2f4188a429",
      "sub_id": "0cdb59ce-224b-4118-8da1-c5ea08a5d955",
      "name": "driver_data",
      "purpose_id": "ed1170f1-3caa-4985-aa38-c9c5a190b770",
      "audit": "false",
      "audit_id": "fc1048fe-323d-4eeb-92df-5710b3d1d100",
      "audit_token": "39e47aac-45d2-44c1-8c26-2d9b28b1703b"
    },
    "signature": {
      "digest": null,
      "signature": null
    }
  }
}
```

## Лицензирование
Qravan распространяется под открытой лицензией [CAPAAL](LICENSE).

Copyright (c) 2022 Panasenkov Alexander (apanasenkov@capaa.ru)
