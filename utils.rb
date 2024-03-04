#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#Created on Sat Feb 10 08:34:54 PM EST 2024 
#author: Ryan Hildebrandt, github.com/ryancahildebrandt

# imports
require "erb"
require "json"
require "pandoc-ruby"

#utils
def strip_newlines(in_text)
	return in_text.gsub(/\R{2,}/, "\n\n")
end

def prep_md(in_text)
	out = in_text
	#empty english skills
	out = out.gsub("*: *", "")
	#empty sections
	out = out.gsub(/## .*\n\n/, "")
	#newlines last
	out = strip_newlines(out)
	return out
end

def prep_tex(in_text)
	out = in_text
	#ampersands for tex
	out = out.gsub(/&/, "\\\\&")
	#_ in urls
	out = out.gsub(/{aozora_corpus}/, "{aozora{\\_}corpus}")
	#empty english skills
	out = out.gsub("\\textit{: }", "")
	#empty sections
	out = out.gsub(/(^\\section.*$\R+)(^\\section.*$)/, "\\2")
	#newlines last
	out = strip_newlines(out)
	return out
end

def filter_resume(in_json, tag)
	out = {"basics" => in_json["basics"]}
	in_json.each do |k, v| 
		if k != "basics"
			out[k] = v.select{|i| i["tags"].include?(tag)}
		end
	end
	return out
end

def process_single_resume(tag)
	resume_file = File.read("resume.json")
	raw_json = JSON.parse(resume_file)
	resume = filter_resume(raw_json, tag)

	basics = {
		"md" => "
# #{resume["basics"]["name"]}

#{resume["basics"]["profiles"].map{|i| "[#{i["network"]}](#{i["url"]})"}.join(" ")}

#{resume["basics"]["email"]} | #{resume["basics"]["location"]["city"]}, #{resume["basics"]["location"]["region"]}
	",
		"tex" => "
\\textbf{\\Large #{resume["basics"]["name"]}}\\\\[2pt]
#{resume["basics"]["label"]}

#{resume["basics"]["profiles"].map{|i| "\\href{#{i["url"]}}{#{i["network"]}}"}.join(" ")}
#{resume["basics"]["email"]} | #{resume["basics"]["location"]["city"]}, #{resume["basics"]["location"]["region"]}
	"}

	work = {
		"md" => "
## Work Experience
#{resume["work"].map{|i| 
"**#{i["position"]}**\n
*#{i["company"]}*, #{i["startDate"]} - #{i["endDate"]}\n
#{i["highlights"].map{|h| "- #{h}"}.join("\n")}
"}.join("\n")}",
		"tex" => "
\\section*{Work Experience}
#{resume["work"].map{|i| 
"
\\noindent
\\textbf{#{i["position"]}}
\\noindent
\\textit{#{i["company"]}} \\hfill #{i["startDate"]} - #{i["endDate"]}
\\begin{itemize}
#{i["highlights"].map{|h| "\\item #{h}"}.join("\n")}
\\end{itemize}
"}.join("\n")}"
	}	

	skills = {
		"md" => "
## Skills
#{resume["skills"].map{|i| 
"**#{i["name"]}**

*#{i["keywords"].join(", ")}*
"}.join("\n")}",
		"tex" => "
\\section*{Skills}
#{resume["skills"].map{|i| 
"
\\noindent
\\textbf{#{i["name"]}:}
\\textit{#{i["keywords"].join(" - ")}}
"}.join("\n")}"
	}

	research = {
		"md" => "
## Research Experience
#{resume["research"].map{|i| 
"**#{i["title"]}** - *#{i["institution"]} - #{i["type"]}*\n
#{i["highlights"].map{|h| "- #{h}"}.join("\n")}
"}.join("\n")}",
		"tex" => "
\\section*{Research Experience}
#{resume["research"].map{|i| 
"
\\noindent
\\textbf{#{i["title"]}:}
#{i["institution"]} - \\textit{#{i["type"]}}
\\begin{itemize}
#{i["highlights"].map{|h| "\\item #{h}"}.join("\n")}
\\end{itemize}
"}.join("\n")}"
	}

	publications = {
		"md" => "
## Publications & Presentations
#{resume["publications"].map{|i| 
"**#{i["name"]}, #{i["releaseDate"]}.**, #{i["publisher"]}, #{i["authors"]}, #{i["website"]}
"}.join("\n")}",
		"tex" => "
\\section*{Publications & Presentations}
#{resume["publications"].map{|i| 
"
\\noindent
\\textbf{\\href{#{i["website"]}}{#{i["name"]}}} (#{i["releaseDate"]})
#{i["publisher"]}
#{i["authors"]}
"}.join("\n")}"
	}

	languages = {
		"md" => "
## Languages
#{resume["languages"].map{|i| 
"**#{i["language"]}: #{i["level"]}**\n
#{i["skills"].map{|s| "*#{s["name"]}: #{s["level"]}*  "}.join("\n")}"}.join("\n")}",
		"tex" => "
\\section*{Languages}
#{resume["languages"].map{|i| 
"
\\noindent
\\textbf{#{i["language"]}: #{i["level"]}}
#{i["skills"].map{|s| "\\textit{#{s["name"]}: #{s["level"]}}\n"}.join("\n")}
"}.join("\n")}"
	}

	education = {
		"md" => "
## Education
#{resume["education"].map{|i| 
"**#{i["institution"]}** - *#{i["studyType"]} - #{i["area"]}*, #{i["startDate"]} - #{i["endDate"]}
"}.join("\n")}",
		"tex" => "
\\section*{Education}
#{resume["education"].map{|i| 
"
\\noindent
\\textbf{#{i["institution"]}}
\\textit{#{i["studyType"]} - #{i["area"]}, #{i["startDate"]} - #{i["endDate"]}}
"}.join("\n")}"
	}

	volunteer = {
		"md" => "
## Volunteer Work
#{resume["volunteer"].map{|i| 
"**#{i["position"]}** - *#{i["organization"]}*, #{i["startDate"]} - #{i["endDate"]}\n
#{i["highlights"].map{|h| "- #{h}"}.join("\n")}
"}.join("\n")}",
		"tex" => "
\\section*{Volunteer Work}
#{resume["volunteer"].map{|i| 
"
\\noindent
\\textbf{#{i["position"]}}
\\noindent
\\textit{#{i["organization"]}} \\hfill #{i["startDate"]} - #{i["endDate"]}
\\begin{itemize}
#{i["highlights"].map{|h| "\\item #{h}"}.join("\n")}
\\end{itemize}
"}.join("\n")}"
	}

	projects = {
		"md" => "
## Projects
#{resume["projects"].map{|i| 
"***[#{i["name"]}](#{i["url"]})***: #{i["description"]}  
**Keywords:** *#{i["keywords"].map{|k| "#{k}"}.join(", ")}*
"}.join("\n")}",
		"tex" => "
\\section*{Projects}
#{resume["projects"].map{|i| 
"
\\noindent
\\textbf{\\href{#{i["url"]}}{#{i["name"]}}}
#{i["description"]}
Keywords: #{i["keywords"].map{|k| "#{k}"}.join(", ")}
"}.join("\n")}"
	}

	interests = {
		"md" => "
## Research Interests
#{resume["interests"].map{|i| 
"**#{i["name"]}**  
**Keywords:** *#{i["keywords"].map{|k| "#{k}"}.join(", ")}*
"}.join("\n")}",
		"tex" => "
\\section*{Research Interests}
#{resume["interests"].map{|i| 
"
\\noindent
\\textbf{#{i["name"]}}
Keywords: #{i["keywords"].map{|k| "#{k}"}.join(", ")}
"}.join("\n")}"
	}

	certifications = {
		"md" => "
## Certifications
#{resume["certifications"].map{|i| 
"[**#{i["organization"]} #{i["title"]}**](#{i["url"]}) #{i["date"]}
"}.join("\n")}",
		"tex" => "
\\section*{Certifications}
#{resume["certifications"].map{|i| 
"
\\noindent
\\textbf{#{i["organization"]} \\href{#{i["url"]}}{#{i["title"]}}} \\hfill #{i["date"]}
"}.join("\n")}"
	}

	courses = {
		"md" => "
## Coursework
#{resume["courses"].map{|i| 
"**#{i["category"]}**  
**Courses:** *#{i["keywords"].map{|k| "#{k}"}.join(", ")}*
"}.join("\n")}",
		"tex" => "
\\section*{Coursework}
#{resume["courses"].map{|i| 
"
\\noindent
\\textbf{#{i["category"]}}
Keywords: #{i["keywords"].map{|k| "#{k}"}.join(", ")}
"}.join("\n")}"
	}
	
	outfile = case tag
		when "full" then "out/Full_Resume"
		when "data" then "out/Data_Resume"
		when "cv" then "out/CV"
		when "japanese" then "out/Japanese_Resume"
	end

	md_template = File.read("templates/md.erb.txt")
	md_out = ERB.new(md_template).result(binding)
	md_out = prep_md(md_out)

	File.open("#{outfile}.md", "w+").write(md_out)
	puts "#{outfile}.md written successfully"

	File.open("#{outfile}.odt", "w+").write(PandocRuby.new(md_out, :standalone).to_odt)
	puts "#{outfile}.odt written successfully"

	File.open("#{outfile}.docx", "w+").write(PandocRuby.new(md_out, :standalone).to_docx)
	puts "#{outfile}.docx written successfully"

	File.open("#{outfile}.html", "w+").write(PandocRuby.new(md_out, :standalone).to_html)
	puts "#{outfile}.html written successfully"

	tex_template = File.read("templates/tex.erb.txt")
	tex_out = ERB.new(tex_template).result(binding)
	tex_out = prep_tex(tex_out)

	File.open("#{outfile}.tex", "w+").write(tex_out)
	puts "#{outfile}.tex written successfully"

	system("xelatex -output-directory=out/ #{outfile}.tex")
	puts "#{outfile}.pdf written successfully"

end

