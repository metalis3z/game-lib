-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["DisplayName"] = "Drumsticks",
	["Description"] = "\"Um, I\'m sorry unfortunately we are out of time...\"",
	["Credits"] = "Made By: Tree_Fitten",
	["RenderImage"] = "rbxassetid://80678095206124",
	["Price"] = 400,
	["Speed"] = 11,
	["AssetID"] = "rbxassetid://104218242170233",
	["SFX"] = "rbxassetid://79545773891548",
	["CreatedServer"] = function(p1)
		local v2 = p1.Character
		if v2 then
			p1.Drumsticks = {}
			for _, v3 in pairs(script:GetChildren()) do
				local v4 = v3.MeshPart:Clone()
				v4.MeshPart.Part0 = v2:FindFirstChild(v3.Name)
				v4.Parent = v2
				local v5 = p1.Drumsticks
				table.insert(v5, v4)
			end
		end
	end,
	["DestroyedServer"] = function(p6)
		for _, v7 in pairs(p6.Drumsticks or {}) do
			v7:Destroy()
		end
	end
}
