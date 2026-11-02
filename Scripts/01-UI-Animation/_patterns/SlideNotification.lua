--[[
	SlideNotification  (ModuleScript)
	Toast notifications that slide in from the screen edge, stack, merge duplicates into
	"(x3)", show a draining timer bar, and slide out while the stack closes the gap smoothly.
	Everything is built in code -- no templates needed.

	Derived from techniques in:
	  - drill-and-mine NotificationsController (merge identical toasts into "(xN)" + overshoot pulse, restart the
	                                            dismiss timer with a token, Back-in exit, fade every descendant)
	  - bee-swarm-sim  NEWAlerts               (stacked alerts grow in with Back-out 0.25 s, merge by item, lifetime 5 s)
	  - brainrot-lab   NotificationManager     (Success / Error colour styles, 0.3 s Quad fades, 2 s lifetime)

	Usage (LocalScript):
		local SlideNotification = require(game.ReplicatedStorage.UI.SlideNotification)

		local notify = SlideNotification.new(player.PlayerGui, { corner = "TopRight", width = 320 })
		notify:push("Not enough coins!", { style = "Error" })
		notify:push("+250 Gems", { style = "Success", lifetime = 2 })
		notify:push("Daily reward ready", { color = Color3.fromRGB(255, 200, 60), icon = "rbxassetid://0000000" })

	corner: "TopRight" | "BottomRight" | "TopLeft" | "BottomLeft"
]]

local TweenService = game:GetService("TweenService")

local SlideNotification = {}
SlideNotification.__index = SlideNotification

SlideNotification.Styles = {
	Info = Color3.fromRGB(80, 150, 255),
	Success = Color3.fromRGB(70, 210, 100),
	Error = Color3.fromRGB(235, 70, 70),
	Warning = Color3.fromRGB(255, 185, 50),
}

local SLIDE_IN = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local SLIDE_OUT = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local COLLAPSE = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local PULSE_UP = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local PULSE_DOWN = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

function SlideNotification.new(playerGui: Instance, opts)
	opts = opts or {}
	local self = setmetatable({}, SlideNotification)
	self.corner = opts.corner or "TopRight"
	self.width = opts.width or 300
	self.height = opts.height or 54
	self.padding = opts.padding or 8
	self.maxVisible = opts.maxVisible or 5
	self.lifetime = opts.lifetime or 3
	self.font = opts.font or Font.new("rbxasset://fonts/families/FredokaOne.json")
	self.active = {} -- [key] = entry
	self.order = 0
	self.list = {} -- entries in arrival order

	local right = self.corner:find("Right") ~= nil
	local bottom = self.corner:find("Bottom") ~= nil
	self.fromRight = right

	local gui = Instance.new("ScreenGui")
	gui.Name = "SlideNotifications"
	gui.ResetOnSpawn = false
	gui.DisplayOrder = opts.displayOrder or 90
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Parent = playerGui
	self.gui = gui

	local holder = Instance.new("Frame")
	holder.Name = "Stack"
	holder.BackgroundTransparency = 1
	holder.AnchorPoint = Vector2.new(right and 1 or 0, bottom and 1 or 0)
	holder.Position = UDim2.new(right and 1 or 0, right and -16 or 16, bottom and 1 or 0, bottom and -16 or 16)
	holder.Size = UDim2.new(0, self.width, 1, -32)
	holder.Parent = gui
	self.holder = holder

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, self.padding)
	layout.VerticalAlignment = bottom and Enum.VerticalAlignment.Bottom or Enum.VerticalAlignment.Top
	layout.HorizontalAlignment = right and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left
	layout.Parent = holder

	return self
end

function SlideNotification:_offscreen(): UDim2
	-- the card lives inside a fixed "slot"; sliding the card (not the slot) keeps the layout stable
	return UDim2.new(self.fromRight and 1.15 or -1.15, 0, 0, 0)
end

function SlideNotification:_build(text: string, color: Color3, icon: string?)
	local slot = Instance.new("Frame")
	slot.Name = "Toast"
	slot.BackgroundTransparency = 1
	slot.Size = UDim2.new(1, 0, 0, self.height)

	local card = Instance.new("Frame")
	card.Name = "Card"
	card.BackgroundColor3 = Color3.fromRGB(28, 30, 38)
	card.BackgroundTransparency = 0.08
	card.Size = UDim2.fromScale(1, 1)
	card.Position = self:_offscreen()
	card.Parent = slot
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = card
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = 2
	stroke.Parent = card
	local scale = Instance.new("UIScale")
	scale.Parent = card

	local accent = Instance.new("Frame")
	accent.Name = "Accent"
	accent.BackgroundColor3 = color
	accent.BorderSizePixel = 0
	accent.Size = UDim2.new(0, 6, 1, -16)
	accent.Position = UDim2.fromOffset(8, 8)
	accent.Parent = card
	local ac = Instance.new("UICorner")
	ac.CornerRadius = UDim.new(1, 0)
	ac.Parent = accent

	local textX = 22
	if icon then
		local img = Instance.new("ImageLabel")
		img.BackgroundTransparency = 1
		img.Image = icon
		img.Size = UDim2.fromOffset(self.height - 18, self.height - 18)
		img.Position = UDim2.fromOffset(22, 9)
		img.Parent = card
		textX = 22 + self.height - 10
	end

	local label = Instance.new("TextLabel")
	label.Name = "Text"
	label.BackgroundTransparency = 1
	label.FontFace = self.font
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Position = UDim2.fromOffset(textX, 8)
	label.Size = UDim2.new(1, -(textX + 10), 1, -18)
	label.Parent = card
	local ts = Instance.new("UITextSizeConstraint")
	ts.MaxTextSize = 22
	ts.Parent = label

	local timer = Instance.new("Frame")
	timer.Name = "Timer"
	timer.BackgroundColor3 = color
	timer.BorderSizePixel = 0
	timer.AnchorPoint = Vector2.new(0, 1)
	timer.Position = UDim2.new(0, 10, 1, -4)
	timer.Size = UDim2.new(1, -20, 0, 3)
	timer.Parent = card

	return slot, card, label, scale, timer
end

function SlideNotification:_scheduleDismiss(entry)
	entry.token += 1
	local token = entry.token
	-- draining timer bar (restarts on merge)
	entry.timer.Size = UDim2.new(1, -20, 0, 3)
	if entry.timerTween then
		entry.timerTween:Cancel()
	end
	entry.timerTween = TweenService:Create(entry.timer, TweenInfo.new(entry.lifetime, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 0, 3) })
	entry.timerTween:Play()
	task.delay(entry.lifetime, function()
		if entry.token == token then
			self:_dismiss(entry)
		end
	end)
end

function SlideNotification:_dismiss(entry)
	if entry.gone then
		return
	end
	entry.gone = true
	self.active[entry.key] = nil
	local idx = table.find(self.list, entry)
	if idx then
		table.remove(self.list, idx)
	end
	local out = TweenService:Create(entry.card, SLIDE_OUT, { Position = self:_offscreen() })
	out.Completed:Once(function()
		-- collapse the slot so the toasts below/above glide into the gap
		local collapse = TweenService:Create(entry.slot, COLLAPSE, { Size = UDim2.new(1, 0, 0, 0) })
		collapse.Completed:Once(function()
			entry.slot:Destroy()
		end)
		collapse:Play()
	end)
	out:Play()
end

-- push(text, { style = "Info"|"Success"|"Error"|"Warning", color = Color3, lifetime = seconds, icon = assetId, key = string })
function SlideNotification:push(text: string, opts)
	opts = opts or {}
	local color = opts.color or SlideNotification.Styles[opts.style or "Info"] or SlideNotification.Styles.Info
	local key = opts.key or ((opts.style or "") .. "|" .. text)
	local lifetime = opts.lifetime or self.lifetime

	local existing = self.active[key]
	if existing and not existing.gone then
		existing.count += 1
		existing.label.Text = text .. "  (x" .. existing.count .. ")"
		existing.lifetime = lifetime
		self:_scheduleDismiss(existing)
		local up = TweenService:Create(existing.scale, PULSE_UP, { Scale = 1.08 })
		up.Completed:Once(function()
			TweenService:Create(existing.scale, PULSE_DOWN, { Scale = 1 }):Play()
		end)
		up:Play()
		return existing
	end

	local slot, card, label, scale, timer = self:_build(text, color, opts.icon)
	self.order += 1
	slot.LayoutOrder = self.order
	slot.Parent = self.holder

	local entry = {
		key = key, slot = slot, card = card, label = label, scale = scale, timer = timer,
		count = 1, lifetime = lifetime, token = 0, gone = false, timerTween = nil,
	}
	self.active[key] = entry
	table.insert(self.list, entry)

	TweenService:Create(card, SLIDE_IN, { Position = UDim2.fromScale(0, 0) }):Play()
	self:_scheduleDismiss(entry)

	while #self.list > self.maxVisible do
		self:_dismiss(self.list[1])
	end
	return entry
end

function SlideNotification:clear()
	for _, entry in ipairs(table.clone(self.list)) do
		self:_dismiss(entry)
	end
end

function SlideNotification:destroy()
	self.gui:Destroy()
end

return SlideNotification
