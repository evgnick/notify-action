# Notify Action

Этот GitHub Action предназначен для отправки уведомлений в Telegram о результатах тестов, полученных из Allure Report. Он автоматически:  
- Находит последний успешный или неудачный запуск указанного workflow.  
- Загружает результаты тестов из Allure Report.  
- Генерирует диаграмму с распределением тестов.  
- Отправляет отчет в Telegram, включая ссылку на отчет и изображение диаграммы.  


Добавьте следующий код в ваш `.github/workflows/your-workflow.yml`:  

```yaml
jobs:
  notify:
    runs-on: ubuntu-latest
    steps:
      - name: Send Notification
        uses: your-org/notify-action@v1
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          telegram-token: ${{ secrets.TELEGRAM_TOKEN }}
          telegram-chat-id: ${{ secrets.TELEGRAM_CHAT_ID }}
          workflow-name: "CI" # Имя workflow, для которого ищем последний запуск

```