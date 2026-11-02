-- RightSideOffersController: wires the HUD side strength chips
-- (HUD.RightSide.Product100M/Product1B/Product10B) straight to their
-- GameConfig.StrengthShop dev products ("BuyStrength_<key>" context,
-- validated + granted server-side by PurchaseService), instead of the old
-- behavior of just opening the shop. Also keeps each chip's Title/Price
-- labels in sync with the config.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local RightSideOffersController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")

-- chip frame name -> GameConfig.StrengthShop key (frame names predate the
-- final amounts, so they're off by 10x from what the offer actually grants)
local CHIP_TO_OFFER = {
	Product100M = "B1",   -- +1.00B strength
	Product1B   = "B10",  -- +10.0B strength
	Product10B  = "B100", -- +100B  strength
}

local pendingByKey = {}

local function setText(label, text)
	if not label then return end
	label.Text = text
	for _, d in ipairs(label:GetDescendants()) do
		if d:IsA("TextLabel") then d.Text = text end
	end
end

local function promptPurchase(productId, context)
	if pendingByKey[context] then
		return
	end
	pendingByKey[context] = true
	task.spawn(function()
		pcall(function()
			PromptPurchaseFunc:InvokeServer(productId, context)
		end)
		pendingByKey[context] = nil
	end)
end

local function wireChip(chip, key)
	local cfg = GameConfig.StrengthShop and GameConfig.StrengthShop[key]
	if not cfg then return end
	local buyButton = chip:FindFirstChild("BuyButton")
	if not buyButton or not buyButton:IsA("GuiButton") then return end

	-- the legacy chips opened the shop through FrameAnimator's Open
	-- attribute; clear it so a stale copy can't rebind that behavior
	buyButton:SetAttribute("Open", nil)

	setText(buyButton:FindFirstChild("Title"), cfg.Label)
	setText(buyButton:FindFirstChild("Price"), utf8.char(0xE002) .. tostring(cfg.PriceRobux))

	buyButton.MouseButton1Click:Connect(function()
		if not cfg.ProductId or cfg.ProductId == 0 then
			warn(string.format("[RightSideOffersController] %s has no ProductId set in GameConfig.StrengthShop", key))
			return
		end
		promptPurchase(cfg.ProductId, "BuyStrength_" .. key)
	end)
end

function RightSideOffersController.Init()
	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return end
	local hud = gui:WaitForChild("HUD", 10)
	if not hud then return end
	local rightSide = hud:WaitForChild("RightSide", 10)
	if not rightSide then return end

	for chipName, key in pairs(CHIP_TO_OFFER) do
		local chip = rightSide:WaitForChild(chipName, 10)
		if chip then
			wireChip(chip, key)
		end
	end
end

return RightSideOffersController
