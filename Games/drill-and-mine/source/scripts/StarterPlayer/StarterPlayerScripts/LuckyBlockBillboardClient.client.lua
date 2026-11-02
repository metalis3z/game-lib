-- Server (IslandLuckyBlockSpawner) owns the lucky-block models in the world
-- so all players see the SAME blocks and race for them through the server-
-- owned ProximityPrompt. This client script handles the visual overhead
-- (PodiumBillboard with display name + rarity gradient + luck + timer) and
-- the per-frame position follower that keeps the overhead glued to the top
-- of the block as it idles/wobbles.
--
-- Why the follower exists: the lucky-block rig is a skinned mesh with an
-- anchored PrimaryPart (C_01) and a single root Bone (joint1) that doesn't
-- move under the Idle animation. The previous code set Adornee to that root
-- Bone with a fixed StudsOffsetWorldSpace, so the billboard stayed locked to
-- the un-animated anchor while the visible mesh wobbled out from under it.
-- model:GetBoundingBox() reflects the current animated bounds, so updating
-- the offset from the primary part to the live bounding-box top each frame
-- keeps the overhead glued to whatever the player actually sees.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Assets = Workspace:WaitForChild("Assets")
local ISLANDS_FOLDER = Assets:WaitForChild("Islands")

local BILLBOARD_TEMPLATE = playerGui:WaitForChild("PodiumBillboard")
local RARITY_GRADIENT_FOLDER = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")

-- Overhead sits a fixed height above the block on its in-model Attachment
-- (no code bob -- that made the text fly around weirdly).
local OVERHEAD_RAISE = 8.6

-- The lucky-block rigs ship with an empty AnimationId on their Idle Animation,
-- so the server-spawned blocks just sit static. Each client drives a simple
-- sinusoidal bob + slow yaw spin against the spawn CFrame so every player
-- sees the same idle wobble without any animation asset or server-side
-- per-frame replication cost. The PrimaryPart is anchored, so writing CFrame
-- on the client sticks locally and doesn't fight the server.
local BOB_HEIGHT = 0.55
local BOB_SPEED = 2.4
local SPIN_SPEED = math.rad(35)

local function setLabel(label, text)
	if not label then
		return
	end
	label.Text = text
	local inner = label:FindFirstChild("Inner")
	if inner then
		inner.Text = text
	end
end

-- Idle animation is played locally on every client rather than once on the
-- server. The lucky-block rigs are skinned meshes; running the Animator
-- locally is the canonical Roblox pattern for shared decorative wobble (each
-- client drives its own copy of the bones for its render, no asset-permission
-- coupling between server and client, and no replication traffic for the
-- pose). The template ships with an AnimationController + Animator + an
-- Animation child named "Idle" so we just have to load it.
local function playIdleAnimation(model)
	local animController = model:FindFirstChildWhichIsA("Humanoid", true)
		or model:FindFirstChildWhichIsA("AnimationController", true)
	if not animController then
		return nil
	end
	local idleAnim = animController:FindFirstChild("Idle")
	if not idleAnim or not idleAnim:IsA("Animation") or idleAnim.AnimationId == "" then
		return nil
	end
	local animator = animController:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = animController
	end
	local ok, track = pcall(function()
		return animator:LoadAnimation(idleAnim)
	end)
	if not ok or not track then
		return nil
	end
	track.Looped = true
	track:Play()
	return track
end

local function formatRemaining(remaining)
	if remaining >= 3600 then
		return string.format("%dh %dm", math.floor(remaining / 3600), math.floor((remaining % 3600) / 60))
	elseif remaining >= 60 then
		return string.format("%dm %ds", math.floor(remaining / 60), math.floor(remaining % 60))
	else
		return string.format("%.1fs", math.max(0, remaining))
	end
end

-- Active entries are keyed by model so we can clean up on removal regardless
-- of which signal (Destroying / Parent change / attribute clear) fires first.
local active = {}

local function detach(model)
	local entry = active[model]
	if not entry then
		return
	end
	active[model] = nil
	if entry.connections then
		for _, conn in ipairs(entry.connections) do
			conn:Disconnect()
		end
	end
	if entry.idleTrack then
		pcall(function()
			entry.idleTrack:Stop(0)
		end)
	end
	if entry.billboard then
		entry.billboard:Destroy()
	end
end

local function attach(model)
	if active[model] then
		return
	end
	if not model:GetAttribute("IslandLuckyBlock") then
		return
	end
	local primary = model.PrimaryPart
	if not primary then
		return
	end

	local displayName = model:GetAttribute("DisplayName") or model.Name
	local rarity = model:GetAttribute("Rarity")
	local luck = tonumber(model:GetAttribute("Luck")) or 1
	local spawnedAt = tonumber(model:GetAttribute("SpawnedAt"))
	local lifetime = tonumber(model:GetAttribute("Lifetime"))

	local billboard = BILLBOARD_TEMPLATE:Clone()
	billboard:SetAttribute("IslandLuckyBlockBillboard", true)

	setLabel(billboard:FindFirstChild("Name"), displayName)
	setLabel(billboard:FindFirstChild("Income"), string.format("x%.2f Luck", luck))

	local typeLabel = billboard:FindFirstChild("Type")
	if typeLabel then
		typeLabel.Visible = false
	end

	local rarityLabel = billboard:FindFirstChild("Rarity")
	if rarityLabel and rarity then
		rarityLabel.Text = rarity
		local rarityInner = rarityLabel:FindFirstChild("Rarity")
		local gradientHost = rarityInner or rarityLabel
		if rarityInner then
			rarityInner.Text = rarity
		end
		for _, child in ipairs(gradientHost:GetChildren()) do
			if child:IsA("UIGradient") then
				child:Destroy()
			end
		end
		local grad = RARITY_GRADIENT_FOLDER:FindFirstChild(rarity)
		if grad then
			grad:Clone().Parent = gradientHost
		end
	end

	local timerFrame = billboard:FindFirstChild("TimerFrame")
	local timerLabel = timerFrame and timerFrame:FindFirstChild("Timer")
	local timerInner = timerLabel and timerLabel:FindFirstChild("Inner")

	-- Overhead on an Attachment INSIDE the model (on the animated root Bone
	-- if there is one -- the skinned Idle moves the bone, not the part) so the
	-- text moves together with the block. MaxDistance 0 = visible at any range.
	local _, ohSize = model:GetBoundingBox()
	local ohHost = primary:FindFirstChildWhichIsA("Bone") or primary
	local ohAtt = Instance.new("Attachment")
	ohAtt.Name = "OverheadAttachment"
	ohAtt.Position = Vector3.new(0, ohSize.Y / 2 + OVERHEAD_RAISE, 0)
	ohAtt.Parent = ohHost
	billboard.MaxDistance = 0
	billboard.StudsOffsetWorldSpace = Vector3.zero
	billboard.Adornee = ohAtt
	billboard.Parent = ohAtt

	local idleTrack = playIdleAnimation(model)

	local entry = {
		billboard = billboard,
		primary = primary,
		lastTimerText = nil,
		timerLabel = timerLabel,
		timerInner = timerInner,
		spawnedAt = spawnedAt,
		lifetime = lifetime,
		idleTrack = idleTrack,
		baseCFrame = primary.CFrame,
		bobPhase = math.random() * math.pi * 2,
		spinStart = os.clock(),
		connections = {},
	}
	active[model] = entry

	table.insert(entry.connections, model.AncestryChanged:Connect(function(_, parent)
		if not parent then
			detach(model)
		end
	end))
	table.insert(entry.connections, model.Destroying:Connect(function()
		detach(model)
	end))
end

-- One Heartbeat loop drives every billboard so we aren't burning N
-- connections for the (potentially ~30) live blocks across all islands.
RunService.Heartbeat:Connect(function()
	local now = Workspace:GetServerTimeNow()
	for model, entry in pairs(active) do
		local primary = entry.primary
		if not primary or not primary.Parent or not model.Parent then
			detach(model)
		else
			if entry.timerLabel and entry.spawnedAt and entry.lifetime then
				local remaining = math.max(0, (entry.spawnedAt + entry.lifetime) - now)
				local text = formatRemaining(remaining)
				if text ~= entry.lastTimerText then
					entry.lastTimerText = text
					entry.timerLabel.Text = text
					if entry.timerInner then
						entry.timerInner.Text = text
					end
				end
			end
		end
	end
end)

local function tryAttachDescendant(inst)
	if inst:IsA("Model") and inst:GetAttribute("IslandLuckyBlock") then
		attach(inst)
	end
end

for _, inst in ipairs(ISLANDS_FOLDER:GetDescendants()) do
	tryAttachDescendant(inst)
end

ISLANDS_FOLDER.DescendantAdded:Connect(function(inst)
	-- A clone may arrive before its PrimaryPart attribute fully replicates; wait a
	-- frame so primary + attributes are both populated before reading them.
	if inst:IsA("Model") then
		task.defer(tryAttachDescendant, inst)
	end
end)
