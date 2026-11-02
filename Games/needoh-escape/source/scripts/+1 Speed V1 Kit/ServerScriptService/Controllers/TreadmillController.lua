--!strict
-- LOCATION: ServerScriptService/Controllers/TreadmillController

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)

-- Constants
local TICK_RATE = 0.5
local TREADMILLS_FOLDER = Workspace:WaitForChild("Treadmills")
local START_PART_NAME = "Start"

-- RequirementType:
--   "none"     → anyone can use
--   "rebirths" → player needs RebirthCount rebirths
--   "gamepass" → player needs to own GamePassId
local TREADMILL_CONFIG = {
	Basic = {
		Multiplier = 1,
		Color = Color3.fromRGB(255, 255, 255),
		RequirementType = "none",
	},
	Diamond = {
		Multiplier = 1.5,
		Color = Color3.fromRGB(85, 255, 255),
		RequirementType = "rebirths",
		RebirthCount = 3,
	},
	Amethyst = {
		Multiplier = 2,
		Color = Color3.fromRGB(185, 64, 255),
		RequirementType = "rebirths",
		RebirthCount = 5,
	},
	Gold = {
		Multiplier = 5,
		Color = Color3.fromRGB(255, 215, 0),
		RequirementType = "gamepass",
		GamePassId = ProductConfigurations.GoldTreadmillGP,
	},
	Admin = {
		Multiplier = 10,
		Color = Color3.fromRGB(255, 0, 4),
		RequirementType = "gamepass",
		GamePassId = ProductConfigurations.DiamondTreadmillGP,
	},
}

local TreadmillController = {}
local activeTreadmills: {[Player]: Model} = {}

-- Gamepass ownership cache
-- [userId][passId] = true | false | "pending" | nil (retry)
local ownershipCache: {[number]: {[number]: boolean | "pending"}} = {}

local PlayerController: any
local timeAccumulator = 0

-- [ HELPERS ] ----------------------------------------------------------------

local function getTreadmillFromPart(part: BasePart): (Model?, string?)
	if not part then return nil, nil end
	local parent = part.Parent
	while parent and parent ~= Workspace do
		if parent.Parent == TREADMILLS_FOLDER then
			return parent :: Model, parent.Name
		end
		parent = parent.Parent
	end
	return nil, nil
end

local function applyHighlight(model: Model, color: Color3)
	local highlight = model:FindFirstChild("ActiveHighlight") :: Highlight
	if not highlight then
		highlight = Instance.new("Highlight")
		highlight.Name = "ActiveHighlight"
		highlight.FillColor = color
		highlight.OutlineColor = color
		highlight.FillTransparency = 0.8
		highlight.OutlineTransparency = 0.2
		highlight.Parent = model
	end
	highlight.Enabled = true
end

local function removeHighlight(model: Model)
	local highlight = model:FindFirstChild("ActiveHighlight") :: Highlight
	if highlight then highlight.Enabled = false end
end

-- Async gamepass check — returns true/false when known, nil while pending
local function checkGamePass(player: Player, passId: number): boolean?
	local userId = player.UserId
	if not ownershipCache[userId] then ownershipCache[userId] = {} end

	local cached = ownershipCache[userId][passId]
	if cached == "pending" then return nil end
	if cached ~= nil then return cached :: boolean end

	-- Fire async fetch
	ownershipCache[userId][passId] = "pending"
	task.spawn(function()
		local ok, result = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(userId, passId)
		end)
		if ok then
			ownershipCache[userId][passId] = result
		else
			ownershipCache[userId][passId] = nil -- allow retry next tick
		end
	end)
	return nil
end

-- Synchronous rebirth check
local function checkRebirths(player: Player, required: number): boolean
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return false end
	local rebirths = leaderstats:FindFirstChild("Rebirths")
	return rebirths ~= nil and rebirths.Value >= required
end

-- Returns true (allowed), false (denied), or nil (still loading)
local function checkAccess(player: Player, config: any): boolean?
	local rType = config.RequirementType
	if rType == "none" then
		return true
	elseif rType == "rebirths" then
		return checkRebirths(player, config.RebirthCount)
	elseif rType == "gamepass" then
		return checkGamePass(player, config.GamePassId)
	end
	return true
end

local function kickFromTreadmill(player: Player, config: any)
	local char = player.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart") :: BasePart
	local startPart = Workspace:FindFirstChild(START_PART_NAME) :: BasePart
	if not (root and startPart) then return end

	root.CFrame = startPart.CFrame + Vector3.new(0, 3, 0)

	if PlayerController then
		if config.RequirementType == "rebirths" then
			PlayerController:Notify(player, "Locked! You need " .. config.RebirthCount .. " rebirths.", "Error")
		elseif config.RequirementType == "gamepass" then
			PlayerController:Notify(player, "Locked! You need the Gamepass.", "Error")
			MarketplaceService:PromptGamePassPurchase(player, config.GamePassId)
		end
	end
end

-- Pre-load all gamepass treadmill passes for a player on join
local function preLoadGamePasses(player: Player)
	local userId = player.UserId
	if not ownershipCache[userId] then ownershipCache[userId] = {} end
	for _, config in pairs(TREADMILL_CONFIG) do
		if config.RequirementType == "gamepass" then
			local passId = config.GamePassId
			if ownershipCache[userId][passId] == nil then
				ownershipCache[userId][passId] = "pending"
				task.spawn(function()
					local ok, result = pcall(function()
						return MarketplaceService:UserOwnsGamePassAsync(userId, passId)
					end)
					if ok then
						ownershipCache[userId][passId] = result
					else
						ownershipCache[userId][passId] = nil
					end
				end)
			end
		end
	end
end

-- [ LOGIC ] ------------------------------------------------------------------

local function checkTreadmills(deltaTime: number)
	timeAccumulator += deltaTime
	local shouldAwardPoints = false
	if timeAccumulator >= TICK_RATE then
		shouldAwardPoints = true
		timeAccumulator = 0
	end

	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		if not character then continue end

		local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not rootPart then continue end

		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {character}
		rayParams.FilterType = Enum.RaycastFilterType.Exclude

		local rayResult = Workspace:Raycast(rootPart.Position, Vector3.new(0, -3.5, 0), rayParams)
		local floorPart = rayResult and rayResult.Instance

		local treadmillModel, treadmillName = nil, nil
		if floorPart then
			treadmillModel, treadmillName = getTreadmillFromPart(floorPart)
		end

		local previousModel = activeTreadmills[player]

		if treadmillModel then
			local config = TREADMILL_CONFIG[treadmillName]

			if config then
				local access = checkAccess(player, config)

				if access == nil then
					-- Still loading (gamepass fetch in progress) — allow standing, skip points
					continue
				end

				if not access then
					-- Denied — kick and prompt if gamepass
					kickFromTreadmill(player, config)
					if previousModel then
						removeHighlight(previousModel)
						activeTreadmills[player] = nil
					end
					continue
				end

				-- Access granted
				if previousModel ~= treadmillModel then
					if previousModel then removeHighlight(previousModel) end
					activeTreadmills[player] = treadmillModel
					applyHighlight(treadmillModel, config.Color)
				end

				if shouldAwardPoints and PlayerController then
					PlayerController:AddSpeedPoints(player)
				end

			else
				if previousModel then
					removeHighlight(previousModel)
					activeTreadmills[player] = nil
				end
			end
		else
			if previousModel then
				removeHighlight(previousModel)
				activeTreadmills[player] = nil
			end
		end
	end
end

-- [ PUBLIC API ] -------------------------------------------------------------

function TreadmillController:GetMultiplier(player: Player): number
	local model = activeTreadmills[player]
	if model then
		local config = TREADMILL_CONFIG[model.Name]
		if config then return config.Multiplier end
	end
	return 1
end

function TreadmillController:IsOnTreadmill(player: Player): boolean
	return activeTreadmills[player] ~= nil
end

function TreadmillController:Init(controllers)
	PlayerController = controllers.PlayerController
end

function TreadmillController:Start()
	RunService.Heartbeat:Connect(checkTreadmills)

	-- Instantly update cache when a gamepass is purchased mid-session
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, wasPurchased)
		if wasPurchased then
			if not ownershipCache[player.UserId] then ownershipCache[player.UserId] = {} end
			ownershipCache[player.UserId][passId] = true
		end
	end)

	-- Pre-load passes for players already in the game
	for _, player in ipairs(Players:GetPlayers()) do
		preLoadGamePasses(player)
	end

	Players.PlayerAdded:Connect(function(player)
		preLoadGamePasses(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		ownershipCache[player.UserId] = nil
		if activeTreadmills[player] then
			removeHighlight(activeTreadmills[player])
			activeTreadmills[player] = nil
		end
	end)
end

return TreadmillController