local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local CombatService = require(ServerScriptService.Services.CombatService)
local RagdollModule = require(ReplicatedStorage.Packages.Ragdoll)

local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
local SlashSound = Handle:WaitForChild("Slash")
local EquippedSound = Handle:WaitForChild("Equipped")
local Remote = Tool:WaitForChild("RemoteEvent")

local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://89785685942743"

local cooldowns = {}

local function playSound(soundId)
	local s = Instance.new("Sound")
	s.Volume = 1
	s.SoundId = soundId
	s.Parent = Handle
	s:Play()
	Debris:AddItem(s, 2)
end

local function createPartHitbox(root)
	local hitbox = Instance.new("Part")
	hitbox.Size = Vector3.new(6, 4, 6)
	hitbox.CFrame = root.CFrame * CFrame.new(0, 0, -3)
	hitbox.Transparency = 1
	hitbox.CanCollide = false
	hitbox.Anchored = true
	hitbox.Parent = workspace
	return hitbox
end

local function createRegionHitbox(root)
	local pos = (root.CFrame * CFrame.new(0, 0, -3)).Position
	local size = Vector3.new(6, 4, 6)
	return Region3.new(pos - size/2, pos + size/2)
end

local function getTargets(playerChar, root)
	local final = {}

	local partHB = createPartHitbox(root)
	for _, part in ipairs(workspace:GetPartsInPart(partHB)) do
		local char = part.Parent
		local hum = char and char:FindFirstChild("Humanoid")
		if hum and char ~= playerChar and hum.Health > 0 then
			final[char] = true
		end
	end

	local region = createRegionHitbox(root)
	local regionParts = workspace:FindPartsInRegion3(region, playerChar, 40)
	for _, part in ipairs(regionParts) do
		local char = part.Parent
		local hum = char and char:FindFirstChild("Humanoid")
		if hum and char ~= playerChar and hum.Health > 0 then
			final[char] = true
		end
	end

	partHB:Destroy()
	return final
end

local function applyBothSlaps(attackerPlayer, targetChar, direction)
	local hum = targetChar:FindFirstChild("Humanoid")
	local root = targetChar:FindFirstChild("HumanoidRootPart")
	if not hum or not root then return end

	hum:TakeDamage(0)

	local bv = Instance.new("BodyVelocity")
	bv.Velocity = direction.Unit * 90 + Vector3.new(0, 10, 0)
	bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bv.Parent = root
	Debris:AddItem(bv, 0.2)

	CombatService.Fling(root, 500, root.Position)

	RagdollModule.TimedRagdoll(targetChar, 5)

	local plr = Players:GetPlayerFromCharacter(targetChar)
	if plr then
		plr:SetAttribute("Stealing", false)
	end
end

Remote.OnServerEvent:Connect(function(player, action)
	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if action == "Equipped" then
		playSound(EquippedSound.SoundId)
	elseif action == "Slash" then
		playSound(SlashSound.SoundId)
	end

	if action == "Slash" then
		local dir = root.CFrame.LookVector
		local targets = getTargets(char, root)

		for targetChar in pairs(targets) do
			applyBothSlaps(player, targetChar, dir)
		end
	end
end)

Tool.Activated:Connect(function()
	local char = Tool.Parent
	local player = Players:GetPlayerFromCharacter(char)
	if not player then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChild("Humanoid")
	if not root then return end

	local last = cooldowns[player.UserId] or 0
	if os.clock() - last < 2 then return end
	cooldowns[player.UserId] = os.clock()

	playSound(SlashSound.SoundId)

	if hum then
		local track = hum:LoadAnimation(anim)
		track:Play()
	end

	local bv = Instance.new("BodyVelocity")
	bv.Velocity = root.CFrame.LookVector * 100
	bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bv.Parent = root
	Debris:AddItem(bv, 0.2)

	local targets = getTargets(char, root)

	for targetChar in pairs(targets) do
		applyBothSlaps(player, targetChar, root.CFrame.LookVector)
	end
end)
