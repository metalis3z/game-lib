local CollectionService = game:GetService("CollectionService")
CollectionService:AddTag(script.Parent, "InteractiveBox")

local Spinning = false
local Debounce = false
local Button = script.Parent.Parent.Switch
local InUse = script.Parent.InUse

local function TriggerAllSirens(bool)
	script.Parent.Parent.ToggleAll.Value = bool
end

script.Parent.Interact.OnServerEvent:Connect(function(Player)
	if not InUse.Value then
		InUse.Value = true
		for i,v in Button.Button:GetDescendants() do
			v.Transparency = 1
		end
		for i,v in Button.ButtonPressed:GetDescendants() do
			v.Transparency = 0
		end
		script.Parent.Parent.Parent.DoorLockdown1.InteractiveBox.ForceClosed.Value = true
		script.Parent.Parent.Parent.DoorLockdown2.InteractiveBox.ForceClosed.Value = true
		TriggerAllSirens(true)
		wait(20)
		for i,v in Button.Button:GetDescendants() do
			v.Transparency = 0
		end
		for i,v in Button.ButtonPressed:GetDescendants() do
			v.Transparency = 1
		end
		TriggerAllSirens(false)
		wait(40)
		InUse.Value = false
	end
end)