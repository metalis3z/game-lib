local Window = script.Parent.Window
local Remote = game.ReplicatedStorage.Remote
local Categories = script.Parent.Window.Content.Categories
local PassKey = game.ReplicatedStorage.Remote.ReqPassKey:InvokeServer()
local ContentPages = Window.Content
local data1 = nil

repeat
	data1 = Remote.ReqItemData:InvokeServer()
	if not data1 then
		wait()
	end
until data1


Remote.UpdPlayerData.OnClientEvent:connect(function(Data)
local PlayerItemData = data1
	PlayerItemData = Data
	script.Parent.Currencies.Coins.Amount.Text = PlayerItemData.coins
	script.Parent.Currencies.Gems.Amount.Text = PlayerItemData.gems
	script.Parent.Currencies.Visible = true
end)

Remote.UpdIngameStats.OnClientEvent:connect(function(gameinfo)
	Categories.BoostIntensity.AutoButtonColor = gameinfo.boostingEnabled
	Categories.BoostIntensity.BackgroundColor3 = gameinfo.boostingEnabled and Color3.fromRGB(155, 89, 182) or Color3.fromRGB(22, 31, 40)
	Categories.BoostIntensity.Desc.Text = gameinfo.boostingEnabled and "Boost " .. gameinfo.intBoostCurrentCost .. "\240\159\146\142" or "Boost \226\157\140"
end)

Categories.BoostIntensity.MouseButton1Click:Connect(function()
		if Categories.BoostIntensity.BackgroundColor3 == Color3.fromRGB(155, 89, 182) then
			Remote.BoostIntensity:FireServer()
		end
end)

ContentPages.CodeRedeem.Confirm.Activated:connect(function()
	Remote.ReqCode:FireServer(-PassKey, ContentPages.CodeRedeem.CodeBox.TextBox.Text)
end)

Categories.Codes.MouseButton1Click:Connect(function()
Window.Content.CodeRedeem.Visible = true
end)