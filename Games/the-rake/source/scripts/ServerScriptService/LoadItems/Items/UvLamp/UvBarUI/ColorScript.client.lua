while true do
	wait()
	if game.Players.LocalPlayer.Character.UvLamp.Power.Value == 0 then
		script.Parent.Frame.Battery.Bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	elseif 	game.Players.LocalPlayer.Character.UvLamp.Power.Value == 200 then
		script.Parent.Frame.Battery.Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	end
end