#!/bin/bash

# Принимаем параметры
REPO_NAME=$1
REPO_OWNER=$2
RUN_NUMBER=$3

# Получаем результаты тестов
RESULTS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_NUMBER/artifacts")

# Извлекаем ссылку на артефакт (предположим, что он первый в списке)
ARTIFACT_URL=$(echo "$RESULTS" | jq -r '.artifacts[0].archive_download_url')

# Скачиваем артефакт
curl -L -o results.zip -H "Authorization: token $GITHUB_TOKEN" "$ARTIFACT_URL"

# Распаковываем результат
unzip -o results.zip -d /app/results

# Теперь результаты готовы
echo "Results downloaded and extracted."
