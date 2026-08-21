import std/osproc
#  Project 10: Environment Parity Verifier
import os

proc audit_env_var(var_name: string) {.discardable.} =
  var val = getEnv(var_name)
  if val.len > 0:
    echo "Env Var " & var_name & " is SET: " & val
  else:
    echo "Env Var " & var_name & " is MISSING"

audit_env_var("PATH")
audit_env_var("USER")
audit_env_var("PRODUCTION_SECRET")
