-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService"):IsServer()
local v3 = v1:WaitForChild("Modules")
local v4 = require(v3:WaitForChild("Warp"))
local v_u_5
if v_u_2 then
	v_u_5 = v4.Server("Change")
else
	v_u_5 = v_u_2
end
local v_u_6 = v3:WaitForChild("Moves")
local v_u_7 = require(v_u_6:WaitForChild("Locate"))
return {
	["HighlightObject"] = function(_, p8, p9)
		-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7
		if v_u_2 then
			v_u_5:Fire(true, p9, {
				"Module",
				v_u_6.Locate,
				"Activate",
				p8
			})
		else
			v_u_7.Activate(p8)
		end
	end
}