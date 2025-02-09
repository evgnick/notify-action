#!/bin/bash

# Получаем параметры
GITHUB_TOKEN="$1"
TELEGRAM_TOKEN="$2"
TELEGRAM_CHAT_ID="$3"
WORKFLOW_NAME="$4"

# Получаем данные о последнем успешном запуске CI
echo "Запуск find_ci_run.sh с токеном: $GITHUB_TOKEN для workflow: $WORKFLOW_NAME"
./find_ci_run.sh $GITHUB_TOKEN $WORKFLOW_NAME

# Чтение информации о последнем запуске
if [[ ! -f "/app/ci_run.txt" ]]; then
  echo "Не удалось найти файл ci_run.txt"
  exit 1
fi

# Извлекаем данные из файла
read RUN_ID RUN_NUMBER REPO_OWNER REPO_NAME < /app/ci_run.txt

# Получаем результаты выполнения
echo "Запуск fetch_results.sh для RUN_NUMBER=$RUN_NUMBER"
./fetch_results.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER $GITHUB_TOKEN

# Генерация графика
echo "Запуск generate_chart.py"
python3 /app/generate_chart.py

# Отправка уведомления в Telegram
echo "Запуск notify_telegram.sh"
./notify_telegram.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER $TELEGRAM_TOKEN $TELEGRAM_CHAT_ID
