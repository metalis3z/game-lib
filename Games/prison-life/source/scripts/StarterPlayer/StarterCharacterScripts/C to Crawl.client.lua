-- Credit AxiumDev for using this ! 
-- This is the v.0.1

--print("Crawl made by axiumdev")

repeat game:GetService("RunService").Stepped:Wait() until game.Players.LocalPlayer

local player = game.Players.LocalPlayer
local Crawl = false

local keyToCrawl = "c"

local mouse = player:GetMouse()

local AnimationId = "11275763829"

local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://"..AnimationId

local k = player.Character.Humanoid:LoadAnimation(Anim)
k:AdjustSpeed(10)

mouse.KeyDown:Connect(function(key)
	if key == keyToCrawl then
		if Crawl == false then
			Crawl = true
			player.Character.Humanoid:UnequipTools()
			game.StarterGui:SetCoreGuiEnabled("Backpack", false);
			player.Character.Humanoid.JumpPower = 0
			player.Character.Humanoid.WalkSpeed = 14
			k:Play()
		else
			Crawl = false
	
			game.StarterGui:SetCoreGuiEnabled("Backpack", true);
			player.Character.Humanoid.JumpPower = 50
			k:Stop()
		end
	end
end)

