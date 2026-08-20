#  Operators and Lexical symbols test in Compound

var a = 10
var b = 3

a += 5
echo "a += 5 ->", a

var c = a div b
echo "a div b (integer division) ->", c

var d = a mod b
echo "a mod b (modulo) ->", d

var bitwise = 1 shl 3
echo "1 shl 3 (left shift) ->", bitwise
