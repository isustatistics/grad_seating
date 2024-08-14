tex_preamble <- "\\documentclass[24pt]{article}
\\usepackage{tikz}
\\usetikzlibrary{positioning}
\\usepackage[sfdefault]{cabin}
\\usepackage[T1]{fontenc}
\\usepackage[fontsize=18pt]{fontsize}

\\tikzstyle{seat} = [rectangle,
                    rounded corners,
                    minimum width=5.5cm,
                    minimum height=4cm,
                    text centered,
                    % node distance=3cm and 1cm,
                    fill=cyan!25,
                    draw=black]

\\begin{document}
\\vspace{2mm}

\\begin{figure}[h]
   \\centering
   \\begin{tikzpicture}[node distance=1cm]"

tex_post <- "\\end{tikzpicture}
\\end{figure}
\\vfill
officenumber
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
