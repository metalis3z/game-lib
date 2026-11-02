repeat wait() until script.Parent.Parent:FindFirstChildOfClass("Humanoid")
local Humanoid = script.Parent.Parent:FindFirstChildOfClass("Humanoid")
local Animations = script.Parent:FindFirstChild("Animations")
local TweenService = game:GetService("TweenService")
local Info = TweenInfo.new(1.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local LightFade = TweenService:Create(script.Parent.Handle.PointLight,Info,{Brightness = 0})

local Equip = Humanoid:LoadAnimation(Animations.Equip)
local Idle = Humanoid:LoadAnimation(Animations.Idle)
local Shot = Humanoid:LoadAnimation(Animations.Shot)

local Shotted = false

script.Parent.Equipped:Connect(function()
	Idle:Play()
	Equip:Play()
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
	Equip:Stop()
end)

script.Parent.Handle.ParticleEmitter.Changed:Connect(function()
	if script.Parent.Handle.ParticleEmitter.Enabled == true then
		wait(0.07)
		script.Parent.Handle.ParticleEmitter.Enabled = false
	end
end)

script.Parent.Activated:Connect(function()
	if Shotted == false then
		Shotted = true
		Equip:Stop()
		Idle:Stop()
		Shot:Play()
		script.Parent.Handle.Shot:Play()
		script.Parent.Handle.Fire:Play()
		script.Parent.Handle.PointLight.Brightness = 1000
		script.Parent.Handle.ParticleEmitter.Enabled = true
		LightFade:Play()
		if (workspace:WaitForChild("The_Rake").Torso.Position - script.Parent.Part.Position).magnitude < 24 then
			workspace.The_Rake:FindFirstChild("NPC"):TakeDamage(250)
			workspace.The_Rake.Stunning.Value = 1
			workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 7
			workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 900
			workspace.The_Rake.Torso.Burn.Burning.Value = true
			workspace.The_Rake.Torso.Sizzle:Play()
			local bv = Instance.new("BodyVelocity")
			bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
			bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 32
			bv.Parent = workspace.The_Rake.HumanoidRootPart
			game:GetService("Debris"):AddItem(bv,0.1)
		end
		wait(4)
		local Drop = script.Parent.Handle:Clone()
		Drop.Parent = workspace
		Drop.Shot:Destroy()
		Drop.PointLight:Destroy()
		Drop.Name = "DroppedFlareGun"
		Drop.Decompose.Disabled = false
		script.Parent:Destroy()
	end
end)