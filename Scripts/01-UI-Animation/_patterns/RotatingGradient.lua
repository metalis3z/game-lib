--[[
	RotatingGradient  (ModuleScript)
	Continuous rotation for UIGradients (rotating rainbow borders, glowing frames) and for
	GuiObjects themselves (sunburst / rays images behind icons), plus sideways "panning"
	gradients. One shared Heartbeat connection drives everything.

	Derived from techniques in:
	  - brainrot-lab   UIEffects.client     (CollectionService tags RotatingGradient / PanningGradient / SunburstEffect,
	                                         per-instance speed from attributes RotationSpeed / PanSpeed / PanRange)
	  - drill-and-mine HoverController      (rotation updates throttled to 30 Hz: visually identical, far fewer re-rasters)
	  - smash-egg-for-animals GradientPolish / CardStuds (slow rays 14-24 deg/s, skip work while the window is hidden)

	Usage (LocalScript):
		local RotatingGradient = require(game.ReplicatedStorage.UI.RotatingGradient)

		-- rainbow border: a UIStroke with a rainbow UIGradient inside, spun at 90 deg/s
		local stroke = frame.UIStroke
		local grad = RotatingGradient.rainbow(stroke)   -- creates the UIGradient
		RotatingGradient.add(grad, 90)

		-- sunburst image behind a reward icon
		RotatingGradient.add(raysImage, 20)

		-- pan a gradient left/right (sin wave), e.g. a lava bar
		RotatingGradient.addPan(barFrame.UIGradient, 1.5, 0.25)

		-- tag-driven, like brainrot-lab: tag any UIGradient / GuiObject "RotatingGradient"
		RotatingGradient.bindTag("RotatingGradient", 90) -- attribute RotationSpeed overrides per instance
]]

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local RotatingGradient = {}

local UPDATE_INTERVAL = 1 / 30 -- set to 0 for every frame

local spinners = {} -- [Instance] = degrees per second
local panners = {} -- [UIGradient] = { speed, range, axis, t0 }
local conn: RBXScriptConnection? = nil
local accum = 0

local function isShown(inst: Instance): boolean
	-- skip invisible work: the object (or the GuiObject holding a gradient) must be Visible
	local gui = inst:IsA("GuiObject") and inst or inst:FindFirstAncestorWhichIsA("GuiObject")
	if gui and not (gui :: GuiObject).Visible then
		return false
	end
	local layer = inst:FindFirstAncestorWhichIsA("LayerCollector")
	if layer and layer:IsA("ScreenGui") and not layer.Enabled then
		return false
	end
	return true
end

local function step(dt: number)
	accum += dt
	if accum < UPDATE_INTERVAL then
		return
	end
	dt = accum
	accum = 0
	local now = os.clock()

	for inst, speed in pairs(spinners) do
		if inst.Parent == nil then
			spinners[inst] = nil
		elseif isShown(inst) then
			local obj = inst :: any
			obj.Rotation = (obj.Rotation + speed * dt) % 360
		end
	end

	for grad, p in pairs(panners) do
		if grad.Parent == nil then
			panners[grad] = nil
		elseif isShown(grad) then
			local v = math.sin((now - p.t0) * p.speed) * p.range
			grad.Offset = p.axis == "Y" and Vector2.new(0, v) or Vector2.new(v, 0)
		end
	end

	if next(spinners) == nil and next(panners) == nil and conn then
		conn:Disconnect()
		conn = nil
	end
end

local function ensure()
	if not conn then
		conn = RunService.Heartbeat:Connect(step)
	end
end

-- inst: a UIGradient or any GuiObject (ImageLabel sunburst, Frame...). speed in degrees/second.
function RotatingGradient.add(inst: Instance, speed: number?)
	assert(inst:IsA("UIGradient") or inst:IsA("GuiObject"), "RotatingGradient.add expects a UIGradient or GuiObject")
	spinners[inst] = speed or inst:GetAttribute("RotationSpeed") or 90
	ensure()
	return function()
		spinners[inst] = nil
	end
end

-- Sideways sine pan of a gradient's Offset. speed = radians/second, range = max offset (0..1).
function RotatingGradient.addPan(grad: UIGradient, speed: number?, range: number?, axis: string?)
	panners[grad] = {
		speed = speed or grad:GetAttribute("PanSpeed") or 1,
		range = range or grad:GetAttribute("PanRange") or 0.25,
		axis = axis or "X",
		t0 = os.clock(),
	}
	ensure()
	return function()
		panners[grad] = nil
	end
end

function RotatingGradient.remove(inst: Instance)
	spinners[inst] = nil
	panners[inst] = nil
end

-- Creates (or reuses) a rainbow UIGradient under parent (a GuiObject or a UIStroke).
function RotatingGradient.rainbow(parent: Instance, steps: number?): UIGradient
	local n = steps or 6
	local keys = {}
	for i = 0, n do
		table.insert(keys, ColorSequenceKeypoint.new(i / n, Color3.fromHSV(i / n, 1, 1)))
	end
	local grad = parent:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
	grad.Color = ColorSequence.new(keys)
	grad.Parent = parent
	return grad
end

-- Tag-driven binding. Tagged UIGradients / GuiObjects spin; attribute RotationSpeed sets speed.
-- Tag a UIGradient with panTag (optional) to pan it instead.
function RotatingGradient.bindTag(tag: string, defaultSpeed: number?, panTag: string?)
	local function onAdded(inst)
		if inst:IsA("UIGradient") or inst:IsA("GuiObject") then
			RotatingGradient.add(inst, inst:GetAttribute("RotationSpeed") or defaultSpeed or 90)
		end
	end
	for _, inst in ipairs(CollectionService:GetTagged(tag)) do
		onAdded(inst)
	end
	CollectionService:GetInstanceAddedSignal(tag):Connect(onAdded)
	CollectionService:GetInstanceRemovedSignal(tag):Connect(RotatingGradient.remove)

	if panTag then
		local function onPan(inst)
			if inst:IsA("UIGradient") then
				RotatingGradient.addPan(inst)
			end
		end
		for _, inst in ipairs(CollectionService:GetTagged(panTag)) do
			onPan(inst)
		end
		CollectionService:GetInstanceAddedSignal(panTag):Connect(onPan)
		CollectionService:GetInstanceRemovedSignal(panTag):Connect(RotatingGradient.remove)
	end
end

return RotatingGradient
