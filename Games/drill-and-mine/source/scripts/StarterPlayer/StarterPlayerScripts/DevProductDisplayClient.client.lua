--[[
	DevProductDisplayClient
	Animates dev-product pedestal displays (Workspace.DevProduct*):
	- models tagged "DevProductDisplayItem" spin in place, same speed as the
	  zone loot spin in RarityLootClient
	- UIGradients tagged "DevProductTitleGradient" scroll their offset, same
	  speed as the animated rare-tier loot gradients
	- frames tagged "DevProductTimer" count down to their DeadlineUnix
	  attribute (absolute unix time, set at edit time) on their Timer label
	Tags are set at edit time (CollectionService), so this survives the
	BillboardVisibility _CenterHost reparent and any clones.
]]

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local SPIN_TAG = "DevProductDisplayItem"
local GRADIENT_TAG = "DevProductTitleGradient"
local TIMER_TAG = "DevProductTimer"
local SPIN_SPEED = math.rad(40)   -- matches RarityLootClient SPIN_SPEED
local BOB_HEIGHT = 0.55           -- matches RarityLootClient BOB_HEIGHT
local BOB_SPEED = 2.2             -- matches RarityLootClient BOB_SPEED
local GRADIENT_SCROLL_SPEED = 0.9 -- matches RarityLootClient GRADIENT_SCROLL_SPEED

local spinners = {}  -- [Model] = { basePivot = CFrame, start = number }
local gradients = {} -- [UIGradient] = phase
local timers = {}    -- [Instance] = { label, inner, lastText }

local function addSpinner(inst)
	-- models with the DisplayLootItem attribute are bob+spun by
	-- RarityLootClient (which also drives their overhead billboard) --
	-- animating them here too meant TWO PivotTo calls fighting over the
	-- same model every frame (the Dragon Egg pedestal jitter)
	if inst:GetAttribute("DisplayLootItem") then return end
	if inst:IsA("Model") and not spinners[inst] then
		spinners[inst] = {
			basePivot = inst:GetPivot(),
			start = os.clock(),
			bobPhase = math.random() * math.pi * 2,
		}
	end
end

local function addGradient(inst)
	if inst:IsA("UIGradient") and not gradients[inst] then
		gradients[inst] = math.random() * 2
	end
end

local function addTimer(inst)
	if timers[inst] then return end
	local label = inst:FindFirstChild("Timer", true)
	if not label then return end
	timers[inst] = { label = label, inner = label:FindFirstChild("Inner"), lastText = nil }
end

for _, inst in ipairs(CollectionService:GetTagged(SPIN_TAG)) do addSpinner(inst) end
for _, inst in ipairs(CollectionService:GetTagged(GRADIENT_TAG)) do addGradient(inst) end
for _, inst in ipairs(CollectionService:GetTagged(TIMER_TAG)) do addTimer(inst) end
CollectionService:GetInstanceAddedSignal(SPIN_TAG):Connect(addSpinner)
CollectionService:GetInstanceAddedSignal(GRADIENT_TAG):Connect(addGradient)
CollectionService:GetInstanceAddedSignal(TIMER_TAG):Connect(addTimer)
CollectionService:GetInstanceRemovedSignal(SPIN_TAG):Connect(function(inst) spinners[inst] = nil end)
CollectionService:GetInstanceRemovedSignal(GRADIENT_TAG):Connect(function(inst) gradients[inst] = nil end)
CollectionService:GetInstanceRemovedSignal(TIMER_TAG):Connect(function(inst) timers[inst] = nil end)

local function formatCountdown(remaining)
	if remaining <= 0 then return "ENDED" end
	local d = math.floor(remaining / 86400)
	local h = math.floor(remaining % 86400 / 3600)
	local m = math.floor(remaining % 3600 / 60)
	local s = math.floor(remaining % 60)
	if d > 0 then return string.format("%dd %dh %dm %ds", d, h, m, s) end
	if h > 0 then return string.format("%dh %dm %ds", h, m, s) end
	if m > 0 then return string.format("%dm %ds", m, s) end
	return string.format("%ds", s)
end

-- 30 Hz: gradient scroll / countdown text / pedestal spin all read the
-- clock, so skipping frames never desyncs -- but at full frame rate the
-- title-gradient Offset writes re-rasterized the pedestal billboards
-- every frame right where players idle.
local UPDATE_INTERVAL = 1 / 30
local accum = 0
RunService.Heartbeat:Connect(function(dt)
	accum += dt
	if accum < UPDATE_INTERVAL then return end
	accum = 0
	local now = os.clock()
	for model, entry in pairs(spinners) do
		if model.Parent then
			-- same float as the zone loot (RarityLootClient): bob + slow spin
			-- around the base pivot
			local t = now - entry.start
			local bob = math.sin(t * BOB_SPEED + entry.bobPhase) * BOB_HEIGHT
			model:PivotTo(entry.basePivot * CFrame.Angles(0, t * SPIN_SPEED, 0) + Vector3.new(0, bob, 0))
		else
			spinners[model] = nil
		end
	end
	for gradient, phase in pairs(gradients) do
		if gradient.Parent then
			local x = ((now * GRADIENT_SCROLL_SPEED + phase) % 2) - 1
			gradient.Offset = Vector2.new(x, 0)
		else
			gradients[gradient] = nil
		end
	end
	for inst, entry in pairs(timers) do
		if inst.Parent then
			local deadline = tonumber(inst:GetAttribute("DeadlineUnix"))
			if deadline then
				local text = formatCountdown(deadline - os.time())
				if text ~= entry.lastText then
					entry.lastText = text
					entry.label.Text = text
					if entry.inner then entry.inner.Text = text end
				end
			end
		else
			timers[inst] = nil
		end
	end
end)
