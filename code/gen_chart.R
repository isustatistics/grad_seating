tex_preamble <- "\\documentclass[11pt]{article}
\\usepackage{tikz}
\\usetikzlibrary{positioning}

\\tikzstyle{seat} = [rectangle,
                    rounded corners,
                    minimum width=3cm,
                    minimum height=2cm,
                    text centered,
                    % node distance=3cm and 1cm,
                    fill=cyan!25,
                    draw=black]

\\begin{document}

\\begin{figure}[h]
   \\centering
   \\begin{tikzpicture}[node distance=2cm]"

tex_post <- "\\end{tikzpicture}
\\end{figure}
\\end{document}"

tex_even <- list(
     "\\node (s1) [seat] {\\begin{tabular}{c} replace \\end{tabular}};",
     "\\node (s2) [seat, below= of s1] {\\begin{tabular}{c} replace \\end{tabular}};",
     "\\node (s3) [seat, below= of s2] {\\begin{tabular}{c} replace \\end{tabular}};",
     "\\node (s4) [seat, right= of s1, yshift = -2cm] {\\begin{tabular}{c} replace \\end{tabular}};",
     "\\node (s5) [seat, below= of s4] {\\begin{tabular}{c} replace \\end{tabular}};"
)

tex_odd <- list(
     "\\node (s1) [seat] {\\begin{tabular}{c} replace \\end{tabular}};",
     "\\node (s2) [seat, below= of s1] {\\begin{tabular}{c} replace \\end{tabular}};",
     "\\node (s3) [seat, below= of s2] {\\begin{tabular}{c} replace \\end{tabular}};",
     "\\node (s4) [seat, left= of s1, yshift = -2cm] {\\begin{tabular}{c} replace \\end{tabular}};",
     "\\node (s5) [seat, below= of s4] {\\begin{tabular}{c} replace \\end{tabular}};"
)


dat <- read.csv("../data/fake_data.csv")

# function to generate the seating chart
# input is a df from read.csv (the seating chart)
gen_charts <- function(seats) {

  offices <- split(seats, seats$office)

  # this maps the inner function to every office in the list
  # the output of this will be a list with a string containing the tikz part of
  # each individual document
  gen_charts <- function(seats) {
  offices <- split(seats, seats$office)

  # this maps the inner function to every office in the list
  # the output of this will be a list with a string containing the tikz part of
  # each individual document
  office_maps <- Map(function(office) {

        # this creates the node for each of the individuals
        indiv_nodes <- apply(office, 1, function(x) {
            fname <- x[1]
            lname <- x[2]
            seat <- as.integer(x[4])
            # NOTE: this actual condition needs to be changed
            template <- ifelse(x[3] == "officeA", tex_even[[seat]], tex_odd[[seat]])
            sub("replace", paste(fname, "\\\\", lname), template)
          }
        )

        # paste them all together and make the tex file
        interior  <- paste(Reduce(c, indiv_nodes), sep = "\n")
        interior  <- paste(indiv_nodes, collapse = "\n")
        full_file <- paste(tex_preamble, interior, tex_post, sep = "\n")

        list(fname = paste0("../tex/", office$office, "_seatchart.tex"),
             content = full_file)
    },
    offices
  )

  Map(function(f) cat(f$content, file = f$fname[1]), office_maps)
}
