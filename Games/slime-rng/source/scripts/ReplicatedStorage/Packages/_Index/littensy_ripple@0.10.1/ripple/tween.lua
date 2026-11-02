-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: tween, time of decompilation: Sun May  3 10:10:46 2026 ]]
local easing = require("./easing")
local utilsInterpolate = require("./utils/interpolate")
local utilsMerge = require("./utils/merge")
local utilsSchedule = require("./utils/schedule")
local utilsSignal = require("./utils/signal")

require("./types")

local t1 = {}

t1.__index = t1

local v7 = utilsSchedule("Tween", function(t2: {[any]: any}, p1, p2) -- line: 81
	-- upvalues: utilsInterpolate (copy)
	if t2.complete then
		p2(t2)

		return t2.position
	end

	t2.elapsed = t2.elapsed + p1

	local v14 = math.clamp(t2.elapsed / t2.duration, 0, t2.repeats)
	local repeats = t2.repeats
	local reverses = t2.reverses

	if repeats < 0 then
		repeats = 1e999
	end

	local v17 = if not (repeats > 1) or not (v14 >= 1) then v14 else if not reverses then not (v14 < repeats) and 1 or v14 % 1 else math.abs((v14 - 1) % 2 - 1)
	local v18 = if not (v17 > 0) or not (v17 < 1) then v17 else t2.easingFunction(v17)
	local v19 = utilsInterpolate(t2.from, t2.goal, v18)

	t2.position = v19
	t2.fireChange(v19, p1)

	if v14 == t2.repeats then
		p2(t2)
		t2.complete = true
		t2.fireComplete(v19)
	end

	return v19
end)

function t1.resumeFromCurrentPosition(p3) -- line: 143
	-- upvalues: v7 (copy)
	local state = p3.state

	state.complete = false
	state.elapsed = 0
	state.from = state.position

	if state.started then
		v7.add(state)
	end
end
function t1.start(p4) -- line: 155
	-- upvalues: v7 (copy)
	p4.state.started = true

	if not p4.state.complete then
		v7.add(p4.state)
	end
end
function t1.stop(p5) -- line: 163
	-- upvalues: v7 (copy)
	p5.state.started = false
	v7.remove(p5.state)
end
function t1.idle(p6) -- line: 168
	return p6.state.complete
end
function t1.step(t3: {[any]: any}, n1: number) -- line: 172
	-- upvalues: v7 (copy)
	return v7.update(t3.state, n1)
end
function t1.configure(t4: {[any]: any}, t5: {[any]: any}) -- line: 176
	-- upvalues: easing (copy)
	local state = t4.state

	state.easingFunction = easing[t5.easing] or state.easingFunction
	state.duration = t5.duration or state.duration
	state.repeats = t5.repeats or state.repeats
	state.reverses = t5.reverses or state.reverses

	if t5.position then
		t4:setPosition(t5.position)
	end

	if not state.complete and state.elapsed ~= 0 then
		t4:resumeFromCurrentPosition()
	end
end
function t1.getPosition(p7) -- line: 193
	return p7.state.position
end
function t1.getFrom(p8) -- line: 197
	return p8.state.from
end
function t1.getGoal(p9) -- line: 201
	return p9.state.goal
end
function t1.setPosition(p10, p11) -- line: 205
	-- upvalues: utilsMerge (copy)
	local v44 = if type(p11) ~= "table" then p11 else utilsMerge(p10.state.position, p11)

	if v44 ~= p10.state.position then
		p10.state.position = v44
		p10:resumeFromCurrentPosition()
		p10.state.fireChange(v44, 0)
	end
end
function t1.setGoal(t6: {[any]: any}, p12, t7: {[any]: any}?) -- line: 215
	-- upvalues: utilsMerge (copy)
	if t7 then
		t6:configure(t7)
	end

	local v48 = if type(p12) ~= "table" then p12 else utilsMerge(t6.state.goal, p12)

	if v48 ~= t6.state.goal then
		t6.state.goal = v48
		t6:resumeFromCurrentPosition()
	end
end
function t1.onChange(t8: {[any]: any}, p13: ((...any) -> ...any)) -- line: 228
	return t8.state.onChange(p13)
end
function t1.onComplete(t9: {[any]: any}, p14: ((...any) -> ...any)) -- line: 232
	return t9.state.onComplete(p14)
end
function t1.destroy(p15) -- line: 236
	p15:stop()
end

return {
	scheduler = v7,
	createTween = function(p16, t10: {[any]: any}?) --[[ createTween ]] -- line: 106
		-- upvalues: utilsSignal (copy), easing (copy), t1 (copy)
		local v22 = t10 or {}
		local v23 = v22.position or p16
		local v24, v25 = utilsSignal()
		local v26, v27 = utilsSignal()
		local v28 = setmetatable({
			state = {
				duration = 1,
				repeats = 1,
				reverses = false,
				elapsed = 0,
				started = false,
				complete = true,
				position = v23,
				from = v23,
				goal = v23,
				easingFunction = easing.linear,
				onChange = v24,
				fireChange = v25,
				onComplete = v26,
				fireComplete = v27
			}
		}, t1)

		v28:configure(v22)

		if v22.start then
			v28:start()
		end

		return v28
	end
}
