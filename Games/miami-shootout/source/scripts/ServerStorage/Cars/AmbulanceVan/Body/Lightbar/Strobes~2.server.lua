model = script.Parent
wait(0.5)
currentP = "Off"
script.Parent.YelpEvent.OnServerEvent:Connect( function(player, pattern)
	if script.Parent.Yelp.Value == true then
		script.Parent.Yelp.Value = false
	else
		script.Parent.Yelp.Value = true
		script.Parent.Wail.Value = false
	end
end)