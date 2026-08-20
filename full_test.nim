#  Testing complete keyword suite & C FFI ecosystem in Compound (.hg)

#  1. Shamil karo (Importing Nim/C standard libraries)
import os
import strutils

#  2. C FFI Binding: Directly calling C stdio `puts` function from C library
proc puts(s: cstring): cint {.importc, header: "stdio.h", discardable.}

puts("Namaste C Ecosystem se! Directly calling C stdio puts()")

#  3. Constant and Data Type creation
const DUNIYA = "Compound World"
type User = object
  naam: string
  umar: int

#  4. Loops & Iteration
echo "--- Loop test ---"
var list_items = @["Aap", "Sabka", "Swagat", "Hai"]
for cheez in list_items:
  echo "Item:", cheez

#  5. Try - Except - Finally (Error handling)
echo "--- Error handling test ---"
try:
  echo "Koshish kar rahe hain..."
  #  galti_phenko "Kuch gadbad ho gayi"
except:
  echo "Galti pakad li!"
finally:
  echo "Hamesha chalne wala code (Finally block)"

#  6. Case / Switch pattern matching
var din = 1
case din:
of 1:
  echo "Somvaar"
of 2:
  echo "Mangalvaar"
else:
  echo "Koyi and din"
