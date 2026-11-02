--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeepEquals = require(ReplicatedStorage.UserGenerated.Collections.DeepEquals)
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)

local function Get(p1) --[[ Get | Line: 45 ]]
	return p1.Value
end

local function Set(p1, p2) --[[ Set | Line: 62 | Upvalues: DeepEquals (copy) ]]
	if p1.Assertion then
		p2 = p1.Assertion(p2)
	end

	local v2 = p1.Value

	p1.Value = p2

	if not DeepEquals(p2, v2) then
		p1.Changed:Fire(p2, v2)
	end

	return v2
end

local v2 = table.freeze({
	__index = table.freeze({
		Get = Get,
		Set = Set
	})
})

local function new(p1, p2) --[[ new | Line: 84 | Upvalues: Bindable (copy), v2 (copy) ]]
	assert(if type(p1) == "function" then true else false)

	local v22 = p1(p2)
	local t = {
		Changed = Bindable.new(),
		Assertion = p1,
		Value = v22
	}

	t.Readonly = t

	return setmetatable(t, v2)
end

local function Unasserted(p1) --[[ Unasserted | Line: 100 | Upvalues: Bindable (copy), v2 (copy) ]]
	local t = {
		Changed = Bindable.new(),
		Value = p1
	}

	t.Readonly = t

	return setmetatable(t, v2)
end

return table.freeze({
	new = new,
	Unasserted = Unasserted
})