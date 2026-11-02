-- Client source of truth for the player's cash-boost multiplier.
-- - Owns the HUD chip at PlayerGui.GUI.HUD.RightDownSide.CashBoost.Button.Boost.
-- - Caches the current total % from Remotes.CashBoostService.BoostUpdate so other client
--   modules (PodiumController income display, etc.) can call GetMultiplier() / GetTotalPercent().
-- - Fires BoostChanged BindableEvent.Event(total, breakdown) on every update so consumers
--   can refresh visible labels without polling.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CashBoostHudController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ServiceRemotes = Remotes:WaitForChild("CashBoostService")
local BoostUpdateEvent = ServiceRemotes:WaitForChild("BoostUpdate")
local RequestBoostFunc = ServiceRemotes:WaitForChild("RequestBoost")

local cashBoostFrame = nil
local boostLabel = nil

local currentTotalPercent = 0
local currentBreakdown = {}

local boostChangedBindable = Instance.new("BindableEvent")
CashBoostHudController.BoostChanged = boostChangedBindable.Event

function CashBoostHudController.GetTotalPercent()
	return currentTotalPercent
end

function CashBoostHudController.GetMultiplier()
	return 1 + currentTotalPercent / 100
end

function CashBoostHudController.GetBreakdown()
	return currentBreakdown
end

local function setBoostText(pct)
	if not boostLabel then return end
	local text = "+" .. tostring(math.floor(pct or 0)) .. "%"
	boostLabel.Text = text
	for _, descendant in ipairs(boostLabel:GetDescendants()) do
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
			descendant.Text = text
		end
	end
end

local function applyTotal(total, breakdown)
	local pct = tonumber(total) or 0
	local changed = pct ~= currentTotalPercent
	currentTotalPercent = pct
	currentBreakdown = breakdown or {}

	setBoostText(pct)
	if cashBoostFrame then
		-- Hide chip when no boost is active so the HUD stays clean.
		cashBoostFrame.Visible = pct > 0
	end

	if changed then
		boostChangedBindable:Fire(currentTotalPercent, currentBreakdown)
	end
end

local function findHudCashBoost()
	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return nil end
	local hud = gui:WaitForChild("HUD", 10)
	if not hud then return nil end
	local rds = hud:WaitForChild("RightDownSide", 10)
	if not rds then return nil end
	return rds:WaitForChild("CashBoost", 10)
end

function CashBoostHudController.Init()
	cashBoostFrame = findHudCashBoost()
	local button = cashBoostFrame and cashBoostFrame:FindFirstChild("Button")
	if button then
		boostLabel = button:FindFirstChild("Boost")
	end
	if cashBoostFrame and not boostLabel then
		warn("[CashBoostHudController] Boost label missing under HUD.RightDownSide.CashBoost.Button")
	end

	-- Hide until we get the first server payload so a stale authored value never lingers.
	if cashBoostFrame then
		cashBoostFrame.Visible = false
	end

	BoostUpdateEvent.OnClientEvent:Connect(function(total, breakdown)
		applyTotal(total, breakdown)
	end)

	task.spawn(function()
		for _ = 1, 20 do
			local ok, info = pcall(function()
				return RequestBoostFunc:InvokeServer()
			end)
			if ok and info then
				applyTotal(info.Total, info.Sources)
				return
			end
			task.wait(0.5)
		end
	end)
end

return CashBoostHudController
