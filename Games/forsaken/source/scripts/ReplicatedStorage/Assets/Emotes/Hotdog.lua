-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v10 = {
	["DisplayName"] = "Hotdog",
	["Description"] = "Hey kid, want a",
	["Credits"] = "Made By: shipi7",
	["RenderImage"] = "rbxassetid://70514684116327",
	["Price"] = 175,
	["AssetID"] = "rbxassetid://113201780763319",
	["SFX"] = "rbxassetid://75226719036096",
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
