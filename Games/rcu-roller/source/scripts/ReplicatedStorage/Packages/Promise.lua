--[[
	Promise - evaera-compatible implementation for Knit/Roblox Luau
	API-compatible with evaera/promise v4 as used by Knit framework.
	No decompiler artifacts. Clean implementation.
--]]

local Promise = {}
Promise.__index = Promise

-- Status enum
Promise.Status = {
	Started   = "Started",
	Resolved  = "Resolved",
	Rejected  = "Rejected",
	Cancelled = "Cancelled",
}

-- Internal sentinel for cancellation
local CANCEL_SENTINEL = {}

------------------------------------------------------------------------
-- Internal constructor (raw, no executor)
------------------------------------------------------------------------
local function newPromise()
	local self = setmetatable({}, Promise)
	self._status      = Promise.Status.Started
	self._values      = nil   -- resolved/rejected values (table)
	self._callbacks   = {}    -- { onResolved, onRejected }
	self._cancelFn    = nil   -- optional cancel callback set by executor
	self._cancelled   = false
	return self
end

------------------------------------------------------------------------
-- Internal resolve/reject helpers
------------------------------------------------------------------------
local function runCallbacks(promise)
	local callbacks = promise._callbacks
	promise._callbacks = {}
	for _, cb in ipairs(callbacks) do
		task.spawn(cb, promise._status, promise._values)
	end
end

local function resolvePromise(promise, values)
	if promise._status ~= Promise.Status.Started then return end
	promise._status = Promise.Status.Resolved
	promise._values = values
	runCallbacks(promise)
end

local function rejectPromise(promise, values)
	if promise._status ~= Promise.Status.Started then return end
	promise._status = Promise.Status.Rejected
	promise._values = values
	runCallbacks(promise)
end

local function cancelPromise(promise)
	if promise._status ~= Promise.Status.Started then return end
	promise._cancelled = true
	promise._status = Promise.Status.Cancelled
	promise._values = {}
	if promise._cancelFn then
		pcall(promise._cancelFn)
	end
	-- fire callbacks so chained promises can propagate
	runCallbacks(promise)
end

------------------------------------------------------------------------
-- Promise.new(executor)
-- executor: function(resolve, reject, onCancel)
------------------------------------------------------------------------
function Promise.new(executor)
	local self = newPromise()

	local function resolve(...)
		resolvePromise(self, { ... })
	end

	local function reject(...)
		rejectPromise(self, { ... })
	end

	local function onCancel(cancelFn)
		self._cancelFn = cancelFn
		-- returns whether already cancelled
		return self._cancelled
	end

	task.spawn(function()
		local ok, err = pcall(executor, resolve, reject, onCancel)
		if not ok then
			rejectPromise(self, { err })
		end
	end)

	return self
end

------------------------------------------------------------------------
-- Promise.resolve(value, ...)
------------------------------------------------------------------------
function Promise.resolve(...)
	local args = { ... }
	return Promise.new(function(resolve)
		resolve(table.unpack(args))
	end)
end

------------------------------------------------------------------------
-- Promise.reject(reason, ...)
------------------------------------------------------------------------
function Promise.reject(...)
	local args = { ... }
	return Promise.new(function(_, reject)
		reject(table.unpack(args))
	end)
end

------------------------------------------------------------------------
-- Promise.try(fn, ...)  — wraps a function call in a promise
------------------------------------------------------------------------
function Promise.try(fn, ...)
	local args = { ... }
	return Promise.new(function(resolve, reject)
		local results = table.pack(pcall(fn, table.unpack(args)))
		if results[1] then
			-- shift out the pcall boolean
			resolve(table.unpack(results, 2, results.n))
		else
			reject(results[2])
		end
	end)
end

------------------------------------------------------------------------
-- Promise.delay(seconds)
------------------------------------------------------------------------
function Promise.delay(seconds)
	return Promise.new(function(resolve, _, onCancel)
		local cancelled = false
		onCancel(function()
			cancelled = true
		end)
		task.delay(seconds, function()
			if not cancelled then
				resolve(seconds)
			end
		end)
	end)
end

------------------------------------------------------------------------
-- Promise.fromEvent(signal, predicate?)
-- Resolves with the first fire of signal that passes predicate (if any).
------------------------------------------------------------------------
function Promise.fromEvent(signal, predicate)
	return Promise.new(function(resolve, _, onCancel)
		local connection
		local cancelled = false

		onCancel(function()
			cancelled = true
			if connection then
				connection:Disconnect()
			end
		end)

		connection = signal:Connect(function(...)
			if cancelled then return end
			if predicate == nil or predicate(...) then
				connection:Disconnect()
				resolve(...)
			end
		end)
	end)
end

------------------------------------------------------------------------
-- Promise.all(promises)
-- Resolves with array of all resolved values, or rejects on first rejection.
------------------------------------------------------------------------
function Promise.all(promises)
	if #promises == 0 then
		return Promise.resolve({})
	end

	return Promise.new(function(resolve, reject, onCancel)
		local results  = {}
		local remaining = #promises
		local settled   = false

		onCancel(function()
			for _, p in ipairs(promises) do
				p:cancel()
			end
		end)

		for i, promise in ipairs(promises) do
			promise:andThen(
				function(...)
					if settled then return end
					results[i] = { ... }
					remaining -= 1
					if remaining == 0 then
						-- flatten single-value results for ergonomics
						local flat = {}
						for _, v in ipairs(results) do
							table.insert(flat, v[1])
						end
						settled = true
						resolve(flat)
					end
				end,
				function(...)
					if settled then return end
					settled = true
					reject(...)
				end
			)
		end
	end)
end

------------------------------------------------------------------------
-- Promise.allSettled(promises)
-- Always resolves with array of { status, value } / { status, reason }
------------------------------------------------------------------------
function Promise.allSettled(promises)
	if #promises == 0 then
		return Promise.resolve({})
	end

	return Promise.new(function(resolve)
		local results   = {}
		local remaining = #promises

		for i, promise in ipairs(promises) do
			promise:andThen(
				function(...)
					results[i] = { status = Promise.Status.Resolved, value = (...) }
					remaining -= 1
					if remaining == 0 then resolve(results) end
				end,
				function(...)
					results[i] = { status = Promise.Status.Rejected, reason = (...) }
					remaining -= 1
					if remaining == 0 then resolve(results) end
				end
			)
		end
	end)
end

------------------------------------------------------------------------
-- Promise.race(promises)
-- Resolves/rejects with the first promise that settles.
------------------------------------------------------------------------
function Promise.race(promises)
	return Promise.new(function(resolve, reject, onCancel)
		local settled = false

		onCancel(function()
			for _, p in ipairs(promises) do
				p:cancel()
			end
		end)

		for _, promise in ipairs(promises) do
			promise:andThen(
				function(...)
					if settled then return end
					settled = true
					resolve(...)
				end,
				function(...)
					if settled then return end
					settled = true
					reject(...)
				end
			)
		end
	end)
end

------------------------------------------------------------------------
-- Promise.is(obj)
------------------------------------------------------------------------
function Promise.is(obj)
	return type(obj) == "table" and getmetatable(obj) == Promise
end

------------------------------------------------------------------------
-- Internal: subscribe to a promise's resolution
------------------------------------------------------------------------
local function subscribe(promise, onResolved, onRejected)
	local status = promise._status
	if status == Promise.Status.Started then
		table.insert(promise._callbacks, function(resolvedStatus, values)
			if resolvedStatus == Promise.Status.Resolved then
				if onResolved then onResolved(table.unpack(values)) end
			elseif resolvedStatus == Promise.Status.Rejected then
				if onRejected then onRejected(table.unpack(values)) end
			end
			-- Cancelled: neither callback fires
		end)
	elseif status == Promise.Status.Resolved then
		if onResolved then task.spawn(onResolved, table.unpack(promise._values)) end
	elseif status == Promise.Status.Rejected then
		if onRejected then task.spawn(onRejected, table.unpack(promise._values)) end
	end
	-- Cancelled: do nothing
end

------------------------------------------------------------------------
-- promise:andThen(onResolved, onRejected?)
------------------------------------------------------------------------
function Promise:andThen(onResolved, onRejected)
	return Promise.new(function(resolve, reject, onCancel)
		onCancel(function()
			self:cancel()
		end)

		subscribe(self,
			function(...)
				if onResolved then
					local ok, result = pcall(onResolved, ...)
					if not ok then
						reject(result)
					else
						-- if the handler returned a promise, chain it
						if Promise.is(result) then
							result:andThen(resolve, reject)
						else
							resolve(result)
						end
					end
				else
					resolve(...)
				end
			end,
			function(...)
				if onRejected then
					local ok, result = pcall(onRejected, ...)
					if not ok then
						reject(result)
					else
						if Promise.is(result) then
							result:andThen(resolve, reject)
						else
							resolve(result)
						end
					end
				else
					reject(...)
				end
			end
		)
	end)
end

------------------------------------------------------------------------
-- promise:catch(onRejected)
------------------------------------------------------------------------
function Promise:catch(onRejected)
	return self:andThen(nil, onRejected)
end

------------------------------------------------------------------------
-- promise:finally(onFinally)
-- onFinally receives no arguments. Chain passes through original value.
------------------------------------------------------------------------
function Promise:finally(onFinally)
	return Promise.new(function(resolve, reject, onCancel)
		onCancel(function()
			self:cancel()
		end)

		subscribe(self,
			function(...)
				local args = { ... }
				local ok, err = pcall(onFinally)
				if not ok then
					reject(err)
				else
					resolve(table.unpack(args))
				end
			end,
			function(...)
				local args = { ... }
				local ok, err = pcall(onFinally)
				if not ok then
					reject(err)
				else
					reject(table.unpack(args))
				end
			end
		)
	end)
end

------------------------------------------------------------------------
-- promise:cancel()
------------------------------------------------------------------------
function Promise:cancel()
	cancelPromise(self)
end

------------------------------------------------------------------------
-- promise:getStatus()
------------------------------------------------------------------------
function Promise:getStatus()
	return self._status
end

------------------------------------------------------------------------
-- promise:await()
-- Yields the calling thread until the promise settles.
-- Returns: success (bool), ...values
------------------------------------------------------------------------
function Promise:await()
	local status = self._status
	if status == Promise.Status.Resolved then
		return true, table.unpack(self._values)
	elseif status == Promise.Status.Rejected then
		return false, table.unpack(self._values)
	elseif status == Promise.Status.Cancelled then
		return false
	end

	-- Still running — yield
	local thread = coroutine.running()
	subscribe(self,
		function(...)
			task.spawn(thread, true, ...)
		end,
		function(...)
			task.spawn(thread, false, ...)
		end
	)
	-- also handle cancel
	table.insert(self._callbacks, function(resolvedStatus)
		if resolvedStatus == Promise.Status.Cancelled then
			task.spawn(thread, false)
		end
	end)

	return coroutine.yield()
end

------------------------------------------------------------------------
-- promise:expect()
-- Like await but errors instead of returning false on rejection.
------------------------------------------------------------------------
function Promise:expect()
	local ok, result = self:await()
	if not ok then
		error(result, 2)
	end
	return result
end

------------------------------------------------------------------------
-- Metamethod for nice tostring
------------------------------------------------------------------------
function Promise:__tostring()
	return "Promise(" .. self._status .. ")"
end

return Promise
