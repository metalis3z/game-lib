-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v10 = {
	["DisplayName"] = "Caramell",
	["Description"] = "It\226\128\153s no lie, Lisa in the crowd said; ",
	["Credits"] = "Made By: AndrewD0tWeb & NiixxOG",
	["RenderImage"] = "rbxassetid://75549836782121",
	["Price"] = 650,
	["CreatedServer"] = function(p1)
		local v2 = p1.Character
		local v3 = v2 and v2:FindFirstChild("Torso")
		if v3 then
			local v4 = script:FindFirstChild("Effect1")
			if v4 then
				v4:Clone().Parent = v3
			end
			local v5 = script:FindFirstChild("Effect2")
			if v5 then
				v5:Clone().Parent = v3
			end
		end
	end,
	["DestroyedServer"] = function(p6)
		local v7 = p6.Character
		local v8 = v7 and v7:FindFirstChild("Torso")
		if v8 then
			for _, v9 in pairs(v8:GetChildren()) do
				if v9.Name == "Effect1" or v9.Name == "Effect2" then
					v9:Destroy()
				end
			end
		end
	end,
	["AssetID"] = "rbxassetid://95899415604662",
	["SFX"] = "rbxassetid://127550001365624",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["SyncMusic"] = true,
	["SyncAnim"] = true,
	["SyncDistance"] = 20
}
return v10
