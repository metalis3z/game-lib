-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	local v1 = false
	local v2 = nil
	local t = {}

	local function EmptyMenuStack(p12) --[[ EmptyMenuStack | Line: 8 | Upvalues: t (copy), p1 (copy), v1 (ref), v2 (ref) ]]
		for i = #t, if p12 then p12 + 1 or 1 else 1, -1 do
			local v3 = t[i]

			v3.state.isOpened:set(false)
			v3.Instance.BackgroundColor3 = p1._config.HeaderColor
			v3.Instance.BackgroundTransparency = 1
			table.remove(t, i)
		end

		if #t ~= 0 then
			return
		end

		v1 = false
		v2 = nil
	end

	local function UpdateChildContainerTransform(p12) --[[ UpdateChildContainerTransform | Line: 25 | Upvalues: p1 (copy) ]]
		local isType = p12.parentWidget.type == "Menu"
		local v1 = p12.Instance
		local ChildContainer = p12.ChildContainer

		ChildContainer.Size = UDim2.fromOffset(math.max(ChildContainer.AbsoluteSize.X, v1.AbsoluteSize.X), (math.max(ChildContainer.AbsoluteSize.Y, v1.AbsoluteSize.Y)))

		if ChildContainer.Parent == nil then
			return
		end

		local AbsolutePosition = v1.AbsolutePosition
		local AbsoluteSize = v1.AbsoluteSize
		local AbsoluteSize2 = ChildContainer.AbsoluteSize
		local PopupBorderSize = p1._config.PopupBorderSize
		local AbsoluteSize3 = ChildContainer.Parent.AbsoluteSize
		local v3 = AbsolutePosition.X + PopupBorderSize

		if p12.parentWidget.type == "Menu" then
			v3 = if AbsolutePosition.X + AbsoluteSize2.X > AbsoluteSize3.X then AbsolutePosition.X - PopupBorderSize - (isType and AbsoluteSize2.X or 0) else AbsolutePosition.X + PopupBorderSize + (isType and AbsoluteSize.X or 0)
		end

		ChildContainer.Position = UDim2.fromOffset(v3, if AbsolutePosition.Y + AbsoluteSize2.Y > AbsoluteSize3.Y then AbsolutePosition.Y - PopupBorderSize - AbsoluteSize2.Y + (isType and AbsoluteSize.Y or 0) else AbsolutePosition.Y + PopupBorderSize + (if isType then 0 else AbsoluteSize.Y))
	end

	p2.UserInputService.InputBegan:Connect(function(p1) --[[ Line: 65 | Upvalues: v1 (ref), v2 (ref), p2 (copy), t (copy), EmptyMenuStack (copy) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.MouseButton2 then
			return
		end

		if v1 == false then
			return
		end

		if v2 == nil then
			return
		end

		local v12 = p2.getMouseLocation()
		local v22 = false

		for v3, v4 in t do
			for v5, v6 in { v4.ChildContainer, v4.Instance } do
				local AbsolutePosition = v6.AbsolutePosition

				if p2.isPosInsideRect(v12, AbsolutePosition, AbsolutePosition + v6.AbsoluteSize) then
					v22 = true

					break
				end
			end
		end

		if v22 then
			return
		end

		EmptyMenuStack()
	end)
	p1.WidgetConstructor("MenuBar", {
		hasState = false,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(p12) --[[ Generate | Line: 105 | Upvalues: p1 (copy), p2 (copy) ]]
			local MenuBar = Instance.new("Frame")

			MenuBar.Name = "MenuBar"
			MenuBar.Size = UDim2.fromScale(1, 0)
			MenuBar.AutomaticSize = Enum.AutomaticSize.Y
			MenuBar.BackgroundColor3 = p1._config.MenubarBgColor
			MenuBar.BackgroundTransparency = p1._config.MenubarBgTransparency
			MenuBar.BorderSizePixel = 0
			MenuBar.ZIndex = p12.ZIndex
			MenuBar.LayoutOrder = p12.ZIndex
			MenuBar.ClipsDescendants = true
			p2.UIPadding(MenuBar, Vector2.new(p1._config.ItemSpacing.X, 2))
			p2.UIListLayout(MenuBar, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center

			return MenuBar
		end,
		Update = function(p12) --[[ Update | Line: 123 | Upvalues: p1 (copy) ]]
			local parentWidget = p12.parentWidget

			if parentWidget.type == "Window" then
				local v1 = parentWidget.Instance and parentWidget.Instance:FindFirstChild("WindowButton")

				if not v1 then
					return
				end

				p12.Instance.Parent = v1

				local v2 = #p1._postCycleCallbacks + 1
				local v3 = p1._cycleTick + 1

				p1._postCycleCallbacks[v2] = function() --[[ Line: 134 | Upvalues: p1 (ref), v3 (copy), parentWidget (copy), v2 (copy) ]]
					if p1._cycleTick ~= v3 then
						return
					end

					p1._widgets.Window.Update(parentWidget)
					p1._postCycleCallbacks[v2] = nil
				end
			elseif parentWidget.type ~= "Root" then
				error("The MenuBar was not created directly under a window or root.")
			end
		end,
		ChildAdded = function(p1) --[[ ChildAdded | Line: 148 ]]
			return p1.Instance
		end,
		Discard = function(p12) --[[ Discard | Line: 151 | Upvalues: p1 (copy) ]]
			p12.Instance:Destroy()
			p1._widgets.Window.Update(p12.parentWidget)
		end
	})
	p1.WidgetConstructor("Menu", {
		hasState = true,
		hasChildren = true,
		Args = {
			Text = 1
		},
		Events = {
			clicked = p2.EVENTS.click(function(p1) --[[ Line: 169 ]]
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 172 ]]
				return p1.Instance
			end),
			opened = {
				Init = function(p1) --[[ Line: 176 ]] end,
				Get = function(p12) --[[ Line: 177 | Upvalues: p1 (copy) ]]
					return p12.lastOpenedTick == p1._cycleTick
				end
			},
			closed = {
				Init = function(p1) --[[ Line: 182 ]] end,
				Get = function(p12) --[[ Line: 183 | Upvalues: p1 (copy) ]]
					return p12.lastClosedTick == p1._cycleTick
				end
			}
		},
		Generate = function(p12) --[[ Generate | Line: 188 | Upvalues: p1 (copy), p2 (copy), t (copy), v1 (ref), v2 (ref), EmptyMenuStack (copy) ]]
			p12.ButtonColors = {
				ButtonTransparency = 1,
				ButtonColor = p1._config.HeaderColor,
				ButtonHoveredColor = p1._config.HeaderHoveredColor,
				ButtonHoveredTransparency = p1._config.HeaderHoveredTransparency,
				ButtonActiveColor = p1._config.HeaderHoveredColor,
				ButtonActiveTransparency = p1._config.HeaderHoveredTransparency
			}

			local v12

			if p12.parentWidget.type == "Menu" then
				local Menu = Instance.new("TextButton")

				Menu.Name = "Menu"
				Menu.BackgroundColor3 = p1._config.HeaderColor
				Menu.BackgroundTransparency = 1
				Menu.BorderSizePixel = 0
				Menu.Size = UDim2.fromScale(1, 0)
				Menu.Text = ""
				Menu.AutomaticSize = Enum.AutomaticSize.Y
				Menu.ZIndex = p12.ZIndex
				Menu.LayoutOrder = p12.ZIndex
				Menu.AutoButtonColor = false

				local v22 = p2.UIPadding(Menu, p1._config.FramePadding)

				v22.PaddingTop = v22.PaddingTop - UDim.new(0, 1)
				p2.UIListLayout(Menu, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center

				local TextLabel = Instance.new("TextLabel")

				TextLabel.Name = "TextLabel"
				TextLabel.AnchorPoint = Vector2.new(0, 0)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.ZIndex = p12.ZIndex + 2
				TextLabel.LayoutOrder = p12.ZIndex + 2
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY
				p2.applyTextStyle(TextLabel)
				TextLabel.Parent = Menu

				local v3 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
				local v4 = v3 - math.round(v3 * 0.2) * 2
				local Icon = Instance.new("ImageLabel")

				Icon.Name = "Icon"
				Icon.Size = UDim2.fromOffset(v4, v4)
				Icon.BackgroundTransparency = 1
				Icon.BorderSizePixel = 0
				Icon.ImageColor3 = p1._config.TextColor
				Icon.ImageTransparency = p1._config.TextTransparency
				Icon.Image = p2.ICONS.RIGHT_POINTING_TRIANGLE
				Icon.ZIndex = p12.ZIndex + 3
				Icon.LayoutOrder = p12.ZIndex + 3
				Icon.Parent = Menu
				v12 = Menu
			else
				local Menu = Instance.new("TextButton")

				Menu.Name = "Menu"
				Menu.Size = UDim2.fromScale(0, 0)
				Menu.AutomaticSize = Enum.AutomaticSize.XY
				Menu.BackgroundColor3 = p1._config.HeaderColor
				Menu.BackgroundTransparency = 1
				Menu.BorderSizePixel = 0
				Menu.Text = ""
				Menu.LayoutOrder = p12.ZIndex
				Menu.ZIndex = p12.ZIndex
				Menu.AutoButtonColor = false
				Menu.ClipsDescendants = true
				p2.applyTextStyle(Menu)
				p2.UIPadding(Menu, Vector2.new(p1._config.ItemSpacing.X, p1._config.FramePadding.Y))
				v12 = Menu
			end

			p2.applyInteractionHighlights(v12, v12, p12.ButtonColors)
			v12.MouseButton1Click:Connect(function() --[[ Line: 269 | Upvalues: t (ref), p12 (copy), v1 (ref), v2 (ref) ]]
				local v12 = if #t <= 1 then not p12.state.isOpened.value else true

				p12.state.isOpened:set(v12)
				v1 = v12
				v2 = if v12 then p12 or nil else nil

				if not (#t <= 1) then
					return
				end

				if v12 then
					table.insert(t, p12)

					return
				end

				table.remove(t)
			end)
			v12.MouseEnter:Connect(function() --[[ Line: 284 | Upvalues: v1 (ref), v2 (ref), p12 (copy), t (ref), EmptyMenuStack (ref) ]]
				if not v1 or (not v2 or v2 == p12) then
					return
				end

				EmptyMenuStack((table.find(t, p12.parentWidget)))
				p12.state.isOpened:set(true)
				v2 = p12
				v1 = true
				table.insert(t, p12)
			end)

			local ChildContainer = Instance.new("ScrollingFrame")

			ChildContainer.Name = "ChildContainer"
			ChildContainer.BackgroundColor3 = p1._config.WindowBgColor
			ChildContainer.BackgroundTransparency = p1._config.WindowBgTransparency
			ChildContainer.BorderSizePixel = 0
			ChildContainer.Size = UDim2.fromOffset(0, 0)
			ChildContainer.AutomaticSize = Enum.AutomaticSize.XY
			ChildContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			ChildContainer.ScrollBarImageTransparency = p1._config.ScrollbarGrabTransparency
			ChildContainer.ScrollBarImageColor3 = p1._config.ScrollbarGrabColor
			ChildContainer.ScrollBarThickness = p1._config.ScrollbarSize
			ChildContainer.CanvasSize = UDim2.fromScale(0, 0)
			ChildContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			ChildContainer.ZIndex = p12.ZIndex + 6
			ChildContainer.LayoutOrder = p12.ZIndex + 6
			ChildContainer.ClipsDescendants = true
			p2.UIListLayout(ChildContainer, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top
			ChildContainer.Parent = p1._rootInstance and p1._rootInstance:FindFirstChild("PopupScreenGui")
			p12.ChildContainer = ChildContainer
			p2.UIStroke(ChildContainer, p1._config.WindowBorderSize, p1._config.BorderColor, p1._config.BorderTransparency)
			p2.UIPadding(ChildContainer, Vector2.new(2, p1._config.WindowPadding.Y - p1._config.ItemSpacing.Y))

			return v12
		end,
		Update = function(p1) --[[ Update | Line: 343 ]]
			local v1 = p1.Instance;

			(if p1.parentWidget.type == "Menu" then v1.TextLabel else v1).Text = p1.arguments.Text or "Menu"
		end,
		ChildAdded = function(p1, p2) --[[ ChildAdded | Line: 353 | Upvalues: UpdateChildContainerTransform (copy) ]]
			UpdateChildContainerTransform(p1)

			return p1.ChildContainer
		end,
		ChildDiscarded = function(p1, p2) --[[ ChildDiscarded | Line: 357 | Upvalues: UpdateChildContainerTransform (copy) ]]
			UpdateChildContainerTransform(p1)
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 360 | Upvalues: p1 (copy) ]]
			if p12.state.isOpened ~= nil then
				return
			end

			p12.state.isOpened = p1._widgetState(p12, "isOpened", false)
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 365 | Upvalues: p1 (copy), UpdateChildContainerTransform (copy) ]]
			local ChildContainer = p12.ChildContainer

			if p12.state.isOpened.value then
				p12.lastOpenedTick = p1._cycleTick + 1
				p12.ButtonColors.ButtonTransparency = p1._config.HeaderTransparency
				ChildContainer.Visible = true
				UpdateChildContainerTransform(p12)
			else
				p12.lastClosedTick = p1._cycleTick + 1
				p12.ButtonColors.ButtonTransparency = 1
				ChildContainer.Visible = false
			end
		end,
		Discard = function(p1) --[[ Discard | Line: 380 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
	p1.WidgetConstructor("MenuItem", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1,
			KeyCode = 2,
			ModifierKey = 3
		},
		Events = {
			clicked = p2.EVENTS.click(function(p1) --[[ Line: 398 ]]
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 401 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 405 | Upvalues: p2 (copy), p1 (copy), EmptyMenuStack (copy), v1 (ref), v2 (ref), t (copy) ]]
			local MenuItem = Instance.new("TextButton")

			MenuItem.Name = "MenuItem"
			MenuItem.BackgroundTransparency = 1
			MenuItem.BorderSizePixel = 0
			MenuItem.Size = UDim2.fromScale(1, 0)
			MenuItem.Text = ""
			MenuItem.AutomaticSize = Enum.AutomaticSize.Y
			MenuItem.ZIndex = p12.ZIndex
			MenuItem.LayoutOrder = p12.ZIndex
			MenuItem.AutoButtonColor = false

			local v12 = p2.UIPadding(MenuItem, p1._config.FramePadding)

			v12.PaddingTop = v12.PaddingTop - UDim.new(0, 1)
			p2.UIListLayout(MenuItem, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X))
			p2.applyInteractionHighlights(MenuItem, MenuItem, {
				ButtonTransparency = 1,
				ButtonColor = p1._config.HeaderColor,
				ButtonHoveredColor = p1._config.HeaderHoveredColor,
				ButtonHoveredTransparency = p1._config.HeaderHoveredTransparency,
				ButtonActiveColor = p1._config.HeaderHoveredColor,
				ButtonActiveTransparency = p1._config.HeaderHoveredTransparency
			})
			MenuItem.MouseButton1Click:Connect(function() --[[ Line: 434 | Upvalues: EmptyMenuStack (ref) ]]
				EmptyMenuStack()
			end)
			MenuItem.MouseEnter:Connect(function() --[[ Line: 438 | Upvalues: p12 (copy), v1 (ref), v2 (ref), t (ref), EmptyMenuStack (ref) ]]
				local parentWidget = p12.parentWidget

				if not v1 or (not v2 or v2 == parentWidget) then
					return
				end

				EmptyMenuStack((table.find(t, parentWidget)))
				v2 = parentWidget
				v1 = true
			end)

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			TextLabel.AnchorPoint = Vector2.new(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = p12.ZIndex + 2
			TextLabel.LayoutOrder = p12.ZIndex + 2
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = MenuItem

			local Shortcut = Instance.new("TextLabel")

			Shortcut.Name = "Shortcut"
			Shortcut.AnchorPoint = Vector2.new(0, 0)
			Shortcut.BackgroundTransparency = 1
			Shortcut.BorderSizePixel = 0
			Shortcut.ZIndex = p12.ZIndex + 3
			Shortcut.LayoutOrder = p12.ZIndex + 3
			Shortcut.AutomaticSize = Enum.AutomaticSize.XY
			p2.applyTextStyle(Shortcut)
			Shortcut.Text = ""
			Shortcut.TextColor3 = p1._config.TextDisabledColor
			Shortcut.TextTransparency = p1._config.TextDisabledTransparency
			Shortcut.Parent = MenuItem

			return MenuItem
		end,
		Update = function(p1) --[[ Update | Line: 481 ]]
			local v1 = p1.Instance

			v1.TextLabel.Text = p1.arguments.Text

			if not p1.arguments.KeyCode then
				return
			end

			v1.Shortcut.Text = p1.arguments.ModifierKey.Name .. " + " .. p1.arguments.KeyCode.Name
		end,
		Discard = function(p1) --[[ Discard | Line: 491 ]]
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("MenuToggle", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			KeyCode = 2,
			ModifierKey = 3
		},
		Events = {
			checked = {
				Init = function(p1) --[[ Line: 509 ]] end,
				Get = function(p12) --[[ Line: 510 | Upvalues: p1 (copy) ]]
					return p12.lastCheckedTick == p1._cycleTick
				end
			},
			unchecked = {
				Init = function(p1) --[[ Line: 515 ]] end,
				Get = function(p12) --[[ Line: 516 | Upvalues: p1 (copy) ]]
					return p12.lastUncheckedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 520 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 524 | Upvalues: p2 (copy), p1 (copy), EmptyMenuStack (copy), v1 (ref), v2 (ref), t (copy) ]]
			local MenuItem = Instance.new("TextButton")

			MenuItem.Name = "MenuItem"
			MenuItem.BackgroundTransparency = 1
			MenuItem.BorderSizePixel = 0
			MenuItem.Size = UDim2.fromScale(1, 0)
			MenuItem.Text = ""
			MenuItem.AutomaticSize = Enum.AutomaticSize.Y
			MenuItem.ZIndex = p12.ZIndex
			MenuItem.LayoutOrder = p12.ZIndex
			MenuItem.AutoButtonColor = false

			local v12 = p2.UIPadding(MenuItem, p1._config.FramePadding)

			v12.PaddingTop = v12.PaddingTop - UDim.new(0, 1)
			p2.UIListLayout(MenuItem, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			p2.applyInteractionHighlights(MenuItem, MenuItem, {
				ButtonTransparency = 1,
				ButtonColor = p1._config.HeaderColor,
				ButtonHoveredColor = p1._config.HeaderHoveredColor,
				ButtonHoveredTransparency = p1._config.HeaderHoveredTransparency,
				ButtonActiveColor = p1._config.HeaderHoveredColor,
				ButtonActiveTransparency = p1._config.HeaderHoveredTransparency
			})
			MenuItem.MouseButton1Click:Connect(function() --[[ Line: 554 | Upvalues: p12 (copy), EmptyMenuStack (ref) ]]
				p12.state.isChecked:set(not p12.state.isChecked.value)
				EmptyMenuStack()
			end)
			MenuItem.MouseEnter:Connect(function() --[[ Line: 560 | Upvalues: p12 (copy), v1 (ref), v2 (ref), t (ref), EmptyMenuStack (ref) ]]
				local parentWidget = p12.parentWidget

				if not v1 or (not v2 or v2 == parentWidget) then
					return
				end

				EmptyMenuStack((table.find(t, parentWidget)))
				v2 = parentWidget
				v1 = true
			end)

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			TextLabel.AnchorPoint = Vector2.new(0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = p12.ZIndex + 2
			TextLabel.LayoutOrder = p12.ZIndex + 2
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = MenuItem

			local Shortcut = Instance.new("TextLabel")

			Shortcut.Name = "Shortcut"
			Shortcut.AnchorPoint = Vector2.new(0, 0)
			Shortcut.BackgroundTransparency = 1
			Shortcut.BorderSizePixel = 0
			Shortcut.ZIndex = p12.ZIndex + 3
			Shortcut.LayoutOrder = p12.ZIndex + 3
			Shortcut.AutomaticSize = Enum.AutomaticSize.XY
			p2.applyTextStyle(Shortcut)
			Shortcut.Text = ""
			Shortcut.TextColor3 = p1._config.TextDisabledColor
			Shortcut.TextTransparency = p1._config.TextDisabledTransparency
			Shortcut.Parent = MenuItem

			local v22 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
			local v3 = v22 - math.round(v22 * 0.2) * 2
			local Icon = Instance.new("ImageLabel")

			Icon.Name = "Icon"
			Icon.Size = UDim2.fromOffset(v3, v3)
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.ImageColor3 = p1._config.TextColor
			Icon.ImageTransparency = p1._config.TextTransparency
			Icon.Image = p2.ICONS.CHECK_MARK
			Icon.ZIndex = p12.ZIndex + 4
			Icon.LayoutOrder = p12.ZIndex + 4
			Icon.Parent = MenuItem

			return MenuItem
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 620 | Upvalues: p1 (copy) ]]
			if p12.state.isChecked ~= nil then
				return
			end

			p12.state.isChecked = p1._widgetState(p12, "isChecked", false)
		end,
		Update = function(p1) --[[ Update | Line: 625 ]]
			local v1 = p1.Instance

			v1.TextLabel.Text = p1.arguments.Text

			if not p1.arguments.KeyCode then
				return
			end

			v1.Shortcut.Text = p1.arguments.ModifierKey.Name .. " + " .. p1.arguments.KeyCode.Name
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 635 | Upvalues: p2 (copy), p1 (copy) ]]
			local Icon = p12.Instance.Icon

			if p12.state.isChecked.value then
				Icon.Image = p2.ICONS.CHECK_MARK
				p12.lastCheckedTick = p1._cycleTick + 1
			else
				Icon.Image = ""
				p12.lastUncheckedTick = p1._cycleTick + 1
			end
		end,
		Discard = function(p1) --[[ Discard | Line: 647 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end