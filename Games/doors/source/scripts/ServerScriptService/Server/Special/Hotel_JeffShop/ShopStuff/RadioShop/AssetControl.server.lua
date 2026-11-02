local ProximityPrompt = script.Parent.InteractPrompt
local clicked = false

ProximityPrompt.Triggered:Connect(function(player)
	if clicked == false then
		clicked = true
		game.ReplicatedStorage.EntityInfo.Caption:FireClient(player, 'There is no power button here.')
		wait(8)
		clicked = false
	end
end)