local tool = script.Parent
local remote = tool:FindFirstChild("Remote")
local firePart = tool:FindFirstChild("FirePart")
local handle = tool:FindFirstChild("Handle")
local equipSound = handle and handle:FindFirstChild("Equip")
local fireSound = handle and handle:FindFirstChild("Fire")

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local debounce = false
local fireDelay = 0.05

-- Sword logic variables
local DamageValues = { BaseDamage = 5, SlashDamage = 10, LungeDamage = 30 }
local Damage = DamageValues.BaseDamage
local Sounds = {
	Slash = handle and handle:FindFirstChild("SwordSlash"),
	Lunge = handle and handle:FindFirstChild("SwordLunge"),
	Unsheath = handle and handle:FindFirstChild("Unsheath")
}
local ToolEquipped = false
local LastAttack = 0

-- Helper functions for tagging
local function TagHumanoid(humanoid, player)
	local tag = Instance.new("ObjectValue")
	tag.Name = "creator"
	tag.Value = player
	Debris:AddItem(tag, 2)
	tag.Parent = humanoid
end

local function UntagHumanoid(humanoid)
	for _, v in humanoid:GetChildren() do
		if v:IsA("ObjectValue") and v.Name == "creator" then
			v:Destroy()
		end
	end
end

local function CheckIfAlive()
	return (Player and Player.Parent and Character and Character.Parent and Humanoid and Humanoid.Parent and Humanoid.Health > 0 and Torso and Torso.Parent)
end

-- Bullet visual
local function createBullet(origin, hitPos)
	local bullet = Instance.new("Part")
	bullet.Name = "Bullet"
	bullet.Color = Color3.fromRGB(255, 170, 0)
	bullet.Material = Enum.Material.Neon
	bullet.CanCollide = false
	bullet.Anchored = true
	bullet.Transparency = 0
	local distance = (origin - hitPos).Magnitude
	bullet.CFrame = CFrame.lookAt(origin, hitPos) * CFrame.new(0, 0, -distance / 2)
	bullet.Size = Vector3.new(0.1, 0.1, distance)
	bullet.Parent = workspace
	task.spawn(function()
		task.wait(0.1)
		bullet.Transparency = 1
		task.wait(0.2)
		bullet:Destroy()
	end)
end

-- Gun logic: Only damage Humanoids named "Zombie" and tag them
remote.OnServerEvent:Connect(function(plr, hitPos)
	if debounce or tool.Parent ~= plr.Character then return end
	debounce = true
	if firePart and firePart:FindFirstChildOfClass("ParticleEmitter") then
		firePart.ParticleEmitter.Enabled = true
	end
	if fireSound then
		local sound = fireSound:Clone()
		sound.Parent = handle
		sound.PlayOnRemove = true
		sound:Destroy()
	end
	local origin = firePart and firePart.Position or tool.Position
	local direction = (hitPos - origin).Unit * 1000
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {plr.Character}
	params.IgnoreWater = true
	params.FilterType = Enum.RaycastFilterType.Blacklist
	local ray = workspace:Raycast(origin, direction, params)
	if ray and ray.Instance then
		local part = ray.Instance
		local char = part.Parent
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum and hum.Name == "Zombie" and hum.Health > 0 then
			UntagHumanoid(hum)
			TagHumanoid(hum, plr)
			hum:TakeDamage(part.Name == "Head" and 30 or 10)
		end
	end
	createBullet(origin, hitPos)
	task.wait(fireDelay)
	debounce = false
	if firePart and firePart:FindFirstChildOfClass("ParticleEmitter") then
		firePart.ParticleEmitter.Enabled = false
	end
end)

-- Sword logic: Only damage Humanoids named "Zombie" and tag them
local Character, Player, Humanoid, Torso

local function Blow(Hit)
	if not Hit or not Hit.Parent or not CheckIfAlive() or not ToolEquipped then
		return
	end
	local RightArm = Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
	if not RightArm then return end
	local RightGrip = RightArm:FindFirstChild("RightGrip")
	if not RightGrip or (RightGrip.Part0 ~= handle and RightGrip.Part1 ~= handle) then return end
	local character = Hit.Parent
	if character == Character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health == 0 or humanoid.Name ~= "Zombie" then return end
	UntagHumanoid(humanoid)
	TagHumanoid(humanoid, Player)
	humanoid:TakeDamage(Damage)
end

local function Attack()
	Damage = DamageValues.SlashDamage
	if Sounds.Slash then Sounds.Slash:Play() end
end

local function Lunge()
	Damage = DamageValues.LungeDamage
	if Sounds.Lunge then Sounds.Lunge:Play() end
	Damage = DamageValues.SlashDamage
end

tool.Enabled = true

local function Activated()
	if not tool.Enabled or not ToolEquipped or not CheckIfAlive() then return end
	tool.Enabled = false
	local Tick = RunService.Stepped:wait()
	if (Tick - LastAttack < 0.2) then
		Lunge()
	else
		Attack()
	end
	LastAttack = Tick
	Damage = DamageValues.BaseDamage
	tool.Enabled = true
end

local function Equipped()
	Character = tool.Parent
	Player = Players:GetPlayerFromCharacter(Character)
	Humanoid = Character:FindFirstChildOfClass("Humanoid")
	Torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("HumanoidRootPart")
	if not CheckIfAlive() then return end
	ToolEquipped = true
	if Sounds.Unsheath then Sounds.Unsheath:Play() end
	if equipSound then equipSound:Play() end
end

local function Unequipped()
	ToolEquipped = false
end

tool.Activated:Connect(Activated)
tool.Equipped:Connect(Equipped)
tool.Unequipped:Connect(Unequipped)
if handle then
	handle.Touched:Connect(Blow)
end

-- Modernize particle emitters for thumbnail
for _, v in handle:GetChildren() do
	if v:IsA("ParticleEmitter") then
		v.Rate = 20
	end
end

