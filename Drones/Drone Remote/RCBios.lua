local d = component.proxy(component.list("drone")())
local t = component.proxy(component.list("tunnel")())
while true do
  local evt,_,sender,_,_,name,cmd,a,b,c = computer.pullSignal()
  if evt == "modem_message" and name == d.name() then
    if cmd == "gst" then
      t.send(d.name(),"gst",d.getStatusText())
    end
    if cmd == "sst" then
      t.send(d.name(),"sst",d.setStatusText(a))
    end
    if cmd == "mov" then
      d.move(a,b,c)
    end
    if cmd == "gos" then
      t.send(d.name(),"gos",d.getOffset())
    end
    if cmd == "gve" then
      t.send(d.name(),"gv",d.getVelocity())
    end
    if cmd == "gmv" then
      t.send(d.name(),"gmv",d.getMaxVelocity())
    end
    if cmd == "gac" then
      t.send(d.name(),"ga",d.getAcceleration())
    end
    if cmd == "sac" then
      d.setAcceleration(a)
    end
    if cmd == "glc" then
      t.send(d.name(),"glc",d.getLightColor())
    end
    if cmd == "slc" then
      d.setLightColor(a)
    end
    if cmd == "dct" then
      local b, s = d.detect(a)
      t.send(d.name(),"dct",b,s)
    end
    if cmd == "cmp" then
      t.send(d.name(),"c",d.compare(a))
    end
  end
end
