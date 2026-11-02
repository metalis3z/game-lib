-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = table.freeze({
	["0"] = "\0",
	["1"] = "\1",
	["2"] = "\2",
	["3"] = "\3",
	["4"] = "\4",
	["5"] = "\5",
	["6"] = "\6",
	["7"] = "\7",
	["8"] = "\8",
	["9"] = "\t"
})

function t.from_double(p1) --[[ from_double | Line: 15 | Upvalues: v1 (copy) ]]
	local v12, v2, v3 = string.match(tostring(p1), "^(%d+)%.?(%d*)e?([+-]?%d*)$")
	local v4, v5 = string.match(v12 .. v2, "^0*(%d-)(0*)$")
	local t = {}

	t[1] = string.byte(string.gsub(v4, ".", v1), 1, -1)

	return t, #t, (tonumber(v3) or 0) - #v2 + #v5
end

return table.freeze(t)