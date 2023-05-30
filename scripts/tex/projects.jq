.projects[] |
select(.tags[] | contains($tag)) |
[
("\\\\href{" + .url + "}{" + .name + "}: "), 
(.description + ";"),  
("Keywords: " + (.keywords | join(" \\\\textbullet{} ")) + ";")
] | 
join("")