os.pullEvent = os.pullEventRaw
term.clear()
term.setCursorPos(1,1)

--configs

--set custom password here
password = "SpecterNetworks01"
--set redstone side here
rsSide = "left"
-- set System Admin password here
SystemAdmin = "RootAdmin"

door = open


--System Code
while true do

  if door == "close" then
    redstone.setOutput(rsSide, false)
  end
  write("Password: ")
  input = read("*")
  if input == password then
    redstone.setOutput(rsSide, true)
    write("welcome: please type close. ")
	door = io.read()
  elseif password == SystemAdmin then
    print ("system admin over write")
    break
  else print ("Access Denied")
  os.sleep(1)
  end
term.clear()
term.setCursorPos(1,1)
end
