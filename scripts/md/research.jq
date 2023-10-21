.research[] |
select(.tags[] | contains($tag)) |
[
("### " + .title + ";"), 
(.institution + ";"),
(.type + ";"),
("- " + .highlights[] + ";")
] | 
join("")