# Setup
import pathlib

import pandas as pd

data_dir = pathlib.Path("data")
students = pd.read_csv(data_dir / "jdata.csv")
layouts = pd.read_csv(data_dir / "layouts.csv")
df = students.merge(layouts, on="room", how="inner")

# Template loading and image manipulation
def get_template(layout):
    if layout == 0:
        pass
    else:
        with open("templates/pod-2-3.svg", "r") as f:
            return f.read()

# Main loop: Iterate over pods and create a chart from the appropriate template for each one
# If there's less than 5 students in a pod, this will leave filler text in the chart
for room in df["room"].unique():
    in_room = df.loc[df["room"] == room]
    chart = get_template(in_room["layout"][0])

    for student in in_room.itertuples():
        seat = student.seat
        first = student.first
        last = student.last

        chart = chart.replace(f"first{seat}", first)
        chart = chart.replace(f"last{seat}", last)

    with open(f"outputs/room_{room}_chart.svg", "w") as f:
        f.write(chart)
