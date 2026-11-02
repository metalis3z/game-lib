-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Items = Library:WaitForChild("Items")
local Functions = require(Library.Functions)
local Asserts = require(Library.Asserts)
local AbstractItem = require(Items.AbstractItem)
local AbstractStore = require(script.Parent:WaitForChild("AbstractStore"))
local ShadowStore = require(script.Parent:WaitForChild("ShadowStore"))
local t = {}

function t.new(p1, p2, p3) --[[ new | Line: 11 | Upvalues: AbstractStore (copy), Asserts (copy), t (copy) ]]
	AbstractStore.Assert(p1)
	Asserts.optional.Player(p2)
	assert(type(p3) == "function", "Commit callback must be a function")

	return setmetatable({
		_commitAttempted = false,
		_commitSuccess = false,
		_store = p1,
		_owner = p2,
		_commitCallback = p3,
		_addedSeen = {},
		_addedItems = {},
		_trackedItems = {},
		_removedItems = {}
	}, {
		__index = t
	})
end
function t.Store(p1) --[[ Store | Line: 29 ]]
	assert(not p1._commitAttempted)

	return p1._store
end
function t.GetType(p1, p2) --[[ GetType | Line: 34 ]]
	assert(not p1._commitAttempted)

	return p1._store:GetType(p2.Class.Name)
end
function t.Type(p1, p2) --[[ Type | Line: 39 ]]
	assert(not p1._commitAttempted)

	return p1._store:Type(p2.Class.Name)
end
function t.Owner(p1) --[[ Owner | Line: 44 ]]
	return p1._owner
end
function t.Size(p1) --[[ Size | Line: 48 ]]
	assert(not p1._commitAttempted)

	return p1._store:Size()
end
function t.Amount(p1, p2) --[[ Amount | Line: 53 | Upvalues: AbstractItem (copy) ]]
	assert(not p1._commitAttempted)

	if p2 == nil or p2 == AbstractItem then
		return p1._store:Amount()
	end

	local v2 = p1._store:GetType(p2.Class.Name)

	return if v2 then v2:Amount() or 0 else 0
end
function t.IsValid(p1) --[[ IsValid | Line: 63 ]]
	if p1._commitAttempted then
		return false
	end

	return p1._store:IsValid()
end
function t.IsCommitAttempted(p1) --[[ IsCommitAttempted | Line: 70 ]]
	return p1._commitAttempted
end
function t.IsCommitSuccess(p1) --[[ IsCommitSuccess | Line: 74 ]]
	return p1._commitSuccess
end
function t.GetAddedItems(p1) --[[ GetAddedItems | Line: 78 ]]
	return p1._addedItems
end
function t.GetTrackedItems(p1) --[[ GetTrackedItems | Line: 82 ]]
	return p1._trackedItems
end
function t.GetRemovedItems(p1) --[[ GetRemovedItems | Line: 86 ]]
	return p1._removedItems
end
function t.Get(p1, p2, p3) --[[ Get | Line: 90 | Upvalues: AbstractItem (copy) ]]
	assert(not p1._commitAttempted)

	if p3 == nil or p3 == AbstractItem then
		return p1._store:Get(p2)
	end

	local v2 = p1._store:GetType(p3.Class.Name)

	return if v2 then v2:Get(p2) or nil else nil
end
function t.All(p1, p2) --[[ All | Line: 100 | Upvalues: AbstractItem (copy) ]]
	assert(not p1._commitAttempted)

	if p2 == nil or p2 == AbstractItem then
		return p1._store:All()
	end

	local v2 = p1._store:GetType(p2.Class.Name)

	return if v2 then v2:All() or {} else {}
end
function t.Each(p1, p2, p3, ...) --[[ Each | Line: 110 | Upvalues: AbstractItem (copy) ]]
	assert(not p1._commitAttempted)

	if p2 == nil or p2 == AbstractItem then
		return p1._store:Each(p3, ...)
	end

	local v2 = p1._store:GetType(p2.Class.Name)

	return if v2 then v2:Each(p3, ...) or nil else nil
end
function t.IsEmpty(p1, p2) --[[ IsEmpty | Line: 120 | Upvalues: AbstractItem (copy) ]]
	assert(not p1._commitAttempted)

	if p2 == nil or p2 == AbstractItem then
		return p1._store:IsEmpty()
	end

	local v2 = p1._store:GetType(p2.Class.Name)

	if v2 then
		return v2:IsEmpty()
	end

	return true
end
function t.HasExact(p1, p2) --[[ HasExact | Line: 130 ]]
	assert(not p1._commitAttempted)

	return p1._store:HasExact(p2)
end
function t.HasAny(p1, p2) --[[ HasAny | Line: 135 ]]
	assert(not p1._commitAttempted)

	return p1._store:HasAny(p2)
end
function t.CountExact(p1, p2) --[[ CountExact | Line: 140 ]]
	assert(not p1._commitAttempted)

	return p1._store:CountExact(p2)
end
function t.CountAny(p1, p2) --[[ CountAny | Line: 145 ]]
	assert(not p1._commitAttempted)

	return p1._store:CountAny(p2)
end
function t.CollectExact(p1, ...) --[[ CollectExact | Line: 150 | Upvalues: Functions (copy), ShadowStore (copy) ]]
	assert(not p1._commitAttempted)

	local v2 = Functions.SmartPack(...)
	local v3 = ShadowStore.new(p1._store)
	local t = {}

	for i, v in ipairs(v2) do
		local v4 = v3:RemoveExact(v)

		if not v4 then
			return nil
		end

		table.move(v4, 1, #v4, #t + 1, t)
	end

	return t
end
function t.CollectAny(p1, ...) --[[ CollectAny | Line: 165 | Upvalues: Functions (copy), ShadowStore (copy) ]]
	assert(not p1._commitAttempted)

	local v2 = Functions.SmartPack(...)
	local v3 = ShadowStore.new(p1._store)
	local t = {}

	for i, v in ipairs(v2) do
		local v4 = v3:RemoveAny(v)

		if not v4 then
			return nil
		end

		table.move(v4, 1, #v4, #t + 1, t)
	end

	return t
end
function t.FindExact(p1, p2) --[[ FindExact | Line: 181 ]]
	assert(not p1._commitAttempted)

	return p1._store:FindExact(p2)
end
function t.FindAny(p1, p2) --[[ FindAny | Line: 186 ]]
	assert(not p1._commitAttempted)

	return p1._store:FindAny(p2)
end
function t.Clear(p1) --[[ Clear | Line: 191 ]]
	assert(not p1._commitAttempted)

	local v2 = p1._store:Clear()

	table.move(v2, 1, #v2, #p1._removedItems + 1, p1._removedItems)

	return v2
end

local function AddGeneric(p1, p2, p3) --[[ AddGeneric | Line: 198 ]]
	assert(not p1._commitAttempted)

	local v2, v3 = p1._store:Add(p2, p1._owner, p3)

	if not v2 then
		return false
	end

	local v4 = p2:GetUID()

	if p1._addedSeen[v4] then
		local v5 = warn
		local v6 = tostring(p2)
		local v7 = debug.traceback()

		v5(("[DupeDetector] [Transaction.Add] %s %s %s"):format(v6, v7, (tostring(_G.DupeDetectorTraceback))))

		return false
	end

	p1._addedSeen[v4] = true
	table.insert(p1._addedItems, p2)

	if not v3 then
		return true
	end

	table.insert(p1._trackedItems, p2)

	return true
end

function t.Add(p1, p2) --[[ Add | Line: 227 | Upvalues: AddGeneric (copy) ]]
	return AddGeneric(p1, p2)
end
function t.AddRelaxed(p1, p2) --[[ AddRelaxed | Line: 231 | Upvalues: AddGeneric (copy) ]]
	return AddGeneric(p1, p2, true)
end
function t.RemoveExact(p1, p2) --[[ RemoveExact | Line: 235 ]]
	assert(not p1._commitAttempted)

	local v2 = p1._store:RemoveExact(p2)

	if v2 then
		if not p2:IsExchangeBlacklisted() then
			table.move(v2, 1, #v2, #p1._removedItems + 1, p1._removedItems)

			return v2
		end

		for i, v in ipairs(v2) do
			local v3 = v:Clone():SetExchangeBlacklisted(true)

			table.insert(p1._removedItems, v3:Freeze())
		end
	end

	return v2
end
function t.RemoveAny(p1, p2) --[[ RemoveAny | Line: 251 ]]
	assert(not p1._commitAttempted)

	local v2 = p1._store:RemoveAny(p2)

	if v2 then
		if not p2:IsExchangeBlacklisted() then
			table.move(v2, 1, #v2, #p1._removedItems + 1, p1._removedItems)

			return v2
		end

		for i, v in ipairs(v2) do
			local v3 = v:Clone():SetExchangeBlacklisted(true)

			table.insert(p1._removedItems, v3:Freeze())
		end
	end

	return v2
end
function t.Commit(p1) --[[ Commit | Line: 267 ]]
	assert(not p1._commitAttempted)
	p1._commitAttempted = true

	local v2 = p1._commitCallback(p1)

	p1._commitSuccess = v2

	return v2
end

return t