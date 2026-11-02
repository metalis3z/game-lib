--[[
	SpringScale  (ModuleScript)
	Springy UI motion: a tiny exact damped-spring solver plus helpers that drive a UIScale
	(or any number property) with it. Springs keep their velocity when the target changes
	mid-motion, so rapid hover / unhover feels physical instead of restarting a tween.

	Derived from techniques in:
	  - punching-simulator  Physics/Spr  (the MIT "spr" library: dampingRatio + frequency API, sleep thresholds;
	                                      used as Spr.Target(UIScale, 1, 4, {Scale = 1}) after setting Scale = 2 for a hit pulse)
	  - doors               MainUI/Modules/Spring (analytic spring: position/velocity solved in closed form)
	  - drill-and-mine      HoverController (hover / press / release scale values 0.95 / 0.87 / bounce)

	Usage (LocalScript):
		local SpringScale = require(game.ReplicatedStorage.UI.SpringScale)

		-- springy button (overshoots a little on hover, squashes on press)
		SpringScale.bindButton(playButton, { hover = 1.08, press = 0.9, damping = 0.55, frequency = 5 })

		-- "hit" pulse: jump to 1.4 and wobble back to 1
		local s = SpringScale.attach(damageFrame, { damping = 0.4, frequency = 4 })
		s:snap(1.4)
		s:to(1)

		-- raw spring for anything (number): e.g. a bar that wobbles
		local spring = SpringScale.Spring.new(0, 0.5, 3)
		spring.target = 1
		RunService.RenderStepped:Connect(function(dt) bar.Size = UDim2.fromScale(spring:step(dt), 1) end)

	damping: 1 = no overshoot (critically damped), < 1 = bouncy, > 1 = sluggish.
	frequency: oscillations per second (higher = snappier).
]]

local RunService = game:GetService("RunService")

local SpringScale = {}

--------------------------------------------------------------------------- Spring (number)
local Spring = {}
Spring.__index = Spring

function Spring.new(initial: number, damping: number?, frequency: number?)
	return setmetatable({
		position = initial,
		velocity = 0,
		target = initial,
		damping = damping or 1,
		frequency = frequency or 4,
	}, Spring)
end

-- Advances the spring by dt seconds using the exact solution of x'' = -w^2 x - 2 z w x'
-- (stable for any dt, no substeps needed). Returns the new position.
function Spring:step(dt: number): number
	local z = math.max(self.damping, 0)
	local w = self.frequency * 2 * math.pi
	local x0 = self.position - self.target
	local v0 = self.velocity
	local x, v

	if w < 1e-5 then
		return self.position
	end

	if z < 1 - 1e-4 then -- under-damped (bouncy)
		local wd = w * math.sqrt(1 - z * z)
		local e = math.exp(-z * w * dt)
		local c, s = math.cos(wd * dt), math.sin(wd * dt)
		local b = (v0 + z * w * x0) / wd
		x = e * (x0 * c + b * s)
		v = e * ((-z * w * x0 + wd * b) * c + (-z * w * b - wd * x0) * s)
	elseif z <= 1 + 1e-4 then -- critically damped
		local e = math.exp(-w * dt)
		local b = v0 + w * x0
		x = e * (x0 + b * dt)
		v = e * (v0 - w * b * dt)
	else -- over-damped
		local r = math.sqrt(z * z - 1)
		local r1, r2 = -w * (z - r), -w * (z + r)
		local c1 = (v0 - r2 * x0) / (r1 - r2)
		local c2 = x0 - c1
		local e1, e2 = math.exp(r1 * dt), math.exp(r2 * dt)
		x = c1 * e1 + c2 * e2
		v = c1 * r1 * e1 + c2 * r2 * e2
	end

	self.position = self.target + x
	self.velocity = v
	return self.position
end

function Spring:isResting(eps: number?): boolean
	local e = eps or 1e-3
	return math.abs(self.position - self.target) < e and math.abs(self.velocity) < e
end

SpringScale.Spring = Spring

--------------------------------------------------------------------------- shared driver
local active = {} -- [controller] = true
local conn: RBXScriptConnection? = nil
local stepSignal = RunService:IsClient() and RunService.RenderStepped or RunService.Heartbeat

local function drive(dt: number)
	dt = math.min(dt, 1 / 15) -- a long hitch should not fling the spring
	for ctrl in pairs(active) do
		if not ctrl.object.Parent then
			active[ctrl] = nil
		else
			local p = ctrl.spring:step(dt)
			ctrl.object[ctrl.property] = p
			if ctrl.spring:isResting() then
				ctrl.spring.position = ctrl.spring.target
				ctrl.spring.velocity = 0
				ctrl.object[ctrl.property] = ctrl.spring.target
				active[ctrl] = nil -- sleep until the next :to()
			end
		end
	end
	if next(active) == nil and conn then
		conn:Disconnect()
		conn = nil
	end
end

local function wake(ctrl)
	active[ctrl] = true
	if not conn then
		conn = stepSignal:Connect(drive)
	end
end

--------------------------------------------------------------------------- controllers
local Controller = {}
Controller.__index = Controller

-- Move toward a new value (keeps current velocity).
function Controller:to(value: number)
	self.spring.target = value
	wake(self)
end

-- Jump instantly (no motion), e.g. snap(1.4) then to(1) for a hit wobble.
function Controller:snap(value: number)
	self.spring.position = value
	self.spring.velocity = 0
	self.object[self.property] = value
	wake(self)
end

-- Add velocity (units per second), e.g. kick(6) for a little jolt.
function Controller:kick(velocity: number)
	self.spring.velocity += velocity
	wake(self)
end

function Controller:destroy()
	active[self] = nil
end

-- Drive any number property of any instance with a spring.
function SpringScale.property(object: Instance, property: string, opts)
	opts = opts or {}
	local start = (object :: any)[property]
	local ctrl = setmetatable({
		object = object,
		property = property,
		spring = Spring.new(start, opts.damping or 0.6, opts.frequency or 4),
	}, Controller)
	return ctrl
end

-- Drive a GuiObject's UIScale (created if missing).
function SpringScale.attach(gui: GuiObject, opts)
	local scale = gui:FindFirstChild("SpringScale") or gui:FindFirstChildOfClass("UIScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "SpringScale"
		scale.Parent = gui
	end
	return SpringScale.property(scale, "Scale", opts)
end

-- Springy hover / press for a button. Returns cleanup().
function SpringScale.bindButton(button: GuiButton, opts)
	opts = opts or {}
	local hover = opts.hover or 1.08
	local press = opts.press or 0.9
	local ctrl = SpringScale.attach(button, { damping = opts.damping or 0.55, frequency = opts.frequency or 5 })
	local base = ctrl.spring.target
	local hovering = false
	local conns = {
		button.MouseEnter:Connect(function()
			hovering = true
			ctrl:to(base * hover)
		end),
		button.MouseLeave:Connect(function()
			hovering = false
			ctrl:to(base)
		end),
		button.MouseButton1Down:Connect(function()
			ctrl:to(base * press)
		end),
		button.MouseButton1Up:Connect(function()
			ctrl:to(hovering and base * hover or base)
		end),
		button.Activated:Connect(function()
			if not hovering then -- touch: squash then release
				ctrl:snap(base * press)
				ctrl:to(base)
			end
		end),
	}
	return function()
		for _, c in ipairs(conns) do
			c:Disconnect()
		end
		ctrl:destroy()
	end
end

return SpringScale
