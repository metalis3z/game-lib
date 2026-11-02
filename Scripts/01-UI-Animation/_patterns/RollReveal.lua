--[[
	RollReveal  (ModuleScript)
	Gacha / RNG roll animations:
	  * RollReveal.play     -- flick through candidates very fast, then slower and slower, land on the result
	  * RollReveal.spinWheelTo -- spin a wheel image several turns and stop exactly on a slice
	  * RollReveal.revealPop   -- the "ta-da" punch for the final card (scale slam + rays + flash)
	The UI is yours: you get callbacks for each tick and for the reveal.

	Derived from techniques in:
	  - smash-egg-for-animals HatchReelClient (slot length = 0.08 + k^2 * 0.62 after a 0.5 s full-speed phase;
	                                           never show the same pet twice in a row; the result never appears
	                                           in the slot right before it lands; tick sound pitch rises per slot)
	  - pet-rng RollHandler                   (4 fake results with a tiny shake, then the real one + expanding ring
	                                           + "1/N" chance text)
	  - punching-simulator Wheel              (Rotation = 360 * 5 + slotOffset, Quint-out over 5 s, then normalise)

	Usage (LocalScript):
		local RollReveal = require(game.ReplicatedStorage.UI.RollReveal)

		local items = { "Common Cat", "Rare Dog", "Epic Dragon", "Legendary Phoenix" }
		RollReveal.play({
			items = items,
			result = "Epic Dragon",        -- decided by the SERVER, the animation only shows it
			duration = 3,
			onTick = function(item, index, isFinal)
				card.NameLabel.Text = item
				tickSound.PlaybackSpeed = 0.9 + math.min(index * 0.02, 0.5)
				tickSound:Play()
			end,
			onReveal = function(item)
				RollReveal.revealPop(card, { rays = card.Rays, flashColor = Color3.fromRGB(255, 220, 90) })
			end,
		})

		-- wheel: 8 slices, slice 1 starts at the top and slices go clockwise
		RollReveal.spinWheelTo(wheel.Inner, 3, 8, { turns = 6, duration = 5 }).Completed:Wait()
]]

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local RollReveal = {}

-- Builds the timeline: { {item, start, length, final}, ... } ending with the result.
function RollReveal.buildSchedule(items: { any }, result: any, duration: number, opts)
	opts = opts or {}
	local fastTime = opts.fastTime or 0.5
	local minStep = opts.minStep or 0.08
	local maxStep = opts.maxStep or 0.62
	local landHold = opts.landHold or 0.6 -- the final slot is at least this long
	local rng = opts.random or Random.new()

	local function slotLength(t)
		local k = math.clamp((t - fastTime) / math.max(duration - fastTime, 0.1), 0, 1)
		return minStep + k * k * (maxStep - minStep) -- quadratic slow-down
	end

	local slots, t, last = {}, 0, nil
	while true do
		local length = slotLength(t)
		if t + length >= duration - landHold then
			break
		end
		local pick
		repeat
			pick = items[rng:NextInteger(1, #items)]
		until pick ~= last or #items == 1
		table.insert(slots, { item = pick, start = t, length = length })
		last, t = pick, t + length
	end
	-- don't flash the result right before landing on it (reads as "it skipped back")
	local prev = slots[#slots]
	if prev and prev.item == result and #items > 1 then
		repeat
			prev.item = items[rng:NextInteger(1, #items)]
		until prev.item ~= result and (slots[#slots - 1] == nil or prev.item ~= slots[#slots - 1].item or #items == 2)
	end
	table.insert(slots, { item = result, start = t, length = math.max(duration - t, 0), final = true })
	return slots
end

-- Plays a roll. Returns a handle { cancel: () -> () }. onTick(item, index, isFinal), onReveal(item).
function RollReveal.play(opts)
	local slots = RollReveal.buildSchedule(opts.items, opts.result, opts.duration or 3, opts)
	local cancelled = false
	task.spawn(function()
		local start = os.clock()
		local index = 0
		while not cancelled do
			local now = os.clock() - start
			while slots[index + 1] and now >= slots[index + 1].start do
				index += 1
				local slot = slots[index]
				if opts.onTick then
					opts.onTick(slot.item, index, slot.final == true)
				end
			end
			if index >= #slots then
				break
			end
			RunService.Heartbeat:Wait()
		end
		if not cancelled and opts.onReveal then
			opts.onReveal(opts.result)
		end
	end)
	return {
		cancel = function()
			cancelled = true
		end,
	}
end

-- Spin a wheel GuiObject so slice `index` (1-based, clockwise from the top) ends under a pointer at the top.
-- jitter (0..0.45) lands somewhere inside the slice instead of dead centre. Returns the Tween.
function RollReveal.spinWheelTo(wheel: GuiObject, index: number, sliceCount: number, opts)
	opts = opts or {}
	local turns = opts.turns or 5
	local duration = opts.duration or 5
	local jitter = opts.jitter or 0.35
	local sliceAngle = 360 / sliceCount
	local centre = (index - 0.5) * sliceAngle + (opts.offsetDegrees or 0)
	local wobble = (math.random() * 2 - 1) * jitter * sliceAngle

	wheel.Rotation = wheel.Rotation % 360
	local target = turns * 360 + (360 - centre) + wobble
	local tw = TweenService:Create(wheel, TweenInfo.new(duration, opts.style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Rotation = target })
	tw.Completed:Once(function()
		wheel.Rotation = target % 360 -- keep numbers small for the next spin
	end)
	tw:Play()
	return tw
end

-- Final reveal punch on a card: scale slam (from 1.3 to 1, Back-out), optional rays spin-in and
-- a white/colour flash frame that fades. opts: { scale, rays: GuiObject?, flashColor: Color3? }
function RollReveal.revealPop(card: GuiObject, opts)
	opts = opts or {}
	local scale = card:FindFirstChild("RevealScale") or Instance.new("UIScale")
	scale.Name = "RevealScale"
	scale.Parent = card
	scale.Scale = opts.scale or 1.3
	TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()

	if opts.rays then
		local rays = opts.rays :: GuiObject
		rays.Visible = true
		local rs = rays:FindFirstChild("RevealScale") or Instance.new("UIScale")
		rs.Name = "RevealScale"
		rs.Parent = rays
		rs.Scale = 0
		TweenService:Create(rs, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
		TweenService:Create(rays, TweenInfo.new(6, Enum.EasingStyle.Linear), { Rotation = rays.Rotation + 120 }):Play()
	end

	if opts.flashColor then
		local flash = Instance.new("Frame")
		flash.Name = "RevealFlash"
		flash.BackgroundColor3 = opts.flashColor
		flash.BackgroundTransparency = 0.2
		flash.BorderSizePixel = 0
		flash.Size = UDim2.fromScale(1, 1)
		flash.ZIndex = card.ZIndex + 5
		local corner = card:FindFirstChildOfClass("UICorner")
		if corner then
			corner:Clone().Parent = flash
		end
		flash.Parent = card
		local fade = TweenService:Create(flash, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 })
		fade.Completed:Once(function()
			flash:Destroy()
		end)
		fade:Play()
	end
end

-- Little "shake" used between fake results (pet-rng style): nudges Position up and back.
function RollReveal.nudge(gui: GuiObject, pixels: number?)
	-- remember the true resting position so rapid nudges never drift
	if gui:GetAttribute("NudgeBase") == nil then
		gui:SetAttribute("NudgeBase", gui.Position)
	end
	local p = gui:GetAttribute("NudgeBase")
	local up = TweenService:Create(gui, TweenInfo.new(0.03), { Position = p + UDim2.fromOffset(0, -(pixels or 6)) })
	up.Completed:Once(function()
		TweenService:Create(gui, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = p }):Play()
	end)
	up:Play()
end

return RollReveal
