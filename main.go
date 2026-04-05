// -*- coding: utf-8 -*-

// Created on Sun Mar 22 09:13:14 PM EDT 2026
// author: Ryan Hildebrandt, github.com/ryancahildebrandt

package main

import (
	"bufio"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
	"text/template"
)

func main() {
	var tag string
	var err error

	fmt.Print("tag [*full*|data|japanese|cv|all]: ")
	fmt.Scanln(&tag)

	switch tag {
	case "all":
		err = renderResume("full")
		err = renderResume("data")
		err = renderResume("cv")
		err = renderResume("japanese")
	case "":
		tag = "full"
		err = renderResume(tag)
	default:
		err = renderResume(tag)
	}
	if err != nil {
		log.Fatal(err)
	}
}

func renderResume(tag string) error {
	var (
		outfile string
		err     error
		resume  Resume
		buf     []byte
	)

	switch tag {
	case "full":
		outfile = "out/Full_Resume"
	case "data":
		outfile = "out/Data_Resume"
	case "cv":
		outfile = "out/CV"
	case "japanese":
		outfile = "out/Japanese_Resume"
	default:
		return errors.New("unrecognized tag")
	}

	// read resume
	buf, err = os.ReadFile("resume.json")
	if err != nil {
		return err
	}
	err = json.Unmarshal(buf, &resume)
	if err != nil {
		return err
	}
	resume = resume.filterByTag(tag)

	// md, odt, docx, html
	err = processTemplate(resume, outfile, "md")
	if err != nil {
		return err
	}
	log.Printf("%s.md written successfully", outfile)

	err = pandocConvert(outfile, "md", "odt")
	if err != nil {
		return err
	}
	log.Printf("%s.odt written successfully", outfile)

	err = pandocConvert(outfile, "md", "docx")
	if err != nil {
		return err
	}
	log.Printf("%s.docx written successfully", outfile)

	err = pandocConvert(outfile, "md", "html")
	if err != nil {
		return err
	}
	log.Printf("%s.html written successfully", outfile)

	// tex, pdf
	err = processTemplate(resume, outfile, "tex")
	if err != nil {
		return err
	}
	log.Printf("%s.tex written successfully", outfile)

	err = pandocConvert(outfile, "tex", "pdf")
	if err != nil {
		return err
	}
	log.Printf("%s.pdf written successfully", outfile)

	return nil
}

func pandocConvert(basename string, from string, to string) error {
	var (
		sourceFile = fmt.Sprintf("%s.%s", basename, from)
		targetFile = fmt.Sprintf("%s.%s", basename, to)
		cmd        = exec.Command("pandoc", "--verbose", sourceFile, "-o", targetFile)
	)

	if to == "pdf" {
		cmd = exec.Command("xelatex", "-output-directory=out/", sourceFile)
	}

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()

	return err
}

func processTemplate(resume Resume, outfile string, ext string) error {
	var (
		templateFiles = fmt.Sprintf("./templates/*.%s.tmpl", ext)
		renderedFile  = fmt.Sprintf("%s.%s", outfile, ext)
		funcMap       = template.FuncMap{
			"strings_join": strings.Join,
			"tex_sanitize": func(in string) string {
				out := in
				out = strings.ReplaceAll(out, "&", "\\&")
				out = strings.ReplaceAll(out, "_", "\\_")
				return out
			},
		}
	)

	tmpl, err := template.New("main").Funcs(funcMap).ParseGlob(templateFiles)
	if err != nil {
		return err
	}

	f, err := os.OpenFile(renderedFile, os.O_CREATE|os.O_WRONLY|os.O_TRUNC, 0644)
	if err != nil {
		return err
	}

	w := bufio.NewWriter(f)
	err = tmpl.ExecuteTemplate(w, "main", resume)
	if err != nil {
		return err
	}

	err = w.Flush()

	return err
}
