# Укажите базовый образ
FROM ubuntu:latest

# Установите рабочую директорию
WORKDIR /app

# Скопируйте остальные файлы в рабочую директорию
COPY . .

RUN cd docker/

# Скопируйте и установите переменные окружения
RUN cp .env.example .env

# Выполните команды для подготовки окружения
RUN docker-compose pull

CMD ["docker-compose", "up", "-d"]
