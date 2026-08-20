import std/osproc
#  Point 1 Test: Catching Catchable Exceptions in Compound

try:
  echo "Attempting to throw and catch custom error..."
  raise newException(ValueError, "Custom User Error Triggered!")
except:
  echo "Caught error gracefully! Process continuing..."

echo "Execution resumed successfully after error recovery!"
