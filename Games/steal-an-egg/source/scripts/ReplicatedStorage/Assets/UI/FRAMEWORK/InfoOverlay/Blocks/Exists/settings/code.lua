-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Functions = require(game:GetService("ReplicatedStorage").Library.Functions)

return function(p1, p2, p3) --[[ updateTitle | Line: 3 | Upvalues: Functions (copy) ]]
	p1.title.Text = ("%* Exist%*"):format(Functions.NumberShorten(p3), if p3 == 1 then "s" else "")
end