
var name = "Compound English User"
echo "Hello!", name

var count = 1
while count <= 3:
  echo "Count number:", count
  count = count + 1

proc add(a: int, b: int): int {.discardable.} =
  return a + b

var total = add(10, 25)
echo "Total sum is:", total
