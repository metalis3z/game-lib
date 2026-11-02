-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v10 = {
	["DisplayName"] = "Chicken",
	["Description"] = "nom nom nom RGHRGHRGRGHR",
	["Credits"] = "Made By: snowyblessing",
	["RenderImage"] = "rbxassetid://93387041641721",
	["Price"] = 650,
	["AssetID"] = "rbxassetid://88259206269160",
	["SFX"] = "rbxassetid://1838457617",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["CreatedServer"] = function(p1)
		local v2 = p1.Character
		if v2 then
			local v3 = Instance.new("Folder")
			v3.Name = "EmoteAssets"
			v3.Parent = v2
			for _, v4 in pairs(script:GetChildren()) do
				if v4:IsA("BasePart") then
					local v5 = script:FindFirstChild((("%*Joint"):format(v4.Name)))
					if v5 then
						local v6 = v4:Clone()
						v6.Parent = v3
						local v7 = v5:Clone()
						v7.Part0 = v2:FindFirstChild((tostring(v4:GetAttribute("AttachTo"))))
						v7.Part1 = v6
						v7.Parent = v6
					end
				end
			end
		end
	end,
	["DestroyedServer"] = function(p8)
		local v9 = p8.Character
		if v9 then
			v9 = v9:FindFirstChild("EmoteAssets")
		end
		if v9 then
			v9:Destroy()
		end
	end
}
return v10
