.interests[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .name + "};"),
("\\\\textit{Keywords:} " + (.keywords | join(" - ")) + ";")
] | 
join("")