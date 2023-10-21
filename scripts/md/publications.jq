.publications[] |
select(.tags[] | contains($tag)) |
[
("### " + .name + ", " + .releaseDate + ";"), 
(.publisher + ";"),
(.authors + ";"),
(.website + ";")
] | 
join("")