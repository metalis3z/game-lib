-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Promise = require(ReplicatedStorage.Library.Modules.Packages.Promise)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = t.tuple(t.optional(t.numberPositive))
local v2 = t.tuple(t.callback)
local t2 = {}

t2.__index = t2
function t2.new(p1) --[[ new | Line: 43 | Upvalues: v1 (copy), t2 (copy), Trove (copy), Signal (copy) ]]
	assert(v1(p1))

	local v2 = t2
	local v3 = setmetatable({}, v2)

	v3._trove = Trove.new()
	v3._queue = {}
	v3._processTimeout = p1 or 60
	v3._processNextEvent = v3._trove:Add(Signal.new())
	v3._destroyed = false
	task.spawn(function() --[[ Line: 54 | Upvalues: v3 (copy), t2 (ref) ]]
		local v1 = false

		v3._processNextEvent:Connect(function() --[[ Line: 56 | Upvalues: v1 (ref) ]]
			v1 = true
		end)

		while not v3._destroyed do
			if not v1 then
				v3._processNextEvent:Wait()
			end

			v1 = false
			task.spawn(t2.ProcessNext, v3)
		end
	end)

	return v3
end
function t2.ProcessNext(p1) --[[ ProcessNext | Line: 76 | Upvalues: Constants (copy) ]]
	if p1.Processing then
		return
	end

	local v1 = p1._queue[1]

	if not v1 then
		return
	end

	p1.Processing = true

	local v2 = false
	local v3 = false

	task.spawn(function() --[[ Line: 90 | Upvalues: v1 (copy), Constants (ref), v3 (ref), v2 (ref), p1 (copy) ]]
		local t = { pcall(function() --[[ Line: 91 | Upvalues: v1 (ref) ]]
				return v1.Callback(table.unpack(v1.Args))
			end) }

		if t[1] then
			table.remove(t, 1)
			v1.ResolvePromise(table.unpack(t))
		else
			local v22 = ("CallbackQueue: %*\n%*"):format(tostring(t[2]), v1.Traceback)

			if Constants.IS_STUDIO then
				error(v22)
			end

			warn(v22)
		end

		v3 = true

		if v2 then
			return
		end

		v2 = true
		table.remove(p1._queue, 1)
		p1.Processing = false
		p1._processNextEvent:Fire()
	end)

	local v4 = os.clock()

	while not v3 and os.clock() - v4 < p1._processTimeout do
		task.wait()
	end

	if v2 then
		return
	end

	v2 = true
	table.remove(p1._queue, 1)
	p1.Processing = false
	p1._processNextEvent:Fire()
end
function t2.Add(p1, p2, ...) --[[ Add | Line: 130 | Upvalues: v2 (copy), Promise (copy) ]]
	assert(v2(p2))
	assert(not p1._destroyed, "Attempted to add to a destroyed CallbackQueue!")

	local t = {
		Callback = p2,
		Args = { ... },
		Traceback = debug.traceback()
	}
	local v3 = Promise.new(function(p1) --[[ Line: 140 | Upvalues: t (copy) ]]
		t.ResolvePromise = p1
	end):catch(warn)

	table.insert(p1._queue, t)
	p1._processNextEvent:Fire()

	return v3
end
function t2.AddAsync(p1, p2, ...) --[[ AddAsync | Line: 150 ]]
	local t = { p1:Add(p2, ...):await() }

	table.remove(t, 1)

	return table.unpack(t)
end
function t2.Destroy(p1) --[[ Destroy | Line: 156 ]]
	p1._destroyed = true
	p1._trove:Destroy()
end

return t2