--[[
	TabUnderline  (ModuleScript)
	A selection bar that glides under the active tab. Optional "stretchy" mode: the leading
	edge runs ahead first, then the trailing edge catches up (the elastic underline seen in
	modern mobile UIs). Also tints tab labels and punches the selected tab with a small pop.

	Source note: none of the 66 games had a clean, standalone tab underline (tabs were mostly
	instant Visible swaps). This pattern combines easing choices observed elsewhere:
	  - drill-and-mine HUDSlideController / FrameAnimator (Quart / Back easing, scale-only positions)
	  - drill-and-mine HoverController (cancel the running tween before starting a new one)
	  - smash-egg-for-animals ButtonFX (0.12 s Back-out pops)

	Usage (LocalScript):
		local TabUnderline = require(game.ReplicatedStorage.UI.TabUnderline)

		-- tabBar: a Frame holding the tab buttons (any layout, e.g. UIListLayout)
		-- underline: a Frame inside tabBar that is NOT part of the layout (put it in tabBar but
		--            give it its own Position; set Size Y as you like, e.g. UDim2.new(0, 0, 0, 4))
		local tabs = TabUnderline.new({
			container = tabBar,
			underline = tabBar.Underline,
			buttons = { tabBar.Pets, tabBar.Items, tabBar.Eggs },
			stretch = true,
			widthFactor = 0.7,              -- underline width relative to the tab width
			activeColor = Color3.new(1, 1, 1),
			idleColor = Color3.fromRGB(150, 150, 160),
			onSelect = function(index, button) showPage(button.Name) end,
		})
		tabs:select(1, true) -- instant on startup

	Note: if tabBar has a UIListLayout, the underline must be excluded from it. Easiest: put the
	underline in a separate Frame overlaying tabBar and pass that Frame as `container`.
]]

local TweenService = game:GetService("TweenService")

local TabUnderline = {}
TabUnderline.__index = TabUnderline

function TabUnderline.new(opts)
	local self = setmetatable({}, TabUnderline)
	self.container = opts.container :: GuiObject
	self.underline = opts.underline :: GuiObject
	self.buttons = opts.buttons :: { GuiButton }
	self.stretch = opts.stretch == true
	self.widthFactor = opts.widthFactor or 1
	self.info = opts.info or TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	self.activeColor = opts.activeColor
	self.idleColor = opts.idleColor
	self.onSelect = opts.onSelect
	self.selected = nil
	self.tweens = {}
	self.conns = {}
	self.version = 0

	self.underline.AnchorPoint = Vector2.new(0, self.underline.AnchorPoint.Y)

	for i, button in ipairs(self.buttons) do
		table.insert(self.conns, button.Activated:Connect(function()
			self:select(i)
		end))
	end
	-- keep the bar glued to its tab when the screen / container resizes
	table.insert(self.conns, self.container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if self.selected then
			self:select(self.selected, true)
		end
	end))
	return self
end

-- left edge (px, relative to container) and width (px) of the bar under tab i
function TabUnderline:_target(i: number): (number, number)
	local b = self.buttons[i]
	local w = b.AbsoluteSize.X * self.widthFactor
	local x = (b.AbsolutePosition.X - self.container.AbsolutePosition.X) + (b.AbsoluteSize.X - w) / 2
	return x, w
end

function TabUnderline:_set(x: number, w: number)
	local p, s = self.underline.Position, self.underline.Size
	self.underline.Position = UDim2.new(0, x, p.Y.Scale, p.Y.Offset)
	self.underline.Size = UDim2.new(0, w, s.Y.Scale, s.Y.Offset)
end

function TabUnderline:_tween(x: number, w: number, info: TweenInfo): Tween
	for _, t in ipairs(self.tweens) do
		t:Cancel()
	end
	table.clear(self.tweens)
	local p, s = self.underline.Position, self.underline.Size
	local a = TweenService:Create(self.underline, info, { Position = UDim2.new(0, x, p.Y.Scale, p.Y.Offset) })
	local b = TweenService:Create(self.underline, info, { Size = UDim2.new(0, w, s.Y.Scale, s.Y.Offset) })
	table.insert(self.tweens, a)
	table.insert(self.tweens, b)
	a:Play()
	b:Play()
	return a
end

function TabUnderline:_tint(i: number, instant: boolean?)
	if not (self.activeColor and self.idleColor) then
		return
	end
	local info = instant and TweenInfo.new(0) or self.info
	for j, b in ipairs(self.buttons) do
		local color = (j == i) and self.activeColor or self.idleColor
		local label = b:IsA("TextButton") and b or b:FindFirstChildWhichIsA("TextLabel")
		if label then
			TweenService:Create(label, info, { TextColor3 = color }):Play()
		end
		if b:IsA("ImageButton") then
			TweenService:Create(b, info, { ImageColor3 = color }):Play()
		end
	end
end

local function pop(button: GuiObject)
	local scale = button:FindFirstChild("TabPop") or Instance.new("UIScale")
	scale.Name = "TabPop"
	scale.Parent = button
	scale.Scale = 0.9
	TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
end

function TabUnderline:select(i: number, instant: boolean?)
	local previous = self.selected
	self.selected = i
	self.version += 1
	local version = self.version
	local x, w = self:_target(i)

	if instant or previous == nil then
		for _, t in ipairs(self.tweens) do
			t:Cancel()
		end
		self:_set(x, w)
	elseif self.stretch and previous ~= i then
		-- phase 1: stretch the leading edge to the new tab, phase 2: pull the trailing edge in
		local ox = self.underline.Position.X.Offset
		local ow = self.underline.Size.X.Offset
		local left = math.min(ox, x)
		local right = math.max(ox + ow, x + w)
		local half = TweenInfo.new(self.info.Time * 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local first = self:_tween(left, right - left, half)
		first.Completed:Once(function(state)
			if state == Enum.PlaybackState.Completed and self.version == version then
				self:_tween(x, w, TweenInfo.new(self.info.Time * 0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
			end
		end)
	else
		self:_tween(x, w, self.info)
	end

	self:_tint(i, instant)
	if not instant and previous ~= i then
		pop(self.buttons[i])
	end
	if self.onSelect and previous ~= i then
		task.spawn(self.onSelect, i, self.buttons[i])
	end
end

function TabUnderline:destroy()
	for _, c in ipairs(self.conns) do
		c:Disconnect()
	end
	for _, t in ipairs(self.tweens) do
		t:Cancel()
	end
end

return TabUnderline
