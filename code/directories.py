import itertools

import pandas as pd

students = pd.read_csv("data/fake_data.csv")
layouts = pd.read_csv("data/layouts.csv")

layouts["floor"] = layouts["room"] // 1000
df = students.merge(layouts, how="inner", on="room")
df = df.drop(labels=["building", "layout", "seat"], axis=1)

for floor, aisle in itertools.product([1, 2, 3], [0, 1]):
    dir_students = df.loc[(df["floor"] == floor) & (df["aisle"] == aisle)]
    print(dir_students.head())
