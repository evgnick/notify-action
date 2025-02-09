#!/bin/bash
set -e

REPO_NAME=$1
REPO_OWNER=$2
RUN_NUMBER=$3
TELEGRAM_TOKEN=$4
TELEGRAM_CHAT_ID=$5

REPORT_LINK="https://$REPO_OWNER.github.io/$REPO_NAME/$RUN_NUMBER/"
CI_RUN_LINK="https://github.com/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_NUMBER"
TIMESTAMP=$(date +"%Y.%m.%d %H:%M:%S")

read PASSED FAILED BROKEN SKIPPED UNKNOWN DURATION_FINAL < results.txt

MESSAGE="📝 Report: [open]($REPORT_LINK)
📅 Date: $TIMESTAMP
⏱️ Execution time: $DURATION_FINAL
⚙️ Build: $RUN_NUMBER
🔗 Run: [see]($CI_RUN_LINK)"

curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendPhoto" \
  -F chat_id="$TELEGRAM_CHAT_ID" \
  -F photo="@chart.png" \
  -F caption="$MESSAGE" \
  -F parse_mode="MarkdownV2"
