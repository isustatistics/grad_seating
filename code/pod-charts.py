# Setup
import pandas as pd

students = pd.read_csv("data/fake_data.csv")
layouts = pd.read_csv("data/layouts.csv")

# Template loading and image manipulation
def get_template(layout):
    if layout == 0:
        # Too lazy to create template right now
        return "".join([f"first{n} last{n} " for n in range(1, 6)])
    else:
        with open("templates/pod-2-3.svg", "r") as f:
            return f.read()

# Main loop: Iterate over pods and create a chart from the appropriate template for each one
for room in students["room"].unique():
    in_room = students.loc[students["room"] == room]
    # Only pods for now
    if len(in_room) != 5:
        continue
    layout = layouts.loc[layouts["room"] == room, "layout"].iloc[0]
    chart = get_template(layout)

    for student in in_room.itertuples():
        chart = chart.replace(f"first{student.seat}", student.first)
        chart = chart.replace(f"last{student.seat}", student.last)

    with open(f"outputs/room_{room}_chart.svg", "w") as f:
        f.write(chart)
