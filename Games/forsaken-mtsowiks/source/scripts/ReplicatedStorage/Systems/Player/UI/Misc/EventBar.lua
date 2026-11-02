-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(game.ReplicatedStorage.GlobalTypes)
local v1 = game:GetService("Players")
local v_u_2 = script.EventIcons
local v_u_3 = script.EventBar
local v_u_4 = v1.LocalPlayer
return {
	["Start"] = function(_)
		-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
		local v5 = v_u_3:Clone()
		for v6, v7 in workspace:GetAttributes() do
			if v6:find("Event_") and (v7 == true and v_u_2[v6]) then
				v_u_2[v6]:Clone().Parent = v5
				warn((("[%*]: Found new event flag: %*, enabling it."):format(script, v6)))
			end
		end
		local v8 = v_u_4
		if v8 then
			v8 = v_u_4.PlayerGui:FindFirstChild("MainUI")
		end
		v5.Parent = v8
	end
}
