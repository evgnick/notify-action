import matplotlib.pyplot as plt
import os
from matplotlib import patches

with open("results.txt", "r") as f:
    passed, failed, broken, skipped, unknown, duration = f.read().split()

values = [int(passed), int(failed), int(broken), int(skipped), int(unknown)]
labels = ["Passed", "Failed", "Broken", "Skipped", "Unknown"]
colors = ["#8BC34A", "#F44336", "#FF9800", "#2196F3", "#8A2BE2"]

fig, ax = plt.subplots(figsize=(3, 2))
wedges, texts, autotexts = ax.pie(
    values, labels=None, autopct="%1.1f%%", colors=colors,
    startangle=90, wedgeprops={"edgecolor": "white", "linewidth": 2}, pctdistance=0.85,
)

for autotext in autotexts:
    if float(autotext.get_text().replace("%", "")) == 0:
        autotext.set_text("")
    autotext.set_fontsize(6)

centre_circle = plt.Circle((0, 0), 0.60, fc="white")
fig.gca().add_artist(centre_circle)

ax.text(0, 0, str(sum(values)), ha="center", va="center", fontsize=16, fontweight="bold")

legend_x, legend_y = 1.05, 0.6
plt.gca().set_position([0, 0, 0.7, 1])

for i, (label, color, value) in enumerate(zip(labels, colors, values)):
    rect = patches.Rectangle(
        (legend_x - 0.07, legend_y - i * 0.1 - 0.025),
        0.05, 0.05, color=color, transform=ax.transAxes, clip_on=False
    )
    plt.gcf().add_artist(rect)

    plt.gcf().text(
        legend_x - 0.35, legend_y - i * 0.1, f"{value} - {label}",
        color="black", fontsize=8, bbox=dict(facecolor="white", edgecolor="white", boxstyle="square,pad=0.3"),
        ha="left", va="center"
    )

plt.savefig("chart.png", dpi=300, bbox_inches="tight", pad_inches=0.05)
