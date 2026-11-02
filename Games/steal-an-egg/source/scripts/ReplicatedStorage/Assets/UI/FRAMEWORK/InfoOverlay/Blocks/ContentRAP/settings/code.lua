-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Functions = require(game.ReplicatedStorage.Library.Functions)

return function(p1, p2, p3, p4) --[[ Line: 3 | Upvalues: Functions (copy) ]]
	local v1 = math.round(p3)

	if p4 > 1 then
		p1.title.Text = ("Contents: %* (%*/ea)"):format(Functions.NumberShorten(v1 * p4), Functions.NumberShorten(v1))
	else
		p1.title.Text = ("Contents: %*"):format(Functions.NumberShorten(v1))
	end
end