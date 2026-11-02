-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Items = Library:WaitForChild("Items")
local Asserts = require(Library.Asserts)
local Types = require(Items.Types)
local AbstractStore = require(script.Parent:WaitForChild("AbstractStore"))
local ShadowStore = require(script.Parent:WaitForChild("ShadowStore"))
local t = {}
local t2 = {
	Class = "SimpleStoreChild",
	GetIteration = function(p1) --[[ GetIteration | Line: 12 ]]
		return p1._iteration
	end,
	Size = function(p1) --[[ Size | Line: 16 ]]
		return p1._size
	end,
	Amount = function(p1) --[[ Amount | Line: 20 ]]
		return p1._amount
	end,
	Get = function(p1, p2) --[[ Get | Line: 24 ]]
		return p1._byUID[p2]
	end,
	_SetReference = function(p1, p2, p3) --[[ _SetReference | Line: 28 ]]
		local v1 = p1._byUID[p2]
		local _size = p1._size
		local _amount = p1._amount

		if v1 then
			_amount = _amount - v1:GetAmount()
			_size = _size - 1
		end

		if p3 then
			_amount = _amount + p3:GetAmount()
			_size = _size + 1
		end

		p1._size = _size
		p1._amount = _amount
		p1._byUID[p2] = p3
		p1._iteration = p1._iteration + 1
	end,
	All = function(p1, p2) --[[ All | Line: 49 ]]
		local _byUID = p1._byUID

		if p2 then
			_byUID = table.clone(_byUID)
		end

		return _byUID
	end,
	Each = function(p1, p2, ...) --[[ Each | Line: 59 ]]
		for k, v in pairs(p1._byUID) do
			local v1 = p2(v, ...)

			if v1 ~= nil then
				return v1
			end
		end
	end,
	IsEmpty = function(p1) --[[ IsEmpty | Line: 69 ]]
		return next(p1._byUID) == nil
	end
}
local t3 = {
	Class = "SimpleStoreStack"
}

setmetatable(t3, {
	__index = t2
})
function t.newStack() --[[ newStack | Line: 81 | Upvalues: t3 (copy) ]]
	return setmetatable({
		_iteration = 0,
		_size = 0,
		_amount = 0,
		_byUID = {}
	}, {
		__index = t3
	})
end

local t4 = {
	Class = "SimpleStoreType"
}

setmetatable(t4, {
	__index = t2
})
function t4.Stack(p1, p2) --[[ Stack | Line: 99 | Upvalues: t (copy) ]]
	local v1 = p1._byStack[p2]

	if not v1 then
		assert(type(p2) == "string")

		local v3 = t.newStack()

		p1._byStack[p2] = v3
		v1 = v3
	end

	return v1
end
function t4.GetStack(p1, p2) --[[ GetStack | Line: 112 ]]
	return p1._byStack[p2]
end
function t.newType() --[[ newType | Line: 116 | Upvalues: t4 (copy) ]]
	return setmetatable({
		_iteration = 0,
		_size = 0,
		_amount = 0,
		_byUID = {},
		_byStack = {}
	}, {
		__index = t4
	})
end

local t5 = {
	Class = "SimpleStore"
}

setmetatable(t5, {
	__index = t2
})
function t5.Type(p1, p2) --[[ Type | Line: 135 | Upvalues: Types (copy), t (copy) ]]
	local v1 = p1._byType[p2]

	if not v1 then
		Types.AssertTypeName(p2)

		local v2 = t.newType()

		p1._byType[p2] = v2
		v1 = v2
	end

	return v1
end
function t5.GetType(p1, p2) --[[ GetType | Line: 147 ]]
	return p1._byType[p2]
end
function t5.Capacity(p1) --[[ Capacity | Line: 151 ]]
	return p1._capacity
end
function t5.SetCapacity(p1, p2) --[[ SetCapacity | Line: 155 | Upvalues: Asserts (copy), AbstractStore (copy) ]]
	if p2 ~= nil then
		Asserts.integer(p2)
		assert(p2 <= AbstractStore.HARD_SIZE_CAPACITY)
	end

	p1._capacity = p2
end
function t5._GetDataContainer(p1, p2) --[[ _GetDataContainer | Line: 164 | Upvalues: Types (copy) ]]
	local v1 = p1._dataByType[p2]

	if not v1 then
		Types.AssertTypeName(p2)
		v1 = {}
		p1._dataByType[p2] = v1
	end

	return v1
end
function t5.GetData(p1, p2, p3) --[[ GetData | Line: 177 ]]
	return p1:_GetDataContainer(p2)[p3]
end
function t5._SetData(p1, p2, p3, p4) --[[ _SetData | Line: 181 ]]
	p1:_GetDataContainer(p2)[p3] = p4
	p1._iteration = p1._iteration + 1
end
function t5.GetDataTable(p1) --[[ GetDataTable | Line: 186 ]]
	return p1._dataByType
end
function t5.Packet(p1) --[[ Packet | Line: 190 ]]
	local _byUID = p1._byUID

	if not next(_byUID) then
		return nil
	end

	local t = {}

	for k, v in pairs(_byUID) do
		local v1 = v.Class.Name
		local v2 = t[v1]

		if not v2 then
			v2 = {}
			t[v1] = v2
		end

		v2[k] = v:GetData()
	end

	return {
		set = t
	}
end
function t5.Clone(p1) --[[ Clone | Line: 215 | Upvalues: t (copy) ]]
	local v1 = t.new()

	for k, v in pairs(p1._byUID) do
		v1:SetReference(v:GetUID(), v:Clone())
	end

	return v1
end
function t5.ClearReference(p1) --[[ ClearReference | Line: 225 ]]
	for k, v in pairs(p1._byUID) do
		p1:RemoveReference(v)
	end
end
function t5.Clear(p1) --[[ Clear | Line: 231 ]]
	local t = {}

	for k, v in pairs(p1._byUID) do
		p1:RemoveReference(v)
		table.insert(t, v)
	end

	return t
end
function t5.Shadow(p1) --[[ Shadow | Line: 242 | Upvalues: ShadowStore (copy) ]]
	return ShadowStore.new(p1)
end
t5.AddReference = AbstractStore.AddReference
t5.RemoveReference = AbstractStore.RemoveReference
t5.SetReference = AbstractStore.SetReference
t5.Add = AbstractStore.Add
t5.RemoveExact = AbstractStore.RemoveExact
t5.RemoveAny = AbstractStore.RemoveAny
t5.HasExact = AbstractStore.HasExact
t5.HasAny = AbstractStore.HasAny
t5.CountExact = AbstractStore.CountExact
t5.CountAny = AbstractStore.CountAny
t5.FindExact = AbstractStore.FindExact
t5.FindAny = AbstractStore.FindAny
function t.new(p1, p2) --[[ new | Line: 259 | Upvalues: t5 (copy), Types (copy) ]]
	local v1 = if p1 then p1 else {}
	local t2 = {
		_iteration = 0,
		_size = 0,
		_amount = 0,
		_capacity = nil,
		_byUID = {},
		_byType = {},
		_dataByType = v1
	}

	t2.IsValid = if p2 then p2 else function() --[[ Line: 274 ]]
	return true
end

	local v3 = setmetatable(t2, {
		__index = t5
	})

	for k, v in pairs(v1) do
		local v4 = Types.TypeUnchecked(k)

		if v4 then
			for k2, v5 in pairs(v) do
				local v52 = v4:From(v5)

				v52:SetUID(k2)
				v52:SetTracked(true)
				v3:SetReference(k2, v52)
			end
		end
	end

	return v3
end

return t