local Buddy = script.Parent
local Humanoid = Buddy.Humanoid
local HumanoidRootPart = Buddy.HumanoidRootPart
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local OwnerCharacter = script.Pointer.Value
local Player = Players:GetPlayerFromCharacter(OwnerCharacter)

script.Jump.OnServerEvent:Connect(function(Player)
	if Player.Character == OwnerCharacter then
		task.wait(0.1)
		Humanoid.Jump = true
	end
end)

RunService.Stepped:Connect(function()
	pcall(function()
		if not Player then
			Buddy:Destroy()
			return
		end
		if not OwnerCharacter:FindFirstChild("HumanoidRootPart") then
			Buddy:Destroy()
		end
		if OwnerCharacter.Humanoid.Health < 1 then
			Buddy:Destroy()
		end
		--[[
		local Part = workspace:FindPartOnRay(Ray.new(HumanoidRootPart.Position, HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector - HumanoidRootPart.Position))
		if Part and not Part:IsDescendantOf(Buddy) and not Part:IsDescendantOf(OwnerCharacter) and Part.Transparency < 1 then
			Humanoid.Jump = true
		end
		local Part = workspace:FindPartOnRay(Ray.new(HumanoidRootPart.Position,(HumanoidRootPart.CFrame.LookVector * 2.8) + Vector3.new(0,-1.5,0)), OwnerCharacter)
		if (Part == nil) and (math.floor(math.abs(HumanoidRootPart.Velocity.Y)) < 1) then
			Humanoid.Jump = true
		end
		]]
		local Magnitude = (OwnerCharacter.HumanoidRootPart.Position - HumanoidRootPart.Position).magnitude
		if OwnerCharacter then
			if Magnitude > 3.4 then
				--print("move!")
				Humanoid:MoveTo(OwnerCharacter.HumanoidRootPart.Position + Vector3.new(0, 0, -1.8))
			elseif Magnitude > 21.5 then
				--print("move! 21.5")
				HumanoidRootPart.CFrame = OwnerCharacter.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
			end
		end
	end)
end)