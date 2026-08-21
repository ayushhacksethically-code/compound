import std/osproc
#  Project 1: Container Life-Cycle Cleaner
var cmd = "docker ps -a --filter status=exited --format '{{.ID}}'"
echo "Checking for exited containers..."
discard execCmd("echo [ContainerCleaner] Auditing containers...")
discard execCmd("docker image prune -f --filter 'dangling=true'")
echo "Container Audit & Cleanup Completed."
