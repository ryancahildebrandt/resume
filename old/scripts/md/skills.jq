.skills[] |
select(.tags[] | contains($tag)) |
[
("### **" + .name + "**;"), 
("Keywords: *" + (.keywords | join(", ")) + "*;")
] | 
join("")