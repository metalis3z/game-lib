-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")

return function(p1, p2, p3) --[[ Line: 3 | Upvalues: RunService (copy) ]]
	RunService:BindToRenderStep(p1, p2, p3)

	return function() --[[ Line: 5 | Upvalues: RunService (ref), p1 (copy) ]]
		RunService:UnbindFromRenderStep(p1)
	end
end