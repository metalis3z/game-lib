math.randomseed(tick())

local ft = script.Parent.Parent
local props = {}
local activeBurns = {} -- Dictionary to track currently burning zombies
local firing = false

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

-- Ensure Remotes folder exists
local remotes = ft:FindFirstChild("Remotes") or Instance.new("Folder")
remotes.Name = "Remotes"
remotes.Parent = ft

-- Helper Functions
local function generateEvent(name)
	local remote = remotes:FindFirstChild(name) or Instance.new("RemoteEvent")
	remote.Name = name
	remote.Parent = remotes
	return remote
end

local function generateFunction(name)
	local remote = remotes:FindFirstChild(name) or Instance.new("RemoteFunction")
	remote.Name = name
	remote.Parent = remotes
	return remote
end

local function TagHumanoid(humanoid, player)
	local tag = Instance.new("ObjectValue")
	tag.Name = "creator"
	tag.Value = player
	Debris:AddItem(tag, 2)
	tag.Parent = humanoid
end

local function UntagHumanoid(humanoid)
	for _, v in ipairs(humanoid:GetChildren()) do
		if v:IsA("ObjectValue") and v.Name == "creator" then
			v:Destroy()
		end
	end
end

-- Damage and Fire Logic
function ignite(character, plr)
	-- Check if target is a Zombie and not already on fire
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Name ~= "Zombie" or humanoid.Health <= 0 or activeBurns[character] then
		return
	end

	activeBurns[character] = true -- Mark as burning

	-- Stop the zombie
	local originalSpeed = humanoid.WalkSpeed
	humanoid.WalkSpeed = 0

	-- Create Visual Effects
	local currentEffects = {}
	for _, child in pairs(character:GetChildren()) do
		if child:IsA("BasePart") then
			-- Flame
			local flame = ft.FlamePart.Flame:Clone()
			flame.Enabled = true
			flame.Parent = child
			table.insert(currentEffects, flame)

			-- Smoke
			local smoke = flame:Clone()
			smoke.Texture = "rbxassetid://133619974"
			smoke.Color = ColorSequence.new(Color3.fromRGB(40, 40, 40))
			smoke.Parent = child
			table.insert(currentEffects, smoke)
		end
	end

	-- Sound
	local scream = Instance.new("Sound")
	scream.SoundId = "rbxassetid://147758618"
	scream.Looped = true
	scream.Volume = 1.2
	scream.Parent = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
	scream:Play()

	-- Damage Loop (Asynchronous)
	task.spawn(function()
		local damageCount = 0
		while humanoid.Health > 0 and damageCount < 12 do
			UntagHumanoid(humanoid)
			TagHumanoid(humanoid, plr)

			humanoid:TakeDamage(15) -- Damage per tick

			-- Burn tools if they have them
			local tool = character:FindFirstChildOfClass("Tool")
			if tool then tool:Destroy() end

			damageCount += 1
			task.wait(0.4)
		end

		-- Cleanup
		if scream then scream:Stop() scream:Destroy() end
		for _, effect in pairs(currentEffects) do
			if effect then effect.Enabled = false Debris:AddItem(effect, 2) end
		end

		if humanoid.Parent then
			humanoid.WalkSpeed = originalSpeed
		end

		activeBurns[character] = nil -- Allow them to be ignited again later
	end)
end

-- Remote Handlers
local makeNozzle = generateEvent("GenerateNozzle")
makeNozzle.OnServerEvent:Connect(function(player)
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local attachment1 = Instance.new("Attachment")
	attachment1.Position = Vector3.new(1, -1, 0.5)
	attachment1.Parent = char.HumanoidRootPart

	local rope = Instance.new("RopeConstraint")
	rope.Attachment0 = ft.Rope.Attachment
	rope.Attachment1 = attachment1
	rope.Visible = true
	rope.Color = BrickColor.new("Really black")
	rope.Thickness = 0.1
	rope.Parent = ft

	table.insert(props, attachment1)
	table.insert(props, rope)
end)

local unmakeNozzle = generateEvent("RemoveNozzle")
unmakeNozzle.OnServerEvent:Connect(function(player)
	for _, v in pairs(props) do
		if v then v:Destroy() end
	end
	table.clear(props)
end)

local fire = generateFunction("Fire")
fire.OnServerInvoke = function(player)
	if firing then return end
	firing = true

	-- Startup Sound
	local sound1 = Instance.new("Sound")
	sound1.SoundId = "rbxassetid://574293274"
	sound1.Parent = ft.BulletPart
	sound1:Play()
	Debris:AddItem(sound1, 1)

	ft.BulletPart.Fuel.Enabled = true
	task.wait(0.2)

	local fireSound = Instance.new("Sound")
	fireSound.Name = "FireSound"
	fireSound.Looped = true
	fireSound.SoundId = "rbxassetid://149906526"
	fireSound.Parent = ft.FlamePart
	fireSound:Play()

	ft.FlamePart.Fire.Enabled = true

	-- Continuous Detection Loop
	while firing do
		-- Modern Raycast: 15 studs range
		local rayOrigin = ft.FlamePart.Position
		local rayDirection = -ft.FlamePart.CFrame.upVector * 15

		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {player.Character, ft}
		params.FilterType = Enum.RaycastFilterType.Exclude

		local result = workspace:Raycast(rayOrigin, rayDirection, params)

		if result and result.Instance then
			local hitModel = result.Instance:FindFirstAncestorOfClass("Model")
			if hitModel then
				ignite(hitModel, player)
			end
		end
		task.wait(0.1)
	end
end

local stopFire = generateFunction("StopFire")
stopFire.OnServerInvoke = function(player)
	firing = false
	local fs = ft.FlamePart:FindFirstChild("FireSound")
	if fs then fs:Destroy() end

	ft.BulletPart.Fuel.Enabled = false
	ft.FlamePart.Fire.Enabled = false
end