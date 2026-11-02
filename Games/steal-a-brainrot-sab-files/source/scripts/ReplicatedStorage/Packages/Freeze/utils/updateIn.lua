

local ParentParent = script.Parent.Parent
local None = require(ParentParent.None)
local isDataStructure = require(script.Parent.Parent.utils.isDataStructure)
local slice = require(script.Parent.slice)
local get = require(script.Parent.get)
local remove = require(script.Parent:FindFirstChild("remove"))
local set = require(script.Parent.set)

local function toString(p1)
	return table.concat(p1, ", ")
end
local function updateInDeeply(p2, t1: {[any]: any}, n1: number, p3: ((...any) -> ...any), p4)
	local v16 = p2 == None

	if n1 == #t1 + 1 then
		local v17 = if not v16 then p2 else p4
		local v18 = p3(v17)

		if v18 == v17 then
			return p2
		end

		return v18
	end

	if not v16 and not isDataStructure(p2) then
		local _error = error
		local v20 = slice(t1, 1, n1 - 1)

		_error("Cannot update within non-data-structure value in path [" .. table.concat(v20, ", ") .. "]: " .. tostring(p2))
	end

	local v21 = t1[n1]
	local v22 = if not v16 then get(p2, v21, None) else None
	local v23 = updateInDeeply(v22, t1, n1 + 1, p3, p4)

	if v23 == v22 then
		return p2
	end

	if v23 == None then
		return (remove(p2, v21))
	end

	return (set(if not v16 then p2 else {}, v21, v23))
end

return function(t2: {[any]: any}, t3: {[any]: any}, p5: ((...any) -> ...any), p6)
	local v28 = updateInDeeply(t2, t3, 1, p5, p6)

	if v28 == None then
		return p6
	end

	return v28
end
