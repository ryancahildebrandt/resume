.education[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .institution + "};"), 
(.studyType + " - " + .area + "\\\\hfill"), 
(.startDate + " - "), 
(.endDate + ";")
] | 
join("")