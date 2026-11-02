-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: spring, time of decompilation: Sun May  3 10:10:46 2026 ]]
local utilsIntermediate = require("./utils/intermediate")
local utilsSchedule = require("./utils/schedule")
local utilsSignal = require("./utils/signal")

require("./types")

local getValue = utilsIntermediate.getValue
local recomputeValue = utilsIntermediate.recomputeValue
local t1 = {}

t1.__index = t1

local v7 = utilsSchedule("Spring", function(t2: {[any]: any}, p1, p2) -- line: 84
	-- upvalues: getValue (copy), recomputeValue (copy), utilsIntermediate (copy)
	if t2.complete then
		p2(t2)

		return getValue(t2.position)
	end

	local position = t2.position
	local velocity = t2.velocity
	local goal = t2.goal
	local restPosition = t2.restPosition
	local restVelocity = t2.restVelocity
	local dampingRatio = t2.dampingRatio
	local v20 = t2.frequency * 2 * 3.141592653589793
	local v21 = math.exp(-p1 * dampingRatio * v20)
	local v22 = true
	local components = position.components
	local components2 = velocity.components
	local components3 = goal.components

	if dampingRatio == 1 then
		for v26, v27 in components do
			local v28 = components2[v26]
			local v29 = components3[v26]
			local v30 = v27 - v29
			local v31 = (v28 * p1 + v30 * (v20 * p1 + 1)) * v21 + v29
			local v32 = (v28 - v20 * p1 * (v30 * v20 + v28)) * v21

			if v22 then
				local v33 = v31 - v29

				if type(v33) == "number" then
					v22 = restPosition >= math.abs(v33)
				else
					local v34 = vector.abs(v33)

					v22 = restPosition >= math.max(v34.x, v34.y, v34.z)
				end

				if v22 then
					if type(v32) == "number" then
						v22 = restVelocity >= math.abs(v32)
					else
						local v35 = vector.abs(v32)

						v22 = restVelocity >= math.max(v35.x, v35.y, v35.z)
					end
				end
			end

			components[v26] = v31
			components2[v26] = v32
		end
	elseif dampingRatio < 1 then
		local v36 = (1 - dampingRatio * dampingRatio) ^ 0.5
		local v37 = math.cos(v20 * v36 * p1)
		local v38 = math.sin(v20 * v36 * p1)
		local v39

		if v36 > 0.0001 then
			v39 = v38 / v36
		else
			local v40 = p1 * v20

			v39 = v40 + (v40 * v40 * (v36 * v36) * (v36 * v36) / 20 - v36 * v36) * (v40 * v40 * v40) / 6
		end

		local v41

		if v20 * v36 > 0.0001 then
			v41 = v38 / (v20 * v36)
		else
			local v42 = v20 * v36

			v41 = p1 + (p1 * p1 * (v42 * v42) * (v42 * v42) / 20 - v42 * v42) * (p1 * p1 * p1) / 6
		end

		for v43, v44 in components do
			local v45 = components2[v43]
			local v46 = components3[v43]
			local v47 = v44 - v46
			local v48 = (v47 * (v37 + dampingRatio * v39) + v45 * v41) * v21 + v46
			local v49 = (v45 * (v37 - v39 * dampingRatio) - v47 * (v39 * v20)) * v21

			if v22 then
				local v50 = v48 - v46

				if type(v50) == "number" then
					v22 = restPosition >= math.abs(v50)
				else
					local v51 = vector.abs(v50)

					v22 = restPosition >= math.max(v51.x, v51.y, v51.z)
				end

				if v22 then
					if type(v49) == "number" then
						v22 = restVelocity >= math.abs(v49)
					else
						local v52 = vector.abs(v49)

						v22 = restVelocity >= math.max(v52.x, v52.y, v52.z)
					end
				end
			end

			components[v43] = v48
			components2[v43] = v49
		end
	else
		local v53 = math.sqrt(dampingRatio * dampingRatio - 1)
		local v54 = -v20 * (dampingRatio - v53)
		local v55 = -v20 * (dampingRatio + v53)
		local v56 = math.exp(v54 * p1)
		local v57 = math.exp(v55 * p1)

		for v58, v59 in components do
			local v60 = components2[v58]
			local v61 = components3[v58]
			local v62 = v59 - v61
			local v63 = (v60 - v62 * v54) / (2 * v20 * v53)
			local v64 = v56 * (v62 - v63)
			local v65 = v64 + v63 * v57 + v61
			local v66 = v64 * v54 + v63 * v57 * v55

			if v22 then
				local v67 = v65 - v61

				if type(v67) == "number" then
					v22 = restPosition >= math.abs(v67)
				else
					local v68 = vector.abs(v67)

					v22 = restPosition >= math.max(v68.x, v68.y, v68.z)
				end

				if v22 then
					if type(v66) == "number" then
						v22 = restVelocity >= math.abs(v66)
					else
						local v69 = vector.abs(v66)

						v22 = restVelocity >= math.max(v69.x, v69.y, v69.z)
					end
				end
			end

			components[v58] = v65
			components2[v58] = v66
		end
	end

	local v70 = if v22 then getValue(goal) else recomputeValue(position)

	velocity.dirty = true
	t2.complete = v22
	t2.fireChange(v70, p1)

	if v22 then
		p2(t2)
		utilsIntermediate.assign(position, goal)
		utilsIntermediate.zero(velocity)
		t2.fireComplete(v70)
	end

	return v70
end)

function t1.scheduleUpdate(p3) -- line: 240
	-- upvalues: v7 (copy)
	p3.state.complete = false

	if p3.state.started then
		v7.add(p3.state)
	end
end
function t1.start(p4) -- line: 248
	-- upvalues: v7 (copy)
	p4.state.started = true

	if not p4.state.complete then
		v7.add(p4.state)
	end
end
function t1.stop(p5) -- line: 256
	-- upvalues: v7 (copy)
	p5.state.started = false
	v7.remove(p5.state)
end
function t1.idle(p6) -- line: 261
	return p6.state.complete
end
function t1.step(t3: {[any]: any}, n1: number) -- line: 265
	-- upvalues: v7 (copy)
	return v7.update(t3.state, n1)
end
function t1.configure(t4: {[any]: any}, t5: {[any]: any}) -- line: 269
	local state = t4.state

	state.restPosition = t5.precision or state.restPosition
	state.restVelocity = t5.restVelocity or state.restPosition * 62.5

	if t5.dampingRatio or t5.frequency then
		state.dampingRatio = t5.dampingRatio or state.dampingRatio
		state.frequency = t5.frequency or state.frequency
	else
		local v89 = t5.tension or 170
		local v90 = t5.friction or 26
		local v91 = t5.mass or 1

		state.dampingRatio = v90 / (2 * (v91 * v89) ^ 0.5)
		state.frequency = (v89 / v91) ^ 0.5 / 2 / 3.141592653589793
	end

	if t5.velocity then
		t4:setVelocity(t5.velocity)
	end

	if t5.impulse then
		t4:impulse(t5.impulse)
	end

	if t5.position then
		t4:setPosition(t5.position)
	end
end
function t1.getPosition(p7) -- line: 300
	-- upvalues: utilsIntermediate (copy)
	return utilsIntermediate.getValue(p7.state.position)
end
function t1.getVelocity(p8) -- line: 304
	-- upvalues: utilsIntermediate (copy)
	return utilsIntermediate.getValue(p8.state.velocity)
end
function t1.getGoal(p9) -- line: 308
	-- upvalues: utilsIntermediate (copy)
	return utilsIntermediate.getValue(p9.state.goal)
end
function t1.setPosition(p10, p11) -- line: 312
	-- upvalues: utilsIntermediate (copy)
	if utilsIntermediate.setValue(p10.state.position, p11) then
		p10:scheduleUpdate()
		p10.state.fireChange(utilsIntermediate.getValue(p10.state.position), 0)
	end
end
function t1.setVelocity(p12, p13) -- line: 319
	-- upvalues: utilsIntermediate (copy)
	if utilsIntermediate.setValue(p12.state.velocity, p13) then
		p12:scheduleUpdate()
	end
end
function t1.setGoal(t6: {[any]: any}, p14, t7: {[any]: any}?) -- line: 325
	-- upvalues: utilsIntermediate (copy)
	if t7 then
		t6:configure(t7)
	end

	if utilsIntermediate.setValue(t6.state.goal, p14) then
		t6:scheduleUpdate()
	end
end
function t1.impulse(p15, p16) -- line: 335
	-- upvalues: utilsIntermediate (copy)
	utilsIntermediate.addValue(p15.state.velocity, p16)
	p15:scheduleUpdate()
end
function t1.halt(p17) -- line: 340
	-- upvalues: utilsIntermediate (copy)
	utilsIntermediate.zero(p17.state.velocity)
end
function t1.onChange(t8: {[any]: any}, p18: ((...any) -> ...any)) -- line: 344
	return t8.state.onChange(p18)
end
function t1.onComplete(t9: {[any]: any}, p19: ((...any) -> ...any)) -- line: 348
	return t9.state.onComplete(p19)
end
function t1.destroy(p20) -- line: 352
	p20:stop()
end

return {
	scheduler = v7,
	createSpring = function(p21, t10: {[any]: any}?) --[[ createSpring ]] -- line: 204
		-- upvalues: utilsIntermediate (copy), utilsSignal (copy), t1 (copy)
		local v73 = t10 or {}
		local v74 = utilsIntermediate.create(v73.position or p21)
		local v75, v76 = utilsSignal()
		local v77, v78 = utilsSignal()
		local v79 = setmetatable({
			state = {
				dampingRatio = 1,
				frequency = 1,
				restPosition = 0.001,
				restVelocity = 0.0625,
				started = false,
				complete = true,
				position = v74,
				velocity = utilsIntermediate.zero(utilsIntermediate.copy(v74)),
				goal = utilsIntermediate.copy(v74),
				onChange = v75,
				fireChange = v76,
				onComplete = v77,
				fireComplete = v78
			}
		}, t1)

		v79:configure(v73)

		if v73.start then
			v79:start()
		end

		return v79
	end
}
