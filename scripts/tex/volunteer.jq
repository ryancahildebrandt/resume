.volunteer[] |
select(.tags[] | contains($tag)) |
[
("\\\\runsubsection{" + .position + "};"), 
("\\\\descript{" + .organization + "}, "), 
("\\\\location{" + .startDate + " - "), 
(.endDate + "};"),
("\\\\begin{tightitemize};"),
("\\\\item " + .highlights[] + ";"),
("\\\\end{tightitemize};"),
("\\\\sectionspace;")
] | 
join("")