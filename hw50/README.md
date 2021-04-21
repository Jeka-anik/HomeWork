# Настроить jenkins pipeline для запуска терраформа
Usage folder task1

# Прикрутить оповещения в слак с возможность нажать yes-no

После его установки снова нажмите « Управление Jenkins» на левой панели навигации, а затем перейдите в « Настроить систему» . Найдите раздел Global Slack Notifier Settings и добавьте следующие значения:
Поддомен команды: devopsteam-yao4345
Идентификатор учетных данных токена интеграции: создайте секретные текстовые учетные данные, используя QaDi7FQOU8R73vWnzXXQzYnCв качестве значения
```yaml
pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                slackSend channel: '#testforevgen', message: 'Job succes', blocks: [
                      [
          "type": "section",
          "text": [
            "type": "plain_text",
            "text": "Run joba?"
                      ]
                ],

                [
          "type": "actions",
          "elements": [
                        [
            "type": "button",
            "text": [
                                "type": "plain_text",
          "text": "Yes"
                              ],
            "style": "primary",
          "url": "http://anik:11e3c0ac3b2eaf27fdfa06521fefdd4312@54.166.142.141:8080/job/hw50task2_1/build?token=123456"
                        ],


                        [
            "type": "button",
            "text": [
               "type": "plain_text",
          "text": "No"
                              ],
                              "style": "danger",
          //"url": "<curl -X POST http://52.91.151.200:8080/job/HW48/49/input/Apply/abort?token=1135a13b197263294b61cb9d591fd3f8c1 --user Aleksandr:1135a13b197263294b61cb9d591fd3f8c1 -H 'Jenkins-Crumb: 6e6f3d3ff16d360ac873e5c58a1a32e4c9094e8609e6dc886056fdb65be557a1'>"
                        ]  // "${BUILD_URL}input/Apply/abort?token=1135a13b197263294b61cb9d591fd3f8c1"
                      ]
      ]
              ] 
         }
        }
    }
}
```

```yml
pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                slackSend channel: '#testforevgen', message: 'Job succes', blocks: [
    [
      "type": "section",
      "text": [
        "type": "mrkdwn",
        "text": "*Хорошо.*"
      ]
    ],
    [
      "type": "section",
      "text": [
        "type": "mrkdwn",
        "text": "Эта джоба запускается по команде из Slack"
      ]
       ]
        ]
         }
        }
    }
}
```

# Создать пайплайн для сборки кода и помещения его в имедж, по результатам джобы слать оповещение в слак

аналогично предыдущим задачам.
