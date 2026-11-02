local plr = game.Players.LocalPlayer
local tool = script.Parent
local char = plr.Character or plr.CharacterAdded:wait()

local Cooldown = false
script.Parent.Equipped:Connect(function(Mouse)
	local animation = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent["Animation 2"])
	animation:Play()
	Mouse.Button1Down:Connect(function()
		if Cooldown then return end
		Cooldown = true
		local animation = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Animation)
		animation:Play()
		
		local sound = script.Parent.Sound
		wait(0.5)
		sound:Play()
		task.wait(1.1)
		Cooldown = false
	end)
	tool.Unequipped:connect(function()
		local hum = char:WaitForChild("Humanoid")
		for _,anim in pairs(hum:GetPlayingAnimationTracks()) do
			animation:Stop()
		end
	end)
end)