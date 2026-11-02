-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
function HMAC(p1, p2, p3, p4) --[[ HMAC | Line: 1 ]]
	if p2 < #p3 then
		p3 = p1(p3)
	end

	local v2 = p3 .. string.rep("\0", p2 - #p3)
	local v3 = string.rep("\\", p2)
	local v4 = string.rep("6", p2)
	local v5 = ""
	local v6 = ""

	for i = 1, p2 do
		local v7 = string.byte(v3, i)
		local v8 = string.byte(v2, i)

		v5 = v5 .. string.char((bit32.bxor(v7, v8)))
		v6 = v6 .. string.char((bit32.bxor(string.byte(v4, i), v8)))
	end

	return p1(v5 .. p1(v6 .. p4))
end

return HMAC