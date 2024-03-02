#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#Created on Sat Feb 10 01:30:07 PM EST 2024 
#author: Ryan Hildebrandt, github.com/ryancahildebrandt

# imports
require_relative "utils"

puts "tag name [*full*|data|japanese|cv|all]:"
tag = gets.chomp

if tag == "all"
	process_single_resume("full")
	process_single_resume("data")
	process_single_resume("cv")
	process_single_resume("japanese")
elsif tag == ""
	tag = "full"
	process_single_resume(tag)
else
	process_single_resume(tag)
end
