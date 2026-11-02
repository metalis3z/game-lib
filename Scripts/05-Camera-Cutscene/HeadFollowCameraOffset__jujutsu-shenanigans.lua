-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: StarterPlayer/StarterPlayerScripts/CameraHeadLock.client.lua  (LocalScript, 28 lines)
-- What it does: Every frame tweens Humanoid.CameraOffset to the head's offset from the root, so the camera follows animations (punches, dodges) instead of staying on the root.

local plr = game.Players.LocalPlayer
local cam = workspace.CurrentCamera

local tween = game:GetService("TweenService")

plr.CharacterAdded:Connect(function(char)
	local hum = char:WaitForChild("Humanoid")
	local rootpart,head = char:WaitForChild("HumanoidRootPart"),char:WaitForChild("Head")
	local offset = CFrame.new()
	local camOrigin = cam.CFrame
	
	local Render
	
	Render = game:GetService("RunService").RenderStepped:Connect(function()
		local objectSpace = (rootpart.CFrame + Vector3.new(0, 1.5, 0)):ToObjectSpace(head.CFrame)
		
		if char then
			if char:GetAttribute("Ragdolled") == false then
				tween:Create(hum,TweenInfo.new(0.3),{CameraOffset = objectSpace.Position}):Play()
			elseif char:GetAttribute("Ragdolled") == true then
				tween:Create(hum,TweenInfo.new(0),{CameraOffset = Vector3.new(0,0,0)}):Play()
			end
		elseif not char or char.Parent == nil or not char:FindFirstChild("HumanoidRootPart") then
			Render:Disconnect()
		end
	end)
end)
