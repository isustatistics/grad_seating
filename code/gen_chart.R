library("dplyr")
library("qpdf")

# function to generate the seating chart
# input is a df from read.csv (the seating chart)
gen_charts <- function(seats) {
  offices <- split(seats, seats$room)

  # this maps the inner function to every office in the list
  # the output of this will be a list with a string containing the tikz part of
  # each individual document
  office_maps <- Map(function(office) {

        # this creates the node for each of the individuals
        indiv_nodes <- apply(office, 1, function(x) {
            lay <- as.integer(x[7])
            fname <- x[4]
            lname <- x[5]
            nname <- x[6]
            seat <- as.integer(x[3])
            # do not ask why you need to check equality here
            template <- ifelse(lay == 1, tex_odd[[seat]], tex_even[[seat]])
            # return(sub("replace", paste0(fname, " \`\`", nname, "\"", "\\\\\\\\", lname), template))
            # without nickname
            return(sub("replace", paste0(fname, "\\\\\\\\", lname), template))
          }
        )

        onum <- office$room[1]

        # paste them all together and make the tex file
        # interior  <- paste(Reduce(c, indiv_nodes), sep = "\n")
        interior  <- paste(indiv_nodes, collapse = "\n")
        # add office number to bottom
        this_post <- sub("officenumber", onum, tex_post)
        # interior <- paste(interior, onum, sep = "\n\\hfill\\vfill")
        full_file <- paste(tex_preamble, interior, this_post, sep = "\n")

        list(fname = paste0("tex/", office$building, office$room, "_seatchart.tex"),
             content = full_file)
    },
    offices
  )

  Map(function(f) cat(f$content, file = f$fname[1]), office_maps)
}
