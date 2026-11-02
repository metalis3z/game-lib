local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local DoorMessage = ReplicatedStorage:FindFirstChild("DoorMessage")
local MutatorsFolder = ReplicatedStorage.Mutators
local MutatorEvents = ReplicatedStorage.MutatorEvents
local ScrollingFrame = script.Parent.ScrollingFrame.mutators
local Button = script.Parent.OpenButton
local OpenPosition = UDim2.new(0.012, 229,0.984, 13)
local ClosedPosition = UDim2.new(0, -10,0.984, 13)
debounce = false
Opened = false

local mutatorEvent = ReplicatedStorage.MutatorEvent

Button.MouseButton1Click:Connect(function()
	if Opened == false then
		Opened = true
		script.Parent:TweenPosition(OpenPosition)
	else
		Opened = false
		script.Parent:TweenPosition(ClosedPosition)
	end
end)

for _,mutatorBtn in pairs(script.Parent.ScrollingFrame:GetChildren()) do
	if not mutatorBtn:IsA("TextButton") then continue end
	mutatorBtn.MouseButton1Click:Connect(function()
		if Player.leaderstats.Cash.Value < tonumber(mutatorBtn.Price.Text) then return end
		mutatorEvent:FireServer({Name = mutatorBtn.Name, Price = tonumber(mutatorBtn.Price.Text)})
	end)
end

mutatorEvent.OnClientEvent:Connect(function(msg)
	if debounce then return end
	debounce = true
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = msg
	})
	wait()
	debounce = false
end)

ScrollingFrame.HighSpeed.MouseButton1Click:Connect(function()
	if Player.leaderstats.Cash.Value >= 100 then
		MutatorEvents.HighSpeed:FireServer(Player)
	end
end)

ScrollingFrame.LowGravity.MouseButton1Click:Connect(function()
	if Player.leaderstats.Cash.Value >= 100 then
		MutatorEvents.LowGravity:FireServer(Player)
	end
end)

ScrollingFrame.Invincibility.MouseButton1Click:Connect(function()
	if Player.leaderstats.Cash.Value >= 500 then
		MutatorEvents.Invincibility:FireServer(Player)
	end
end)

ScrollingFrame.Negative.MouseButton1Click:Connect(function()
	if Player.leaderstats.Cash.Value >= 150 then
		MutatorEvents.Negative:FireServer(Player)
	end
end)

ScrollingFrame.Fog.MouseButton1Click:Connect(function()
	if Player.leaderstats.Cash.Value >= 150 then
		MutatorEvents.Fog:FireServer(Player)
	end
end)

ScrollingFrame.ExtraTime.MouseButton1Click:Connect(function()
	if Player.leaderstats.Cash.Value >= 50 then
		MutatorEvents.ExtraTime:FireServer(Player)
		Player.leaderstats.Cash.Value = Player.leaderstats.Cash.Value + 50
	end
end)

MutatorEvents.HighSpeed.OnClientEvent:Connect(function(Player)
	if debounce == false then
		debounce = true
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = Player.Name.." bought High Speed!"
		})
	debounce = false
	end
end)

MutatorEvents.Invincibility.OnClientEvent:Connect(function(Player)
	if debounce == false then
		debounce = true
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = Player.Name.." bought Invincibility!"
		})
		debounce = false
	end
end)

MutatorEvents.LowGravity.OnClientEvent:Connect(function(Player)
	if debounce == false then
		debounce = true
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = Player.Name.." bought Low Gravity!"
		})
		debounce = false
	end
end)

MutatorEvents.Negative.OnClientEvent:Connect(function(Player)
	if debounce == false then
		debounce = true
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = Player.Name.." bought Negative!"
	})
		debounce = false
	end
end)

MutatorEvents.Fog.OnClientEvent:Connect(function(Player)
	if debounce == false then
		debounce = true
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = Player.Name.." bought Fog!"
		})
	debounce = false
	end
end)

MutatorEvents.ExtraTime.OnClientEvent:Connect(function(Player)
	if debounce == false then
		debounce = true
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = Player.Name.." bought Extra Time!"
		})
		debounce = false
	end
end)