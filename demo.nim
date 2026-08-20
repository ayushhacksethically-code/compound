#  Sample program in Compound (Hinglish)

var naam = "Dost"
echo "Namaste!", naam

var ginti = 1
while ginti <= 5:
  echo "Ginti number:", ginti
  ginti = ginti + 1

proc jod(a: int, b: int): int {.discardable.} =
  return a + b

var uttar = jod(20, 30)
echo "20 and 30 ka jod hai:", uttar

if uttar > 40:
  echo "Kamaal hai! Jod 40 se bada hai."
else:
  echo "Jod chhota hai."
