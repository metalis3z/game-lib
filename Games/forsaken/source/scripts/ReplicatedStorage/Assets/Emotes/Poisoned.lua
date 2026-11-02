-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["DisplayName"] = "Poisoned",
	["Description"] = "fortnite",
	["Credits"] = "Made By: c2o",
	["RenderImage"] = "rbxassetid://92399495788269",
	["Price"] = 400,
	["AssetID"] = "rbxassetid://98298145242276",
	["SFX"] = "rbxassetid://118582448199737",
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
					["Volume"] = 1.2,
					["Parent"] = v_u_2,
					["Name"] = "PlayerEmoteSFX",
					["RollOffMinDistance"] = 12,
					["RollOffMaxDistance"] = 18
				}
				require(game.ReplicatedStorage.Modules.Sounds):Play("rbxassetid://3239083228", v4)
			end)
		end
	end
}
