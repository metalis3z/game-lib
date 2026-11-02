wait(0.1)
local m = script.Parent.Parent.Parent.SS.Motor

script.Parent.MouseClick:connect(function(p)
if m.DesiredAngle == 0 then
	m.DesiredAngle = .9
	script.Parent.Parent.DoorOpen:Play()
elseif m.DesiredAngle < .9 then
	m.DesiredAngle = 0
	while m.CurrentAngle > 0 do wait() end
	script.Parent.Parent.DoorClose:Play()
end
end)