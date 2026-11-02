local l__TweenService__1 = game:GetService("TweenService");

while true do
	wait(4)
	script.Parent.CanTouch = true
end

script.Parent.Touched:Connect(function(v)
	local waie = math.random(3, 7)
	local player = game.Players:GetPlayerFromCharacter(v.Parent)
	local get = true
--	player.Character:SetAttribute("InDark", true)
	script.Parent.CanTouch = false
	wait(waie)
	game.ReplicatedStorage.Bricks.Screech:FireClient(player)
	script.Parent.CanTouch = true
	l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Ambient = Color3.new(0, 0, 0)
	}):Play();
end)

script.Parent.TouchEnded:Connect(function(v)
	local player = game.Players:GetPlayerFromCharacter(v.Parent)
	player.Character:SetAttribute("InDark", false)
	script.Parent.CanTouch = true
	l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Ambient = Color3.new(0.262745, 0.2, 0.219608)
	}):Play();
end)

--[[	l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Ambient = Color3.new(0.262745, 0.2, 0.219608)
	}):Play();]]