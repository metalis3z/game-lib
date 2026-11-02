-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v7 = {
	["DisplayName"] = "Hakari Dance",
	["Description"] = "\"For 4 minutes and 11 seconds, Hakari is effectively immortal!\"",
	["Credits"] = "Made By: Flarebeorn",
	["RenderImage"] = "rbxassetid://124587965197013",
	["Price"] = 777,
	["AssetID"] = "rbxassetid://131248818380412",
	["SFX"] = "rbxassetid://127987908902168",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["CreatedServer"] = function(p1)
		local v2 = p1.Character
		if v2 then
			local v3 = script.HakariBeamEffect:Clone()
			v3.Name = "PlayerEmoteVFX"
			v3.CFrame = v2.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
			v3.WeldConstraint.Part0 = v2.PrimaryPart
			v3.WeldConstraint.Part1 = v3
			v3.Parent = v2
		end
	end,
	["DestroyedServer"] = function(p4)
		local v5 = p4.Character
		local v6 = v5 and v5:FindFirstChild("PlayerEmoteVFX")
		if v6 then
			v6:Destroy()
		end
	end
}
return v7
