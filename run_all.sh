#!/bin/bash

# find_ci_run.sh должен создать файл ci_run.txt с нужными данными
./find_ci_run.sh $GITHUB_TOKEN

# Читаем данные из ci_run.txt
read RUN_ID RUN_NUMBER REPO_OWNER REPO_NAME < ci_run.txt

# Загружаем результаты Allure
./fetch_results.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER

# Генерируем диаграмму
python3 generate_chart.py

# Отправляем уведомление в Telegram
./notify_telegram.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER $TELEGRAM_TOKEN $TELEGRAM_CHAT_ID
