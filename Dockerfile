FROM python:3.9-slim

RUN apt-get update && apt-get install -y wget jq curl && \
    pip install matplotlib && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY find_ci_run.sh find_ci_run.sh
COPY fetch_results.sh fetch_results.sh
COPY generate_chart.py generate_chart.py
COPY notify_telegram.sh notify_telegram.sh

RUN chmod +x find_ci_run.sh fetch_results.sh notify_telegram.sh

ENTRYPOINT ["bash", "-c", "./find_ci_run.sh $GITHUB_TOKEN && \
                          read RUN_ID RUN_NUMBER REPO_OWNER REPO_NAME < ci_run.txt && \
                          ./fetch_results.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER && \
                          python3 generate_chart.py && \
                          ./notify_telegram.sh $REPO_NAME $REPO_OWNER $RUN_NUMBER $TELEGRAM_TOKEN $TELEGRAM_CHAT_ID"]
