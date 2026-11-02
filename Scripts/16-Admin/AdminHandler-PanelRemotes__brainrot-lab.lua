-- Reference copy for study. Game: Brainrot Lab (brainrot-lab)
-- Original: ServerScriptService/Modules/AdminHandler.lua  (607 lines)
-- What it does: Admin panel backend with one function per remote (spawn items, start/end events locally or globally, announcements, private-server tools, youtuber tags), each starting with an isAdmin check, plus player resolving by id or name.

--!strict
-- LOCATION: ServerScriptService/Modules/AdminHandler
-- Handles all admin panel remote events and integrates with game systems

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

-- Modules
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local ItemConfigurations = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ItemConfigurations"))
local BrainrotData = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("BrainrotData"))
local EventConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("EventConfig"))

-- Lazy-loaded modules (avoid circular requires)
local PlayerController
local ItemManager
local RebirthSystem
local EventManager
local DataAccessor

-- Remotes
local AdminRemotes = ReplicatedStorage:WaitForChild("AdminRemotes")
local EventRemotes = ReplicatedStorage:WaitForChild("EventRemotes")
local YoutuberTagRemote = ReplicatedStorage:WaitForChild("YoutuberTagRemote")

-- State
local topGlobalBlacklist = {}
local topGlobalStoreName = "DefaultStore"

local AdminHandler = {}

-- Helper: check if player is admin
local function isAdmin(player: Player): boolean
	return AdminConfig.IsAdmin(player)
end

-- Helper: send action result notification to admin
local function notifyAdmin(player: Player, message: string, duration: number?)
	local remote = AdminRemotes:FindFirstChild("AdminActionResult")
	if remote and remote:IsA("RemoteEvent") then
		remote:FireClient(player, message, duration or 4)
	end
end

-- Helper: resolve player by name or userId string
local function resolvePlayer(query: string): Player?
	if not query then return nil end
	query = tostring(query):match("^%s*(.-)%s*$")
	if query == "" then return nil end

	-- Try numeric userId
	local uid = tonumber(query)
	if uid and uid > 0 then
		return Players:GetPlayerByUserId(uid)
	end

	-- Try name match (case-insensitive)
	local lower = string.lower(query):gsub("^@", "")
	for _, p in ipairs(Players:GetPlayers()) do
		if string.lower(p.Name) == lower or string.lower(p.DisplayName) == lower then
			return p
		end
	end

	return nil
end

-- Helper: get all players or specific player
local function getTargetPlayers(isGlobal: boolean?, targetQuery: string?): {Player}
	if isGlobal then
		return Players:GetPlayers()
	end
	if targetQuery and targetQuery ~= "" then
		local target = resolvePlayer(targetQuery)
		if target then return {target} end
	end
	return {}
end

-- ============================================================
-- REMOTE FUNCTION HANDLERS
-- ============================================================

-- IsAdmin: returns whether the invoking player is an admin
local function handleIsAdmin(player: Player): boolean
	return isAdmin(player)
end

-- GetAdminBrainrotList: returns the brainrot list for the admin panel
local function handleGetBrainrotList(player: Player): table?
	if not isAdmin(player) then return nil end
	local Brainrots = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Brainrots"))
	return Brainrots
end

-- TopGlobalGetState: returns the top global state
local function handleTopGlobalGetState(player: Player): table?
	if not isAdmin(player) then return nil end
	return {
		blacklist = topGlobalBlacklist,
		storeName = topGlobalStoreName,
	}
end

-- TranslateAnnouncement: returns translated text (simplified - returns original)
local function handleTranslate(player: Player, text: string): string
	if not isAdmin(player) then return text end
	-- Simplified: return original text
	-- The AnnouncementReceiver client script has its own fallback translation
	return text
end

-- ============================================================
-- REMOTE EVENT HANDLERS
-- ============================================================

-- AdminSpawnBrainrot: Queue the selected brainrot as the NEXT conveyor spawn
-- Parameters: brainrotId, mutationType, selectedTraits, isGlobal
local function handleSpawnBrainrot(player: Player, brainrotId: string, mutationType: string?, selectedTraits: table?, isGlobal: boolean?)
	if not isAdmin(player) then return end
	if not brainrotId or brainrotId == "" then return end

	local itemData = ItemConfigurations.GetItemData(brainrotId)
	if not itemData then
		notifyAdmin(player, "Brainrot not found: " .. tostring(brainrotId))
		return
	end

	local mutation = mutationType or "Normal"
	local rarity = itemData.Rarity or "Common"

	-- Apply selected traits (first trait becomes the mutation)
	if selectedTraits and #selectedTraits > 0 then
		mutation = selectedTraits[1]
	end

	-- Queue this brainrot as the NEXT spawn on the conveyor belt
	local BrainrotConveyor = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("BrainrotConveyor"))
	BrainrotConveyor:SetForcedBrainrot(brainrotId, mutation, rarity)

	notifyAdmin(player, string.format("Queued %s (%s) as the next brainrot on the conveyor!", brainrotId, mutation))
end

-- AdminWorldSpawnBrainrot: Spawn brainrot in the world
-- Parameters: brainrotId, mutationType, selectedTraits, serverCount
local function handleWorldSpawnBrainrot(player: Player, brainrotId: string, mutationType: string?, selectedTraits: table?, serverCount: number?)
	if not isAdmin(player) then return end
	if not brainrotId or brainrotId == "" then return end

	if not ItemManager then
		ItemManager = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("ItemManager"))
	end

	local itemData = ItemConfigurations.GetItemData(brainrotId)
	if not itemData then
		notifyAdmin(player, "Brainrot not found: " .. tostring(brainrotId))
		return
	end

	local mutation = mutationType or "Normal"
	if selectedTraits and #selectedTraits > 0 then
		mutation = selectedTraits[1]
	end

	local rarity = itemData.Rarity or "Common"

	-- Spawn in world: give to all players in current server
	local count = 0
	for _, target in ipairs(Players:GetPlayers()) do
		local success = pcall(function()
			ItemManager.GiveItemToPlayer(target, brainrotId, mutation, rarity, 1)
		end)
		if success then count += 1 end
	end

	notifyAdmin(player, string.format("World spawn: %s (%s) to %d players", brainrotId, mutation, count))
end

-- AdminRandomServerSpawnBrainrotV2: Queue the selected brainrot as the NEXT conveyor spawn
local function handleRandomServerSpawn(player: Player, brainrotId: string, mutationType: string?, selectedTraits: table?, serverCount: number?)
	if not isAdmin(player) then return end
	if not brainrotId or brainrotId == "" then return end

	local itemData = ItemConfigurations.GetItemData(brainrotId)
	if not itemData then
		notifyAdmin(player, "Brainrot not found: " .. tostring(brainrotId))
		return
	end

	local mutation = mutationType or "Normal"
	if selectedTraits and #selectedTraits > 0 then
		mutation = selectedTraits[1]
	end

	local rarity = itemData.Rarity or "Common"

	-- Queue this brainrot as the NEXT spawn on the conveyor belt
	local BrainrotConveyor = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("BrainrotConveyor"))
	BrainrotConveyor:SetForcedBrainrot(brainrotId, mutation, rarity)

	notifyAdmin(player, string.format("Queued %s (%s) as the next brainrot on the conveyor!", brainrotId, mutation))
end

-- StartEventAdmin: Start an event via EventManager
-- Parameters: eventKey, nil, isGlobal
local function handleStartEvent(player: Player, eventKey: string, _, isGlobal: boolean?)
	if not isAdmin(player) then return end
	if not eventKey then return end

	local config = EventConfig.Events[eventKey]
	if not config then
		notifyAdmin(player, "Unknown event: " .. tostring(eventKey))
		return
	end

	if not EventManager then
		EventManager = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("EventManager"))
	end

	local success, errMsg = EventManager.AdminStartEvent(eventKey)
	if success then
		notifyAdmin(player, "Started event: " .. (config.Name or eventKey))
	elseif errMsg then
		notifyAdmin(player, errMsg, 6)
	else
		notifyAdmin(player, "Failed to start event: " .. tostring(eventKey))
	end
end

-- EndEventAdmin: End an event via EventManager
-- Parameters: eventKey, isGlobal
local function handleEndEvent(player: Player, eventKey: string, isGlobal: boolean?)
	if not isAdmin(player) then return end
	if not eventKey then return end

	if not EventManager then
		EventManager = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("EventManager"))
	end

	local success = EventManager.AdminStopEvent(eventKey)
	if success then
		notifyAdmin(player, "Ended event: " .. tostring(eventKey))
	else
		notifyAdmin(player, "Failed to end event: " .. tostring(eventKey))
	end
end

-- AdminAction: Handle various admin actions
-- Parameters: action, ...
local function handleAdminAction(player: Player, action: string, ...)
	if not isAdmin(player) then return end
	if not action then return end

	local args = {...}

	if action == "ResetData" then
		-- Reset the admin's own data
		if not PlayerController then
			PlayerController = require(ServerScriptService:WaitForChild("Controllers"):WaitForChild("PlayerController"))
		end
		local profile = PlayerController:GetProfile(player)
		if profile then
			profile.Data.Money = 0
			profile.Data.Rebirths = 0
			profile.Data.Power = 0
			profile.Data.Inventory = {}
			profile.Data.Plots = { Floor1 = {}, Floor2 = {}, Floor3 = {} }
			profile.Data.DiscoveredItems = {}
			profile.Data.ClaimedPacks = {}
			profile.Data.UnlockedWeights = {}

			-- Update leaderstats
			if player:FindFirstChild("leaderstats") then
				local ls = player.leaderstats
				if ls:FindFirstChild("Money") then ls.Money.Value = 0 end
				if ls:FindFirstChild("Rebirths") then ls.Rebirths.Value = 0 end
				if ls:FindFirstChild("Power") then ls.Power.Value = 0 end
			end

			-- Clear backpack
			if player:FindFirstChild("Backpack") then
				player.Backpack:ClearAllChildren()
			end

			notifyAdmin(player, "Your data has been reset.")
		end

	elseif action == "SetMoney" then
		local amount = tonumber(args[1])
		if not amount or amount < 0 then return end

		if not PlayerController then
			PlayerController = require(ServerScriptService:WaitForChild("Controllers"):WaitForChild("PlayerController"))
		end
		local profile = PlayerController:GetProfile(player)
		if profile then
			profile.Data.Money = math.floor(amount)
			if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Money") then
				player.leaderstats.Money.Value = profile.Data.Money
				notifyAdmin(player, "Money set to: " .. tostring(profile.Data.Money))
			end
		end

	elseif action == "SetRebirth" then
		local amount = tonumber(args[1])
		if not amount or amount < 0 then return end
		amount = math.floor(amount)

		if not PlayerController then
			PlayerController = require(ServerScriptService:WaitForChild("Controllers"):WaitForChild("PlayerController"))
		end
		local profile = PlayerController:GetProfile(player)
		if profile then
			profile.Data.Rebirths = amount
			if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Rebirths") then
				player.leaderstats.Rebirths.Value = amount
			notifyAdmin(player, "Rebirths set to: " .. tostring(amount))
			end

			-- Refresh slots to update multipliers
			local SlotManager = ServerScriptService:FindFirstChild("Modules") and ServerScriptService.Modules:FindFirstChild("SlotManager")
			if SlotManager then
				local sm = require(SlotManager)
				if sm.RefreshAllSlots then sm.RefreshAllSlots(player) end
			end
		end

	elseif action == "SingleAnnounce" then
		-- Fun: Send a single announcement to a specific player
		local targetName = tostring(args[1] or "")
		local message = tostring(args[2] or "")
		if message == "" then return end

		local target = resolvePlayer(targetName)
		if target then
			local adminAvatar = ""
			pcall(function()			
				adminAvatar, _ = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
			end)
			local announceRemote = AdminRemotes:FindFirstChild("AdminAnnounce")
			if announceRemote then
				announceRemote:FireClient(target, adminAvatar, player.Name, message, nil)
			end
			notifyAdmin(player, "Announcement sent to " .. target.Name)
		else
			notifyAdmin(player, "Player not found: " .. targetName)
		end

	elseif action == "Sound" then
		-- Fun: Play a sound effect on target player
		local targetName = tostring(args[1] or "")
		local brainrotName = tostring(args[2] or "")
		local target = resolvePlayer(targetName)
		if target then
			local funRemote = AdminRemotes:FindFirstChild("AdminFunClient")
			if funRemote then
				funRemote:FireClient(target, "Sound", brainrotName)
			end
			notifyAdmin(player, "Sound sent to " .. target.Name)
		else
			notifyAdmin(player, "Player not found: " .. targetName)
		end

	elseif action == "Invert" then
		-- Fun: Invert controls on target player
		local targetName = tostring(args[1] or "")
		local target = resolvePlayer(targetName)
		if target then
			local funRemote = AdminRemotes:FindFirstChild("AdminFunClient")
			if funRemote then
				funRemote:FireClient(target, "Invert", 10)
			end
			notifyAdmin(player, "Inverted controls for " .. target.Name .. " (10s)")
		else
			notifyAdmin(player, "Player not found: " .. targetName)
		end

	elseif action == "Rainbow" or action == "Big" or action == "Tiny" or action == "Avatar" or action == "Jump" or action == "Dash" or action == "Rocket" then
		-- Fun: Send visual effect to target player
		local targetName = tostring(args[1] or "")
		local target = resolvePlayer(targetName)
		if target then
			local funRemote = AdminRemotes:FindFirstChild("AdminFunClient")
			if funRemote then
				funRemote:FireClient(target, action, player.Name)
			end
			notifyAdmin(player, action .. " effect sent to " .. target.Name)
		else
			notifyAdmin(player, "Player not found: " .. targetName)
		end

	else
		notifyAdmin(player, "Unknown action: " .. tostring(action))
	end
end

-- AdminAnnounce: Broadcast announcement to all players
-- Parameters: text, isGlobal, customName
local function handleAnnounce(player: Player, text: string, isGlobal: boolean?, customName: string?)
	if not isAdmin(player) then return end
	if not text or text == "" then return end

	local adminAvatar = ""
	pcall(function()
		adminAvatar, _ = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
	end)

	local displayName = customName and customName ~= "" and customName or player.DisplayName
	local announceRemote = AdminRemotes:FindFirstChild("AdminAnnounce")
	if announceRemote then
		announceRemote:FireAllClients(adminAvatar, player.Name, text, displayName)
	end
end

-- AdminPrivateServer: Create a private server for a player
-- Parameters: playerName
local function handlePrivateServer(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if not targetName or targetName == "" then return end

	local resultRemote = AdminRemotes:FindFirstChild("AdminPrivateServerResult")

	-- Simplified: just notify the admin
	-- Full private server creation would require Roblox API calls
	local target = resolvePlayer(targetName)
	if target then
		if resultRemote then
			resultRemote:FireClient(player, "Private server feature is not fully configured.", 4)
		end
	else
		if resultRemote then
			resultRemote:FireClient(player, "Player not found: " .. targetName, 4)
		end
	end
end

-- TopGlobalAdmin: Manage top global blacklist
-- Parameters: action, ...
local function handleTopGlobalAdmin(player: Player, action: string, ...)
	if not isAdmin(player) then return end
	if not action then return end

	local args = {...}

	if action == "Refresh" then
		notifyAdmin(player, "Top global refreshed.")

	elseif action == "Reset" then
		topGlobalBlacklist = {}
		notifyAdmin(player, "Top global reset.")

	elseif action == "BlacklistAdd" then
		local userId = tonumber(args[1])
		if userId and userId > 0 then
			-- Avoid duplicates
			for _, id in ipairs(topGlobalBlacklist) do
				if id == userId then
				notifyAdmin(player, "User already blacklisted: " .. tostring(userId))
				return
				end
			end
			table.insert(topGlobalBlacklist, userId)
			notifyAdmin(player, "Added to blacklist: " .. tostring(userId))
		end

	elseif action == "BlacklistRemove" then
		local userId = tonumber(args[1])
		if userId then
			for i, id in ipairs(topGlobalBlacklist) do
				if id == userId then
					table.remove(topGlobalBlacklist, i)
				notifyAdmin(player, "Removed from blacklist: " .. tostring(userId))
				return
				end
			end
		end

	end
end

-- YoutuberTagRemote: Grant youtuber tag to a player
-- Parameters: "GrantYoutuberTag", userId
local function handleYoutuberTag(player: Player, action: string, userId: number?)
	if not isAdmin(player) then return end
	if action ~= "GrantYoutuberTag" then return end
	if not userId then return end

	local target = Players:GetPlayerByUserId(userId)
	if target then
		-- Set attribute on the target player
		target:SetAttribute("IsYoutuber", true)

		-- Notify the admin
		YoutuberTagRemote:FireClient(player, "GrantResult", {
			message = "Content Creator applied to @" .. target.Name,
			success = true,
		})

		-- Notify the target player
		YoutuberTagRemote:FireClient(target, "ShowWarningYoutuber", {
			displayName = target.DisplayName,
			name = target.Name,
		})
	else
		YoutuberTagRemote:FireClient(player, "GrantResult", {
			message = "Player not found (UserId: " .. tostring(userId) .. ")",
			success = false,
		})
	end
end

-- ============================================================
-- INIT AND START
-- ============================================================

function AdminHandler:Init(controllers)
	PlayerController = controllers.PlayerController

	-- Lazy load other modules
	local Modules = ServerScriptService:WaitForChild("Modules")
	pcall(function() ItemManager = require(Modules:WaitForChild("ItemManager")) end)
	pcall(function() RebirthSystem = require(Modules:WaitForChild("RebirthSystem")) end)
	pcall(function() EventManager = require(Modules:WaitForChild("EventManager")) end)
	pcall(function() DataAccessor = require(Modules:WaitForChild("DataAccessor")) end)

	print("[AdminHandler] Initialized")
end

function AdminHandler:Start()
	-- Remote Functions
	local isAdminRF = AdminRemotes:FindFirstChild("IsAdmin")
	if isAdminRF and isAdminRF:IsA("RemoteFunction") then
		isAdminRF.OnServerInvoke = handleIsAdmin
	end

	local getBrainrotListRF = AdminRemotes:FindFirstChild("GetAdminBrainrotList")
	if getBrainrotListRF and getBrainrotListRF:IsA("RemoteFunction") then
		getBrainrotListRF.OnServerInvoke = handleGetBrainrotList
	end

	local topGlobalGetStateRF = AdminRemotes:FindFirstChild("TopGlobalGetState")
	if topGlobalGetStateRF and topGlobalGetStateRF:IsA("RemoteFunction") then
		topGlobalGetStateRF.OnServerInvoke = handleTopGlobalGetState
	end

	local translateRF = AdminRemotes:FindFirstChild("TranslateAnnouncement")
	if translateRF and translateRF:IsA("RemoteFunction") then
		translateRF.OnServerInvoke = handleTranslate
	end

	-- Remote Events
	local spawnBrainrotRE = AdminRemotes:FindFirstChild("AdminSpawnBrainrot")
	if spawnBrainrotRE then
		spawnBrainrotRE.OnServerEvent:Connect(handleSpawnBrainrot)
	end

	local worldSpawnRE = AdminRemotes:FindFirstChild("AdminWorldSpawnBrainrot")
	if worldSpawnRE then
		worldSpawnRE.OnServerEvent:Connect(handleWorldSpawnBrainrot)
	end

	local randomServerSpawnRE = AdminRemotes:FindFirstChild("AdminRandomServerSpawnBrainrotV2")
	if randomServerSpawnRE then
		randomServerSpawnRE.OnServerEvent:Connect(handleRandomServerSpawn)
	end

	local startEventRE = AdminRemotes:FindFirstChild("StartEventAdmin")
	if startEventRE then
		startEventRE.OnServerEvent:Connect(handleStartEvent)
	end

	local endEventRE = AdminRemotes:FindFirstChild("EndEventAdmin")
	if endEventRE then
		endEventRE.OnServerEvent:Connect(handleEndEvent)
	end

	local adminActionRE = AdminRemotes:FindFirstChild("AdminAction")
	if adminActionRE then
		adminActionRE.OnServerEvent:Connect(handleAdminAction)
	end

	local announceRE = AdminRemotes:FindFirstChild("AdminAnnounce")
	if announceRE then
		announceRE.OnServerEvent:Connect(handleAnnounce)
	end

	local privateServerRE = AdminRemotes:FindFirstChild("AdminPrivateServer")
	if privateServerRE then
		privateServerRE.OnServerEvent:Connect(handlePrivateServer)
	end

	local topGlobalAdminRE = AdminRemotes:FindFirstChild("TopGlobalAdmin")
	if topGlobalAdminRE then
		topGlobalAdminRE.OnServerEvent:Connect(handleTopGlobalAdmin)
	end

	-- YoutuberTagRemote
	if YoutuberTagRemote then
		YoutuberTagRemote.OnServerEvent:Connect(handleYoutuberTag)
	end

	print("[AdminHandler] Started - All admin remotes connected")
end

return AdminHandler
