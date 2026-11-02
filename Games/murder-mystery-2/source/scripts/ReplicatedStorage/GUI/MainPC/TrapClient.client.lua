local StartSize = UDim2.new(1, 0,1, 0)
local EndSize = UDim2.new(0, 0, 1, 0)
local TrapBar = script.Parent.Game.TrapBar

game.ReplicatedStorage.TrapSystem.TrapTouch.OnClientEvent:Connect(function(TrapSeconds)
	TrapSeconds = tonumber(TrapSeconds)
	
	TrapBar.Visible = true
	
	local tween = game:GetService("TweenService"):Create(TrapBar.Progress.Bar, TweenInfo.new(TrapSeconds, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = EndSize})
	tween:Play()
	tween.Completed:connect(function()
		TrapBar.Visible = false
		TrapBar.Progress.Bar.Size = StartSize
	end)
end)

game.ReplicatedStorage.TrapSystem.PlaceTrap.OnClientEvent:Connect(function(trap)
	trap.TrapVisual.Transparency = 0.5
	trap.TrapVisual.TrapBillboard.Enabled = true
end)