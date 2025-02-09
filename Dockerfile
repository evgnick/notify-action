FROM python:3.9-slim

# Установим зависимости
RUN apt-get update && apt-get install -y wget jq curl && \
    pip install matplotlib && \
    rm -rf /var/lib/apt/lists/*

# Установим рабочую директорию
WORKDIR /app

# Копируем скрипты в контейнер
COPY find_ci_run.sh find_ci_run.sh
COPY fetch_results.sh fetch_results.sh
COPY generate_chart.py generate_chart.py
COPY notify_telegram.sh notify_telegram.sh
COPY run_all.sh run_all.sh

# Устанавливаем права на выполнение для всех скриптов
RUN chmod +x find_ci_run.sh fetch_results.sh notify_telegram.sh run_all.sh

# Используем новый скрипт для выполнения всех шагов
ENTRYPOINT ["bash", "/app/run_all.sh"]
