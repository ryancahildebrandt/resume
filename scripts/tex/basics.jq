.basics |
[
("\\\\namesection{" + .name + "};\\\\leavevmode;;"),
("\\\\sectionspace;\\\\leavevmode;"),
(.label + ";\\\\leavevmode;;"),
(.profiles[] | ("\\\\href{" + .url + "}"), ("{" + .network + "}") + ";"),
(" \\| " + .email + " \\| " + .location.city + ", " + .location.region)
] | 
join("")
