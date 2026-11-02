repeat wait() until script.Parent.Parent:FindFirstChildOfClass("Humanoid")
local tool = script.Parent
local Humanoid = script.Parent.Parent:FindFirstChildOfClass("Humanoid")
local Animations = script.Parent:FindFirstChild("Animations")

local Equip = Humanoid:LoadAnimation(tool.Equip)
local Idle = Humanoid:LoadAnimation(tool.Idle)
local Shot = Humanoid:LoadAnimation(tool.Shot)

local Shotted = false
local idleCool = true
local debounce = false
local ammo = 10
local damage = 120

script.Parent.Equipped:Connect(function()
	Equip:Play()
	wait(0.1)
	Idle:Play()
	idleCool = false
end)

script.Parent.Unequipped:Connect(function()
	Equip:Stop()
	repeat wait() until idleCool == false
	Idle:Stop()
end)

script.Parent.Activated:Connect(function()
	if Shotted == false and ammo > 0 then
		Shotted = true
		ammo = ammo - 1
		Equip:Stop()
		Shot:Play()
		tool.Handle.Shot:Play()
		if (workspace:WaitForChild("The_Rake").Torso.Position - script.Parent.Part.Position).magnitude < 24 then
			workspace.The_Rake:FindFirstChild("NPC"):TakeDamage(damage)
			workspace.The_Rake.Stunning.Value = 1
			workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 1
			workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 90
			local newEmitter = tool.Handle.SplashEmitter:Clone()
			newEmitter.Parent = workspace.The_Rake:FindFirstChild("Head")
			local newSplash = tool.Handle.Splash:Clone()
			newSplash.Parent = workspace.The_Rake:FindFirstChild("Torso")
			newSplash.Playing = true
			game:GetService("Debris"):AddItem(newSplash,3)
			local bv = Instance.new("BodyVelocity")
			bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
			bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 12
			bv.Parent = workspace.The_Rake.HumanoidRootPart
			game:GetService("Debris"):AddItem(bv,0.1)
			newEmitter.Enabled = true
			game:GetService("Debris"):AddItem(newEmitter,2)
			wait(0.1)
			newEmitter.Enabled = false
			wait(0.4)
			Shotted = false
		end
	elseif ammo < 1 and debounce == false then
		debounce = true
		Idle:Stop()
		local Drop = script.Parent.Handle:Clone()
		Drop.Parent = workspace
		Drop.Name = "DroppedWaterGun"
		Drop.Decompose.Disabled = false
		script.Parent:Destroy()
	end
end)