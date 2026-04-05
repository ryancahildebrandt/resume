.skills[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .name + ":} "),
((.keywords | join(" - ")) + ";")
] | 
join("")