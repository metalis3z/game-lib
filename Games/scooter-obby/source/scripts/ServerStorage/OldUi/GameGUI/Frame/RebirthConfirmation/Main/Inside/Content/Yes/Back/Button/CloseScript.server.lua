local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,2,0)
local debounce = false

script.Parent.Activated:Connect(function()
	if game.Players.LocalPlayer.leaderstats.Stage.Value >= 100 and not debounce then
		debounce = true
		ts:Create(script.Parent.Parent.Parent.Parent.Parent.Parent.Parent, ti, {Position = downPos}):Play()
		game:GetService("ReplicatedStorage").RemoteEvents.callForRebirth:FireServer()
		wait(5)
		debounce = false
	else
		script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.CashNotificationHandler.errorWrite:Fire("You need to complete the obby before you rebirth!")
	end
end)