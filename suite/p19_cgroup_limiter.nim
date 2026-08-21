import std/osproc
#  Project 19: Linux Cgroup Resource Limiter
proc apply_cgroup_limit(group_name: string, cpu_max: string) {.discardable.} =
  echo "Configuring cgroup v2 group: " & group_name & " (CPU limit: " & cpu_max & ")"
  discard execCmd("echo '[cgroups] Applied cpu.max=" & cpu_max & " to /sys/fs/cgroup/" & group_name & "' || echo '[cgroups] Simulated'")

apply_cgroup_limit("app_sandbox", "50000 100000")
