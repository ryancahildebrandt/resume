.interests[] |
select(.tags[] | contains($tag)) |
[
("\\\\textbf{" + .name + "};"),
("Keywords: " + (.keywords | join(" \\\\textbullet{} ")) + ";")
] | 
join("")