-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Items = Library:WaitForChild("Items")
local Modules = Library:WaitForChild("Modules")
local Asserts = require(Library.Asserts)
local Functions = require(Library.Functions)
local v1 = require(Modules.Event)
local Types = require(Items:WaitForChild("Types"))
local AbstractItem = require(Items.AbstractItem)
local AbstractStore = require(script.AbstractStore)
local SimpleStore = require(script.SimpleStore)
local ShadowStore = require(script.ShadowStore)
local Transaction = require(script.Transaction)
local t = {}

function t.new(p1, p2) --[[ new | Line: 20 | Upvalues: AbstractStore (copy), Asserts (copy), SimpleStore (copy), v1 (copy), t (copy) ]]
	AbstractStore.AssertOptional(p1)
	Asserts.optional.Player(p2)

	local t2 = {}

	t2._store = if p1 then p1 else SimpleStore.new()
	t2._owner = p2
	t2.Added = v1.new()
	t2.Removed = v1.new()
	t2.Deleted = v1.new()
	t2.Tracked = v1.new()
	t2.Updated = v1.new()

	return setmetatable(t2, {
		__index = t
	})
end
function t.IsA(p1) --[[ IsA | Line: 37 | Upvalues: t (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	local v1 = getmetatable(p1)

	return if typeof(v1) == "table" then v1.__index == t else false
end
function t.Destroy(p1) --[[ Destroy | Line: 47 | Upvalues: v1 (copy) ]]
	for v12, v2 in p1 do
		if v1.IsA(v2) then
			v2:Destroy()
		end
	end

	table.clear(p1)
	setmetatable(p1, nil)
end
function t.Clone(p1) --[[ Clone | Line: 59 | Upvalues: t (copy) ]]
	return t.new(p1._store:Clone(), p1._owner)
end
function t.UpdatedCallback(p1, p2, ...) --[[ UpdatedCallback | Line: 63 | Upvalues: Functions (copy), AbstractItem (copy) ]]
	local v1 = Functions.SmartPack(...)

	assert(if #v1 > 0 then true else false, "UpdatedCallback requires at least one item type")

	local t = {}

	for i, v in ipairs(v1) do
		AbstractItem.AssertModule(v)
		t[v] = p1:Type(v):GetIteration()
	end

	return p1.Updated:Connect(function(p12) --[[ Line: 73 | Upvalues: v1 (copy), p1 (copy), t (copy), p2 (copy) ]]
		local v12 = false

		for i, v in ipairs(v1) do
			local v2 = p1:Type(v):GetIteration()

			if t[v] ~= v2 then
				t[v] = v2
				v12 = true
			end
		end

		if not v12 then
			return
		end

		p2(p12)
	end)
end
function t.FireDeleted(p1, p2, p3) --[[ FireDeleted | Line: 89 ]]
	if p3 then
		p1.Deleted:FireAsync({
			{ p2, p3 }
		})

		return p1
	end

	warn("MissingItemDeletionTag", debug.traceback())
	p1.Deleted:FireAsync({
		{ p2, p3 }
	})

	return p1
end
function t.Capacity(p1) --[[ Capacity | Line: 98 ]]
	return p1._store:Capacity()
end
function t.SetCapacity(p1, p2) --[[ SetCapacity | Line: 102 ]]
	p1._store:SetCapacity(p2)

	return p1
end
function t.Transact(p1) --[[ Transact | Line: 107 | Upvalues: ShadowStore (copy), Transaction (copy) ]]
	local v1 = ShadowStore.new(p1._store)

	return Transaction.new(v1, p1._owner, function(p12) --[[ Line: 109 | Upvalues: v1 (copy), p1 (copy) ]]
		if not v1:IsValid() then
			return false
		end

		if not v1:HasChanges() then
			return true
		end

		v1:Replicate()
		p1.Updated:FireAsync(v1)

		local v12 = p12._addedItems or {}

		if #v12 > 0 then
			p1.Added:FireAsync(v12)
		end

		local v2 = p12._trackedItems or {}

		if #v2 > 0 then
			p1.Tracked:FireAsync(v2)
		end

		local v3 = p12._removedItems or {}

		if #v3 > 0 then
			p1.Removed:FireAsync(v3)
		end

		local v4 = p12._deletedItems or {}

		if not (#v4 > 0) then
			return true
		end

		p1.Deleted:FireAsync(v4)

		return true
	end)
end
function t.Store(p1) --[[ Store | Line: 139 ]]
	return p1._store
end
function t.GetDataTable(p1) --[[ GetDataTable | Line: 143 ]]
	return p1._store:GetDataTable()
end
function t.GetType(p1, p2) --[[ GetType | Line: 147 ]]
	return p1._store:GetType(p2.Class.Name)
end
function t.Type(p1, p2) --[[ Type | Line: 151 ]]
	return p1._store:Type(p2.Class.Name)
end
function t.Owner(p1) --[[ Owner | Line: 155 ]]
	return p1._owner
end
function t.Size(p1) --[[ Size | Line: 159 ]]
	return p1._store:Size()
end
function t.Amount(p1, p2) --[[ Amount | Line: 163 | Upvalues: AbstractItem (copy) ]]
	if p2 == nil or p2 == AbstractItem then
		return p1._store:Amount()
	end

	local v1 = p1._store:GetType(p2.Class.Name)

	if v1 then
		return v1:Amount()
	end

	return 0
end
function t.IsValid(p1) --[[ IsValid | Line: 176 ]]
	return p1._store:IsValid()
end
function t.Get(p1, p2, p3) --[[ Get | Line: 180 | Upvalues: AbstractItem (copy) ]]
	if p3 == nil or p3 == AbstractItem then
		return p1._store:Get(p2)
	end

	local v1 = p1._store:GetType(p3.Class.Name)

	if v1 then
		return v1:Get(p2)
	end

	return nil
end
function t.All(p1, p2) --[[ All | Line: 193 | Upvalues: AbstractItem (copy) ]]
	if p2 == nil or p2 == AbstractItem then
		return p1._store:All()
	end

	local v1 = p1._store:GetType(p2.Class.Name)

	if v1 then
		return v1:All()
	end

	return {}
end
function t.Each(p1, p2, p3, ...) --[[ Each | Line: 206 | Upvalues: AbstractItem (copy) ]]
	local v1 = nil

	if p2 == nil or p2 == AbstractItem then
		v1 = p1._store:Each(p3, ...)
	else
		local v3 = p1._store:GetType(p2.Class.Name)

		if v3 then
			return v3:Each(p3, ...)
		end
	end

	return v1
end
function t.IsEmpty(p1, p2) --[[ IsEmpty | Line: 219 | Upvalues: AbstractItem (copy) ]]
	if p2 == nil or p2 == AbstractItem then
		return p1._store:IsEmpty()
	end

	local v1 = p1._store:GetType(p2.Class.Name)

	if v1 then
		return v1:IsEmpty()
	end

	return true
end
function t.HasExact(p1, p2) --[[ HasExact | Line: 232 ]]
	return p1._store:HasExact(p2)
end
function t.HasAny(p1, p2) --[[ HasAny | Line: 236 ]]
	return p1._store:HasAny(p2)
end
function t.CountExact(p1, p2) --[[ CountExact | Line: 240 ]]
	return p1._store:CountExact(p2)
end
function t.CountAny(p1, p2) --[[ CountAny | Line: 244 ]]
	return p1._store:CountAny(p2)
end
function t.FindExact(p1, p2) --[[ FindExact | Line: 248 ]]
	return p1._store:FindExact(p2)
end
function t.FindAny(p1, p2) --[[ FindAny | Line: 252 ]]
	return p1._store:FindAny(p2)
end
function t.CollectExact(p1, ...) --[[ CollectExact | Line: 256 | Upvalues: Functions (copy), ShadowStore (copy) ]]
	local v1 = Functions.SmartPack(...)
	local v2 = ShadowStore.new(p1._store)
	local t = {}

	for i, v in ipairs(v1) do
		local v3 = v2:RemoveExact(v)

		if not v3 then
			return nil
		end

		table.move(v3, 1, #v3, #t + 1, t)
	end

	return t
end
function t.CollectAny(p1, ...) --[[ CollectAny | Line: 273 | Upvalues: Functions (copy), ShadowStore (copy) ]]
	local v1 = Functions.SmartPack(...)
	local v2 = ShadowStore.new(p1._store)
	local t = {}

	for i, v in ipairs(v1) do
		local v3 = v2:RemoveAny(v)

		if not v3 then
			return nil
		end

		table.move(v3, 1, #v3, #t + 1, t)
	end

	return t
end
function t.Clear(p1, p2, p3) --[[ Clear | Line: 288 ]]
	local v1 = p1:Transact()

	v1:Clear(p2, p3)

	return v1:Commit()
end
function t.Add(p1, p2) --[[ Add | Line: 294 ]]
	local v1 = p1:Transact()

	if v1:Add(p2) then
		return v1:Commit()
	end

	return false
end
function t.AddRelaxed(p1, p2) --[[ AddRelaxed | Line: 303 ]]
	local v1 = p1:Transact()

	if v1:AddRelaxed(p2) then
		return v1:Commit()
	end

	return false
end
function t.RemoveExact(p1, p2) --[[ RemoveExact | Line: 312 ]]
	local v1 = p1:Transact()

	if not v1:RemoveExact(p2) then
		return nil
	end

	if v1:Commit() then
		return v1._removedItems
	end

	return nil
end
function t.RemoveAny(p1, p2) --[[ RemoveAny | Line: 323 ]]
	local v1 = p1:Transact()

	if not v1:RemoveAny(p2) then
		return nil
	end

	if v1:Commit() then
		return v1._removedItems
	end

	return nil
end
function t.ApplyPacket(p1, p2) --[[ ApplyPacket | Line: 334 | Upvalues: Asserts (copy), ShadowStore (copy), Types (copy) ]]
	Asserts.table(p2)

	if not p1:IsValid() then
		return false
	end

	local t = {}
	local t2 = {}
	local v1 = ShadowStore.new(p1._store)

	if p2.del then
		for i, v in ipairs(p2.del) do
			local v2 = v1:Get(v)

			if v2 then
				v1:SetReference(v, nil)
				table.insert(t, v2)
			end
		end
	end

	if p2.set then
		for k, v in pairs(p2.set) do
			local v3 = Types.TypeUnchecked(k)

			if v3 then
				for k2, v2 in pairs(v) do
					local v4 = v3:From(v2)

					v4:SetUID(k2)
					v4:SetTracked(true)

					local v5 = v1:Get(k2)

					if v5 then
						table.insert(t, v5)
					end

					v1:SetReference(k2, v4)
					table.insert(t2, v4)
				end
			end
		end
	end

	if not v1:HasChanges() then
		return true
	end

	v1:Replicate()
	p1.Updated:FireAsync(v1)

	if #t > 0 then
		p1.Removed:FireAsync(t)
	end

	if not (#t2 > 0) then
		return true
	end

	p1.Added:FireAsync(t2)

	return true
end

return t