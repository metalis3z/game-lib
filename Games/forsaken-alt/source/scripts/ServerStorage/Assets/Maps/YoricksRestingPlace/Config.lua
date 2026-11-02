local v7 = {
	["DisplayName"] = "Yorick's resting place",
	["Description"] = "stop breaking into my house!!!!!!",
	["Ambience"] = "rbxassetid://82152520941515",
	["AmbienceProperties"] = {
		["Volume"] = 1
	},
	["Created"] = function(p1) --[[Function name: Created, line 14]]
		local v2 = p1.Map.AcidContainer.Acid
		for _, v4 in pairs(v2:GetChildren()) do
			v4.Touched:Connect(function(p5) --[[Anonymous function at line 26]]
				local v6 = p5.Parent
				if p5.Parent:FindFirstChild("Humanoid") then
					require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(p5.Parent, "Poisoned", {
						["Level"] = 1,
						["Duration"] = 8
					})
				end
			end)
		end
	end
}
return v7