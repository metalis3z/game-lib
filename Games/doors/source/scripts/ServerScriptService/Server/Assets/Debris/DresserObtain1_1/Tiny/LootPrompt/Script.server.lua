local clicked = false

script.Parent.Triggered:Connect(function(player)
	if clicked == false then
		clicked = true
		script.Parent.Parent.Collect:Play()
		player.Stats.Gold.Value += script.Parent.Parent:GetAttribute("GoldValue")
		script.Parent.Parent.Hitbox:Destroy()
		script.Parent.Parent.LootPrompt:Destroy()
	end
end)
