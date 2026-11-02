local InUse = script.Parent.Parent.InteractiveBoxInside.InUse.Value
local Debounce = script.Parent.Parent.Debounce.Value

script.Parent.Interact.OnServerEvent:Connect(function(player)
	if InUse then return end
	if not Debounce then
		Debounce = true
		InUse = true
		player.Character.HumanoidRootPart.CFrame = script.Parent.Parent.TeleportPart.CFrame
		wait(1)
		Debounce = false
	end
end)