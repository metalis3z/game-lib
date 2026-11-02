-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ServerScriptService/Source/Services/AdminCommandsService.lua  (491 lines)
-- What it does: F2 text console backend: tokenizer, partial-name player lookup, give-anything commands that reuse the real grant paths, aliases, help text, owner-only data wipe, cross-server shutdown via MessagingService.
-- Excerpt of lines 1-28, 40-491 (only the relevant part of a bigger script).
-- Note: Lines 29-39 held the original game's hard-coded ADMIN_IDS and OWNER_USER_ID; they were removed on purpose. Define both with your own UserIds.

-- In-house admin console (ported in concept from the slime place's Cmdr setup,
-- rewritten to match this place's PlayerDataService / MaterialService /
-- ProfileService stack instead of leaderstats + DataStore-direct.
--
-- Commands (admin gated by UserId):
--   givecash <player> <amount>
--   givewood <player> <amount>
--   givebrainrot <player> <brainrotId> [mutation] [amount]
--   resetdata [player]      -- OWNER ONLY: wipes the profile + kicks; no
--                              argument = wipe YOURSELF (fresh-start test)
--   resetme                 -- OWNER ONLY: always wipes YOUR OWN data + kicks
--   resetservers            -- broadcasts a global shutdown to every server
--
-- Client side: StarterPlayer.StarterPlayerScripts.AdminConsoleClient builds the
-- F2 console UI and InvokeServers "RunCommand" with the raw text line.
local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService = game:GetService("HttpService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local PlayerDataService = require(script.Parent.PlayerDataService)
-- MaterialService is required lazily because both modules sit under the same
-- Services folder and MainServer requires us in folder order.
local MaterialService

-- Allowed UserIds. Add more here if other staff need access.

-- ... (lines 29-39 skipped) ...

local AdminCommandsService = {}

local function isAdmin(player)
	return player and ADMIN_IDS[player.UserId] == true
end

-- Looser-than-username match: an admin can type a prefix or a partial. Falls
-- back to exact case-insensitive equality first so unique full names always win.
local function findPlayer(name)
	if type(name) ~= "string" or name == "" then return nil end
	local lower = string.lower(name)
	for _, p in ipairs(Players:GetPlayers()) do
		if string.lower(p.Name) == lower then return p end
		if p.DisplayName and string.lower(p.DisplayName) == lower then return p end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if string.find(string.lower(p.Name), lower, 1, true) then return p end
	end
	return nil
end

local function tokenize(s)
	local out = {}
	for word in string.gmatch(s, "%S+") do
		table.insert(out, word)
	end
	return out
end

--------------------------------------------------------------------------------
-- Commands
--------------------------------------------------------------------------------

local function cmdGiveCash(_executor, args)
	local targetName, amountStr = args[1], args[2]
	if not targetName or not amountStr then
		return "Usage: givecash <player> <amount>"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local amount = tonumber(amountStr)
	if not amount then return "Invalid amount: " .. tostring(amountStr) end
	amount = math.floor(amount)
	local ok = PlayerDataService.AddStat(target, "Cash", amount)
	if not ok then return "AddStat failed (no profile loaded?)" end
	if amount > 0 then
		local LeaderboardService = require(ServerScriptService.Source.Services.LeaderboardService)
		pcall(function() LeaderboardService.AddTotalCash(target, amount) end)
	end
	local data = PlayerDataService.GetPlayerData(target)
	local newBal = data and data.Cash or "?"
	return string.format("Gave $%d to %s (new balance: $%s)", amount, target.Name, tostring(newBal))
end

local function cmdGiveWood(_executor, args)
	local targetName, amountStr = args[1], args[2]
	if not targetName or not amountStr then
		return "Usage: givewood <player> <amount>"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local amount = tonumber(amountStr)
	if not amount then return "Invalid amount: " .. tostring(amountStr) end
	amount = math.floor(amount)
	if not MaterialService then
		MaterialService = require(script.Parent.MaterialService)
	end
	local ok, err = pcall(function()
		MaterialService.AddMaterialOverfill(target, amount)
	end)
	if not ok then return "AddMaterialOverfill error: " .. tostring(err) end
	return string.format("Gave %d wood to %s", amount, target.Name)
end

local function cmdGiveBrainrot(_executor, args)
	local targetName, brainrotId, mutation, amountStr = args[1], args[2], args[3], args[4]
	if not targetName or not brainrotId then
		return "Usage: givebrainrot <player> <brainrotId> [mutation] [amount]"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	if not GameConfig.Items[brainrotId] then
		local names = {}
		for n in pairs(GameConfig.Items) do names[#names + 1] = n end
		table.sort(names)
		return string.format("Unknown brainrotId '%s'. Valid: %s", tostring(brainrotId), table.concat(names, ", "))
	end
	local mut = mutation
	if mut == "Normal" or mut == "normal" or mut == "none" or mut == "" or mut == nil then
		mut = nil
	end
	if mut and not (GameConfig.Mutations and GameConfig.Mutations[mut]) then
		local mlist = {}
		for n in pairs(GameConfig.Mutations or {}) do mlist[#mlist + 1] = n end
		table.sort(mlist)
		return string.format("Unknown mutation '%s'. Valid: Normal, %s", tostring(mutation), table.concat(mlist, ", "))
	end
	local amount = tonumber(amountStr) or 1
	amount = math.clamp(math.floor(amount), 1, 100)

	local data = PlayerDataService.GetPlayerData(target)
	if not data then return "No profile loaded for " .. target.Name end
	data.BrainrotInventory = data.BrainrotInventory or {}
	data.BrainrotUnlocked = data.BrainrotUnlocked or {}

	local ts = os.time()
	for _ = 1, amount do
		local uid = HttpService:GenerateGUID(false)
		data.BrainrotInventory[uid] = {
			BrainrotId = brainrotId,
			Mutation = mut,
			Timestamp = ts,
		}
	end
	if mut and mut ~= "" then
		data.BrainrotUnlocked[mut .. "_" .. brainrotId] = true
	else
		data.BrainrotUnlocked[brainrotId] = true
	end

	PlayerDataService.SetStat(target, "BrainrotInventory", data.BrainrotInventory)
	PlayerDataService.SetStat(target, "BrainrotUnlocked", data.BrainrotUnlocked)
	PlayerDataService.ScheduleSave(target)

	return string.format("Gave %d %s%s to %s", amount, mut and (mut .. " ") or "", brainrotId, target.Name)
end

--------------------------------------------------------------------------------
-- Give-anything commands (ported from "+1 Kick Door" 2026-07-21): every
-- grantable thing in the game, wired through the SAME grant paths the
-- Robux receipts use so state, saves and client payloads all stay
-- correct. Multi-word names are joined from the remaining args; lookups
-- are case-insensitive and bad input prints the valid catalog.
--------------------------------------------------------------------------------

local function catalogKeys(t)
	local names = {}
	for n in pairs(t or {}) do names[#names + 1] = n end
	table.sort(names)
	return table.concat(names, ", ")
end

local function resolveKey(t, query)
	if type(query) ~= "string" or query == "" then return nil end
	local lower = string.lower(query)
	for key in pairs(t or {}) do
		if string.lower(key) == lower then return key end
	end
	return nil
end

local function cmdGiveStrength(_executor, args)
	local targetName, amountStr = args[1], args[2]
	if not targetName or not amountStr then
		return "Usage: givestrength <player> <amount>"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local amount = math.floor(tonumber(amountStr) or 0)
	if amount < 1 then return "Invalid amount: " .. tostring(amountStr) end
	local clickServer = ServerScriptService:FindFirstChild("StrengthClickServer")
	local grant = clickServer and clickServer:FindFirstChild("GrantStrength")
	if not grant then return "GrantStrength bindable not found" end
	grant:Fire(target, amount)
	return string.format("Gave %d Strength (+XP, levels roll over) to %s", amount, target.Name)
end

local function cmdGiveLoot(_executor, args)
	local targetName = args[1]
	local itemQuery = table.concat(args, " ", 2)
	if not targetName or itemQuery == "" then
		return "Usage: giveloot <player> <item name>  (e.g. giveloot Valzoq Golden Key)"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local RarityItemsConfig = require(ReplicatedStorage.Source.Configs.RarityItemsConfig)
	local proper, properRarity
	local lowerQuery = string.lower(itemQuery)
	for rarityName, list in pairs(RarityItemsConfig.Items) do
		for _, name in ipairs(list) do
			if string.lower(name) == lowerQuery then
				proper, properRarity = name, rarityName
				break
			end
		end
		if proper then break end
	end
	if not proper then
		return "Unknown loot item '" .. itemQuery .. "' (names as in the Index, e.g. Golden Key / Dragon Egg)"
	end
	local spawner = ServerScriptService:FindFirstChild("RarityItemSpawner")
	local grant = spawner and spawner:FindFirstChild("GrantClaimedLoot")
	if not grant then return "GrantClaimedLoot bindable not found" end
	local result = grant:Invoke(target, proper)
	if not result then return "Grant failed (no profile loaded?)" end
	return string.format("Gave %s (%s) to %s", proper, properRarity, target.Name)
end

local function cmdGiveBlock(_executor, args)
	local targetName, blockQuery, amountStr = args[1], args[2], args[3]
	if not targetName or not blockQuery then
		return "Usage: giveblock <player> <blockId> [amount]"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local proper = resolveKey(GameConfig.LuckyBlocks, blockQuery)
	if not proper then
		return "Unknown blockId '" .. tostring(blockQuery) .. "'. Valid: " .. catalogKeys(GameConfig.LuckyBlocks)
	end
	local amount = math.clamp(math.floor(tonumber(amountStr) or 1), 1, 100)
	local LuckyBlockService = require(script.Parent.LuckyBlockService)
	local ok = LuckyBlockService.AddLuckyBlock(target, proper, amount)
	if not ok then return "AddLuckyBlock failed (no profile loaded?)" end
	return string.format("Gave %dx %s to %s", amount, proper, target.Name)
end

local function cmdGiveDrill(_executor, args)
	local targetName = args[1]
	local drillQuery = table.concat(args, " ", 2)
	if not targetName or drillQuery == "" then
		return "Usage: givedrill <player> <drillName>"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local proper = resolveKey(GameConfig.Drills, drillQuery)
	if not proper then
		return "Unknown drill '" .. drillQuery .. "'. Valid: " .. catalogKeys(GameConfig.Drills)
	end
	local DrillShopService = require(script.Parent.DrillShopService)
	if not DrillShopService.GrantDrill(target, proper) then
		return "GrantDrill failed (no profile loaded?)"
	end
	return string.format("Gave + equipped %s on %s", proper, target.Name)
end

local function cmdGiveTrail(_executor, args)
	local targetName = args[1]
	local trailQuery = table.concat(args, " ", 2)
	if not targetName or trailQuery == "" then
		return "Usage: givetrail <player> <trail name>"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local proper = resolveKey(GameConfig.Trails, trailQuery)
	if not proper then
		local lower = string.lower(trailQuery)
		for key, cfg in pairs(GameConfig.Trails or {}) do
			if cfg.DisplayName and string.lower(cfg.DisplayName) == lower then
				proper = key
				break
			end
		end
	end
	if not proper then
		return "Unknown trail '" .. trailQuery .. "'. Valid: " .. catalogKeys(GameConfig.Trails)
	end
	local TrailShopService = require(script.Parent.TrailShopService)
	if not TrailShopService.GrantTrail(target, proper) then
		return "GrantTrail failed (no profile loaded?)"
	end
	return string.format("Gave + equipped %s on %s", proper, target.Name)
end

local function cmdGiveRebirth(_executor, args)
	local targetName, countStr = args[1], args[2]
	if not targetName then
		return "Usage: giverebirth <player> [count]"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local count = math.clamp(math.floor(tonumber(countStr) or 1), 1, 100)
	local RebirthService = require(script.Parent.RebirthService)
	local granted = 0
	for _ = 1, count do
		if RebirthService.GrantRebirth(target) then granted += 1 end
	end
	if granted == 0 then return "GrantRebirth failed (no profile loaded?)" end
	return string.format("Gave %d rebirth(s) to %s (Strength/Level reset like a real rebirth)", granted, target.Name)
end

local UPGRADE_STATS = { Storage = true, Walkspeed = true, Damage = true, Carry = true }

local function cmdGiveUpgrade(_executor, args)
	local targetName, statQuery, countStr = args[1], args[2], args[3]
	if not targetName or not statQuery then
		return "Usage: giveupgrade <player> <Storage|Walkspeed|Damage|Carry> [levels]"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local proper = resolveKey(UPGRADE_STATS, statQuery)
	if not proper then
		return "Unknown stat '" .. tostring(statQuery) .. "'. Valid: Storage, Walkspeed, Damage, Carry"
	end
	local count = math.clamp(math.floor(tonumber(countStr) or 1), 1, 500)
	local UpgradeShopService = require(script.Parent.UpgradeShopService)
	if not UpgradeShopService.GrantLevels(target, proper, count) then
		return "GrantLevels failed (no profile loaded?)"
	end
	return string.format("Gave +%d %s level(s) to %s (capped at the stat's MaxLevel)", count, proper, target.Name)
end

local function cmdGivePass(_executor, args)
	local targetName, passQuery = args[1], args[2]
	if not targetName or not passQuery then
		return "Usage: givepass <player> <passKey>"
	end
	local target = findPlayer(targetName)
	if not target then return "Player not found: " .. tostring(targetName) end
	local passes = GameConfig.Shop and GameConfig.Shop.Passes
	local proper = resolveKey(passes, passQuery)
	if not proper then
		return "Unknown pass '" .. tostring(passQuery) .. "'. Valid: " .. catalogKeys(passes)
	end
	-- SESSION-ONLY soft grant: every consumer checks the mirrored
	-- OwnsGamepass_<key> attribute, and GamepassService re-mirrors real
	-- ownership on the next join -- so this never fakes a permanent pass.
	target:SetAttribute("OwnsGamepass_" .. proper, true)
	return string.format("Unlocked %s for %s (THIS SESSION ONLY -- resets on rejoin)", proper, target.Name)
end

local function cmdResetData(executor, args)
	-- destructive: gated to the game owner alone, NOT the general admin list
	if not executor or executor.UserId ~= OWNER_USER_ID then
		return "Only the game owner can reset data."
	end
	local targetName = args[1]
	local target
	if targetName then
		target = findPlayer(targetName)
		if not target then return "Player not found: " .. tostring(targetName) end
	else
		-- no argument = wipe YOURSELF: the owner's quick "rejoin as a brand
		-- new player" testing path
		target = executor
	end
	local playerName = target.Name
	local ok = PlayerDataService.WipePlayerData(target)
	if not ok then return "WipePlayerData failed for " .. playerName end
	return "Reset data and kicked " .. playerName
end

local function cmdResetServers(_executor, _args)
	local ok, err = pcall(function()
		MessagingService:PublishAsync("AdminGlobalShutdown", { sender = "admin" })
	end)
	if not ok then
		return "Failed to broadcast: " .. tostring(err)
	end
	return "Global server reset sent. Every server will kick + restart."
end

local function cmdHelp()
	return table.concat({
		"Commands:",
		"  givecash <player> <amount>",
		"  givestrength <player> <amount>",
		"  giveloot <player> <item name>        (Index names, e.g. Golden Key)",
		"  giveblock <player> <blockId> [amt]   (lucky blocks + store loot)",
		"  givedrill <player> <drillName>",
		"  givetrail <player> <trail name>",
		"  giverebirth <player> [count]",
		"  giveupgrade <player> <stat> [levels] (Storage/Walkspeed/Damage/Carry)",
		"  givepass <player> <passKey>          (session only)",
		"  givewood <player> <amount>",
		"  givebrainrot <player> <brainrotId> [mutation] [amount]",
		"  resetdata [player]   (owner only; no arg = reset yourself)",
		"  resetme              (owner only; wipes YOUR data + kicks you)",
		"  resetservers",
	}, "\n")
end

local COMMANDS = {
	givecash = cmdGiveCash, gc = cmdGiveCash, givemoney = cmdGiveCash,
	givewood = cmdGiveWood, gw = cmdGiveWood, givematerial = cmdGiveWood,
	givebrainrot = cmdGiveBrainrot, gb = cmdGiveBrainrot,
	givestrength = cmdGiveStrength, gs = cmdGiveStrength,
	giveloot = cmdGiveLoot, gl = cmdGiveLoot, giveitem = cmdGiveLoot,
	giveblock = cmdGiveBlock, glb = cmdGiveBlock, giveluckyblock = cmdGiveBlock,
	givedrill = cmdGiveDrill, gd = cmdGiveDrill,
	givetrail = cmdGiveTrail, gt = cmdGiveTrail,
	giverebirth = cmdGiveRebirth, gr = cmdGiveRebirth,
	giveupgrade = cmdGiveUpgrade, gu = cmdGiveUpgrade,
	givepass = cmdGivePass, gp = cmdGivePass,
	resetdata = cmdResetData, wipe = cmdResetData, resetplayer = cmdResetData,
	-- resetme ignores any arguments so it can never hit another player
	resetme = function(executor, _args) return cmdResetData(executor, {}) end,
	resetservers = cmdResetServers, rs = cmdResetServers, shutdownall = cmdResetServers,
	help = cmdHelp, ["?"] = cmdHelp,
}

--------------------------------------------------------------------------------
-- Init: set up RemoteFunction + MessagingService subscriber
--------------------------------------------------------------------------------

function AdminCommandsService.Init()
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local AdminFolder = Remotes:FindFirstChild("AdminCommands")
	if not AdminFolder then
		AdminFolder = Instance.new("Folder")
		AdminFolder.Name = "AdminCommands"
		AdminFolder.Parent = Remotes
	end
	local RunCommandFunc = AdminFolder:FindFirstChild("RunCommand")
	if not RunCommandFunc then
		RunCommandFunc = Instance.new("RemoteFunction")
		RunCommandFunc.Name = "RunCommand"
		RunCommandFunc.Parent = AdminFolder
	end
	local IsAdminFunc = AdminFolder:FindFirstChild("IsAdmin")
	if not IsAdminFunc then
		IsAdminFunc = Instance.new("RemoteFunction")
		IsAdminFunc.Name = "IsAdmin"
		IsAdminFunc.Parent = AdminFolder
	end

	RunCommandFunc.OnServerInvoke = function(player, commandText)
		if not isAdmin(player) then return "You don't have permission to run this command." end
		if type(commandText) ~= "string" then return "Invalid input." end
		local args = tokenize(commandText)
		if #args == 0 then return "" end
		local name = string.lower(table.remove(args, 1))
		local handler = COMMANDS[name]
		if not handler then
			return string.format("Unknown command '%s'. Type 'help' for a list.", name)
		end
		local ok, result = pcall(handler, player, args)
		if not ok then return "Error: " .. tostring(result) end
		return result or "OK"
	end

	IsAdminFunc.OnServerInvoke = function(player)
		return isAdmin(player) == true
	end

	-- Server-reset subscriber: when ANY server publishes AdminGlobalShutdown,
	-- kick every player here so they reconnect into a fresh server. Saves run
	-- automatically via PlayerRemoving → onPlayerRemoving → profile:Release.
	local subOk, subErr = pcall(function()
		MessagingService:SubscribeAsync("AdminGlobalShutdown", function()
			for _, p in ipairs(Players:GetPlayers()) do
				task.spawn(function()
					pcall(function() p:Kick("Server reset by admin. Please rejoin.") end)
				end)
			end
		end)
	end)
	if not subOk then
		warn("[AdminCommandsService] MessagingService subscribe failed: " .. tostring(subErr))
	end
end

return AdminCommandsService
