#  Hinglish Interactive Calculator in Compound

proc jod(a: float, b: float): float {.discardable.} =
  return a + b

proc ghatao(a: float, b: float): float {.discardable.} =
  return a - b

proc guna(a: float, b: float): float {.discardable.} =
  return a * b

echo "=== Compound Calculator ==="
echo "10 and 5 ka jod:", jod(10.0, 5.0)
echo "10 mein se 5 ghatao:", ghatao(10.0, 5.0)
echo "10 ko 5 se guna karo:", guna(10.0, 5.0)
