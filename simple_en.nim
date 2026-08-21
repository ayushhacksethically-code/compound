when not defined(js):
  import std/[osproc, os]
#  Plain English Program for Non-Tech Beginners

create name = "Aman"
echo "Welcome to Compound Language,", name

create counter = 1
repeat while counter is less than or equal to 3:
  echo "Current Step:", counter
  var counter = counter + 1

proc add_numbers(a: int, b: int): int {.discardable.} =
  give back a + b

create total = add_numbers(50, 100)
echo "Total is:", total

if total is greater than 100:
  echo "Awesome! Total is large."
else:
  echo "Total is small."
