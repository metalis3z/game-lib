model = script.Parent
wait(0.5)
currentP = "Off"
script.Parent.TDEvent.OnServerEvent:Connect( function(player, pattern)
	if script.Parent.TD.Value == 0 then
		script.Parent.TD.Value = 1
	elseif script.Parent.TD.Value == 1 then
		script.Parent.TD.Value = 2
	elseif script.Parent.TD.Value == 2 then
		script.Parent.TD.Value = 3
	elseif script.Parent.TD.Value == 3 then
		script.Parent.TD.Value = 0
	end
end)