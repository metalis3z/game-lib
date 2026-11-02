-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	__mode = "k"
}

local function isCallable(p1) --[[ isCallable | Line: 12 ]]
	if type(p1) == "function" then
		return true
	end

	if type(p1) ~= "table" then
		return false
	end

	local v1 = getmetatable(p1)

	if not v1 then
		return false
	end

	if type((rawget(v1, "__call"))) == "function" then
		return true
	end

	return false
end

local function makeEnum(p1, p2) --[[ makeEnum | Line: 30 ]]
	local t = {}

	for i, v in ipairs(p2) do
		t[v] = v
	end

	return setmetatable(t, {
		__index = function(p12, p2) --[[ __index | Line: 38 | Upvalues: p1 (copy) ]]
			error(string.format("%s is not in %s!", p2, p1), 2)
		end,
		__newindex = function() --[[ __newindex | Line: 41 | Upvalues: p1 (copy) ]]
			error(string.format("Creating new members in %s is not allowed!", p1), 2)
		end
	})
end

local t2 = {
	Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
}

t2.__index = t2
function t2.new(p1, p2) --[[ new | Line: 66 | Upvalues: t2 (ref) ]]
	local v1 = if p1 then p1 else {}
	local t = {}

	t.error = tostring(v1.error) or "[This error has no error text.]"
	t.trace = v1.trace
	t.context = v1.context
	t.kind = v1.kind
	t.parent = p2
	t.createdTick = os.clock()
	t.createdTrace = debug.traceback()

	return setmetatable(t, t2)
end
function t2.is(p1) --[[ is | Line: 79 ]]
	if type(p1) ~= "table" then
		return false
	end

	local v1 = getmetatable(p1)

	if type(v1) ~= "table" then
		return false
	end

	return if rawget(p1, "error") == nil then false else type((rawget(v1, "extend"))) == "function"
end
function t2.isKind(p1, p2) --[[ isKind | Line: 91 | Upvalues: t2 (ref) ]]
	assert(if p2 == nil then false else true, "Argument #2 to Promise.Error.isKind must not be nil")

	return t2.is(p1) and p1.kind == p2
end
function t2.extend(p1, p2) --[[ extend | Line: 97 | Upvalues: t2 (ref) ]]
	local v1 = if p2 then p2 else {}

	v1.kind = v1.kind or p1.kind

	return t2.new(v1, p1)
end
function t2.getErrorChain(p1) --[[ getErrorChain | Line: 105 ]]
	local t = { p1 }

	while t[#t].parent do
		table.insert(t, t[#t].parent)
	end

	return t
end
function t2.__tostring(p1) --[[ __tostring | Line: 115 ]]
	local t = { string.format("-- Promise.Error(%s) --", p1.kind or "?") }

	for i, v in ipairs(p1:getErrorChain()) do
		local concat = table.concat
		local t2 = {}

		t2[1] = v.trace or v.error
		t2[2] = v.context
		table.insert(t, concat(t2, "\n"))
	end

	return table.concat(t, "\n")
end

local function pack(...) --[[ pack | Line: 139 ]]
	return select("#", ...), { ... }
end

local function packResult(p1, ...) --[[ packResult | Line: 146 ]]
	return p1, select("#", ...), { ... }
end

local function makeErrorHandler(p1) --[[ makeErrorHandler | Line: 150 | Upvalues: t2 (ref) ]]
	assert(p1 ~= nil, "traceback is nil")

	return function(p13) --[[ Line: 153 | Upvalues: t2 (ref), p1 (copy) ]]
		if type(p13) == "table" then
			return p13
		end

		return t2.new({
			error = p13,
			kind = t2.Kind.ExecutionError,
			trace = debug.traceback(tostring(p13), 2),
			context = "Promise created at:\n\n" .. p1
		})
	end
end

local function runExecutor(p1, p2, ...) --[[ runExecutor | Line: 173 | Upvalues: packResult (copy), t2 (ref) ]]
	local v2 = xpcall

	assert(p1 ~= nil, "traceback is nil")

	return packResult(v2(p2, function(p13) --[[ Line: 153 | Upvalues: t2 (ref), p1 (copy) ]]
		if type(p13) == "table" then
			return p13
		end

		return t2.new({
			error = p13,
			kind = t2.Kind.ExecutionError,
			trace = debug.traceback(tostring(p13), 2),
			context = "Promise created at:\n\n" .. p1
		})
	end, ...))
end

local function createAdvancer(p1, p2, p3, p4) --[[ createAdvancer | Line: 181 | Upvalues: runExecutor (copy) ]]
	return function(...) --[[ Line: 182 | Upvalues: runExecutor (ref), p1 (copy), p2 (copy), p3 (copy), p4 (copy) ]]
		local v1, v22, v32 = runExecutor(p1, p2, ...)

		if v1 then
			p3(unpack(v32, 1, v22))
		else
			p4(v32[1])
		end
	end
end

local function isEmpty(p1) --[[ isEmpty | Line: 193 ]]
	return next(p1) == nil
end

local t3 = {
	Error = t2,
	Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
	_getTime = os.clock,
	_timeEvent = game:GetService("RunService").Heartbeat,
	_unhandledRejectionCallbacks = {},
	prototype = {}
}

t3.__index = t3.prototype
function t3._new(p1, p2, p3) --[[ _new | Line: 232 | Upvalues: t3 (copy), t (copy), runExecutor (copy) ]]
	if p3 ~= nil and not t3.is(p3) then
		error("Argument #2 to Promise.new must be a promise or nil", 2)
	end

	local t2 = {
		_thread = nil,
		_values = nil,
		_valuesLength = -1,
		_unhandledRejection = true,
		_cancellationHook = nil,
		_source = p1,
		_status = t3.Status.Started,
		_queuedResolve = {},
		_queuedReject = {},
		_queuedFinally = {},
		_parent = p3
	}

	t2._consumers = setmetatable({}, t)

	if p3 and p3._status == t3.Status.Started then
		p3._consumers[t2] = true
	end

	local v2 = t3

	setmetatable(t2, v2)

	local function resolve(...) --[[ resolve | Line: 280 | Upvalues: t2 (copy) ]]
		t2:_resolve(...)
	end

	local function reject(...) --[[ reject | Line: 284 | Upvalues: t2 (copy) ]]
		t2:_reject(...)
	end

	local function onCancel(p1) --[[ onCancel | Line: 288 | Upvalues: t2 (copy), t3 (ref) ]]
		if p1 and t2._status == t3.Status.Cancelled then
			p1()
		elseif p1 then
			t2._cancellationHook = p1
		end

		return t2._status == t3.Status.Cancelled
	end

	t2._thread = coroutine.create(function() --[[ Line: 300 | Upvalues: runExecutor (ref), t2 (copy), p2 (copy), resolve (copy), reject (copy), onCancel (copy) ]]
		local v1, _, v2 = runExecutor(t2._source, p2, resolve, reject, onCancel)

		if v1 then
			return
		end

		reject(v2[1])
	end)
	task.spawn(t2._thread)

	return t2
end
function t3.new(p1) --[[ new | Line: 351 | Upvalues: t3 (copy) ]]
	return t3._new(debug.traceback(nil, 2), p1)
end
function t3.__tostring(p1) --[[ __tostring | Line: 355 ]]
	return string.format("Promise(%s)", p1._status)
end
function t3.defer(p1) --[[ defer | Line: 377 | Upvalues: t3 (copy), runExecutor (copy) ]]
	local v1 = debug.traceback(nil, 2)

	return t3._new(v1, function(p12, p2, p3) --[[ Line: 380 | Upvalues: t3 (ref), runExecutor (ref), v1 (copy), p1 (copy) ]]
		local v12 = nil

		v12 = t3._timeEvent:Connect(function() --[[ Line: 382 | Upvalues: v12 (ref), runExecutor (ref), v1 (ref), p1 (ref), p12 (copy), p2 (copy), p3 (copy) ]]
			v12:Disconnect()

			local v13, _, v2 = runExecutor(v1, p1, p12, p2, p3)

			if v13 then
				return
			end

			p2(v2[1])
		end)
	end)
end
t3.async = t3.defer
function t3.resolve(...) --[[ resolve | Line: 420 | Upvalues: pack (copy), t3 (copy) ]]
	local v1, v2 = pack(...)

	return t3._new(debug.traceback(nil, 2), function(p1) --[[ Line: 422 | Upvalues: v2 (copy), v1 (copy) ]]
		p1(unpack(v2, 1, v1))
	end)
end
function t3.reject(...) --[[ reject | Line: 437 | Upvalues: pack (copy), t3 (copy) ]]
	local v1, v2 = pack(...)

	return t3._new(debug.traceback(nil, 2), function(p1, p2) --[[ Line: 439 | Upvalues: v2 (copy), v1 (copy) ]]
		p2(unpack(v2, 1, v1))
	end)
end
function t3._try(p1, p2, ...) --[[ _try | Line: 448 | Upvalues: pack (copy), t3 (copy) ]]
	local v1, v2 = pack(...)

	return t3._new(p1, function(p1) --[[ Line: 451 | Upvalues: p2 (copy), v2 (copy), v1 (copy) ]]
		p1(p2(unpack(v2, 1, v1)))
	end)
end
function t3.try(p1, ...) --[[ try | Line: 479 | Upvalues: t3 (copy) ]]
	return t3._try(debug.traceback(nil, 2), p1, ...)
end
function t3._all(p1, p2, p3) --[[ _all | Line: 488 | Upvalues: t3 (copy) ]]
	if type(p2) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
	end

	for k, v in pairs(p2) do
		if not t3.is(v) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(k))), 3)
		end
	end

	if #p2 == 0 or p3 == 0 then
		return t3.resolve({})
	end

	return t3._new(p1, function(p1, p22, p32) --[[ Line: 506 | Upvalues: p3 (copy), p2 (copy) ]]
		local t = {}
		local list = {}
		local v1 = 0
		local v2 = 0
		local v3 = false

		local function cancel() --[[ cancel | Line: 517 | Upvalues: list (copy) ]]
			for i, v in ipairs(list) do
				v:cancel()
			end
		end

		local function resolveOne(p12, ...) --[[ resolveOne | Line: 524 | Upvalues: v3 (ref), v1 (ref), p3 (ref), t (copy), p2 (ref), p1 (copy), list (copy) ]]
			if v3 then
				return
			end

			v1 = v1 + 1

			if p3 == nil then
				t[p12] = ...
			else
				t[v1] = ...
			end

			if not ((p3 or #p2) <= v1) then
				return
			end

			v3 = true
			p1(t)

			for i, v in ipairs(list) do
				v:cancel()
			end
		end

		p32(cancel)

		for i, v in ipairs(p2) do
			list[i] = v:andThen(function(...) --[[ Line: 549 | Upvalues: resolveOne (copy), i (copy) ]]
				resolveOne(i, ...)
			end, function(...) --[[ Line: 551 | Upvalues: v2 (ref), p3 (ref), p2 (ref), list (copy), v3 (ref), p22 (copy) ]]
				v2 = v2 + 1

				if p3 ~= nil and not (#p2 - v2 < p3) then
					return
				end

				for i, v in ipairs(list) do
					v:cancel()
				end

				v3 = true
				p22(...)
			end)
		end

		if v3 then
			for i, v in ipairs(list) do
				v:cancel()
			end
		end
	end)
end
function t3.all(p1) --[[ all | Line: 593 | Upvalues: t3 (copy) ]]
	return t3._all(debug.traceback(nil, 2), p1)
end
function t3.fold(p1, p2, p3) --[[ fold | Line: 622 | Upvalues: t3 (copy) ]]
	assert(if type(p1) == "table" then true else false, "Bad argument #1 to Promise.fold: must be a table")

	local v2

	if type(p2) == "function" then
		v2 = true
	elseif type(p2) == "table" then
		local v3 = getmetatable(p2)

		v2 = if v3 then type((rawget(v3, "__call"))) == "function" else false
	else
		v2 = false
	end

	assert(v2, "Bad argument #2 to Promise.fold: must be a function")

	local v5 = t3.resolve(p3)

	return t3.each(p1, function(p1, p22) --[[ Line: 627 | Upvalues: v5 (ref), p2 (copy) ]]
		v5 = v5:andThen(function(p12) --[[ Line: 628 | Upvalues: p2 (ref), p1 (copy), p22 (copy) ]]
			return p2(p12, p1, p22)
		end)
	end):andThen(function() --[[ Line: 631 | Upvalues: v5 (ref) ]]
		return v5
	end)
end
function t3.some(p1, p2) --[[ some | Line: 655 | Upvalues: t3 (copy) ]]
	assert(if type(p2) == "number" then true else false, "Bad argument #2 to Promise.some: must be a number")

	return t3._all(debug.traceback(nil, 2), p1, p2)
end
function t3.any(p1) --[[ any | Line: 661 | Upvalues: t3 (copy) ]]
	return t3._all(debug.traceback(nil, 2), p1, 1):andThen(function(p1) --[[ Line: 662 ]]
		return p1[1]
	end)
end
function t3.allSettled(p1) --[[ allSettled | Line: 683 | Upvalues: t3 (copy) ]]
	if type(p1) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
	end

	for k, v in pairs(p1) do
		if not t3.is(v) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(k))), 2)
		end
	end

	if #p1 == 0 then
		return t3.resolve({})
	end

	return t3._new(debug.traceback(nil, 2), function(p12, p2, p3) --[[ Line: 701 | Upvalues: p1 (copy) ]]
		local t = {}
		local t2 = {}
		local v1 = 0

		local function resolveOne(p13, ...) --[[ resolveOne | Line: 711 | Upvalues: v1 (ref), t (copy), p1 (ref), p12 (copy) ]]
			v1 = v1 + 1
			t[p13] = ...

			if not (#p1 <= v1) then
				return
			end

			p12(t)
		end

		p3(function() --[[ Line: 721 | Upvalues: t2 (copy) ]]
			for i, v in ipairs(t2) do
				v:cancel()
			end
		end)

		for i, v in ipairs(p1) do
			t2[i] = v:finally(function(...) --[[ Line: 730 | Upvalues: resolveOne (copy), i (copy) ]]
				resolveOne(i, ...)
			end)
		end
	end)
end
function t3.race(p1) --[[ race | Line: 761 | Upvalues: t3 (copy) ]]
	local v1 = type(p1) == "table"

	assert(v1, string.format("Please pass a list of promises to %s", "Promise.race"))

	for k, v in pairs(p1) do
		local v2 = t3.is(v)
		local format2 = string.format

		assert(v2, format2("Non-promise value passed into %s at index %s", "Promise.race", (tostring(k))))
	end

	return t3._new(debug.traceback(nil, 2), function(p12, p2, p3) --[[ Line: 768 | Upvalues: p1 (copy) ]]
		local list = {}
		local v1 = false

		local function cancel() --[[ cancel | Line: 772 | Upvalues: list (copy) ]]
			for i, v in ipairs(list) do
				v:cancel()
			end
		end

		local function finalize(p1) --[[ finalize | Line: 778 | Upvalues: list (copy), v1 (ref) ]]
			return function(...) --[[ Line: 779 | Upvalues: list (ref), v1 (ref), p1 (copy) ]]
				for i2, v in ipairs(list) do
					v:cancel()
				end

				v1 = true

				return p1(...)
			end
		end

		if not p3(function(...) --[[ Line: 779 | Upvalues: list (copy), v1 (ref), p2 (copy) ]]
			for i2, v in ipairs(list) do
				v:cancel()
			end

			v1 = true

			return p2(...)
		end) then
			for i, v in ipairs(p1) do
				list[i] = v:andThen(function(...) --[[ Line: 779 | Upvalues: list (copy), v1 (ref), p12 (copy) ]]
					for i2, v in ipairs(list) do
						v:cancel()
					end

					v1 = true

					return p12(...)
				end, function(...) --[[ Line: 779 | Upvalues: list (copy), v1 (ref), p2 (copy) ]]
					for i2, v in ipairs(list) do
						v:cancel()
					end

					v1 = true

					return p2(...)
				end)
			end

			if v1 then
				for i, v in ipairs(list) do
					v:cancel()
				end
			end
		end
	end)
end
function t3.each(p1, p2) --[[ each | Line: 800 | Upvalues: t3 (copy), t2 (ref) ]]
	local v1 = if type(p1) == "table" then true else false

	assert(v1, string.format("Please pass a list of promises to %s", "Promise.each"))

	local v2

	if type(p2) == "function" then
		v2 = true
	elseif type(p2) == "table" then
		local v3 = getmetatable(p2)

		v2 = if v3 then type((rawget(v3, "__call"))) == "function" else false
	else
		v2 = false
	end

	assert(v2, string.format("Please pass a handler function to %s!", "Promise.each"))

	return t3._new(debug.traceback(nil, 2), function(p12, p22, p3) --[[ Line: 804 | Upvalues: p1 (copy), t3 (ref), t2 (ref), p2 (copy) ]]
		local t = {}
		local list = {}
		local v1 = false

		local function cancel() --[[ cancel | Line: 810 | Upvalues: list (copy) ]]
			for i, v in ipairs(list) do
				v:cancel()
			end
		end

		p3(function() --[[ Line: 816 | Upvalues: v1 (ref), list (copy) ]]
			v1 = true

			for i, v in ipairs(list) do
				v:cancel()
			end
		end)

		local list2 = {}

		for i, v in ipairs(p1) do
			if t3.is(v) then
				if v:getStatus() == t3.Status.Cancelled then
					for i2, v2 in ipairs(list) do
						v2:cancel()
					end

					return p22(t2.new({
						error = "Promise is cancelled",
						kind = t2.Kind.AlreadyCancelled,
						context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
					}))
				end

				if v:getStatus() == t3.Status.Rejected then
					for i2, v2 in ipairs(list) do
						v2:cancel()
					end

					return p22(select(2, v:await()))
				end

				local v2 = v:andThen(function(...) --[[ Line: 849 ]]
					return ...
				end)

				table.insert(list, v2)
				list2[i] = v2

				continue
			end

			list2[i] = v
		end

		for i, v in ipairs(list2) do
			if t3.is(v) then
				local v3, v4 = v:await()

				if v3 then
					v = v4
				else
					for i2, v2 in ipairs(list) do
						v2:cancel()
					end

					return p22(v4)
				end
			end

			if v1 then
				return
			end

			local v6 = t3.resolve(p2(v, i))

			table.insert(list, v6)

			local v7, v8 = v6:await()

			if v7 then
				t[i] = v8
			else
				for i2, v2 in ipairs(list) do
					v2:cancel()
				end

				return p22(v8)
			end
		end

		p12(t)
	end)
end
function t3.is(p1) --[[ is | Line: 899 | Upvalues: t3 (copy) ]]
	if type(p1) ~= "table" then
		return false
	end

	local v1 = getmetatable(p1)

	if v1 == t3 then
		return true
	end

	if v1 == nil then
		local andThen = p1.andThen

		if type(andThen) == "function" then
			return true
		end

		if type(andThen) ~= "table" then
			return false
		end

		local v2 = getmetatable(andThen)

		if not v2 then
			return false
		end

		if type((rawget(v2, "__call"))) == "function" then
			return true
		end

		return false
	end

	if type(v1) ~= "table" then
		return false
	end

	if type((rawget(v1, "__index"))) ~= "table" then
		return false
	end

	local v6 = rawget(rawget(v1, "__index"), "andThen")
	local v7

	if type(v6) == "function" then
		v7 = true
	elseif type(v6) == "table" then
		local v8 = getmetatable(v6)

		v7 = if v8 then type((rawget(v8, "__call"))) == "function" else false
	else
		v7 = false
	end

	if v7 then
		return true
	end

	return false
end
function t3.promisify(p1) --[[ promisify | Line: 948 | Upvalues: t3 (copy) ]]
	return function(...) --[[ Line: 949 | Upvalues: t3 (ref), p1 (copy) ]]
		return t3._try(debug.traceback(nil, 2), p1, ...)
	end
end

local v1 = nil
local v2 = nil

function t3.delay(p1) --[[ delay | Line: 979 | Upvalues: t3 (copy), v2 (ref), v1 (ref) ]]
	local v12 = type(p1) == "number"

	assert(v12, "Bad argument #1 to Promise.delay, must be a number.")

	if not (p1 >= 1 / 60) or p1 == (1 / 0) then
		p1 = 1 / 60
	end

	return t3._new(debug.traceback(nil, 2), function(p12, p2, p3) --[[ Line: 987 | Upvalues: t3 (ref), p1 (ref), v2 (ref), v1 (ref) ]]
		local v12 = t3._getTime()
		local v22 = v12 + p1
		local t = {
			resolve = p12,
			startTime = v12,
			endTime = v22
		}

		if v2 == nil then
			v1 = t
			v2 = t3._timeEvent:Connect(function() --[[ Line: 999 | Upvalues: t3 (ref), v1 (ref), v2 (ref) ]]
				while v1 ~= nil and v1.endTime < t3._getTime() do
					local v22 = v1

					v1 = v22.next

					if v1 == nil then
						v2:Disconnect()
						v2 = nil
					else
						v1.previous = nil
					end

					v22.resolve(t3._getTime() - v22.startTime)
				end
			end)
		elseif v1.endTime < v22 then
			local v3 = v1
			local v4 = v3.next

			while v4 ~= nil and v4.endTime < v22 do
				v4, v3 = v4.next, v4
			end

			v3.next = t
			t.previous = v3

			if v4 ~= nil then
				t.next = v4
				v4.previous = t
			end
		else
			t.next = v1
			v1.previous = t
			v1 = t
		end

		p3(function() --[[ Line: 1044 | Upvalues: t (copy), v1 (ref), v2 (ref) ]]
			local v12 = t.next

			if v1 == t then
				if v12 == nil then
					v2:Disconnect()
					v2 = nil
				else
					v12.previous = nil
				end

				v1 = v12
			else
				local previous = t.previous

				previous.next = v12

				if v12 == nil then
					return
				end

				v12.previous = previous
			end
		end)
	end)
end

local function timeout(p1, p2, p3) --[[ timeout | Line: 1070 | Upvalues: t3 (copy), t2 (ref) ]]
	local v1 = debug.traceback(nil, 2)

	return t3.race({ t3.delay(p2):andThen(function() --[[ Line: 1074 | Upvalues: t3 (ref), p3 (copy), t2 (ref), p2 (copy), v1 (copy) ]]
			return t3.reject(p3 == nil and t2.new({
				error = "Timed out",
				kind = t2.Kind.TimedOut,
				context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", p2, v1)
			}) or p3)
		end), p1 })
end

t3.prototype.timeout = timeout

local function getStatus(p1) --[[ getStatus | Line: 1094 ]]
	return p1._status
end

t3.prototype.getStatus = getStatus

local function _andThen(p1, p2, p3, p4) --[[ _andThen | Line: 1103 | Upvalues: t3 (copy), runExecutor (copy) ]]
	p1._unhandledRejection = false

	if p1._status == t3.Status.Cancelled then
		local v1 = t3.new(function() --[[ Line: 1108 ]] end)

		v1:cancel()

		return v1
	end

	return t3._new(p2, function(p12, p22, p32) --[[ Line: 1115 | Upvalues: p3 (copy), p2 (copy), runExecutor (ref), p4 (copy), p1 (copy), t3 (ref) ]]
		local v1

		if p3 then
			local v2 = p2
			local v3 = p3

			v1 = function(...) --[[ Line: 182 | Upvalues: runExecutor (ref), v2 (copy), v3 (copy), p12 (copy), p22 (copy) ]]
				local v1, v22, v32 = runExecutor(v2, v3, ...)

				if v1 then
					p12(unpack(v32, 1, v22))
				else
					p22(v32[1])
				end
			end
		else
			v1 = p12
		end

		local v4

		if p4 then
			local v5 = p2
			local v6 = p4

			v4 = function(...) --[[ Line: 182 | Upvalues: runExecutor (ref), v5 (copy), v6 (copy), p12 (copy), p22 (copy) ]]
				local v1, v22, v32 = runExecutor(v5, v6, ...)

				if v1 then
					p12(unpack(v32, 1, v22))
				else
					p22(v32[1])
				end
			end
		else
			v4 = p22
		end

		if p1._status == t3.Status.Started then
			local _queuedResolve = p1._queuedResolve

			table.insert(_queuedResolve, v1)

			local _queuedReject = p1._queuedReject

			table.insert(_queuedReject, v4)
			p32(function() --[[ Line: 1134 | Upvalues: p1 (ref), t3 (ref), v1 (ref), v4 (ref) ]]
				if p1._status ~= t3.Status.Started then
					return
				end

				table.remove(p1._queuedResolve, table.find(p1._queuedResolve, v1))
				table.remove(p1._queuedReject, table.find(p1._queuedReject, v4))
			end)
		elseif p1._status == t3.Status.Resolved then
			v1(unpack(p1._values, 1, p1._valuesLength))
		elseif p1._status == t3.Status.Rejected then
			v4(unpack(p1._values, 1, p1._valuesLength))
		end
	end, p1)
end

t3.prototype._andThen = _andThen

local function andThen(p1, p2, p3) --[[ andThen | Line: 1152 ]]
	local v1

	if p2 == nil or type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)

		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end

	assert(v1, string.format("Please pass a handler function to %s!", "Promise:andThen"))

	local v4

	if p3 == nil or type(p3) == "function" then
		v4 = true
	elseif type(p3) == "table" then
		local v5 = getmetatable(p3)

		v4 = if v5 then type((rawget(v5, "__call"))) == "function" else false
	else
		v4 = false
	end

	assert(v4, string.format("Please pass a handler function to %s!", "Promise:andThen"))

	return p1:_andThen(debug.traceback(nil, 2), p2, p3)
end

t3.prototype.andThen = andThen

local function catch(p1, p2) --[[ catch | Line: 1159 ]]
	local v1

	if p2 == nil or type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)

		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end

	assert(v1, string.format("Please pass a handler function to %s!", "Promise:catch"))

	return p1:_andThen(debug.traceback(nil, 2), nil, p2)
end

t3.prototype.catch = catch

local function tap(p1, p2) --[[ tap | Line: 1164 | Upvalues: t3 (copy), pack (copy) ]]
	local v1

	if type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)

		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end

	assert(v1, string.format("Please pass a handler function to %s!", "Promise:tap"))

	return p1:_andThen(debug.traceback(nil, 2), function(...) --[[ Line: 1166 | Upvalues: p2 (copy), t3 (ref), pack (ref) ]]
		local v1 = p2(...)

		if t3.is(v1) then
			local v2, v3 = pack(...)

			return v1:andThen(function() --[[ Line: 1171 | Upvalues: v3 (copy), v2 (copy) ]]
				return unpack(v3, 1, v2)
			end)
		end

		return ...
	end)
end

t3.prototype.tap = tap

local function andThenCall(p1, p2, ...) --[[ andThenCall | Line: 1199 | Upvalues: pack (copy) ]]
	local v1

	if type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)

		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end

	assert(v1, string.format("Please pass a handler function to %s!", "Promise:andThenCall"))

	local v4, v5 = pack(...)

	return p1:_andThen(debug.traceback(nil, 2), function() --[[ Line: 1202 | Upvalues: p2 (copy), v5 (copy), v4 (copy) ]]
		return p2(unpack(v5, 1, v4))
	end)
end

t3.prototype.andThenCall = andThenCall

local function andThenReturn(p1, ...) --[[ andThenReturn | Line: 1207 | Upvalues: pack (copy) ]]
	local v1, v2 = pack(...)

	return p1:_andThen(debug.traceback(nil, 2), function() --[[ Line: 1209 | Upvalues: v2 (copy), v1 (copy) ]]
		return unpack(v2, 1, v1)
	end)
end

t3.prototype.andThenReturn = andThenReturn

local function cancel(p1) --[[ cancel | Line: 1225 | Upvalues: t3 (copy) ]]
	if p1._status ~= t3.Status.Started then
		return
	end

	p1._status = t3.Status.Cancelled

	if p1._cancellationHook then
		p1._cancellationHook()
	end

	coroutine.close(p1._thread)

	if p1._parent then
		p1._parent:_consumerCancelled(p1)
	end

	for k in pairs(p1._consumers) do
		k:cancel()
	end

	p1:_finalize()
end

t3.prototype.cancel = cancel

local function _consumerCancelled(p1, p2) --[[ _consumerCancelled | Line: 1253 | Upvalues: t3 (copy) ]]
	if p1._status ~= t3.Status.Started then
		return
	end

	p1._consumers[p2] = nil

	if next(p1._consumers) ~= nil then
		return
	end

	p1:cancel()
end

t3.prototype._consumerCancelled = _consumerCancelled

local function _finally(p1, p2, p3) --[[ _finally | Line: 1269 | Upvalues: t3 (copy) ]]
	p1._unhandledRejection = false

	return t3._new(p2, function(p12, p2, p32) --[[ Line: 1272 | Upvalues: p1 (copy), p3 (copy), t3 (ref) ]]
		local v1 = nil

		p32(function() --[[ Line: 1275 | Upvalues: p1 (ref), v1 (ref) ]]
			p1:_consumerCancelled(p1)

			if not v1 then
				return
			end

			v1:cancel()
		end)

		local v2 = if p3 then function(...) --[[ Line: 1288 | Upvalues: p3 (ref), t3 (ref), v1 (ref), p12 (copy), p1 (ref), p2 (copy) ]]
	local v12 = p3(...)

	if t3.is(v12) then
		v1 = v12
		v12:finally(function(p13) --[[ Line: 1295 | Upvalues: t3 (ref), p12 (ref), p1 (ref) ]]
			if p13 == t3.Status.Rejected then
				return
			end

			p12(p1)
		end):catch(function(...) --[[ Line: 1300 | Upvalues: p2 (ref) ]]
			p2(...)
		end)
	else
		p12(p1)
	end
end else p12

		if p1._status == t3.Status.Started then
			table.insert(p1._queuedFinally, v2)
		else
			v2(p1._status)
		end
	end)
end

t3.prototype._finally = _finally

local function finally(p1, p2) --[[ finally | Line: 1370 ]]
	local v1

	if p2 == nil or type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)

		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end

	assert(v1, string.format("Please pass a handler function to %s!", "Promise:finally"))

	return p1:_finally(debug.traceback(nil, 2), p2)
end

t3.prototype.finally = finally

local function finallyCall(p1, p2, ...) --[[ finallyCall | Line: 1384 | Upvalues: pack (copy) ]]
	local v1

	if type(p2) == "function" then
		v1 = true
	elseif type(p2) == "table" then
		local v2 = getmetatable(p2)

		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end

	assert(v1, string.format("Please pass a handler function to %s!", "Promise:finallyCall"))

	local v4, v5 = pack(...)

	return p1:_finally(debug.traceback(nil, 2), function() --[[ Line: 1387 | Upvalues: p2 (copy), v5 (copy), v4 (copy) ]]
		return p2(unpack(v5, 1, v4))
	end)
end

t3.prototype.finallyCall = finallyCall

local function finallyReturn(p1, ...) --[[ finallyReturn | Line: 1409 | Upvalues: pack (copy) ]]
	local v1, v2 = pack(...)

	return p1:_finally(debug.traceback(nil, 2), function() --[[ Line: 1411 | Upvalues: v2 (copy), v1 (copy) ]]
		return unpack(v2, 1, v1)
	end)
end

t3.prototype.finallyReturn = finallyReturn

local function awaitStatus(p1) --[[ awaitStatus | Line: 1423 | Upvalues: t3 (copy) ]]
	p1._unhandledRejection = false

	if p1._status == t3.Status.Started then
		local v1 = coroutine.running()

		p1:finally(function() --[[ Line: 1430 | Upvalues: v1 (copy) ]]
			task.spawn(v1)
		end):catch(function() --[[ Line: 1436 ]] end)
		coroutine.yield()
	end

	if p1._status == t3.Status.Resolved then
		return p1._status, unpack(p1._values, 1, p1._valuesLength)
	end

	if p1._status == t3.Status.Rejected then
		return p1._status, unpack(p1._values, 1, p1._valuesLength)
	end

	return p1._status
end

t3.prototype.awaitStatus = awaitStatus

local function awaitHelper(p1, ...) --[[ awaitHelper | Line: 1451 | Upvalues: t3 (copy) ]]
	return p1 == t3.Status.Resolved, ...
end

local function await(p1) --[[ await | Line: 1455 | Upvalues: awaitHelper (copy) ]]
	return awaitHelper(p1:awaitStatus())
end

t3.prototype.await = await

local function expectHelper(p1, ...) --[[ expectHelper | Line: 1459 | Upvalues: t3 (copy) ]]
	if p1 == t3.Status.Resolved then
		return ...
	end

	error(if ... == nil then "Expected Promise rejected with no value." else ..., 3)
end

local function expect(p1) --[[ expect | Line: 1492 | Upvalues: expectHelper (copy) ]]
	return expectHelper(p1:awaitStatus())
end

t3.prototype.expect = expect
t3.prototype.awaitValue = t3.prototype.expect

local function _unwrap(p1) --[[ _unwrap | Line: 1506 | Upvalues: t3 (copy) ]]
	if p1._status == t3.Status.Started then
		error("Promise has not resolved or rejected.", 2)
	end

	return p1._status == t3.Status.Resolved, unpack(p1._values, 1, p1._valuesLength)
end

t3.prototype._unwrap = _unwrap

local function _resolve(p1, ...) --[[ _resolve | Line: 1516 | Upvalues: t3 (copy), t2 (ref), pack (copy) ]]
	if p1._status == t3.Status.Started then
		if t3.is((...)) then
			if select("#", ...) > 1 then
				warn((string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", p1._source)))
			end

			local v2 = ...
			local v3 = v2:andThen(function(...) --[[ Line: 1537 | Upvalues: p1 (copy) ]]
				p1:_resolve(...)
			end, function(...) --[[ Line: 1539 | Upvalues: v2 (copy), t2 (ref), p1 (copy) ]]
				local v1 = v2._values[1]

				if v2._error then
					v1 = t2.new({
						context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
						error = v2._error,
						kind = t2.Kind.ExecutionError
					})
				end

				if t2.isKind(v1, t2.Kind.ExecutionError) then
					return p1:_reject(v1:extend({
						error = "This Promise was chained to a Promise that errored.",
						trace = "",
						context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", p1._source)
					}))
				end

				p1:_reject(...)
			end)

			if v3._status == t3.Status.Cancelled then
				p1:cancel()

				return
			end

			if v3._status ~= t3.Status.Started then
				return
			end

			p1._parent = v3
			v3._consumers[p1] = true
		else
			p1._status = t3.Status.Resolved

			local v4, v5 = pack(...)

			p1._valuesLength = v4
			p1._values = v5

			for i, v in ipairs(p1._queuedResolve) do
				coroutine.wrap(v)(...)
			end

			p1:_finalize()
		end
	else
		if not t3.is((...)) then
			return
		end

		(...):_consumerCancelled(p1)
	end
end

t3.prototype._resolve = _resolve

local function _reject(p1, ...) --[[ _reject | Line: 1587 | Upvalues: t3 (copy), pack (copy) ]]
	if p1._status ~= t3.Status.Started then
		return
	end

	p1._status = t3.Status.Rejected

	local v1, v2 = pack(...)

	p1._valuesLength = v1
	p1._values = v2

	if next(p1._queuedReject) == nil then
		local v4 = tostring((...))

		coroutine.wrap(function() --[[ Line: 1609 | Upvalues: t3 (ref), p1 (copy), v4 (copy) ]]
			t3._timeEvent:Wait()

			if not p1._unhandledRejection then
				return
			end

			local v1 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", v4, p1._source)

			for i, v in ipairs(t3._unhandledRejectionCallbacks) do
				task.spawn(v, p1, unpack(p1._values, 1, p1._valuesLength))
			end

			if not t3.TEST then
				warn(v1)
			end
		end)()
	else
		for i, v in ipairs(p1._queuedReject) do
			coroutine.wrap(v)(...)
		end
	end

	p1:_finalize()
end

t3.prototype._reject = _reject

local function _finalize(p1) --[[ _finalize | Line: 1641 | Upvalues: t3 (copy) ]]
	for i, v in ipairs(p1._queuedFinally) do
		coroutine.wrap(v)(p1._status)
	end

	p1._queuedFinally = nil
	p1._queuedReject = nil
	p1._queuedResolve = nil

	if not t3.TEST then
		p1._parent = nil
		p1._consumers = nil
	end

	task.defer(coroutine.close, p1._thread)
end

t3.prototype._finalize = _finalize

local function now(p1, p2) --[[ now | Line: 1662 | Upvalues: t3 (copy), t2 (ref) ]]
	local v1 = debug.traceback(nil, 2)

	if p1._status == t3.Status.Resolved then
		return p1:_andThen(v1, function(...) --[[ Line: 1665 ]]
			return ...
		end)
	end

	return t3.reject(if p2 == nil then t2.new({
	error = "This Promise was not resolved in time for :now()",
	kind = t2.Kind.NotResolvedInTime,
	context = ":now() was called at:\n\n" .. v1
}) or p2 else p2)
end

t3.prototype.now = now
function t3.retry(p1, p2, ...) --[[ retry | Line: 1707 | Upvalues: t3 (copy) ]]
	local v1

	if type(p1) == "function" then
		v1 = true
	elseif type(p1) == "table" then
		local v2 = getmetatable(p1)

		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end

	assert(v1, "Parameter #1 to Promise.retry must be a function")
	assert(if type(p2) == "number" then true else false, "Parameter #2 to Promise.retry must be a number")

	local t = { ... }
	local v5 = select("#", ...)

	return t3.resolve(p1(...)):catch(function(...) --[[ Line: 1713 | Upvalues: p2 (copy), t3 (ref), p1 (copy), t (copy), v5 (copy) ]]
		if p2 > 0 then
			return t3.retry(p1, p2 - 1, unpack(t, 1, v5))
		end

		return t3.reject(...)
	end)
end
function t3.retryWithDelay(p1, p2, p3, ...) --[[ retryWithDelay | Line: 1735 | Upvalues: t3 (copy) ]]
	local v1

	if type(p1) == "function" then
		v1 = true
	elseif type(p1) == "table" then
		local v2 = getmetatable(p1)

		v1 = if v2 then type((rawget(v2, "__call"))) == "function" else false
	else
		v1 = false
	end

	assert(v1, "Parameter #1 to Promise.retry must be a function")
	assert(if type(p2) == "number" then true else false, "Parameter #2 (times) to Promise.retry must be a number")
	assert(if type(p3) == "number" then true else false, "Parameter #3 (seconds) to Promise.retry must be a number")

	local t = { ... }
	local v6 = select("#", ...)

	return t3.resolve(p1(...)):catch(function(...) --[[ Line: 1742 | Upvalues: p2 (copy), t3 (ref), p3 (copy), p1 (copy), t (copy), v6 (copy) ]]
		if p2 > 0 then
			t3.delay(p3):await()

			return t3.retryWithDelay(p1, p2 - 1, p3, unpack(t, 1, v6))
		end

		return t3.reject(...)
	end)
end
function t3.fromEvent(p1, p2) --[[ fromEvent | Line: 1777 | Upvalues: t3 (copy) ]]
	local v2 = p2 or (function() --[[ Line: 1778 ]]
		return true
	end)

	return t3._new(debug.traceback(nil, 2), function(p12, p2, p3) --[[ Line: 1782 | Upvalues: p1 (copy), v2 (ref) ]]
		local v1 = nil
		local v22 = false

		local function disconnect() --[[ disconnect | Line: 1786 | Upvalues: v1 (ref) ]]
			v1:Disconnect()
			v1 = nil
		end

		v1 = p1:Connect(function(...) --[[ Line: 1795 | Upvalues: v2 (ref), p12 (copy), v1 (ref), v22 (ref) ]]
			local v12 = v2(...)

			if v12 == true then
				p12(...)

				if v1 then
					v1:Disconnect()
					v1 = nil
				else
					v22 = true
				end
			else
				if type(v12) == "boolean" then
					return
				end

				error("Promise.fromEvent predicate should always return a boolean")
			end
		end)

		if v22 and v1 then
			return disconnect()
		end

		p3(disconnect)
	end)
end
function t3.onUnhandledRejection(p1) --[[ onUnhandledRejection | Line: 1829 | Upvalues: t3 (copy) ]]
	local _unhandledRejectionCallbacks = t3._unhandledRejectionCallbacks

	table.insert(_unhandledRejectionCallbacks, p1)

	return function() --[[ Line: 1832 | Upvalues: t3 (ref), p1 (copy) ]]
		local v1 = table.find(t3._unhandledRejectionCallbacks, p1)

		if not v1 then
			return
		end

		table.remove(t3._unhandledRejectionCallbacks, v1)
	end
end

return t3