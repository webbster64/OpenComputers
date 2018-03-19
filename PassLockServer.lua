term.clear()
term.setCursorPos(1,1)

--comfigs

--set modem side
rednet.open("top")
--set password here
passwordA = "penis"
passwordB = "gwarkill"
passwordC = "goodstuff"
passwordD = "564897"



-- System code
time = os.time()
time = textutils.formatTime(time, true)
 print("Server Ports open to Clients")
while true do
  id, input = rednet.receive()
  print("from: "..id.." input: "..input.." at: "..time)
  if input == passwordA or input == passwordB or input == passwordC or input == passwordD then
    rednet.send(id, "true")
  else
    rednet.send(id, "false")
  end
end
