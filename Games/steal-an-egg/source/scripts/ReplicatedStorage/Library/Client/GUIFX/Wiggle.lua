-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions = require(ReplicatedStorage.Library.Functions)

return function(p1, p2, p3) --[[ Wiggle | Line: 4 | Upvalues: Functions (copy) ]]
	local v1 = p2 or 15
	local Rotation = p1.Rotation

	return Functions.RenderStepped(function(p12, p2) --[[ Line: 7 | Upvalues: v1 (ref), p1 (copy) ]]
		p1.Rotation = v1 * math.sin(6.283185307179586 * (1 + p2) * 6) / 4 ^ (5 * p2)
	end, p3 or 1, true):Then(function() --[[ Line: 11 | Upvalues: p1 (copy), Rotation (copy) ]]
		p1.Rotation = Rotation
	end)
end