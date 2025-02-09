#!/bin/bash

# Получаем параметры
GITHUB_TOKEN="$1"
WORKFLOW_NAME="$2"

# Получаем информацию о запуске воркфлоу
API_URL="https://api.github.com/repos/$GITHUB_REPOSITORY_OWNER/$GITHUB_REPOSITORY/actions/workflows/$WORKFLOW_NAME/runs"

echo "Запуск find_ci_run.sh с токеном: $GITHUB_TOKEN для workflow: $WORKFLOW_NAME"

# Запрашиваем данные о последних запусках воркфлоу
response=$(curl -H "Authorization: Bearer $GITHUB_TOKEN" "$API_URL")

# Проверяем успешность запроса
if [[ $? -ne 0 ]]; then
  echo "Не удалось получить данные из GitHub API"
  exit 1
fi

# Записываем информацию о первом успешном запуске в файл
echo "$response" | jq -r '.workflow_runs[0] | "\(.id) \(.run_number) \(.repository.owner.login) \(.repository.name)"' > /app/ci_run.txt

echo "Данные записаны в /app/ci_run.txt"
