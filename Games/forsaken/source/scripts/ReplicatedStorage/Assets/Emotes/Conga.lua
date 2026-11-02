-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v5 = {
	["DisplayName"] = "Conga",
	["Description"] = "Conga conga conga!",
	["Credits"] = "Made By: ffPrankster",
	["RenderImage"] = "rbxassetid://86813660004340",
	["Price"] = 650,
	["AutoWalk"] = true,
	["Speed"] = 5,
	["AssetID"] = {
		["Survivalist"] = "rbxassetid://88074823591793",
		["Sentinel"] = "rbxassetid://111390883863272",
		["Support"] = "rbxassetid://123041270268320"
	},
	["SFX"] = "rbxassetid://104396878120843",
	["SFXProperties"] = {
		["Looped"] = true
	},
	["SyncMusic"] = true,
	["CreatedServer"] = function(p1)
		local v_u_2 = p1.Character
		if v_u_2 then
			v_u_2 = p1.Character.PrimaryPart
		end
		local v3 = p1.Emote
		if v_u_2 and v3 then
			v3:GetMarkerReachedSignal("Clap"):Connect(function()
				-- upvalues: (copy) v_u_2
				local v4 = {
					["Parent"] = v_u_2,
					["Name"] = "PlayerEmoteSFX",
					["RollOffMinDistance"] = 12,
					["RollOffMaxDistance"] = 18
				}
				require(game.ReplicatedStorage.Modules.Sounds):Play("rbxassetid://9114771714", v4)
			end)
		end
	end
}
return v5
