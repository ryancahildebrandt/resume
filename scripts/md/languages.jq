.languages[] |
select(.tags[] | contains($tag)) |
[
("### **" + .language + ": " + .level + "**;"),
("*" + (.skills[] | join(": ")) + "*;")
] | 
join("")