-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Library.Modules.Packages.Promise)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script.Private.Types)

local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local TableInjectAutoRemovalBehavior = require(ReplicatedStorage.Library.Functions.TableInjectAutoRemovalBehavior)
local v1 = Log.new()
local t = {
	NOT_FOUND = "_stackNotFound"
}
local t2 = {
	RESOLVED = 1,
	RESOLVING = 2,
	REMOVING = 4,
	DESTROYING = 8,
	BLOCK_LISTENER = 15,
	INVALID_EXECUTABLE_RESOLVER = 6
}
local t3 = {}

t3.__index = t3
t3.__class = "DeferredListener"
t3.RESULT_STATUS = t
t3.STATE_FLAGS = t2

local t4 = {}

t4.__index = t4
t4.__class = "ExecutableStack"
function t4.new(p1, p2, p3) --[[ new | Line: 52 | Upvalues: Asserts (copy), Trove (copy), t4 (copy), TableInjectAutoRemovalBehavior (copy) ]]
	Asserts.optional.table(p1)

	local t = {
		_flags = 0,
		_stack = {},
		_subStacksContainer = {}
	}

	t._stackChainConfig = if p1 then p1 else {}
	t._trove = Trove.new()
	t._sharedListData = if p3 then p3 else {
	_masterIndex = 0
}

	local v4 = setmetatable(t, t4)

	if typeof(p2) == "table" then
		p2.object = v4

		return TableInjectAutoRemovalBehavior(p2)
	end

	return v4
end
function t3.new(p1) --[[ new | Line: 77 | Upvalues: t3 (copy) ]]
	return setmetatable({
		_destroying = false,
		_stackChainConfig = p1,
		_stackContainer = {}
	}, t3)
end
function t3._safeGetStack(p1, p2) --[[ _safeGetStack | Line: 90 | Upvalues: Asserts (copy) ]]
	Asserts.optional.string(p2)

	if p2 then
		return p1._stackContainer[p2]
	end
end
function t3.Destroy(p1) --[[ Destroy | Line: 100 ]]
	if p1._destroying then
		return
	end

	p1._destroying = true

	for v1, v2 in p1._stackContainer do
		v2:Destroy()
	end

	setmetatable(p1, nil)
	table.clear(p1)
end
function t3.GetOrCreateExecutableStack(p1, p2, p3) --[[ GetOrCreateExecutableStack | Line: 115 | Upvalues: Asserts (copy), t4 (copy) ]]
	Asserts.string(p2)

	local t = {
		removeFrom = p1._stackContainer,
		indexOverride = p2
	}
	local v1 = p1._stackContainer[p2]

	if not v1 then
		v1 = t4.new(if p3 then p3 else p1._stackChainConfig, t)
	end

	p1._stackContainer[p2] = v1
	v1._name = p2

	return p1._stackContainer[p2]
end
function t3.ResolveAll(p1, p2) --[[ ResolveAll | Line: 131 | Upvalues: Promise (copy) ]]
	local v1 = if p2 then {} else p2

	for v2, v3 in p1._stackContainer do
		local v4 = v3:ResolveAllListeners()

		if v1 and v4 then
			table.insert(v1, v4)
		end
	end

	return if v1 then Promise.all(v1) or nil else nil
end
function t3.ProxySafeInstructionsToStack(p1, p2, p3, ...) --[[ ProxySafeInstructionsToStack | Line: 145 | Upvalues: t (copy), Asserts (copy) ]]
	local v1 = p1:_safeGetStack(p3)

	if v1 then
		Asserts.string(p2)
		Asserts.func(v1[p2])

		return v1[p2](v1, ...)
	end

	return t.NOT_FOUND
end
function t4.SetFlag(p1, p2) --[[ SetFlag | Line: 163 ]]
	p1._flags = bit32.bor(p1._flags, p2)
end
function t4.ClearFlag(p1, p2) --[[ ClearFlag | Line: 167 ]]
	p1._flags = bit32.band(p1._flags, (bit32.bnot(p2)))
end
function t4.IsFlagSet(p1, p2) --[[ IsFlagSet | Line: 171 ]]
	return bit32.band(p1._flags, p2) ~= 0
end
function t4.Destroy(p1) --[[ Destroy | Line: 176 | Upvalues: t2 (copy), v1 (copy) ]]
	if p1:IsFlagSet(t2.DESTROYING) then
		return
	end

	p1:SetFlag(t2.DESTROYING)

	local v12 = os.clock()

	v1:AtTrace():Log(("stack:%* destroying it self, config:"):format(p1._name), p1._stackChainConfig)

	for v2, v3 in p1._subStacksContainer do
		if p1._stackChainConfig.resolveSubStacksOnDestroy then
			v3:ResolveAllListeners(false, true):await()

			continue
		end

		v3:Destroy()
	end

	if p1._stackChainConfig.selfResolveOnDestroy then
		p1:ResolveAllListeners():await()
	end

	v1:AtTrace():Log((("stack:%* successfully destroyed it in: %*"):format(p1._name, os.clock() - v12)))
	p1._trove:Destroy()
	setmetatable(p1, nil)

	return table.clear(p1)
end
function t4.Extend(p1, p2) --[[ Extend | Line: 205 | Upvalues: t4 (copy) ]]
	return t4.new(if p2 then p2 else p1._stackChainConfig, {
		removeFrom = p1._subStacksContainer
	}, p1._sharedListData)
end
function t4.MarkAsResolved(p1) --[[ MarkAsResolved | Line: 211 | Upvalues: t2 (copy) ]]
	p1:SetFlag(t2.RESOLVED)
end
function t4.IsStackChainEmpty(p1) --[[ IsStackChainEmpty | Line: 215 ]]
	return p1._sharedListData._masterIndex == 0
end
function t4.AddListener(p1, p2, ...) --[[ AddListener | Line: 220 | Upvalues: v1 (copy), t2 (copy) ]]
	if typeof(p2) ~= "function" then
		return v1:AtTrace():Log("registration request dropped  due to invalid parameters.")
	end

	if p1:IsFlagSet(t2.BLOCK_LISTENER) then
		return v1:AtTrace():Log((("registration request dropped due to invalid state for %*"):format(p1._name)))
	end

	v1:AtTrace():Log((("registration request successfully registered for: %*"):format(p1._name)))
	table.insert(p1._stack, {
		Packet = { ... },
		Callback = p2
	})

	local _sharedListData = p1._sharedListData

	_sharedListData._masterIndex = _sharedListData._masterIndex + 1

	return true
end
function t4.ResolveAllListeners(p1, p2, p3, ...) --[[ ResolveAllListeners | Line: 237 | Upvalues: t2 (copy), Promise (copy), v1 (copy) ]]
	if p1:IsFlagSet(t2.INVALID_EXECUTABLE_RESOLVER) then
		return Promise.reject("attempt to resolve listeners in an invalid stack state.")
	end

	if #p1._stack == 0 then
		return Promise.resolve("instantly resolved. Empty local stack.")
	end

	p1:SetFlag(t2.RESOLVING)
	v1:AtTrace():Log("successfully resolving user listeners.")

	local v12 = p1._stackChainConfig.passCustomDataToListenerWhenResolving and (if select("#", ...) == 0 then false else { ... })
	local v2 = #p1._stack
	local v3 = 0
	local throttleThreshold = p1._stackChainConfig.throttleThreshold

	return Promise.new(function(p12, p22, p3) --[[ Line: 259 | Upvalues: p1 (copy), v1 (ref), t2 (ref), v12 (copy), v3 (ref), p2 (copy), throttleThreshold (copy) ]]
		local count = 0
		local v13 = false

		p3(function() --[[ Line: 263 | Upvalues: v13 (ref), p1 (ref) ]]
			v13 = true
			table.clear(p1._stack)
		end)

		for i, v in ipairs(p1._stack) do
			if typeof(v) == "table" then
				if v13 then
					return v1:AtInfo():Log((("operation cancelled during iteration during: %*ts packet."):format(i)))
				end

				if p1:IsFlagSet(t2.REMOVING) then
					return p12(p1, "_removing")
				end

				local function processListener() --[[ processListener | Line: 279 | Upvalues: v (copy), v12 (ref), v1 (ref) ]]
					local t = {}
					local v13 = table.clone(v.Packet)

					if v12 and #v12 ~= 0 then
						table.move(v12, 1, #v12, 1, t)
						table.move(v13, 1, #v13, #t + 1, t)
					end

					local ok, result = pcall(v.Callback, unpack(t))

					if ok then
						return
					end

					v1:AtWarning():Log((("Failed to resolve database shared listener protocol: %*"):format(result)))
				end

				if p1._stackChainConfig.yieldWhenResolving then
					processListener()
				else
					task.spawn(processListener)
				end

				v3 = v3 + 1

				local _sharedListData = p1._sharedListData

				_sharedListData._masterIndex = _sharedListData._masterIndex - 1

				if not p2 and (throttleThreshold and not (throttleThreshold <= 0)) then
					count = count + 1

					if not (count < throttleThreshold) then
						task.wait(0.05)
						count = 0
					end
				end
			end
		end

		table.clear(p1._stack)

		return p12(p1, "_completed")
	end):finally(function(...) --[[ Line: 317 | Upvalues: p1 (copy), t2 (ref), v2 (copy), v3 (ref), p3 (copy) ]]
		p1:ClearFlag(t2.RESOLVING)

		local _sharedListData = p1._sharedListData

		_sharedListData._masterIndex = _sharedListData._masterIndex - (v2 - v3)

		if p3 then
			p1:Destroy()
		end

		return ...
	end):catch(function(p1) --[[ Line: 328 | Upvalues: v1 (ref) ]]
		v1:AtWarning():Log((("Failed to successfully resolve all listeners: %*"):format(p1)))
	end)
end

return t3