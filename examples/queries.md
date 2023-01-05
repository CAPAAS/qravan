# Примеры запросов Qravan

Запрос объединенных данных о владельце автомобиля из Prostore и Postgres:
```json
{
  "query":{
    "driverlicense":{
      "conditions":{
        "DriverLicenseSerNum":"abc",
        "norm_DriverLicenseSerNum":"5"
      },
      "attributes":[
        "DriverLastname",
        "DriverFirstname",
        "DriverMiddlename",
        "Driverlicenseid"
        ],
      "source": "prostore"
    },
    "driverlicense_new":{
      "conditions":{
        "DriverLicenseSerNum":"abc",
        "norm_DriverLicenseSerNum":"3"
      },
      "attributes":[
        "DriverLastname",
        "DriverFirstname",
        "DriverMiddlename",
        "Driverlicenseid"
        ],
      "source": "postgres"
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
      "driverlicense": [
        [
          {
            "driverlastname": "Петров",
            "driverfirstname": "Иван",
            "drivermiddlename": "Иванович",
            "driverlicenseid": 1111
          }
        ],
        {
          "time": "Duration: 0.052415s for 1 (RPS: 19 r/s)"
        }
      ]
    },
    {
      "driverlicense_new": [
        {
          "driverlastname": "Евгеничук",
          "driverfirstname": "Евгений",
          "drivermiddlename": "Олегович",
          "driverlicenseid": 333
        }
      ]
    }
  ],
  "credentials": {
    "response": {
      "id": null,
      "sub_id": null,
      "started_at": null,
      "finished_at": null
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
