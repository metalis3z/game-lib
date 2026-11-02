local PurchasePromptDeps = require(script.Parent.PurchasePromptDeps)
local Otter = PurchasePromptDeps.Otter

local activeMotors = {}

local function AnimateFrame(frame, options)
	assert(typeof(frame) == "Instance" and frame:IsA("GuiObject"), "Expected a GuiObject")

	if activeMotors[frame] then
		activeMotors[frame]:destroy()
		activeMotors[frame] = nil
	end

	local startValue = options.startValue or 1
	local endValue = options.endValue or 0
	local springConfig = options.springConfig or {
		dampingRatio = 1,
		frequency = 1.6,
	}
	local onStep = options.onStep
	local property = options.property or "Position"
	local map = options.map

	local motor = Otter.createSingleMotor(startValue)

	activeMotors[frame] = motor

	motor:onStep(function(value)
		if map then
			frame[property] = map(value)
		else
			frame[property] = value
		end
		if onStep then
			onStep(value)
		end
	end)

	motor:onComplete(function()
		if activeMotors[frame] == motor then
			activeMotors[frame] = nil
		end
	end)

	motor:start()
	motor:setGoal(Otter.spring(endValue, springConfig))
end

return AnimateFrame