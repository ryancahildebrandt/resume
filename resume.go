// -*- coding: utf-8 -*-

// Created on Sun Mar 22 09:31:39 PM EDT 2026
// author: Ryan Hildebrandt, github.com/ryancahildebrandt

package main

import (
	"slices"
)

type Resume struct {
	Basics struct {
		Email    string `json:"email"`
		Label    string `json:"label"`
		Location struct {
			Address     string `json:"address"`
			City        string `json:"city"`
			CountryCode string `json:"countryCode"`
			PostalCode  string `json:"postalCode"`
			Region      string `json:"region"`
		} `json:"location"`
		Name     string `json:"name"`
		Phone    string `json:"phone"`
		Picture  string `json:"picture"`
		Profiles []struct {
			Network  string `json:"network"`
			URL      string `json:"url"`
			Username string `json:"username"`
		} `json:"profiles"`
		Summary string   `json:"summary"`
		Tags    []string `json:"tags"`
		Website string   `json:"website"`
	} `json:"basics"`
	Certifications []struct {
		Date         string   `json:"date"`
		Organization string   `json:"organization"`
		Tags         []string `json:"tags"`
		Title        string   `json:"title"`
		URL          string   `json:"url"`
	} `json:"certifications"`
	Courses []struct {
		Category string   `json:"category"`
		Keywords []string `json:"keywords"`
		Tags     []string `json:"tags"`
	} `json:"courses"`
	Education []struct {
		Area        string   `json:"area"`
		Courses     []string `json:"courses"`
		EndDate     string   `json:"endDate"`
		Gpa         string   `json:"gpa"`
		Institution string   `json:"institution"`
		StartDate   string   `json:"startDate"`
		StudyType   string   `json:"studyType"`
		Tags        []string `json:"tags"`
	} `json:"education"`
	Interests []struct {
		Keywords []string `json:"keywords"`
		Name     string   `json:"name"`
		Summary  string   `json:"summary"`
		Tags     []string `json:"tags"`
	} `json:"interests"`
	Languages []struct {
		Language string `json:"language"`
		Level    string `json:"level"`
		Skills   []struct {
			Level string `json:"level"`
			Name  string `json:"name"`
		} `json:"skills"`
		Tags []string `json:"tags"`
	} `json:"languages"`
	Projects []struct {
		Description string   `json:"description"`
		Highlights  []any    `json:"highlights"`
		Keywords    []string `json:"keywords"`
		Name        string   `json:"name"`
		Roles       []any    `json:"roles"`
		Tags        []string `json:"tags"`
		URL         string   `json:"url"`
	} `json:"projects"`
	Publications []struct {
		Authors     string   `json:"authors"`
		Name        string   `json:"name"`
		Publisher   string   `json:"publisher"`
		ReleaseDate string   `json:"releaseDate"`
		Summary     string   `json:"summary"`
		Tags        []string `json:"tags"`
		Website     string   `json:"website"`
	} `json:"publications"`
	Research []struct {
		Highlights  []string `json:"highlights"`
		Institution string   `json:"institution"`
		Tags        []string `json:"tags"`
		Title       string   `json:"title"`
		Type        string   `json:"type"`
	} `json:"research"`
	Skills []struct {
		Keywords []string `json:"keywords"`
		Level    string   `json:"level"`
		Name     string   `json:"name"`
		Tags     []string `json:"tags"`
	} `json:"skills"`
	Volunteer []struct {
		EndDate      string   `json:"endDate"`
		Highlights   []string `json:"highlights"`
		Organization string   `json:"organization"`
		Position     string   `json:"position"`
		StartDate    string   `json:"startDate"`
		Summary      string   `json:"summary"`
		Tags         []string `json:"tags"`
		Website      string   `json:"website"`
	} `json:"volunteer"`
	Work []struct {
		Company    string   `json:"company"`
		EndDate    string   `json:"endDate"`
		Highlights []string `json:"highlights"`
		Position   string   `json:"position"`
		StartDate  string   `json:"startDate"`
		Summary    string   `json:"summary"`
		Tags       []string `json:"tags"`
		Website    string   `json:"website"`
	} `json:"work"`
}

func (r Resume) filterByTag(tag string) Resume {
	out := Resume{}
	out.Basics = r.Basics
	for _, entry := range r.Certifications {
		if slices.Contains(entry.Tags, tag) {
			out.Certifications = append(out.Certifications, entry)
		}
	}
	for _, entry := range r.Courses {
		if slices.Contains(entry.Tags, tag) {
			out.Courses = append(out.Courses, entry)
		}
	}
	for _, entry := range r.Education {
		if slices.Contains(entry.Tags, tag) {
			out.Education = append(out.Education, entry)
		}
	}
	for _, entry := range r.Interests {
		if slices.Contains(entry.Tags, tag) {
			out.Interests = append(out.Interests, entry)
		}
	}
	for _, entry := range r.Languages {
		if slices.Contains(entry.Tags, tag) {
			out.Languages = append(out.Languages, entry)
		}
	}
	for _, entry := range r.Projects {
		if slices.Contains(entry.Tags, tag) {
			out.Projects = append(out.Projects, entry)
		}
	}
	for _, entry := range r.Publications {
		if slices.Contains(entry.Tags, tag) {
			out.Publications = append(out.Publications, entry)
		}
	}
	for _, entry := range r.Research {
		if slices.Contains(entry.Tags, tag) {
			out.Research = append(out.Research, entry)
		}
	}
	for _, entry := range r.Skills {
		if slices.Contains(entry.Tags, tag) {
			out.Skills = append(out.Skills, entry)
		}
	}
	for _, entry := range r.Volunteer {
		if slices.Contains(entry.Tags, tag) {
			out.Volunteer = append(out.Volunteer, entry)
		}
	}
	for _, entry := range r.Work {
		if slices.Contains(entry.Tags, tag) {
			out.Work = append(out.Work, entry)
		}
	}
	return out
}
