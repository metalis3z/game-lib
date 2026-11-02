-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.Util)
return {
	["OnIntroduction"] = function(_, _, _, p_u_3)
		-- upvalues: (copy) v_u_2
		local function v4()
			-- upvalues: (ref) v_u_2, (copy) p_u_3
			v_u_2:CreateFOVMultiplier(game.Players.LocalPlayer.Character, 0.8571428571428571, "ArtfulIntro", p_u_3)
		end
		task.spawn(v4)
	end
}