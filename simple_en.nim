#  Plain English Program for Non-Tech Beginners

var name = "Aman"
echo "Welcome to Compound Language,", name

var counter = 1
while counter <= 3:
  echo "Current Step:", counter
  counter = counter + 1

proc add_numbers(a: int, b: int): int {.discardable.} =
  return a + b

var total = add_numbers(50, 100)
echo "Total is:", total

if total > 100:
  echo "Awesome! Total is large."
else:
  echo "Total is small."
