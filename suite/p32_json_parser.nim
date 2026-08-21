import std/osproc
#  Project 32: Custom JSON Stream Parser & Transformer
import json

var jsonText = """{"name": "Compound", "version": "1.0.0", "speed": "C-level"}"""
var parsed = parseJson(jsonText)

echo "Language Name: " & parsed["name"].getStr()
echo "Language Version: " & parsed["version"].getStr()
echo "Performance Target: " & parsed["speed"].getStr()
