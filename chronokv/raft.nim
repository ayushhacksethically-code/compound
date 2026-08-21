import std/osproc
#  ChronoKV Module 2: Raft Consensus Engine (Follower, Candidate, Leader)
import tables, random

var nodeState = "Follower"
var currentTerm = 1
var votedFor = ""
var leaderId = ""

proc process_heartbeat(leader_node_id: string, term: int) {.discardable.} =
  if term >= currentTerm:
    currentTerm = term
    leaderId = leader_node_id
    nodeState = "Follower"
    echo "[Raft Node] Received Heartbeat from Leader '" & leader_node_id & "' (Term: " & $currentTerm & ")"

proc start_election(node_id: string) {.discardable.} =
  nodeState = "Candidate"
  currentTerm += 1
  votedFor = node_id
  echo "[Raft Node] Heartbeat Timeout! Node '" & node_id & "' starting Election for Term " & $currentTerm
  nodeState = "Leader"
  leaderId = node_id
  echo "[Raft Node] Node '" & node_id & "' ELECTED LEADER for Term " & $currentTerm

#  Self Test
echo "[Raft Engine Self-Test] Initial State: Follower"
process_heartbeat("Node_A", 1)
start_election("Node_B")
