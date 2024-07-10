# Укажите базовый образ
FROM node:14

# Установите рабочую директорию
WORKDIR /app

# Скопируйте остальные файлы в рабочую директорию
COPY . .

WORKDIR /app/docker

# Скопируйте и установите переменные окружения
RUN cp .env.example .env

# Выполните команды для подготовки окружения
RUN docker-compose pull
RUN docker-compose up -d
