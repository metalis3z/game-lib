-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Items = Library:WaitForChild("Items")
local Asserts = require(Library.Asserts)
local Types = require(Items.Types)
local AbstractStore = require(script.Parent.AbstractStore)
local v1 = newproxy()

local function encode(p1, p2) --[[ encode | Line: 15 | Upvalues: v1 (copy) ]]
	if p1 == p2 then
		return v1
	end

	return if p1 then p1 else v1
end

local function decode(p1, p2) --[[ decode | Line: 22 | Upvalues: v1 (copy) ]]
	if not p1 then
		return p2
	end

	if p1 == v1 then
		return v1
	end

	return if p1 then p1 else v1
end

local t = {
	NIL = v1
}
local t2 = {
	Class = "ShadowStoreChild",
	GetIteration = function(p1) --[[ GetIteration | Line: 38 ]]
		return (p1._parentIteration or p1._parent:GetIteration()) + p1._iteration
	end,
	Size = function(p1) --[[ Size | Line: 42 ]]
		return p1._size + p1._parent:Size()
	end,
	Amount = function(p1) --[[ Amount | Line: 46 ]]
		return p1._amount + p1._parent:Amount()
	end,
	Get = function(p1, p2) --[[ Get | Line: 50 | Upvalues: v1 (copy) ]]
		local v12 = p1._byUID[p2]

		if not v12 then
			return p1._parent:Get(p2)
		end

		if v12 == v1 then
			v12 = nil
		end

		return v12
	end,
	_SetReference = function(p1, p2, p3) --[[ _SetReference | Line: 61 | Upvalues: v1 (copy) ]]
		local v12 = p1._parent:Get(p2)
		local v2 = p1._byUID[p2]
		local v3 = if v2 then if v2 == v1 then v1 elseif v2 then v2 else v1 else v12
		local _size = p1._size
		local _amount = p1._amount

		if v3 then
			_amount = _amount - v3:GetAmount()
			_size = _size - 1
		end

		if p3 then
			_amount = _amount + p3:GetAmount()
			_size = _size + 1
		end

		p1._size = _size
		p1._amount = _amount
		p1._byUID[p2] = if p3 == v12 then v1 elseif p3 then p3 else v1

		if not p1._parentIteration then
			p1._parentIteration = p1._parent:GetIteration()
		end

		p1._iteration = p1._iteration + 1
	end,
	All = function(p1, p2) --[[ All | Line: 88 | Upvalues: v1 (copy) ]]
		local v12 = p1._parent:All(true)

		for k, v in pairs(p1._byUID) do
			if v == v1 or not v then
				v = nil
			end

			v12[k] = v
		end

		return v12
	end,
	Each = function(p1, p2, ...) --[[ Each | Line: 99 | Upvalues: v1 (copy) ]]
		local v12 = p1._parent:Each(function(p1, p22, ...) --[[ Line: 100 | Upvalues: p2 (copy) ]]
			if p22[p1:GetUID()] then
				return
			end

			return p2(p1, ...)
		end, p1._byUID, ...)

		if v12 ~= nil then
			return v12
		end

		for k, v in pairs(p1._byUID) do
			if v ~= v1 then
				local v2 = p2(v, ...)

				if v2 ~= nil then
					return v2
				end
			end
		end
	end,
	IsEmpty = function(p1) --[[ IsEmpty | Line: 122 | Upvalues: v1 (copy) ]]
		for k, v in pairs(p1._byUID) do
			if v ~= v1 then
				return false
			end
		end

		local v12 = p1._parent:Each(function(p1, p2) --[[ Line: 129 | Upvalues: v1 (ref) ]]
			return if p2[p1:GetUID()] == v1 then nil else true
		end, p1._byUID) == nil

		return v12
	end,
	Reset = function(p1) --[[ Reset | Line: 134 ]]
		p1._size = 0
		p1._amount = 0
		table.clear(p1._byUID)
	end
}
local t3 = {
	Class = "ShadowStoreStack"
}

setmetatable(t3, {
	__index = t2
})
function t3.Reset(p1) --[[ Reset | Line: 147 | Upvalues: t2 (copy) ]]
	t2.Reset(p1)
end
function t.newStack(p1) --[[ newStack | Line: 151 | Upvalues: t3 (copy) ]]
	return setmetatable({
		_iteration = 0,
		_size = 0,
		_amount = 0,
		_parent = p1,
		_byUID = {}
	}, {
		__index = t3
	})
end

local t4 = {
	Class = "ShadowStoreType"
}

setmetatable(t4, {
	__index = t2
})
function t4.Stack(p1, p2) --[[ Stack | Line: 171 | Upvalues: t (copy) ]]
	local v1 = p1._byStack[p2]

	if not v1 then
		local v3 = t.newStack((p1._parent:Stack(p2)))

		p1._byStack[p2] = v3
		v1 = v3
	end

	return v1
end
function t4.GetStack(p1, p2) --[[ GetStack | Line: 181 | Upvalues: t (copy) ]]
	local v1 = p1._byStack[p2]

	if not v1 then
		local v2 = p1._parent:GetStack(p2)

		if v2 then
			local v3 = t.newStack(v2)

			p1._byStack[p2] = v3
			v1 = v3
		end
	end

	return v1
end
function t4.Reset(p1) --[[ Reset | Line: 193 ]]
	for k, v in pairs(p1._byStack) do
		v:Reset()
	end
end
function t.newType(p1) --[[ newType | Line: 199 | Upvalues: t4 (copy) ]]
	return setmetatable({
		_iteration = 0,
		_size = 0,
		_amount = 0,
		_parent = p1,
		_byUID = {},
		_byStack = {}
	}, {
		__index = t4
	})
end

local t5 = {
	Class = "ShadowStore"
}

setmetatable(t5, {
	__index = t2
})
function t5.Type(p1, p2) --[[ Type | Line: 220 | Upvalues: t (copy) ]]
	local v1 = p1._byType[p2]

	if not v1 then
		local v3 = t.newType((p1._parent:Type(p2)))

		p1._byType[p2] = v3
		v1 = v3
	end

	return v1
end
function t5.GetType(p1, p2) --[[ GetType | Line: 230 | Upvalues: t (copy) ]]
	local v1 = p1._byType[p2]

	if not v1 then
		local v2 = p1._parent:GetType(p2)

		if v2 then
			local v3 = t.newType(v2)

			p1._byType[p2] = v3
			v1 = v3
		end
	end

	return v1
end
function t5.Capacity(p1) --[[ Capacity | Line: 242 ]]
	return p1._capacity or p1._parent:Capacity()
end
function t5.SetCapacity(p1, p2) --[[ SetCapacity | Line: 246 | Upvalues: Asserts (copy), AbstractStore (copy) ]]
	if p2 ~= nil then
		Asserts.integer(p2)
		assert(p2 <= AbstractStore.HARD_SIZE_CAPACITY)
	end

	p1._capacity = p2
end
function t5.IsValid(p1) --[[ IsValid | Line: 255 ]]
	local _parentIteration = p1._parentIteration

	if _parentIteration and p1._parent:GetIteration() ~= _parentIteration then
		return false
	end

	return p1._parent:IsValid()
end
function t5._GetDataContainer(p1, p2) --[[ _GetDataContainer | Line: 264 | Upvalues: Types (copy) ]]
	local v1 = p1._dataByType[p2]

	if not v1 then
		Types.AssertTypeName(p2)
		v1 = {}
		p1._dataByType[p2] = v1
	end

	return v1
end
function t5.GetData(p1, p2, p3) --[[ GetData | Line: 274 | Upvalues: v1 (copy) ]]
	local v12 = p1:_GetDataContainer(p2)[p3]

	if not v12 then
		return p1._parent:GetData(p2, p3)
	end

	if v12 == v1 then
		v12 = nil
	end

	return v12
end
function t5._SetData(p1, p2, p3, p4) --[[ _SetData | Line: 285 | Upvalues: v1 (copy) ]]
	p1:_GetDataContainer(p2)[p3] = if p4 == p1._parent:GetData(p2, p3) then v1 elseif p4 then p4 else v1

	if not p1._parentIteration then
		p1._parentIteration = p1._parent:GetIteration()
	end

	p1._iteration = p1._iteration + 1
end
function t5.GetDataTable(p1) --[[ GetDataTable | Line: 293 ]]
	if next(p1._byUID) then
		local t = {}

		p1:Each(function(p1, p2) --[[ Line: 298 ]]
			local v1 = p1.Class.Name
			local v2 = p2[v1]

			if not v2 then
				v2 = {}
				p2[v1] = v2
			end

			v2[p1:GetUID()] = p1:GetData()
		end, t)

		return t
	end

	return p1._parent:GetDataTable()
end
function t5.Packet(p1) --[[ Packet | Line: 310 | Upvalues: v1 (copy) ]]
	local _byUID = p1._byUID
	local v12

	if next(_byUID) then
		local t = {}
		local t2 = {}

		for k, v in pairs(_byUID) do
			if v == v1 then
				table.insert(t, k)

				continue
			end

			local v2 = v.Class.Name
			local v3 = t2[v2]

			if not v3 then
				v3 = {}
				t2[v2] = v3
			end

			v3[k] = v:GetData()
		end

		local t3 = {}

		t3.set = if next(t2) and t2 then t2 else nil
		t3.del = if #t > 0 then t else nil
		v12 = t3
	else
		v12 = nil
	end

	return v12
end
function t5.Reset(p1) --[[ Reset | Line: 337 | Upvalues: t2 (copy) ]]
	if not next(p1._byUID) then
		return
	end

	p1._parentIteration = nil
	t2.Reset(p1)

	for k, v in pairs(p1._byType) do
		v:Reset()
	end

	for k, v in pairs(p1._dataByType) do
		table.clear(v)
	end
end
function t5.ReplicateTo(p1, p2) --[[ ReplicateTo | Line: 351 | Upvalues: v1 (copy) ]]
	for k, v in pairs(p1._byUID) do
		if v == v1 or not v then
			v = nil
		end

		p2:SetReference(k, v)
	end
end
function t5.Replicate(p1) --[[ Replicate | Line: 360 ]]
	return p1:ReplicateTo(p1._parent)
end
function t5.HasChanges(p1) --[[ HasChanges | Line: 364 ]]
	return next(p1._byUID)
end
function t5.Clone(p1) --[[ Clone | Line: 368 | Upvalues: t (copy), v1 (copy) ]]
	local v12 = t.new(p1._parent)

	for k, v in pairs(p1._byUID) do
		local v2, v3

		if v == v1 then
			v2 = k
			v3 = nil
		else
			v3 = v:Clone()

			if v3 then
				v2 = k
			else
				v2 = k
				v3 = nil
			end
		end

		v12:SetReference(v2, v3)
	end

	return v12
end
function t5.Shadow(p1) --[[ Shadow | Line: 376 | Upvalues: t (copy) ]]
	return t.new(p1)
end
t5.ClearReference = AbstractStore.ClearReference
t5.AddReference = AbstractStore.AddReference
t5.RemoveReference = AbstractStore.RemoveReference
t5.SetReference = AbstractStore.SetReference
t5.Clear = AbstractStore.Clear
t5.Add = AbstractStore.Add
t5.RemoveExact = AbstractStore.RemoveExact
t5.RemoveAny = AbstractStore.RemoveAny
t5.HasExact = AbstractStore.HasExact
t5.HasAny = AbstractStore.HasAny
t5.CountExact = AbstractStore.CountExact
t5.CountAny = AbstractStore.CountAny
t5.FindExact = AbstractStore.FindExact
t5.FindAny = AbstractStore.FindAny
function t.new(p1) --[[ new | Line: 395 | Upvalues: t5 (copy) ]]
	return setmetatable({
		_iteration = 0,
		_parentIteration = nil,
		_size = 0,
		_amount = 0,
		_parent = p1,
		_byUID = {},
		_byType = {},
		_dataByType = {}
	}, {
		__index = t5
	})
end

return t