-- Owns the HUD chip at PlayerGui.GUI.HUD.RightDownSide.RobloxPlus.
-- When the player has an active Roblox Plus subscription: hides Locked + IconBlack
-- overlays and shows the +N% boost. When inactive: shows Locked + IconBlack and
-- clicking the button fires PromptPurchase so the server prompts the subscription.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local RobloxPlusController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ServiceRemotes = Remotes:WaitForChild("RobloxPlusService")
local StatusUpdateEvent = ServiceRemotes:WaitForChild("StatusUpdate")
local GetStatusFunc = ServiceRemotes:WaitForChild("GetStatus")
local PromptPurchaseEvent = ServiceRemotes:WaitForChild("PromptPurchase")

local frame = nil
local button = nil
local boostLabel = nil
local lockedImage = nil
local iconBlack = nil

local function getBoostPercent()
	local cfg = GameConfig.RobloxPlus
	return (cfg and cfg.BoostPercent) or 10
end

local function setLabelText(text)
	if not boostLabel then
		return
	end
	boostLabel.Text = text
	for _, descendant in ipairs(boostLabel:GetDescendants()) do
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
			descendant.Text = text
		end
	end
end

local function applyStatus(isActive)
	if lockedImage then
		lockedImage.Visible = not isActive
	end
	if iconBlack then
		iconBlack.Visible = not isActive
	end
	setLabelText("+" .. tostring(math.floor(getBoostPercent())) .. "%")
end

local function findHudRobloxPlus()
	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return nil end
	local hud = gui:WaitForChild("HUD", 10)
	if not hud then return nil end
	local rds = hud:WaitForChild("RightDownSide", 10)
	if not rds then return nil end
	return rds:WaitForChild("RobloxPlus", 10)
end

function RobloxPlusController.Init()
	frame = findHudRobloxPlus()
	if not frame then
		return
	end
	button = frame:FindFirstChild("Button")
	if not button then
		warn("[RobloxPlusController] Button missing under HUD.RightDownSide.RobloxPlus")
		return
	end
	boostLabel = button:FindFirstChild("Boost")
	lockedImage = button:FindFirstChild("Locked")
	iconBlack = button:FindFirstChild("IconBlack")

	frame.Visible = true
	applyStatus(false)

	StatusUpdateEvent.OnClientEvent:Connect(function(isActive)
		applyStatus(isActive == true)
	end)

	if button:IsA("GuiButton") then
		button.MouseButton1Click:Connect(function()
			PromptPurchaseEvent:FireServer()
		end)
	end

	task.spawn(function()
		for _ = 1, 20 do
			local ok, isActive = pcall(function()
				return GetStatusFunc:InvokeServer()
			end)
			if ok then
				applyStatus(isActive == true)
				return
			end
			task.wait(0.5)
		end
	end)
end

return RobloxPlusController
