import std/osproc
#  Module A Main script importing Module B

import module_b

echo "Calling imported helper function from module_b..."
var res = helperFunc(5)
echo "Result from module_b helperFunc(5):", res
