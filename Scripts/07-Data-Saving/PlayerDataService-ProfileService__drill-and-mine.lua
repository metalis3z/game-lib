-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ServerScriptService/Source/Services/PlayerDataService.lua  (280 lines)
-- What it does: ProfileService load/release, leaderstats mirror, migration sweep that drops items no longer in config, debounced ScheduleSave, and an admin data wipe (WipeProfileAsync).

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ProfileService = require(ServerScriptService.ServerPackages.ProfileService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local RemotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local ServiceRemotes = RemotesFolder:WaitForChild("PlayerDataService")
local DataUpdateEvent = ServiceRemotes:WaitForChild("DataUpdate")
local RequestDataFunc = ServiceRemotes:WaitForChild("RequestData")

local PlayerDataService = {}

PlayerDataService.ProfileLoaded = Instance.new("BindableEvent")
PlayerDataService.DataChanged = Instance.new("BindableEvent")
PlayerDataService.ProfileReleased = Instance.new("BindableEvent")

local PlayerProfiles = {}
local WipingPlayers = {} -- [player] = true while WipePlayerData is releasing their profile
local ProfileStore = ProfileService.GetProfileStore("PlayerData_V1", GameConfig.Data.PlayerDataTemplate)

local SAVE_DEBOUNCE_SECONDS = 2
local pendingSaveAt = {}

local LeaderstatsCache = {}

local function setupLeaderstats(player, profile)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"

	local cash = Instance.new("IntValue")
	cash.Name = "Cash"
	cash.Value = profile.Data.Cash or 0
	cash.Parent = leaderstats

	local rebirth = Instance.new("IntValue")
	rebirth.Name = "Rebirths"
	rebirth.Value = profile.Data.Rebirths or 0
	rebirth.Parent = leaderstats

	leaderstats.Parent = player
	LeaderstatsCache[player] = leaderstats
end

local function updateLeaderstatVisual(player, statName, value)
	local leaderstats = LeaderstatsCache[player]
	if leaderstats then
		local statObj = leaderstats:FindFirstChild(statName)
		if statObj then
			statObj.Value = value
		end
	end
end

local function onPlayerAdded(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)

	if not profile then
		player:Kick("The data could not be loaded. Please rejoin.")
		return
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile()

	-- Migration sweep: drop BrainrotInventory entries whose BrainrotId isn't
	-- in the new pack's GameConfig.Items. Same for the old Inventory map of
	-- lucky-block ids. Stale entries from the previous pack would otherwise
	-- linger as un-equippable / un-placeable hotbar slots forever.
	local GameConfig = require(game:GetService("ReplicatedStorage").Source.Configs.GameConfig)
	local brInv = profile.Data.BrainrotInventory
	if type(brInv) == "table" then
		for uid, entry in pairs(brInv) do
			local id = type(entry) == "table" and entry.BrainrotId or nil
			if not id or not GameConfig.Items[id] then
				brInv[uid] = nil
			end
		end
	end
	local lbInv = profile.Data.Inventory
	if type(lbInv) == "table" then
		for id, amount in pairs(lbInv) do
			if type(amount) ~= "number" or amount <= 0 or not (GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[id]) then
				lbInv[id] = nil
			end
		end
	end
	if profile.Data.EquippedItem ~= "" then
		local eid = profile.Data.EquippedItem
		local stillValid = (brInv and brInv[eid] ~= nil) or (lbInv and lbInv[eid] and lbInv[eid] > 0)
		if not stillValid then
			profile.Data.EquippedItem = ""
		end
	end

	profile:ListenToRelease(function()
		PlayerProfiles[player] = nil
		LeaderstatsCache[player] = nil
		if WipingPlayers[player] then
			-- admin wipe path: give the honest message instead of the
			-- another-server one (a normal leave also releases, but Kick on a
			-- player who already left is a no-op)
			player:Kick("Your data has been reset. Rejoin to start fresh!")
		else
			player:Kick("The profile was loaded on another server.")
		end
	end)

	if not player:IsDescendantOf(Players) then
		profile:Release()
		return
	end

	PlayerProfiles[player] = profile
	setupLeaderstats(player, profile)

	PlayerDataService.ProfileLoaded:Fire(player, profile.Data)
end

local function onPlayerRemoving(player)
	pendingSaveAt[player] = nil
	WipingPlayers[player] = nil
	local profile = PlayerProfiles[player]
	if profile then
		profile:Release()
		PlayerProfiles[player] = nil
		LeaderstatsCache[player] = nil
		PlayerDataService.ProfileReleased:Fire(player)
	end
end

function PlayerDataService.SetStat(player, statName, value)
	local profile = PlayerProfiles[player]
	if not profile then return false end

	local data = profile.Data

	if data[statName] ~= nil then
		data[statName] = value

		updateLeaderstatVisual(player, statName, value)
		DataUpdateEvent:FireClient(player, statName, value)

		PlayerDataService.DataChanged:Fire(player, statName, value)
		return true
	end
	
	return false
end

function PlayerDataService.AddStat(player, statName, amount)
	local profile = PlayerProfiles[player]
	if not profile then return false end

	local currentVal = profile.Data[statName]

	if type(currentVal) == "number" then
		local newValue = currentVal + amount
		return PlayerDataService.SetStat(player, statName, newValue)
	end

	return false
end

function PlayerDataService.GiveBrainrot(player, amount)
	return PlayerDataService.AddStat(player, "Brainrot", amount)
end

function PlayerDataService.RemoveBrainrot(player, amount)
	local profile = PlayerProfiles[player]
	if not profile then return false end

	local current = profile.Data.Brainrot or 0
	if current - amount < 0 then
		return PlayerDataService.SetStat(player, "Brainrot", 0)
	else
		return PlayerDataService.AddStat(player, "Brainrot", -amount)
	end
end

function PlayerDataService.AddItem(player, itemId, amount)
	local profile = PlayerProfiles[player]
	if not profile then return false end

	local inventory = profile.Data.Inventory
	inventory[itemId] = (inventory[itemId] or 0) + amount

	DataUpdateEvent:FireClient(player, "Inventory", inventory)
	PlayerDataService.DataChanged:Fire(player, "Inventory", inventory)
	return true
end

function PlayerDataService.GetPlayerData(player)
	local profile = PlayerProfiles[player]
	return profile and profile.Data
end

function PlayerDataService.ScheduleSave(player)
	local profile = PlayerProfiles[player]
	if not profile then
		return
	end

	local deadline = os.clock() + SAVE_DEBOUNCE_SECONDS
	pendingSaveAt[player] = deadline

	task.delay(SAVE_DEBOUNCE_SECONDS, function()
		if pendingSaveAt[player] ~= deadline then
			return
		end
		pendingSaveAt[player] = nil

		local currentProfile = PlayerProfiles[player]
		if not currentProfile then
			return
		end

		local ok, err = pcall(function()
			currentProfile:Save()
		end)
		if not ok then
			warn(string.format("[PlayerDataService] Save failed for %s: %s", player.Name, tostring(err)))
		end
	end)
end

-- Admin reset: release the live profile (which saves), wipe the DataStore entry,
-- then kick the player so they rejoin with default data. Safe to call once per
-- player -- subsequent calls no-op while the player is offline.
function PlayerDataService.WipePlayerData(player)
	local userId = player.UserId
	local profileKey = "Player_" .. userId
	local profile = PlayerProfiles[player]
	if profile then
		pendingSaveAt[player] = nil
		PlayerProfiles[player] = nil
		LeaderstatsCache[player] = nil
		-- Release fires ListenToRelease, which kicks the player; the flag
		-- makes that kick use the data-reset message instead of the
		-- loaded-on-another-server one.
		WipingPlayers[player] = true
		pcall(function() profile:Release() end)
	end
	task.spawn(function()
		-- Give Release a beat to actually flush before wiping.
		task.wait(1.0)
		local ok, err = pcall(function()
			ProfileStore:WipeProfileAsync(profileKey)
		end)
		if not ok then
			warn(string.format("[PlayerDataService] Wipe failed for %s: %s", tostring(player and player.Name), tostring(err)))
		end
	end)
	pcall(function()
		if player.Parent then
			player:Kick("Your data has been reset by an admin. Please rejoin.")
		end
	end)
	return true
end

function PlayerDataService.Init()
	RequestDataFunc.OnServerInvoke = function(player)
		local profile = PlayerProfiles[player]
		if profile then
			return profile.Data
		end
		return nil
	end

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(onPlayerAdded, player)
	end

	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)
end

return PlayerDataService
