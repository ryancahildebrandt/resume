.languages[] |
select(.tags[] | contains($tag)) |
[
("\\\\noindent"),
("\\\\textbf{" + .language + ": " + .level + "};"),
("\\\\textit{" + (.skills[] | join(": ")) + " \\|};")
] | 
join("")