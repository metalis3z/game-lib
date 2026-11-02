-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local BinaryToInt = require(script.Parent.BinaryToInt)

return function(p1) --[[ Line: 3 | Upvalues: BinaryToInt (copy) ]]
	assert(if type(p1) == "string" then if #p1 >= 16 then true else false else false)

	return string.format("%08x%08x%08x%08x", BinaryToInt(p1:sub(1, 4)), bit32.bor(bit32.band(BinaryToInt(p1:sub(5, 8)), 4294905855), 16384), bit32.bor(bit32.band(BinaryToInt(p1:sub(9, 12)), 1073741823), 2147483648), (BinaryToInt(p1:sub(13, 16))))
end