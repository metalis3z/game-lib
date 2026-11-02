--[[
	ProgressFill  (ModuleScript)
	Animated progress / XP / health bars with an optional "ghost" trail bar:
	  * value goes DOWN  -> fill drops at once, ghost lingers then slides down (fighting-game damage bar)
	  * value goes UP    -> ghost jumps ahead, fill grows into it (gain preview)
	Plus: skips tweens for invisible changes, hides the fill at 0 (UICorner pills look broken
	at 1 px), and fires a full-bar pop.

	Derived from techniques in:
	  - drill-and-mine LevelBarController   (fill Size tween 0.3 s Quad-out, skip changes < 0.0005, pop & hold the
	                                         whole readout on gains, coalesce several stat changes into one refresh)
	  - drill-and-mine RebirthProgressController (percent text + pulsing "ready" notify when the bar is full)
	  - bee-swarm-sim  Boost/Hover          (bar fraction = clamp(time / max, 0, 1))

	Usage (LocalScript):
		local ProgressFill = require(game.ReplicatedStorage.UI.ProgressFill)

		-- Fill: a Frame inside the bar background, AnchorPoint (0, 0), Size = UDim2.fromScale(frac, 1)
		local xp = ProgressFill.new(bar.Fill, {
			ghost = bar.Ghost,           -- optional second Frame behind Fill (lighter colour)
			label = bar.Percent,         -- optional TextLabel, shows "73%"
			onFull = function() PopIn.bounce(bar) end,
		})
		xp:set(0.4, true)  -- instant
		xp:set(0.73)       -- animated

		-- vertical bar (fills bottom -> top): set the fill AnchorPoint to (0, 1), Position (0, 1)
		local hp = ProgressFill.new(tube.Fill, { axis = "Y" })
]]

local TweenService = game:GetService("TweenService")

local ProgressFill = {}
ProgressFill.__index = ProgressFill

function ProgressFill.new(fill: GuiObject, opts)
	opts = opts or {}
	local self = setmetatable({}, ProgressFill)
	self.fill = fill
	self.ghost = opts.ghost
	self.label = opts.label
	self.axis = opts.axis or "X"
	self.info = opts.info or TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	self.ghostDelay = opts.ghostDelay or 0.35
	self.ghostInfo = opts.ghostInfo or TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	self.minDelta = opts.minDelta or 0.0005
	self.onFull = opts.onFull
	self.format = opts.format or function(f)
		return math.floor(f * 100 + 0.5) .. "%"
	end
	self.value = nil
	self.ghostToken = 0
	self.tween = nil
	self.ghostTween = nil
	return self
end

function ProgressFill:_size(frac: number): UDim2
	local s = self.fill.Size
	if self.axis == "Y" then
		return UDim2.new(s.X.Scale, s.X.Offset, frac, 0)
	end
	return UDim2.new(frac, 0, s.Y.Scale, s.Y.Offset)
end

function ProgressFill:_ghostSize(frac: number): UDim2
	local s = self.ghost.Size
	if self.axis == "Y" then
		return UDim2.new(s.X.Scale, s.X.Offset, frac, 0)
	end
	return UDim2.new(frac, 0, s.Y.Scale, s.Y.Offset)
end

function ProgressFill:set(frac: number, instant: boolean?)
	frac = math.clamp(frac, 0, 1)
	local old = self.value
	if old ~= nil and not instant and math.abs(frac - old) < self.minDelta and frac ~= 0 and frac ~= 1 then
		return -- the bar would not visibly move: don't restart a tween 15x per second
	end
	self.value = frac
	if self.label then
		self.label.Text = self.format(frac)
	end

	if self.tween then
		self.tween:Cancel()
	end
	self.fill.Visible = true

	local function hideIfEmpty()
		if self.value <= 0.001 then
			self.fill.Visible = false
		end
	end

	if instant or old == nil then
		self.fill.Size = self:_size(frac)
		if self.ghost then
			if self.ghostTween then
				self.ghostTween:Cancel()
			end
			self.ghost.Size = self:_ghostSize(frac)
		end
		hideIfEmpty()
		return
	end

	local going_down = frac < old
	if self.ghost then
		self.ghostToken += 1
		local token = self.ghostToken
		if self.ghostTween then
			self.ghostTween:Cancel()
		end
		if going_down then
			-- fill snaps down fast, ghost waits, then slides down to meet it
			self.tween = TweenService:Create(self.fill, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = self:_size(frac) })
			self.tween.Completed:Once(hideIfEmpty)
			self.tween:Play()
			task.delay(self.ghostDelay, function()
				if self.ghostToken == token then
					self.ghostTween = TweenService:Create(self.ghost, self.ghostInfo, { Size = self:_ghostSize(frac) })
					self.ghostTween:Play()
				end
			end)
		else
			-- ghost jumps to the new value, fill grows into it
			self.ghost.Size = self:_ghostSize(frac)
			self.tween = TweenService:Create(self.fill, self.ghostInfo, { Size = self:_size(frac) })
			self.tween:Play()
		end
	else
		self.tween = TweenService:Create(self.fill, self.info, { Size = self:_size(frac) })
		self.tween.Completed:Once(hideIfEmpty)
		self.tween:Play()
	end

	if frac >= 1 and old < 1 and self.onFull then
		task.spawn(self.onFull)
	end
end

function ProgressFill:get(): number
	return self.value or 0
end

-- Convenience: set from a current / max pair.
function ProgressFill:setRatio(current: number, max: number, instant: boolean?)
	self:set(max > 0 and current / max or 0, instant)
end

return ProgressFill
