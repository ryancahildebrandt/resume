.work[] |
select(.tags[] | contains($tag)) |
[
("\\\\runsubsection{" + .position + "};"),
("\\\\descript{" + .company + "}, "), 
("\\\\location{" + .startDate + " - "), 
(.endDate + "};"),
("\\\\begin{tightitemize};"),
("\\\\item " + .highlights[] + ";"),
("\\\\end{tightitemize};"),
("\\\\sectionspace;")
] | 
join("")