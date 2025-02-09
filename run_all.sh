#!/bin/bash

# Получаем параметры из командной строки
GITHUB_TOKEN=$1
TELEGRAM_TOKEN=$2
TELEGRAM_CHAT_ID=$3
WORKFLOW_NAME=$4

# Шаг 1: Найдем информацию о последнем успешном CI
OUTPUT=$(./find_ci_run.sh $GITHUB_TOKEN $WORKFLOW_NAME)

# Извлекаем данные из вывода
RUN_ID=$(echo "$OUTPUT" | grep "RUN_ID" | cut -d '=' -f 2)
RUN_NUMBER=$(echo "$OUTPUT" | grep "RUN_NUMBER" | cut -d '=' -f 2)
REPO_OWNER=$(echo "$OUTPUT" | grep "REPO_OWNER" | cut -d '=' -f 2)
REPO_NAME=$(echo "$OUTPUT" | grep "REPO_NAME" | cut -d '=' -f 2)

# Шаг 2: Получим результаты тестов
./fetch_results.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER

# Шаг 3: Отправим уведомление в Telegram
./notify_telegram.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER $TELEGRAM_TOKEN $TELEGRAM_CHAT_ID
