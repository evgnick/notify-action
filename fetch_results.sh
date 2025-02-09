#!/bin/bash
set -e

REPO_NAME=$1
REPO_OWNER=$2
RUN_NUMBER=$3

REPORT_URL="https://$REPO_OWNER.github.io/$REPO_NAME/$RUN_NUMBER/widgets/summary.json"

wget -q -O summary.json "$REPORT_URL" || { echo "Failed to download report"; exit 1; }

PASSED=$(jq '.statistic.passed' summary.json || echo "0")
FAILED=$(jq '.statistic.failed' summary.json || echo "0")
BROKEN=$(jq '.statistic.broken' summary.json || echo "0")
SKIPPED=$(jq '.statistic.skipped' summary.json || echo "0")
UNKNOWN=$(jq '.statistic.unknown' summary.json || echo "0")
DURATION=$(jq '.time.duration' summary.json || echo "0")
DURATION_FINAL=$(date -ud @$((DURATION / 1000)) +'%M:%S')

echo "$PASSED $FAILED $BROKEN $SKIPPED $UNKNOWN $DURATION_FINAL" > results.txt
