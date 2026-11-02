local button = script.Parent
local giftFrame = button:FindFirstAncestor("GiftrewardFrame")

button.MouseButton1Click:Connect(function()
	if giftFrame then
		giftFrame.Visible = false
	end
end)
