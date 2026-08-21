import std/osproc
#  Project 5: Static Site Deployer
proc deploy_site(src_dir: string, dest_dir: string) {.discardable.} =
  echo "Deploying static assets from " & src_dir & " to " & dest_dir
  discard execCmd("mkdir -p " & dest_dir)
  discard execCmd("cp -r " & src_dir & "/* " & dest_dir & "/")
  echo "Static site deployment complete."

deploy_site("/home/narayanas/projects/compound/docs/content", "/tmp/site_deploy")
