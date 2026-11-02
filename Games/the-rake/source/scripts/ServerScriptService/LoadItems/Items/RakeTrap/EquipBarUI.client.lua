script.parent.Equipped:Connect(function()
	local TrapBarUI = script.Parent.TrapBarUI:Clone()
	TrapBarUI.Parent = game.Players.LocalPlayer.PlayerGui
	TrapBarUI.DestroyScript.Disabled = false
	TrapBarUI.Frame.Bar.LocalScript.Disabled = false
end)