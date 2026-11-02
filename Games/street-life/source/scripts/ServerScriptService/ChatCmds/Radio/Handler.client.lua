task.wait(1)

local Radio = script.Parent
local localPlayer = game.Players.LocalPlayer
local chatter = Radio.Main.Chatter
local mainUI = Radio.Main

local Cooldown = false

Radio.Min.MouseButton1Click:Connect(function()
	mainUI.Visible = not mainUI.Visible
	Radio.Min.Text = mainUI.Visible and "-" or "+"
end)

local chatterLines = {
	Line1 = chatter.Line1,
	Line2 = chatter.Line2,
	Line3 = chatter.Line3,
	Line4 = chatter.Line4,
	Line5 = chatter.Line5
}

game.ReplicatedStorage.Radio.send.OnClientEvent:Connect(function(message, check)
	if string.find(message.Line5, "**PANIC BUTTON**") and check == nil and check ~= '__*GET' then
		script.Distress:Play()
	end

	for i = 1, 5 do
		chatterLines["Line" .. i].Text = message["Line" .. i]
		if string.find(message["Line" .. i], '**PANIC BUTTON**') then
			chatterLines["Line" .. i].TextColor3 = Color3.fromRGB(200, 0, 0)
		else
			chatterLines["Line" .. i].TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end
end)

local isActive = false

local function toggleActivation()
	isActive = not isActive
	mainUI.Activate.BackgroundColor3 = isActive and Color3.new(0, 0.73, 0) or Color3.new(0.68, 0, 0)
	mainUI.Activate.Text = isActive and "ON" or "OFF"
end

mainUI.Activate.MouseButton1Click:Connect(toggleActivation)

local function sendMessage(message)
	task.spawn(function()
		if Cooldown then return end
		Cooldown = true
		game.ReplicatedStorage.Radio.send:FireServer(message)
		task.wait(1)
		Cooldown = false
	end)
end

mainUI.EA.MouseButton1Click:Connect(function()
	sendMessage("**PANIC BUTTON**")
end)

localPlayer.Chatted:Connect(function(chatMessage)
	if isActive then
		sendMessage(chatMessage)
	end
end)

mainUI.TextBox.FocusLost:Connect(function()
	if mainUI.TextBox.Text ~= '' and mainUI.TextBox.Text ~= ' ' then
		sendMessage(mainUI.TextBox.Text)
		mainUI.TextBox.Text = ''
	end
end)

mainUI.Send.MouseButton1Click:Connect(function()
	if mainUI.TextBox.Text ~= '' and mainUI.TextBox.Text ~= ' ' then
		sendMessage(mainUI.TextBox.Text)
		mainUI.TextBox.Text = ''
	end
end)

sendMessage("__*GET")