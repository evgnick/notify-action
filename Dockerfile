FROM python:3.9-slim

# Установим зависимости
RUN apt-get update && apt-get install -y wget jq curl && \
    pip install matplotlib && \
    rm -rf /var/lib/apt/lists/*

# Установим рабочую директорию
WORKDIR /app

# Копируем скрипты в контейнер
COPY find_ci_run.sh /app/find_ci_run.sh
COPY fetch_results.sh /app/fetch_results.sh
COPY generate_chart.py /app/generate_chart.py
COPY notify_telegram.sh /app/notify_telegram.sh
COPY run_all.sh /app/run_all.sh

# Устанавливаем права на выполнение для всех скриптов
RUN chmod +x /app/find_ci_run.sh /app/fetch_results.sh /app/notify_telegram.sh /app/run_all.sh

# Проверим файлы, чтобы убедиться, что все на месте
RUN ls -la /app

# Используем новый скрипт для выполнения всех шагов
ENTRYPOINT ["bash", "/app/run_all.sh"]
