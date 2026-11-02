local v7 = {
	["DisplayName"] = "Ultimate Assassin Grounds",
	["Description"] = "NOT SO NEW DOJO!",
	["Ambience"] = "rbxassetid://82152520941515",
	["AmbienceProperties"] = {
		["Volume"] = 1
	},
	["Created"] = function(p1) --[[Function name: Created, line 14]]
		local v2 = p1.Map.SlownessParts
		for _, v4 in pairs(v2:GetChildren()) do
			v4.Touched:Connect(function(p5) --[[Anonymous function at line 26]]
				local v6 = p5.Parent
				if p5.Parent:FindFirstChild("Humanoid") then
					require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(p5.Parent, "Slowness", {
						["Level"] = 2,
						["Duration"] = 2
					})
				end
			end)
		end
	end
}
return v7