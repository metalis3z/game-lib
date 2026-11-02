
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage       = game:GetService("ServerStorage")
local Players             = game:GetService("Players")
local TextService         = game:GetService("TextService")
local CollectionService   = game:GetService("CollectionService")

local Net           = require(ReplicatedStorage.Packages.Net)
local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local AnimalData    = require(ReplicatedStorage.Datas.Animals)
local RaritiesData  = require(ReplicatedStorage.Datas.Rarities)
local RebirthData   = require(ReplicatedStorage.Datas.Rebirth)
local BasesData     = require(ReplicatedStorage.Datas.Bases)
local GameData      = require(ReplicatedStorage.GameData)
local LuckyBlocks   = require(ReplicatedStorage.Datas.LuckyBlocks)

local PlotService   = require(ServerScriptService.Services.PlotService)
local SkinService   = require(ServerScriptService.Services.SkinService)

local blacklisted   = GameData.UnSpawnableBrainrots

local MAX_DISPLAY_NAME_LENGTH = 32
local ALLOWED_NAME_PATTERN = "^[a-zA-Z0-9 '%-.!?_]+$"
local MAX_REBIRTH = 18
local GRACE_PERIOD = 30
local NUM_PLOTS = 8
local DEFAULT_SKIN = "Normal"

local BLOCKED_SKINS = {
	["SmurfCat"] = true,
}

local function isValidSkin(name: string): boolean
	if name == DEFAULT_SKIN then return true end
	if BLOCKED_SKINS[name] then return false end
	local skinsFolder = ServerStorage:FindFirstChild("Skins")
	if not skinsFolder then return false end
	local folder = skinsFolder:FindFirstChild(name)
	return folder ~= nil and folder:IsA("Folder")
end
local BOT_BASE_LOCK_TIME = 20

local ADMINS = {
	[0] = true,
	[1215597321] = true,
}
local function isPrivateServer()
	return game.PrivateServerId ~= ""
end
local RobuxShopData = require(ReplicatedStorage.Datas.RobuxShopData)

local BotBaseRemote = Net:RemoteFunction("BotBaseService/SpawnBotBase")
local RemoveBotBaseRemote = Net:RemoteFunction("BotBaseService/RemoveBotBase")
local StealService = require(ServerScriptService.Services.StealService)

local cooldowns = {}
local COOLDOWN = 3
Players.PlayerRemoving:Connect(function(p) cooldowns[p.UserId] = nil end)

local function isBlacklisted(name: string, caller: Player): boolean
	if blacklisted[name] then return true end
	local animal = AnimalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end

local function trim(s: string): string
	return (s:match("^%s*(.-)%s*$")) or ""
end

local function filterDisplayName(player: Player, displayName: string): (string?, string?)
	if #displayName > MAX_DISPLAY_NAME_LENGTH then
		return nil, ("Username is too long (max %d characters)."):format(MAX_DISPLAY_NAME_LENGTH)
	end
	if not displayName:match(ALLOWED_NAME_PATTERN) then
		return nil, "Username contains invalid characters. Only letters, numbers, spaces and basic punctuation are allowed."
	end
	local filterOk, filterObject = pcall(function()
		return TextService:FilterStringAsync(displayName, player.UserId, Enum.TextFilterContext.PublicChat)
	end)
	if not filterOk then
		return nil, "Username could not be verified right now. Please try again."
	end
	local getOk, filtered = pcall(function()
		return filterObject:GetNonChatStringForBroadcastAsync()
	end)
	if not getOk then
		return nil, "Username could not be verified right now. Please try again."
	end
	return filtered, nil
end

local function pickRandomPodiums(plotModel: Model, maxAnimals: number, count: number): {number}
	local folder = plotModel:FindFirstChild("AnimalPodiums")
	local indices = {}
	if folder then
		for _, podium in ipairs(folder:GetChildren()) do
			local idx = tonumber(podium.Name)
			if idx and idx <= maxAnimals then
				table.insert(indices, idx)
			end
		end
	end
	for i = #indices, 2, -1 do
		local j = math.random(1, i)
		indices[i], indices[j] = indices[j], indices[i]
	end
	local chosen = {}
	for i = 1, math.min(count, #indices) do
		table.insert(chosen, indices[i])
	end
	return chosen
end

local function spawnBotBase(player: Player, username: string, brainrots: {string}, rebirth: number, targetPlotNumber: number?, skin: string?): (boolean, string)
	local freePlot
	if targetPlotNumber then
		local plotsFolder = workspace:WaitForChild("Plots")
		local candidate = plotsFolder:FindFirstChild(tostring(targetPlotNumber))
		if not candidate then
			return false, ("Plot %d does not exist."):format(targetPlotNumber)
		end
		if not PlotService.isPlotFree(candidate) then
			return false, ("Plot %d is taken, please select another plot."):format(targetPlotNumber)
		end
		freePlot = candidate
	else
		freePlot = PlotService.getFreePlot()
		if not freePlot then
			return false, "No free plots available. All 8 plots are occupied."
		end
	end

	local plotName = freePlot.Name
	local plotCFrame = freePlot:GetPivot()

	local baseEntry = BasesData[rebirth]
	if not baseEntry or not baseEntry.Model then
		return false, ("No base model configured for rebirth %d."):format(rebirth)
	end
	local maxAnimals = baseEntry.MaxAnimals or 10

	local newPlot = baseEntry.Model:Clone()
	newPlot.Name = plotName
	if newPlot.PrimaryPart then
		newPlot.PrimaryPart.Anchored = true
	end

	local podiumsFolder = newPlot:FindFirstChild("AnimalPodiums")
	if podiumsFolder then
		for _, podium in ipairs(podiumsFolder:GetChildren()) do
			local idx = tonumber(podium.Name)
			if idx and idx > maxAnimals then
				podium:Destroy()
			end
		end
	end

	if newPlot:FindFirstChild("PlotSign")
		and newPlot.PlotSign:FindFirstChild("SurfaceGui")
		and newPlot.PlotSign.SurfaceGui:FindFirstChild("Frame")
		and newPlot.PlotSign.SurfaceGui.Frame:FindFirstChild("TextLabel")
	then
		newPlot.PlotSign.SurfaceGui.Frame.TextLabel.Text = string.format("%s's Base", username)
	end
	if newPlot:FindFirstChild("PlotSign") and newPlot.PlotSign:FindFirstChild("YourBase") then
		newPlot.PlotSign.YourBase.Enabled = false
	end

	local multiplierValue = 1
	local rebirthRewards = RebirthData[rebirth] and RebirthData[rebirth].Rewards
	if rebirthRewards and rebirthRewards.Multiplier then
		multiplierValue = 1 + rebirthRewards.Multiplier
	end
	if newPlot:FindFirstChild("Multiplier") and newPlot.Multiplier:FindFirstChild("Main") then
		newPlot.Multiplier.Main.Amount.Text = string.format("x%d", multiplierValue)
		newPlot.Multiplier.Main.Enabled = rebirth > 0
	end

	if newPlot:FindFirstChild("Unlock") then
		for _, main in pairs(newPlot.Unlock:GetDescendants()) do
			if main.Name == "Main" and main:FindFirstChild("UnlockBase") then
				main.UnlockBase.Enabled = false
			end
		end
	end

	local animalList = {}
	if #brainrots > 0 then
		local slots = pickRandomPodiums(newPlot, maxAnimals, #brainrots)
		for i, podiumIndex in ipairs(slots) do
			local animalName = brainrots[i]
			animalList[podiumIndex] = {
				Index       = animalName,
				LastCollect = workspace:GetServerTimeNow(),
				Mutation    = nil,
				Traits      = nil,
				Timer       = LuckyBlocks[animalName] and 0 or nil,
			}
		end
	end

	newPlot:SetAttribute("Tier", rebirth)
	newPlot:SetAttribute("IsBotBase", true)
	newPlot:PivotTo(plotCFrame)
	newPlot:AddTag("Plot")
	newPlot:SetAttribute("Loaded", false)
	newPlot.Parent = workspace:WaitForChild("Plots")
	freePlot:Destroy()

	local chosenSkin = (skin and skin ~= "") and skin or DEFAULT_SKIN
	pcall(function() SkinService:Apply(chosenSkin, newPlot, rebirth) end)

	local initialData = {
		Owner          = username,
		AnimalList     = animalList,
		FriendsAllowed = false,
		IsBotBase      = true,
	}
	initialData.AnimalList["__dict__"] = true

	local existingChannel = Synchronizer:Get(plotName)
	local plotChannel
	if existingChannel then
		for k, v in pairs(initialData) do
			existingChannel:Set(k, v)
		end
		plotChannel = existingChannel
	else
		plotChannel = Synchronizer:Create(plotName, initialData)
	end

	if plotChannel and plotChannel.AddListener then
		for _, p in ipairs(Players:GetPlayers()) do
			pcall(function() plotChannel:AddListener(p) end)
		end
	end

	newPlot:SetAttribute("Loaded", true)

	pcall(function() PlotService.LockBotBase(newPlot, BOT_BASE_LOCK_TIME) end)

	return true, string.format(
		"Fake base '%s' spawned on base %s (rebirth %d, %d brainrot%s%s).",
		username, plotName, rebirth, #brainrots, #brainrots == 1 and "" or "s",
		(chosenSkin ~= DEFAULT_SKIN) and (", " .. chosenSkin .. " skin") or ""
	)
end

local enabled = true
BotBaseRemote.OnServerInvoke = function(player: Player, username: any, brainrots: any, rebirth: any, plotNumber: any, skin: any)
    if not enabled then return false, "Fake base is disabled." end
	local last = cooldowns[player.UserId]
	if last and (os.time() - last) < COOLDOWN then
		return false, ("Please wait %d second(s) before spawning another fake base."):format(COOLDOWN - (os.time() - last))
	end

	if type(username) ~= "string" then
		return false, "Username is required."
	end
	local trimmedName = trim(username)
	if trimmedName == "" then
		return false, "Username is required."
	end
	local filteredName, nameErr = filterDisplayName(player, trimmedName)
	if not filteredName then
		return false, nameErr
	end

	local rebirthNum = tonumber(rebirth) or 0
	rebirthNum = math.floor(rebirthNum)
	if rebirthNum < 0 or rebirthNum > MAX_REBIRTH then
		return false, ("Rebirths must be between 0 and %d."):format(MAX_REBIRTH)
	end
	if not BasesData[rebirthNum] then
		return false, ("No base configured for rebirth %d."):format(rebirthNum)
	end
	local maxAnimals = BasesData[rebirthNum].MaxAnimals or 10

	local animals = {}
	if type(brainrots) == "table" then
		for _, v in ipairs(brainrots) do
			local name = trim(tostring(v))
			if name ~= "" then table.insert(animals, name) end
		end
	elseif type(brainrots) == "string" then
		for entry in brainrots:gmatch("[^,]+") do
			local name = trim(entry)
			if name ~= "" then table.insert(animals, name) end
		end
	end

	if #animals > maxAnimals then
		return false, ("Too many brainrots for rebirth %d. Max %d, you provided %d."):format(rebirthNum, maxAnimals, #animals)
	end

	for i, name in ipairs(animals) do
		if not AnimalData[name] then
			return false, ("Slot %d - invalid brainrot: '%s'"):format(i, name)
		end
		if isBlacklisted(name, player) then
			return false, ("Slot %d - blacklisted brainrot: '%s'"):format(i, name)
		end
	end

	local targetPlot = nil
	if plotNumber ~= nil and plotNumber ~= "" then
		local n = tonumber(plotNumber)
		if not n then
			return false, "Plot number must be a number (1-" .. NUM_PLOTS .. ")."
		end
		n = math.floor(n)
		if n < 1 or n > NUM_PLOTS then
			return false, ("Plot number must be between 1 and %d."):format(NUM_PLOTS)
		end
		targetPlot = n
	end

	local chosenSkin = DEFAULT_SKIN
	if skin ~= nil and skin ~= "" then
		if type(skin) ~= "string" then
			return false, "Skin must be a name."
		end
		local trimmedSkin = trim(skin)
		if trimmedSkin ~= "" then
			if not isValidSkin(trimmedSkin) then
				return false, ("Invalid skin: '%s'."):format(trimmedSkin)
			end
			chosenSkin = trimmedSkin
		end
	end

	local pcallOk, success, message = pcall(spawnBotBase, player, filteredName, animals, rebirthNum, targetPlot, chosenSkin)

	if not pcallOk then
		warn("[BotBase] spawnBotBase error:", success)
		return false, "Failed to spawn fake base (internal error)."
	end

	if success then
		cooldowns[player.UserId] = os.time()
	end

	return success, message
end

local function removeBotBase(plotNumber: number): (boolean, string)
	local plotsFolder = workspace:FindFirstChild("Plots")
	if not plotsFolder then
		return false, "Plots folder not found."
	end

	local plot = plotsFolder:FindFirstChild(tostring(plotNumber))
	if not plot or not plot:IsA("Model") then
		return false, ("Plot %d does not exist."):format(plotNumber)
	end

	if plot:GetAttribute("IsBotBase") ~= true then
		return false, ("Plot %d is not a fake base."):format(plotNumber)
	end

	local plotName = plot.Name

	for _, p in ipairs(Players:GetPlayers()) do
		local stealData = StealService:GetStealData(p)
		if stealData then
			if stealData.VictimPlotUID == plotName or stealData.VictimPlotUID == "Sammy" then
				pcall(function() StealService:CancelSteal(p) end)
			end
		end
	end

	local plotChannel = Synchronizer:Get(plotName)
	if plotChannel and getmetatable(plotChannel) then
		plotChannel:Set("AnimalList", {})
		plotChannel:Set("Owner", nil)
		plotChannel:Set("IsBotBase", nil)
		plotChannel:Set("FriendsAllowed", false)
		plotChannel:Set("BlockEndTime", nil)
		plotChannel:Set("BlockEndTimeFirstFloor", nil)
		plotChannel:Set("BlockEndTimeSecondFloor", nil)
		plotChannel:Set("BlockEndTimeThirdFloor", nil)
		plotChannel:Set("BlockedDelayTime", nil)
	end

	local ok, err = pcall(function()
		PlotService.resetPlot(plot)
	end)
	if not ok then
		warn("[BotBase] removeBotBase resetPlot error:", err)
		return false, "Failed to remove fake base (internal error)."
	end

	return true, ("Fake base on plot %d removed."):format(plotNumber)
end

RemoveBotBaseRemote.OnServerInvoke = function(player: Player, plotNumber: any)
	if not enabled then return false, "Fake base is disabled." end

	local n = tonumber(plotNumber)
	if not n then
		return false, ("Plot number must be a number (1-%d)."):format(NUM_PLOTS)
	end
	n = math.floor(n)
	if n < 1 or n > NUM_PLOTS then
		return false, ("Plot number must be between 1 and %d."):format(NUM_PLOTS)
	end

	local pcallOk, success, message = pcall(removeBotBase, n)
	if not pcallOk then
		warn("[BotBase] removeBotBase error:", success)
		return false, "Failed to remove fake base (internal error)."
	end
	return success, message
end

local NotificationService = require(ServerScriptService.Services.NotificationService)

local BotUnlockRemote = Net:RemoteEvent("BotBaseService/Unlock")

local function resolveBotPlot(plotName: any): Model?
	if typeof(plotName) ~= "string" then return nil end
	local plotsFolder = workspace:FindFirstChild("Plots")
	local plot = plotsFolder and plotsFolder:FindFirstChild(plotName)
	if plot and plot:IsA("Model") and plot:GetAttribute("IsBotBase") then
		return plot
	end
	return nil
end

BotUnlockRemote.OnServerEvent:Connect(function(player: Player, plotName: any, _floor: any)
	local plot = resolveBotPlot(plotName)
	if not plot then return end
	PlotService.UnlockBotBase(plot)
	NotificationService.Notify(player, "You broke into the base!", 3, "Sounds.Sfx.Unlock")
end)
