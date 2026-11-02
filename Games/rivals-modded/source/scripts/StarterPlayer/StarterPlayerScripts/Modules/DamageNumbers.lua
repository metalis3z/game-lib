-- Damage numbers for what the local player hits (UserInterface.DamageGui).
--
-- Ported from the "gun game" place (ClientItem._DamageNumber there), whose motion was replayed
-- from live captures of the real game (see project doc sniper-and-damage-numbers-groundtruth):
--
--   * Every number sits on the top of the target's HEAD, wherever the shot landed.
--   * Whole numbers (12, 24...), white; a critical hit is red and ~33% taller.
--   * Screen-space "toss": MainFrame grows to ~1.05, pops up a hair, then shrinks to ~0.47 while
--     falling and drifting to a random side, spinning faster as it goes (rotation = +/-2690 * t^4).
--     No fade, no world movement. Lives ~0.566s.
--   * Accumulation IN PLACE: another hit on the same target while its number is alive adds to it
--     and re-pops the SAME billboard, so it visibly climbs (15 -> 30 -> 45) in one spot.
--
-- Settings (SettingsLibrary): "Damage Numbers" (off hides them), "Damage Numbers Color" and
-- "Damage Numbers Critical Color" (Color3 or hex); white / red when unset.
--
--   DamageNumbers.Show(model, amount, critical, position?)
--
-- The previous topple-style version is kept in ServerStorage.DamageNumbers_ToppleStyle_Backup.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")
local Template = PlayerScripts:WaitForChild("UserInterface"):WaitForChild("DamageGui")

local DEFAULT_COLOR = Color3.fromRGB(255, 255, 255)
local DEFAULT_CRITICAL_COLOR = Color3.fromRGB(255, 50, 50)

-- MainFrame.Size Y-scale: normal hits 0.75, crits 1.0 (X-scale 1.0 for both).
local NORMAL_HEIGHT = 0.75
local CRITICAL_HEIGHT = 1.0
local LIFE = 0.566
-- A hit this soon after the last one on the same target adds to its number.
local ACCUMULATE_WINDOW = 0.9
local SPIN = 2690

-- (t, size multiplier, sideways drift, vertical drift) -- captured frame by frame.
local KEYFRAMES = {
	{ 0.00, 1.000, 0.000, 0.000 }, { 0.05, 1.006, 0.001, -0.002 }, { 0.10, 1.019, 0.005, -0.005 },
	{ 0.15, 1.035, 0.011, -0.009 }, { 0.20, 1.047, 0.019, -0.012 }, { 0.23, 1.050, 0.026, -0.012 },
	{ 0.27, 1.046, 0.035, -0.011 }, { 0.30, 1.035, 0.042, -0.009 }, { 0.33, 1.019, 0.051, -0.004 },
	{ 0.37, 0.985, 0.063, 0.006 }, { 0.40, 0.938, 0.071, 0.015 }, { 0.43, 0.885, 0.082, 0.029 },
	{ 0.47, 0.806, 0.093, 0.049 }, { 0.50, 0.715, 0.110, 0.085 }, { 0.53, 0.598, 0.120, 0.117 },
	{ 0.55, 0.534, 0.122, 0.130 }, { 0.566, 0.470, 0.125, 0.140 },
}

local DamageNumbers = {}

-- [model] = { total, critical, expire, restart, anchor }
local active: { [Instance]: any } = {}

local PlayerDataController = nil
local function setting(name: string)
	PlayerDataController = PlayerDataController or require(PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
	local ok, value = pcall(PlayerDataController.GetSetting, PlayerDataController, name)
	return ok and value or nil
end

local function colorFor(critical: boolean): Color3
	local value = setting(critical and "Damage Numbers Critical Color" or "Damage Numbers Color")
	if typeof(value) == "Color3" then
		return value
	end
	if type(value) == "string" then
		local ok, parsed = pcall(Color3.fromHex, value)
		if ok then
			return parsed
		end
	end
	return critical and DEFAULT_CRITICAL_COLOR or DEFAULT_COLOR
end

local function sample(t: number): (number, number, number)
	for index = 1, #KEYFRAMES - 1 do
		local a, b = KEYFRAMES[index], KEYFRAMES[index + 1]
		if t <= b[1] then
			local f = (t - a[1]) / (b[1] - a[1])
			return a[2] + (b[2] - a[2]) * f, a[3] + (b[3] - a[3]) * f, a[4] + (b[4] - a[4]) * f
		end
	end
	local last = KEYFRAMES[#KEYFRAMES]
	return last[2], last[3], last[4]
end

-- The top of the target's head; else where the hit landed; else the target's pivot.
local function anchorPosition(model: Instance?, position: Vector3?): Vector3?
	if typeof(model) == "Instance" then
		local head = model:FindFirstChild("Head") or model:FindFirstChild("head")
		if head and head:IsA("BasePart") then
			return head.Position + Vector3.new(0, head.Size.Y / 2, 0)
		end
	end
	if typeof(position) == "Vector3" then
		return position
	end
	if typeof(model) == "Instance" then
		local ok, pivot = pcall(function()
			return model:GetPivot().Position
		end)
		if ok then
			return pivot
		end
	end
	return nil
end

function DamageNumbers.Show(model: Instance?, amount: number, critical: boolean?, position: Vector3?)
	if type(amount) ~= "number" or amount <= 0 then
		return
	end
	if setting("Damage Numbers") == false then
		return
	end
	critical = critical == true
	local damage = math.floor(amount + 0.5)

	-- Still showing a number on this target: add to it and re-pop the same billboard.
	local key = typeof(model) == "Instance" and model or nil
	local previous = key and active[key]
	if previous and os.clock() < previous.expire then
		previous.total += damage
		previous.critical = previous.critical or critical
		previous.expire = os.clock() + ACCUMULATE_WINDOW
		previous.restart(previous.total, previous.critical)
		return
	end

	local at = anchorPosition(model, position)
	if not at then
		return
	end

	local attachment = Instance.new("Attachment")
	attachment.Name = "DamageNumber"
	attachment.WorldPosition = at
	attachment.Parent = workspace.Terrain

	local gui = Template:Clone()
	gui.Adornee = attachment
	local frame = gui:WaitForChild("MainFrame")
	local label = frame:WaitForChild("Value")
	local absorbed = frame:FindFirstChild("Absorbed")
	if absorbed then
		absorbed.Visible = false
	end
	label.Text = tostring(damage)
	label.TextColor3 = colorFor(critical)
	gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	local state = {
		started = os.clock(),
		height = critical and CRITICAL_HEIGHT or NORMAL_HEIGHT,
		side = math.random() < 0.5 and -1 or 1,
	}

	local function apply(t: number)
		local size, drift, drop = sample(t)
		frame.Size = UDim2.fromScale(size, state.height * size)
		frame.Position = UDim2.fromScale(0.5 + state.side * drift, 0.5 + drop)
		frame.Rotation = state.side * SPIN * t * t * t * t
	end
	apply(0)

	local entry = {
		total = damage,
		critical = critical,
		expire = os.clock() + ACCUMULATE_WINDOW,
		anchor = attachment,
	}
	function entry.restart(total: number, isCritical: boolean)
		if label.Parent then
			label.Text = tostring(total)
			label.TextColor3 = colorFor(isCritical)
		end
		state.height = isCritical and CRITICAL_HEIGHT or NORMAL_HEIGHT
		state.started = os.clock()
	end
	if key then
		active[key] = entry
	end

	local connection
	connection = RunService.RenderStepped:Connect(function()
		local t = os.clock() - state.started
		if t >= LIFE or not gui.Parent then
			connection:Disconnect()
			if key and active[key] == entry then
				active[key] = nil
			end
			gui:Destroy()
			attachment:Destroy()
			return
		end
		apply(t)
	end)
end

return DamageNumbers
