local TweenService = game:GetService('TweenService')

local plr = game.Players.LocalPlayer
local plrGui = plr.PlayerGui
local shop = plrGui:WaitForChild("GUI").Frames.Shop
local shopHolder = shop.ShopHolder.ShopScroll
local replicatedStorage = game:GetService("ReplicatedStorage")
local ids = replicatedStorage.ID
local gamepasses = ids.Gamepasses
local mps = game:GetService("MarketplaceService")
local quickFrame = shop.Frame

local gamepassesPos = Vector2.new(0,0)
local dicePos = Vector2.new(0, 465.83)

local itemsEnabled = false

for _, frame in pairs(shopHolder.Gamepasses:GetChildren()) do
	if frame:IsA("ImageLabel") then
		local button = frame.Purchase
		button.MouseButton1Down:Connect(function()
			mps:PromptGamePassPurchase(plr, ids.Gamepasses[frame.Name].Value)	
				--mps:PromptProductPurchase(plr, ids.Products[button.Parent.Item.Value])
		end)
	end
end

for _, frame in pairs(shopHolder.Dice:GetChildren()) do
	if frame:IsA("ImageLabel") then
		local button = frame.Purchase
		button.MouseButton1Down:Connect(function()
			mps:PromptProductPurchase(plr, ids.Products[frame.Name].Value)
		end)
	end
end

quickFrame.Boosts.MouseButton1Down:Connect(function()
	TweenService:Create(shopHolder, TweenInfo.new(.25), {CanvasPosition = dicePos}):Play()
end)

quickFrame.Gamepasses.MouseButton1Down:Connect(function()
	TweenService:Create(shopHolder, TweenInfo.new(.25), {CanvasPosition = gamepassesPos}):Play()
end)