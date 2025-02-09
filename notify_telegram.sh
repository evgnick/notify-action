#!/bin/bash

# Принимаем параметры
REPO_NAME=$1
REPO_OWNER=$2
RUN_NUMBER=$3
TELEGRAM_TOKEN=$4
TELEGRAM_CHAT_ID=$5

# Генерируем ссылку на отчет
REPORT_URL="https://github.com/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_NUMBER"

# Отправляем сообщение в Telegram
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" \
  -d chat_id=$TELEGRAM_CHAT_ID \
  -d text="CI Run completed successfully. You can check the results here: $REPORT_URL"
