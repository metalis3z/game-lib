--!strict
-- LOCATION: StarterPlayerScripts/UpgradeVisuals

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Modules
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

-- Config
local UPGRADES_FOLDER = Workspace:WaitForChild("UpgradeWins")

-- Colors
local COLOR_LOCKED      = Color3.new(0, 0, 0)          -- Black
local COLOR_CAN_BUY     = Color3.new(0, 1, 0)          -- Green
local COLOR_TOO_EXPENSIVE = Color3.new(1, 0, 0)        -- Red
local COLOR_OWNED       = Color3.fromRGB(0, 170, 255)  -- Blue

-- Order list
local UPGRADE_ORDER = {
	"Button1", "Button2", "Button3", "Button4",  "Button5",  "Button6",
	"Button7", "Button8", "Button9", "Button10", "Button11", "Button12"
}

local player = Players.LocalPlayer

-- Helper: returns a set of owned upgrade IDs
local function getOwnedUpgrades()
	local owned = {}
	local upgradesFolder = player:FindFirstChild("Upgrades")
	if upgradesFolder then
		for _, child in ipairs(upgradesFolder:GetChildren()) do
			owned[child.Name] = true
		end
	end
	return owned
end

local function getWins()
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local wins = leaderstats:FindFirstChild("Wins")
		if wins then return wins.Value end
	end
	return 0
end

local function updateVisuals()
	local ownedData    = getOwnedUpgrades()
	local currentWins  = getWins()

	for index, upgradeId in ipairs(UPGRADE_ORDER) do
		local model = UPGRADES_FOLDER:FindFirstChild(upgradeId)
		if not model then continue end

		local touchPart = model:FindFirstChild("Touch") :: BasePart
		local gui = touchPart and touchPart:FindFirstChild("GUI") :: BillboardGui
		if not touchPart or not gui then continue end

		local addonLabel    = gui:FindFirstChild("Addon")   :: TextLabel
		local winCostLabel  = gui:FindFirstChild("WinCost") :: TextLabel

		local cost  = model:GetAttribute("WinCost")   or 0
		local bonus = model:GetAttribute("SpeedBonus") or 0

		-- Unlocked if it is the first button OR the previous one is owned
		local previousId = UPGRADE_ORDER[index - 1]
		local isUnlocked = (index == 1) or (previousId and ownedData[previousId])
		local isOwned    = ownedData[upgradeId]

		if isOwned then
			-- [ STATE: OWNED ]
			touchPart.Color = COLOR_OWNED
			gui.Enabled = true
			if winCostLabel then winCostLabel.Text = "OWNED" end
			if addonLabel   then addonLabel.Text   = "+" .. tostring(bonus) .. "/Step" end

		elseif not isUnlocked then
			-- [ STATE: LOCKED ]
			touchPart.Color = COLOR_LOCKED
			gui.Enabled = false

		else
			-- [ STATE: UNLOCKED — can buy or too expensive ]
			gui.Enabled = true
			if addonLabel  then addonLabel.Text  = "+" .. tostring(bonus) .. "/Step" end
			if winCostLabel then winCostLabel.Text = NumberFormatter.Format(cost) .. " Wins Required" end

			if currentWins >= cost then
				touchPart.Color = COLOR_CAN_BUY
			else
				touchPart.Color = COLOR_TOO_EXPENSIVE
			end
		end
	end
end

RunService.Heartbeat:Connect(updateVisuals)