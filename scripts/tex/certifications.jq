.certifications[] |
select(.tags[] | contains($tag)) |
[
("\\\\textbf{" + .organization + " " + .title + "};"), 
(.date + ";"),
(.url + ";")
] | 
join("")