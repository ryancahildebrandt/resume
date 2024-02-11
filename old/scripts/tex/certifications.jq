.certifications[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .organization + " \\\\href{" + .url + "}{"  + .title + "}};"), 
("\\\\hfill" + .date + ";")
] | 
join("")