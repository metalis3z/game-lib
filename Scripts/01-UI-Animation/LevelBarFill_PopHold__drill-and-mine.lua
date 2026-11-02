-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: StarterGui/GUI/HUD/LevelBarController.client.lua  (client, 146 lines)
-- Categories: ui-animation 16.8, leaderboards 10.0
-- What it does: XP progress-bar fill tween (skips tiny changes), level text, and a "pop and hold" UIScale on stat gain that rests inflated while gains keep coming; coalesces refreshes per frame.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local plr = Players.LocalPlayer
local hud = script.Parent
-- LevelReadout wraps LevelBar + LevelSubBg so the strength pulse scales the
-- bar and its text as ONE rigid unit (they used to pop independently).
local readout = hud:WaitForChild("LevelReadout")
local bar = readout:WaitForChild("LevelBar")
local fill = bar:WaitForChild("ProgressFrame")
local levelText = bar:WaitForChild("LevelText")
local xpText = bar:WaitForChild("XPText")
local sub = readout:WaitForChild("LevelSubBg"):WaitForChild("Body", 5)
local subText = readout.LevelSubBg:FindFirstChild("SubText", true)
local levelSubBg = readout:WaitForChild("LevelSubBg")

-- Whole-bar pulse on every Strength gain (world clicks AND AFK training pads,
-- both of which raise the Strength attribute). The bar + its text + the drop
-- shadow all scale as ONE rigid unit via AnimatedText.Pop; LevelBar/LevelSubBg
-- carry the AT_Ignore attribute so their labels never self-animate (that per
-- label popping is what used to desync the "Double" shadow copies).
-- ProgressFrame (the XP fill) ALSO carries AT_Ignore: AnimatedTextController's
-- bar-fill watcher would otherwise pop LevelBar alone (1.08) on every fill
-- growth, stacking with this readout pop -- the bar visibly scaled apart from
-- the strength text. One container, one pop.
local AnimatedText
pcall(function()
	AnimatedText = require(game:GetService("ReplicatedStorage"):WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("AnimatedText"))
end)
local STRENGTH_POP = 1.05 -- subtle; 1.12 read as "extravagant" at click cadence
-- Sustained-gain hold: while clicks keep landing, the readout RESTS inflated
-- at STRENGTH_POP instead of restarting the pop tween every click. A tweening
-- UIScale re-rasterizes the whole readout (fills + 6 TextScaled labels +
-- strokes) EVERY frame -- at spam-click cadence that alone dropped FPS hard.
-- A resting scale costs nothing; the spring-down plays once gains stop.
local POP_HOLD = 0.3
local POP_UP_INFO = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local POP_DOWN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local lastStrength
local lastGainAt = 0
local popHeld = false
local function pulseStrengthReadout()
	lastGainAt = os.clock()
	if popHeld then return end -- already inflated; the gain just extends the hold
	popHeld = true
	-- same _ATPop UIScale AnimatedText.Pop uses, so the two never stack
	local scale = readout:FindFirstChild("_ATPop")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "_ATPop"
		scale.Parent = readout
	end
	TweenService:Create(scale, POP_UP_INFO, { Scale = STRENGTH_POP }):Play()
	task.spawn(function()
		while os.clock() - lastGainAt < POP_HOLD do
			task.wait(0.1)
		end
		popHeld = false
		TweenService:Create(scale, POP_DOWN_INFO, { Scale = 1 }):Play()
	end)
end

local function setText(label, txt)
	if not label then return end
	label.Text = txt
	local dbl = label:FindFirstChild("Double")
	if dbl then dbl.Text = txt end
end

local function abbrev(n)
	n = tonumber(n) or 0
	local units = {{1e42,"Td"},{1e39,"Dd"},{1e36,"Ud"},{1e33,"Dc"},{1e30,"No"},{1e27,"Oc"},{1e24,"Sp"},{1e21,"Sx"},{1e18,"Qn"},{1e15,"Qd"},{1e12,"T"},{1e9,"B"},{1e6,"M"},{1e3,"K"}}
	for _, u in ipairs(units) do
		if n >= u[1] then return string.format("%.1f%s", n/u[1], u[2]) end
	end
	return tostring(math.floor(n))
end

local function readStat(name)
	local ls = plr:FindFirstChild("leaderstats")
	local stat = ls and ls:FindFirstChild(name)
	if stat then return stat.Value end
	return plr:GetAttribute(name)
end

local lastFrac = nil

local function refresh()
	local level = readStat("Level") or 1
	local xp = readStat("XP") or 0
	local xpMax = readStat("XPMax") or readStat("XPRequired") or 100
	local strength = readStat("Strength")

	setText(levelText, "Level " .. tostring(level))
	setText(xpText, abbrev(xp) .. "/" .. abbrev(xpMax))
	local frac = 0
	if tonumber(xpMax) and tonumber(xpMax) > 0 then
		frac = math.clamp((tonumber(xp) or 0) / tonumber(xpMax), 0, 1)
	end
	-- skip the fill tween when the bar wouldn't visibly move (late-game XP
	-- bars advance a hair per click -- restarting a tween 15x/s for that is
	-- pure churn)
	if lastFrac == nil or math.abs(frac - lastFrac) >= 0.0005 or frac == 0 or frac == 1 then
		lastFrac = frac
		TweenService:Create(fill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(frac, 0, 1, 0) }):Play()
	end
	if strength ~= nil then
		setText(subText, abbrev(strength) .. " Strength")
		local sv = tonumber(strength)
		if sv then
			if lastStrength ~= nil and sv > lastStrength then
				pulseStrengthReadout()
			end
			lastStrength = sv
		end
	end
end

-- One click changes up to FOUR of the hooked stats (Strength, XP, and on
-- level-ups Level + XPMax) in the same replication step -- refresh() used to
-- run once PER SIGNAL (2-4x per click: 6 label writes + a fill tween each).
-- Coalesce to at most one refresh per frame.
local refreshPending = false
local function scheduleRefresh()
	if refreshPending then return end
	refreshPending = true
	task.defer(function()
		refreshPending = false
		refresh()
	end)
end

local function hook()
	for _, name in ipairs({"Level","XP","XPMax","XPRequired","Strength"}) do
		local ls = plr:FindFirstChild("leaderstats")
		local stat = ls and ls:FindFirstChild(name)
		if stat then stat.Changed:Connect(scheduleRefresh) end
		plr:GetAttributeChangedSignal(name):Connect(scheduleRefresh)
	end
	refresh()
end

if plr:FindFirstChild("leaderstats") then hook() else
	plr.ChildAdded:Connect(function(c) if c.Name == "leaderstats" then task.wait(0.1); hook() end end)
end
refresh()
