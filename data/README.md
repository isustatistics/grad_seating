Let's not put any identifying information in here, 
i.e. no real names. 

## fake_data.csv 

This file is created from ../code/create_fake_data.R and is intended to get us 
started with a data structure for creating scripts. 

The data file has these following columns

- building: name of building (Snedecor, CSSM, ?)
- room: room number
- seat: seat number is clockwise from the entryway, i.e. seat 1 is the first seat on the left (as you enter the room)
- first: first name
- last: last name
- nickname: nickname

## layouts.csv

This file contains information about different room layouts:

- room: room number
- layout: 0 for pods with 3 seats on the left and 2 on the right (from the entrance), 1 for pods with 2 seats on the left and 3 on the right
- aisle: 0 for pods on the west side of Snedecor, 1 for those on the east side


## seatdata.csv

Use this name for actual seating data as it is included in .gitignore.