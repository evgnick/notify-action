#!/bin/bash
set -e

GITHUB_TOKEN=$1
WORKFLOW_NAME=$2

# Получаем владельца и название репозитория из переменных окружения GitHub Actions
REPO_OWNER=${GITHUB_REPOSITORY_OWNER}
REPO_NAME=$(basename $GITHUB_REPOSITORY)

# Получаем список запусков нужного workflow
LATEST_CI_RUN=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs?per_page=50" \
  | jq --arg WORKFLOW_NAME "$WORKFLOW_NAME" '.workflow_runs[] | select(.name == $WORKFLOW_NAME and .status == "completed" and (.conclusion == "success" or .conclusion == "failure")) | {id, run_number, created_at}' \
  | jq -s 'sort_by(.created_at) | reverse | .[0]')

RUN_ID=$(echo "$LATEST_CI_RUN" | jq -r '.id')
RUN_NUMBER=$(echo "$LATEST_CI_RUN" | jq -r '.run_number')

if [[ "$RUN_ID" == "null" || "$RUN_NUMBER" == "null" ]]; then
  echo "Error: No successful runs found for workflow: $WORKFLOW_NAME"
  exit 1
fi

echo "$RUN_ID $RUN_NUMBER $REPO_OWNER $REPO_NAME" > ci_run.txt
