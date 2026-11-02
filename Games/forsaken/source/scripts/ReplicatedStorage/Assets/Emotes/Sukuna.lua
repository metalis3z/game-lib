-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v12 = {
	["DisplayName"] = "Sukuna",
	["Description"] = "\"Welcome to my malevolent kitchen what could I get for you\"",
	["Credits"] = "Made By: Tree_Fitten, & BillyMalfroid",
	["RenderImage"] = "rbxassetid://95950437854407",
	["Price"] = 1500,
	["AssetID"] = "rbxassetid://70933986120521",
	["SFX"] = "rbxassetid://137906124003434",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["CreatedServer"] = function(p1)
		local v2 = p1.Character
		if v2 then
			for _, v3 in pairs(script:GetChildren()) do
				if v3.Name:find("Handle") then
					local v4 = v3:Clone()
					local v5 = v4:FindFirstChildWhichIsA("Motor6D")
					local v6 = v2:FindFirstChild((("%* Arm"):format((string.gsub(v4.Name, "Handle", "")))))
					if v5 and v6 then
						v5.Part0 = v6
						v4.Name = "PlayerEmoteHand"
						v4.Parent = v2
						for _, v7 in pairs(v4:GetDescendants()) do
							if v7:IsA("BasePart") then
								v7.Color = v6.Color
							end
						end
					else
						v4:Destroy()
					end
				end
			end
			local v8 = script.DismantleFX:Clone()
			v8.DismantleFX.Part0 = v2.PrimaryPart
			v8.Parent = v2
		end
	end,
	["DestroyedServer"] = function(p9)
		local v10 = p9.Character
		if v10 then
			for _, v11 in pairs(v10:GetChildren()) do
				if v11.Name == "PlayerEmoteHand" or v11.Name == "DismantleFX" then
					v11:Destroy()
				end
			end
		end
	end
}
return v12
