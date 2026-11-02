if script.Parent:FindFirstChildOfClass("ProximityPrompt") then
	script.Parent:FindFirstChildOfClass("ProximityPrompt"):Destroy()
end
if not script.Parent:GetAttribute("Opened") then
	script.Parent:SetAttribute("Opened", false)
end
local newprompt = Instance.new("ProximityPrompt")
local animloader = script.Parent.AnimationController
local cloce = animloader:LoadAnimation(script.Parent.Animations.close)
local open = animloader:LoadAnimation(script.Parent.Animations.open)
local idle = animloader:LoadAnimation(script.Parent.Animations.openidle)
local itemunlocked = false
local item = script.Parent:FindFirstChild("Vitamins")
newprompt.Style = Enum.ProximityPromptStyle.Custom
newprompt.Name = "ActivateEventPrompt"
newprompt.ActionText = "Loot"
newprompt.ObjectText = "Drawer"
newprompt.Parent = script.Parent
newprompt.Triggered:Connect(function(player)
	if script.Parent:GetAttribute("Opened") ~= true then
		if item then
			if itemunlocked == false then
				itemunlocked = true
				item.Main.PlaySound:Play()
				item.ModulePrompt.Enabled = true
			end
		end
		script.Parent.Main.Open:Play()
		open:Play()
		task.wait(open.Length)
		idle:Play()
		newprompt.ActionText = "Looted"
		script.Parent:SetAttribute("Opened", true)
	else
		if item then
			item.ModulePrompt.Enabled = false
	    end
		script.Parent.Main.Close:Play()
		cloce:Play()
		idle:Stop()
		task.wait(cloce.Length)
		script.Parent:SetAttribute("Opened", false)
	end
end)
