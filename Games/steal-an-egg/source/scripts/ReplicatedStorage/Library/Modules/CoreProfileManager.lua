-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Promise = require(ReplicatedStorage.Library.Modules.Packages.Promise)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local GenerateUID = require(ReplicatedStorage.Library.Functions.GenerateUID)
local t = {}

t.__index = t
t.ProfileRemoving = Signal.new()
t.ProfileAdded = Signal.new()
function t.is(p1) --[[ is | Line: 43 | Upvalues: t (copy) ]]
	return if typeof(p1) == "table" then getmetatable(p1) == t else false
end
function t.new(p1, p2) --[[ new | Line: 47 | Upvalues: Asserts (copy), t (copy), GenerateUID (copy) ]]
	Asserts.optional.func(p2)
	Asserts.optional.table(p1)

	local v2 = setmetatable({}, t)

	v2._uuid = GenerateUID()
	v2._profileContainer = if p1 then p1 else {}
	v2._keyParser = if p2 then p2 else function(p1) --[[ Line: 56 | Upvalues: Asserts (ref) ]]
	Asserts.Player(p1)

	return p1.UserId
end

	return v2
end
function t._getValueAndKey(p1, p2) --[[ _getValueAndKey | Line: 69 ]]
	local v2 = assert(p1._keyParser(p2), "Failed to parse key for player")

	return p1._profileContainer[v2], v2
end
function t._safeChainForLoadEvent(p1, p2) --[[ _safeChainForLoadEvent | Line: 76 | Upvalues: Promise (copy), t (copy) ]]
	local v1 = select(2, p1:_getValueAndKey(p2))

	local function matchKey(p12, p2, p3) --[[ matchKey | Line: 83 | Upvalues: p1 (copy), v1 (copy) ]]
		return if p12 == p1._uuid then p2 == v1 else false
	end

	return Promise.race({ Promise.fromEvent(t.ProfileAdded, matchKey):andThen(function(p1, p2, p3) --[[ Line: 88 ]]
			return p3
		end), Promise.fromEvent(t.ProfileRemoving, matchKey):andThen(function() --[[ Line: 91 | Upvalues: Promise (ref), v1 (copy) ]]
			return Promise.reject((("Player: \"%*\", left before the profile was added."):format(v1)))
		end) })
end
function t.Get(p1, p2) --[[ Get | Line: 98 | Upvalues: Promise (copy) ]]
	local v1 = p1:_getValueAndKey(p2)

	if v1 == nil then
		return Promise.reject("Could not find the requested profile. Invalid lookup or get function"), false
	end

	return Promise.resolve(v1), true
end
function t.GetAll(p1) --[[ GetAll | Line: 108 ]]
	return table.clone(p1._profileContainer)
end
function t.GetAssert(p1, p2) --[[ GetAssert | Line: 112 ]]
	return p1:Get(p2):expect()
end
function t.GetAsync(p1, p2) --[[ GetAsync | Line: 116 ]]
	local v1 = p1:_getValueAndKey(p2)

	if v1 then
		return v1
	end

	return p1:_safeChainForLoadEvent(p2):expect()
end
function t.IsProfileRegistered(p1, p2) --[[ IsProfileRegistered | Line: 125 ]]
	return p1:_getValueAndKey(p2) and true or false
end
function t.Remove(p1, p2) --[[ Remove | Line: 129 | Upvalues: v1 (copy), t (copy) ]]
	local v12, v2 = p1:_getValueAndKey(p2)

	if v12 == nil then
		return false, v1:AtWarning():Log((("Attempt to remove an unloaded player from the profile stack: %*"):format(v2)))
	end

	t.ProfileRemoving:Fire(p1._uuid, v2, v12)
	p1._profileContainer[v2] = nil

	return true
end
function t.Set(p1, p2, ...) --[[ Set | Line: 142 | Upvalues: t (copy) ]]
	local v1, v2 = p1:_getValueAndKey(p2)

	p1._profileContainer[v2] = ...

	if not v1 then
		t.ProfileAdded:Fire(p1._uuid, v2, ...)
	end
end

return t