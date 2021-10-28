# Setup
import pandas as pd

data_path = "data/fake_data.csv"

# Import data
students = pd.read_csv(data_path)
layout = {"officeA": 0, "officeB": 1}

# Template loading and image manipulation
def get_template(layout):
    if layout == 0:
        return "3-2 layout SVG code Student1 Student2 Student3 Student4 Student5"
    else:
        return "2-3 layout SVG code Student1 Student2 Student3 Student4 Student5"

def replace_in_chart(chart, seat, first, last):
    # Given seat number, find part of chart corresponding to the student
    # with that seat and replace the filler text with their first and last name

    # We might be able to replace this with a basic string function
    pass

def write_to_file(chart, filepath):
    # Write final seating chart for a pod to disk for downstream processing.
    pass

# Main loop: Iterate over pods and create a chart from the appropriate template for each one
# If there's less than 5 students in a pod, this will leave filler text in the chart
for office in students["office"].unique():
    in_office = students.loc[students["office"] == office]
    seating_chart = get_template(layout[office])

    print(in_office)

    for student in in_office.itertuples():
        seat = student.seat
        first = student.first
        last = student.last

        replace_in_chart(seating_chart, seat, first, last)
    write_to_file(seating_chart, f"office_{office}_chart.svg")
