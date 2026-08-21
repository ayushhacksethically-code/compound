import std/osproc
#  Project 6: Blue-Green Deployment Orchestrator
proc swap_deployment(active_color: string) {.discardable.} =
  echo "Switching active traffic target to: " & active_color
  discard execCmd("ln -sfn /var/www/" & active_color & " /var/www/active")
  echo "Traffic target updated successfully."

swap_deployment("green")
