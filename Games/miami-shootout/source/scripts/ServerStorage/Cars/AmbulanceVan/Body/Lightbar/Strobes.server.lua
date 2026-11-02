model = script.Parent
wait(0.5)
currentP = "Off"
script.Parent.RemoteEvent.OnServerEvent:Connect( function(player, pattern)
	if script.Parent.on.Value == true then
		script.Parent.on.Value = false
	else
		script.Parent.on.Value = true
	end
end)