-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = script.Resources
local Library = ReplicatedStorage.Library
local Packages = Library.Modules.Packages
local Promise = require(Packages.Promise)
local Signal = require(Packages.Signal)
local Log = require(Packages.Log)
local Asserts = require(Library.Asserts)
local Flags = require(Library.Modules.Flags)
local Constants = require(script.Private.Constants)
local v1 = Log.new():LimitUnderLevel("Debug")
local Types = require(script.Private.Types)
local TableUtil = require(Library.Modules.Packages.TableUtil)
local States = require(script.Private.States)
local t = {}

t.__index = t
function t._optionCallModifier(p1, p2, ...) --[[ _optionCallModifier | Line: 50 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	local v1 = p1.Modifiers[p2]

	if typeof(v1) == "function" then
		return v1(p1, ...)
	end
end
function t._processBatchQueue(p1) --[[ _processBatchQueue | Line: 67 | Upvalues: v1 (copy), States (copy), ContentProvider (copy), Promise (copy) ]]
	local count = 0

	while #p1.BatchQueue ~= 0 do
		local count2 = 0
		local v12 = os.clock()

		count = count + 1
		v1:AtTrace():Log((("Processing batch queue: counter: %*, smear counter: %*"):format(count, count2)))

		local t = {}
		local t2 = {}
		local v3 = false

		for i = math.min(p1.CONSTANTS.BATCH_THRESHOLD, #p1.BatchQueue), 1, -1 do
			local v4 = table.remove(p1.BatchQueue, i)

			count2 = count2 + 1
			v1:AtTrace():Log("processing batch queu packet. Found cache packet in batch quue:", v4)

			if v4 and not v4._resolvedAndFlushed then
				v4._flags:Add(States.LOADING)
				table.insert(t, v4)
				table.insert(t2, v4._trackedInstance)

				if not (count2 < p1.CONSTANTS.INNER_SMEAR_THRESHOLD) then
					task.wait()
					count2 = 0
				end
			end
		end

		v1:AtTrace():Log(("finalized first batch operation, smear counter is at: %*"):format(count2), "(preload queue):", t2, "(resovleQueue):", t)

		local v5 = p1.CONSTANTS.PRELOAD_TIMEOUT + #t2 * p1.CONSTANTS.AVERAGE_TIME_PER_ITEM
		local v6 = nil

		local function tryPreload(p1) --[[ tryPreload | Line: 110 | Upvalues: ContentProvider (ref), t2 (copy), v6 (ref) ]]
			ContentProvider:PreloadAsync(t2, function(p1, p2) --[[ Line: 111 | Upvalues: v6 (ref) ]]
				v6 = p2
			end)
			p1()
		end

		Promise.retryWithDelay(function() --[[ Line: 117 | Upvalues: Promise (ref), tryPreload (copy) ]]
			return Promise.new(tryPreload)
		end, p1.CONSTANTS.RETRY_THRESHOLD, p1.CONSTANTS.RETRY_DELAY):timeout(v5, (("Retry timeout for preload work. (timeoutValue): %*, numItems: %*"):format(v5, #t2))):catch(function(p1) --[[ Line: 121 | Upvalues: v3 (ref), v1 (ref), v6 (ref) ]]
			v3 = p1
			v1:AtError():Log((("Failed to batch process even after many trials, last fetch status: %*, err: %*"):format(v6, p1)))
		end):await()

		for v7, v8 in t do
			v8._flags:Add(States.LOADED)

			if v3 then
				v8._flags:Add(States.FAILED)
				v8._deferredStack.reject(v8._trackedInstance, "Failed to preload the instance with error:", v3)
				v1:AtError():Log(("Couldn\'t preload the animations even after preload: counter: %*, smear: %*"):format(count, count2), "the cache that was processed:", v8)
				p1:_optionCallModifier("OnPreloadFail", v8, count, count2)

				continue
			end

			v8._deferredStack.resolve(v8._trackedInstance)
			p1:_optionCallModifier("OnPreloadSuccess", v8, count, count2)

			if not v8._preserveOnFailure then
				v8._resolvedAndFlushed = true
				v8._loadingPromise = nil
				v8._preserveOnFailure = nil
				v8._flags = v8._preserveStateFlags and v8._flags or nil
				v8._deferredStack = nil
			end
		end

		v1:AtTrace():Log(("Completed animation preload cycle in %*ms, for:"):format((os.clock() - v12) * 1000), t2)

		if not (count < p1.CONSTANTS.GLOBAL_COUNTER_THRESHOLD) then
			task.wait()
			count = 0
		end
	end

	p1.BatchScheduled = false
end
function t._enqueue(p1, p2, p3, p4) --[[ _enqueue | Line: 176 | Upvalues: Asserts (copy), v1 (copy), States (copy) ]]
	Asserts.optional.number(p4)
	p1.InstanceCache[p3] = p2
	table.insert(p1.BatchQueue, p2)

	if #p1.BatchQueue >= p1.CONSTANTS.BATCH_THRESHOLD and not p1.BatchScheduled then
		v1:AtTrace():Log("Batch queu already filled the threashold, spawning hte process instnaly and not waiting for the the delay:", p1.BatchQueue)
		p1.BatchScheduled = true
		task.spawn(p1._processBatchQueue, p1)

		return
	end

	if p1.BatchScheduled then
		return
	end

	v1:AtTrace():Log("Batch quue is emtpy so instantly scheduling work while waiting for the queu to fill up more to catch more nodes:", p1.BatchQueue)
	p1.BatchScheduled = true
	p2._flags:Add(States.WAITING_FOR_BATCH)

	local v12 = task.delay

	v12(if p4 then p4 else p1.CONSTANTS.BATCH_DELAY, p1._processBatchQueue, p1)
end
function t._selectResults(p1, p2, p3) --[[ _selectResults | Line: 204 | Upvalues: v1 (copy) ]]
	if p1 == "Promise" then
		return p2
	end

	if p1 == "CachePacket" then
		return p3
	end

	if p1 == "TrackedInstance" then
		return if p3 then p3._trackedInstance else p3
	end

	if p2 and p3 then
		return { p2, p3 }
	end

	v1:AtWarning():Log("PipelineBuilder cannot successful guess teh selected result, invalid parameters/")
end
function t.GetPromisePacketFromId(p1, p2, p3, p4) --[[ GetPromisePacketFromId | Line: 227 | Upvalues: Asserts (copy), v1 (copy), Signal (copy), Promise (copy), States (copy), Flags (copy) ]]
	Asserts.string(p2)

	local v12 = p1.InstanceCache[p2]

	v1:AtTrace():Log("(GetPromisePacketFromId): cache:", v12)

	if v12 then
		if Signal.Is(v12) then
			v1:AtTrace():Log("cache is already acquired, waiting for tthe hanlder to releases it")

			local v2 = v12:Wait()

			v1:AtTrace():Log("cache found after signal yield, meanign that many systems were getting the same asset id:", v2)

			if v2 and not Promise.is(v2) then
				v12 = v2
			else
				return v2
			end
		else
			if not (v12._flags and v12._flags:Has(States.LOADED) or v12._resolvedAndFlushed) then
				v1:AtTrace():Log("cache foudn but not in a special state meanign that alreayd processing so waiting for process to complete:", v12)

				return v12._loadingPromise, v12
			end

			v1:AtTrace():Log("cache already loaded, isntnaly resolving with the cache instate:", v12)

			return Promise.resolve(v12._trackedInstance), v12
		end

		v1:AtTrace():Log("cache foudn but not in a special state meanign that alreayd processing so waiting for process to complete:", v12)

		return v12._loadingPromise, v12
	end

	local v4 = Signal.new()

	p1.InstanceCache[p2] = v4

	local v5 = p1.Modifiers.PrepareInstance(p1, p2)

	if typeof(v5) == "Instance" then
		local t = {
			_resolvedAndFlushed = false,
			_trackedInstance = v5,
			_assetId = p2,
			_flags = Flags.new(),
			_deferredStack = {},
			_preserveStateFlags = p3,
			_preserveOnFailure = p4
		}

		t._loadingPromise = Promise.new(function(p1, p2, p3) --[[ Line: 280 | Upvalues: t (copy) ]]
			t._deferredStack.resolve = p1
			t._deferredStack.reject = p2
			t._deferredStack.onCancel = p3
		end):catch(function(p1) --[[ Line: 284 | Upvalues: v1 (ref) ]]
			v1:AtWarning("Loading promise errored, couldn\'t successfully resolve the deferred stack with:", p1)
		end)
		v1:AtTrace():Log("Creating brand new cache structure with its related animation:", v12)
		t._flags:Add(States.INITIALIZED)
		p1:_enqueue(t, p2)
		v4:Fire(t)
		task.delay(4, function() --[[ Line: 296 | Upvalues: v4 (copy), v1 (ref) ]]
			if v4 then
				v4:Destroy()
				v1:AtTrace():Log("lock marker resolved and destroyed, it will be GCed")
			end
		end)

		return t._loadingPromise, t
	end

	local v6 = Promise.reject("Invalid instance class returned by the prepare function")

	v4:Fire(v6)

	return v6
end
function t.CollectRawResults(p1, p2, p3) --[[ CollectRawResults | Line: 311 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.string(p3)

	if typeof(p2) == "table" then
		local t = {}

		for v12, v2 in p2 do
			local v3 = p1:CollectRawResults(v2, p3)

			if v3 then
				table.insert(t, v3)
			end
		end

		return t, "Batched"
	end

	local v4 = p1._selectResults(p3, p1:GetPromisePacketFromId(p2))

	if v4 then
		return v4
	end

	return v1:AtError():Log((("Failed to get one of the results guided by %*"):format(p3)))
end
function t.RushGetTrackedInstance(p1, p2) --[[ RushGetTrackedInstance | Line: 341 ]]
	return assert(p1:CollectRawResults(p2, "TrackedInstance"))
end
function t.RushGetTrackedPromises(p1, p2) --[[ RushGetTrackedPromises | Line: 352 ]]
	return p1:CollectRawResults(p2, "Promise")
end
function t.GetPackageAfterPreload(p1, p2) --[[ GetPackageAfterPreload | Line: 363 | Upvalues: Promise (copy) ]]
	local v1, v2 = p1:CollectRawResults(p2, "Promise")
	local v3 = if v2 == "Batched" and v1 then v1 else { v1 }

	if typeof(v3) == "table" then
		return Promise.some(v3, #v3)
	end

	return Promise.reject("Failed to retrieve the promise list from cache")
end
function t.GetTrackedAfterPreloadAwait(p1, p2) --[[ GetTrackedAfterPreloadAwait | Line: 378 ]]
	return p1:GetPackageAfterPreload(p2):await()
end
function t.GetTrackedAfterPreloadAsync(p1, p2) --[[ GetTrackedAfterPreloadAsync | Line: 389 ]]
	return p1:GetPackageAfterPreload(p2):expect()
end
function t.create(p1) --[[ create | Line: 397 | Upvalues: Types (copy), Resources (copy), TableUtil (copy), Constants (copy), States (copy), t (copy) ]]
	assert(Types.Create(p1))

	local t2 = {
		BatchScheduled = false
	}

	t2.Modifiers = p1.Modifiers or {}
	t2.Resources = p1.Resources or Resources
	t2.CONSTANTS = TableUtil.Reconcile(p1.Constants or {}, Constants)
	t2.States = p1.States or States
	t2.InstanceCache = {}
	t2.BatchQueue = {}

	return setmetatable(t2, {
		__index = t
	})
end

return t