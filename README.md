# Qravan 
Qravan _[карав`ан]_ — сервер для быстрого создания API обмена данными, консолидирующий различные источники с SQL-интерфейсами (СУБД или REST).

![](assets/images/qravan.png)
## Установка

Добавить строку ниже в свой Gemfile:

```ruby
gem 'qravan'
```

Потом выполнить:

    $ bundle install

Или установить просто как Gem (предпочтительно):

    $ gem install qravan

## Запуск
Запустить сервер Qravan:

    $ qravan

Сервер станет доступен по адресу `http://localhost:3300/`. В базовую поставку включены демонстрационные источники и модели.

## Методы сервера
Сервер содержит следующие методы:
1. GET /ping — проверить запусщенность сервера (ответ PONG!)
2. GET /models — список загруженных моделей
3. GET /sources — список загруженных источников
4. POST /data — выполнить запрос


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

Запрос объединенных данных о владельце автомобиля из Prostore и Postgres:
```json
{
  "query":{
    "driver":{
      "conditions":{
        "DriverLicenseSerNum":"abc",
        "norm_DriverLicenseSerNum":"5"
      },
      "attributes":[
        "DriverLastname",
        "DriverFirstname",
        "DriverMiddlename",
        "Driverlicenseid"
        ]
    },
    "driver_license":{
      "conditions":{
        "DriverLicenseSerNum":"abc",
        "norm_DriverLicenseSerNum":"3"
      },
      "attributes":[
        "DriverLastname",
        "DriverFirstname",
        "DriverMiddlename",
        "Driverlicenseid"
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
            "driverlastname": "Сидоров",
            "driverfirstname": "Олег",
            "drivermiddlename": "Львович",
            "driverlicenseid": 2222
          }
        ],
        {
          "time": "REST Duration: 0.053709s "
        }
      ]
    },
    {
      "driver_license": [
        {
          "driverlastname": "Петречук",
          "driverfirstname": "Петр",
          "drivermiddlename": "Петрович",
          "driverlicenseid": 2
        },
        {
          "time": "DB Duration: 0.010184s"
        }
      ]
    }
  ],
  "credentials": {
    "response": {
      "id": "c11ba197-ae96-4a6a-bc11-a3464d54496c",
      "sub_id": "50bcef8c-ef6e-4c6e-a893-4b42641919be",
      "started_at": "2023-01-19 00:34:39 +0300",
      "finished_at": "2023-01-19 00:34:39 +0300"
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
