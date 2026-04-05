.research[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .title + "};;"), 
(.institution + " - \\\\textit{" + .type + "};"),
("\\\\begin{itemize};"),
("\\\\item " + .highlights[] + ";"),
("\\\\end{itemize};")
] | 
join("")