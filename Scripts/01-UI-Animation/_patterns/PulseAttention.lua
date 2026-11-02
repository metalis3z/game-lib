--[[
	PulseAttention  (ModuleScript)
	"Look at me!" effects for badges, claim buttons and "you can rebirth" prompts:
	breathing scale, expanding ripple rings, bell wiggle, quick pop -- and a combined loop.

	Derived from techniques in:
	  - drill-and-mine NotifyPulse          (every 2.6 s: two UIStroke rings grow to 2.4x and fade over 0.85 s,
	                                         0.12 s pop to 1.12 then Back-out, wiggle +9 / -9 / +5 / 0 degrees,
	                                         skip all work while the badge is hidden)
	  - drill-and-mine MusclePulse / RebirthProgressController (looping UIScale tween Sine InOut, repeat -1, reverses)
	  - brainrot-lab   UIEffects PulseEffect (1.1 scale, 0.8 s, Sine InOut, restore Scale = 1 on cleanup)

	Usage (LocalScript):
		local PulseAttention = require(game.ReplicatedStorage.UI.PulseAttention)

		local stopBreath = PulseAttention.breathe(claimButton, { scale = 1.08, period = 0.8 })
		PulseAttention.ripple(badge, { color = Color3.fromRGB(255, 45, 85) })
		PulseAttention.pop(badge)
		task.spawn(PulseAttention.wiggle, bellIcon)

		-- all of the above on a timer, automatically paused while invisible
		local stop = PulseAttention.loop(giftBadge, { every = 2.6, color = Color3.fromRGB(255, 45, 85) })
]]

local TweenService = game:GetService("TweenService")

local PulseAttention = {}

local function getScale(gui: GuiObject, name: string): UIScale
	local s = gui:FindFirstChild(name)
	if not s then
		s = Instance.new("UIScale")
		s.Name = name
		s.Parent = gui
	end
	return s :: UIScale
end

-- Endless soft scale pulse. Returns stop().
function PulseAttention.breathe(gui: GuiObject, opts)
	opts = opts or {}
	local scale = getScale(gui, "BreathScale")
	scale.Scale = 1
	local tw = TweenService:Create(scale, TweenInfo.new(opts.period or 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
		Scale = opts.scale or 1.08,
	})
	tw:Play()
	return function()
		tw:Cancel()
		scale.Scale = 1
	end
end

-- One or more rings expanding out of gui and fading. opts: color, thickness, growTo, duration, count, gap, round
function PulseAttention.ripple(gui: GuiObject, opts)
	opts = opts or {}
	local count = opts.count or 2
	for i = 1, count do
		task.delay((i - 1) * (opts.gap or 0.22), function()
			if not gui.Parent then
				return
			end
			local ring = Instance.new("Frame")
			ring.Name = "PulseRing"
			ring.AnchorPoint = Vector2.new(0.5, 0.5)
			ring.Position = UDim2.fromScale(0.5, 0.5)
			ring.Size = UDim2.fromScale(1, 1)
			ring.BackgroundTransparency = 1
			ring.ZIndex = math.max(gui.ZIndex - 1, 1) -- behind the badge itself
			local corner = Instance.new("UICorner")
			corner.CornerRadius = (opts.round == false) and UDim.new(0, 8) or UDim.new(0.5, 0)
			corner.Parent = ring
			local stroke = Instance.new("UIStroke")
			stroke.Thickness = opts.thickness or 3
			stroke.Color = opts.color or Color3.new(1, 1, 1)
			stroke.Transparency = 0.25
			stroke.Parent = ring
			ring.Parent = gui
			local info = TweenInfo.new(opts.duration or 0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local grow = opts.growTo or 2.4
			TweenService:Create(ring, info, { Size = UDim2.fromScale(grow, grow) }):Play()
			local fade = TweenService:Create(stroke, info, { Transparency = 1 })
			fade.Completed:Once(function()
				ring:Destroy()
			end)
			fade:Play()
		end)
	end
end

-- Quick pop: up fast, settle with Back-out. Yields ~0.12 s only if wait = true.
function PulseAttention.pop(gui: GuiObject, amount: number?, wait: boolean?)
	local scale = getScale(gui, "PopScale")
	local up = TweenService:Create(scale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = amount or 1.12 })
	up.Completed:Once(function()
		TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	end)
	up:Play()
	if wait then
		up.Completed:Wait()
	end
end

-- Bell wiggle around the object's current rotation. Yields (~0.4 s); use task.spawn to fire and forget.
function PulseAttention.wiggle(gui: GuiObject, angle: number?)
	local a = angle or 9
	local base = gui:GetAttribute("WiggleBase")
	if base == nil then
		base = gui.Rotation
		gui:SetAttribute("WiggleBase", base)
	end
	local steps = { { base + a, 0.09 }, { base - a, 0.12 }, { base + a * 0.55, 0.1 }, { base, 0.1 } }
	for _, s in ipairs(steps) do
		local tw = TweenService:Create(gui, TweenInfo.new(s[2], Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Rotation = s[1] })
		tw:Play()
		tw.Completed:Wait()
	end
end

-- Repeats ripple + pop + wiggle every `every` seconds while gui is Visible. Returns stop().
-- opts: every, ripple (bool, default true), pop (default true), wiggle (default true), color
function PulseAttention.loop(gui: GuiObject, opts)
	opts = opts or {}
	local alive = true
	task.spawn(function()
		while alive and gui.Parent do
			task.wait(opts.every or 2.6)
			if not alive then
				break
			end
			if gui.Visible then -- hidden badge = nothing to claim, skip the work entirely
				if opts.ripple ~= false then
					PulseAttention.ripple(gui, { color = opts.color })
				end
				if opts.pop ~= false then
					PulseAttention.pop(gui)
				end
				if opts.wiggle ~= false then
					PulseAttention.wiggle(gui, opts.angle)
				end
			end
		end
	end)
	return function()
		alive = false
	end
end

return PulseAttention
