library(tidyverse)
library(qpdf)

# =============================================================================
# tex headers
# =============================================================================

tex_preamble <- "\\documentclass[24pt]{article}
\\usepackage[sfdefault]{cabin}
\\usepackage[T1]{fontenc}
\\usepackage[fontsize=26pt]{fontsize}
\\usepackage{tabularx}
\\usepackage[margin=.7in]{geometry}

\\begin{document}
\\thispagestyle{empty}
\\vfill
\\begin{center}
\\begin{tabularx}{\\textwidth}{X}
{\\large \\textbf{Name}} \\dotfill {\\large \\textbf{Room}} \\\\
"

tex_post <- "\\end{tabularx}
\\end{center}
\\end{document}"


# =============================================================================
# read and arrange seating chart data for latex table
# =============================================================================
seats <- read_csv("../data/fake_data.csv")

seats <- seats |>
  select(room, first, last) |>
  filter(!is.na(first) & !is.na(last)) |>
  mutate(dir = floor(room/100)) 

seats_spl <- split(seats, f = seats$dir) |>
  map(
    function(df) {
      select(df, room, first, last) |>
        mutate(name = paste0(last, ", ", first)) |>
        select(name, room) |>
        arrange(name)
    }
  )

# =============================================================================
# create tex files
# =============================================================================
seats_spl |>
  map(
    function(side) {
      namestr <- ""

      for (i in 1:nrow(side))
        namestr <- c(namestr, paste(side$name[i], side$room[i], sep = " \\dotfill "))

      f <- paste(tex_preamble, paste(namestr, collapse = "\\\\\n"), tex_post, sep = "\n")
      cat(f, file = paste0("../tex/", floor(side$room[1]/100), "_dir.tex"))
    }
  )

# =============================================================================
# compile and combine pdfs
# =============================================================================

setwd("../tex")
tex_files <- list.files(pattern = "_dir\\.tex")
for (file in tex_files)
  system(paste("pdflatex", file))

pdf_files <- setdiff(list.files(pattern = "_dir\\.pdf"), "directories.pdf")
qpdf::pdf_combine(input = pdf_files, output = "directories.pdf")

