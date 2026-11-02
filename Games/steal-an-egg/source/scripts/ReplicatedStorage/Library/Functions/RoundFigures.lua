-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NiceExp10 = require(ReplicatedStorage.Library.Functions.NiceExp10)

function RoundFigures(p1, p2, p3, p4) --[[ RoundFigures | Line: 4 | Upvalues: NiceExp10 (copy) ]]
	local v2 = p3 or 1
	local v3 = if p4 then p4 else math.round
	local v4 = math.sign(p1)

	if v4 == 0 then
		return 0
	end

	local v5 = p1 * v4
	local v7 = math.floor((math.log10(v5))) - (p2 or 3) + 1

	if v2 ~= 1 then
		v5 = v5 / v2
	end

	return NiceExp10(v3((NiceExp10(v5, -v7))) * v2, v7) * v4
end

return RoundFigures