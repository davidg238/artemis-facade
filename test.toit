import host.pipe show *

INHERIT ::= PIPE-INHERITED

invoke command args -> string:
  complete-args := [command] + args
  output := OpenPipe false
  stdout := output.fd
  pipes := fork 
    true  // use path
    INHERIT 
    stdout 
    INHERIT 
    command
    complete-args

  return output.read.to-string.trim  

main args:
  print "Version: $(invoke "artemis" ["version"])"
  print "Org: $(invoke "artemis" ["org", "list", "--output-format=json"])"
  print "Org default: $(invoke "artemis" ["org", "default", "--output-format=json"])"
  print "Org members: $(invoke "artemis" ["org", "members", "list", "--output-format=json"])"
  print "Default device: $(invoke "artemis" ["device", "default", "--fleet-root=../home", "--output-format=json"])"
  // print "Default device status: $(invoke "artemis" ["device", "show", "--fleet-root=../home", "--output-format=json"])"

  print "Fleet status: $(invoke "artemis" ["fleet", "status", "--fleet-root=../home", "--output-format=json"])"
  print "Fleet groups: $(invoke "artemis" ["fleet", "group", "list", "--fleet-root=../home", "--output-format=json"])"


  /*
  toit-run := args[0]
  run-program toit-run "artemis" ["org", "list"] // , "--output-format=json"]
  */