--Drone Remote Control Script Client

--local peripherals
local component = require("component")
local event = require("event")
local keyboard = require("keyboard")
--local modem = component.proxy(component.list("modem")())
--local InvC = component.proxy(component.list("inventory_controller")()) -- optionals 01
--local leach = component.proxy(component.list("leach")()) -- optionals 02



--command links
--Set port for drone client Here
local remoteport = 256


--modem setup ports
modem.open(remoteport)
modem.broadcast(remoteport, "drone=component.proxy(component.list('drone')())")

local keys = {
  [17] = "moveForward",
  [31] = "moveBack",
  [30] = "turnLeft",
  [32] = "turnRight",
  [42] = "moveDown",
  [57] = "moveUp",
  [46] = "changeColor",
  [18] = "OTSOS",
  [16] = "dropAll",
  [33] = "toggleLeash",
}

print("Welcome To Webbster64s RC Drone Programe ")
print("Key Bindings")
print("W = Forward")
print("S = Backwards ")
print("A = Strafe Left")
print("D = Strafe Right")
print("SPACE = Ascend")
print("SHIFT = Descend")
print("E = Grab From Inv")
print("F = toggles the Leash")
print("C = Change Colors")
print("scrolling = Alter Speed")
print("scrolling + ALT = Alter acceleration")
print(" Note ")
print(" Button E will force the drone to suck up the objects from the inventory under and above it ")
os.sleep(15:1)
term.clear()


while true do
  local e = {event.pull()}
  if e[1] == "key_down" then
    if keys[e[4]] then
      print("Command drones: " .. keys[e[4]])
      modem.broadcast(port, "ECSDrone", keys[e[4]])
    end
  elseif e[1] == "scroll" then
    if e[5] == 1 then
      if keyboard.isAltDown() then
        modem.broadcast(port, "ECSDrone", "accelerationUp")
        print("Command drones: accelerationUp")
      else
        modem.broadcast(port, "ECSDrone", "moveSpeedUp")
        print("Command drones: moveSpeedUp")
      end
    else
      if keyboard.isAltDown() then
        modem.broadcast(port, "ECSDrone", "accelerationDown")
        print("Command drones: accelerationDown")
      else
        modem.broadcast(port, "ECSDrone", "moveSpeedDown")
        print("Command drones: moveSpeedDown")
      end
    end
  elseif e[1] == "modem_message" then
    if e[6] == "ECSDrone" and e[7] == "DroneInfo" then
      print(" ")
      print("Speed of the drone: " .. tostring(e[8]))
      print("Acceleration of the drone: " .. tostring(e[9]))
      print("Drone direction: " .. tostring(e[10]))
      print(" ")
    end
  end
end

