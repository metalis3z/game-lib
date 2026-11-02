local InUse = script.Parent.InUse
local Debounce = script.Parent.Parent.Debounce
local Occupied = script.Parent.Parent.TubeOccupied

local CollectionService = game:GetService("CollectionService")
CollectionService:AddTag(script.Parent, "InteractiveBox")

Debounce.Changed:Connect(function()
	InUse.Value = Debounce.Value
end)

script.Parent.Interact.OnServerEvent:Connect(function(Player)
	if not Debounce.Value then
		script.Parent.Parent.Button.Color = Color3.fromRGB(0,255,0)
		Debounce.Value = true
		Player.Character.HumanoidRootPart.CFrame = script.Parent.Parent.TeleportPartExit.CFrame
		wait(1)
		Occupied.Value = false
		Debounce.Value = false
	end
end)