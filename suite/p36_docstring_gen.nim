import std/osproc
#  Project 36: Docstring Generator (hg doc)
import strutils

proc extract_doc(signature: string, doc: string) {.discardable.} =
  echo "<div class='doc-item'><code>" & signature & "</code><p>" & doc & "</p></div>"

extract_doc("proc translateHinglishLine*(line: string): string", "Translates a single line of Hinglish source to Nim AST.")
