local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local LUCKYBLOCKS_FOLDER = ReplicatedStorage:WaitForChild("LuckyBlocks")
local Assets = Workspace:WaitForChild("Assets")
local ISLANDS_FOLDER = Assets:WaitForChild("Islands")
local PLOTS_FOLDER = Assets:FindFirstChild("Plots")

-- IslandBrainrotSpawner creates the IslandBrainrot remotes folder + its child
-- RequestCarry BindableFunction. Wait for them so this script can hand carry
-- attempts to the shared state owner.
local IslandBrainrotSpawnerScript = ServerScriptService:WaitForChild("IslandBrainrotSpawner")
local RequestCarryBindable = IslandBrainrotSpawnerScript:WaitForChild("RequestCarry")

-- Constants mirror the previous client-side spawner so the in-game cadence is
-- unchanged after moving spawning server-side.
local LIFETIME_MIN = 45
local LIFETIME_MAX = 90
local LUCKYBLOCK_SCALE = 1.45
-- Base offset of the block bottom above the island top. Has to clear the
-- client-side bob amplitude (LuckyBlockBillboardClient BOB_HEIGHT = 0.55)
-- with margin so the block doesn't clip into the ground at the bottom of
-- its bob. Dropped from 2.0 -> 0.7 per user request ("too high"); the block
-- now sits noticeably closer to the ground while still clearing the bob.
local LUCKYBLOCK_HOVER_LIFT = 0.7
local LUCKYBLOCK_MIN_SEPARATION = 16
local ISLAND_EDGE_MARGIN_X = 5
local ISLAND_EDGE_MARGIN_Z = 7
local COLLECT_DISTANCE_LIMIT = 14

local function pickLifetime()
	return LIFETIME_MIN + math.random() * (LIFETIME_MAX - LIFETIME_MIN)
end

local function getPlotsCenter()
	if not PLOTS_FOLDER then
		return Vector3.zero
	end
	local total = Vector3.zero
	local count = 0
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		if plot:IsA("BasePart") then
			total = total + plot.Position
			count = count + 1
		else
			for _, child in ipairs(plot:GetChildren()) do
				if child:IsA("BasePart") then
					total = total + child.Position
					count = count + 1
					break
				end
			end
		end
	end
	if count == 0 then
		return Vector3.zero
	end
	return total / count
end

local PLOTS_CENTER = getPlotsCenter()

-- Same logic as the old client-side helper: anchor only the PrimaryPart, no-
-- collide everything, drop any baked ProximityPrompts + KeyframeSequences.
-- Motor6D / skinned-mesh rigs need every non-primary part unanchored so the
-- Idle animation can move them.
local function prepareIslandClone(model)
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("KeyframeSequence") then
			desc:Destroy()
		end
	end
	local primary = model.PrimaryPart
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("BasePart") then
			desc.Anchored = (desc == primary)
			desc.CanCollide = false
		elseif desc:IsA("ProximityPrompt") then
			desc:Destroy()
		end
	end
end

local function randomIslandXZ(island)
	local hx = math.max(1, island.Size.X / 2 - ISLAND_EDGE_MARGIN_X)
	local hz = math.max(1, island.Size.Z / 2 - ISLAND_EDGE_MARGIN_Z)
	local lx = (math.random() * 2 - 1) * hx
	local lz = (math.random() * 2 - 1) * hz
	local p = (island.CFrame * CFrame.new(lx, 0, lz)).Position
	return p.X, p.Z
end

local function pickFreeIslandXZ(island, active)
	local x, z
	for _ = 1, 14 do
		x, z = randomIslandXZ(island)
		local ok = true
		for _, p in pairs(active) do
			local dx, dz = p.x - x, p.z - z
			if (dx * dx + dz * dz) < (LUCKYBLOCK_MIN_SEPARATION * LUCKYBLOCK_MIN_SEPARATION) then
				ok = false
				break
			end
		end
		if ok then
			break
		end
	end
	return x, z
end

-- Spawn a single lucky-block instance into ISLANDS_FOLDER. Returns the model
-- and a state table the slot loop polls so it can react to ProximityPrompt
-- collection in the same frame.
local function spawnLuckyBlockAt(islandTopY, desc, islandName, worldX, worldZ, lifetime)
	local models = desc.Models
	if not models or #models == 0 then
		return nil, { collected = true }
	end
	local modelName = models[math.random(1, #models)]
	local cfg = GameConfig.LuckyBlocks[modelName] or {}
	local displayName = cfg.DisplayName or modelName
	local rarity = cfg.Rarity or desc.Rarity
	local luck = tonumber(cfg.Luck) or 1

	local template = LUCKYBLOCKS_FOLDER:FindFirstChild(modelName)
	if not template then
		warn("[IslandLuckyBlockSpawner] missing lucky-block model: " .. tostring(modelName))
		return nil, { collected = true }
	end

	local clone = template:Clone()
	for _, d in ipairs(clone:GetDescendants()) do
		if d.Name == "AnimSaves" or d.Name == "InitialPoses" then
			d:Destroy()
		end
	end
	prepareIslandClone(clone)
	clone.Name = modelName

	local primary = clone.PrimaryPart
	if not primary then
		clone:Destroy()
		return nil, { collected = true }
	end

	clone:ScaleTo(clone:GetScale() * LUCKYBLOCK_SCALE)
	local lookTarget = Vector3.new(PLOTS_CENTER.X, islandTopY, PLOTS_CENTER.Z)
	clone:PivotTo(CFrame.lookAt(Vector3.new(worldX, islandTopY, worldZ), lookTarget))
	local bbCF, bbSize = clone:GetBoundingBox()
	local desiredBottom = islandTopY + LUCKYBLOCK_HOVER_LIFT
	local currentBottom = bbCF.Position.Y - bbSize.Y / 2
	clone:PivotTo(clone:GetPivot() + Vector3.new(0, desiredBottom - currentBottom, 0))

	-- Attributes are how the client billboard controller finds these blocks and
	-- pulls the labels it needs to render. SpawnedAt + Lifetime drive the live
	-- countdown text.
	clone:SetAttribute("IslandLuckyBlock", true)
	clone:SetAttribute("LuckyBlockId", modelName)
	clone:SetAttribute("LuckyBlockSpawnId", HttpService:GenerateGUID(false))
	clone:SetAttribute("IslandName", islandName)
	clone:SetAttribute("DisplayName", displayName)
	clone:SetAttribute("Rarity", rarity)
	clone:SetAttribute("Luck", luck)
	clone:SetAttribute("SpawnedAt", Workspace:GetServerTimeNow())
	clone:SetAttribute("Lifetime", lifetime)

	clone.Parent = ISLANDS_FOLDER
	-- Idle animation is played per-client in LuckyBlockBillboardClient so the
	-- wobble doesn't rely on a single server-side Animator (the rigs are
	-- skinned meshes -- each client drives its own copy for its render). The
	-- AnimationController + Animator + "Idle" Animation already live inside
	-- the template so no setup is needed here.

	local state = { collected = false }

	local promptAttachment = Instance.new("Attachment")
	promptAttachment.Name = "PromptAttachment"
	-- Anchor the prompt at the model's bounding-box center, expressed in the
	-- primary part's object space (primary is the anchor but isn't always
	-- aligned with the visual center on rigs whose pivot sits at one corner).
	promptAttachment.Position = primary.CFrame:PointToObjectSpace(clone:GetBoundingBox().Position)
	promptAttachment.Parent = primary

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Collect"
	prompt.ObjectText = displayName
	prompt.HoldDuration = 1
	prompt:SetAttribute("GrabZoom", true)
	prompt.MaxActivationDistance = 12
	prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt.RequiresLineOfSight = false
	prompt.Parent = promptAttachment

	prompt.Triggered:Connect(function(triggerPlayer)
		if state.collected then
			return
		end
		local character = triggerPlayer.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp or not clone.Parent or not clone.PrimaryPart then
			return
		end
		if (hrp.Position - clone.PrimaryPart.Position).Magnitude > COLLECT_DISTANCE_LIMIT then
			return
		end

		-- Hand the carry attempt to the same gating used by the brainrot
		-- carry flow (capacity check, per-player cooldown, fires StartCarry to
		-- play the held visual + carry animation). Pass the live spawnedAt /
		-- lifetime so the carry entry preserves the block's timer -- the
		-- DropCarry path uses them to respawn a clone with the SAME remaining
		-- countdown instead of restarting from full.
		local carryAttrs = {
			SpawnedAt = clone:GetAttribute("SpawnedAt"),
			Lifetime = clone:GetAttribute("Lifetime"),
			IslandName = islandName,
		}
		local accepted = RequestCarryBindable:Invoke(triggerPlayer, modelName, nil, carryAttrs)
		if not accepted then
			return
		end

		state.collected = true
		clone:Destroy()
	end)

	return clone, state
end

local function runLuckyBlockSlot(islandTopY, islandName, desc, ctx)
	local lifetime = ctx.lifetime
	local slotKey = {}
	while true do
		local worldX, worldZ = pickFreeIslandXZ(ctx.island, ctx.active)
		ctx.active[slotKey] = { x = worldX, z = worldZ }

		local block, state = spawnLuckyBlockAt(islandTopY, desc, islandName, worldX, worldZ, lifetime)
		local spawnedAt = os.clock()

		while not state.collected and os.clock() - spawnedAt < lifetime do
			task.wait(0.25)
		end
		if not state.collected and block and block.Parent then
			block:Destroy()
		end
		ctx.active[slotKey] = nil

		task.wait(0.5 + math.random() * 0.6)
		lifetime = pickLifetime()
	end
end

local function setupIsland(islandName, config)
	local island = ISLANDS_FOLDER:FindFirstChild(islandName)
	if not island then
		warn(string.format("[IslandLuckyBlockSpawner] island '%s' not found in workspace.Assets.Islands", islandName))
		return
	end

	local desc = GameConfig.LuckyBlockSpawn and GameConfig.LuckyBlockSpawn[islandName]
	if not desc then
		warn(string.format("[IslandLuckyBlockSpawner] no LuckyBlockSpawn config for island '%s', skipping", islandName))
		return
	end

	local islandTopY = island.Position.Y + island.Size.Y / 2

	local activePositions = {}
	for _, slot in ipairs(config.slots) do
		task.spawn(function()
			if slot.initialDelay and slot.initialDelay > 0 then
				task.wait(slot.initialDelay)
			end
			runLuckyBlockSlot(islandTopY, islandName, desc, {
				island = island,
				lifetime = slot.lifetime or pickLifetime(),
				active = activePositions,
			})
		end)
		task.wait()
	end
end

-- Lucky-block spawning in the zones is DISABLED (replaced by the rarity loot
-- system, see RarityItemSpawner). The rest of this script stays alive because
-- IslandBrainrotSpawner still waits on the RespawnLuckyBlock bindable below.
-- To re-enable spawning, restore this loop:
-- for islandName, config in pairs(GameConfig.Islands) do
-- 	task.spawn(setupIsland, islandName, config)
-- end
local _ = setupIsland -- keep the function referenced

--------------------------------------------------------------------------------
-- Respawn API: lets IslandBrainrotSpawner.DropCarry place a lucky block back
-- on the ground with the player's preserved spawnedAt+lifetime, so dropped
-- blocks resume their original countdown instead of restarting.
--------------------------------------------------------------------------------
local function spawnAtPosition(modelName, worldPos, spawnedAt, lifetime, islandName)
	local template = LUCKYBLOCKS_FOLDER:FindFirstChild(modelName)
	if not template then return nil end
	local cfg = GameConfig.LuckyBlocks[modelName] or {}
	local displayName = cfg.DisplayName or modelName
	local rarity = cfg.Rarity
	local luck = tonumber(cfg.Luck) or 1

	local clone = template:Clone()
	for _, d in ipairs(clone:GetDescendants()) do
		if d.Name == "AnimSaves" or d.Name == "InitialPoses" then d:Destroy() end
	end
	prepareIslandClone(clone)
	clone.Name = modelName
	local primary = clone.PrimaryPart
	if not primary then clone:Destroy(); return nil end

	clone:ScaleTo(clone:GetScale() * LUCKYBLOCK_SCALE)
	local lookTarget = Vector3.new(PLOTS_CENTER.X, worldPos.Y, PLOTS_CENTER.Z)
	clone:PivotTo(CFrame.lookAt(worldPos, lookTarget))
	local bbCF, bbSize = clone:GetBoundingBox()
	-- Drop the block at the player's feet -- use the player's Y as the
	-- baseline, lifted just enough to clear the bob.
	local desiredBottom = worldPos.Y - 2.5 + LUCKYBLOCK_HOVER_LIFT
	local currentBottom = bbCF.Position.Y - bbSize.Y / 2
	clone:PivotTo(clone:GetPivot() + Vector3.new(0, desiredBottom - currentBottom, 0))

	clone:SetAttribute("IslandLuckyBlock", true)
	clone:SetAttribute("LuckyBlockId", modelName)
	clone:SetAttribute("LuckyBlockSpawnId", HttpService:GenerateGUID(false))
	clone:SetAttribute("IslandName", islandName or "")
	clone:SetAttribute("DisplayName", displayName)
	clone:SetAttribute("Rarity", rarity)
	clone:SetAttribute("Luck", luck)
	clone:SetAttribute("SpawnedAt", spawnedAt or Workspace:GetServerTimeNow())
	clone:SetAttribute("Lifetime", lifetime or pickLifetime())

	clone.Parent = ISLANDS_FOLDER

	-- Collect prompt mirrors the spawnLuckyBlockAt path so other players (or
	-- the dropper themselves) can pick it back up. Stripped down -- no
	-- lifetime watchdog, the world block self-destroys on its own countdown.
	local promptAttachment = Instance.new("Attachment")
	promptAttachment.Name = "PromptAttachment"
	promptAttachment.Position = primary.CFrame:PointToObjectSpace(clone:GetBoundingBox().Position)
	promptAttachment.Parent = primary

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Collect"
	prompt.ObjectText = displayName
	prompt.HoldDuration = 1
	prompt:SetAttribute("GrabZoom", true)
	prompt.MaxActivationDistance = 12
	prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt.RequiresLineOfSight = false
	prompt.Parent = promptAttachment

	local grabbed = false
	prompt.Triggered:Connect(function(triggerPlayer)
		if grabbed then return end
		local char = triggerPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp or not clone.Parent or not clone.PrimaryPart then return end
		if (hrp.Position - clone.PrimaryPart.Position).Magnitude > COLLECT_DISTANCE_LIMIT then return end
		local carryAttrs = {
			SpawnedAt = clone:GetAttribute("SpawnedAt"),
			Lifetime = clone:GetAttribute("Lifetime"),
			IslandName = clone:GetAttribute("IslandName"),
		}
		local accepted = RequestCarryBindable:Invoke(triggerPlayer, modelName, nil, carryAttrs)
		if not accepted then return end
		grabbed = true
		clone:Destroy()
	end)

	-- Auto-despawn after the remaining lifetime expires.
	task.delay(math.max(1, (clone:GetAttribute("Lifetime") or 60) - (Workspace:GetServerTimeNow() - (clone:GetAttribute("SpawnedAt") or Workspace:GetServerTimeNow()))), function()
		if clone and clone.Parent then clone:Destroy() end
	end)

	return clone
end

local RespawnLuckyBlockBindable = Instance.new("BindableFunction")
RespawnLuckyBlockBindable.Name = "RespawnLuckyBlock"
RespawnLuckyBlockBindable.OnInvoke = function(modelName, worldPos, spawnedAt, lifetime, islandName)
	return spawnAtPosition(modelName, worldPos, spawnedAt, lifetime, islandName) ~= nil
end
RespawnLuckyBlockBindable.Parent = script
