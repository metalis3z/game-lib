model = script.Parent
wait(0.5)
currentP = "Off"
script.Parent.WailEvent.OnServerEvent:Connect( function(player, pattern)
	if script.Parent.Wail.Value == true then
		script.Parent.Wail.Value = false
	else
		script.Parent.Wail.Value = true
		script.Parent.Yelp.Value = false
	end
end)