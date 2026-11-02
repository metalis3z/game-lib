-- RarityItemSpawner: spawns floating rarity loot in the underground zones
-- (Workspace.Assets.Map.Zone1..30). Deeper zone = rarer pool (RarityItemsConfig).
-- Players pick items up with E (gated by MaxLootStorage), carry them while
-- underground, and the loot auto-claims when they reach the surface. Claimed
-- loot is sold at the SellShop prompt.
--
-- Mirrors IslandLuckyBlockSpawner's structure: server owns the world models +
-- prompts, RarityLootClient renders billboards, bob/spin and pickup FX.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local RarityItemsConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("RarityItemsConfig"))
local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local LeaderboardService = require(ServerScriptService.Source.Services.LeaderboardService)

-- Store-block loot items (GameConfig.LuckyBlocks[id].IsLootItem) sell at this
-- shop too. Resolved in the BACKGROUND: GameConfig / LuckyBlockService block at
-- require time on content folders + remotes, and a stall there must never
-- stop the zone loot spawners below. Until they resolve, loot-item selling
-- simply no-ops (claimed rarity loot still sells).
local GameConfig, LuckyBlockService, DataUpdateEvent, UpgradeShopService
task.spawn(function()
	GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
	LuckyBlockService = require(ServerScriptService.Source.Services.LuckyBlockService)
	DataUpdateEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayerDataService"):WaitForChild("DataUpdate")
	-- offers the Robux Storage upgrade when a pickup is blocked by full storage
	UpgradeShopService = require(ServerScriptService.Source.Services.UpgradeShopService)
end)

local TEMPLATES = ReplicatedStorage:WaitForChild("RarityItems")
local MAP = Workspace:WaitForChild("Assets"):WaitForChild("Map")

local ZONE_COUNT = 30
local HOVER_LIFT = 1.0
local PICKUP_DISTANCE_LIMIT = 14
local SURFACE_Y = -4 -- matches SurfaceModeController's underground threshold
local DEFAULT_MAX_LOOT = 1
-- Full-storage upgrade offer: cooldown so holding E on a pickup at full storage
-- doesn't spam the Robux prompt.
local STORAGE_PROMPT_COOLDOWN = 4
local storagePromptAt = {} -- [player] = os.clock() of last storage-full upgrade prompt

--------------------------------------------------------------------------------
-- Remotes
--------------------------------------------------------------------------------
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local lootRemotes = Remotes:FindFirstChild("RarityLoot")
if not lootRemotes then
	lootRemotes = Instance.new("Folder")
	lootRemotes.Name = "RarityLoot"
	lootRemotes.Parent = Remotes
end
local function ensureEvent(name)
	local ev = lootRemotes:FindFirstChild(name)
	if not ev then
		ev = Instance.new("RemoteEvent")
		ev.Name = name
		ev.Parent = lootRemotes
	end
	return ev
end
local function ensureFunction(name)
	local rf = lootRemotes:FindFirstChild(name)
	if not rf then
		rf = Instance.new("RemoteFunction")
		rf.Name = name
		rf.Parent = lootRemotes
	end
	return rf
end
local PickupEvent = ensureEvent("Pickup")   -- (player, itemName, rarity, pivotCFrame) -> the picking player ONLY
local ClaimedEvent = ensureEvent("Claimed") -- (itemNames, totalValue) -> owner
local DeniedEvent = ensureEvent("Denied")   -- (reason) -> owner
local SoldEvent = ensureEvent("Sold")       -- (count, totalValue) -> owner
local LootChangedEvent = ensureEvent("LootChanged") -- (claimedList) -> owner
local BoardSpawnEvent = ensureEvent("BoardSpawn")   -- (rarity, zoneLabel, itemName) -> all clients (rainbow toast)
local EquipLootToolEvent = ensureEvent("EquipLootTool") -- (uid) client -> server toggle equip
local GetClaimedLootFunc = ensureFunction("GetClaimedLoot") -- () -> claimedList
local SellLootItemFunc = ensureFunction("SellLootItem")     -- (uid) -> {Success, Amount}
local SellAllLootFunc = ensureFunction("SellAllLoot")       -- () -> {Success, Amount, Count}

local liveFolder = Workspace:FindFirstChild("RarityLootLive")
if not liveFolder then
	liveFolder = Instance.new("Folder")
	liveFolder.Name = "RarityLootLive"
	liveFolder.Parent = Workspace
end

--------------------------------------------------------------------------------
-- Per-player loot state (session)
--------------------------------------------------------------------------------
local carried = {} -- [player] = { {Item=, Rarity=, Value=}, ... } while underground
local claimed = {} -- [player] = { ... } after reaching surface, sellable
local persistentLoaded = {} -- [player] = true once profile PersistentLoot merged in

local function refreshAttributes(player)
	local c = carried[player] or {}
	local cl = claimed[player] or {}
	local claimedValue = 0
	for _, e in ipairs(cl) do claimedValue += e.Value end
	player:SetAttribute("LootCarried", #c)
	player:SetAttribute("LootClaimed", #cl)
	player:SetAttribute("LootClaimedValue", claimedValue)
end

local function pushClaimed(player)
	LootChangedEvent:FireClient(player, claimed[player] or {})
end

-- First-ever pickup of an item name unlocks its card in the Index
-- (persisted; IndexController listens to the LootDiscovered DataUpdate).
local function markDiscovered(player, itemName)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then return end
	if type(data.LootDiscovered) ~= "table" then
		data.LootDiscovered = {}
	end
	if data.LootDiscovered[itemName] then return end
	data.LootDiscovered[itemName] = true
	PlayerDataService.SetStat(player, "LootDiscovered", data.LootDiscovered)
	PlayerDataService.ScheduleSave(player)
end

local function setupPlayer(player)
	carried[player] = {}
	claimed[player] = {}
	if player:GetAttribute("MaxLootStorage") == nil then
		player:SetAttribute("MaxLootStorage", DEFAULT_MAX_LOOT)
	end
	refreshAttributes(player)
	pushClaimed(player)
end
Players.PlayerAdded:Connect(setupPlayer)
for _, p in ipairs(Players:GetPlayers()) do setupPlayer(p) end
Players.PlayerRemoving:Connect(function(player)
	carried[player] = nil
	claimed[player] = nil
	persistentLoaded[player] = nil
	storagePromptAt[player] = nil
end)

--------------------------------------------------------------------------------
-- Claimed loot -> equippable Tools in the player's Backpack. The tool carries
-- LootUid so selling can find and remove it; tools are re-granted on respawn
-- because the Backpack resets with the character.
--------------------------------------------------------------------------------
local TOOL_MAX_EXTENT = 2.5

local function buildLootTool(entry)
	local tierFolder = TEMPLATES:FindFirstChild(entry.Rarity or "")
	local template = tierFolder and tierFolder:FindFirstChild(entry.Item or "")
	if not template then return nil end

	local model = template:Clone()
	local _, bbSize = model:GetBoundingBox()
	local maxExt = math.max(bbSize.X, bbSize.Y, bbSize.Z)
	if maxExt > TOOL_MAX_EXTENT then
		pcall(function() model:ScaleTo(model:GetScale() * TOOL_MAX_EXTENT / maxExt) end)
	end

	local tool = Instance.new("Tool")
	tool.Name = entry.Item
	tool.ToolTip = entry.Item
	tool.CanBeDropped = false
	tool.RequiresHandle = true
	tool:SetAttribute("RarityLootTool", true)
	tool:SetAttribute("LootUid", entry.Uid)
	tool:SetAttribute("LootRarity", entry.Rarity)
	tool:SetAttribute("LootValue", entry.Value)

	local bbCF = model:GetBoundingBox()
	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(0.6, 0.6, 0.6)
	handle.Transparency = 1
	handle.CanCollide = false
	handle.Massless = true
	handle.CFrame = bbCF
	handle.Parent = tool

	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			d.Massless = true
			local w = Instance.new("Weld")
			w.Part0 = handle
			w.Part1 = d
			w.C0 = handle.CFrame:ToObjectSpace(d.CFrame)
			w.Parent = handle
		end
	end
	-- unanchor AFTER welding so nothing falls for a physics step
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = false
		end
	end
	model.Parent = tool
	return tool
end

local function removeLootTool(player, uid)
	local function scan(container)
		if not container then return end
		for _, t in ipairs(container:GetChildren()) do
			if t:IsA("Tool") and t:GetAttribute("LootUid") == uid then
				t:Destroy()
			end
		end
	end
	scan(player:FindFirstChild("Backpack"))
	scan(player.Character)
end

local function giveLootTool(player, entry)
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then return end
	removeLootTool(player, entry.Uid) -- no duplicates on regrant
	local tool = buildLootTool(entry)
	if tool then tool.Parent = backpack end
end

local function regrantLootTools(player)
	for _, entry in ipairs(claimed[player] or {}) do
		giveLootTool(player, entry)
	end
end

local function hookRespawn(player)
	player.CharacterAdded:Connect(function()
		task.wait(0.6)
		regrantLootTools(player)
	end)
end
Players.PlayerAdded:Connect(hookRespawn)
for _, p in ipairs(Players:GetPlayers()) do hookRespawn(p) end

--------------------------------------------------------------------------------
-- Persistent loot: paid pedestal grants (Dragon Egg etc.) survive a rejoin.
-- Farmed loot stays session-only (mine -> surface -> sell); only entries whose
-- in-memory record carries Persist=true are mirrored into profile.PersistentLoot.
-- savePersistentLoot recomputes that profile field from the live claimed list,
-- so it is safe to call after ANY change to a player's claimed loot.
--------------------------------------------------------------------------------
local function savePersistentLoot(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then return end
	local out = {}
	for _, e in ipairs(claimed[player] or {}) do
		if e.Persist then
			out[#out + 1] = { Item = e.Item, Rarity = e.Rarity, Value = e.Value, Uid = e.Uid }
		end
	end
	-- Write straight to the profile table: SetStat only assigns when the key
	-- already exists in the loaded profile, which silently drops the very first
	-- write on any profile that predates the PersistentLoot template field.
	data.PersistentLoot = out
	PlayerDataService.ScheduleSave(player)
end

local function loadPersistentLoot(player, data)
	if persistentLoaded[player] then return end
	data = data or PlayerDataService.GetPlayerData(player)
	if not data or type(data.PersistentLoot) ~= "table" then return end
	persistentLoaded[player] = true
	local list = claimed[player]
	if not list then
		claimed[player] = {}
		list = claimed[player]
	end
	for _, e in ipairs(data.PersistentLoot) do
		if type(e) == "table" and e.Item and e.Rarity then
			table.insert(list, {
				Item = e.Item,
				Rarity = e.Rarity,
				Value = e.Value or RarityItemsConfig.GetItemValue(e.Item),
				Uid = e.Uid or HttpService:GenerateGUID(false),
				Persist = true,
			})
		end
	end
	refreshAttributes(player)
	pushClaimed(player)
	-- grant tools now if the character is already up; otherwise hookRespawn's
	-- CharacterAdded regrants them on the next spawn
	if player.Character then
		regrantLootTools(player)
	end
end

PlayerDataService.ProfileLoaded.Event:Connect(loadPersistentLoot)
-- players already in-game when this script starts (Studio playtest / hot-reload):
-- their ProfileLoaded may have fired before we connected above, so poll until
-- their data is available. The persistentLoaded flag prevents a double-load if
-- ProfileLoaded also fires.
for _, p in ipairs(Players:GetPlayers()) do
	task.spawn(function()
		for _ = 1, 20 do
			if persistentLoaded[p] or not p.Parent then return end
			local d = PlayerDataService.GetPlayerData(p)
			if d then
				loadPersistentLoot(p, d)
				return
			end
			task.wait(0.5)
		end
	end)
end

--------------------------------------------------------------------------------
-- Zone geometry
--------------------------------------------------------------------------------
-- Items spawn ONLY on each zone's island platform (Assets.Islands.Zone<N>Island
-- -- the perfectly-scaled part the lucky blocks used to spawn on).
local ISLANDS_FOLDER = Workspace.Assets:WaitForChild("Islands")
local ISLAND_EDGE_MARGIN = 5

local zones = {} -- { {island=, active=} }
for i = 1, ZONE_COUNT do
	local island = ISLANDS_FOLDER:FindFirstChild("Zone" .. i .. "Island")
	if island and island:IsA("BasePart") then
		zones[i] = {
			island = island,
			active = {}, -- [slotKey] = {x=, z=} live item positions for separation
		}
	else
		warn("[RarityItemSpawner] missing island part 'Zone" .. i .. "Island' in Assets.Islands")
	end
end

local function farEnough(zone, x, z)
	local minSep = RarityItemsConfig.MinSeparation or 10
	for _, p in pairs(zone.active) do
		local dx, dz = p.x - x, p.z - z
		if (dx * dx + dz * dz) < (minSep * minSep) then
			return false
		end
	end
	return true
end

local function findSpawnPoint(zone)
	local island = zone.island
	local topY = island.Position.Y + island.Size.Y / 2
	local hx = math.max(1, island.Size.X / 2 - ISLAND_EDGE_MARGIN)
	local hz = math.max(1, island.Size.Z / 2 - ISLAND_EDGE_MARGIN)
	for _ = 1, 20 do
		local lx = (math.random() * 2 - 1) * hx
		local lz = (math.random() * 2 - 1) * hz
		local p = (island.CFrame * CFrame.new(lx, 0, lz)).Position
		if farEnough(zone, p.X, p.Z) then
			return Vector3.new(p.X, topY, p.Z)
		end
	end
	return nil
end

--------------------------------------------------------------------------------
-- Spawning
--------------------------------------------------------------------------------
local function pickFromPool(pool)
	local total = 0
	for _, entry in ipairs(pool) do total += entry.Weight end
	if total <= 0 then return nil end
	local roll = math.random() * total
	for _, entry in ipairs(pool) do
		roll -= entry.Weight
		if roll <= 0 then return entry.Rarity end
	end
	return pool[#pool].Rarity
end

local function pickItem(zoneIndex)
	local pool = RarityItemsConfig.GetZonePool(zoneIndex)
	local rarityName = pickFromPool(pool)
	if not rarityName then return nil end
	-- zone-windowed subset: the item lineup rotates across the rarity's
	-- range instead of every zone offering the full list
	local list = RarityItemsConfig.GetZoneItemPool(rarityName, zoneIndex)
	if not list or #list == 0 then return nil end
	return list[math.random(1, #list)], rarityName
end

local function spawnItem(zoneIndex, zone, slotKey, forcedItem, forcedRarity)
	local itemName, rarityName
	if forcedItem then
		itemName, rarityName = forcedItem, forcedRarity
	else
		itemName, rarityName = pickItem(zoneIndex)
	end
	if not itemName then return nil, nil end
	local rarityCfg = RarityItemsConfig.Rarities[rarityName]
	local template = TEMPLATES:FindFirstChild(rarityName) and TEMPLATES[rarityName]:FindFirstChild(itemName)
	if not template then
		warn("[RarityItemSpawner] missing template: " .. rarityName .. "." .. itemName)
		return nil, nil
	end
	local point = findSpawnPoint(zone)
	if not point then return nil, nil end
	zone.active[slotKey] = { x = point.X, z = point.Z }

	local clone = template:Clone()
	local yaw = math.random() * math.pi * 2
	clone:PivotTo(CFrame.new(point) * CFrame.Angles(0, yaw, 0))
	local bbCF, bbSize = clone:GetBoundingBox()
	local desiredBottom = point.Y + HOVER_LIFT
	local currentBottom = bbCF.Position.Y - bbSize.Y / 2
	clone:PivotTo(clone:GetPivot() + Vector3.new(0, desiredBottom - currentBottom, 0))

	local lifetime = rarityCfg.LifeMin + math.random() * (rarityCfg.LifeMax - rarityCfg.LifeMin)
	clone:SetAttribute("RarityLootItem", true)
	clone:SetAttribute("ItemId", itemName)
	clone:SetAttribute("DisplayName", itemName)
	clone:SetAttribute("Rarity", rarityName)
	clone:SetAttribute("Value", RarityItemsConfig.GetItemValue(itemName))
	clone:SetAttribute("SpawnedAt", Workspace:GetServerTimeNow())
	clone:SetAttribute("Lifetime", lifetime)
	clone:SetAttribute("ZoneName", "Zone" .. zoneIndex)
	clone:SetAttribute("SpawnId", HttpService:GenerateGUID(false))
	clone.Parent = liveFolder

	local state = { collected = false }

	local primary = clone.PrimaryPart or clone:FindFirstChildWhichIsA("BasePart", true)
	if not primary then
		clone:Destroy()
		return nil, nil
	end

	local promptAttachment = Instance.new("Attachment")
	promptAttachment.Name = "PromptAttachment"
	promptAttachment.Position = primary.CFrame:PointToObjectSpace(clone:GetBoundingBox().Position)
	promptAttachment.Parent = primary

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Pick Up"
	prompt.ObjectText = itemName
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.HoldDuration = 1
	prompt:SetAttribute("GrabZoom", true)
	prompt.MaxActivationDistance = 12
	prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt.RequiresLineOfSight = false
	prompt.Parent = promptAttachment

	prompt.Triggered:Connect(function(triggerPlayer)
		if state.collected then return end
		local character = triggerPlayer.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp or not clone.Parent then return end
		if (hrp.Position - clone:GetPivot().Position).Magnitude > PICKUP_DISTANCE_LIMIT then return end

		local list = carried[triggerPlayer]
		if not list then return end
		local maxLoot = tonumber(triggerPlayer:GetAttribute("MaxLootStorage")) or DEFAULT_MAX_LOOT
		if #list >= maxLoot then
			DeniedEvent:FireClient(triggerPlayer, "full")
			-- Storage full: offer the Robux Storage upgrade (escalating ladder
			-- product for the player's current level). Cooldown-gated so holding E
			-- doesn't spam the prompt; no-ops silently once Storage is maxed.
			if UpgradeShopService and UpgradeShopService.PromptRobuxUpgrade then
				local now = os.clock()
				local last = storagePromptAt[triggerPlayer]
				if not last or now - last >= STORAGE_PROMPT_COOLDOWN then
					storagePromptAt[triggerPlayer] = now
					pcall(function()
						UpgradeShopService.PromptRobuxUpgrade(triggerPlayer, "Storage")
					end)
				end
			end
			return
		end

		state.collected = true
		table.insert(list, { Item = itemName, Rarity = rarityName, Value = RarityItemsConfig.GetItemValue(itemName) })
		markDiscovered(triggerPlayer, itemName)
		refreshAttributes(triggerPlayer)
		-- pickup FX (flying item + trail + burst in RarityLootClient) is
		-- PER-PLAYER: only the picker sees their own celebration. The player
		-- arg is kept in the payload so the client handler signature (and the
		-- TutorialController `who == player` check) stays unchanged.
		PickupEvent:FireClient(triggerPlayer, triggerPlayer, itemName, rarityName, clone:GetPivot())
		clone:Destroy()
	end)

	return clone, state
end

local function runZoneSlot(zoneIndex, zone)
	local slotKey = {}
	while true do
		local clone, state = spawnItem(zoneIndex, zone, slotKey)
		if clone and state then
			local lifetime = clone:GetAttribute("Lifetime") or 60
			local spawnedAt = os.clock()
			while not state.collected and os.clock() - spawnedAt < lifetime do
				task.wait(0.25)
			end
			if not state.collected and clone.Parent then
				clone:Destroy()
			end
		end
		zone.active[slotKey] = nil
		task.wait(RarityItemsConfig.RespawnDelayMin + math.random() * (RarityItemsConfig.RespawnDelayMax - RarityItemsConfig.RespawnDelayMin))
	end
end

for zoneIndex, zone in pairs(zones) do
	for _ = 1, RarityItemsConfig.SlotsPerZone do
		task.spawn(function()
			task.wait(math.random() * 4)
			runZoneSlot(zoneIndex, zone)
		end)
	end
end

--------------------------------------------------------------------------------
-- Spawn Board (Workspace.SpawnBoard): fixed countdowns; each expiry force-
-- spawns one random item of that rarity in Zone 1 as an EXTRA drop on top of
-- the normal slots, then the countdown restarts. SpawnBoardClient renders the
-- timers from the SpawnAt<Rarity> attributes (server-time deadlines).
--------------------------------------------------------------------------------
local BOARD_TIMERS = {
	-- user-set cadence 2026-07-21: Legendary 10m / Mythic 30m / Secret 60m
	{ Rarity = "Legendary", Interval = 10 * 60 },
	{ Rarity = "Mythic", Interval = 30 * 60 },
	{ Rarity = "Secret", Interval = 60 * 60 },
}

local boardFolder = Workspace:FindFirstChild("SpawnBoard")
if boardFolder and zones[1] then
	for _, timerCfg in ipairs(BOARD_TIMERS) do
		task.spawn(function()
			while true do
				boardFolder:SetAttribute("SpawnAt" .. timerCfg.Rarity, Workspace:GetServerTimeNow() + timerCfg.Interval)
				task.wait(timerCfg.Interval)
				-- any item of the rarity that actually has a template (the
				-- full list, not the zone window -- the board drop is special);
				-- NoNaturalSpawn items (paid pedestal exclusives) never drop
				local candidates = {}
				local tierFolder = TEMPLATES:FindFirstChild(timerCfg.Rarity)
				for _, name in ipairs(RarityItemsConfig.Items[timerCfg.Rarity] or {}) do
					if tierFolder and tierFolder:FindFirstChild(name)
						and not RarityItemsConfig.NoNaturalSpawn[name] then
						table.insert(candidates, name)
					end
				end
				if #candidates > 0 then
					local slotKey = {}
					local clone, state = spawnItem(1, zones[1], slotKey, candidates[math.random(#candidates)], timerCfg.Rarity)
					if clone and state then
						-- rainbow toast on every client: "A Mythic has spawned in Zone 1!"
						BoardSpawnEvent:FireAllClients(timerCfg.Rarity, "Zone 1", clone:GetAttribute("ItemId"))
						-- lifetime cleanup runs detached so the next countdown
						-- starts immediately, mirroring runZoneSlot's loop
						task.spawn(function()
							local lifetime = clone:GetAttribute("Lifetime") or 60
							local spawnedAt = os.clock()
							while not state.collected and os.clock() - spawnedAt < lifetime do
								task.wait(0.25)
							end
							if not state.collected and clone.Parent then
								clone:Destroy()
							end
							zones[1].active[slotKey] = nil
						end)
					else
						zones[1].active[slotKey] = nil
					end
				end
			end
		end)
	end
end

--------------------------------------------------------------------------------
-- Surface claim: carried loot converts to claimed (sellable) loot once the
-- player is back above ground.
--------------------------------------------------------------------------------
task.spawn(function()
	while true do
		task.wait(0.5)
		for player, list in pairs(carried) do
			if #list > 0 then
				local character = player.Character
				local hrp = character and character:FindFirstChild("HumanoidRootPart")
				if hrp and hrp.Position.Y >= SURFACE_Y then
					local names = {}
					local total = 0
					local claimedList = claimed[player]
					for _, entry in ipairs(list) do
						entry.Uid = HttpService:GenerateGUID(false)
						table.insert(claimedList, entry)
						table.insert(names, entry.Item)
						total += entry.Value
					end
					carried[player] = {}
					refreshAttributes(player)
					ClaimedEvent:FireClient(player, names, total)
					pushClaimed(player)
					-- only the freshly claimed entries get new tools; older claimed
					-- loot already has its tool in the Backpack
					for _, entry in ipairs(list) do
						giveLootTool(player, entry)
					end
				end
			end
		end
	end
end)

--------------------------------------------------------------------------------
-- Store-block loot items (lucky-block unbox rewards) live in
-- playerData.Inventory (the custom hotbar), NOT in the claimed list above.
-- The sell shop cashes them out too, at their CashReward value.
--------------------------------------------------------------------------------
local INV_LOOT_UID_PREFIX = "invloot:"

local function getInventoryLootList(player)
	if not (GameConfig and LuckyBlockService) then return {} end
	local data = PlayerDataService.GetPlayerData(player)
	local inventory = data and data.Inventory
	if not inventory then return {} end
	local list = {}
	for itemId, amount in pairs(inventory) do
		local cfg = GameConfig.LuckyBlocks[itemId]
		if cfg and cfg.IsLootItem and type(amount) == "number" and amount > 0 then
			table.insert(list, { ItemId = itemId, Cfg = cfg, Amount = amount })
		end
	end
	table.sort(list, function(a, b) return a.ItemId < b.ItemId end)
	return list
end

local function pushInventoryToClient(player)
	if not DataUpdateEvent then return end
	local data = PlayerDataService.GetPlayerData(player)
	if data then
		DataUpdateEvent:FireClient(player, "Inventory", data.Inventory)
	end
end

-- Sells every loot item in the player's inventory; returns (cash, count).
-- RemoveLuckyBlock handles the unequip-on-zero; the explicit DataUpdate push
-- is needed because Remove only fires the server-side DataChanged bindable,
-- and the client hotbar sync listens to the DataUpdate remote.
local function sellInventoryLootItems(player)
	local total, count = 0, 0
	for _, entry in ipairs(getInventoryLootList(player)) do
		if LuckyBlockService.RemoveLuckyBlock(player, entry.ItemId, entry.Amount) then
			total += (entry.Cfg.CashReward or 0) * entry.Amount
			count += entry.Amount
		end
	end
	if count > 0 then
		pushInventoryToClient(player)
	end
	return total, count
end

--------------------------------------------------------------------------------
-- Sell shop prompt: REMOVED (2026-07-16). The runtime instant-sell prompt
-- duplicated the booth's own Prox-part prompt ("Sell Loot" -> opens the Sell
-- UI via ShopProximityController), showing two prompts on the booth with one
-- of them dead. Selling now always goes through the Sell UI, whose Sell-All
-- bar invokes SellAllLootFunc below -- same payout logic, one prompt.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Sell UI remotes: list claimed loot / sell a single claimed item by Uid
--------------------------------------------------------------------------------
GetClaimedLootFunc.OnServerInvoke = function(player)
	-- claimed rarity loot + one synthetic entry per owned store-block loot
	-- item copy, so the Sell UI lists both. The invloot uid round-trips
	-- through SellLootItem below. Copies are capped per item so a huge
	-- stack can't flood the UI (Sell All still sells everything).
	local result = {}
	for _, entry in ipairs(claimed[player] or {}) do
		table.insert(result, entry)
	end
	for _, inv in ipairs(getInventoryLootList(player)) do
		for i = 1, math.min(inv.Amount, 50) do
			table.insert(result, {
				Item = inv.Cfg.DisplayName or inv.ItemId,
				ModelName = inv.Cfg.ModelName or inv.ItemId,
				LootFolder = inv.Cfg.LootFolder,
				Rarity = inv.Cfg.Rarity or "Common",
				Value = inv.Cfg.CashReward or 0,
				Uid = INV_LOOT_UID_PREFIX .. inv.ItemId .. ":" .. i,
			})
		end
	end
	return result
end

-- Equip/unequip a loot tool server-side so the equip always replicates.
EquipLootToolEvent.OnServerEvent:Connect(function(player, uid)
	if type(uid) ~= "string" then return end
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end
	local function findTool(container)
		if not container then return nil end
		for _, t in ipairs(container:GetChildren()) do
			if t:IsA("Tool") and t:GetAttribute("LootUid") == uid then
				return t
			end
		end
		return nil
	end
	if findTool(character) then
		humanoid:UnequipTools()
		return
	end
	local tool = findTool(player:FindFirstChild("Backpack"))
	if tool then
		humanoid:UnequipTools()
		humanoid:EquipTool(tool)
	end
end)

SellAllLootFunc.OnServerInvoke = function(player)
	local list = claimed[player] or {}
	local lootTotal, lootCount = sellInventoryLootItems(player)
	if #list == 0 and lootCount == 0 then
		return { Success = false, Amount = 0, Count = 0 }
	end
	local total = lootTotal
	local count = #list + lootCount
	local hadPersist = false
	for _, entry in ipairs(list) do
		total += entry.Value
		removeLootTool(player, entry.Uid)
		if entry.Persist then hadPersist = true end
	end
	claimed[player] = {}
	refreshAttributes(player)
	if hadPersist then
		savePersistentLoot(player)
	end
	if total > 0 then
		PlayerDataService.AddStat(player, "Cash", total)
		pcall(function() LeaderboardService.AddTotalCash(player, total) end)
	end
	SoldEvent:FireClient(player, count, total)
	pushClaimed(player)
	return { Success = true, Amount = total, Count = count }
end

SellLootItemFunc.OnServerInvoke = function(player, uid)
	local list = claimed[player]
	if type(uid) ~= "string" then
		return { Success = false }
	end
	-- store-block loot item copy ("invloot:<itemId>:<n>") from GetClaimedLoot
	if uid:sub(1, #INV_LOOT_UID_PREFIX) == INV_LOOT_UID_PREFIX then
		if not (GameConfig and LuckyBlockService) then return { Success = false } end
		local rest = uid:sub(#INV_LOOT_UID_PREFIX + 1)
		local itemId = rest:match("^(.-):%d+$") or rest
		local cfg = GameConfig.LuckyBlocks[itemId]
		if not (cfg and cfg.IsLootItem) then return { Success = false } end
		if not LuckyBlockService.RemoveLuckyBlock(player, itemId, 1) then
			return { Success = false }
		end
		pushInventoryToClient(player)
		local value = cfg.CashReward or 0
		if value > 0 then
			PlayerDataService.AddStat(player, "Cash", value)
			pcall(function() LeaderboardService.AddTotalCash(player, value) end)
		end
		SoldEvent:FireClient(player, 1, value)
		pushClaimed(player)
		return { Success = true, Amount = value }
	end
	if not list then
		return { Success = false }
	end
	for i, entry in ipairs(list) do
		if entry.Uid == uid then
			table.remove(list, i)
			removeLootTool(player, uid)
			refreshAttributes(player)
			if entry.Persist then
				savePersistentLoot(player)
			end
			if entry.Value > 0 then
				PlayerDataService.AddStat(player, "Cash", entry.Value)
				pcall(function() LeaderboardService.AddTotalCash(player, entry.Value) end)
			end
			SoldEvent:FireClient(player, 1, entry.Value)
			pushClaimed(player)
			return { Success = true, Amount = entry.Value }
		end
	end
	return { Success = false }
end

--------------------------------------------------------------------------------
-- Gifting: GiftService moves one claimed entry (by Uid) between two players'
-- session lists when the giver holds the loot Tool and hold-triggers the Gift
-- prompt on the receiver. Exposed as a BindableFunction because carried/claimed
-- are script-local. Returns the moved entry on success, nil otherwise.
--------------------------------------------------------------------------------
local GiftClaimedLootFunc = Instance.new("BindableFunction")
GiftClaimedLootFunc.Name = "GiftClaimedLoot"
GiftClaimedLootFunc.Parent = script

GiftClaimedLootFunc.OnInvoke = function(giver, receiver, uid)
	local giverList = claimed[giver]
	local receiverList = claimed[receiver]
	if not giverList or not receiverList then return nil end
	for i, entry in ipairs(giverList) do
		if entry.Uid == uid then
			table.remove(giverList, i)
			removeLootTool(giver, uid)
			refreshAttributes(giver)
			pushClaimed(giver)

			table.insert(receiverList, entry)
			markDiscovered(receiver, entry.Item)
			refreshAttributes(receiver)
			pushClaimed(receiver)
			giveLootTool(receiver, entry)
			-- a persistent (paid) item keeps its persistence with the receiver:
			-- recompute both sides so the giver loses it and the receiver keeps it
			-- across their own rejoins
			if entry.Persist then
				savePersistentLoot(giver)
				savePersistentLoot(receiver)
			end
			return { Item = entry.Item, Rarity = entry.Rarity, Value = entry.Value }
		end
	end
	return nil
end

--------------------------------------------------------------------------------
-- Dev-product grant: DevProductPedestalServer invokes this after a successful
-- Robux purchase to hand the buyer a claimed copy of the pedestal's loot item.
-- Mirrors the receiving half of GiftClaimedLoot (claimed/carried are
-- script-local). Returns the granted entry on success, nil otherwise.
--------------------------------------------------------------------------------
local GrantClaimedLootFunc = Instance.new("BindableFunction")
GrantClaimedLootFunc.Name = "GrantClaimedLoot"
GrantClaimedLootFunc.Parent = script

-- persist=true (paid pedestal grants) makes the entry survive a rejoin; free
-- grants (daily reward, admin) stay session-only exactly as before.
GrantClaimedLootFunc.OnInvoke = function(player, itemName, persist)
	local list = claimed[player]
	if not list then return nil end
	local rarityName = RarityItemsConfig.GetItemRarity(itemName)
	if not rarityName then return nil end
	local entry = {
		Item = itemName,
		Rarity = rarityName,
		Value = RarityItemsConfig.GetItemValue(itemName),
		Uid = HttpService:GenerateGUID(false),
		Persist = persist and true or nil,
	}
	table.insert(list, entry)
	markDiscovered(player, itemName)
	refreshAttributes(player)
	pushClaimed(player)
	giveLootTool(player, entry)
	ClaimedEvent:FireClient(player, { entry.Item }, entry.Value)
	if entry.Persist then
		savePersistentLoot(player)
	end
	return { Item = entry.Item, Rarity = entry.Rarity, Value = entry.Value }
end
