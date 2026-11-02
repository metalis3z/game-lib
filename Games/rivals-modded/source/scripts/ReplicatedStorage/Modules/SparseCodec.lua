-- Tables with gaps in their numeric keys, made safe for remotes and DataStores.
--
-- A remote cuts an array at its first hole: { [1] = a, [3] = c } arrives as { [1] = a }.
-- EquippedEmotes is exactly that (a slot number per emote), so the server packs such tables
-- as { [MARKER] = { key, value, key, value, ... } } before sending or saving them, and
-- ClientPlayerData unpacks them on arrival. Proper arrays and string-keyed tables pass
-- through untouched.

local SparseCodec = {}

SparseCodec.MARKER = "__sparse"

local function isSparse(value: { [any]: any }): boolean
	local count, hasNumber = 0, false
	for key in value do
		count += 1
		if type(key) == "number" then
			hasNumber = true
		else
			return false
		end
	end
	return hasNumber and count ~= #value
end

function SparseCodec.Encode(value: any): any
	if type(value) ~= "table" then
		return value
	end

	if isSparse(value) then
		local pairsList = {}
		for key, item in value do
			table.insert(pairsList, key)
			table.insert(pairsList, SparseCodec.Encode(item))
		end
		return { [SparseCodec.MARKER] = pairsList }
	end

	local copy = {}
	for key, item in value do
		copy[key] = SparseCodec.Encode(item)
	end
	return copy
end

function SparseCodec.Decode(value: any): any
	if type(value) ~= "table" then
		return value
	end

	local packed = value[SparseCodec.MARKER]
	if type(packed) == "table" then
		local result = {}
		for index = 1, #packed, 2 do
			result[packed[index]] = SparseCodec.Decode(packed[index + 1])
		end
		return result
	end

	for key, item in value do
		if type(item) == "table" then
			value[key] = SparseCodec.Decode(item)
		end
	end
	return value
end

return SparseCodec
