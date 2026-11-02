--!strict
-- LOCATION: ServerScriptService/Controllers/UpgradeController

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local PlayerController -- Loaded in Init

local UPGRADES_FOLDER = Workspace:WaitForChild("UpgradeWins")
local DEBOUNCE_TIME = 1

local touchDebounces = {}
local UpgradeController = {}

-- [ PRIVATE LOGIC ] ----------------------------------------------------------

local function onButtonTouched(hitPart: BasePart, buttonModel: Model)
	local character = hitPart.Parent
	if not character then return end
	local player = Players:GetPlayerFromCharacter(character)
	if not player then return end

	-- Debounce check
	local now = tick()
	if touchDebounces[player] and (now - touchDebounces[player] < DEBOUNCE_TIME) then
		return
	end

	-- Use the model name as the upgrade ID ("Button1", "Button2", etc.)
	local upgradeId = buttonModel.Name
	local cost  = buttonModel:GetAttribute("WinCost")
	local bonus = buttonModel:GetAttribute("SpeedBonus")

	if not cost or not bonus then
		warn("[UpgradeController] Missing Attributes (WinCost/SpeedBonus) on " .. buttonModel.Name)
		return
	end

	-- Set debounce
	touchDebounces[player] = now

	-- Process purchase
	if PlayerController then
		PlayerController:PurchaseUpgrade(player, upgradeId, cost, bonus)
	end
end

-- [ PUBLIC API ] -------------------------------------------------------------

function UpgradeController:Init(controllers)
	PlayerController = controllers.PlayerController
end

function UpgradeController:Start()
	for _, child in ipairs(UPGRADES_FOLDER:GetChildren()) do
		if child:IsA("Model") then
			local touchPart = child:FindFirstChild("Touch") :: BasePart
			if touchPart then
				touchPart.Touched:Connect(function(hit)
					onButtonTouched(hit, child)
				end)
			else
				warn("[UpgradeController] Missing 'Touch' part in " .. child.Name)
			end
		end
	end

	-- Clean up debounce table when players leave
	Players.PlayerRemoving:Connect(function(player)
		touchDebounces[player] = nil
	end)
end

return UpgradeController