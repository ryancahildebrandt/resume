.languages[] |
select(.tags[] | contains($tag)) |
[
("\\\\subsection{" + .language + ": " + .level + "};"),
("\\\\textbf{" + (.skills[] | join(": ")) + "};")
] | 
join("")