local F = {}
wait(0.5)

F.ToggleLights = function()
	if script.Parent.on.Value == true then
		script.Parent.on.Value = false
	else
		script.Parent.on.Value = true
	end
end

F.ToggleRise = function()
	if script.Parent.H1.part0.Motor.DesiredAngle == 0 then
		script.Parent.H1.part0.Motor.DesiredAngle = math.rad(-90)
		script.Parent.H2.part0.Motor.DesiredAngle = math.rad(90)
	else
		script.Parent.H1.part0.Motor.DesiredAngle = 0
		script.Parent.H2.part0.Motor.DesiredAngle = 0
	end
end

script.Parent.RemoteEvent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)
