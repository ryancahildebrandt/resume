.volunteer[] |
select(.tags[] | contains($tag)) |
[
("### **" + .position + "**;"), 
("*" + .organization + "*, "), 
(.startDate + " - "), 
(.endDate + ";"),
("- " + .highlights[] + ";")
] | 
join("")