#  Constants test in Compound (.hg)

echo "Sahi (True):", true
echo "Galat (False):", false
echo "Debug Mode (jaanch_mode):", not defined(release)

proc test_placeholder() {.discardable.} =
  discard

test_placeholder()
echo "Done checking built-in constants!"
