local mutatorImages = {
	["Extra Time"] = "http://www.roblox.com/asset/?id=5569235493",
	["Foggy"] = "http://www.roblox.com/asset/?id=4858321527",
	["High Speed"] = "http://www.roblox.com/asset/?id=2037779615",
	["Invincibility"] = "http://www.roblox.com/asset/?id=5569235586",
	["Low Gravity"] = "http://www.roblox.com/asset/?id=2037970828",
	["Negative"] = "http://www.roblox.com/asset/?id=3063573856"
}

local mutators = game:GetService("ReplicatedStorage").Mutators

for _,mutator in pairs(mutators:GetChildren()) do
	function toggleIcon(val)
		if val then
			if script.Parent:FindFirstChild(mutator.Name) then return end
			local clonedFrame = script.Template:Clone()
			clonedFrame.Name = mutator.Name
			clonedFrame.Image = mutatorImages[mutator.Name]
			clonedFrame.Visible = true
			clonedFrame.Parent = script.Parent
		else
			if not script.Parent:FindFirstChild(mutator.Name) then return end
			script.Parent[mutator.Name]:Destroy()
		end
	end

	toggleIcon(mutator.Value)
	mutator.Changed:Connect(toggleIcon)
end