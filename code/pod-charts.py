# Setup
import pathlib

import pandas as pd

data_dir = pathlib.Path("data")
students = pd.read_csv(data_dir / "fake_data.csv")
layouts = pd.read_csv(data_dir / "layouts.csv")

# Template loading and image manipulation
def get_template(layout):
    if layout == 0:
        # Too lazy to create template right now
        return "".join([f"first{n} last{n} " for n in range(1, 6)])
    else:
        with open("templates/pod-2-3.svg", "r") as f:
            return f.read()

# Main loop: Iterate over pods and create a chart from the appropriate template for each one
# If there's less than 5 students in a pod, this will leave filler text in the chart
for room in students["room"].unique():
    in_room = students.loc[students["room"] == room]
    # Only pods for now
    if len(in_room) != 5:
        continue
    layout = layouts.loc[layouts["room"] == room, "layout"].iloc[0]
    print(layout)
    chart = get_template(layout)

    for student in in_room.itertuples():
        seat = student.seat
        first = student.first
        last = student.last

        chart = chart.replace(f"first{seat}", first)
        chart = chart.replace(f"last{seat}", last)

    with open(f"outputs/room_{room}_chart.svg", "w") as f:
        f.write(chart)
