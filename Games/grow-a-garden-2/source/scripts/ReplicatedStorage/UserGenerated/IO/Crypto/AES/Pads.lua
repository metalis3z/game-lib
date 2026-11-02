--credit to quartz games studio
local copy = buffer.copy
local create = buffer.create
local fill = buffer.fill
local len = buffer.len
local readu8 = buffer.readu8
local writeu8 = buffer.writeu8
local random = math.random
local t = {}

local function nonPad(p1) --[[ nonPad | Line: 25 ]]
	return p1
end

t.None = table.freeze({
	Overwrite = false,
	Pad = nonPad,
	Unpad = nonPad
})

local function anxPad(p1, p2, p3) --[[ anxPad | Line: 38 | Upvalues: len (copy), copy (copy), fill (copy), writeu8 (copy), create (copy) ]]
	local v1 = len(p1)
	local v2 = v1 - v1 % p3

	if not p2 then
		local v3 = v2 + p3
		local v4 = create(v3)

		copy(v4, 0, p1, 0, v1)
		writeu8(v4, v3 - 1, p3 - v1 % p3)

		return v4
	end

	assert(v1 + p3 <= len(p2), "Output buffer out of bounds")

	local v6 = p3 - v1 % p3

	copy(p2, 0, p1, 0, v1)
	fill(p2, v1, 0, v6 - 1)
	writeu8(p2, v2 + p3 - 1, v6)

	return p2
end

local function anxUnpad(p1, p2, p3) --[[ anxUnpad | Line: 56 | Upvalues: len (copy), readu8 (copy), create (copy), copy (copy) ]]
	local v1 = len(p1)
	local v2 = readu8(p1, v1 - 1)
	local v3 = v1 - v2

	assert(if v2 > 0 then v2 <= p3 else false, "Got unexpected padding")

	for i = v3, v1 - 2 do
		if readu8(p1, i) ~= 0 then
			error("Got unexpected padding")
		end
	end

	if p2 then
		assert(v3 <= len(p2), "Output buffer out of bounds")
	else
		p2 = create(v3)
	end

	copy(p2, 0, p1, 0, v3)

	return p2
end

local function i10Pad(p1, p2, p3) --[[ i10Pad | Line: 78 | Upvalues: len (copy), create (copy), copy (copy), random (copy), writeu8 (copy) ]]
	local v1 = len(p1)
	local v2 = v1 - v1 % p3

	if p2 then
		assert(v1 + p3 <= len(p2), "Output buffer out of bounds")
	else
		p2 = create(v2 + p3)
	end

	copy(p2, 0, p1, 0, v1)

	for i = v1, v2 + p3 - 2 do
		writeu8(p2, i, (random(0, 255)))
	end

	writeu8(p2, v2 + p3 - 1, p3 - v1 % p3)

	return p2
end

local function i10Unpad(p1, p2, p3) --[[ i10Unpad | Line: 93 | Upvalues: len (copy), readu8 (copy), create (copy), copy (copy) ]]
	local v1 = len(p1)
	local v2 = readu8(p1, v1 - 1)
	local v3 = v1 - v2

	assert(if v2 > 0 then v2 <= p3 else false, "Got unexpected padding")

	if p2 then
		assert(if v3 <= len(p2) then true else false, "Output buffer out of bounds")
	else
		p2 = create(v3)
	end

	copy(p2, 0, p1, 0, v3)

	return p2
end

local function pksPad(p1, p2, p3) --[[ pksPad | Line: 110 | Upvalues: len (copy), create (copy), copy (copy), fill (copy) ]]
	local v1 = len(p1)
	local v2 = v1 - v1 % p3

	if p2 then
		assert(v1 + p3 <= len(p2), "Output buffer out of bounds")
	else
		p2 = create(v2 + p3)
	end

	local v5 = p3 - v1 % p3

	copy(p2, 0, p1, 0, v1)
	fill(p2, v1, v5, v5)

	return p2
end

local function pksUnpad(p1, p2, p3) --[[ pksUnpad | Line: 123 | Upvalues: len (copy), readu8 (copy), create (copy), copy (copy) ]]
	local v1 = len(p1)
	local v2 = readu8(p1, v1 - 1)
	local v3 = v1 - v2

	assert(if v2 > 0 then if v2 <= p3 then true else false else false, "Got unexpected padding")

	for i = v3, v1 - 2 do
		if readu8(p1, i) ~= v2 then
			error("Got unexpected padding")
		end
	end

	if p2 then
		assert(v3 <= len(p2), "Output buffer out of bounds")
	else
		p2 = create(v3)
	end

	copy(p2, 0, p1, 0, v3)

	return p2
end

local function ii7Pad(p1, p2, p3) --[[ ii7Pad | Line: 145 | Upvalues: len (copy), fill (copy), create (copy), copy (copy), writeu8 (copy) ]]
	local v1 = len(p1)

	if p2 then
		assert(v1 + p3 <= len(p2), "Output buffer out of bounds")
		fill(p2, v1 + 1, 0, p3 - v1 % p3 - 1)
	else
		p2 = create(v1 + p3 - v1 % p3)
	end

	copy(p2, 0, p1, 0, v1)
	writeu8(p2, v1, 128)

	return p2
end

local function ii7Unpad(p1, p2, p3) --[[ ii7Unpad | Line: 157 | Upvalues: len (copy), readu8 (copy), create (copy), copy (copy) ]]
	local v1 = len(p1) - 1

	for i = v1, v1 - p3, -1 do
		local v2 = readu8(p1, i)

		if v2 == 128 then
			if p2 then
				assert(i <= len(p2), "Output buffer out of bounds")
			else
				p2 = create(i)
			end

			copy(p2, 0, p1, 0, i)

			return p2
		end

		assert(v2 == 0, "Got unexpected padding")
	end

	error("Got unexpected padding")
end

local function zroPad(p1, p2, p3) --[[ zroPad | Line: 181 | Upvalues: len (copy), fill (copy), create (copy), copy (copy) ]]
	local v1 = len(p1)

	if p2 then
		assert(v1 + p3 <= len(p2), "Output buffer out of bounds")
		fill(p2, v1, 0, p3 - v1 % p3)
	else
		p2 = create(v1 + p3 - v1 % p3)
	end

	copy(p2, 0, p1, 0, v1)

	return p2
end

local function zroUnpad(p1, p2, p3) --[[ zroUnpad | Line: 192 | Upvalues: len (copy), readu8 (copy), create (copy), copy (copy) ]]
	local v1 = len(p1) - 1

	for i = v1, v1 - p3, -1 do
		if readu8(p1, i) == 0 then
			local v2 = i + 1

			if p2 then
				assert(v2 <= len(p2), "Output buffer out of bounds")
			else
				p2 = create(v2)
			end

			copy(p2, 0, p1, 0, v2)

			return p2
		end
	end

	copy(p2, 0, p1, 0, v1 - p3 - 1)

	return p2
end

local t2 = {
	__index = function(p1, p2) --[[ __index | Line: 213 | Upvalues: anxPad (copy), i10Pad (copy), i10Unpad (copy), pksPad (copy), pksUnpad (copy), ii7Pad (copy), ii7Unpad (copy), zroPad (copy), zroUnpad (copy) ]]
		if p2 == "AnsiX923" then
			return {
				Overwrite = nil,
				Pad = anxPad,
				Unpad = anxPad
			}
		end

		if p2 == "Iso10126" then
			return {
				Overwrite = nil,
				Pad = i10Pad,
				Unpad = i10Unpad
			}
		end

		if p2 == "Pkcs7" then
			return {
				Overwrite = nil,
				Pad = pksPad,
				Unpad = pksUnpad
			}
		end

		if p2 == "Iso7816_4" then
			return {
				Overwrite = nil,
				Pad = ii7Pad,
				Unpad = ii7Unpad
			}
		end

		if p2 == "Zero" then
			return {
				Overwrite = nil,
				Pad = zroPad,
				Unpad = zroUnpad
			}
		end

		return nil
	end,
	__newindex = function() --[[ __newindex | Line: 231 ]] end
}

setmetatable(t, t2)
t.AnsiX923 = {}
t.Iso10126 = {}
t.Pkcs7 = {}
t.Iso7816_4 = {}
t.Zero = {}
table.freeze(t)
t2.__metatable = "This metatable is locked"

return t