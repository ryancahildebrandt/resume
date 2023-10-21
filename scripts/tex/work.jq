.work[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .position + "} ;;"),
("\\\\noindent"),
("\\\\textit{" + .company + "} \\\\hfill " + .startDate + " - " + .endDate + ";"), 
("\\\\begin{itemize}"),
("\\\\item " + .highlights[] + ";"),
("\\\\end{itemize}")
] | 
join("")