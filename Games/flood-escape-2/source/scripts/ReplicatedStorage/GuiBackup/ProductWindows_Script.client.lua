local ProductWindows = workspace:WaitForChild("Lobby"):WaitForChild("ProductWindows")
local CurrencyProducts = ProductWindows:WaitForChild("CurrencyProducts"):WaitForChild("CurrencyUI"):WaitForChild("Content"):WaitForChild("Products")
local ProductsUI = ProductWindows:WaitForChild("Products"):WaitForChild("ProductUI"):WaitForChild("Content"):WaitForChild("Products")
local Local_Player = game.Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local IsLockedProducts = false
ProductWindows.Lock.LockUI.Content.MouseButton1Click:Connect(function()
	if IsLockedProducts then
		for index, part in ipairs(workspace.Lobby.ProductWindows:GetDescendants()) do
			if part:IsA("Frame") and part.Name == "LockedFrame" then
				part.Visible = false
			end
		end
		IsLockedProducts = false
	else
		for index, part in ipairs(workspace.Lobby.ProductWindows:GetDescendants()) do
			if part:IsA("Frame") and part.Name == "LockedFrame" then
				part.Visible = true
			end
		end
		IsLockedProducts = true
	end
end)

for _, v in next, CurrencyProducts:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			if not IsLockedProducts then
				MarketplaceService:PromptProductPurchase(Local_Player, v.ProductId.Value)
			end
		end)
	end
end

for _, v in next, ProductsUI:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			if not IsLockedProducts and v.IsGamepass.Value == true then
				MarketplaceService:PromptGamePassPurchase(Local_Player, v.ProductId.Value)
			end
		end)
	end
end