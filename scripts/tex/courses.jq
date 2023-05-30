.courses[] |
select(.tags[] | contains($tag)) |
[
("\\\\subsection{" + .category + "};"), 
("Courses: " + (.keywords | join(" \\\\textbullet{} ")) + ";")
] | 
join("")