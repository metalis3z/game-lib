--credit to quartz games studio
local band = bit32.band
local lshift = bit32.lshift
local rshift = bit32.rshift
local lrotate = bit32.lrotate
local bxor = bit32.bxor
local bor = bit32.bor
local len = buffer.len
local readu32 = buffer.readu32
local readu8 = buffer.readu8
local readu16 = buffer.readu16
local fromstring = buffer.fromstring

function mul32(p1, p2) --[[ mul32 | Line: 26 | Upvalues: band (copy), rshift (copy), lshift (copy) ]]
	return band(p1, 65535) * p2 + lshift(band(rshift(p1, 16) * p2, 65535), 16)
end
function DigestBufferUnsafe(p1, p2, p3, p4) --[[ DigestBufferUnsafe | Line: 30 | Upvalues: bor (copy), readu32 (copy), lrotate (copy), bxor (copy), lshift (copy), band (copy), readu8 (copy), readu16 (copy), rshift (copy) ]]
	local v1

	if p4 == nil then
		v1 = 0
	else
		assert(bor(p4, 0) == p4)
		v1 = p4
	end

	local sum, v3 = p2, p2 + p3 - 3

	while sum < v3 do
		v1 = lshift(lrotate(bxor(v1, (mul32(lrotate(mul32(readu32(p1, sum), 3432918353), 15), 461845907))), 13) * 5, 0) + 3864292196
		sum = sum + 4
	end

	local v6 = band(p3, 3)

	if v6 > 0 then
		v1 = bxor(v1, (mul32(lrotate(mul32(if v6 == 3 then readu8(p1, sum) + lshift(readu16(p1, sum + 1), 8) elseif v6 == 2 then readu16(p1, sum) else readu8(p1, sum), 3432918353), 15), 461845907)))
	end

	local v12 = bxor(v1, p3)
	local v14 = mul32(bxor(v12, (rshift(v12, 16))), 2246822507)
	local v16 = mul32(bxor(v14, (rshift(v14, 13))), 3266489909)

	return bxor(v16, (rshift(v16, 16)))
end
function DigestBufferCustom(p1, p2, p3, p4) --[[ DigestBufferCustom | Line: 83 | Upvalues: len (copy) ]]
	assert(if type(p1) == "buffer" then true else false)
	assert(if type(p2) == "number" and p2 >= 0 then if p2 <= len(p1) then true else false else false)
	assert(if type(p3) == "number" and p3 >= 0 then if p3 <= len(p1) - p2 then true else false else false)

	return DigestBufferUnsafe(p1, p2, p3, p4)
end
function DigestBuffer(p1, p2) --[[ DigestBuffer | Line: 99 | Upvalues: len (copy) ]]
	return DigestBufferUnsafe(p1, 0, len(p1), p2)
end
function Digest(p1, p2) --[[ Digest | Line: 103 | Upvalues: fromstring (copy), len (copy) ]]
	local v1 = fromstring(p1)

	return DigestBufferUnsafe(v1, 0, len(v1), p2)
end

local t = {
	DigestBufferCustom = DigestBufferCustom,
	DigestBuffer = DigestBuffer,
	Digest = Digest
}

table.freeze(t)

return t