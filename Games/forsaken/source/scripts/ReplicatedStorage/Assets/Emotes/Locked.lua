-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v10 = {
	["DisplayName"] = "Locked",
	["Description"] = "\'Forsaken Is Cringe\' you do NOT want to make us angry...",
	["Credits"] = "Made By: AndrewD0tWeb",
	["RenderImage"] = "rbxassetid://103241825392940",
	["Price"] = 750,
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
	["AssetID"] = "rbxassetid://127599271772218",
	["SFX"] = "rbxassetid://117520733630504",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["SyncMusic"] = true,
	["SyncAnim"] = true
}
return v10
