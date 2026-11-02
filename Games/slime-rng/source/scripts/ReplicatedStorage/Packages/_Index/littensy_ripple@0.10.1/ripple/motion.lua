-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: motion, time of decompilation: Sun May  3 10:10:46 2026 ]]
local utilsSchedule = require("./utils/schedule")
local utilsSignal = require("./utils/signal")
local spring = require("./spring")
local tween = require("./tween")

require("./types")

local t1 = {}

t1.__index = t1

local v6 = utilsSchedule("Motion", function(t2: {[any]: any}, p1, p2) -- line: 69
	if t2.complete then
		p2(t2)

		return t2.current:getPosition()
	end

	local v10 = t2.current:step(p1)

	if t2.current:idle() then
		p2(t2)
		t2.complete = true
		t2.fireComplete(v10)
	end

	return v10
end)

function t1.scheduleUpdate(p3) -- line: 141
	-- upvalues: v6 (copy)
	p3.state.complete = false

	if p3.state.started then
		v6.add(p3.state)
	end
end
function t1.prepareSpring(p4) -- line: 149
	local state = p4.state

	if state.current ~= state.spring then
		state.spring:setPosition(state.tween:getPosition())
		state.current = state.spring
	end
end
function t1.prepareTween(p5) -- line: 158
	local state = p5.state

	if state.current ~= state.tween then
		state.tween:setPosition(state.spring:getPosition())
		state.spring:halt()
		state.current = state.tween
	end
end
function t1.start(p6) -- line: 168
	-- upvalues: v6 (copy)
	p6.state.started = true

	if not p6.state.complete then
		v6.add(p6.state)
	end
end
function t1.stop(p7) -- line: 176
	-- upvalues: v6 (copy)
	p7.state.started = false
	v6.remove(p7.state)
end
function t1.idle(p8) -- line: 181
	return p8.state.complete
end
function t1.step(t3: {[any]: any}, n1: number) -- line: 185
	-- upvalues: v6 (copy)
	return v6.update(t3.state, n1)
end
function t1.configure(t4: {[any]: any}, t5: {[any]: any}) -- line: 189
	if t5.spring then
		t4.state.spring:configure(t5.spring)
	end

	if t5.tween then
		t4.state.tween:configure(t5.tween)
	end

	if not t4.state.current:idle() then
		t4:scheduleUpdate()
	end
end
function t1.getPosition(p9) -- line: 203
	return p9.state.current:getPosition()
end
function t1.getVelocity(p10) -- line: 207
	return p10.state.spring:getVelocity()
end
function t1.getGoal(p11) -- line: 211
	return p11.state.current:getGoal()
end
function t1.setPosition(p12, p13) -- line: 215
	p12.state.current:setPosition(p13)

	if not p12.state.current:idle() then
		p12:scheduleUpdate()
	end
end
function t1.setVelocity(p14, p15) -- line: 223
	if p14.state.current == p14.state.spring then
		p14.state.spring:setVelocity(p15)

		if not p14.state.current:idle() then
			p14:scheduleUpdate()
		end
	end
end
function t1.setGoal(t6: {[any]: any}, p16, t7: {[any]: any}?) -- line: 233
	if t7 then
		if t7.spring then
			return t6:spring(p16, t7.spring)
		end

		if t7.tween then
			return t6:tween(p16, t7.tween)
		end
	end

	t6.state.current:setGoal(p16)

	if not t6.state.current:idle() then
		t6:scheduleUpdate()
	end
end
function t1.spring(p17, p18, p19) -- line: 249
	p17:prepareSpring()
	p17.state.spring:setGoal(p18, p19)

	if not p17.state.spring:idle() then
		p17:scheduleUpdate()
	end
end
function t1.tween(p20, p21, p22) -- line: 258
	p20:prepareTween()
	p20.state.tween:setGoal(p21, p22)

	if not p20.state.tween:idle() then
		p20:scheduleUpdate()
	end
end
function t1.onChange(t8: {[any]: any}, p23: ((...any) -> ...any)) -- line: 267
	return t8.state.onChange(p23)
end
function t1.onComplete(t9: {[any]: any}, p24: ((...any) -> ...any)) -- line: 271
	return t9.state.onComplete(p24)
end
function t1.destroy(p25) -- line: 275
	p25:stop()
end

return {
	scheduler = v6,
	createMotion = function(p26, t10: {[any]: any}?) --[[ createMotion ]] -- line: 98
		-- upvalues: spring (copy), tween (copy), utilsSignal (copy), t1 (copy)
		local v15 = t10 or {}
		local createSpring = spring.createSpring
		local spring2 = v15.spring

		if spring2 == nil or spring2.start ~= true then
		else
			spring2 = table.clone(spring2)
			spring2.start = nil
		end

		local v18 = createSpring(p26, spring2)
		local createTween = tween.createTween
		local tween2 = v15.tween

		if tween2 == nil or tween2.start ~= true then
		else
			tween2 = table.clone(tween2)
			tween2.start = nil
		end

		local v21 = createTween(p26, tween2)
		local v22 = if v15.tween then v21 else v18
		local v23, v24 = utilsSignal()
		local v25, v26 = utilsSignal()
		local t11 = {
			started = false,
			complete = true,
			spring = v18,
			tween = v21,
			current = v22,
			onChange = v23,
			onComplete = v25,
			fireComplete = v26
		}
		local v28 = setmetatable({
			state = t11
		}, t1)

		if v15.start then
			v28:start()
		end

		v18:onChange(function(p27, n2: number) -- line: 126
			-- upvalues: t11 (copy), v18 (copy), v24 (copy)
			if t11.current == v18 then
				v24(p27, n2)
			end
		end)
		v21:onChange(function(p28, n3: number) -- line: 132
			-- upvalues: t11 (copy), v21 (copy), v24 (copy)
			if t11.current == v21 then
				v24(p28, n3)
			end
		end)

		return v28
	end
}
