--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

game:GetService("Players")
assert(RunService:IsClient())

local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local SharedFastFlags = require(ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local DeepEqualsPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe)
local DeepCopyPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)
local ObjectPaths = require(ReplicatedStorage.UserGenerated.Strings.ObjectPaths)
local t = {}
local v1 = table.freeze({
	__index = t
})

function t.Get(p1) --[[ Get | Line: 48 ]]
	return p1.Value
end
function t.GetAsync(p1) --[[ GetAsync | Line: 51 ]]
	if not p1.ValueLoaded then
		local v1 = coroutine.running()
		local v2 = p1.Loaded:Connect(function() --[[ Line: 56 | Upvalues: v1 (copy) ]]
			task.spawn(v1)
		end)

		coroutine.yield()
		v2:Disconnect()
	end

	return p1.Value
end
function t.IsLoaded(p1) --[[ IsLoaded | Line: 63 ]]
	return p1.ValueLoaded
end

local function IsA(p1) --[[ IsA | Line: 67 | Upvalues: v1 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == v1 else false
end

local function Assert(p1) --[[ Assert | Line: 71 | Upvalues: v1 (copy) ]]
	if if type(p1) == "table" then if getmetatable(p1) == v1 then true else false else false then
		return p1
	end

	error("FastFlag", 2)
end

table.freeze(t)

local NullValue = SharedFastFlags.NullValue
local t2 = {}
local v2 = false
local t3 = {}
local v3 = Bindable.new()

local function DecodeValue(p1) --[[ DecodeValue | Line: 89 | Upvalues: NullValue (copy) ]]
	if p1 == NullValue then
		return nil
	end

	return p1
end

local function SetContent(p1, p2) --[[ SetContent | Line: 93 | Upvalues: DeepFreezeUnsafe (copy), t3 (ref), t2 (copy), NullValue (copy), DeepEqualsPureUnsafe (copy), v2 (ref), v3 (copy) ]]
	DeepFreezeUnsafe(p1)
	t3 = p1

	local list = {}
	local list2 = {}

	for k, v in pairs(p1) do
		local v1 = t2[k]

		if v1 then
			local v22 = if v == NullValue then nil else v
			local v32 = v1.Value

			if not DeepEqualsPureUnsafe(v22, v32) then
				v1.Value = v22
				table.insert(list, {
					instance = v1,
					value = v22,
					prevValue = v32
				})
			end

			if p2 and not v1.ValueLoaded then
				v1.ValueLoaded = true
				table.insert(list2, v1)
			end
		end
	end

	local v4 = if p2 then not v2 else p2

	if v4 then
		v2 = true
	end

	for i, v in ipairs(list2) do
		v.Loaded:Fire()
	end

	if v4 then
		v3:Fire()
	end

	for i, v in ipairs(list) do
		v.instance.Changed:Fire(v.value, v.prevValue)
	end
end

local function Create(p1, p2, p3) --[[ Create | Line: 141 | Upvalues: Asserts (copy), DeepCopyPureUnsafe (copy), DeepFreezeUnsafe (copy), t2 (copy), ObjectPaths (copy), t3 (ref), NullValue (copy), v2 (ref), Bindable (copy), v1 (copy) ]]
	Asserts.String(p1)
	Asserts.Function(p2)
	p2(p3)
	Asserts.Storable(p3)

	local v12 = DeepCopyPureUnsafe(p3)

	DeepFreezeUnsafe(v12)
	assert(not t2[p1], (("ConflictingKeys: %*, %*"):format(p1, p1)))

	local v4 = v12

	for k, v in pairs(t2) do
		if ObjectPaths.HasHierarchicalOverlap(p1, k) then
			error((("ConflictingKeys: %*, %*"):format(p1, k)))
		end
	end

	local v5 = t3[p1]
	local v6, v7

	if v5 == nil then
		v6 = false
		v7 = v4
	else
		v7 = if v5 == NullValue then nil else v5
		v6 = v2
	end

	local v9 = setmetatable({
		Replicated = true,
		Changed = Bindable.new(),
		Loaded = Bindable.new(),
		Key = p1,
		DefaultValue = v4,
		Assertion = p2,
		ValueLoaded = v6,
		Value = v7
	}, v1)

	t2[p1] = v9

	return v9
end

local t4 = {
	Loaded = v3,
	IsA = IsA,
	Assert = Assert,
	Replicated = function(p1, p2, p3) --[[ Replicated | Line: 197 | Upvalues: Create (copy) ]]
		return Create(p1, p2, p3)
	end,
	Private = function(p1, p2, p3) --[[ Private | Line: 205 ]]
		error("ServerOnly")
	end,
	Get = function(p1) --[[ Get | Line: 213 | Upvalues: t2 (copy), Asserts (copy) ]]
		local v1 = t2[p1]

		if v1 then
			return v1
		end

		Asserts.String(p1)
		error((("UnknownKey: \'%*\'"):format(p1)))
	end,
	IsLoaded = function() --[[ IsLoaded | Line: 224 | Upvalues: v2 (ref) ]]
		return v2
	end
}

SharedFastFlags.UpdateRemote.OnClientEvent:Connect(SetContent)
table.freeze(t4)

return t4