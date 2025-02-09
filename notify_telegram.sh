#!/bin/bash

# Получаем параметры
REPO_NAME="$1"
REPO_OWNER="$2"
RUN_NUMBER="$3"
TELEGRAM_TOKEN="$4"
TELEGRAM_CHAT_ID="$5"

# Чтение результатов из файла
RESULTS_FILE="/app/results.txt"
if [[ ! -f "$RESULTS_FILE" ]]; then
  echo "Результаты не найдены"
  exit 1
fi

STATUS=$(cat "$RESULTS_FILE" | head -n 1)
CONCLUSION=$(cat "$RESULTS_FILE" | tail -n 1)

# Отправка уведомления в Telegram
MESSAGE="Результат выполнения CI для $REPO_NAME / $REPO_OWNER, RUN #$RUN_NUMBER:
Статус: $STATUS
Заключение: $CONCLUSION"

curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" \
     -d chat_id=$TELEGRAM_CHAT_ID \
     -d text="$MESSAGE"

echo "Уведомление отправлено в Telegram"
