.certifications[] |
select(.tags[] | contains($tag)) |
[
("### " + .organization + " " + .title + ";"), 
(.date + ";"),
(.url + ";")
] | 
join("")