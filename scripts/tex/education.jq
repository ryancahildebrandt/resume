.education[] |
select(.tags[] | contains($tag)) |
[
("\\\\textbf{" + .institution + "};"), 
(.studyType + " - " + .area + ", "), 
(.startDate + " - "), 
(.endDate + ";")
] | 
join("")