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

MutatorEvents.HighSpeed.OnClientEvent:Connect(function(Player)
	if debounce == false then
		debounce = true
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = Player.Name.." bought High Speed!"
		})
		debounce = false
	end
end)