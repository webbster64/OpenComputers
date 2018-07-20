local component = require("component")
local gpu = component.gpu
local term = require("term")
local unicode = require("unicode")
gpu.setResolution(40, 20)
local w, h = gpu.getResolution()
local loc = (w+2)
local string = "Sorry; this machine is out of order. Check back later."
::loop::
gpu.setBackground(0x0099FF)
gpu.setForeground(0xFFFFFF)
gpu.fill(1, 1, w, h, " ")
local loc = (loc-1)
term.setCursor(loc, 2)
print(string)
os.sleep(0.5)
if loc > ((unicode.len(string)*2)-0) then
  goto loop
else
  os.sleep(4)
  local loc = (w+2)
  goto loop
end
