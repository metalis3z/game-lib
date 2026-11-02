-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Animals = require(ReplicatedStorage.Datas.Animals)
local CustomRichTextController = require(ReplicatedStorage.Controllers.CustomRichTextController)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local NewEntryEvent = Net:RemoteEvent("Liveboard/NewEntry")
local ClaimEntryEvent = Net:RemoteEvent("Liveboard/ClaimEntry")
local GetEntriesFunction = Net:RemoteFunction("Liveboard/GetEntries")
local Blacklisted = require(ReplicatedStorage.GameData)

local entries = {}
local entriesByUID = {}
local LiveboardController = {}

local REAL_LEADERBOARD_ONLY_BRAINROTS = {
	["Strawberry Elephant"] = true,
	["Skibidi Toilet"] = true,
	["Meowl"] = true,
	["John Pork"] = true,
}

local function shouldAllowEntry(entryData)
	local isRealLeaderboardEnabled = ReplicatedStorage:GetAttribute("RealLeaderboards")
	local isGlobal = not entryData.IsLocalServer

	if isGlobal then
		local isSpecialBrainrot = REAL_LEADERBOARD_ONLY_BRAINROTS[entryData.BrainrotName]

		if entryData.IsOriginServer then
			return true
		end

		if isRealLeaderboardEnabled then
			if not isSpecialBrainrot then
				return false
			end
			if Blacklisted.UnSpawnableBrainrots[entryData.BrainrotName] then
				return false
			end
		else
			if isSpecialBrainrot then
				return false
			end
		end
	end

	return true
end
local function formatTimeAgo(seconds)
	seconds = math.max(0, math.floor(seconds))
	if seconds < 60 then
		return ("Spawned %*s ago"):format(seconds)
	else
		local minutes = math.floor(seconds / 60)
		local remainingSeconds = seconds % 60
		if remainingSeconds > 0 then
			return ("Spawned %*m %*s ago"):format(minutes, remainingSeconds)
		else
			return ("Spawned %*m ago"):format(minutes)
		end
	end
end

local function applyOwner(frame, userId, displayName)
	local filler = frame.Filler
	if userId and displayName then
		filler.PlayerBg.Visible = true
		filler.PlayerBg.Username.TextColor3 = Color3.fromRGB(255, 255, 255)
		filler.PlayerBg.Username.Text = displayName
		filler.PlayerBg.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(userId)
	else
		filler.PlayerBg.Visible = false
		filler.PlayerBg.Username.TextColor3 = Color3.fromRGB(255, 61, 61)
		filler.PlayerBg.Username.Text = "UNCLAIMED"
		filler.PlayerBg.Headshot.Image = ""
	end
end

local function removeEntry(index)
	local entry = entries[index]
	if not entry then
		return
	end
	entriesByUID[entry.UID] = nil
	entry.Trove:Destroy()
	entry.Frame:Destroy()
	table.remove(entries, index)
	for i, e in entries do
		e.Frame.LayoutOrder = i
	end
end

local function createEntry(entryData, serverTemplate, globalTemplate, scrollingFrame)
	if not shouldAllowEntry(entryData) then
		return
	end

	local isLocalServer = entryData.IsLocalServer
	local frame = (if isLocalServer then serverTemplate else globalTemplate):Clone()
	frame.Visible = true
	frame.Name = "Entry"

	local filler = frame.Filler
	CustomRichTextController.apply(filler.Title, SharedAnimals:ColorBrainrotName(entryData.BrainrotName))

	local spawnedLabel = filler.Spawned
	local initialSeconds = math.max(0, math.floor(0))
	local initialTimeText

	if initialSeconds < 60 then
		initialTimeText = ("Spawned %*s ago"):format(initialSeconds)
	else
		local minutes = math.floor(initialSeconds / 60)
		local remainingSeconds = initialSeconds % 60
		initialTimeText = if remainingSeconds > 0
			then ("Spawned %*m %*s ago"):format(minutes, remainingSeconds)
			else ("Spawned %*m ago"):format(minutes)
	end

	spawnedLabel.Text = initialTimeText
	filler.Location.Text = isLocalServer and "[SERVER]" or "[GLOBAL]"
	applyOwner(frame, entryData.OwnerUserId, entryData.OwnerDisplayName)

	filler.BrainrotBg.Img.Visible = false

	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "BrainrotViewport"
	viewport.BackgroundTransparency = 1
	viewport.Size = UDim2.fromScale(1, 1)
	viewport.Position = UDim2.fromScale(0.5, 0.5)
	viewport.AnchorPoint = Vector2.new(0.5, 0.5)
	viewport.Parent = filler.BrainrotBg

	task.spawn(pcall, function()
		SharedAnimals:AttachOnViewport(entryData.BrainrotName, viewport, nil, entryData.Mutation)
	end)

	local barFill = filler.Bar.Fill
	barFill.Size = UDim2.fromScale(1, 1)
	frame.Parent = scrollingFrame

	local trove = Trove.new()
	local serverTime = workspace:GetServerTimeNow()
	local elapsed = math.max(0, serverTime - entryData.Timestamp)
	local remaining = math.max(0, entryData.DisplayDuration - elapsed)

	if remaining <= 0 then
		frame:Destroy()
		trove:Destroy()
		return
	end

	local fillScale = remaining / entryData.DisplayDuration
	barFill.Size = UDim2.fromScale(fillScale, 1)

	local tween = TweenService:Create(barFill, TweenInfo.new(remaining, Enum.EasingStyle.Linear), {
		Size = UDim2.fromScale(0, 1)
	})
	trove:Add(tween)
	tween:Play()

	local animalData = Animals[entryData.BrainrotName]
	local rarity = if animalData then animalData.Rarity else nil

	local entryObject = {
		UID           = entryData.UID,
		Rarity        = rarity,
		BrainrotName  = entryData.BrainrotName,
		IsLocalServer = entryData.IsLocalServer,
		IsOriginServer = entryData.IsOriginServer,
		Frame         = frame,
		Trove         = trove,
		ExpiresAt     = serverTime + remaining,
		SpawnedAt     = entryData.Timestamp,
		Duration      = entryData.DisplayDuration,
	}

	local insertIndex = nil
	if rarity == "OG" then
		insertIndex = 1
	elseif rarity == "Admin" then
		insertIndex = 1
		for i, e in ipairs(entries) do
			if e.Rarity == "Admin" then
				insertIndex = i + 1
			else
				break
			end
		end
	else
		insertIndex = 1
		for i, e in ipairs(entries) do
			if e.Rarity == "Admin" or e.Rarity == "OG" then
				insertIndex = i + 1
			else
				break
			end
		end
	end

	table.insert(entries, insertIndex, entryObject)
	entriesByUID[entryData.UID] = entryObject

	for i, e in ipairs(entries) do
		e.Frame.LayoutOrder = i
	end

	while #entries > FFlags:GetInstant("Liveboard/MaxEntries", 50) do
		removeEntry(#entries)
	end
end

LiveboardController.Start = function(_)
	if ServerData.IsDuelsServer() or ServerData.IsTsunamiServer() then
		return
	end

	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

	Observers.observeTag("Liveboard", function(liveboardInstance)
		local trove = Trove.new()
		local surfaceGui = trove:Clone(script.SurfaceGui)
		surfaceGui.Adornee = liveboardInstance
		surfaceGui.Parent = playerGui

		local scrollingFrame = surfaceGui.ScrollingFrame
		local serverTemplate = scrollingFrame.ServerTemplate
		local globalTemplate = scrollingFrame.GlobalTemplate
		serverTemplate.Visible = false
		globalTemplate.Visible = false

		trove:Add(NewEntryEvent.OnClientEvent:Connect(function(entryData)
			if type(entryData) ~= "table" then
				return
			elseif type(entryData.BrainrotName) ~= "string" then
				return
			else
				createEntry(entryData, serverTemplate, globalTemplate, scrollingFrame)
			end
		end))

		trove:Add(ClaimEntryEvent.OnClientEvent:Connect(function(uid, userId, displayName)
			local entry = entriesByUID[uid]
			if not entry then
				return
			end
			applyOwner(entry.Frame, userId, displayName)
		end))

		trove:Add(RunService.Heartbeat:Connect(function()
			local serverTime = workspace:GetServerTimeNow()
			local i = 1
			while i <= #entries do
				local entry = entries[i]
				if entry.ExpiresAt <= serverTime then
					removeEntry(i)
				else
					local elapsed = serverTime - entry.SpawnedAt
					local spawnedLabel = entry.Frame.Filler.Spawned
					local elapsedSeconds = math.max(0, math.floor(elapsed))
					local timeText

					if elapsedSeconds < 60 then
						timeText = ("Spawned %*s ago"):format(elapsedSeconds)
					else
						local minutes = math.floor(elapsedSeconds / 60)
						local remainingSeconds = elapsedSeconds % 60
						timeText = if remainingSeconds > 0
							then ("Spawned %*m %*s ago"):format(minutes, remainingSeconds)
							else ("Spawned %*m ago"):format(minutes)
					end

					spawnedLabel.Text = timeText
					i = i + 1
				end
			end
		end))

		trove:Add(ReplicatedStorage:GetAttributeChangedSignal("RealLeaderboards"):Connect(function()
			local isRealLeaderboardEnabled = ReplicatedStorage:GetAttribute("RealLeaderboards")
			local i = 1
			while i <= #entries do
				local entry = entries[i]
				if not entry.IsLocalServer then
					if not entry.IsOriginServer then
						local isSpecialBrainrot = REAL_LEADERBOARD_ONLY_BRAINROTS[entry.BrainrotName]

						if isRealLeaderboardEnabled then
							if not isSpecialBrainrot then
								removeEntry(i)
								continue
							end
							if Blacklisted.UnSpawnableBrainrots[entry.BrainrotName] then
								removeEntry(i)
								continue
							end
						else
							if isSpecialBrainrot then
								removeEntry(i)
								continue
							end
						end
					end
				end
				i = i + 1
			end
		end))

		task.spawn(function()
			local success, result = pcall(GetEntriesFunction.InvokeServer, GetEntriesFunction)
			if success and typeof(result) == "table" then
				for _, entryData in result do
					createEntry(entryData, serverTemplate, globalTemplate, scrollingFrame)
				end
			end
		end)

		return trove:WrapClean()
	end)
end

return LiveboardController