--Drone Remote Control Script EEPROM


--local peripherals
local drone = component.proxy(component.list("drone")())
local modem = component.proxy(component.list("modem")())
local inventory = component.proxy(component.list("inventory_controller")())




--value link--
--Set port for drone Here--
local remoteport = 256
---------------------------
local moveSpeed = 1.0
local direction = 0
local acceleration = 0.5

local autoDrop = true
local leashed = false

--modem setup ports
modem.open(remoteport)



local function move(forward)
  if direction == 0 then
      drone.move(1 * forward, 0, 0)
  elseif direction == 1 then
    drone.move(0, 0, 1 * forward)
  elseif direction == 2 then
    drone.move(-1 * forward, 0, 0)
  else
    drone.move(0, 0, -1 * forward)
  end
end


--Preflight Checks
drone.setStatusText("Checks")
os.sleep(15:1)
--movement
drone.move(0, 1, 0) -- move one block up
drone.move(0, -1, 0) -- move one block down
drone.move(0, 0, 1) -- move one block North
drone.move(0, 0, -1) -- move one block South
drone.move(-1, 0, 0) -- move one block West
drone.move(1, 0, 0) -- move one block East
os.sleep(15:1)




--System Status
drone.setStatusText("Linked !")


-- LCD Reporting


local function printSpeed()
  drone.setStatusText("SPD " .. tostring(moveSpeed))
end

local function printDirection()
  drone.setStatusText("DIR " .. tostring(direction))
end

local function printAcceleration()
  drone.setStatusText("ACC " .. tostring(acceleration))
end


-- Remote Reporting
local function sendInfo()
  modem.broadcast(port, "ECSDrone", "DroneInfo", moveSpeed, acceleration, direction)
end

while true do
  local e = { computer.pullSignal() }
  if e[1] == "modem_message" then
    if e[4] == port then
      if e[6] == "ECSDrone" then
        drone.setStatusText(e[7])
        if e[7] == "moveUp" then
          drone.move(0, moveSpeed, 0)
        elseif e[7] == "moveDown" then
          drone.move(0, -moveSpeed, 0)
        elseif e[7] == "moveForward" then
          move(1)
        elseif e[7] == "moveBack" then
          move(-1)
        elseif e[7] == "turnLeft" then
          direction = direction - 1
          if direction < 0 then direction = 3 end
          printDirection()
          sendInfo()
        elseif e[7] == "turnRight" then
          direction = direction + 1
          if direction > 3 then direction = 0 end
          printDirection()
          sendInfo()
        elseif e[7] == "changeColor" then
          drone.setLightColor(math.random(0x0, 0xFFFFFF))
        elseif e[7] == "OTSOS" then
          for i = 1, (inventory.getInventorySize(0) or 1) do
            inventory.suckFromSlot(0, i)
          end
          drone.setStatusText("Pulled")
        elseif e[7] == "swing" then
          drone.swing(0)
        elseif e[7] == "dropAll" then
          dropAll()
        elseif e[7] == "changeAutoDrop" then
          changeAutoDrop = not changeAutoDrop
          drone.setStatusText("DROP: " .. tostring(changeAutoDrop))
        elseif e[7] == "moveSpeedUp" then
          moveSpeed = moveSpeed + 0.1
          if moveSpeed >= 8 then moveSpeed = 8 end
          printSpeed()
          sendInfo()
        elseif e[7] == "moveSpeedDown" then
          moveSpeed = moveSpeed - 0.1
          if moveSpeed <= 0.1 then moveSpeed = 0.1 end
          printSpeed()
          sendInfo()
        elseif e[7] == "accelerationUp" then
          acceleration = acceleration + 0.1
          if acceleration >= 5 then acceleration = 5 end
          drone.setAcceleration(acceleration)
          printAcceleration()
          sendInfo()
        elseif e[7] == "accelerationDown" then
          acceleration = acceleration - 0.1
          if acceleration <= 0.1 then acceleration = 0.1 end
          drone.setAcceleration(acceleration)
          printAcceleration()
          sendInfo()
        elseif e[7] == "toggleLeash" then
          if leashed then
            component.proxy(component.list("leash")()).unleash()
            leashed = false
          else 
            component.proxy(component.list("leash")()).leash(suckSide)
            leashed = true
          end
        end
      end
    end
  end
end
