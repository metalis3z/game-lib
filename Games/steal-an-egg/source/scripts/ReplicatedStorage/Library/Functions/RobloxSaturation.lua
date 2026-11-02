-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Lerp = require(script.Parent.Lerp)

return function(p1, p2) --[[ Line: 3 | Upvalues: Lerp (copy) ]]
	local R = p1.R
	local G = p1.G
	local B = p1.B
	local v1 = R * 0.299 + G * 0.587 + B * 0.114
	local v2 = Lerp(v1, R, 1 + p2)
	local v3 = Lerp(v1, G, 1 + p2)

	return Color3.new(v2, v3, (Lerp(v1, B, 1 + p2)))
end