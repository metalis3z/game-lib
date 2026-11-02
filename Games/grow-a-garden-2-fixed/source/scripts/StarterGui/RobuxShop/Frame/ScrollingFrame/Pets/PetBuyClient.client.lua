--credit to quartz games studio
--[[
	PetBuyClient (MODDED)
	Conecta los pets de RobuxShop > Pets a su DevProduct.
	Raccoon · IceSerpent · Unicorn · Dragonfly (pet real: GoldenDragonfly).
	IDs en SharedModules.ProductIds. El server (DevProductService) entrega la
	pet con GameServerAPI.AddPet en ProcessReceipt.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local ProductIds = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("ProductIds"))
local LocalPlayer = Players.LocalPlayer

local Frame = script.Parent:WaitForChild("Frame")

local PETS = {
	{ frame = "Raccoon",    id = ProductIds.Products.PetRaccoon },
	{ frame = "IceSerpent", id = ProductIds.Products.PetIceSerpent },
	{ frame = "Unicorn",    id = ProductIds.Products.PetUnicorn },
	{ frame = "Dragonfly",  id = ProductIds.Products.PetDragonfly },
}

local function setText(label, text)
	if not label then return end
	label.Text = text
	local inner = label:FindFirstChild("TextLabel")
	if inner then inner.Text = text end
end

local function setPrice(button, productId)
	local price = button:FindFirstChild("Price")
	if not price then return end
	local text = "..."
	if type(productId) == "number" and productId > 0 then
		local ok, info = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, productId, Enum.InfoType.Product)
		if ok and info and info.PriceInRobux then
			text = "\238\128\130" .. tostring(info.PriceInRobux)
		end
	end
	setText(price, text)
end

for _, data in ipairs(PETS) do
	local petFrame = Frame:FindFirstChild(data.frame)
	if petFrame then
		local buy = petFrame:FindFirstChild("BuyButton")
		local gift = petFrame:FindFirstChild("GiftButton")

		if buy then
			setPrice(buy, data.id)
			buy.Activated:Connect(function()
				if type(data.id) ~= "number" or data.id <= 0 then return end
				require(game:GetService("ReplicatedStorage").SharedModules.FakeBuy).Product(data.id)
			end)
		end
		if gift then
			gift.Activated:Connect(function()
				if type(data.id) ~= "number" or data.id <= 0 then return end
				require(game:GetService("ReplicatedStorage").SharedModules.FakeBuy).Product(data.id)
			end)
		end
	end
end
