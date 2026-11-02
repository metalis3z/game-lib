--!strict
-- LOCATION: ServerScriptService/PlotManager

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

-- Modules
local PlayerController = require(ServerScriptService.Controllers.PlayerController)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

-- Assets
local Templates = ReplicatedStorage:WaitForChild("Templates")
local PlotTemplate = Templates:WaitForChild("Plot")
local PlotsFolder = Workspace:WaitForChild("Plots")
local Events = ReplicatedStorage:WaitForChild("Events")

-- Config
local UPGRADE_PRICES = { [0] = 250000, [1] = 1000000,}
local MAX_LEVEL = 2

-- State
local occupiedPlots = {} 
local activePlotModels = {} 

-- [ HELPER FUNCTIONS ] -------------------------------------------------------

local function getFreePlotIndex(): number?
	for i = 1, 5 do
		local taken = false
		for _, index in pairs(occupiedPlots) do
			if index == i then taken = true; break end
		end
		if not taken then return i end
	end
	return nil
end

local function initializePlotVisuals(plotModel: Model)
	for _, part in ipairs(plotModel:GetDescendants()) do
		if part:IsA("BasePart") then
			part:SetAttribute("OriginalTransparency", part.Transparency)
			part:SetAttribute("OriginalCanCollide", part.CanCollide)
		end
	end
end

local function setFloorVisibility(plotModel: Model, floorName: string, visible: boolean)
	local floor = plotModel:FindFirstChild(floorName)
	if floor then
		for _, part in ipairs(floor:GetDescendants()) do
			if part:IsA("BasePart") then
				if visible then
					local originalTrans = part:GetAttribute("OriginalTransparency") or 0
					local originalCollide = part:GetAttribute("OriginalCanCollide")
					if originalCollide == nil then originalCollide = true end

					part.Transparency = originalTrans
					part.CanCollide = originalCollide
				else
					part.Transparency = 1
					part.CanCollide = false
				end
			end
		end
	end
end

local function updatePlotVisuals(player: Player, baseLevel: number)
	local plotModel = activePlotModels[player]
	if not plotModel then return end

	setFloorVisibility(plotModel, "Floor1", true) 
	setFloorVisibility(plotModel, "Floor2", baseLevel >= 1)
	setFloorVisibility(plotModel, "Floor3", baseLevel >= 2)

	local baseUpgrade = plotModel:FindFirstChild("BaseUpgrade")
	if baseUpgrade then
		local guiPart = baseUpgrade:FindFirstChild("GUIPart")
		if guiPart then
			guiPart:SetAttribute("CurrentLevel", baseLevel)
			guiPart:SetAttribute("MaxLevel", MAX_LEVEL)
			guiPart:SetAttribute("Price", UPGRADE_PRICES[baseLevel] or 0)
			guiPart:SetAttribute("OwnerId", player.UserId)
		end
	end
end

-- [ CORE LOGIC ] -------------------------------------------------------------

local function spawnPlot(player: Player)
	local index = getFreePlotIndex()
	if not index then player:Kick("No free plots available."); return end

	occupiedPlots[player] = index

	local locator = PlotsFolder:FindFirstChild(tostring(index))
	if not locator then warn("Locator not found") return end

	local newPlot = PlotTemplate:Clone()
	newPlot.Name = "Plot_" .. player.Name
	newPlot.Parent = Workspace
	newPlot:SetPrimaryPartCFrame(locator.CFrame)

	-- ## ADDED: Disable PlotGUI by default (Server Side) ##
	local spawnPart = newPlot:FindFirstChild("Spawn")
	if spawnPart then
		local plotGui = spawnPart:FindFirstChild("PlotGUI") :: SurfaceGui
		if plotGui then
			-- We disable it here so other players don't see it
			-- The owner will enable it locally in PlotController
			plotGui.Enabled = false
		end
	end

	initializePlotVisuals(newPlot)

	activePlotModels[player] = newPlot

	local profile = PlayerController:GetProfile(player)
	if profile then
		updatePlotVisuals(player, profile.Data.BaseLevel)
	end
end

local function handleCharacterSpawn(player: Player, character: Model)
	local plotModel = activePlotModels[player]
	if plotModel and plotModel.PrimaryPart then
		character:WaitForChild("HumanoidRootPart").CFrame = plotModel.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
	end
end

-- [ EVENTS ] -----------------------------------------------------------------

Players.PlayerAdded:Connect(function(player)
	repeat task.wait() until PlayerController:GetProfile(player)
	spawnPlot(player)

	player.CharacterAdded:Connect(function(char)
		task.wait(0.1) 
		handleCharacterSpawn(player, char)
	end)

	if player.Character then handleCharacterSpawn(player, player.Character) end
end)

Players.PlayerRemoving:Connect(function(player)
	if activePlotModels[player] then
		activePlotModels[player]:Destroy()
		activePlotModels[player] = nil
	end
	occupiedPlots[player] = nil
end)

local requestUpgrade = Events:WaitForChild("RequestBaseUpgrade")

requestUpgrade.OnServerEvent:Connect(function(player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	local currentLevel = profile.Data.BaseLevel
	if currentLevel >= MAX_LEVEL then return end

	local price = UPGRADE_PRICES[currentLevel]

	if PlayerController:DeductMoney(player, price) then
		local newLevel = PlayerController:IncrementBaseLevel(player)
		updatePlotVisuals(player, newLevel)

		local notif = Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Upgrade Successful!", "Success") end
	else
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Not enough Money!", "Error") end
	end
end)

print("[PlotManager] Active")