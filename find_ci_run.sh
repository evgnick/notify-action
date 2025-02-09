#!/bin/bash

# Принимаем параметры
GITHUB_TOKEN=$1
WORKFLOW_NAME=$2

# Используем API GitHub для получения CI-run
RUN_DATA=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$GITHUB_REPOSITORY/actions/workflows/$WORKFLOW_NAME.yml/runs?status=success")

# Получаем последний успешный run
RUN_ID=$(echo "$RUN_DATA" | jq -r '.workflow_runs[0].id')
RUN_NUMBER=$(echo "$RUN_DATA" | jq -r '.workflow_runs[0].run_number')
REPO_OWNER=$(echo "$GITHUB_REPOSITORY" | cut -d '/' -f 1)
REPO_NAME=$(echo "$GITHUB_REPOSITORY" | cut -d '/' -f 2)

# Выводим результаты в консоль
echo "RUN_ID=$RUN_ID"
echo "RUN_NUMBER=$RUN_NUMBER"
echo "REPO_OWNER=$REPO_OWNER"
echo "REPO_NAME=$REPO_NAME"
