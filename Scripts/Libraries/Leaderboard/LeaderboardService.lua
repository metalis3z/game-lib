local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LeaderboardConfig = require(script.Parent.Parent.Config.LeaderboardConfig)
local MathUtility = require(ReplicatedStorage:WaitForChild("Math Utility"))
local LeaderboardShared = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("LeaderboardShared"))

local LeaderboardService = {}
LeaderboardService.__index = LeaderboardService

local PODIUM_REFRESH_DELAY_SECONDS = 2
local INITIAL_GLOBAL_REFRESH_DELAY_SECONDS = 3
local ORDERED_READ_STAGGER_SECONDS = 0.15
local PODIUM_GROUND_EPSILON = 0.01
local MAX_SORTED_VALUE = 9007199254740991
local PODIUM_ANIMATION_ID = "rbxassetid://131536124544762"
local PODIUM_ANIMATION_SPEED = 0.5
local PODIUM_HEAD_MESH_BASE_SCALE = Vector3.new(1.25, 1.25, 1.25)

local PODIUM_REQUIRED_PARTS = {
	"Head",
	"Torso",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg",
	"HumanoidRootPart",
}

local PODIUM_REQUIRED_JOINTS = {
	{"HumanoidRootPart", "Root Hip"},
	{"Torso", "Neck"},
	{"Torso", "Left Shoulder"},
	{"Torso", "Right Shoulder"},
	{"Torso", "Left Hip"},
	{"Torso", "Right Hip"},
}

local PODIUM_R6_ATTACHMENT_MAP = {
	HairAttachment = {Part = "Head", Position = Vector3.new(0, 0.6, 0)},
	HatAttachment = {Part = "Head", Position = Vector3.new(0, 0.6, 0)},
	FaceFrontAttachment = {Part = "Head", Position = Vector3.new(0, 0, -0.6)},
	FaceCenterAttachment = {Part = "Head", Position = Vector3.new(0, 0, -0.6)},
	BodyFrontAttachment = {Part = "Torso", Position = Vector3.new(0, 0, -0.5)},
	BodyBackAttachment = {Part = "Torso", Position = Vector3.new(0, 0, 0.5)},
	NeckAttachment = {Part = "Torso", Position = Vector3.new(0, 0.5, 0)},
	WaistFrontAttachment = {Part = "Torso", Position = Vector3.new(0, -0.5, -0.5)},
	WaistBackAttachment = {Part = "Torso", Position = Vector3.new(0, -0.5, 0.5)},
	LeftShoulderAttachment = {Part = "Left Arm", Position = Vector3.new(0, 0.5, 0)},
	RightShoulderAttachment = {Part = "Right Arm", Position = Vector3.new(0, 0.5, 0)},
	LeftGripAttachment = {Part = "Left Arm", Position = Vector3.new(0, -0.5, 0)},
	RightGripAttachment = {Part = "Right Arm", Position = Vector3.new(0, -0.5, 0)},
	LeftFootAttachment = {Part = "Left Leg", Position = Vector3.new(0, -0.5, 0)},
	RightFootAttachment = {Part = "Right Leg", Position = Vector3.new(0, -0.5, 0)},
}

function LeaderboardService.new()
	return setmetatable({
		IsStudio = RunService:IsStudio(),
		OrderedStores = {},
		Boards = {},
		NameCache = {},
		PublishedValues = {},
		LastPublishAtByUserId = {},
		CachedGlobalEntries = {},
		NextRefreshAt = os.time() + LeaderboardConfig.RefreshIntervalSeconds,
		RefreshQueued = false,
		PendingInitialRefresh = false,
	}, LeaderboardService)
end

function LeaderboardService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	if not self.IsStudio then
		for boardKey, definition in pairs(LeaderboardConfig.Boards) do
			self.OrderedStores[boardKey] = DataStoreService:GetOrderedDataStore(definition.OrderedStoreName)
		end
	end
end
function LeaderboardService:Start()
	self:_discoverBoards()
	self.DataService.ProfileLoaded.Event:Connect(function()
		self:_queueRefresh(false)
	end)
	self.DataService.ProfileReleased.Event:Connect(function()
		self:_queueRefresh(false)
	end)
	Players.PlayerRemoving:Connect(function()
		self:_queueRefresh(false)
	end)

	self.NextRefreshAt = os.time() + LeaderboardConfig.RefreshIntervalSeconds
	self:_refreshBoardDisplays(true)
	self:_updateRefreshLabels()

	task.delay(PODIUM_REFRESH_DELAY_SECONDS, function()
		self:_refreshBoardDisplays(false)
	end)

	task.delay(INITIAL_GLOBAL_REFRESH_DELAY_SECONDS, function()
		self:_runScheduledRefresh(true)
	end)

	task.spawn(function()
		while true do
			task.wait(1)
			self:_updateRefreshLabels()
			if os.time() >= self.NextRefreshAt then
				self:_runScheduledRefresh(false)
			end
		end
	end)
end

function LeaderboardService:_queueRefresh(isInitial)
	self.PendingInitialRefresh = self.PendingInitialRefresh or isInitial == true
	if self.RefreshQueued then
		return
	end
	self.RefreshQueued = true
	task.defer(function()
		self.PendingInitialRefresh = false
		self.RefreshQueued = false
		self:_refreshBoardDisplays(false)
	end)
end

function LeaderboardService:_resolvePodiumAnchor(boardModel)
	local pedestal = boardModel:FindFirstChild("Pedestial")
	local anchorSource = pedestal or boardModel
	local boxCFrame, boxSize = anchorSource:GetBoundingBox()
	local topY = boxCFrame.Position.Y + (boxSize.Y * 0.5)
	if pedestal then
		for _, child in ipairs(pedestal:GetDescendants()) do
			if child:IsA("BasePart") then
				topY = math.max(topY, child.Position.Y + (child.Size.Y * 0.5))
			end
		end
	end

	local boardLook = boardModel:GetPivot().LookVector
	local flatLook = Vector3.new(boardLook.X, 0, boardLook.Z)
	if flatLook.Magnitude < 0.001 then
		flatLook = Vector3.zAxis
	else
		flatLook = flatLook.Unit
	end

	local center = Vector3.new(boxCFrame.Position.X, topY, boxCFrame.Position.Z)
	return CFrame.lookAt(center, center + flatLook), topY
end

function LeaderboardService:_disableBoardSortScript(surfaceGui)
	if not surfaceGui then
		return nil
	end
	local sortScript = surfaceGui:FindFirstChild("Sort")
	if sortScript and sortScript:IsA("BaseScript") then
		sortScript.Disabled = true
	end
	return sortScript
end

function LeaderboardService:_discoverBoards()
	local boardsFolder = workspace:FindFirstChild("Leaderboards")
	if not boardsFolder then
		warn("[LeaderboardService] Missing workspace.Leaderboards")
		return
	end

	for boardKey, definition in pairs(LeaderboardConfig.Boards) do
		local boardModel = boardsFolder:FindFirstChild(definition.BoardModelName)
		if not boardModel then
			warn("[LeaderboardService] Missing board model", definition.BoardModelName)
			continue
		end

		local surfaceGui = boardModel:FindFirstChild(definition.SurfaceGuiName, true)
		if not surfaceGui then
			warn("[LeaderboardService] Missing surface gui", definition.SurfaceGuiName)
			continue
		end

		local playerList = surfaceGui:FindFirstChild("PlayerList")
		local refreshLabel = surfaceGui:FindFirstChild("RefreshTime", true) or surfaceGui:FindFirstChild("Refresh", true)
		local podiumFolder = boardModel:FindFirstChild("PodiumCharacters") or Instance.new("Folder")
		podiumFolder.Name = "PodiumCharacters"
		podiumFolder.Parent = boardModel
		local podiumAnchorCFrame, podiumFloorY = self:_resolvePodiumAnchor(boardModel)

		self.Boards[boardKey] = {
			Definition = definition,
			BoardModel = boardModel,
			SurfaceGui = surfaceGui,
			SortScript = self:_disableBoardSortScript(surfaceGui),
			PlayerList = playerList,
			RefreshLabel = refreshLabel,
			PodiumFolder = podiumFolder,
			PodiumAnchorCFrame = podiumAnchorCFrame,
			PodiumFloorY = podiumFloorY,
			Slots = self:_collectSlots(playerList),
			RuntimeFrames = {},
			FrameDefaults = {},
		}

		self:_prepareBoard(self.Boards[boardKey])
	end
end
function LeaderboardService:_collectSlots(playerList)
	local slots = {}
	if not playerList then
		return slots
	end

	local container = playerList.Parent
	slots.Template = playerList:FindFirstChild("PlayerTemplate") or (container and container:FindFirstChild("PlayerTemplate"))
	slots.LegacyTopOne = playerList:FindFirstChild("PlayerTemplateOne") or (container and container:FindFirstChild("PlayerTemplateOne"))
	slots.LegacyTopTwo = playerList:FindFirstChild("PlayerTemplateTwo") or (container and container:FindFirstChild("PlayerTemplateTwo"))
	slots.LegacyTopThree = playerList:FindFirstChild("PlayerTemplateThree") or (container and container:FindFirstChild("PlayerTemplateThree"))
	return slots
end

function LeaderboardService:_rememberFrameDefaults(board, frame)
	if not board or not frame or board.FrameDefaults[frame] then
		return
	end
	board.FrameDefaults[frame] = {
		Size = frame.Size,
	}
end

function LeaderboardService:_setFrameDisplayed(board, frame, isDisplayed)
	if not board or not frame then
		return
	end
	frame.AutomaticSize = Enum.AutomaticSize.None
	self:_rememberFrameDefaults(board, frame)
	local defaults = board.FrameDefaults[frame]
	frame.Visible = isDisplayed == true
	if defaults then
		frame.Size = defaults.Size
	end
end

function LeaderboardService:_prepareBoard(board)
	if not board.PlayerList then
		return
	end

--	board.PlayerList.CanvasPosition = Vector2.zero

	for _, child in ipairs(board.PlayerList:GetChildren()) do
		if child:IsA("Frame") and child.Name:match("^PlayerTemplate_%d+$") then
			child:Destroy()
		end
	end
	table.clear(board.RuntimeFrames)

	for _, legacyFrame in ipairs({ board.Slots.LegacyTopOne, board.Slots.LegacyTopTwo, board.Slots.LegacyTopThree }) do
		if legacyFrame then
			legacyFrame.Visible = false
			legacyFrame.Parent = board.SurfaceGui
			legacyFrame:SetAttribute("Rank", nil)
			legacyFrame:SetAttribute("UserId", nil)
			self:_rememberFrameDefaults(board, legacyFrame)
		end
	end

	if board.Slots.Template then
		if board.RuntimeTemplateSource then
			board.RuntimeTemplateSource:Destroy()
		end
		board.RuntimeTemplateSource = board.Slots.Template:Clone()
		board.RuntimeTemplateSource.Name = "PlayerTemplateSource"
		board.RuntimeTemplateSource.Visible = false
		board.RuntimeTemplateSource.Parent = board.SurfaceGui
		board.Slots.Template.Visible = false
		board.Slots.Template.Parent = board.SurfaceGui
		board.Slots.Template:SetAttribute("Rank", nil)
		board.Slots.Template:SetAttribute("UserId", nil)
		self:_rememberFrameDefaults(board, board.RuntimeTemplateSource)
	end
end

function LeaderboardService:_sanitizeOrderedValue(value)
	value = tonumber(value) or 0
	if value ~= value or value == math.huge or value == -math.huge then
		return 0
	end

	if value > MAX_SORTED_VALUE then
		value = MAX_SORTED_VALUE
	elseif value < 0 then
		value = 0
	end

	value = math.floor(value)
	return value
end

function LeaderboardService:_getValueType(definition)
	local sharedDefinition = definition and definition.Key and LeaderboardShared.Boards and LeaderboardShared.Boards[definition.Key]
	return sharedDefinition and sharedDefinition.valueType or definition.ValueFormat or "number"
end

function LeaderboardService:_extractStat(profile, statPath)
	local current = profile
	for _, key in ipairs(statPath) do
		if type(current) ~= "table" then
			return 0
		end
		current = current[key]
	end
	return self:_sanitizeOrderedValue(current)
end

function LeaderboardService:_extractStatEntry(profile, definition)
	local current = profile
	for _, key in ipairs(definition.StatPath) do
		if type(current) ~= "table" then
			return {
				EncodedValue = 0,
				DisplayValue = 0,
			}
		end
		current = current[key]
	end

	local valueType = self:_getValueType(definition)
	if valueType == "big" then
		local normalized = LeaderboardShared.NormalizeBig(current)
		return {
			EncodedValue = self:_sanitizeOrderedValue(LeaderboardShared.EncodeBig(normalized)),
			DisplayValue = normalized,
		}
	end

	local sanitized = self:_sanitizeOrderedValue(current)
	return {
		EncodedValue = sanitized,
		DisplayValue = sanitized,
	}
end
function LeaderboardService:_publishCurrentPlayers()
	if self.IsStudio then
		return
	end

	local now = os.time()
	for _, player in ipairs(Players:GetPlayers()) do
		local profile = self.DataService:GetProfile(player)
		if not profile then
			continue
		end

		local userId = player.UserId
		if userId <= 0 then
			continue
		end

		local lastPublishAt = self.LastPublishAtByUserId[userId]
		if lastPublishAt and (now - lastPublishAt) < LeaderboardConfig.PublishIntervalSeconds then
			continue
		end

		local publishedForUser = self.PublishedValues[userId] or {}
		self.PublishedValues[userId] = publishedForUser
		local attemptedWrite = false

		for boardKey, definition in pairs(LeaderboardConfig.Boards) do
			local store = self.OrderedStores[boardKey]
			if store then
				local statEntry = self:_extractStatEntry(profile, definition)
				local value = statEntry.EncodedValue
				if publishedForUser[boardKey] ~= value then
					local ok, err = pcall(function()
						store:SetAsync(tostring(userId), value)
					end)
					if ok then
						publishedForUser[boardKey] = value
						attemptedWrite = true
					else
						warn("[LeaderboardService] Failed to publish", boardKey, player.Name, err)
					end
				end
			end
		end

		if attemptedWrite then
			self.LastPublishAtByUserId[userId] = now
		end
	end
end

function LeaderboardService:_resolveName(userId, livePlayer)
	if livePlayer then
		self.NameCache[userId] = livePlayer.DisplayName
		return livePlayer.DisplayName
	end
	if self.NameCache[userId] then
		return self.NameCache[userId]
	end

	local success, result = pcall(function()
		return Players:GetNameFromUserIdAsync(userId)
	end)
	if success and type(result) == "string" and result ~= "" then
		self.NameCache[userId] = result
		return result
	end
	return "User " .. tostring(userId)
end

function LeaderboardService:_formatDuration(seconds)
	seconds = math.max(0, math.floor(tonumber(seconds) or 0))
	local days = math.floor(seconds / 86400)
	local hours = math.floor((seconds % 86400) / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	if days > 0 then
		return string.format("%dd %dh %dm", days, hours, minutes)
	elseif hours > 0 then
		return string.format("%dh %dm", hours, minutes)
	elseif minutes > 0 then
		return string.format("%dm %ds", minutes, secs)
	else
		return string.format("%ds", secs)
	end
end

function LeaderboardService:_formatValue(definition, value, encodedValue)
	if definition.ValueFormat == "duration" then
		local durationValue = tonumber(value)
		if durationValue == nil then
			durationValue = tonumber(encodedValue) or 0
		end
		return self:_formatDuration(durationValue)
	end
	if self:_getValueType(definition) == "big" then
		local normalizedBig = nil
		if value ~= nil then
			normalizedBig = LeaderboardShared.NormalizeBig(value)
		end
		if normalizedBig and normalizedBig.mantissa and normalizedBig.mantissa > 0 then
			return LeaderboardShared.FormatBig(normalizedBig, true)
		end
		return LeaderboardShared.FormatBigFromScore(encodedValue or 0, true)
	end
	return MathUtility.FormatNumber(value)
end
function LeaderboardService:_readGlobalEntries(boardKey)
	if self.IsStudio then
		return {}
	end

	local store = self.OrderedStores[boardKey]
	if not store then
		return {}
	end

	local success, pages = pcall(function()
		return store:GetSortedAsync(false, LeaderboardConfig.MaxEntries)
	end)
	if not success then
		warn("[LeaderboardService] Failed to read ordered store", boardKey, pages)
		return nil
	end

	local entries = {}
	for _, item in ipairs(pages:GetCurrentPage()) do
		local userId = tonumber(item.key)
		if userId and userId > 0 then
			entries[userId] = {
				UserId = userId,
				EncodedValue = self:_sanitizeOrderedValue(item.value),
			}
		end
	end
	return entries
end

function LeaderboardService:_buildEntries(boardKey, definition)
	local merged = {}
	local cachedEntries = self.IsStudio and nil or self.CachedGlobalEntries[boardKey]
	if cachedEntries then
		for userId, entry in pairs(cachedEntries) do
			local encodedValue = self:_sanitizeOrderedValue(entry.EncodedValue or entry.Value)
			local displayValue = entry.DisplayValue
			if displayValue == nil then
				if definition.ValueFormat == "duration" then
					displayValue = encodedValue
				elseif self:_getValueType(definition) == "big" then
					displayValue = LeaderboardShared.DecodeBig(encodedValue)
				else
					displayValue = encodedValue
				end
			end
			merged[userId] = {
				UserId = entry.UserId,
				EncodedValue = encodedValue,
				DisplayValue = displayValue,
			}
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		local profile = self.DataService:GetProfile(player)
		local statEntry = {
			EncodedValue = 0,
			DisplayValue = 0,
		}
		if profile then
			statEntry = self:_extractStatEntry(profile, definition)
		elseif not self.IsStudio then
			continue
		end

		local existing = merged[player.UserId]
		if self.IsStudio or not existing or statEntry.EncodedValue > existing.EncodedValue then
			merged[player.UserId] = {
				UserId = player.UserId,
				EncodedValue = statEntry.EncodedValue,
				DisplayValue = statEntry.DisplayValue,
				LivePlayer = player,
			}
		end
	end

	local entries = {}
	for _, entry in pairs(merged) do
		table.insert(entries, entry)
	end
	table.sort(entries, function(left, right)
		if left.EncodedValue == right.EncodedValue then
			return left.UserId < right.UserId
		end
		return left.EncodedValue > right.EncodedValue
	end)
	while #entries > LeaderboardConfig.MaxEntries do
		table.remove(entries)
	end

	for rank, entry in ipairs(entries) do
		entry.Rank = rank
		entry.DisplayName = self:_resolveName(entry.UserId, entry.LivePlayer)
		entry.FaceImage = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420", entry.UserId)
		entry.FormattedValue = self:_formatValue(definition, entry.DisplayValue, entry.EncodedValue)
	end
	return entries
end

function LeaderboardService:_getSlotFrame(board, rank)
	local legacyFrame = rank == 1 and board.Slots.LegacyTopOne
		or rank == 2 and board.Slots.LegacyTopTwo
		or rank == 3 and board.Slots.LegacyTopThree
	if legacyFrame then
		legacyFrame.Parent = board.PlayerList
		legacyFrame.LayoutOrder = rank
		self:_setFrameDisplayed(board, legacyFrame, true)
		return legacyFrame
	end

	local frame = board.RuntimeFrames[rank]
	if frame and frame.Parent == board.PlayerList then
		frame.LayoutOrder = rank
		self:_setFrameDisplayed(board, frame, true)
		return frame
	end

	local template = board.RuntimeTemplateSource
	if not template then
		return nil
	end

	frame = template:Clone()
	frame.Name = "PlayerTemplate_" .. tostring(rank)
	frame.LayoutOrder = rank
	frame.Parent = board.PlayerList
	board.RuntimeFrames[rank] = frame
	self:_rememberFrameDefaults(board, frame)
	self:_setFrameDisplayed(board, frame, true)
	return frame
end

function LeaderboardService:_findPlayerIconImage(frame)
	if not frame then
		return nil
	end

	local iconContainer = frame:FindFirstChild("PlayerIcon", true)
	if iconContainer then
		if iconContainer:IsA("ImageLabel") or iconContainer:IsA("ImageButton") then
			return iconContainer
		end
		for _, descendant in ipairs(iconContainer:GetDescendants()) do
			if descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
				return descendant
			end
		end
	end

	for _, descendant in ipairs(frame:GetDescendants()) do
		if descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
			return descendant
		end
	end

	return nil
end

function LeaderboardService:_populateFrame(board, frame, entry)
	if not frame or not entry then
		return
	end

	self:_setFrameDisplayed(board, frame, true)
	frame.LayoutOrder = entry.Rank or 0
	frame:SetAttribute("Rank", entry.Rank)
	frame:SetAttribute("UserId", entry.UserId)

	local face = self:_findPlayerIconImage(frame)
	local position = frame:FindFirstChild("PlayerPosition", true)
		or frame:FindFirstChild("Position", true)
		or frame:FindFirstChild("Place", true)
		or frame:FindFirstChild("Rank", true)
	local nameLabel = frame:FindFirstChild("PlayerName", true)
	local valueLabel = frame:FindFirstChild("Value", true)

	if face and (face:IsA("ImageLabel") or face:IsA("ImageButton")) then
		face.Image = entry.FaceImage
	end
	if position and position:IsA("TextLabel") then
		position.Text = "#" .. tostring(entry.Rank)
	end
	if nameLabel and nameLabel:IsA("TextLabel") then
		nameLabel.Text = entry.DisplayName
	end
	if valueLabel and valueLabel:IsA("TextLabel") then
		valueLabel.Text = entry.FormattedValue
	end
end

function LeaderboardService:_clearUnusedFrames(board, startRank)
	for rank = startRank, #board.RuntimeFrames do
		local frame = board.RuntimeFrames[rank]
		if frame then
			frame:Destroy()
			board.RuntimeFrames[rank] = nil
		end
	end

	for rank, legacyFrame in ipairs({ board.Slots.LegacyTopOne, board.Slots.LegacyTopTwo, board.Slots.LegacyTopThree }) do
		if legacyFrame and rank >= startRank then
			self:_setFrameDisplayed(board, legacyFrame, false)
			legacyFrame:SetAttribute("Rank", nil)
			legacyFrame:SetAttribute("UserId", nil)
			legacyFrame.Parent = board.SurfaceGui
		end
	end
end

function LeaderboardService:_getDisplayedFrames(board)
	local displayed = {}
	if not board or not board.PlayerList then
		return displayed
	end

	for _, child in ipairs(board.PlayerList:GetChildren()) do
		if child:IsA("Frame") and child.Visible then
			table.insert(displayed, child)
		end
	end

	table.sort(displayed, function(left, right)
		return (left.LayoutOrder or 0) < (right.LayoutOrder or 0)
	end)
	return displayed
end

function LeaderboardService:_syncCanvas(_board)
	return
end

function LeaderboardService:_getPodiumDummy(board)
	if not board or not board.PodiumFolder then
		return nil
	end

	local dummy = board.PodiumDummy
	if dummy and dummy.Parent == board.PodiumFolder then
		return dummy
	end

	dummy = board.PodiumFolder:FindFirstChild("Dummy")
	if not dummy then
		for _, child in ipairs(board.PodiumFolder:GetChildren()) do
			if child:IsA("Model") and child:FindFirstChildOfClass("Humanoid") then
				dummy = child
				break
			end
		end
	end
	if dummy and dummy:IsA("Model") then
		board.PodiumDummy = dummy
		return dummy
	end

	warn("[LeaderboardService] Missing podium dummy for board", board.Definition and board.Definition.BoardModelName)
	return nil
end

function LeaderboardService:_validatePodiumDummy(dummy)
	if not dummy or not dummy:IsA("Model") then
		return nil, nil
	end

	local humanoid = dummy:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 then
		warn("[LeaderboardService] Podium dummy must be an R6 rig", dummy:GetFullName())
		return nil, nil
	end

	for _, partName in ipairs(PODIUM_REQUIRED_PARTS) do
		local part = dummy:FindFirstChild(partName)
		if not part or not part:IsA("BasePart") then
			warn("[LeaderboardService] Podium dummy missing body part", dummy:GetFullName(), partName)
			return nil, nil
		end
	end

	for _, jointInfo in ipairs(PODIUM_REQUIRED_JOINTS) do
		local jointParent = dummy:FindFirstChild(jointInfo[1])
		local joint = jointParent and jointParent:FindFirstChild(jointInfo[2])
		if not joint or not joint:IsA("Motor6D") then
			warn("[LeaderboardService] Podium dummy missing Motor6D", dummy:GetFullName(), jointInfo[2])
			return nil, nil
		end
	end

	return humanoid, dummy:FindFirstChild("HumanoidRootPart")
end

function LeaderboardService:_clearPodiumDummyAppearance(dummy)
	local head = dummy:FindFirstChild("Head")
	for _, descendant in ipairs(dummy:GetDescendants()) do
		if descendant:IsA("Accessory")
			or descendant:IsA("Shirt")
			or descendant:IsA("Pants")
			or descendant:IsA("ShirtGraphic")
			or descendant:IsA("BodyColors")
			or descendant:IsA("CharacterMesh") then
			descendant:Destroy()
		elseif descendant:IsA("Decal") and descendant.Parent == head then
			descendant:Destroy()
		elseif descendant:IsA("BaseScript") and descendant.Name == "Animate" then
			descendant.Disabled = true
		elseif descendant:IsA("Animator") or descendant:IsA("AnimationController") then
			descendant:Destroy()
		elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
			descendant.Enabled = false
		end
	end
end

function LeaderboardService:_preparePodiumDummyForAppearance(dummy, humanoid)
	for _, descendant in ipairs(dummy:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Anchored = false
			descendant.CanCollide = false
			descendant.Massless = true
			descendant.AssemblyLinearVelocity = Vector3.zero
			descendant.AssemblyAngularVelocity = Vector3.zero
		end
	end

	humanoid.PlatformStand = false
	humanoid.AutoRotate = false
	humanoid.Sit = false
	pcall(function()
		humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end)
end

function LeaderboardService:_getPodiumScale(dummy)
	if not dummy then
		return 1
	end

	local success, scale = pcall(function()
		return dummy:GetScale()
	end)
	if success and type(scale) == "number" and scale > 0 then
		return scale
	end
	return 1
end

function LeaderboardService:_scalePodiumHead(dummy, scale)
	local head = dummy:FindFirstChild("Head")
	if not head or not head:IsA("BasePart") then
		return
	end

	for _, child in ipairs(head:GetChildren()) do
		if child:IsA("SpecialMesh") then
			child.Scale = Vector3.new(1.25, 1.25, 1.25)
			child.Offset = Vector3.zero
		elseif child:IsA("Attachment") then
			local attachmentInfo = PODIUM_R6_ATTACHMENT_MAP[child.Name]
			if attachmentInfo and attachmentInfo.Part == "Head" then
				child.Position = attachmentInfo.Position * scale
			end
		end
	end
end

function LeaderboardService:_scalePodiumAccessory(accessory, scale)
	local handle = accessory:FindFirstChild("Handle")
	if not handle or not handle:IsA("BasePart") then
		return
	end

	handle.CanCollide = false
	handle.Massless = true

	local originalSize = handle:GetAttribute("PodiumOriginalSize")
	if typeof(originalSize) ~= "Vector3" then
		originalSize = handle.Size
		handle:SetAttribute("PodiumOriginalSize", originalSize)
	end

	local hasSpecialMesh = false
	for _, descendant in ipairs(handle:GetDescendants()) do
		if descendant:IsA("SpecialMesh") then
			hasSpecialMesh = true
			local meshScale = descendant:GetAttribute("PodiumOriginalScale")
			if typeof(meshScale) ~= "Vector3" then
				meshScale = descendant.Scale
				descendant:SetAttribute("PodiumOriginalScale", meshScale)
			end
			local meshOffset = descendant:GetAttribute("PodiumOriginalOffset")
			if typeof(meshOffset) ~= "Vector3" then
				meshOffset = descendant.Offset
				descendant:SetAttribute("PodiumOriginalOffset", meshOffset)
			end
			descendant.Scale = meshScale * scale
			descendant.Offset = meshOffset * scale
		elseif descendant:IsA("Attachment") then
			local basePosition = descendant:GetAttribute("PodiumOriginalPosition")
			if typeof(basePosition) ~= "Vector3" then
				basePosition = descendant.Position
				descendant:SetAttribute("PodiumOriginalPosition", basePosition)
			end
			descendant.Position = basePosition * scale
		end
	end

	if not hasSpecialMesh then
		handle.Size = originalSize * scale
	end
end

function LeaderboardService:_scalePodiumAppearance(dummy, scale)
	self:_scalePodiumHead(dummy, scale)
	for _, child in ipairs(dummy:GetChildren()) do
		if child:IsA("Accessory") then
			self:_scalePodiumAccessory(child, scale)
		end
	end
end

function LeaderboardService:_ensurePodiumBodyAttachment(dummy, attachmentName)
	local attachmentInfo = PODIUM_R6_ATTACHMENT_MAP[attachmentName]
	if not attachmentInfo then
		return nil
	end

	local bodyPart = dummy:FindFirstChild(attachmentInfo.Part)
	if not bodyPart or not bodyPart:IsA("BasePart") then
		return nil
	end

	local scaledPosition = attachmentInfo.Position * self:_getPodiumScale(dummy)
	local bodyAttachment = bodyPart:FindFirstChild(attachmentName)
	if bodyAttachment and bodyAttachment:IsA("Attachment") then
		bodyAttachment.Position = scaledPosition
		return bodyAttachment
	end

	bodyAttachment = Instance.new("Attachment")
	bodyAttachment.Name = attachmentName
	bodyAttachment.Position = scaledPosition
	bodyAttachment.Parent = bodyPart
	return bodyAttachment
end

function LeaderboardService:_getAccessoryAttachmentPair(dummy, accessory)
	local handle = accessory:FindFirstChild("Handle")
	if not handle or not handle:IsA("BasePart") then
		return nil, nil, nil
	end

	for _, handleChild in ipairs(handle:GetChildren()) do
		if handleChild:IsA("Attachment") then
			local bodyAttachment = self:_ensurePodiumBodyAttachment(dummy, handleChild.Name)
			if bodyAttachment then
				return handle, handleChild, bodyAttachment
			end
		end
	end

	return handle, nil, nil
end

function LeaderboardService:_rebuildAccessoryWeld(dummy, accessory)
	local handle, handleAttachment, bodyAttachment = self:_getAccessoryAttachmentPair(dummy, accessory)
	if not handle then
		return false
	end

	handle.CanCollide = false
	handle.Massless = true

	if not handleAttachment or not bodyAttachment then
		return false
	end

	for _, child in ipairs(handle:GetChildren()) do
		if child:IsA("Weld") or child:IsA("WeldConstraint") or child.Name == "AccessoryWeld" then
			child:Destroy()
		end
	end

	local accessoryWeld = Instance.new("Weld")
	accessoryWeld.Name = "AccessoryWeld"
	accessoryWeld.Part0 = handle
	accessoryWeld.Part1 = bodyAttachment.Parent
	accessoryWeld.C0 = handleAttachment.CFrame
	accessoryWeld.C1 = bodyAttachment.CFrame
	accessoryWeld.Parent = handle

	handle.CFrame = bodyAttachment.Parent.CFrame * bodyAttachment.CFrame * handleAttachment.CFrame:Inverse()
	return true
end

function LeaderboardService:_reattachPodiumAccessories(dummy, humanoid)
	pcall(function()
		humanoid:BuildRigFromAttachments()
	end)

	for _, accessory in ipairs(dummy:GetChildren()) do
		if accessory:IsA("Accessory") then
			self:_rebuildAccessoryWeld(dummy, accessory)
		end
	end
end

function LeaderboardService:_playPodiumAnimation(humanoid)
	if not humanoid or not humanoid.Parent then
		return
	end

	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop(0)
	end

	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = humanoid:FindFirstChild("PodiumAnimation")
	if not animation or not animation:IsA("Animation") then
		animation = Instance.new("Animation")
		animation.Name = "PodiumAnimation"
		animation.Parent = humanoid
	end
	animation.AnimationId = PODIUM_ANIMATION_ID

	local ok, track = pcall(function()
		return animator:LoadAnimation(animation)
	end)
	if not ok or not track then
		warn("[LeaderboardService] Failed to load podium animation")
		return
	end

	track.Priority = Enum.AnimationPriority.Action3
	track.Looped = true
	track:Play(0)
	track:AdjustSpeed(PODIUM_ANIMATION_SPEED)
end

function LeaderboardService:_freezePodiumDummy(dummy, humanoid, rootPart)
	for _, descendant in ipairs(dummy:GetDescendants()) do
		if descendant:IsA("BaseScript") and descendant.Name == "Animate" then
			descendant.Disabled = true
		elseif descendant:IsA("BasePart") then
			descendant.Anchored = true
			descendant.CanCollide = false
			descendant.AssemblyLinearVelocity = Vector3.zero
			descendant.AssemblyAngularVelocity = Vector3.zero
		end
	end

	if rootPart then
		rootPart.Transparency = 1
	end

	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	humanoid.NameDisplayDistance = 0
	humanoid.HealthDisplayDistance = 0
	humanoid.AutoRotate = false
	humanoid.PlatformStand = false
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.JumpHeight = 0
	humanoid.Sit = false
end

function LeaderboardService:_getPodiumDummyBottomY(dummy)
	local lowestY = nil
	for _, descendant in ipairs(dummy:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
			local accessory = descendant:FindFirstAncestorWhichIsA("Accessory")
			if not accessory and descendant.Transparency < 1 then
				local partBottomY = descendant.Position.Y - (descendant.Size.Y * 0.5)
				if not lowestY or partBottomY < lowestY then
					lowestY = partBottomY
				end
			end
		end
	end
	return lowestY
end

function LeaderboardService:_placePodiumDummy(dummy, board, rootPart)
	local bodyBottomY = self:_getPodiumDummyBottomY(dummy)
	local rootToBottom = bodyBottomY and (rootPart.Position.Y - bodyBottomY) or 3
	local targetPosition = board.PodiumAnchorCFrame.Position + Vector3.new(0, rootToBottom + PODIUM_GROUND_EPSILON, 0)
	local targetCFrame = CFrame.lookAt(targetPosition, targetPosition + board.PodiumAnchorCFrame.LookVector)
	dummy:PivotTo(targetCFrame)
end

function LeaderboardService:_applyPodiumDescription(board, userId)
	local dummy = self:_getPodiumDummy(board)
	if not dummy or not userId or userId <= 0 then
		return
	end

	local humanoid, rootPart = self:_validatePodiumDummy(dummy)
	if not humanoid or not rootPart then
		return
	end

	if board.LastPodiumUserId ~= userId then
		local ok, description = pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(userId)
		end)
		if not ok or not description then
			warn("[LeaderboardService] Failed to load humanoid description for podium", userId)
			return
		end

		local targetScale = self:_getPodiumScale(dummy)
		self:_clearPodiumDummyAppearance(dummy)
		self:_preparePodiumDummyForAppearance(dummy, humanoid)

		local applied = false
		if typeof(humanoid.ApplyDescriptionReset) == "function" then
			applied = pcall(function()
				humanoid:ApplyDescriptionReset(description)
			end)
		end
		if not applied then
			local fallbackApplied = pcall(function()
				humanoid:ApplyDescription(description)
			end)
			if not fallbackApplied then
				warn("[LeaderboardService] Failed to apply humanoid description to podium dummy", userId)
				return
			end
		end

		pcall(function()
			dummy:ScaleTo(targetScale)
		end)
		self:_scalePodiumAppearance(dummy, targetScale)
		self:_reattachPodiumAccessories(dummy, humanoid)
		dummy.Name = string.format("Rank_1_%d", userId)
		board.LastPodiumUserId = userId
	end

	self:_freezePodiumDummy(dummy, humanoid, rootPart)
	self:_placePodiumDummy(dummy, board, rootPart)
	task.defer(function()
		self:_playPodiumAnimation(humanoid)
	end)
end

function LeaderboardService:_updatePodium(board, entry)
	if not board then
		return
	end

	self:_applyPodiumDescription(board, entry and entry.UserId or nil)
	local dummy = self:_getPodiumDummy(board)
	if not dummy then
		return
	end
	local humanoid = dummy:FindFirstChildOfClass("Humanoid")
	if humanoid then
		task.defer(function()
			self:_playPodiumAnimation(humanoid)
		end)
	end
end
function LeaderboardService:_refreshBoardDisplays(_isInitial)
	for boardKey, board in pairs(self.Boards) do
		local entries = self:_buildEntries(boardKey, board.Definition)
		self:_applyEntries(boardKey, entries)
	end
end

function LeaderboardService:_runScheduledRefresh(isInitial)
	self:_publishCurrentPlayers()
	for boardKey in pairs(self.Boards) do
		local freshEntries = self:_readGlobalEntries(boardKey)
		if freshEntries ~= nil then
			self.CachedGlobalEntries[boardKey] = freshEntries
		end
		if ORDERED_READ_STAGGER_SECONDS > 0 then
			task.wait(ORDERED_READ_STAGGER_SECONDS)
		end
	end
	self:_refreshBoardDisplays(isInitial)
	self.NextRefreshAt = os.time() + LeaderboardConfig.RefreshIntervalSeconds
	self:_updateRefreshLabels()
end

function LeaderboardService:_applyEntries(boardKey, entries)
	local board = self.Boards[boardKey]
	if not board or not board.PlayerList then
		return
	end

	entries = entries or {}
	for index, entry in ipairs(entries) do
		local frame = self:_getSlotFrame(board, index)
		if frame then
			self:_populateFrame(board, frame, entry)
		end
	end
	self:_clearUnusedFrames(board, #entries + 1)
--	board.PlayerList.CanvasPosition = Vector2.zero
	self:_updatePodium(board, entries[1])
end

function LeaderboardService:_updateRefreshLabels()
	local remaining = math.max(0, self.NextRefreshAt - os.time())
	for _, board in pairs(self.Boards) do
		if board.RefreshLabel and board.RefreshLabel:IsA("TextLabel") then
			board.RefreshLabel.Text = string.format("Refresh: %ss", remaining)
		end
	end
end

return LeaderboardService