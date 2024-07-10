# Укажите базовый образ
FROM ubuntu:latest

# Установите рабочую директорию
WORKDIR /app

# Скопируйте остальные файлы в рабочую директорию
COPY . .

RUN cd docker/

# Скопируйте и установите переменные окружения
RUN cp .env.example .env

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# Добавим официальный ключ GPG Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Добавим репозиторий Docker
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

# Установим Docker
RUN apt-get update && apt-get install -y docker-ce-cli

# Настройка Docker
RUN groupadd docker
RUN usermod -aG docker $USER

# Установка Docker Compose (опционально)
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# Создаем символическую ссылку для использования docker-compose командой "docker compose"
RUN ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Выполните команды для подготовки окружения
RUN docker-compose pull

CMD ["docker-compose", "up", "-d"]
