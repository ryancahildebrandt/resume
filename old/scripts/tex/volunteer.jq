.volunteer[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .position + "} ;;"),
("\\\\noindent"),
("\\\\textit{" + .organization + "} \\\\hfill " + .startDate + " - " + .endDate + ";"), 
("\\\\begin{itemize}"),
("\\\\item " + .highlights[] + ";"),
("\\\\end{itemize}")
] | 
join("")