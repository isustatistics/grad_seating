library("tidyverse")

## Rooms with number of seats
rooms <- tribble(
  ~building, ~room, ~nseats,
  "CSSM", 1215, 4,
  "CSSM", 1219, 5,
  "CSSM", 1220, 2,
  "Snedecor", 1411, 3,
  "Snedecor", 1414, 4, 
  "Snedecor", 1418, 5,
  "Snedecor", 2207, 5,
  "Snedecor", 2211, 5,
  "Snedecor", 2406, 5,
  "Snedecor", 2410, 5,
  "Snedecor", 2215, 5,
  "Snedecor", 2414, 5,
  "Snedecor", 2219, 5,
  "Snedecor", 2418, 5,
  "Snedecor", 3207, 5,
  "Snedecor", 3211, 5, 
  "Snedecor", 3215, 5,
  "Snedecor", 3219, 5,
  "Snedecor", 3406, 5,
  "Snedecor", 3410, 5,
  "Snedecor", 3414, 5,
  "Snedecor", 3418, 5,
  "Snedecor", 3220, 3
)

create_room <- function(d) {
  data.frame(
    building = d$building,
    room = d$room,
    seat = 1:d$nseats
  )
}

seating <- rooms %>%
  group_by(building, room) %>%
  do(create_room(.)) %>%
  ungroup() %>%
  mutate(first = paste0(building,room),
         last = paste0(seat),
         nickname = paste0("nick", 1:n()))

write_csv(seating, file = "../data/fake_data.csv")
