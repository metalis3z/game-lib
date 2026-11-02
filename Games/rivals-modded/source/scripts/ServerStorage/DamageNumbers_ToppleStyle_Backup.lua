-- Damage numbers for what the local player hits (UserInterface.DamageGui).
--
-- Every hit puts its own number on the point it landed on: it pops in, stands for a moment and
-- then topples over to the left or right, pivoting on its bottom corner like a falling sign,
-- fading as it goes down. When a target is left alone for COMBO_END seconds, the burst's total
-- pops up where the last hit landed, holds, and topples over the same way. Numbers always carry
-- one decimal (12.0, 11.5). Settings: "Damage Numbers" (on/off), "Damage Numbers Color" and
-- "Damage Numbers Critical Color" (hex).
--
--   DamageNumbers.Show(model, amount, critical, position?)
--
-- DamageGui is a 15-stud square canvas; each number is its Value label moving inside it, with
-- the canvas centred on the hit point. Positions are canvas fractions (the same on both axes).

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")
local Template = PlayerScripts:WaitForChild("UserInterface"):WaitForChild("DamageGui")

-- Size of the numbers relative to the DamageGui template's Value label.
local SIZE_SCALE = 0.7
local CRITICAL_SCALE = 1.2

-- A hit's number (seconds): pop in, stand, topple, fade out at the end.
local POP_SCALE = 1.5
local POP_SECONDS = 0.12
local STAND_SECONDS = 0.18
local TOPPLE_SECONDS = 0.5
local FADE_SECONDS = 0.25
local TOPPLE_ANGLE = 90
-- Extra drop once it has fallen over (canvas fractions).
local TOPPLE_DROP = 0.03

-- The combo total: shown once the target has not been hit for COMBO_END seconds.
local COMBO_END = 0.8
local COMBO_MIN_HITS = 2
local COMBO_SCALE = 1.35
local COMBO_POP_SECONDS = 0.25
local COMBO_HOLD = 0.6

-- A light outline around each number (the template's UIStroke): thin and see-through, its
-- thickness following the number's size on screen.
local STROKE_RATIO = 0.03
local STROKE_MIN = 1
local STROKE_MAX = 1.5
local STROKE_TRANSPARENCY = 0.55

local DEFAULT_COLOR = Color3.fromRGB(255, 255, 255)
local DEFAULT_CRITICAL_COLOR = Color3.fromRGB(255, 50, 50)

local DamageNumbers = {}

-- [model] = { Total, Hits, Critical, Position, Hash }
local combos: { [Instance]: any } = {}

local PlayerDataController = nil
local function setting(name: string)
	PlayerDataController = PlayerDataController or require(PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
	local ok, value = pcall(PlayerDataController.GetSetting, PlayerDataController, name)
	return ok and value or nil
end

local function color(critical: boolean): Color3
	local name = critical and "Damage Numbers Critical Color" or "Damage Numbers Color"
	local value = setting(name)
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

-- Always one decimal (12.0, 11.5), the way the game's own client writes damage
-- (ClientDPSDummy: "Total: %.1f").
local function format(amount: number): string
	return string.format("%.1f", amount)
end

-- A canvas centred on `position`, with its Value label ready.
local function canvasAt(position: Vector3)
	local attachment = Instance.new("Attachment")
	attachment.Name = "DamageNumber"
	attachment.WorldPosition = position
	attachment.Parent = workspace.Terrain

	local gui = Template:Clone()
	gui.Adornee = attachment
	gui.ExtentsOffset = Vector3.zero
	gui.ExtentsOffsetWorldSpace = Vector3.zero
	local frame = gui:WaitForChild("MainFrame")
	local label = frame:WaitForChild("Value")
	local absorbed = frame:FindFirstChild("Absorbed")
	if absorbed then
		absorbed.Visible = false
	end
	local stroke = label:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Transparency = STROKE_TRANSPARENCY
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	end
	gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	local function destroy()
		gui:Destroy()
		attachment:Destroy()
	end
	return frame, label, label:FindFirstChildOfClass("UIStroke"), destroy
end

local function scaled(size: UDim2, factor: number): UDim2
	return UDim2.new(size.X.Scale * factor, size.X.Offset, size.Y.Scale * factor, size.Y.Offset)
end

local function setTransparency(label: TextLabel, stroke: UIStroke?, strokeBase: number, alpha: number)
	label.TextTransparency = alpha
	if stroke then
		stroke.Transparency = strokeBase + (1 - strokeBase) * alpha
		stroke.Thickness = math.clamp(label.AbsoluteSize.Y * STROKE_RATIO, STROKE_MIN, STROKE_MAX)
	end
end

-- Places the label toppled by `progress` (0 upright, 1 lying on its side) toward `side` (1 right,
-- -1 left): rotated about the bottom corner of its text on that side.
local function topple(frame: Frame, label: TextLabel, progress: number, side: number)
	local canvas = frame.AbsoluteSize
	local bounds = label.TextBounds
	local halfWidth = canvas.X > 0 and bounds.X / canvas.X / 2 or 0.02
	local halfHeight = canvas.Y > 0 and bounds.Y / canvas.Y / 2 or 0.02

	local angle = math.rad(TOPPLE_ANGLE * progress) * side
	-- The pivot, relative to the label's centre (x right, y down).
	local pivotX, pivotY = side * halfWidth, halfHeight
	-- Rotating the centre around the pivot (clockwise for positive angles, as GUI rotation does).
	local cx, cy = -pivotX, -pivotY
	local cos, sin = math.cos(angle), math.sin(angle)
	local rx, ry = cx * cos - cy * sin, cx * sin + cy * cos
	label.Rotation = math.deg(angle)
	label.Position = UDim2.fromScale(0.5 + pivotX + rx, 0.5 + pivotY + ry + TOPPLE_DROP * progress * progress)
end

-- One hit: pops in on the hit point, stands, then topples over to a side and fades.
local function dropNumber(position: Vector3, amount: number, critical: boolean)
	local frame, label, stroke, destroy = canvasAt(position)
	local baseSize = scaled(label.Size, (critical and CRITICAL_SCALE or 1) * SIZE_SCALE)
	local strokeBase = stroke and stroke.Transparency or 0
	label.Text = format(amount)
	label.TextColor3 = color(critical)
	label.Size = scaled(baseSize, POP_SCALE)

	local side = math.random() < 0.5 and -1 or 1
	local lifetime = POP_SECONDS + STAND_SECONDS + TOPPLE_SECONDS
	local started = os.clock()
	local connection
	connection = RunService.RenderStepped:Connect(function()
		local t = os.clock() - started
		if t >= lifetime then
			connection:Disconnect()
			destroy()
			return
		end
		if t < POP_SECONDS then
			label.Size = scaled(baseSize, POP_SCALE + (1 - POP_SCALE) * (t / POP_SECONDS))
		else
			label.Size = baseSize
		end
		local toppleTime = t - POP_SECONDS - STAND_SECONDS
		local progress = toppleTime > 0 and math.clamp(toppleTime / TOPPLE_SECONDS, 0, 1) or 0
		-- Accelerates like something falling over.
		topple(frame, label, progress * progress, side)
		local fadeStart = lifetime - FADE_SECONDS
		setTransparency(label, stroke, strokeBase, t > fadeStart and (t - fadeStart) / FADE_SECONDS or 0)
	end)
end

-- The burst's total, where the last hit landed: pops in, holds, then topples over and fades.
local function showCombo(combo)
	local frame, label, stroke, destroy = canvasAt(combo.Position)
	local baseSize = scaled(label.Size, COMBO_SCALE * SIZE_SCALE)
	local strokeBase = stroke and stroke.Transparency or 0
	label.Text = format(combo.Total)
	label.TextColor3 = color(combo.Critical)
	label.Size = UDim2.new(0, 0, 0, 0)
	TweenService:Create(label, TweenInfo.new(COMBO_POP_SECONDS, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = baseSize }):Play()

	local side = math.random() < 0.5 and -1 or 1
	local lifetime = COMBO_POP_SECONDS + COMBO_HOLD + TOPPLE_SECONDS
	local started = os.clock()
	local connection
	connection = RunService.RenderStepped:Connect(function()
		local t = os.clock() - started
		if t >= lifetime then
			connection:Disconnect()
			destroy()
			return
		end
		local toppleTime = t - COMBO_POP_SECONDS - COMBO_HOLD
		local progress = toppleTime > 0 and math.clamp(toppleTime / TOPPLE_SECONDS, 0, 1) or 0
		topple(frame, label, progress * progress, side)
		local fadeStart = lifetime - FADE_SECONDS
		setTransparency(label, stroke, strokeBase, t > fadeStart and (t - fadeStart) / FADE_SECONDS or 0)
	end)
end

function DamageNumbers.Show(model: Instance?, amount: number, critical: boolean?, position: Vector3?)
	if type(amount) ~= "number" or amount <= 0 then
		return
	end
	if setting("Damage Numbers") == false then
		return
	end
	if typeof(position) ~= "Vector3" then
		if typeof(model) ~= "Instance" then
			return
		end
		local ok, pivot = pcall(function()
			return model:GetPivot().Position
		end)
		if not ok then
			return
		end
		position = pivot
	end

	dropNumber(position, amount, critical == true)

	if typeof(model) ~= "Instance" then
		return
	end
	local combo = combos[model]
	if not combo then
		combo = { Total = 0, Hits = 0, Critical = false, Hash = 0 }
		combos[model] = combo
	end
	combo.Total += amount
	combo.Hits += 1
	combo.Critical = combo.Critical or critical == true
	combo.Position = position
	combo.Hash += 1
	local hash = combo.Hash
	task.delay(COMBO_END, function()
		if combos[model] ~= combo or combo.Hash ~= hash then
			return
		end
		combos[model] = nil
		if combo.Hits >= COMBO_MIN_HITS then
			showCombo(combo)
		end
	end)
end

return DamageNumbers
