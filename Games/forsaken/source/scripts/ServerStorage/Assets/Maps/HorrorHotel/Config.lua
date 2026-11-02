-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v8 = {
	["DisplayName"] = "Horror Hotel",
	["Description"] = "introducing joshman601 horror hotel pls like and favorite",
	["Render"] = "rbxassetid://81983515415764",
	["Ambience"] = "rbxassetid://89637323979367",
	["AmbienceProperties"] = {
		["Volume"] = 0.175
	},
	["Created"] = function(p1)
		local v2 = p1.Map.Slowdown.Arms
		for _, v3 in pairs(p1.Map:GetDescendants()) do
			if v3:IsA("BasePart") then
				v3.MaterialVariant = "21_" .. v3.Material.Name
			end
		end
		local v4 = require(game.ReplicatedStorage.Modules.Util):LoadAnimationFromID(v2, "rbxassetid://117276351030166")
		v4.Looped = true
		v4:Play(0)
		for _, v5 in pairs(v2:GetChildren()) do
			if v5.Name:find("ArmGrab") then
				v5.Touched:Connect(function(p6)
					local v7 = p6.Parent
					if v7:FindFirstChild("Humanoid") then
						require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(v7, "Slowness", {
							["Level"] = 3,
							["Duration"] = 2
						})
					end
				end)
			end
		end
	end
}
return v8
