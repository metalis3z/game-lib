--!strict
-- LOCATION: ServerScriptService/PlotManager
-- Sistema de Plots: 8 plots pre-posicionados permanentemente no mapa
-- Floor1 sempre visivel, Floor2/Floor3 aparecem quando comprados
-- Player spawn de frente para sua base

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

-- Modules
local PlayerController = require(ServerScriptService.Controllers.PlayerController)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local SlotManager = require(ServerScriptService.Modules.SlotManager)

-- Assets
local Templates = ReplicatedStorage:WaitForChild("Templates")
local PlotsFolder = Workspace:WaitForChild("Plots")
local Events = ReplicatedStorage:WaitForChild("Events")
local PlotRebirthFolder = ReplicatedStorage:WaitForChild("PlotRebirth")

-- [ FIX: Ensure Event Exists ]
local requestUpgrade = Events:FindFirstChild("RequestBaseUpgrade") or Instance.new("RemoteEvent")
requestUpgrade.Name = "RequestBaseUpgrade"
requestUpgrade.Parent = Events

-- [ CONFIGURATION: PRICES ]
local UPGRADE_PRICES = {
	[0] = 100000,   -- Cost to unlock Floor 2
	[1] = 900000,   -- Cost to unlock Floor 3
}
local REBIRTH_REQUIREMENTS = {
	[0] = 5,        -- Rebirths needed to unlock Floor 2
	[1] = 24,       -- Rebirths needed to unlock Floor 3
}
local MAX_LEVEL = 2

-- State
local occupiedPlots = {} 
local activePlotModels = {} 

local PlotManager = {}
function PlotManager.GetPrice(currentLevel: number)
	return UPGRADE_PRICES[currentLevel]
end
function PlotManager.GetMaxLevel()
	return MAX_LEVEL
end
function PlotManager.GetRebirthRequirement(currentLevel: number)
	return REBIRTH_REQUIREMENTS[currentLevel] or 0
end

-- [ HELPER FUNCTIONS ] -------------------------------------------------------

local function getFreePlotIndex(): number?
	for i = 1, 8 do
		local taken = false
		for _, index in pairs(occupiedPlots) do
			if index == i then taken = true; break end
		end
		if not taken then return i end
	end
	return nil
end

local function storeOriginalProperties(model: Instance)
	for _, child in ipairs(model:GetDescendants()) do
		if child:IsA("BasePart") then
			if child:GetAttribute("OriginalTransparency") == nil then
				child:SetAttribute("OriginalTransparency", child.Transparency)
				child:SetAttribute("OriginalCanCollide", child.CanCollide)
			end
		end
	end
end

local function setModelVisibility(model: Instance, isVisible: boolean)
	if not model then return end
	for _, child in ipairs(model:GetDescendants()) do
		if child:IsA("BasePart") then
			if isVisible then
				child.Transparency = child:GetAttribute("OriginalTransparency") or 0
				local collide = child:GetAttribute("OriginalCanCollide")
				if collide == nil then collide = true end
				child.CanCollide = collide
			else
				child.Transparency = 1
				child.CanCollide = false
			end
		end
	end
end

-- [NEW] Rebirth-based Floor unlocking -----------------------------------------
-- Floor1 always ships pre-placed inside Workspace.Plots.<index>.
-- Floor2/Floor3 do NOT exist in the live Plot until the player has unlocked
-- them. When unlocked, the correct Floor model is cloned from
-- ReplicatedStorage.PlotRebirth.<plotIndex>.<floorName> into the live plot.
-- Idempotent: if the floor already exists in the plot, this is a no-op, so it
-- is always safe to call again (rejoin, respawn, data reload, re-upgrade)
-- without ever duplicating a floor.
local function ensureFloorUnlocked(plotModel: Model, floorName: string, plotIndex: number?)
	if not plotModel or not plotIndex then return end

	-- Already present in the live plot -> nothing to clone.
	if plotModel:FindFirstChild(floorName) then return end

	local sourceFolder = PlotRebirthFolder:FindFirstChild(tostring(plotIndex))
	if not sourceFolder then
		warn(("[PlotManager] ReplicatedStorage.PlotRebirth.%s not found (needed for %s)"):format(tostring(plotIndex), floorName))
		return
	end

	local template = sourceFolder:FindFirstChild(floorName)
	if not template then
		warn(("[PlotManager] %s template missing in ReplicatedStorage.PlotRebirth.%s"):format(floorName, tostring(plotIndex)))
		return
	end

	-- Defensive re-check right before parenting. Luau has no yield points
	-- between the check above and here, so this can't actually race within a
	-- single call, but it keeps the function safe if that ever changes.
	if plotModel:FindFirstChild(floorName) then return end

	local clone = template:Clone()
	clone.Name = floorName
	clone.Parent = plotModel
end

-- [FIX] Destroy all brainrot VisualItems in a plot's slots so they don't get
-- "stuck" when the plot is recycled to another player.
local function clearAllVisualItems(plotModel: Instance)
	if not plotModel then return end
	for _, descendant in ipairs(plotModel:GetDescendants()) do
		if descendant.Name == "VisualItem" then
			descendant:Destroy()
		end
	end
end

local function updatePlotVisuals(player: Player, baseLevel: number)
	local plotModel = activePlotModels[player]
	if not plotModel then return end

	local plotIndex = plotModel:GetAttribute("OriginalIndex")

	storeOriginalProperties(plotModel)

	for i = 1, 20 do
		local floorName = "Floor" .. i

		-- [NEW] Floor1 always ships pre-placed in the Plot. Floor2/Floor3 do NOT
		-- exist until the player's real Rebirth-derived baseLevel says they're
		-- unlocked - only then do we clone the correct model in from
		-- ReplicatedStorage.PlotRebirth.<plotIndex>. ensureFloorUnlocked() is a
		-- no-op if the floor already exists, so this is always safe to call: on
		-- join, on respawn, on data reload, and on every rebirth/upgrade.
		if i > 1 and i <= baseLevel + 1 then
			ensureFloorUnlocked(plotModel, floorName, plotIndex)
		end

		local floor = plotModel:FindFirstChild(floorName)
		if floor then
			storeOriginalProperties(floor)
			if i <= baseLevel + 1 then
				setModelVisibility(floor, true)

				local slotsFolder = floor:FindFirstChild("Slots")
				if slotsFolder then
					for _, slot in ipairs(slotsFolder:GetChildren()) do
						slot:SetAttribute("IsUnlocked", true)
					end
				end

				local buyFloor = floor:FindFirstChild("BuyFloor")
				if buyFloor then
					if i == baseLevel + 1 and baseLevel < PlotManager.GetMaxLevel() then
						setModelVisibility(buyFloor, true)

						local guiPart = buyFloor:FindFirstChild("GUIPart")
						if guiPart then
							guiPart:SetAttribute("CurrentLevel", baseLevel)
							guiPart:SetAttribute("MaxLevel", PlotManager.GetMaxLevel())
							guiPart:SetAttribute("Price", UPGRADE_PRICES[baseLevel] or 0)
							guiPart:SetAttribute("RebirthRequired", REBIRTH_REQUIREMENTS[baseLevel] or 0)
							guiPart:SetAttribute("OwnerId", player.UserId)
						end
					else
						setModelVisibility(buyFloor, false)
					end
				end

			else
				setModelVisibility(floor, false)
				-- [FIX] Destroy any leftover brainrot VisualItems in locked floors
				-- so they don't reappear "stuck" when the floor is re-unlocked.
				local slotsFolder = floor:FindFirstChild("Slots")
				if slotsFolder then
					for _, slot in ipairs(slotsFolder:GetChildren()) do
						local spawnPart = slot:FindFirstChild("Spawn")
						local existingItem = spawnPart and spawnPart:FindFirstChild("VisualItem")
						if existingItem then existingItem:Destroy() end
					end
				end
			end
		end
	end
end

-- [ PLACAR: photo + name on the plot's Placar board ] -------------------------
local function setupPlacar(player: Player, plotModel: Model)
	local placarPlayer = plotModel:FindFirstChild("PlacarPlayer")
	if not placarPlayer then return end
	local placar = placarPlayer:FindFirstChild("Placar")
	if not placar then return end

	-- Remove any existing Placar gui
	local existing = placar:FindFirstChild("PlacarGUI")
	if existing then existing:Destroy() end

	-- Fetch the player's headshot thumbnail
	local thumbnail = ""
	pcall(function()
		thumbnail = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)

	-- Static SurfaceGui fixed on the Placar board (like the money leaderboard)
	local surface = Instance.new("SurfaceGui")
	surface.Name = "PlacarGUI"
	surface.Face = Enum.NormalId.Top
	surface.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	surface.PixelsPerStud = 100
	surface.CanvasSize = Vector2.new(2250, 750)
	surface.LightInfluence = 0
	surface.Parent = placar

	-- Avatar (photo) - big, rounded corners
	local avatar = Instance.new("ImageLabel")
	avatar.Name = "Avatar"
	avatar.Size = UDim2.fromOffset(600, 600)
	avatar.Position = UDim2.fromOffset(100, 75)
	avatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	avatar.Image = thumbnail
	avatar.ScaleType = Enum.ScaleType.Crop
	avatar.Parent = surface

	local avatarCorner = Instance.new("UICorner")
	avatarCorner.CornerRadius = UDim.new(0, 40)
	avatarCorner.Parent = avatar

	local avatarStroke = Instance.new("UIStroke")
	avatarStroke.Color = Color3.fromRGB(0, 0, 0)
	avatarStroke.Thickness = 8
	avatarStroke.Parent = avatar

	-- Name (big white font, dark outline)
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "Name"
	nameLabel.Size = UDim2.fromOffset(1500, 750)
	nameLabel.Position = UDim2.fromOffset(700, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = player.Name
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	nameLabel.TextStrokeTransparency = 0
	nameLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
	nameLabel.TextScaled = true
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = surface
end

local function clearPlacar(plotModel: Model)
	local placarPlayer = plotModel:FindFirstChild("PlacarPlayer")
	if not placarPlayer then return end
	local placar = placarPlayer:FindFirstChild("Placar")
	if not placar then return end
	local gui = placar:FindFirstChild("PlacarGUI")
	if gui then gui:Destroy() end
end

-- [ CORE LOGIC ] -------------------------------------------------------------

local function spawnPlot(player: Player)
	local index = getFreePlotIndex()
	if not index then player:Kick("No plots available."); return end

	-- Use the pre-placed plot (already in Workspace.Plots)
	local plotModel = PlotsFolder:FindFirstChild(tostring(index))
	-- [FIX] Recover an orphaned plot that may have been left in Workspace
	if not plotModel then
		for _, child in ipairs(Workspace:GetChildren()) do
			if child:IsA("Model") and child:GetAttribute("OriginalIndex") == index then
				plotModel = child
				break
			end
		end
	end
	if not plotModel then
		warn("[PlotManager] Pre-placed plot " .. index .. " not found!")
		-- Mark occupied anyway to avoid re-assigning the same missing plot forever
		occupiedPlots[player] = index
		return
	end

	occupiedPlots[player] = index

	-- [FIX] Clean any leftover brainrot VisualItems from a previous owner
	-- before reusing the plot, so nothing appears "stuck" in the slots.
	clearAllVisualItems(plotModel)

	-- Store original index for when player leaves
	plotModel:SetAttribute("OriginalIndex", index)

	-- Move plot to Workspace (so other scripts can find it with Workspace:FindFirstChild)
	plotModel.Parent = Workspace

	-- Rename to Plot_[PlayerName]
	plotModel.Name = "Plot_" .. player.Name

	local spawnPart = plotModel:FindFirstChild("Spawn")
	if spawnPart then
		local plotGui = spawnPart:FindFirstChild("PlotGUI")
		if plotGui and plotGui:IsA("BillboardGui") then plotGui.Enabled = false end
	end

	activePlotModels[player] = plotModel

	-- Show the player's photo + name on the Placar board
	pcall(setupPlacar, player, plotModel)

	local profile = PlayerController:GetProfile(player)
	if profile then
		updatePlotVisuals(player, profile.Data.BaseLevel or 0)
	end
end

local function handleCharacterSpawn(player: Player, character: Model)
	local plotModel = activePlotModels[player]
	if not plotModel then return end
	local spawnPart = plotModel:FindFirstChild("Spawn")
	if not spawnPart then return end

	-- Wait for HumanoidRootPart with a timeout to avoid infinite yield
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		hrp = character:WaitForChild("HumanoidRootPart", 5)
		if not hrp then return end
	end

	-- Use PivotTo for reliable teleport (preserves Spawn part's rotation so player faces the base)
	local spawnCFrame = spawnPart.CFrame
	local targetCFrame = spawnCFrame + Vector3.new(0, 3, 0)
	character:PivotTo(targetCFrame)
end

-- [ EVENTS ] -----------------------------------------------------------------

Players.PlayerAdded:Connect(function(player)
	-- Assign plot immediately (don't wait for profile)
	spawnPlot(player)

	-- Try to update visuals when profile becomes available (with timeout)
	task.spawn(function()
		local retries = 0
		while not PlayerController:GetProfile(player) and retries < 50 do
			task.wait(0.1)
			retries += 1
		end
		local profile = PlayerController:GetProfile(player)
		if profile then
			updatePlotVisuals(player, profile.Data.BaseLevel or 0)
		end
	end)

	player.CharacterAdded:Connect(function(char)
		task.wait(0.5)
		handleCharacterSpawn(player, char)
	end)

	if player.Character then handleCharacterSpawn(player, player.Character) end
end)

Players.PlayerRemoving:Connect(function(player)
	-- [FIX] Sync ActiveEvent from VisualItems to the player's profile BEFORE
	-- destroying them. PlotManager's PlayerRemoving fires before SlotManager's
	-- and PlayerController's, so without this call the VisualItems (and their
	-- ActiveEvent attributes) would be gone before anyone could read them.
	pcall(SlotManager.SyncActiveEvents, player)

	local plotModel = activePlotModels[player]
	-- [FIX] If not tracked, find the plot by name to avoid leaving it orphaned
	if not plotModel then
		plotModel = Workspace:FindFirstChild("Plot_" .. player.Name)
	end

	if plotModel then
		-- Remove the player's photo + name from the Placar board
		clearPlacar(plotModel)

		-- [FIX] Destroy all brainrot VisualItems so they don't get "stuck"
		-- in slots for the next owner of this plot.
		clearAllVisualItems(plotModel)

		-- Reset the plot: Floor1 stays, Floor2/Floor3 (if any were cloned in for
		-- this player) are fully destroyed rather than just hidden. Workspace
		-- must only ever contain what the CURRENT occupant has actually unlocked -
		-- the next player to receive this plot starts from Floor1 again and gets
		-- their own Floor2/Floor3 cloned in only once their own Rebirths qualify.
		local index = plotModel:GetAttribute("OriginalIndex")
		if index then
			for i = 1, 20 do
				local floor = plotModel:FindFirstChild("Floor" .. i)
				if floor then
					if i == 1 then
						setModelVisibility(floor, true)
						local slotsFolder = floor:FindFirstChild("Slots")
						if slotsFolder then
							for _, slot in ipairs(slotsFolder:GetChildren()) do
								slot:SetAttribute("IsUnlocked", false)
							end
						end
					else
						floor:Destroy()
					end
				end
			end

			-- Re-enable PlotGUI on Spawn
			local spawnPart = plotModel:FindFirstChild("Spawn")
			if spawnPart then
				local plotGui = spawnPart:FindFirstChild("PlotGUI")
				if plotGui and plotGui:IsA("BillboardGui") then plotGui.Enabled = true end
			end

			-- Move back to PlotsFolder and rename to original index
			plotModel.Parent = PlotsFolder
			plotModel.Name = tostring(index)
		end
		activePlotModels[player] = nil
	end
	occupiedPlots[player] = nil
end)

requestUpgrade.OnServerEvent:Connect(function(player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	local currentLevel = profile.Data.BaseLevel or 0
	if currentLevel >= MAX_LEVEL then return end

	local rebirths = profile.Data.Rebirths or 0
	local requiredRebirths = REBIRTH_REQUIREMENTS[currentLevel] or 0

	if rebirths < requiredRebirths then
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Need " .. requiredRebirths .. " Rebirths to unlock!", "Error") end
		return
	end

	local price = UPGRADE_PRICES[currentLevel]

	if PlayerController:DeductMoney(player, price) then
		local newLevel = PlayerController:IncrementBaseLevel(player)
		updatePlotVisuals(player, newLevel)

		-- [FIX] Refresh slot visuals so a newly unlocked floor shows the
		-- correct items (and clears stale ones) instead of leaving brainrots
		-- "stuck" in the slots.
		if SlotManager and SlotManager.RefreshAllSlots then
			SlotManager.RefreshAllSlots(player)
		end

		local notif = Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "New Floor Unlocked!", "Success") end
	else
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Not enough Money!", "Error") end
	end
end)

print("[PlotManager] Active (Floor Upgrade Logic)")

return PlotManager