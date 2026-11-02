local Event = script.Parent:WaitForChild("Activated")
local ts = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local Tool = script.Parent
local MeteorExplosion = script.Parent:WaitForChild("Explosion")
local SnapAnimation = script.Parent:WaitForChild("Snap")
local SnapSound = script.Parent:WaitForChild("Summon")
local FallSound = script.Parent:WaitForChild("Falling")

local function SummonMeteor(Location)
	local HitLocationPart = Instance.new("Part",workspace)
	HitLocationPart.CastShadow = false
	HitLocationPart.Shape = Enum.PartType.Cylinder
	HitLocationPart.Material = Enum.Material.Neon
	HitLocationPart.Anchored = true
	HitLocationPart.CanCollide = false
	HitLocationPart.Transparency = 0.6
	HitLocationPart.Color = Color3.new(1, 0.227451, 0.227451)
	HitLocationPart.Orientation = Vector3.new(0,0,90)
	HitLocationPart.Position = Location.Position
	HitLocationPart.Size = Vector3.new(2,0.001,0.001)
	ts:Create(HitLocationPart,TweenInfo.new(0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Size = Vector3.new(0.001,50,50)}):Play()
	ts:Create(HitLocationPart,TweenInfo.new(0.5),{Transparency = 0.8}):Play()
	
	local Meteor = Instance.new("Part",workspace)
	local fire = Instance.new("Fire",Meteor)
	local smoke = Instance.new("Smoke",Meteor)
	local FallSoundClone = FallSound:Clone()
	FallSoundClone.Parent = Meteor
	FallSoundClone:Play()
	local MeteorExplosionClone = MeteorExplosion:Clone()
	smoke.TimeScale = 5
	smoke.RiseVelocity = 5
	fire.Size = 20
	fire.Heat = 0
	fire.TimeScale = 1.5
	MeteorExplosionClone.PlayOnRemove = true
	MeteorExplosionClone.Parent = Meteor
	Meteor.CanCollide = false
	Meteor.Anchored = true
	Meteor.Color = Color3.new(0.313725, 0.262745, 0.262745)
	Meteor.Shape = Enum.PartType.Ball
	Meteor.Material = Enum.Material.Slate
	Meteor.Size = Vector3.new(0.001, 0.001, 0.001)
	Meteor.Position = Location.Position + Vector3.new(math.random(-250,250),600,math.random(-250,250))
	
	Meteor.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") then
			hit.Parent:FindFirstChild("Humanoid"):TakeDamage(999999999999)
		end
	end)
	
	ts:Create(Meteor,TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.In),{Size = Vector3.new(20, 20, 20)}):Play()
	local MeteorFall = ts:Create(Meteor,TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.In),{Position = Location.Position + Vector3.new(0,Meteor.Size.Y / 2,0)})
	MeteorFall:Play()
	
	MeteorFall.Completed:Connect(function()
		for i = 10, 0, -1 do
			local MeteorDebris = Instance.new("Part",workspace)
			local DebrisFire = Instance.new("Fire",MeteorDebris)
			local DebrisSmoke = Instance.new("Smoke",MeteorDebris)
			DebrisSmoke.RiseVelocity = 5
			DebrisSmoke.Size = 0.1
			DebrisSmoke.TimeScale = 5
			DebrisFire.Size = 7.5
			DebrisFire.TimeScale = 1.5
			DebrisFire.Heat = 0
			MeteorDebris.Size = Vector3.new(math.random(2,5),math.random(2,5),math.random(2,5))
			MeteorDebris.Color = Color3.new(0.313725, 0.262745, 0.262745)
			MeteorDebris.Material = Enum.Material.Slate
			MeteorDebris.Position = Meteor.Position + Vector3.new(math.random(1,5),math.random(1,5),math.random(1,5))
			MeteorDebris.AssemblyLinearVelocity = Vector3.new(math.random(-80,80),math.random(40,80),math.random(-80,80))
			Debris:AddItem(MeteorDebris)
		end
		
		local Explosion = Instance.new("Explosion",workspace)
		Explosion.Position = Location.Position
		Explosion.BlastRadius = 30
		HitLocationPart:Destroy()
		Meteor:Destroy()
	end)
end

Event.OnServerEvent:Connect(function(plr, SpawnPlace)
	local character = plr.Character or plr.CharacterAdded:Wait()
	local humanoid = character:FindFirstChild("Humanoid")
	local Animation = humanoid:LoadAnimation(SnapAnimation)
	local SnapClone = SnapSound:Clone()
	SnapClone.PlayOnRemove = true
	SnapClone.Parent = character:FindFirstChild("Right Arm")
	Animation:Play()
	wait(0.6)
	SnapClone:Destroy()
	SummonMeteor(SpawnPlace)
end)