.education[] |
select(.tags[] | contains($tag)) |
[
("### **" + .institution + "**;"), 
("*" + .studyType + " - " + .area + "*, "), 
(.startDate + " - "), 
(.endDate + ";")
] | 
join("")