.courses[] |
select(.tags[] | contains($tag)) |
[
("### " + .category + ";"), 
("Courses: *" + (.keywords | join(", ")) + "*;")
] | 
join("")