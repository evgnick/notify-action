#!/bin/bash

# Выводим текущую директорию и список файлов для отладки
echo "Текущая директория: $(pwd)"
echo "Список файлов: $(ls -la)"

# Найдем последний CI запуск
/app/find_ci_run.sh $GITHUB_TOKEN

# Читаем данные из ci_run.txt
read RUN_ID RUN_NUMBER REPO_OWNER REPO_NAME < /app/ci_run.txt

# Получаем результаты Allure
/app/fetch_results.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER

# Генерируем диаграмму
python3 /app/generate_chart.py

# Отправляем уведомление в Telegram
/app/notify_telegram.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER $TELEGRAM_TOKEN $TELEGRAM_CHAT_ID
