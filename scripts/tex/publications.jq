.publications[] |
select(.tags[] | contains($tag)) |
[
("\\\\textbf{" + .name + " " + .releaseDate + "};"), 
(.publisher + ";"),
(.authors + ";"),
(.website + ";")
] | 
join("")