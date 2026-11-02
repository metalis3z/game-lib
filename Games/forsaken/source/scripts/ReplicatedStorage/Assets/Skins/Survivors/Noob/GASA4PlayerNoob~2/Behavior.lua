-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-17 06:45:45
-- Luau version 6, Types version 3
-- Time taken: 0.001248 seconds

return {
	CreatedPost = function(arg1, arg2) -- Line 4, Named "CreatedPost"
		if game["Run Service"]:IsServer() then
			local Player = arg2.Player
			if Player then
				Player = arg2.Player.DisplayName
			end
			arg2.Rig.Torso.NameGui.Title.Text = tostring(Player)
		end
	end;
}