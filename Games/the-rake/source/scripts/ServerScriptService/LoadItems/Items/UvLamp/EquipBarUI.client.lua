script.parent.Equipped:Connect(function()
	local UvBarUI = script.Parent.UvBarUI:Clone()
	UvBarUI.Parent = game.Players.LocalPlayer.PlayerGui
	UvBarUI.DestroyScript.Disabled = false
	UvBarUI.Frame.LocalScript.Disabled = false
	UvBarUI.ColorScript.Disabled = false
	UvBarUI.TransparencyScript.Disabled = false
	local NotUseableUI = script.Parent.NotUseableUI:Clone()
	NotUseableUI.Parent = game.Players.LocalPlayer.PlayerGui
	NotUseableUI.DestroyScript.Disabled = false
	NotUseableUI.LocalScript.Disabled = false
end)