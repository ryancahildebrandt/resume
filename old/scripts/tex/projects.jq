.projects[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{\\\\href{" + .url + "}{" + .name + "}}: "), 
(.description + ";;"),  
("\\\\textit{Keywords:} " + (.keywords | join(" - ")) + ";")
] | 
join("")