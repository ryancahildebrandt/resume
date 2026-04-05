.basics |
[
("\\\\textbf{\\\\Large " + .name + "}\\\\\\\\[2pt];"),
(.label + ";;"),
(.profiles[] | ("\\\\href{" + .url + "}"), ("{" + .network + "}") + ";"),
(" \\| " + .email + " \\| " + .location.city + ", " + .location.region + ";")
] | 
join("")
