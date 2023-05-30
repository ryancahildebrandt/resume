.basics |
[
("# " + .name + ";"),
("### " + .label + ";;"),
("--- ;;"),
(.profiles[] | ("[" + .network + "]"), ("(" + .url + ")") + ";"),
(.email + " \\| " + .location.city + ", " + .location.region)
] | 
join("")
