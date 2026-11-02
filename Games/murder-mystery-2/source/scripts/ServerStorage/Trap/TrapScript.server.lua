local TrapSystem = game.ReplicatedStorage.TrapSystem
local trigger = script.Parent.Trigger
local trap = script.Parent
local TrapSeconds = 4
local isTouched = false

trigger.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		if isTouched then return end;
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		
		if player and player.Name ~= trap.PlacedPlayer.Value then
			isTouched = true
			local HRP = player.Character:WaitForChild('HumanoidRootPart')
			if HRP then
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid.WalkSpeed = 0.01
					humanoid.JumpPower = 1
					HRP.Anchored = true
					--HRP.CFrame = trap.TrapVisual.CFrame
					TrapSystem.TrapTouch:FireClient(player, TrapSeconds)
					trigger.Sound:Play()
					trap.TrapVisual.Transparency = 1
					wait(TrapSeconds)
					humanoid.WalkSpeed = 16
					humanoid.JumpPower = 50
					HRP.Anchored = false
					trap:Destroy()
				end
			end
		end
	end
end)