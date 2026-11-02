script.parent.Equipped:Connect(function()
	local StunStickBarUI = script.Parent.StunStickBarUI:Clone()
	StunStickBarUI.Parent = game.Players.LocalPlayer.PlayerGui
	StunStickBarUI.DestroyScript.Disabled = false
	StunStickBarUI.Frame.Bar.LocalScript.Disabled = false
	StunStickBarUI.TransparencyScript.Disabled = false
	local NotUseableUI = script.Parent.NotUseableUI:Clone()
	NotUseableUI.Parent = game.Players.LocalPlayer.PlayerGui
	NotUseableUI.DestroyScript.Disabled = false
	NotUseableUI.LocalScript.Disabled = false
end)