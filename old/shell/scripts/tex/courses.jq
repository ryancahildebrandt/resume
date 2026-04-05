.courses[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .category + "};"), 
((.keywords | join(" - ")) + ";")
] | 
join("")