
repeat wait() until game.Players.LocalPlayer.Character.Humanoid

local equip = false
local using = false

script.Parent.Animation2.AnimationId = "rbxassetid://12003894101"
script.Parent.Animation.AnimationId = "rbxassetid://12003895785"

local idle = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Animation)
local idle2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Animation2)

script.Parent.Parent.Equipped:Connect(function()
	
	idle:Play()
	equip = true
end)


script.Parent.Parent.Unequipped:Connect(function()
	idle:Stop()
	equip = false
end)


script.Parent.Parent.Activated:Connect(function()
	if equip and not using then
		using = true
		idle2:Play()
		
		script.Parent.RemoteEvent:FireServer()
		wait(1.5)
		using = false
	end
end)