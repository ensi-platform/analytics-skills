// Каркас схемы взаимодействия сервисов для ADR.
// Копируется в features/<slug>/analytical documents/diagrams/architecture.c4 и заполняется сервисами фичи.
//
// Правила:
//   1. Стили задаются только здесь, в specification, по видам элементов.
//      В model и views стили не дублируются.
//   2. Иконки не используем. Смысл несут форма, цвет и легенда (notation).
//   3. У каждого элемента заполняется technology — без иконок это единственный
//      способ показать стек.
//   4. Проверка: npx likec4@latest validate .

specification {
  element actor {
    notation 'Пользователь или роль'
    style {
      shape person
      color indigo
    }
  }

  element webapp {
    notation 'Веб-интерфейс: витрина, админ-панель'
    style {
      shape browser
      color primary
    }
  }

  element mobileapp {
    notation 'Мобильное приложение'
    style {
      shape mobile
      color primary
    }
  }

  element service {
    notation 'Сервис, BFF или контейнер'
    style {
      shape component
      color primary
    }
  }

  element database {
    notation 'База данных'
    style {
      shape cylinder
      color green
    }
  }

  element broker {
    notation 'Брокер сообщений, очередь'
    style {
      shape queue
      color amber
    }
  }

  element filestore {
    notation 'Файловое хранилище'
    style {
      shape bucket
      color secondary
    }
  }

  element external {
    notation 'Внешняя система'
    style {
      shape rectangle
      color muted
    }
  }
}

model {
  // Пример — заменить сервисами фичи:
  //
  // visitor = actor 'Посетитель'
  // frontend = webapp 'Frontend' { technology 'Next.js' }
  // api = service 'API' { technology 'Go' }
  // db = database 'API DB' { technology 'PostgreSQL' }
  // queue = broker 'Kafka' { technology 'Kafka' }
  // files = filestore 'Object Storage' { technology 'S3' }
  // payment = external 'Платёжный шлюз'
  //
  // visitor -> frontend 'открывает витрину'
  // frontend -> api 'REST /v1/...'
  // api -> db 'SQL'
  // api -> queue 'публикует события'
  // api -> files 'PUT/GET файлы'
  // api -> payment 'HTTP'
  //
  // Паттерн BFF админ-панели: Admin UI не обращается к сервисам напрямую.
  // admin = actor 'Администратор'
  // adminUi = webapp 'Admin UI' { technology 'Web' }
  // adminBff = service 'Admin GUI Backend' { technology 'BFF админ-панели' }
  //
  // admin -> adminUi 'работает в панели'
  // adminUi -> adminBff 'REST /admin/...'
  // adminBff -> api 'внутренний API сервиса'
}

views {
  view index {
    title 'Схема взаимодействия сервисов'
    include *
  }

  // При необходимости добавить виды для отдельных потоков:
  //
  // view publicFlow {
  //   title 'Публичный поток'
  //   include visitor, frontend, api, db
  // }
}
