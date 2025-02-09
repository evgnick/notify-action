#!/bin/bash

GITHUB_TOKEN=$1
WORKFLOW_NAME=$2

echo "Запуск find_ci_run.sh с токеном: $GITHUB_TOKEN для workflow: $WORKFLOW_NAME"

# Получаем все успешные запуски для указанного workflow
curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
     "https://api.github.com/repos/$GITHUB_REPOSITORY/actions/workflows/$WORKFLOW_NAME.yml/runs?status=success" \
     | jq . > ci_run.json

# Отладочный вывод
echo "Ответ API:"
cat ci_run.json

# Проверяем, есть ли успешные запуски
RUN_ID=$(jq -r '.workflow_runs[0].id' ci_run.json)
RUN_NUMBER=$(jq -r '.workflow_runs[0].run_number' ci_run.json)

if [[ -z "$RUN_ID" || -z "$RUN_NUMBER" ]]; then
    echo "Не удалось найти успешные CI запуски"
    exit 1
fi

# Сохраняем информацию о запуске в файл для дальнейшего использования
echo "$RUN_ID $RUN_NUMBER $GITHUB_REPOSITORY_OWNER $GITHUB_REPOSITORY" > ci_run.txt
