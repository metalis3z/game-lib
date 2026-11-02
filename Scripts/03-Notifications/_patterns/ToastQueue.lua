--!strict
-- ToastQueue (clean pattern) - ModuleScript, client only.
-- Put in ReplicatedStorage and require from a LocalScript.
--
-- Credits / ideas taken from:
--   drill-and-mine  NotificationsController  (merge duplicates into "(xN)", pulse, token-based re-schedule)
--   needoh-escape   NotificationManager      (Success/Error styles, fire-and-forget, survives respawn)
--   bee-swarm-sim   Alerts / NEWAlerts       (max visible rows, oldest pushed out)
--
-- Usage:
--   local Toast = require(game.ReplicatedStorage.ToastQueue)
--   Toast.Success("Purchased Sword!")
--   Toast.Error("Not enough coins")
--   Toast.Show("Double XP active", { kind = "Info", duration = 5 })
--   Toast.SetSound("Error", "rbxassetid://<your sound id>")  -- optional
--
--   -- Let the server send toasts too:
--   remote.OnClientEvent:Connect(function(text, kind) Toast.Show(text, { kind = kind }) end)
--
-- Same text + kind shown again while still on screen => the existing toast shows "(x2)", pulses,
-- and its timer restarts, instead of stacking a copy.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

export type Kind = "Success" | "Error" | "Info" | "Warning"
export type Options = { kind: Kind?, duration: number? }

local ToastQueue = {}

-- [ CONFIG ]
local MAX_VISIBLE = 4
local DEFAULT_DURATION = 2.5
local POP_IN = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local POP_OUT = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.In)
local PULSE = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true)

local STYLES: { [string]: { bg: Color3, stroke: Color3 } } = {
	Success = { bg = Color3.fromRGB(46, 160, 67), stroke = Color3.fromRGB(20, 70, 30) },
	Error = { bg = Color3.fromRGB(205, 45, 45), stroke = Color3.fromRGB(90, 15, 15) },
	Warning = { bg = Color3.fromRGB(230, 160, 30), stroke = Color3.fromRGB(100, 65, 10) },
	Info = { bg = Color3.fromRGB(60, 120, 220), stroke = Color3.fromRGB(20, 45, 100) },
}

local sounds: { [string]: Sound } = {}

type Entry = {
	key: string,
	text: string,
	frame: Frame,
	label: TextLabel,
	scale: UIScale,
	count: number,
	token: number,
	closing: boolean,
}

local active: { Entry } = {} -- oldest first
local orderCounter = 0
local container: Frame? = nil

local function getContainer(): Frame
	if container and container.Parent then
		return container
	end
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

	local gui = Instance.new("ScreenGui")
	gui.Name = "ToastQueue"
	gui.ResetOnSpawn = false -- keeps toasts alive through respawn
	gui.DisplayOrder = 100
	gui.IgnoreGuiInset = false
	gui.Parent = playerGui

	local holder = Instance.new("Frame")
	holder.Name = "Holder"
	holder.AnchorPoint = Vector2.new(0.5, 0)
	holder.Position = UDim2.new(0.5, 0, 0, 12)
	holder.Size = UDim2.new(0.4, 0, 0.5, 0)
	holder.BackgroundTransparency = 1
	holder.Parent = gui

	local constraint = Instance.new("UISizeConstraint")
	constraint.MinSize = Vector2.new(260, 0)
	constraint.MaxSize = Vector2.new(520, math.huge)
	constraint.Parent = holder

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Padding = UDim.new(0, 6)
	layout.Parent = holder

	container = holder
	return holder
end

local function playSound(kind: string)
	local s = sounds[kind]
	if s then
		SoundService:PlayLocalSound(s)
	end
end

local function removeEntry(entry: Entry)
	local i = table.find(active, entry)
	if i then
		table.remove(active, i)
	end
end

local function close(entry: Entry)
	if entry.closing then
		return
	end
	entry.closing = true
	removeEntry(entry)
	local tween = TweenService:Create(entry.scale, POP_OUT, { Scale = 0 })
	tween:Play()
	tween.Completed:Once(function()
		entry.frame:Destroy()
	end)
end

local function schedule(entry: Entry, duration: number)
	entry.token += 1
	local myToken = entry.token
	task.delay(duration, function()
		-- a newer Show() of the same toast bumped the token: keep it alive
		if entry.token == myToken then
			close(entry)
		end
	end)
end

local function build(text: string, kind: string): Entry
	local style = STYLES[kind] or STYLES.Info
	orderCounter += 1

	local frame = Instance.new("Frame")
	frame.Name = "Toast"
	frame.Size = UDim2.new(1, 0, 0, 40)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.BackgroundColor3 = style.bg
	frame.LayoutOrder = orderCounter

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = style.stroke
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = frame

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 12)
	padding.PaddingRight = UDim.new(0, 12)
	padding.PaddingTop = UDim.new(0, 6)
	padding.PaddingBottom = UDim.new(0, 6)
	padding.Parent = frame

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, 0, 0, 28)
	label.AutomaticSize = Enum.AutomaticSize.Y
	label.TextWrapped = true
	label.RichText = true
	label.Font = Enum.Font.GothamBold
	label.TextSize = 20
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = text
	label.Parent = frame

	local textStroke = Instance.new("UIStroke")
	textStroke.Thickness = 1.5
	textStroke.Color = style.stroke
	textStroke.Parent = label

	local scale = Instance.new("UIScale")
	scale.Scale = 0
	scale.Parent = frame

	frame.Parent = getContainer()
	TweenService:Create(scale, POP_IN, { Scale = 1 }):Play()

	return {
		key = kind .. "|" .. text,
		text = text,
		frame = frame,
		label = label,
		scale = scale,
		count = 1,
		token = 0,
		closing = false,
	}
end

function ToastQueue.Show(text: string, options: Options?)
	local kind: string = (options and options.kind) or "Info"
	local duration = (options and options.duration) or DEFAULT_DURATION
	local key = kind .. "|" .. text

	-- 1. Merge with an identical toast that is still visible
	for _, entry in active do
		if entry.key == key and not entry.closing then
			entry.count += 1
			entry.label.Text = string.format("%s (x%d)", entry.text, entry.count)
			TweenService:Create(entry.scale, PULSE, { Scale = 1.08 }):Play()
			schedule(entry, duration)
			playSound(kind)
			return
		end
	end

	-- 2. Make room: drop the oldest toast(s)
	while #active >= MAX_VISIBLE do
		close(active[1])
	end

	-- 3. New toast
	local entry = build(text, kind)
	table.insert(active, entry)
	schedule(entry, duration)
	playSound(kind)
end

function ToastQueue.Success(text: string, duration: number?)
	ToastQueue.Show(text, { kind = "Success", duration = duration })
end

function ToastQueue.Error(text: string, duration: number?)
	ToastQueue.Show(text, { kind = "Error", duration = duration })
end

function ToastQueue.Info(text: string, duration: number?)
	ToastQueue.Show(text, { kind = "Info", duration = duration })
end

function ToastQueue.Warning(text: string, duration: number?)
	ToastQueue.Show(text, { kind = "Warning", duration = duration })
end

-- Register a sound per kind. The Sound lives in SoundService and is played with PlayLocalSound.
function ToastQueue.SetSound(kind: Kind, soundId: string, volume: number?)
	local old = sounds[kind]
	if old then
		old:Destroy()
	end
	local s = Instance.new("Sound")
	s.Name = "Toast_" .. kind
	s.SoundId = soundId
	s.Volume = volume or 0.6
	s.Parent = SoundService
	sounds[kind] = s
end

function ToastQueue.ClearAll()
	for i = #active, 1, -1 do
		close(active[i])
	end
end

return ToastQueue
