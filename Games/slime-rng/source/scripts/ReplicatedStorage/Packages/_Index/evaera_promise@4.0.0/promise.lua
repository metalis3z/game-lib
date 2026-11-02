-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: promise, time of decompilation: Sun May  3 10:10:30 2026 ]]
local t1 = {
	__mode = "k"
}

local function makeEnum(p1, p2) -- line: 28
	local t2 = {}

	for _, v in ipairs(p2) do
		t2[v] = v
	end

	return (setmetatable(t2, {
		__index = function(_, p4) --[[ __index ]] -- line: 36
			-- upvalues: p1 (copy)
			error(string.format("%s is not in %s!", p4, p1), 2)
		end,
		__newindex = function() --[[ __newindex ]] -- line: 39
			-- upvalues: p1 (copy)
			error(string.format("Creating new members in %s is not allowed!", p1), 2)
		end
	}))
end

local t3 = {
	Kind = makeEnum("Promise.Error.Kind", {
		"ExecutionError",
		"AlreadyCancelled",
		"NotResolvedInTime",
		"TimedOut"
	})
}

t3.__index = t3

function t3.new(p5, p6) -- line: 64
	-- upvalues: t3 (ref)
	local v21 = p5 or {}

	return (setmetatable({
		error = tostring(v21.error) or "[This error has no error text.]",
		trace = v21.trace,
		context = v21.context,
		kind = v21.kind,
		parent = p6,
		createdTick = os.clock(),
		createdTrace = debug.traceback()
	}, t3))
end
function t3.is(p7) -- line: 77
	if type(p7) == "table" then
		local mt = getmetatable(p7)

		if type(mt) == "table" then
			return rawget(p7, "error") ~= nil and type((rawget(mt, "extend"))) == "function"
		end
	end

	return false
end
function t3.isKind(p8, p9) -- line: 89
	-- upvalues: t3 (ref)
	assert(p9 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil")

	return t3.is(p8) and p9 == p8.kind
end
function t3.extend(p10, p11) -- line: 95
	-- upvalues: t3 (ref)
	local v28 = p11 or {}

	v28.kind = v28.kind or p10.kind

	return t3.new(v28, p10)
end
function t3.getErrorChain(p12) -- line: 103
	local t4 = { p12 }

	while t4[#t4].parent do
		table.insert(t4, t4[#t4].parent)
	end

	return t4
end
function t3.__tostring(p13) -- line: 113
	local t5 = { string.format("-- Promise.Error(%s) --", p13.kind or "?") }

	for _, v in ipairs(p13:getErrorChain()) do
		table.insert(t5, table.concat({
			v.trace or v.error,
			v.context
		}, "\n"))
	end

	return table.concat(t5, "\n")
end

local function pack(...) -- line: 137
	return select("#", ...), { ... }
end
local function packResult(p14, ...) -- line: 144
	return p14, select("#", ...), { ... }
end
local function runExecutor(p15, p16, ...) -- line: 171
	-- upvalues: packResult (copy), t3 (ref)
	local v39 = packResult
	local _xpcall = xpcall

	assert(p15 ~= nil, "traceback is nil")

	return v39(_xpcall(p16, function(p17) -- line: 151
		-- upvalues: t3 (ref), p15 (copy)
		if type(p17) == "table" then
			return p17
		end

		return t3.new({
			error = p17,
			kind = t3.Kind.ExecutionError,
			trace = debug.traceback(tostring(p17), 2),
			context = "Promise created at:\n\n" .. p15
		})
	end, ...))
end

local t6 = {
	Error = t3,
	Status = makeEnum("Promise.Status", {
		"Started",
		"Resolved",
		"Rejected",
		"Cancelled"
	}),
	_getTime = os.clock,
	_timeEvent = game:GetService("RunService").Heartbeat,
	_unhandledRejectionCallbacks = {},
	prototype = {}
}

t6.__index = t6.prototype

function t6._new(p18, p19, p20) -- line: 230
	-- upvalues: t6 (copy), t1 (copy), runExecutor (copy)
	if p20 ~= nil and not t6.is(p20) then
		error("Argument #2 to Promise.new must be a promise or nil", 2)
	end

	local t7 = {
		_thread = nil,
		_values = nil,
		_valuesLength = -1,
		_unhandledRejection = true,
		_cancellationHook = nil,
		_source = p18,
		_status = t6.Status.Started,
		_queuedResolve = {},
		_queuedReject = {},
		_queuedFinally = {},
		_parent = p20,
		_consumers = setmetatable({}, t1)
	}

	if p20 and p20._status == t6.Status.Started then
		p20._consumers[t7] = true
	end

	setmetatable(t7, t6)

	local function resolve(...) -- line: 278
		-- upvalues: t7 (copy)
		t7:_resolve(...)
	end
	local function reject(...) -- line: 282
		-- upvalues: t7 (copy)
		t7:_reject(...)
	end
	local function onCancel(p21) -- line: 286
		-- upvalues: t7 (copy), t6 (copy)
		if p21 then
			if t7._status == t6.Status.Cancelled then
				p21()
			else
				t7._cancellationHook = p21
			end
		end

		return t7._status == t6.Status.Cancelled
	end

	t7._thread = coroutine.create(function() -- line: 298
		-- upvalues: runExecutor (copy), t7 (copy), p19 (copy), resolve (copy), reject (copy), onCancel (copy)
		local v220, _, v222 = runExecutor(t7._source, p19, resolve, reject, onCancel)

		if not v220 then
			reject(v222[1])
		end
	end)
	task.spawn(t7._thread)

	return t7
end
function t6.new(p22) -- line: 349
	-- upvalues: t6 (copy)
	return t6._new(debug.traceback(nil, 2), p22)
end
function t6.__tostring(p23) -- line: 353
	return string.format("Promise(%s)", p23._status)
end
function t6.defer(p24) -- line: 375
	-- upvalues: t6 (copy), runExecutor (copy)
	local trace = debug.traceback(nil, 2)

	return (t6._new(trace, function(p25, p26, p27) -- line: 378
		-- upvalues: t6 (copy), runExecutor (copy), trace (copy), p24 (copy)
		local connection = nil

		connection = t6._timeEvent:Connect(function() -- line: 380
			-- upvalues: connection (ref), runExecutor (copy), trace (copy), p24 (copy), p25 (copy), p26 (copy), p27 (copy)
			connection:Disconnect()

			local v326, _, v328 = runExecutor(trace, p24, p25, p26, p27)

			if not v326 then
				p26(v328[1])
			end
		end)
	end))
end

t6.async = t6.defer

function t6.resolve(...) -- line: 418
	-- upvalues: pack (copy), t6 (copy)
	local v57, v58 = pack(...)

	return t6._new(debug.traceback(nil, 2), function(p28) -- line: 420
		-- upvalues: v58 (copy), v57 (copy)
		p28(unpack(v58, 1, v57))
	end)
end
function t6.reject(...) -- line: 435
	-- upvalues: pack (copy), t6 (copy)
	local v59, v60 = pack(...)

	return t6._new(debug.traceback(nil, 2), function(_, p30) -- line: 437
		-- upvalues: v60 (copy), v59 (copy)
		p30(unpack(v60, 1, v59))
	end)
end
function t6._try(p31, p32, ...) -- line: 446
	-- upvalues: pack (copy), t6 (copy)
	local v63, v64 = pack(...)

	return t6._new(p31, function(p33) -- line: 449
		-- upvalues: p32 (copy), v64 (copy), v63 (copy)
		p33(p32(unpack(v64, 1, v63)))
	end)
end
function t6.try(p34, ...) -- line: 477
	-- upvalues: t6 (copy)
	return t6._try(debug.traceback(nil, 2), p34, ...)
end
function t6._all(p35, p36, p37) -- line: 486
	-- upvalues: t6 (copy)
	if type(p36) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
	end

	for k, v in pairs(p36) do
		if not t6.is(v) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(k))), 3)
		end
	end

	if #p36 == 0 or p37 == 0 then
		return t6.resolve({})
	end

	return t6._new(p35, function(p38, p39, p40) -- line: 504
		-- upvalues: p37 (copy), p36 (copy)
		local t8 = {}
		local t9 = {}
		local n1 = 0
		local n2 = 0
		local u238 = false

		local function resolveOne(p41, ...) -- line: 522
			-- upvalues: u238 (ref), n1 (ref), p37 (copy), t8 (copy), p36 (copy), p38 (copy), t9 (copy)
			if u238 then
				return
			end

			n1 += 1

			if p37 == nil then
				t8[p41] = ...
			else
				t8[n1] = ...
			end

			if n1 >= (p37 or #p36) then
				u238 = true
				p38(t8)

				for _, v in ipairs(t9) do
					v:cancel()
				end
			end
		end

		p40(function() --[[ cancel ]] -- line: 515
			-- upvalues: t9 (copy)
			for _, v in ipairs(t9) do
				v:cancel()
			end
		end)

		for i, v in ipairs(p36) do
			t9[i] = v:andThen(function(...) -- line: 547
				-- upvalues: resolveOne (copy), i (copy)
				resolveOne(i, ...)
			end, function(...) -- line: 549
				-- upvalues: n2 (ref), p37 (copy), p36 (copy), t9 (copy), u238 (ref), p39 (copy)
				n2 += 1

				if p37 == nil or #p36 - n2 < p37 then
					for _, v2 in ipairs(t9) do
						v2:cancel()
					end

					u238 = true
					p39(...)
				end
			end)
		end

		if u238 then
			for _, v in ipairs(t9) do
				v:cancel()
			end
		end
	end)
end
function t6.all(p42) -- line: 591
	-- upvalues: t6 (copy)
	return t6._all(debug.traceback(nil, 2), p42)
end
function t6.fold(p43, p44, p45) -- line: 620
	-- upvalues: t6 (copy)
	assert(type(p43) == "table", "Bad argument #1 to Promise.fold: must be a table")

	local g76 = nil
	local mt = nil
	local v75 = nil

	if type(p44) == "function" then
		v75 = true
		g76 = true
	end

	repeat
		if g76 or (g76 or type(p44) == "table") then
			if not g76 then
				if not g76 then
					mt = getmetatable(p44)
				end
			end

			if g76 or (g76 or mt and type((rawget(mt, "__call"))) == "function") then
				if not g76 then
					if not g76 then
						v75 = true
					end
				end

				g76 = false
				assert(v75, "Bad argument #2 to Promise.fold: must be a function")

				local u78 = t6.resolve(p45)

				return t6.each(p43, function(p46, p47) -- line: 625
					-- upvalues: u78 (ref), p44 (copy)
					u78 = u78:andThen(function(p48) -- line: 626
						-- upvalues: p44 (copy), p46 (copy), p47 (copy)
						return p44(p48, p46, p47)
					end)
				end):andThen(function() -- line: 629
					-- upvalues: u78 (ref)
					return u78
				end)
			end
		end

		v75 = false
		g76 = true
	until not g76
end
function t6.some(p49, p50) -- line: 653
	-- upvalues: t6 (copy)
	assert(type(p50) == "number", "Bad argument #2 to Promise.some: must be a number")

	return t6._all(debug.traceback(nil, 2), p49, p50)
end
function t6.any(p51) -- line: 677
	-- upvalues: t6 (copy)
	return t6._all(debug.traceback(nil, 2), p51, 1):andThen(function(p52) -- line: 678
		return p52[1]
	end)
end
function t6.allSettled(p53) -- line: 699
	-- upvalues: t6 (copy)
	if type(p53) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
	end

	for k, v in pairs(p53) do
		if not t6.is(v) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(k))), 2)
		end
	end

	if #p53 == 0 then
		return t6.resolve({})
	end

	return t6._new(debug.traceback(nil, 2), function(p54, _, p56) -- line: 717
		-- upvalues: p53 (copy)
		local t10 = {}
		local t11 = {}
		local n3 = 0

		local function resolveOne(p57, ...) -- line: 727
			-- upvalues: n3 (ref), t10 (copy), p53 (copy), p54 (copy)
			n3 += 1
			t10[p57] = ...

			if n3 >= #p53 then
				p54(t10)
			end
		end

		p56(function() -- line: 737
			-- upvalues: t11 (copy)
			for _, v in ipairs(t11) do
				v:cancel()
			end
		end)

		for i, v in ipairs(p53) do
			t11[i] = v:finally(function(...) -- line: 746
				-- upvalues: resolveOne (copy), i (copy)
				resolveOne(i, ...)
			end)
		end
	end)
end
function t6.race(p58) -- line: 777
	-- upvalues: t6 (copy)
	assert(type(p58) == "table", string.format("Please pass a list of promises to %s", "Promise.race"))

	for k, v in pairs(p58) do
		assert(t6.is(v), string.format("Non-promise value passed into %s at index %s", "Promise.race", (tostring(k))))
	end

	return t6._new(debug.traceback(nil, 2), function(p59, p60, p61) -- line: 784
		-- upvalues: p58 (copy)
		local t12 = {}
		local u260 = false

		if p61(function(...) -- line: 795
			-- upvalues: t12 (copy), u260 (ref), p60 (copy)
			for _, v in ipairs(t12) do
				v:cancel()
			end

			u260 = true

			return p60(...)
		end) then
			return
		end

		for i, v in ipairs(p58) do
			t12[i] = v:andThen(function(...) -- line: 795
				-- upvalues: t12 (copy), u260 (ref), p59 (copy)
				for _, v3 in ipairs(t12) do
					v3:cancel()
				end

				u260 = true

				return p59(...)
			end, function(...) -- line: 795
				-- upvalues: t12 (copy), u260 (ref), p60 (copy)
				for _, v4 in ipairs(t12) do
					v4:cancel()
				end

				u260 = true

				return p60(...)
			end)
		end

		if u260 then
			for _, v in ipairs(t12) do
				v:cancel()
			end
		end
	end)
end
function t6.each(p62, p63) -- line: 872
	-- upvalues: t6 (copy), t3 (ref)
	assert(type(p62) == "table", string.format("Please pass a list of promises to %s", "Promise.each"))

	local g91 = nil
	local mt = nil
	local v90 = nil

	if type(p63) == "function" then
		v90 = true
		g91 = true
	end

	repeat
		if g91 or (g91 or type(p63) == "table") then
			if not g91 then
				if not g91 then
					mt = getmetatable(p63)
				end
			end

			if g91 or (g91 or mt and type((rawget(mt, "__call"))) == "function") then
				if not g91 then
					if not g91 then
						v90 = true
					end
				end

				g91 = false
				assert(v90, string.format("Please pass a handler function to %s!", "Promise.each"))

				return t6._new(debug.traceback(nil, 2), function(p64, p65, p66) -- line: 876
					-- upvalues: p62 (copy), t6 (copy), t3 (ref), p63 (copy)
					local t13 = {}
					local t14 = {}
					local u270 = false

					p66(function() -- line: 888
						-- upvalues: u270 (ref), t14 (copy)
						u270 = true

						for _, v in ipairs(t14) do
							v:cancel()
						end
					end)

					local t15 = {}

					for i, v in ipairs(p62) do
						if t6.is(v) then
							if v:getStatus() == t6.Status.Cancelled then
								for _, v5 in ipairs(t14) do
									v5:cancel()
								end

								return p65(t3.new({
									error = "Promise is cancelled",
									kind = t3.Kind.AlreadyCancelled,
									context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
								}))
							end

							if v:getStatus() == t6.Status.Rejected then
								for _, v6 in ipairs(t14) do
									v6:cancel()
								end

								return p65(select(2, v:await()))
							end

							local v278 = v:andThen(function(...) -- line: 921
								return ...
							end)

							table.insert(t14, v278)
							t15[i] = v278

							continue
						end

						t15[i] = v
					end

					for i, v in ipairs(t15) do
						local v281 = v

						if t6.is(v281) then
							local v282

							v282, v281 = v281:await()

							if not v282 then
								for _, v7 in ipairs(t14) do
									v7:cancel()
								end

								return p65(v281)
							end
						end

						if u270 then
							return
						end

						local v285 = t6.resolve(p63(v281, i))

						table.insert(t14, v285)

						local v286, v287 = v285:await()

						if not v286 then
							for _, v8 in ipairs(t14) do
								v8:cancel()
							end

							return p65(v287)
						end

						t13[i] = v287
					end

					p64(t13)
				end)
			end
		end

		v90 = false
		g91 = true
	until not g91
end
function t6.is(p67) -- line: 971
	-- upvalues: t6 (copy)
	if type(p67) ~= "table" then
		return false
	end

	local mt = getmetatable(p67)

	if mt == t6 then
		return true
	end

	if mt == nil then
		local andThen = p67.andThen

		if type(andThen) == "function" then
			return true
		end

		if type(andThen) == "table" then
			local mt2 = getmetatable(andThen)

			if mt2 and type((rawget(mt2, "__call"))) == "function" then
				return true
			end
		end

		return false
	end

	if type(mt) ~= "table" or type((rawget(mt, "__index"))) ~= "table" then
		return false
	end

	local v97 = rawget(rawget(mt, "__index"), "andThen")
	local g99 = nil
	local mt3 = nil
	local v98 = nil

	if type(v97) == "function" then
		v98 = true
		g99 = true
	end

	repeat
		if g99 or (g99 or type(v97) == "table") then
			if not g99 then
				if not g99 then
					mt3 = getmetatable(v97)
				end
			end

			if g99 or (g99 or mt3 and type((rawget(mt3, "__call"))) == "function") then
				if not g99 then
					if not g99 then
						v98 = true
					end
				end

				g99 = false

				if v98 then
					return true
				end

				return false
			end
		end

		v98 = false
		g99 = true
	until not g99
end
function t6.promisify(p68) -- line: 1020
	-- upvalues: t6 (copy)
	return function(...) -- line: 1021
		-- upvalues: t6 (copy), p68 (copy)
		return t6._try(debug.traceback(nil, 2), p68, ...)
	end
end

local u8 = nil
local u9 = nil

function t6.delay(p69) -- line: 1051
	-- upvalues: t6 (copy), u9 (ref), u8 (ref)
	assert(type(p69) == "number", "Bad argument #1 to Promise.delay, must be a number.")

	if not (p69 >= 0.016666666666666666) or p69 == 1e999 then
		p69 = 0.016666666666666666
	end

	return t6._new(debug.traceback(nil, 2), function(p70, _, p72) -- line: 1059
		-- upvalues: t6 (copy), p69 (ref), u9 (ref), u8 (ref)
		local v293 = t6._getTime()
		local v294 = v293 + p69
		local t16 = {
			resolve = p70,
			startTime = v293,
			endTime = v294
		}

		if u9 == nil then
			u8 = t16
			u9 = t6._timeEvent:Connect(function() -- line: 1071
				-- upvalues: t6 (copy), u8 (ref), u9 (ref)
				local v353 = t6._getTime()

				while u8 ~= nil and v353 > u8.endTime do
					local v354 = u8

					u8 = v354.next

					if u8 == nil then
						u9:Disconnect()
						u9 = nil
					else
						u8.previous = nil
					end

					v354.resolve(t6._getTime() - v354.startTime)
				end
			end)
		elseif v294 > u8.endTime then
			local v296 = u8
			local next2 = v296.next

			while next2 ~= nil and v294 > next2.endTime do
				v296 = next2
				next2 = v296.next
			end

			v296.next = t16
			t16.previous = v296

			if next2 ~= nil then
				t16.next = next2
				next2.previous = t16
			end
		else
			t16.next = u8
			u8.previous = t16
			u8 = t16
		end

		p72(function() -- line: 1116
			-- upvalues: t16 (copy), u8 (ref), u9 (ref)
			local next3 = t16.next

			if u8 == t16 then
				if next3 == nil then
					u9:Disconnect()
					u9 = nil
				else
					next3.previous = nil
				end

				u8 = next3

				return
			end

			local previous = t16.previous

			previous.next = next3

			if next3 ~= nil then
				next3.previous = previous
			end
		end)
	end)
end
function t6.prototype.timeout(p73, p74, p75) -- line: 1180
	-- upvalues: t6 (copy), t3 (ref)
	local trace = debug.traceback(nil, 2)

	return t6.race({
		t6.delay(p74):andThen(function() -- line: 1184
			-- upvalues: t6 (copy), p75 (copy), t3 (ref), p74 (copy), trace (copy)
			return t6.reject(p75 == nil and t3.new({
				error = "Timed out",
				kind = t3.Kind.TimedOut,
				context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", p74, trace)
			}) or p75)
		end),
		p73
	})
end
function t6.prototype.getStatus(p76) -- line: 1204
	return p76._status
end
function t6.prototype._andThen(p77, p78, p79, p80) -- line: 1213
	-- upvalues: t6 (copy), runExecutor (copy)
	p77._unhandledRejection = false

	if p77._status == t6.Status.Cancelled then
		local v113 = t6.new(function() -- line: 1218
		end)

		v113:cancel()

		return v113
	end

	return t6._new(p78, function(p81, p82, p83) -- line: 1225
		-- upvalues: p79 (copy), p78 (copy), runExecutor (copy), p80 (copy), p77 (copy), t6 (copy)
		local u301 = p81

		if p79 then
			local v302 = p78
			local v303 = p79

			function u301(...) -- line: 180
				-- upvalues: runExecutor (copy), v302 (copy), v303 (copy), p81 (copy), p82 (copy)
				local v357, v358, v359 = runExecutor(v302, v303, ...)

				if v357 then
					p81(unpack(v359, 1, v358))

					return
				end

				p82(v359[1])
			end
		end

		local u304 = p82

		if p80 then
			local v305 = p78
			local v306 = p80

			function u304(...) -- line: 180
				-- upvalues: runExecutor (copy), v305 (copy), v306 (copy), p81 (copy), p82 (copy)
				local v360, v361, v362 = runExecutor(v305, v306, ...)

				if v360 then
					p81(unpack(v362, 1, v361))

					return
				end

				p82(v362[1])
			end
		end

		if p77._status == t6.Status.Started then
			table.insert(p77._queuedResolve, u301)
			table.insert(p77._queuedReject, u304)
			p83(function() -- line: 1244
				-- upvalues: p77 (copy), t6 (copy), u301 (ref), u304 (ref)
				if p77._status == t6.Status.Started then
					table.remove(p77._queuedResolve, table.find(p77._queuedResolve, u301))
					table.remove(p77._queuedReject, table.find(p77._queuedReject, u304))
				end
			end)
		elseif p77._status == t6.Status.Resolved then
			u301(unpack(p77._values, 1, p77._valuesLength))
		elseif p77._status == t6.Status.Rejected then
			u304(unpack(p77._values, 1, p77._valuesLength))
		end
	end, p77)
end
function t6.prototype.andThen(p84, p85, p86) -- line: 1283
	local v117 = true
	local g121 = nil
	local g118

	if p85 ~= nil then
		g118 = nil

		if type(p85) == "function" then
			v117 = true
			g118 = true
		end

		if not g118 then
			if type(p85) == "table" then
				local mt = getmetatable(p85)

				if mt and type((rawget(mt, "__call"))) == "function" then
					v117 = true
					g118 = true
				end
			end

			if not g118 then
				v117 = false
				g118 = true
			end
		end
	end

	g118 = false
	assert(v117, string.format("Please pass a handler function to %s!", "Promise:andThen"))

	local v120 = true

	if p86 ~= nil then
		if type(p86) == "function" then
			v120 = true
			g121 = true
		end

		if not g121 then
			if type(p86) == "table" then
				local mt = getmetatable(p86)

				if mt and type((rawget(mt, "__call"))) == "function" then
					v120 = true
					g121 = true
				end
			end

			if not g121 then
				v120 = false
				g121 = true
			end
		end
	end

	g121 = false
	assert(v120, string.format("Please pass a handler function to %s!", "Promise:andThen"))

	return p84:_andThen(debug.traceback(nil, 2), p85, p86)
end
function t6.prototype.catch(p87, p88) -- line: 1310
	local v125 = true
	local g126

	if p88 ~= nil then
		g126 = nil

		if type(p88) == "function" then
			v125 = true
			g126 = true
		end

		if not g126 then
			if type(p88) == "table" then
				local mt = getmetatable(p88)

				if mt and type((rawget(mt, "__call"))) == "function" then
					v125 = true
					g126 = true
				end
			end

			if not g126 then
				v125 = false
				g126 = true
			end
		end
	end

	g126 = false
	assert(v125, string.format("Please pass a handler function to %s!", "Promise:catch"))

	return p87:_andThen(debug.traceback(nil, 2), nil, p88)
end
function t6.prototype.tap(p89, p90) -- line: 1331
	-- upvalues: t6 (copy), pack (copy)
	local g131 = nil
	local mt = nil
	local v130 = nil

	if type(p90) == "function" then
		v130 = true
		g131 = true
	end

	repeat
		if g131 or (g131 or type(p90) == "table") then
			if not g131 then
				if not g131 then
					mt = getmetatable(p90)
				end
			end

			if g131 or (g131 or mt and type((rawget(mt, "__call"))) == "function") then
				if not g131 then
					if not g131 then
						v130 = true
					end
				end

				g131 = false
				assert(v130, string.format("Please pass a handler function to %s!", "Promise:tap"))

				return p89:_andThen(debug.traceback(nil, 2), function(...) -- line: 1333
					-- upvalues: p90 (copy), t6 (copy), pack (copy)
					local v307 = p90(...)

					if t6.is(v307) then
						local v308, v309 = pack(...)

						return v307:andThen(function() -- line: 1338
							-- upvalues: v309 (copy), v308 (copy)
							return unpack(v309, 1, v308)
						end)
					end

					return ...
				end)
			end
		end

		v130 = false
		g131 = true
	until not g131
end
function t6.prototype.andThenCall(p91, p92, ...) -- line: 1366
	-- upvalues: pack (copy)
	local g136 = nil
	local mt = nil
	local v135 = nil

	if type(p92) == "function" then
		v135 = true
		g136 = true
	end

	repeat
		if g136 or (g136 or type(p92) == "table") then
			if not g136 then
				if not g136 then
					mt = getmetatable(p92)
				end
			end

			if g136 or (g136 or mt and type((rawget(mt, "__call"))) == "function") then
				if not g136 then
					if not g136 then
						v135 = true
					end
				end

				g136 = false
				assert(v135, string.format("Please pass a handler function to %s!", "Promise:andThenCall"))

				local v138, v139 = pack(...)

				return p91:_andThen(debug.traceback(nil, 2), function() -- line: 1369
					-- upvalues: p92 (copy), v139 (copy), v138 (copy)
					return p92(unpack(v139, 1, v138))
				end)
			end
		end

		v135 = false
		g136 = true
	until not g136
end
function t6.prototype.andThenReturn(p93, ...) -- line: 1396
	-- upvalues: pack (copy)
	local v141, v142 = pack(...)

	return p93:_andThen(debug.traceback(nil, 2), function() -- line: 1398
		-- upvalues: v142 (copy), v141 (copy)
		return unpack(v142, 1, v141)
	end)
end
function t6.prototype.cancel(p94) -- line: 1414
	-- upvalues: t6 (copy)
	if p94._status ~= t6.Status.Started then
		return
	end

	p94._status = t6.Status.Cancelled

	if p94._cancellationHook then
		p94._cancellationHook()
	end

	coroutine.close(p94._thread)

	if p94._parent then
		p94._parent:_consumerCancelled(p94)
	end

	for k in pairs(p94._consumers) do
		k:cancel()
	end

	p94:_finalize()
end
function t6.prototype._consumerCancelled(p95, p96) -- line: 1442
	-- upvalues: t6 (copy)
	if p95._status ~= t6.Status.Started then
		return
	end

	p95._consumers[p96] = nil

	if next(p95._consumers) == nil then
		p95:cancel()
	end
end
function t6.prototype._finally(p97, p98, p99) -- line: 1458
	-- upvalues: t6 (copy)
	p97._unhandledRejection = false

	return (t6._new(p98, function(p100, p101, p102) -- line: 1461
		-- upvalues: p97 (copy), p99 (copy), t6 (copy)
		local u313 = nil

		p102(function() -- line: 1464
			-- upvalues: p97 (copy), u313 (ref)
			p97:_consumerCancelled(p97)

			if u313 then
				u313:cancel()
			end
		end)

		local v314 = p100

		if p99 then
			function v314(...) -- line: 1477
				-- upvalues: p99 (copy), t6 (copy), u313 (ref), p100 (copy), p97 (copy), p101 (copy)
				local v363 = p99(...)

				if t6.is(v363) then
					u313 = v363
					v363:finally(function(p103) -- line: 1484
						-- upvalues: t6 (copy), p100 (copy), p97 (copy)
						if p103 ~= t6.Status.Rejected then
							p100(p97)
						end
					end):catch(function(...) -- line: 1489
						-- upvalues: p101 (copy)
						p101(...)
					end)

					return
				end

				p100(p97)
			end
		end

		if p97._status == t6.Status.Started then
			table.insert(p97._queuedFinally, v314)
		else
			v314(p97._status)
		end
	end))
end
function t6.prototype.finally(p104, p105) -- line: 1559
	local v152 = true
	local g153

	if p105 ~= nil then
		g153 = nil

		if type(p105) == "function" then
			v152 = true
			g153 = true
		end

		if not g153 then
			if type(p105) == "table" then
				local mt = getmetatable(p105)

				if mt and type((rawget(mt, "__call"))) == "function" then
					v152 = true
					g153 = true
				end
			end

			if not g153 then
				v152 = false
				g153 = true
			end
		end
	end

	g153 = false
	assert(v152, string.format("Please pass a handler function to %s!", "Promise:finally"))

	return p104:_finally(debug.traceback(nil, 2), p105)
end
function t6.prototype.finallyCall(p106, p107, ...) -- line: 1573
	-- upvalues: pack (copy)
	local g158 = nil
	local mt = nil
	local v157 = nil

	if type(p107) == "function" then
		v157 = true
		g158 = true
	end

	repeat
		if g158 or (g158 or type(p107) == "table") then
			if not g158 then
				if not g158 then
					mt = getmetatable(p107)
				end
			end

			if g158 or (g158 or mt and type((rawget(mt, "__call"))) == "function") then
				if not g158 then
					if not g158 then
						v157 = true
					end
				end

				g158 = false
				assert(v157, string.format("Please pass a handler function to %s!", "Promise:finallyCall"))

				local v160, v161 = pack(...)

				return p106:_finally(debug.traceback(nil, 2), function() -- line: 1576
					-- upvalues: p107 (copy), v161 (copy), v160 (copy)
					return p107(unpack(v161, 1, v160))
				end)
			end
		end

		v157 = false
		g158 = true
	until not g158
end
function t6.prototype.finallyReturn(p108, ...) -- line: 1599
	-- upvalues: pack (copy)
	local v163, v164 = pack(...)

	return p108:_finally(debug.traceback(nil, 2), function() -- line: 1601
		-- upvalues: v164 (copy), v163 (copy)
		return unpack(v164, 1, v163)
	end)
end
function t6.prototype.awaitStatus(p109) -- line: 1613
	-- upvalues: t6 (copy)
	p109._unhandledRejection = false

	if p109._status == t6.Status.Started then
		local thread = coroutine.running()

		p109:finally(function() -- line: 1620
			-- upvalues: thread (copy)
			task.spawn(thread)
		end):catch(function() -- line: 1626
		end)
		coroutine.yield()
	end

	if p109._status == t6.Status.Resolved then
		return p109._status, unpack(p109._values, 1, p109._valuesLength)
	end

	if p109._status == t6.Status.Rejected then
		return p109._status, unpack(p109._values, 1, p109._valuesLength)
	end

	return p109._status
end

local function awaitHelper(p110, ...) -- line: 1641
	-- upvalues: t6 (copy)
	return p110 == t6.Status.Resolved, ...
end

function t6.prototype.await(p111) -- line: 1666
	-- upvalues: awaitHelper (copy)
	return awaitHelper(p111:awaitStatus())
end

local function expectHelper(p112, ...) -- line: 1670
	-- upvalues: t6 (copy)
	if p112 ~= t6.Status.Resolved then
		error(if ... ~= nil then ... else "Expected Promise rejected with no value.", 3)
	end

	return ...
end

function t6.prototype.expect(p113) -- line: 1703
	-- upvalues: expectHelper (copy)
	return expectHelper(p113:awaitStatus())
end

t6.prototype.awaitValue = t6.prototype.expect

function t6.prototype._unwrap(p114) -- line: 1717
	-- upvalues: t6 (copy)
	if p114._status == t6.Status.Started then
		error("Promise has not resolved or rejected.", 2)
	end

	return p114._status == t6.Status.Resolved, unpack(p114._values, 1, p114._valuesLength)
end
function t6.prototype._resolve(p115, ...) -- line: 1727
	-- upvalues: t6 (copy), t3 (ref), pack (copy)
	if p115._status ~= t6.Status.Started then
		if t6.is((...)) then
			(...):_consumerCancelled(p115)
		end

		return
	end

	if t6.is((...)) then
		if select("#", ...) > 1 then
			local v173 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", p115._source)

			warn(v173)
		end

		local v174 = ...
		local v175 = v174:andThen(function(...) -- line: 1748
			-- upvalues: p115 (copy)
			p115:_resolve(...)
		end, function(...) -- line: 1750
			-- upvalues: v174 (copy), t3 (ref), p115 (copy)
			local v315 = v174._values[1]

			if v174._error then
				v315 = t3.new({
					context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
					error = v174._error,
					kind = t3.Kind.ExecutionError
				})
			end

			if t3.isKind(v315, t3.Kind.ExecutionError) then
				return p115:_reject(v315:extend({
					error = "This Promise was chained to a Promise that errored.",
					trace = "",
					context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", p115._source)
				}))
			end

			p115:_reject(...)
		end)

		if v175._status == t6.Status.Cancelled then
			p115:cancel()

			return
		end

		if v175._status == t6.Status.Started then
			p115._parent = v175
			v175._consumers[p115] = true
		end

		return
	end

	p115._status = t6.Status.Resolved

	local v176, v177 = pack(...)

	p115._valuesLength = v176
	p115._values = v177

	for _, v in ipairs(p115._queuedResolve) do
		coroutine.wrap(v)(...)
	end

	p115:_finalize()
end
function t6.prototype._reject(p116, ...) -- line: 1798
	-- upvalues: t6 (copy), pack (copy)
	if p116._status ~= t6.Status.Started then
		return
	end

	p116._status = t6.Status.Rejected

	local v181, v182 = pack(...)

	p116._valuesLength = v181
	p116._values = v182

	local _queuedReject = p116._queuedReject

	if next(_queuedReject) ~= nil then
		for _, v in ipairs(p116._queuedReject) do
			coroutine.wrap(v)(...)
		end
	else
		local str = tostring((...))

		coroutine.wrap(function() -- line: 1820
			-- upvalues: t6 (copy), p116 (copy), str (copy)
			t6._timeEvent:Wait()

			if not p116._unhandledRejection then
				return
			end

			local v316 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", str, p116._source)

			for _, v in ipairs(t6._unhandledRejectionCallbacks) do
				task.spawn(v, p116, unpack(p116._values, 1, p116._valuesLength))
			end

			if t6.TEST then
				return
			end

			warn(v316)
		end)()
	end

	p116:_finalize()
end
function t6.prototype._finalize(p117) -- line: 1852
	-- upvalues: t6 (copy)
	for _, v in ipairs(p117._queuedFinally) do
		coroutine.wrap(v)(p117._status)
	end

	p117._queuedFinally = nil
	p117._queuedReject = nil
	p117._queuedResolve = nil

	if not t6.TEST then
		p117._parent = nil
		p117._consumers = nil
	end

	task.defer(coroutine.close, p117._thread)
end
function t6.prototype.now(p118, p119) -- line: 1889
	-- upvalues: t6 (copy), t3 (ref)
	local trace = debug.traceback(nil, 2)

	if p118._status == t6.Status.Resolved then
		return p118:_andThen(trace, function(...) -- line: 1892
			return ...
		end)
	end

	return t6.reject(p119 == nil and t3.new({
		error = "This Promise was not resolved in time for :now()",
		kind = t3.Kind.NotResolvedInTime,
		context = ":now() was called at:\n\n" .. trace
	}) or p119)
end
function t6.retry(p120, p121, ...) -- line: 1934
	-- upvalues: t6 (copy)
	local g196 = nil
	local mt = nil
	local v195 = nil

	if type(p120) == "function" then
		v195 = true
		g196 = true
	end

	repeat
		if g196 or (g196 or type(p120) == "table") then
			if not g196 then
				if not g196 then
					mt = getmetatable(p120)
				end
			end

			if g196 or (g196 or mt and type((rawget(mt, "__call"))) == "function") then
				if not g196 then
					if not g196 then
						v195 = true
					end
				end

				g196 = false
				assert(v195, "Parameter #1 to Promise.retry must be a function")
				assert(type(p121) == "number", "Parameter #2 to Promise.retry must be a number")

				local t17 = { ... }
				local v199 = select("#", ...)

				return t6.resolve(p120(...)):catch(function(...) -- line: 1940
					-- upvalues: p121 (copy), t6 (copy), p120 (copy), t17 (copy), v199 (copy)
					if p121 > 0 then
						return t6.retry(p120, p121 - 1, unpack(t17, 1, v199))
					end

					return t6.reject(...)
				end)
			end
		end

		v195 = false
		g196 = true
	until not g196
end
function t6.retryWithDelay(p122, p123, p124, ...) -- line: 1962
	-- upvalues: t6 (copy)
	local g204 = nil
	local mt = nil
	local v203 = nil

	if type(p122) == "function" then
		v203 = true
		g204 = true
	end

	repeat
		if g204 or (g204 or type(p122) == "table") then
			if not g204 then
				if not g204 then
					mt = getmetatable(p122)
				end
			end

			if g204 or (g204 or mt and type((rawget(mt, "__call"))) == "function") then
				if not g204 then
					if not g204 then
						v203 = true
					end
				end

				g204 = false
				assert(v203, "Parameter #1 to Promise.retry must be a function")
				assert(type(p123) == "number", "Parameter #2 (times) to Promise.retry must be a number")
				assert(type(p124) == "number", "Parameter #3 (seconds) to Promise.retry must be a number")

				local t18 = { ... }
				local v207 = select("#", ...)

				return t6.resolve(p122(...)):catch(function(...) -- line: 1969
					-- upvalues: p123 (copy), t6 (copy), p124 (copy), p122 (copy), t18 (copy), v207 (copy)
					if p123 > 0 then
						t6.delay(p124):await()

						return t6.retryWithDelay(p122, p123 - 1, p124, unpack(t18, 1, v207))
					end

					return t6.reject(...)
				end)
			end
		end

		v203 = false
		g204 = true
	until not g204
end
function t6.fromEvent(p125, p126) -- line: 2004
	-- upvalues: t6 (copy)
	local u210 = p126 or function() -- line: 2005
		return true
	end

	return t6._new(debug.traceback(nil, 2), function(p127, _, p129) -- line: 2009
		-- upvalues: p125 (copy), u210 (ref)
		local u322 = nil
		local u323 = false

		local function disconnect() -- line: 2013
			-- upvalues: u322 (ref)
			u322:Disconnect()
			u322 = nil
		end

		u322 = p125:Connect(function(...) -- line: 2022
			-- upvalues: u210 (ref), p127 (copy), u322 (ref), u323 (ref)
			local v364 = u210(...)

			if v364 == true then
				p127(...)

				if u322 then
					u322:Disconnect()
					u322 = nil

					return
				end

				u323 = true

				return
			end

			if type(v364) ~= "boolean" then
				error("Promise.fromEvent predicate should always return a boolean")
			end
		end)

		if u323 and u322 then
			return disconnect()
		end

		p129(disconnect)
	end)
end
function t6.onUnhandledRejection(p130) -- line: 2056
	-- upvalues: t6 (copy)
	table.insert(t6._unhandledRejectionCallbacks, p130)

	return function() -- line: 2059
		-- upvalues: t6 (copy), p130 (copy)
		local v325 = table.find(t6._unhandledRejectionCallbacks, p130)

		if v325 then
			table.remove(t6._unhandledRejectionCallbacks, v325)
		end
	end
end

return t6
