library("dplyr")
library("qpdf")

if (!dir.exists("tex"))
  dir.create("tex")

source("code/tex_stuff.R")
source("code/gen_chart.R")

# dat <- read.csv("data/fake_data.csv") %>% filter(building != "CSSM")
dat <- read.csv("data/seatdata.csv")
lay <- read.csv("data/layouts.csv")

# TODO (josh 11/8): not exactly sure what is going on with CSSM rooms figure
# that out maybe
chart_layouts <- dplyr::inner_join(dat, lay, by = "room")

gen_charts(chart_layouts)

# Create pdfs
setwd("tex")
tex_files <- list.files(pattern = "\\.tex")
for (file in tex_files)
  system(paste("pdflatex", file))

pdf_files <- setdiff(list.files(pattern = "\\.pdf"), "seatingcharts.pdf")
qpdf::pdf_combine(input = pdf_files, output = "seatingcharts.pdf")
setwd("..")
