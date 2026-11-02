-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {}

t2.__index = t2

local function DefaultDestructor() --[[ DefaultDestructor | Line: 8 ]] end

local v1 = t.optional(t.string)

function t2.new(p1, p2) --[[ new | Line: 26 | Upvalues: t (copy), DefaultDestructor (copy), t2 (copy) ]]
	assert(t.callback(p1))
	assert(t.optional(t.callback)(p2))

	local t3 = {
		_destroyed = false,
		_index = 1,
		_prevIndex = 0,
		_debugId = nil,
		_constructor = p1
	}

	t3._destructor = if p2 then p2 else DefaultDestructor
	t3._unKeyed = {}
	t3._keyed = {}
	t3._usedKeys = {}
	t3._prevUsedKeys = {}

	return setmetatable(t3, t2)
end
function t2.Get(p1, p2) --[[ Get | Line: 44 | Upvalues: v1 (copy) ]]
	assert(v1(p2))
	assert(not p1._destroyed, "Pool was destroyed")

	if p2 == nil then
		local v3 = p1._unKeyed[p1._index]
		local v4 = v3 == nil

		if v4 then
			local v5 = p1._constructor()

			p1._unKeyed[p1._index] = v5
			v3 = v5
		end

		p1._index = p1._index + 1

		return v3, v4
	end

	local v6 = p1._keyed[p2]
	local v7 = v6 == nil

	if v7 then
		local v8 = p1._constructor()

		p1._keyed[p2] = v8
		v6 = v8
	end

	p1._usedKeys[p2] = true

	return v6, v7
end
function t2._setDebugId(p1, p2) --[[ _setDebugId | Line: 73 ]]
	p1._debugId = p2
end
function t2.Done(p1) --[[ Done | Line: 77 ]]
	assert(not p1._destroyed, "Pool was destroyed")

	for i = p1._index, p1._prevIndex do
		local v2 = p1._unKeyed[i]

		p1._destructor(v2)
		v2.Parent = nil
	end

	p1._prevIndex = p1._index - 1
	p1._index = 1

	for k, v in pairs(p1._keyed) do
		if not p1._usedKeys[k] and p1._prevUsedKeys[k] then
			p1._destructor(v)
			v.Parent = nil
		end
	end

	p1._prevUsedKeys = table.clone(p1._usedKeys)
	table.clear(p1._usedKeys)
end
function t2.Destroy(p1) --[[ Destroy | Line: 100 ]]
	assert(not p1._destroyed, "Pool was destroyed")

	for k, v in pairs(p1._unKeyed) do
		if k <= p1._prevIndex then
			p1._destructor(v)
		end

		v:Destroy()
	end

	for k, v in pairs(p1._keyed) do
		if p1._prevUsedKeys[k] then
			p1._destructor(v)
		end

		v:Destroy()
	end

	table.clear(p1._unKeyed)
	table.clear(p1._keyed)
	table.clear(p1._usedKeys)
	table.clear(p1._prevUsedKeys)
	p1._destroyed = true
end

return t2