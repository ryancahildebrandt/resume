.projects[] |
select(.tags[] | contains($tag)) |
[
("### **[" + .name + "](" + .url + ")**;"), 
(.description + ";"),  
("Keywords: *" + (.keywords | join(", ")) + "*;")
] | 
join("")