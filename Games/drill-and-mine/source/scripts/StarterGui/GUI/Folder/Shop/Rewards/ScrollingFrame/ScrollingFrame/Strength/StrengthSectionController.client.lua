-- StrengthSectionController: wires the store's Strength section buy buttons
-- through PurchaseService ("BuyStrength_<key>" context, validated server-side),
-- keeps price labels in sync with GameConfig.StrengthShop, and bobs the big
-- +1T card's muscle icon up and down.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PromptPurchaseFunc = Remotes:WaitForChild("PurchaseService"):WaitForChild("PromptPurchase")

local section = script.Parent

local ROBUX_GLYPH = utf8.char(0xE002)

local function setText(label, text)
	label.Text = text
	for _, d in ipairs(label:GetDescendants()) do
		if d:IsA("TextLabel") then d.Text = text end
	end
end

local function wireOffer(card, key)
	local cfg = GameConfig.StrengthShop and GameConfig.StrengthShop[key]
	if not cfg then return end
	local buy = card:FindFirstChild("Buy")
	if not buy or not buy:IsA("TextButton") then return end
	local price = buy:FindFirstChild("Price")
	if price then setText(price, ROBUX_GLYPH .. tostring(cfg.PriceRobux)) end
	buy.MouseButton1Click:Connect(function()
		if not cfg.ProductId or cfg.ProductId == 0 then
			warn(string.format("[StrengthSectionController] %s has no ProductId set in GameConfig.StrengthShop", key))
			return
		end
		pcall(function()
			PromptPurchaseFunc:InvokeServer(cfg.ProductId, "BuyStrength_" .. key)
		end)
	end)
end

local big = section:WaitForChild("T1")
wireOffer(big, "T1")
local row = section:WaitForChild("Row")
for _, key in ipairs({ "B100", "B10", "B1" }) do
	wireOffer(row:WaitForChild(key), key)
end

-- smooth up/down bob on the big offer's muscle icon
local muscle = big:WaitForChild("Muscle")
local basePos = muscle.Position
local INFO = TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
TweenService:Create(muscle, INFO, {
	Position = UDim2.new(basePos.X.Scale, basePos.X.Offset, basePos.Y.Scale - 0.07, basePos.Y.Offset),
}):Play()
