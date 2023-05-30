.work[] |
select(.tags[] | contains($tag)) |
[
("### **" + .position + "**;"), 
("*" + .company + "*, "), 
(.startDate + " - "), 
(.endDate + ";"),
("- " + .highlights[] + ";")
] | 
join("")