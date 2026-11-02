local Exit = script.Parent.InUse.Value
local Debounce = script.Parent.Parent.Debounce.Value

script.Parent.Interact.OnServerEvent:Connect(function(player)
	if not Debounce then
		Debounce = true
		script.Parent.InUse.Value = false
		player.Character.HumanoidRootPart.CFrame = script.Parent.Parent.TeleportPartExit.CFrame
		wait(1)
		Debounce = false
	end
end)