local Occupied = script.Parent.Parent.TubeOccupied
local InUse = script.Parent.InUse
local Debounce = script.Parent.Parent.Debounce

local CollectionService = game:GetService("CollectionService")
CollectionService:AddTag(script.Parent, "InteractiveBox")

Debounce.Changed:Connect(function()
	InUse.Value = Debounce.Value
end)

script.Parent.Interact.OnServerEvent:Connect(function(Player)
	if Occupied.Value then return end
	if not Debounce.Value then	
		script.Parent.Parent.Button.Color = Color3.fromRGB(255,0,0)
		Debounce.Value = true
		Occupied.Value = true
		Player.Character.HumanoidRootPart.CFrame = script.Parent.Parent.TeleportPart.CFrame
		wait(1)
		Debounce.Value = false
	end
end)