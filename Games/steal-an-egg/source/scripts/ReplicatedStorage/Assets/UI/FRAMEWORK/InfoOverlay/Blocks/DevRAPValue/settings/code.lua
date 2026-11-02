-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Functions = require(game:GetService("ReplicatedStorage").Library.Functions)

return ({
	UpdateTitle = function(p1, p2, p3, p4) --[[ UpdateTitle | Line: 5 | Upvalues: Functions (copy) ]]
		local v1 = math.round(p3)

		if p4 > 1 then
			p1.title.Text = ("\226\154\150\239\184\143 %* (%*/ea)"):format(Functions.NumberShorten(v1 * p4), Functions.NumberShorten(v1))
		else
			p1.title.Text = ("\226\154\150\239\184\143 %*"):format(Functions.NumberShorten(v1))
		end
	end
}).UpdateTitle