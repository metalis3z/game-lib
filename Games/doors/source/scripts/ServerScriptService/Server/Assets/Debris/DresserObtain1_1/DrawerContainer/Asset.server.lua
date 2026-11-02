if script.Parent.Knobs:FindFirstChildOfClass("ProximityPrompt") then
	script.Parent.Knobs:FindFirstChildOfClass("ProximityPrompt"):Destroy()
end
if not script.Parent:GetAttribute("Opened") then
	script.Parent:SetAttribute("Opened", false)
end

local coinloot = false
local newprompt = Instance.new("ProximityPrompt")
newprompt.Style = Enum.ProximityPromptStyle.Custom
newprompt.Name = "ActivateEventPrompt"
newprompt.ActionText = "Loot"
newprompt.ObjectText = "Drawer"
newprompt.Parent = script.Parent.Knobs
newprompt.Triggered:Connect(function(player)
	if script.Parent:GetAttribute("Opened") ~= true then
		if coinloot == false then
			coinloot = true
			script.Parent.Parent:FindFirstChild(script.Parent:GetAttribute("Coin")).Sound:Play()
		end
		script.Parent.Constraint.TargetPosition = 5
		script.Parent.Main.Open:Play()
		newprompt.ActionText = "Looted"
		script.Parent:SetAttribute("Opened", true)
	else
		script.Parent.Constraint.TargetPosition = 0
		script.Parent.Main.Close:Play()
		script.Parent:SetAttribute("Opened", false)
	end
end)
