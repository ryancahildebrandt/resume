.research[] |
select(.tags[] | contains($tag)) |
[
("\\\\runsubsection{" + .title + "};"), 
("\\\\location{" + .institution + "};"),
("\\\\descript{" + .type + "};"),
("\\\\begin{tightitemize};"),
("\\\\item " + .highlights[] + ";"),
("\\\\end{tightitemize};"),
("\\\\sectionspace;")
] | 
join("")