local shopFrame = script.Parent:WaitForChild("ShopBG")
local itemScroller = shopFrame.ItemScroller
local itemPreview = shopFrame.ItemPreview

shopFrame.Parent.Enabled = true
shopFrame.Visible = false
itemPreview.Visible = false


local LocalPlayer = game.Players.LocalPlayer
local Distance = 10

local itemsFolder = game.ReplicatedStorage:WaitForChild("Items")

for i, item in pairs(itemsFolder:GetChildren()) do
	
	
	local name = item.Name
	local price = item.ShopGuiInfo.Price.Value
	local desc = item.ShopGuiInfo.Description.Value
	
	local itemSelection = script.ItemSelection:Clone()
	
	itemSelection.ItemView.Image = item.TextureId
	itemSelection.Parent = itemScroller
	
	
	itemSelection.MouseButton1Click:Connect(function()
		shopFrame.ClickSound:Play()
		
		itemPreview.ItemName.Text = name
		itemPreview.ItemPrice.Text = price .. " Points"
		itemPreview.BuyButton.Text = "Buy"
		itemPreview.ItemDescription.Text = desc
		
		if itemPreview.ItemImage:FindFirstChild("Handle") then itemPreview.ItemImage.Handle:Destroy() end
		
		itemPreview.ItemImage.Image = item.TextureId
		
		itemPreview.Visible = true
	end)
end


itemPreview.BuyButton.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.OnItemBought:FireServer(itemsFolder[itemPreview.ItemName.Text])
	shopFrame.ClickSound2:Play()
end)

while wait() do
	if (LocalPlayer.Character.Torso.Position - workspace.Shop.Part.Position).magnitude < Distance then
		shopFrame.Visible = true
		itemPreview.BuyButton.Modal = true
	else
		shopFrame.Visible = false
		itemPreview.BuyButton.Modal = false
	end
end