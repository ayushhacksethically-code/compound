import std/osproc
#  Phase 3 Test 3.2: Mini Lisp S-Expr AST Evaluator Benchmark

type LispExpr = object
  isNum: bool
  val: int
  op: string
  leftNum: int
  rightNum: int

proc evalLisp(e: LispExpr): int {.discardable.} =
  if e.isNum:
    return e.val
  else:
    if e.op == "+":
      return e.leftNum + e.rightNum
    elif e.op == "*":
      return e.leftNum * e.rightNum
    else:
      return 0

var addExpr = LispExpr(isNum: false, op: "+", leftNum: 10, rightNum: 20)
var mulExpr = LispExpr(isNum: false, op: "*", leftNum: 5, rightNum: 6)

echo "(+ 10 20) =>", evalLisp(addExpr)
echo "(* 5 6) =>", evalLisp(mulExpr)
