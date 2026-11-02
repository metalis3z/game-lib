local tool = script.Parent.Parent
local event = script.Parent:WaitForChild("PepperSprayEvent")

event.OnServerEvent:connect(function(plr,event,arg1,arg2,arg3)
	if event == "Button1Down" then
		tool.Spray.Transparency = 1
		tool.Spray.Script.Disabled = false
		tool.Nossle.Spray.Enabled = true
	elseif event == "Button1Up" then
		tool.Spray.Transparency = 1
		tool.Spray.Script.Disabled = true
		tool.Nossle.Spray.Enabled = false
	end
end)