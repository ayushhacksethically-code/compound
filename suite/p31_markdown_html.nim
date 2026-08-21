import std/osproc
#  Project 31: Self-Hosted Markdown to HTML Converter
import strutils

proc md_to_html(line: string) {.discardable.} =
  var res = line
  if res.startsWith("# "):
    res = "<h1>" & res.substr(2) & "</h1>"
  elif res.startsWith("## "):
    res = "<h2>" & res.substr(3) & "</h2>"
  else:
    res = "<p>" & res & "</p>"
  echo res

md_to_html("# Compound Language Docs")
md_to_html("## High Performance Transpilation")
md_to_html("Written in Nim and Hinglish.")
