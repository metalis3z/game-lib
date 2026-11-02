local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local PlayerDataService = require(ServerScriptService:WaitForChild("Source"):WaitForChild("Services"):WaitForChild("PlayerDataService"))
local LuckyBlockService = require(ServerScriptService:WaitForChild("Source"):WaitForChild("Services"):WaitForChild("LuckyBlockService"))

local IslandRemotes = Instance.new("Folder")
IslandRemotes.Name = "IslandBrainrot"
IslandRemotes.Parent = ReplicatedStorage:WaitForChild("Remotes")

local CollectedBrainrotEvent = Instance.new("RemoteEvent")
CollectedBrainrotEvent.Name = "CollectedBrainrot"
CollectedBrainrotEvent.Parent = IslandRemotes

local StartCarryEvent = Instance.new("RemoteEvent")
StartCarryEvent.Name = "StartCarry"
StartCarryEvent.Parent = IslandRemotes

local CancelCarryEvent = Instance.new("RemoteEvent")
CancelCarryEvent.Name = "CancelCarry"
CancelCarryEvent.Parent = IslandRemotes

local RequestCarryEvent = Instance.new("RemoteEvent")
RequestCarryEvent.Name = "RequestCarry"
RequestCarryEvent.Parent = IslandRemotes

local MAIN_ISLAND = workspace:WaitForChild("Assets"):WaitForChild("Map"):WaitForChild("MainIsland")

-- 1.0s was fine for single-carry (you'd always be walking back to deposit
-- before being able to pick up again). With multi-carry the player wants to
-- grab N brainrots in quick succession; the cooldown only exists now as an
-- anti-spam floor, with MaxCarry as the actual cap.
local CARRY_COOLDOWN = 0.15

-- carrying[player] is an array of { BrainrotId, Mutation } entries. Max length
-- is gated by the player's MaxCarry attribute (set by UpgradeShopService from
-- CarryLevel + GameConfig.Upgrades.Carry).
local carrying = {}
local lastCarryRequest = {}

local function getMaxCarry(player)
	local v = player:GetAttribute("MaxCarry")
	if type(v) == "number" and v >= 1 then
		return math.floor(v)
	end
	-- Fallback to GameConfig base if attribute hasn't been pushed yet.
	local carryCfg = GameConfig.Upgrades and GameConfig.Upgrades.Carry
	if carryCfg and type(carryCfg.Base) == "number" then
		return math.max(1, math.floor(carryCfg.Base))
	end
	return 1
end

local function depositCarry(player)
	local entries = carrying[player]
	if not entries or #entries == 0 then
		return
	end
	carrying[player] = nil

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return
	end

	local brainrotInv = playerData.BrainrotInventory or {}
	local unlocked = playerData.BrainrotUnlocked or {}
	local hadBrainrot = false

	for _, entry in ipairs(entries) do
		if entry.LuckyBlockId then
			-- Lucky block: carried like a brainrot, deposited into the
			-- lucky-block inventory via the existing LuckyBlockService.
			LuckyBlockService.AddLuckyBlock(player, entry.LuckyBlockId, 1)
		else
			hadBrainrot = true
			local uniqueId = HttpService:GenerateGUID(false)
			brainrotInv[uniqueId] = {
				BrainrotId = entry.BrainrotId,
				Mutation = entry.Mutation,
				Timestamp = os.time(),
			}
			if entry.Mutation and entry.Mutation ~= "" then
				unlocked[entry.Mutation .. "_" .. entry.BrainrotId] = true
			else
				unlocked[entry.BrainrotId] = true
			end
		end
	end

	if hadBrainrot then
		playerData.BrainrotInventory = brainrotInv
		PlayerDataService.SetStat(player, "BrainrotInventory", brainrotInv)
		playerData.BrainrotUnlocked = unlocked
		PlayerDataService.SetStat(player, "BrainrotUnlocked", unlocked)
	end

	for _, entry in ipairs(entries) do
		if entry.LuckyBlockId then
			CollectedBrainrotEvent:FireClient(player, entry.LuckyBlockId, nil, true)
		else
			CollectedBrainrotEvent:FireClient(player, entry.BrainrotId, entry.Mutation)
		end
	end
end

MAIN_ISLAND.Touched:Connect(function(hit)
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character then
		return
	end
	local player = Players:GetPlayerFromCharacter(character)
	if not player then
		return
	end
	local list = carrying[player]
	if not list or #list == 0 then
		return
	end
	depositCarry(player)
end)

-- Touched is unreliable for characters walking onto a Part (especially when
-- they cross from a Bridgepart at the same Y as MainIsland's top -- Roblox's
-- contact detection sometimes misses the new-part touch). Poll players who are
-- mid-carry: if their HRP is inside MainIsland's AABB, deposit. Same depositCarry
-- guard short-circuits when nothing's carried so this is cheap.
local function isInsideMainIsland(pos)
	local cf, sz = MAIN_ISLAND.CFrame, MAIN_ISLAND.Size
	local lp = cf:PointToObjectSpace(pos)
	return math.abs(lp.X) <= sz.X / 2
		and math.abs(lp.Y) <= sz.Y / 2 + 6 -- generous Y so a character standing on top counts
		and math.abs(lp.Z) <= sz.Z / 2
end

task.spawn(function()
	while true do
		task.wait(0.15)
		for player, list in pairs(carrying) do
			if list and #list > 0 then
				local char = player.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				if hrp and isInsideMainIsland(hrp.Position) then
					depositCarry(player)
				end
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	carrying[player] = nil
	lastCarryRequest[player] = nil
end)

-- Pulled out of the OnServerEvent so the server-side island lucky-block
-- spawner (which owns the ProximityPrompt now) can share carry state by
-- invoking the RequestCarry BindableFunction created below. Returns true when
-- a carry entry was added so the prompt handler knows whether to despawn its
-- block.
local function handleCarryRequest(player, brainrotId, mutationId, attrs)
	if type(brainrotId) ~= "string" then
		return false
	end

	-- World lucky block: collected from a rarity island. Mimics the brainrot
	-- flow -- the player carries it (held visual + carry animation) back to
	-- MainIsland and depositCarry then grants it via LuckyBlockService.
	if GameConfig.LuckyBlocks[brainrotId] then
		local list = carrying[player]
		if list and #list >= getMaxCarry(player) then
			return false
		end
		local now = os.clock()
		local last = lastCarryRequest[player] or 0
		if now - last < CARRY_COOLDOWN then
			return false
		end
		lastCarryRequest[player] = now
		if not list then
			list = {}
			carrying[player] = list
		end
		-- attrs carries the lucky block's preserved SpawnedAt / Lifetime /
		-- IslandName so a Drop respawns the world block with its original
		-- remaining countdown instead of starting from full.
		local entry = { LuckyBlockId = brainrotId }
		if type(attrs) == "table" then
			entry.SpawnedAt = attrs.SpawnedAt
			entry.Lifetime = attrs.Lifetime
			entry.IslandName = attrs.IslandName
		end
		table.insert(list, entry)
		StartCarryEvent:FireClient(player, brainrotId, nil, true)
		return true
	end

	if not GameConfig.Items[brainrotId] then
		return false
	end

	local list = carrying[player]
	if list and #list >= getMaxCarry(player) then
		return false
	end

	local validatedMutation = nil
	if mutationId ~= nil then
		if type(mutationId) ~= "string" then
			return false
		end
		if mutationId ~= "" then
			if not GameConfig.Mutations[mutationId] then
				return false
			end
			validatedMutation = mutationId
		end
	end

	local now = os.clock()
	local last = lastCarryRequest[player] or 0
	if now - last < CARRY_COOLDOWN then
		return false
	end
	lastCarryRequest[player] = now

	if not list then
		list = {}
		carrying[player] = list
	end
	table.insert(list, { BrainrotId = brainrotId, Mutation = validatedMutation })
	StartCarryEvent:FireClient(player, brainrotId, validatedMutation)
	return true
end

RequestCarryEvent.OnServerEvent:Connect(handleCarryRequest)

-- Shared entry point for other server scripts (e.g. IslandLuckyBlockSpawner)
-- so they can hand a carry attempt through the same gating + state map used by
-- the RemoteEvent path.
local RequestCarryBindable = Instance.new("BindableFunction")
RequestCarryBindable.Name = "RequestCarry"
RequestCarryBindable.OnInvoke = handleCarryRequest
RequestCarryBindable.Parent = script

--------------------------------------------------------------------------------
-- PickUpButtons backing remotes:
--   * DropCarry  (RemoteEvent)         -- client "Drop" button. Pops the
--      latest carried lucky block and respawns it as a world block at the
--      player's feet, preserving SpawnedAt / Lifetime so the timer keeps
--      ticking from where it was.
--   * DepositCarry  (BindableFunction) -- exposed for PurchaseService's
--      HomeTeleport context: drains the carry table into the player's
--      inventory (mirrors the MainIsland touch deposit) and lets the
--      purchase callback do the actual teleport.
--------------------------------------------------------------------------------
local IslandLuckyBlockSpawner = ServerScriptService:WaitForChild("IslandLuckyBlockSpawner", 30)
local RespawnLuckyBlockBindable = IslandLuckyBlockSpawner and IslandLuckyBlockSpawner:WaitForChild("RespawnLuckyBlock", 30)

local DropCarryEvent = Instance.new("RemoteEvent")
DropCarryEvent.Name = "DropCarry"
DropCarryEvent.Parent = IslandRemotes

DropCarryEvent.OnServerEvent:Connect(function(player)
	local list = carrying[player]
	if not list or #list == 0 then return end
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- Pop the most-recently-picked lucky block (last entry). Refuse to drop
	-- non-lucky brainrots through this path.
	local entry = list[#list]
	if not (entry and entry.LuckyBlockId) then return end
	table.remove(list, #list)
	if #list == 0 then carrying[player] = nil end

	if RespawnLuckyBlockBindable then
		pcall(function()
			RespawnLuckyBlockBindable:Invoke(
				entry.LuckyBlockId,
				hrp.Position,
				entry.SpawnedAt,
				entry.Lifetime,
				entry.IslandName
			)
		end)
	end

	-- Tell the client to tear down the carry visual. CancelCarry destroys the
	-- whole stack on the client; we re-add the remaining entries below so the
	-- client's view matches the server.
	CancelCarryEvent:FireClient(player)
	if list and #list > 0 then
		for _, e in ipairs(list) do
			StartCarryEvent:FireClient(player, e.LuckyBlockId or e.BrainrotId, e.Mutation, e.LuckyBlockId ~= nil)
		end
	end
end)

local DepositCarryBindable = Instance.new("BindableFunction")
DepositCarryBindable.Name = "DepositCarry"
DepositCarryBindable.OnInvoke = function(player)
	depositCarry(player)
	return true
end
DepositCarryBindable.Parent = script

-- LostBrainrotService fall hook: pops every carried lucky-block entry without
-- respawning the world blocks (the player is being teleported home for free,
-- so dropping the block in place would be a no-cost recovery). Returns the
-- list of LuckyBlockIds that were lost so the recovery UI can offer them back
-- via the dev product. Brainrot entries (non-lucky carries) are preserved --
-- losing those is not part of this feature scope.
local DropCarriedLuckyOnFallBindable = Instance.new("BindableFunction")
DropCarriedLuckyOnFallBindable.Name = "DropCarriedLuckyOnFall"
DropCarriedLuckyOnFallBindable.OnInvoke = function(player)
	local list = carrying[player]
	if not list or #list == 0 then return {} end

	local lost = {}
	local kept = {}
	for _, entry in ipairs(list) do
		if entry.LuckyBlockId then
			table.insert(lost, entry.LuckyBlockId)
		else
			table.insert(kept, entry)
		end
	end

	if #lost == 0 then return {} end

	if #kept == 0 then
		carrying[player] = nil
	else
		carrying[player] = kept
	end

	-- Tear down the client's carry visual stack and rebuild from kept entries
	-- (mirrors the DropCarry RemoteEvent handler above so the client view stays
	-- in sync with the server's carrying state).
	CancelCarryEvent:FireClient(player)
	for _, e in ipairs(kept) do
		StartCarryEvent:FireClient(player, e.LuckyBlockId or e.BrainrotId, e.Mutation, e.LuckyBlockId ~= nil)
	end

	return lost
end
DropCarriedLuckyOnFallBindable.Parent = script
