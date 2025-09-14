# 🚗 inDrive Hackathon - AI Vehicle Inspection

iOS приложение для автоматизации проверки состояния автомобилей с использованием искусственного интеллекта.

## 📱 Демо

Видео демонстрация: [Смотреть на Google Drive](https://drive.google.com/file/d/1c9Glb4GkFkfLpbaLORHpgHCJCGSvGDPU/view?usp=sharing)

## 📋 Описание проекта

Мобильное приложение разработано для решения задачи автоматизации работы модераторов inDrive, которые вручную проверяют фотографии автомобилей. Система использует машинное обучение для анализа состояния транспортных средств по фотографиям.

### Функциональность

**Режим водителя:**
- Создание заявки на регистрацию автомобиля
- Загрузка фотографий автомобиля
- Фотографирование водительского удостоверения
- Отслеживание статуса заявки

**Режим модератора:**
- Просмотр списка всех заявок
- Детальная проверка каждой заявки
- Автоматическая AI проверка состояния автомобиля
- Валидация данных водительского удостоверения
- Одобрение или отклонение заявок

## ✨ Ключевые особенности

- 🔄 Переключение между режимами водителя и модератора
- 📸 Создание заявок с множественными фотографиями
- 📋 Система модерации с детальным просмотром
- 🤖 Интеграция с AI для автоматического анализа повреждений
- 📄 OCR распознавание данных из водительских удостоверений
- 🏗️ VIPER архитектура для масштабируемости
- 🎨 Современный UI с SnapKit Auto Layout
- 🌐 Полноценная интеграция с REST API

## 🛠 Технический стек

- **Язык:** Swift 5.0+
- **UI Framework:** UIKit
- **Архитектура:** VIPER (View-Interactor-Presenter-Entity-Router)
- **Auto Layout:** SnapKit
- **Сеть:** URLSession с кастомным Network Layer
- **Изображения:** UIImagePickerController, фото галерея
- **Минимальная версия iOS:** 15.0+

## 📦 Требования

- iOS 15.0+
- Xcode 12+
- Swift 5.0+
- Активное интернет-соединение для API

## 🚀 Установка и запуск

### 1. Клонирование репозитория
```bash
git clone https://github.com/Lm004yky/Indrive_case_1_Hackathon.git
cd Indrive_case_1_Hackathon
```

### 2. Настройка бэкенда
Сначала запустите бэкенд часть проекта:
```bash
cd djangoProject/
docker compose up --build
```

### 3. Настройка ngrok
```bash
ngrok http 8001
```

### 4. Конфигурация iOS проекта
1. Откройте `Indrive_case_1_Hackathon.xcodeproj` в Xcode
2. Обновите `baseURL` в файле `ApplicationEndpoints.swift` на ваш ngrok URL:
```swift
var baseURL: URL {
    URL(string: "https://your-ngrok-url.ngrok-free.app")!
}
```

### 5. Запуск
Запустите проект на симуляторе или физическом устройстве

## 🏗 Архитектура проекта

```
├── Modules/
│   ├── Main/               # Главный экран и переключение режимов
│   │   ├── MainViewController.swift
│   │   ├── MainPresenter.swift
│   │   ├── MainInteractor.swift
│   │   └── MainRouter.swift
│   ├── ApplicationDetail/  # Экран деталей заявки для модератора
│   │   ├── ApplicationDetailViewController.swift
│   │   ├── ApplicationDetailPresenter.swift
│   │   ├── ApplicationDetailInteractor.swift
│   │   └── ApplicationDetailRouter.swift
│   └── CreateApplication/  # Создание заявки водителем
│       ├── CreateApplicationViewController.swift
│       ├── CreateApplicationPresenter.swift
│       ├── CreateApplicationInteractor.swift
│       └── CreateApplicationRouter.swift
├── Services/
│   ├── NetworkService/     # API интеграция
│   ├── NetworkModels/      # Модели данных
│   └── ApplicationEndpoints/ # Эндпоинты API
├── Common/
│   ├── Views/             # Переиспользуемые UI компоненты
│   │   ├── CarPhotoCollectionViewCell.swift
│   │   └── ApplicationTableViewCell.swift
│   └── Extensions/        # Расширения
└── Resources/             # Ресурсы приложения
```

## 🔗 API Интеграция

Приложение интегрируется со следующими эндпоинтами:

- `GET /application/` - Получение списка заявок
- `GET /application/{id}/` - Получение деталей заявки
- `GET /application/{id}/validate/` - AI проверка заявки
- `POST /application/` - Создание новой заявки

## 🤖 AI Функциональность

- **Анализ повреждений:** Автоматическое определение царапин, вмятин и других повреждений
- **OCR распознавание:** Извлечение данных из водительских удостоверений
- **Валидация данных:** Сверка данных заявителя с документами

## 👥 Команда разработки

- **Backend Developer:** Разработка API и ML модели
- **iOS Developer:** Мобильное приложение на Swift
- **ML Engineer:** Модель компьютерного зрения для анализа автомобилей

## 📈 Статус проекта

🚧 **Активная разработка** - MVP завершен, ведется работа над расширенным функционалом

## 🔮 Планы развития

- [ ] Поддержка множественных языков
- [ ] Офлайн режим с синхронизацией
- [ ] Push уведомления о статусе заявок
- [ ] Расширенная аналитика для модераторов
- [ ] Интеграция с системами inDrive

## 📄 Лицензия

Проект разработан в рамках хакатона inDrive.

---

**Примечание:** Для полноценной работы приложения необходим запущенный бэкенд с ML моделью. Инструкции по запуску бэкенда доступны в основном репозитории проекта.
