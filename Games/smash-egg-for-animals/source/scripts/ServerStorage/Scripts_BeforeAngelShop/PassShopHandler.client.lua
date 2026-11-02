-- Game pass shop: lists ShopConfig.Passes; Buy opens the Roblox purchase prompt.
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local ShopConfig = require(ReplicatedStorage:WaitForChild("ShopSystem"):WaitForChild("ShopConfig"))

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local list = main:WaitForChild("List")
local rowTemplate = script:WaitForChild("RowTemplate")
local openButton = player:WaitForChild("PlayerGui"):WaitForChild("left bottom"):WaitForChild("Holder"):WaitForChild("ShopButton")

local BUY_GRADIENT = ColorSequence.new(Color3.fromRGB(150, 226, 96), Color3.fromRGB(66, 170, 70))
local OWNED_GRADIENT = ColorSequence.new(Color3.fromRGB(130, 214, 255), Color3.fromRGB(70, 140, 236))
local SOON_GRADIENT = ColorSequence.new(Color3.fromRGB(206, 206, 216), Color3.fromRGB(150, 150, 166))

for order, pass in ShopConfig.Passes do
	local row = rowTemplate:Clone()
	row.Name = pass.Key
	row.LayoutOrder = order
	row.PassName.Text = pass.Name
	row.Description.Text = pass.Description
	local icon = script.Icons:FindFirstChild(pass.Key)
	row.Badge.Text.Visible = icon == nil
	row.Badge.Text.Text = pass.Badge
	if icon then icon:Clone().Parent = row.Badge end

	local function refresh()
		local owned = ShopConfig.HasPass(player, pass.Key)
		row.Buy.Text = owned and "OWNED" or pass.Id > 0 and ("R$ " .. pass.Price) or ("Soon · R$ " .. pass.Price)
		row.Buy.Shade.Color = owned and OWNED_GRADIENT or pass.Id > 0 and BUY_GRADIENT or SOON_GRADIENT
	end
	player:GetAttributeChangedSignal("Pass_" .. pass.Key):Connect(refresh)
	refresh()

	row.Buy.Activated:Connect(function()
		if pass.Id > 0 and not ShopConfig.HasPass(player, pass.Key) then
			MarketplaceService:PromptGamePassPurchase(player, pass.Id)
		end
	end)
	row.Parent = list
end

openButton.Activated:Connect(function() main.Visible = not main.Visible end)
main:WaitForChild("Header"):WaitForChild("Close").Activated:Connect(function() main.Visible = false end)

-- VIP tag in chat
TextChatService.OnIncomingMessage = function(message)
	local source = message.TextSource
	local sender = source and Players:GetPlayerByUserId(source.UserId)
	if sender and ShopConfig.HasPass(sender, "VIP") then
		local properties = Instance.new("TextChatMessageProperties")
		properties.PrefixText = "<font color='#FFC83C'>[VIP]</font> " .. message.PrefixText
		return properties
	end
	return nil
end
