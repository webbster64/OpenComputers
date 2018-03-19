local t = require("component").tunnel --or modem if thats what you use
local event = require("event")
function doDrone(dronename,dronecommand,arg1,arg2,arg3)
  t.send(dronename,dronecommand,arg1,arg2,arg3)
  _, _, _, _, _, name, command, respond1, respond2 = event.pull("modem_message")
  return {name, command, respond1, respond2}
end
doDrone("DAVE","mov",0,3,0) --this would make it move up there blocks!
