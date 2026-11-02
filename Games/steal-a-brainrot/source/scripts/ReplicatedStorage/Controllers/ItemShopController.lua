local ItemShopController = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local Net = require(ReplicatedStorage.Packages.Net)
local PurchaseRemote = Net:RemoteEvent("ShopService/Purchase")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Product IDs
local ADMIN_PANEL_PRODUCT_ID = 3612068332
local WITCH_BROOM_PRODUCT_ID = 3612068469

function ItemShopController.Start(_)
	local itemShopGui = PlayerGui:WaitForChild("ItemShopGui", 30)
	if not itemShopGui then return end

	local frames = itemShopGui:WaitForChild("Frames")
	local itemShop = frames:WaitForChild("ItemShop")
	local closeButton = itemShop.Top.Main:WaitForChild("Close")
	local scrollingFrame = itemShop:WaitForChild("ScrollingFrame")

	local interfaceHandle = InterfaceController:Register("ItemShop", frames, "TopQuint")
	interfaceHandle:AttachCloseButton(closeButton)
	interfaceHandle:Close()

	-- AdminPanel Buy (paid)
	local adminPanel = scrollingFrame:FindFirstChild("AdminPanel")
	if adminPanel then
		local buyBtn = adminPanel:FindFirstChild("Buy")
		if buyBtn and buyBtn:IsA("GuiButton") then
			buyBtn.MouseButton1Click:Connect(function()
				PurchaseRemote:FireServer(ADMIN_PANEL_PRODUCT_ID, nil)
			end)
		end
	end

	-- WitchBroom Buy (paid)
	local witchBroom = scrollingFrame:FindFirstChild("WitchBroom")
	if witchBroom then
		local buyBtn = witchBroom:FindFirstChild("Buy")
		if buyBtn and buyBtn:IsA("GuiButton") then
			buyBtn.MouseButton1Click:Connect(function()
				PurchaseRemote:FireServer(WITCH_BROOM_PRODUCT_ID, nil)
			end)
		end
	end

	-- FlyingCarpet Buy (free)
	local flyingCarpet = scrollingFrame:FindFirstChild("FlyingCarpet")
	if flyingCarpet then
		local buyBtn = flyingCarpet:FindFirstChild("Buy")
		if buyBtn and buyBtn:IsA("GuiButton") then
			buyBtn.MouseButton1Click:Connect(function()
				local freeItemRemote = ReplicatedStorage:FindFirstChild("ItemShopFreeItem")
				if freeItemRemote then
					freeItemRemote:FireServer("Flying Carpet")
				end
			end)
		end
	end
end

return ItemShopController