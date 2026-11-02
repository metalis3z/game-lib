local BrainrotShopController = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Developer Product IDs
local BRAINROT_ITEMS = {
	HeadlessHorseman = { productId = 3611965515, name = "Headless Horseman" },
	Meowl = { productId = 3610327634, name = "Meowl" },
	SkibidiToilet = { productId = 3611965549, name = "Skibidi Toilet" },
	StrawberryElephant = { productId = 3611965467, name = "Strawberry Elephant" },
	UltraUltimateLuckyBlock = { productId = 3612055210, name = "Ultime Lucky Block" },
}

function BrainrotShopController.Start(_)
	local brainrotShopScreenGui = PlayerGui:WaitForChild("BrainrotShop")
	local frames = brainrotShopScreenGui:WaitForChild("Frames")
	local brainrotShopFrame = frames:WaitForChild("BrainrotShop")
	local closeButton = brainrotShopFrame.Top.Main:WaitForChild("Close")
	local scrollingFrame = brainrotShopFrame:WaitForChild("ScrollingFrame")

	local interfaceHandle = InterfaceController:Register("BrainrotShop", frames, "TopQuint")
	interfaceHandle:AttachCloseButton(closeButton)
	interfaceHandle:Close()

	for itemName, itemData in pairs(BRAINROT_ITEMS) do
		local itemFrame = scrollingFrame:FindFirstChild(itemName)

		if itemFrame then
			local buyButton = itemFrame:FindFirstChild("Buy")

			if buyButton and buyButton:IsA("GuiButton") then
				buyButton.MouseButton1Click:Connect(function()
					MarketplaceService:PromptProductPurchase(LocalPlayer, itemData.productId)
				end)
			end
		end
	end
end

return BrainrotShopController