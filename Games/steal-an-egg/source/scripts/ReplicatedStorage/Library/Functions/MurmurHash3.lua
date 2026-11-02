-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local band = bit32.band
local lshift = bit32.lshift
local rshift = bit32.rshift
local lrotate = bit32.lrotate
local bxor = bit32.bxor
local len = buffer.len
local readu32 = buffer.readu32
local readu8 = buffer.readu8
local readu16 = buffer.readu16
local fromstring = buffer.fromstring

local function mul(p1, p2) --[[ mul | Line: 12 | Upvalues: band (copy), rshift (copy), lshift (copy) ]]
	return band(p1, 65535) * p2 + lshift(band(rshift(p1, 16) * p2, 65535), 16)
end

local function digestBufferCustom(p1, p2, p3, p4) --[[ digestBufferCustom | Line: 16 | Upvalues: readu32 (copy), band (copy), rshift (copy), lshift (copy), lrotate (copy), bxor (copy), readu8 (copy), readu16 (copy) ]]
	local v2 = p4 or 0

	while p2 < p2 + p3 - 3 do
		local v3 = readu32(p1, p2)
		local v4 = lrotate(band(v3, 65535) * 3432918353 + lshift(band(rshift(v3, 16) * 3432918353, 65535), 16), 15)

		v2 = lshift(lrotate(bxor(v2, band(v4, 65535) * 461845907 + lshift(band(rshift(v4, 16) * 461845907, 65535), 16)), 13) * 5, 0) + 3864292196
		p2 = p2 + 4
	end

	local v5 = band(p3, 3)

	if v5 > 0 then
		local v6 = if v5 == 3 then readu8(p1, p2) + lshift(readu16(p1, p2 + 1), 8) elseif v5 == 2 then readu16(p1, p2) else readu8(p1, p2)
		local v9 = lrotate(band(v6, 65535) * 3432918353 + lshift(band(rshift(v6, 16) * 3432918353, 65535), 16), 15)

		v2 = bxor(v2, band(v9, 65535) * 461845907 + lshift(band(rshift(v9, 16) * 461845907, 65535), 16))
	end

	local v11 = bxor(v2, p3)
	local v12 = bxor(v11, (rshift(v11, 16)))
	local v13 = band(v12, 65535) * 2246822507 + lshift(band(rshift(v12, 16) * 2246822507, 65535), 16)
	local v14 = bxor(v13, (rshift(v13, 13)))
	local v15 = band(v14, 65535) * 3266489909 + lshift(band(rshift(v14, 16) * 3266489909, 65535), 16)

	return bxor(v15, (rshift(v15, 16)))
end

return {
	DigestBufferCustom = digestBufferCustom,
	DigestBuffer = function(p1, p2) --[[ digestBuffer | Line: 46 | Upvalues: digestBufferCustom (copy), len (copy) ]]
		return digestBufferCustom(p1, 0, len(p1), p2)
	end,
	Digest = function(p1, p2) --[[ digest | Line: 50 | Upvalues: fromstring (copy), digestBufferCustom (copy), len (copy) ]]
		local v1 = fromstring(p1)

		return digestBufferCustom(v1, 0, len(v1), p2)
	end
}