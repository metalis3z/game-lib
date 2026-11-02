-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

for i = 0, 255 do
	local v1 = i

	for j = 1, 8 do
		if bit32.band(v1, 1) == 0 then
			v1 = bit32.rshift(v1, 1)

			continue
		end

		v1 = bit32.bxor(bit32.rshift(v1, 1), 517762881)
	end

	t[i] = v1
end

local len = string.len
local byte = string.byte
local bxor = bit32.bxor
local rshift = bit32.rshift
local band = bit32.band
local bnot = bit32.bnot

return function(p1) --[[ Line: 22 | Upvalues: len (copy), byte (copy), rshift (copy), t (copy), bxor (copy), band (copy), bnot (copy) ]]
	local v1 = 4294967295

	for i = 1, len(p1) do
		local v2 = byte(p1, i)

		v1 = bxor(rshift(v1, 8), t[band(bxor(v1, v2), 255)])
	end

	return bnot(v1)
end