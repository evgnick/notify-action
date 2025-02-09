import matplotlib.pyplot as plt

# Чтение результатов из файла
with open('/app/results.txt', 'r') as f:
    status, conclusion = f.readlines()

# Преобразуем данные в формат, который можно отобразить на графике
statuses = ['success', 'failure']
counts = [0, 0]

if 'success' in status:
    counts[0] += 1
else:
    counts[1] += 1

# Создаем простой график
plt.figure(figsize=(5,5))
plt.pie(counts, labels=statuses, autopct='%1.1f%%', startangle=90)
plt.title('CI Workflow Results')

# Сохраняем график
plt.savefig('/app/ci_results_chart.png')
