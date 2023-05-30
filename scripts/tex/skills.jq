.skills[] |
select(.tags[] | contains($tag)) |
[
("\\\\subsection{" + .name + "};"), 
("Keywords: " + (.keywords | join(" \\\\textbullet{} ")) + ";")
] | 
join("")