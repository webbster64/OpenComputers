local pos = 12

mon = peripheral.wrap("bottom")
mon.clear()
mon.setBackgroundColor(32768)
mon.setTextColor(16384)
mon.setTextScale(5)

while true do

 if pos==-16 then
  pos = 12
 end
 
 mon.clear()
 mon.setCursorPos(pos,1)
 mon.write("Something")
 pos = pos-1
 
 os.sleep(0.15)
 
end
