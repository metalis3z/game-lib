--[[
	CountUp  (ModuleScript)
	Animated number labels: currency counters that roll up to the new value, optional "pop"
	on increase, abbreviation (1.2K, 3.4M ...).

	Two modes:
	  "ease" -- each change restarts a fixed-duration cubic ease-out from the shown value (smash-egg MoneyHandler)
	  "lerp" -- the shown value chases the target exponentially every frame (drill-and-mine CashDisplayController);
	            great for values that change many times per second (income ticks, clicking)

	Derived from techniques in:
	  - smash-egg-for-animals MoneyGui/MoneyHandler   (0.5 s cubic ease-out on RenderStepped, pop on spend)
	  - drill-and-mine CashDisplayController          (displayed += diff * min(1, speed * dt), snap when |diff| < 1,
	                                                   only write Text when the string changes)
	  - drill-and-mine AnimatedText.Pop               (grow pulse: Quad-out 0.12 s up, Back-out 0.3 s down)

	Usage (LocalScript):
		local CountUp = require(game.ReplicatedStorage.UI.CountUp)

		local cash = CountUp.new(hud.CashLabel, {
			mode = "ease", duration = 0.5,
			format = function(n) return "$" .. CountUp.abbreviate(n) end,
			popScale = 1.12, -- pulse when the value goes up (nil = no pulse)
		})
		cash:set(player:GetAttribute("Cash") or 0, true) -- true = instant (no animation on join)
		player:GetAttributeChangedSignal("Cash"):Connect(function()
			cash:set(player:GetAttribute("Cash"))
		end)

		-- fire-and-forget one-off count (e.g. "You earned 0 -> 2500" on a results screen)
		CountUp.tween(resultsLabel, 0, 2500, 1.2)
]]

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local CountUp = {}
CountUp.__index = CountUp

local stepSignal = RunService:IsClient() and RunService.RenderStepped or RunService.Heartbeat

local SUFFIXES = { "K", "M", "B", "T", "Qd", "Qn", "Sx", "Sp", "Oc", "No", "Dc" }

-- 1234 -> "1.23K", 15300000 -> "15.3M". decimals = max decimals (default 2, trailing zeros trimmed).
function CountUp.abbreviate(n: number, decimals: number?): string
	local negative = n < 0
	n = math.abs(n)
	if n < 1000 then
		return (negative and "-" or "") .. tostring(math.floor(n))
	end
	local tier = math.min(math.floor(math.log10(n) / 3), #SUFFIXES)
	local scaled = n / 10 ^ (tier * 3)
	if scaled >= 1000 and tier < #SUFFIXES then -- float error guard (log10 can land at 14.9999...)
		tier += 1
		scaled /= 1000
	end
	local d = decimals or 2
	local s = string.format("%." .. d .. "f", math.floor(scaled * 10 ^ d) / 10 ^ d)
	if d > 0 then
		s = s:gsub("0+$", ""):gsub("%.$", "") -- "1.50" -> "1.5", "2.00" -> "2"
	end
	return (negative and "-" or "") .. s .. SUFFIXES[tier]
end

-- 1234567 -> "1,234,567"
function CountUp.commas(n: number): string
	local s = tostring(math.floor(math.abs(n)))
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	return (n < 0 and "-" or "") .. out
end

local function easeOutCubic(t: number): number
	return 1 - (1 - t) ^ 3
end

function CountUp.new(label: TextLabel | TextButton, opts)
	opts = opts or {}
	local self = setmetatable({}, CountUp)
	self.label = label
	self.mode = opts.mode or "ease"
	self.duration = opts.duration or 0.5
	self.speed = opts.speed or 10 -- lerp mode: higher = catches up faster
	self.format = opts.format or function(n)
		return CountUp.commas(n)
	end
	self.easing = opts.easing or easeOutCubic
	self.popScale = opts.popScale
	self.shown = 0
	self.target = 0
	self.from = 0
	self.elapsed = 0
	self.lastText = nil
	self.conn = nil
	self:_write()
	return self
end

function CountUp:_write()
	local text = self.format(self.shown)
	if text ~= self.lastText then
		self.lastText = text
		self.label.Text = text
	end
end

function CountUp:_pop()
	if not self.popScale then
		return
	end
	local scale = self.label:FindFirstChild("CountUpPop")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "CountUpPop"
		scale.Parent = self.label
	end
	local up = TweenService:Create(scale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = self.popScale })
	up.Completed:Once(function(state)
		-- only spring back once the LAST pop finished, so rapid gains keep it gently inflated
		if state == Enum.PlaybackState.Completed then
			TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
		end
	end)
	up:Play()
end

function CountUp:_step(dt: number)
	if self.mode == "lerp" then
		local diff = self.target - self.shown
		if math.abs(diff) < 1 then
			self.shown = self.target
		else
			self.shown += diff * math.min(1, self.speed * dt)
		end
	else
		self.elapsed = math.min(self.elapsed + dt, self.duration)
		local a = self.easing(self.elapsed / self.duration)
		self.shown = self.from + (self.target - self.from) * a
		if self.elapsed >= self.duration then
			self.shown = self.target
		end
	end
	self:_write()
	if self.shown == self.target and self.conn then
		self.conn:Disconnect() -- idle counters cost nothing
		self.conn = nil
	end
end

function CountUp:set(value: number, instant: boolean?)
	local increased = value > self.target
	self.target = value
	if instant then
		if self.conn then
			self.conn:Disconnect()
			self.conn = nil
		end
		self.shown = value
		self:_write()
		return
	end
	self.from = self.shown
	self.elapsed = 0
	if increased then
		self:_pop()
	end
	if not self.conn then
		self.conn = stepSignal:Connect(function(dt)
			self:_step(dt)
		end)
	end
end

function CountUp:get(): number
	return self.target
end

function CountUp:destroy()
	if self.conn then
		self.conn:Disconnect()
		self.conn = nil
	end
end

-- One-off count from -> to over duration seconds. Returns the counter (call :destroy() to stop early).
function CountUp.tween(label, from: number, to: number, duration: number?, format: ((number) -> string)?)
	local c = CountUp.new(label, { mode = "ease", duration = duration or 1, format = format })
	c:set(from, true)
	c:set(to)
	return c
end

return CountUp
