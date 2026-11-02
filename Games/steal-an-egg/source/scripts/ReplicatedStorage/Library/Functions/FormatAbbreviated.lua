-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = { "k", "m", "b", "t", "q", "Qt", "Sx" }

return function(p1, p2, p3) --[[ Line: 11 | Upvalues: t (copy) ]]
	local v1 = p2 or 3
	local v5 = math.max(math.abs(p1), (math.pow(10, -#t * 3)))
	local v9 = 10 ^ (math.min(math.ceil((math.log10(v5))), #t * 3 + v1) - (p3 or 0) - v1)
	local v10 = math.round(v5 / v9) * v9
	local v15 = math.min(math.floor(math.log10((math.max(v10, 1))) / 3), #t)
	local v17 = string.format("%f", v10 * math.sign(p1) / 10 ^ (v15 * 3)):gsub("%.?0+$", "")

	if v15 >= 1 then
		return v17 .. t[v15]
	end

	return v17
end