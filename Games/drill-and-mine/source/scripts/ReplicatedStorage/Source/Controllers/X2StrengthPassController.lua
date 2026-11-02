--[[
	X2StrengthPassController -- drives the HUD X2DrillPanel, now the
	strength LADDER storefront (the x2 Strength gamepass is retired,
	2026-07-23): GameConfig.StrengthLadder is a chain of dev products
	where each tier doubles the permanent strength multiplier. The panel
	always sells the NEXT tier -- "x4 Strength" / "ONLY 9" -- and hides
	for good at the top tier (x1024). Clicking invokes the
	StrengthLadderRemote RemoteFunction; StrengthLadderServer picks the
	product for the player's current tier, prompts through PurchaseService
	(which drives the BuyTransition overlay) and mirrors the owned tier to
	the StrengthMultLevel attribute this panel watches.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local X2StrengthPassController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local LEVEL_ATTR = "StrengthMultLevel"

-- same convention as the chip controllers: the label plus any text
-- descendants (shadow twins like Title.Double) all carry the same string
local function setAllText(label, text)
	if not label then return end
	label.Text = text
	for _, descendant in ipairs(label:GetDescendants()) do
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
			descendant.Text = text
		end
	end
end

function X2StrengthPassController.Init()
	local ladder = GameConfig.StrengthLadder
	if not ladder or #ladder == 0 then return end

	local gui = playerGui:WaitForChild("GUI", 30)
	if not gui then return end
	local hud = gui:WaitForChild("HUD", 30)
	if not hud then return end
	local panel = hud:WaitForChild("X2DrillPanel", 10)
	if not panel then return end
	local button = panel:FindFirstChild("X2Drill")
	if not (button and button:IsA("GuiButton")) then return end
	local title = button:FindFirstChild("Title")
	local priceButton = panel:FindFirstChild("Only3")
	local priceTitle = priceButton and priceButton:FindFirstChild("Title")

	local function refresh()
		local level = tonumber(player:GetAttribute(LEVEL_ATTR)) or 0
		local nextEntry = ladder[level + 1]
		if not nextEntry then
			panel.Visible = false -- top tier owned: nothing left to sell
			return
		end
		setAllText(title, "x" .. nextEntry.Mult .. " Strength")
		-- U+E002 = the official Robux glyph baked into Roblox fonts (same
		-- trick as the rebirth Skip button price)
		setAllText(priceTitle, "ONLY " .. utf8.char(0xE002) .. nextEntry.Price)
		panel.Visible = true
	end

	local busy = false
	local function buy()
		if busy then return end
		local level = tonumber(player:GetAttribute(LEVEL_ATTR)) or 0
		if not ladder[level + 1] then return end
		local remote = ReplicatedStorage:FindFirstChild("StrengthLadderRemote")
		if not remote then return end
		busy = true
		task.spawn(function()
			pcall(function()
				remote:InvokeServer()
			end)
			busy = false
		end)
	end

	button.MouseButton1Click:Connect(buy)
	-- the "ONLY N" price strip is a button too; both halves buy
	if priceButton and priceButton:IsA("GuiButton") then
		priceButton.MouseButton1Click:Connect(buy)
	end

	player:GetAttributeChangedSignal(LEVEL_ATTR):Connect(refresh)
	refresh()
end

return X2StrengthPassController