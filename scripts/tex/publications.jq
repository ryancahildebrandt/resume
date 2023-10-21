.publications[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{\\\\href{" + .website + "}{" + .name + "} \\(" + .releaseDate + "\\)};"),
(.publisher + ";"),
(.authors + ";")
] | 
join("")