local Character = game.Players.LocalPlayer.Character

local l__TweenService__3 = game:GetService("TweenService");

while true do
	wait(0.5)
	
	if script.Parent.Parent:GetAttribute("ESPbright") == true then
		l__TweenService__3:Create(game.Lighting, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Ambient = Color3.fromRGB(255, 255, 255)
		}):Play();
	else
		if Character:GetAttribute("InDark") == true then
			l__TweenService__3:Create(game.Lighting, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Ambient = Color3.fromRGB(0, 0, 0)
			}):Play();
		else

			local v80

			if game.Players.LocalPlayer.PlayerStats.TypeRun.Value == "Hotel" then

				v80 = Color3.fromRGB(67, 51, 56);

			elseif game.Players.LocalPlayer.PlayerStats.TypeRun.Value == "Hunt" then

				v80 = Color3.fromRGB(27, 20, 11);

			elseif game.Players.LocalPlayer.PlayerStats.TypeRun.Value == "HuntExit" then

				v80 = Color3.fromRGB(67, 51, 56);

			end

			l__TweenService__3:Create(game.Lighting, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Ambient = v80
			}):Play();
		end
	end
end