#!/bin/bash

# Получаем параметры
REPO_NAME="$1"
REPO_OWNER="$2"
RUN_NUMBER="$3"
GITHUB_TOKEN="$4"

# Формируем URL для получения деталей запуска
API_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_NUMBER"

# Получаем результат выполнения
echo "Получение результатов для RUN_NUMBER=$RUN_NUMBER"

response=$(curl -H "Authorization: Bearer $GITHUB_TOKEN" "$API_URL")

if [[ $? -ne 0 ]]; then
  echo "Не удалось получить данные о результате"
  exit 1
fi

# Записываем результат в файл
echo "$response" | jq '.status, .conclusion' > /app/results.txt

echo "Результаты записаны в /app/results.txt"
