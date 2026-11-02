--[[
	FloatBob  (ModuleScript)
	Idle motion for icons and badges: vertical bobbing, rocking rotation and a soft scale
	"breath", all from one RenderStepped loop with a per-object phase so a row of icons never
	moves in lock-step.

	Derived from techniques in:
	  - drill-and-mine RotateIcon/LocalScript   (endless Sine InOut rock between +10 and -20 degrees, 1 s per side)
	  - drill-and-mine MusclePulse              (UIScale breathing 1 -> 1.10, 1.6 s Sine, instead of Size tweens)
	  - smash-egg-for-animals RunAlertClient    (math.sin(clock * 7) pulse driven from RenderStepped)
	  - brainrot-lab UIEffects                  (math.sin(tick() * speed) * range panning)

	Usage (LocalScript):
		local FloatBob = require(game.ReplicatedStorage.UI.FloatBob)

		local stop = FloatBob.add(shopIcon, { amplitude = 6, speed = 0.8, rock = 6, breathe = 0.04 })
		-- stop() puts the icon back exactly where it was

		-- or tag-driven: tag GuiObjects "FloatBob"; optional attributes
		-- BobAmplitude (px), BobSpeed (cycles/s), BobRock (deg), BobBreathe (scale amount)
		FloatBob.bindTag("FloatBob")

	Note: FloatBob owns Position/Rotation of the object while active. If another script also moves
	it, wrap the icon in a holder Frame and bob the inner icon instead.
]]

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local FloatBob = {}

local entries = {} -- [GuiObject] = config
local conn: RBXScriptConnection? = nil
local stepSignal = RunService:IsClient() and RunService.RenderStepped or RunService.Heartbeat

local function step()
	local t = os.clock()
	for gui, e in pairs(entries) do
		if gui.Parent == nil then
			entries[gui] = nil
		elseif gui.Visible then
			local w = 2 * math.pi * e.speed
			local s = math.sin(t * w + e.phase)
			gui.Position = e.basePos + UDim2.fromOffset(0, -s * e.amplitude)
			if e.rock ~= 0 then
				-- rock at a slightly different rate so it doesn't look mechanical
				gui.Rotation = e.baseRot + math.sin(t * w * 0.8 + e.phase * 1.3) * e.rock
			end
			if e.scale then
				e.scale.Scale = e.baseScale * (1 + (math.sin(t * w * 0.5 + e.phase) * 0.5 + 0.5) * e.breathe)
			end
		end
	end
	if next(entries) == nil and conn then
		conn:Disconnect()
		conn = nil
	end
end

-- opts: amplitude (pixels, default 5), speed (cycles per second, default 0.6), rock (degrees, default 0),
--       breathe (extra scale, e.g. 0.05 = up to +5%, default 0), phase (radians, default random)
function FloatBob.add(gui: GuiObject, opts)
	opts = opts or {}
	FloatBob.remove(gui)
	local e = {
		basePos = gui.Position,
		baseRot = gui.Rotation,
		amplitude = opts.amplitude or 5,
		speed = opts.speed or 0.6,
		rock = opts.rock or 0,
		breathe = opts.breathe or 0,
		phase = opts.phase or math.random() * math.pi * 2,
		scale = nil,
		baseScale = 1,
		createdScale = false,
	}
	if e.breathe ~= 0 then
		local scale = gui:FindFirstChildOfClass("UIScale")
		if not scale then
			scale = Instance.new("UIScale")
			scale.Name = "BobScale"
			scale.Parent = gui
			e.createdScale = true
		end
		e.scale = scale
		e.baseScale = scale.Scale
	end
	entries[gui] = e
	if not conn then
		conn = stepSignal:Connect(step)
	end
	return function()
		FloatBob.remove(gui)
	end
end

function FloatBob.remove(gui: GuiObject)
	local e = entries[gui]
	if not e then
		return
	end
	entries[gui] = nil
	gui.Position = e.basePos
	gui.Rotation = e.baseRot
	if e.scale then
		if e.createdScale then
			e.scale:Destroy()
		else
			e.scale.Scale = e.baseScale
		end
	end
end

function FloatBob.bindTag(tag: string)
	local function onAdded(inst)
		if inst:IsA("GuiObject") then
			FloatBob.add(inst, {
				amplitude = inst:GetAttribute("BobAmplitude"),
				speed = inst:GetAttribute("BobSpeed"),
				rock = inst:GetAttribute("BobRock"),
				breathe = inst:GetAttribute("BobBreathe"),
			})
		end
	end
	for _, inst in ipairs(CollectionService:GetTagged(tag)) do
		onAdded(inst)
	end
	CollectionService:GetInstanceAddedSignal(tag):Connect(onAdded)
	CollectionService:GetInstanceRemovedSignal(tag):Connect(function(inst)
		if inst:IsA("GuiObject") then
			FloatBob.remove(inst)
		end
	end)
end

return FloatBob
