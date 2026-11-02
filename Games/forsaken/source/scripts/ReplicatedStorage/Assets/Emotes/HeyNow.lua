-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v4 = {
	["DisplayName"] = "Hey Now",
	["Description"] = "You\'re an allsta- oh wait wrong song",
	["Credits"] = "Made By: Tree_Fitten",
	["RenderImage"] = "rbxassetid://93665655595946",
	["Price"] = 900,
	["AssetID"] = "rbxassetid://100964494978364",
	["SFX"] = "rbxassetid://104633544271348",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["SyncMusic"] = true,
	["SyncAnim"] = true,
	["CreatedServer"] = function(p1)
		local v2 = p1.Character
		if v2 then
			p1.Radio = script.MeshPart:Clone()
			p1.Radio.Parent = v2
			p1.Radio.MeshPart.Part0 = v2.PrimaryPart
		end
	end,
	["DestroyedServer"] = function(p3)
		if p3.Radio then
			p3.Radio:Destroy()
		end
	end
}
return v4
