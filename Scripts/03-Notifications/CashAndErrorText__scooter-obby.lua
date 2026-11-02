-- Reference copy for study. Game: Scooter Obby (scooter-obby)
-- Original: ServerStorage/OldUi/GameGUI/Frame/CashNotificationHandler.client.luau  (client, 69 lines)
-- Categories: notifications 16.0
-- What it does: Floating "+N coins!" / "+N skips!" text with random drift and rotation, plus red error text from client (BindableEvent) or server (RemoteEvent).

local rs = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")
local ti = TweenInfo.new(4)
local ti2= TweenInfo.new(12)
local ti3= TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenPos = UDim2.new(0.15, 0, .8, 0)
local tweenPos2 = UDim2.new(0.15, 0, .7, 0)

rs.RemoteEvents.cashNotification.OnClientEvent:Connect(function(value)
	local label = script.Parent.CashRecievedCoins:Clone()
	label.Parent = script.Parent
	label.Visible = true
	label.Text = "+" .. value .. " coins!"
	label.Name = "CoinNotificationText"
	ts:Create(label, ti3, {Position = UDim2.new(math.random(150,200) / 1000, 0, math.random(575,625) / 1000, 0)}):Play()
	ts:Create(label, ti3, {Rotation = math.random(0,50) - 25}):Play()
	ts:Create(label, ti3, {TextTransparency = 1}):Play()
	ts:Create(label, ti3, {TextStrokeTransparency = 1}):Play()
	script.Sound:Play()
	game:GetService("Debris"):AddItem(label, 4)
end)

rs.RemoteEvents.skipNotification.OnClientEvent:Connect(function(value)
	local label = script.Parent.CashRecievedSkips:Clone()
	label.Parent = script.Parent
	label.Visible = true
	label.Text = "+" .. value .. " skips!"
	label.Name = "SkipNotificationText"
	ts:Create(label, ti3, {Position = UDim2.new(math.random(150,200) / 1000, 0, math.random(500,560) / 1000, 0)}):Play()
	ts:Create(label, ti3, {Rotation = math.random(0,50) - 25}):Play()
	ts:Create(label, ti3, {TextTransparency = 1}):Play()
	ts:Create(label, ti3, {TextStrokeTransparency = 1}):Play()
	script.Sound:Play()
	game:GetService("Debris"):AddItem(label, 4)
end)

script.errorWrite.Event:Connect(function(errorMsg, color)
	local label = script.Parent.CashRecieved:Clone()
	label.TextColor3 = Color3.new(1,0,0)
	if color ~= nil then
		label.TextColor3 = color
	end
	label.Parent = script.Parent
	label.Text = errorMsg
	ts:Create(label, ti, {Position = tweenPos}):Play()
	ts:Create(label, ti, {TextTransparency = 1}):Play()
	ts:Create(label, ti, {TextStrokeTransparency = 1}):Play()
	script.Sound:Play()
	game:GetService("Debris"):AddItem(label, 4)
end)

script.serverErrorWrite.OnClientEvent:Connect(function(errorMsg, color, closeShop)
	if closeShop ~= nil and closeShop then
		script.Parent.ShopFrame.Position = UDim2.new(0.5,0,2,0)
		script.Parent.ShopFrame:SetAttribute("Up", false)
	end
	local label = script.Parent.CashRecieved:Clone()
	label.TextColor3 = Color3.new(1,0,0)
	if color ~= nil then
		label.TextColor3 = color
	end
	label.Parent = script.Parent
	label.Text = errorMsg
	ts:Create(label, ti2, {Position = tweenPos2}):Play()
	ts:Create(label, ti2, {TextTransparency = 1}):Play()
	ts:Create(label, ti2, {TextStrokeTransparency = 1}):Play()
	script.Sound:Play()
	game:GetService("Debris"):AddItem(label, 4)
end)