-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	local function relocateTooltips() --[[ relocateTooltips | Line: 4 | Upvalues: p1 (copy), p2 (copy) ]]
		if p1._rootInstance == nil then
			return
		end

		local PopupScreenGui = p1._rootInstance:FindFirstChild("PopupScreenGui")

		if PopupScreenGui then
			local TooltipContainer = PopupScreenGui.TooltipContainer
			local v2 = p2.findBestWindowPosForPopup(p2.getMouseLocation(), TooltipContainer.AbsoluteSize, p1._config.DisplaySafeAreaPadding, PopupScreenGui.AbsoluteSize)

			TooltipContainer.Position = UDim2.fromOffset(v2.X, v2.Y)
		end
	end

	p2.UserInputService.InputChanged:Connect(relocateTooltips)
	p1.WidgetConstructor("Tooltip", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {},
		Generate = function(p12) --[[ Generate | Line: 34 | Upvalues: p1 (copy), p2 (copy) ]]
			p12.parentWidget = p1._rootWidget

			local Iris_Tooltip = Instance.new("Frame")

			Iris_Tooltip.Name = "Iris_Tooltip"
			Iris_Tooltip.Size = UDim2.new(p1._config.ContentWidth, UDim.new(0, 0))
			Iris_Tooltip.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Tooltip.BorderSizePixel = 0
			Iris_Tooltip.BackgroundTransparency = 1
			Iris_Tooltip.ZIndex = p12.ZIndex + 1
			Iris_Tooltip.LayoutOrder = p12.ZIndex + 1

			local TooltipText = Instance.new("TextLabel")

			TooltipText.Name = "TooltipText"
			TooltipText.Size = UDim2.fromOffset(0, 0)
			TooltipText.AutomaticSize = Enum.AutomaticSize.XY
			TooltipText.BackgroundColor3 = p1._config.WindowBgColor
			TooltipText.BackgroundTransparency = p1._config.WindowBgTransparency
			TooltipText.BorderSizePixel = p1._config.PopupBorderSize
			TooltipText.TextWrapped = true
			TooltipText.ZIndex = p12.ZIndex + 1
			TooltipText.LayoutOrder = p12.ZIndex + 1
			p2.applyTextStyle(TooltipText)
			p2.UIStroke(TooltipText, p1._config.WindowBorderSize, p1._config.BorderActiveColor, p1._config.BorderActiveTransparency)
			p2.UIPadding(TooltipText, p1._config.WindowPadding)

			if p1._config.PopupRounding > 0 then
				p2.UICorner(TooltipText, p1._config.PopupRounding)
			end

			TooltipText.Parent = Iris_Tooltip

			return Iris_Tooltip
		end,
		Update = function(p1) --[[ Update | Line: 73 | Upvalues: relocateTooltips (copy) ]]
			if p1.arguments.Text == nil then
				error("Iris.Text Text Argument is required", 5)
			end

			p1.Instance.TooltipText.Text = p1.arguments.Text
			relocateTooltips()
		end,
		Discard = function(p1) --[[ Discard | Line: 82 ]]
			p1.Instance:Destroy()
		end
	})

	local v1 = 0
	local v2 = nil
	local v3 = false
	local v4 = nil
	local v5 = nil
	local v6 = false
	local v7 = false
	local v8 = false
	local Top = Enum.TopBottom.Top
	local Left = Enum.LeftRight.Left
	local v9 = nil
	local v10 = nil
	local v11 = false
	local t = {}

	local function quickSwapWindows() --[[ quickSwapWindows | Line: 107 | Upvalues: p1 (copy), t (copy) ]]
		if p1._config.UseScreenGUIs == false then
			return
		end

		local v1 = 65535
		local v2 = nil

		for v3, v4 in t do
			if v4.state.isOpened.value and (not v4.arguments.NoNav and v4.Instance:IsA("ScreenGui")) then
				local DisplayOrder = v4.Instance.DisplayOrder

				if DisplayOrder < v1 then
					v1 = DisplayOrder
					v2 = v4
				end
			end
		end

		if v2.state.isUncollapsed.value == false then
			v2.state.isUncollapsed:set(true)
		end

		p1.SetFocusedWindow(v2)
	end

	local function fitSizeToWindowBounds(p12, p22) --[[ fitSizeToWindowBounds | Line: 134 | Upvalues: p1 (copy), p2 (copy) ]]
		local v1 = Vector2.new(p12.state.position.value.X, p12.state.position.value.Y)
		local v2 = (p1._config.TextSize + p1._config.FramePadding.Y * 2) * 2
		local v3 = p2.getScreenSizeForWindow(p12) - v1 - Vector2.new(p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.X, p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.Y)

		return Vector2.new(math.clamp(p22.X, v2, (math.max(v3.X, v2))), (math.clamp(p22.Y, v2, (math.max(v3.Y, v2)))))
	end

	local function fitPositionToWindowBounds(p12, p22) --[[ fitPositionToWindowBounds | Line: 150 | Upvalues: p2 (copy), p1 (copy) ]]
		local v1 = p12.Instance
		local v2 = p2.getScreenSizeForWindow(p12)
		local v3 = Vector2.new(p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.X, p1._config.WindowBorderSize + p1._config.DisplaySafeAreaPadding.Y)

		return Vector2.new(math.clamp(p22.X, v3.X, (math.max(v3.X, v2.X - v1.WindowButton.AbsoluteSize.X - v3.X))), (math.clamp(p22.Y, v3.Y, (math.max(v3.Y, v2.Y - v1.WindowButton.AbsoluteSize.Y - v3.Y)))))
	end

	function p1.SetFocusedWindow(p12) --[[ Line: 178 | Upvalues: v10 (ref), v11 (ref), t (copy), p1 (copy), v1 (ref), p2 (copy) ]]
		if v10 == p12 then
			return
		end

		if v11 and v10 ~= nil then
			if t[v10.ID] then
				local WindowButton = v10.Instance.WindowButton
				local TitleBar = WindowButton.TitleBar

				if v10.state.isUncollapsed.value then
					TitleBar.BackgroundColor3 = p1._config.TitleBgColor
					TitleBar.BackgroundTransparency = p1._config.TitleBgTransparency
				else
					TitleBar.BackgroundColor3 = p1._config.TitleBgCollapsedColor
					TitleBar.BackgroundTransparency = p1._config.TitleBgCollapsedTransparency
				end

				WindowButton.UIStroke.Color = p1._config.BorderColor
			end

			v11 = false
			v10 = nil
		end

		if p12 == nil then
			return
		end

		v11 = true
		v10 = p12

		local v12 = p12.Instance
		local WindowButton = v12.WindowButton
		local TitleBar = WindowButton.TitleBar

		TitleBar.BackgroundColor3 = p1._config.TitleBgActiveColor
		TitleBar.BackgroundTransparency = p1._config.TitleBgActiveTransparency
		WindowButton.UIStroke.Color = p1._config.BorderActiveColor
		v1 = v1 + 1

		if p12.usesScreenGUI then
			v12.DisplayOrder = v1 + p1._config.DisplayOrderOffset
		end

		if p12.state.isUncollapsed.value == false then
			p12.state.isUncollapsed:set(true)
		end

		if not p2.GuiService.SelectedObject then
			return
		end

		if TitleBar.Visible then
			p2.GuiService:Select(TitleBar)

			return
		end

		p2.GuiService:Select(v12.ChildContainer)
	end
	p2.UserInputService.InputBegan:Connect(function(p12, p22) --[[ Line: 235 | Upvalues: p1 (copy), p2 (copy), quickSwapWindows (copy), v7 (ref), v8 (ref), v11 (ref), v10 (ref), Top (ref), Left (ref), v6 (ref), v5 (ref) ]]
		if not p22 and p12.UserInputType == Enum.UserInputType.MouseButton1 then
			p1.SetFocusedWindow(nil)
		end

		if p12.KeyCode == Enum.KeyCode.Tab and (p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
			quickSwapWindows()
		end

		if p12.UserInputType ~= Enum.UserInputType.MouseButton1 or (not v7 or (v8 or not (v11 and v10))) then
			return
		end

		local v2 = p2.getMouseLocation() - (v10.state.position.value + v10.state.size.value * 0.5)
		local v3 = math.abs(v2.X) * v10.state.size.value.Y

		if math.abs(v2.Y) * v10.state.size.value.X <= v3 then
			Top = Enum.TopBottom.Center
			Left = if math.sign(v2.X) == -1 then Enum.LeftRight.Left else Enum.LeftRight.Right
		else
			Left = Enum.LeftRight.Center
			Top = if math.sign(v2.Y) == -1 then Enum.TopBottom.Top else Enum.TopBottom.Bottom
		end

		v6 = true
		v5 = v10
	end)
	p2.UserInputService.TouchTapInWorld:Connect(function(p12, p2) --[[ Line: 276 | Upvalues: p1 (copy) ]]
		if p2 then
			return
		end

		p1.SetFocusedWindow(nil)
	end)
	p2.UserInputService.InputChanged:Connect(function(p1) --[[ Line: 282 | Upvalues: v3 (ref), v2 (ref), p2 (copy), v4 (ref), fitPositionToWindowBounds (copy), v6 (ref), v5 (ref), v9 (ref), Left (ref), Top (ref), fitSizeToWindowBounds (copy) ]]
		if v3 and v2 then
			local v1

			if p1.UserInputType == Enum.UserInputType.Touch then
				local Position = p1.Position

				v1 = Vector2.new(Position.X, Position.Y)
			else
				v1 = p2.getMouseLocation()
			end

			local v42 = fitPositionToWindowBounds(v2, v1 - v4)

			v2.Instance.WindowButton.Position = UDim2.fromOffset(v42.X, v42.Y)
			v2.state.position.value = v42
		end

		if v6 and (v5 and v5.arguments.NoResize ~= true) then
			local WindowButton = v5.Instance.WindowButton
			local v52 = Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset)
			local v62 = Vector2.new(WindowButton.Size.X.Offset, WindowButton.Size.Y.Offset)
			local v7 = if p1.UserInputType == Enum.UserInputType.Touch then p1.Delta else p2.getMouseLocation() - v9
			local v11 = v52 + Vector2.new(if Left == Enum.LeftRight.Left then v7.X else 0, if Top == Enum.TopBottom.Top then v7.Y else 0)
			local v15 = fitSizeToWindowBounds(v5, v62 + Vector2.new(if Left == Enum.LeftRight.Left then -v7.X elseif Left == Enum.LeftRight.Right then v7.X else 0, if Top == Enum.TopBottom.Top then -v7.Y elseif Top == Enum.TopBottom.Bottom then v7.Y else 0))
			local v16 = fitPositionToWindowBounds(v5, v11)

			WindowButton.Size = UDim2.fromOffset(v15.X, v15.Y)
			v5.state.size.value = v15
			WindowButton.Position = UDim2.fromOffset(v16.X, v16.Y)
			v5.state.position.value = v16
		end

		v9 = p2.getMouseLocation()
	end)
	p2.UserInputService.InputEnded:Connect(function(p1, p2) --[[ Line: 344 | Upvalues: v3 (ref), v2 (ref), v6 (ref), v5 (ref), quickSwapWindows (copy) ]]
		if (p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch) and (v3 and v2) then
			local WindowButton = v2.Instance.WindowButton

			v3 = false
			v2.state.position:set(Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset))
		end

		if (p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch) and (v6 and v5) then
			v6 = false
			v5.state.size:set(v5.Instance.WindowButton.AbsoluteSize)
		end

		if p1.KeyCode ~= Enum.KeyCode.ButtonX then
			return
		end

		quickSwapWindows()
	end)
	p1.WidgetConstructor("Window", {
		hasState = true,
		hasChildren = true,
		Args = {
			Title = 1,
			NoTitleBar = 2,
			NoBackground = 3,
			NoCollapse = 4,
			NoClose = 5,
			NoMove = 6,
			NoScrollbar = 7,
			NoResize = 8,
			NoNav = 9,
			NoMenu = 10
		},
		Events = {
			closed = {
				Init = function(p1) --[[ Line: 389 ]] end,
				Get = function(p12) --[[ Line: 390 | Upvalues: p1 (copy) ]]
					return p12.lastClosedTick == p1._cycleTick
				end
			},
			opened = {
				Init = function(p1) --[[ Line: 395 ]] end,
				Get = function(p12) --[[ Line: 396 | Upvalues: p1 (copy) ]]
					return p12.lastOpenedTick == p1._cycleTick
				end
			},
			collapsed = {
				Init = function(p1) --[[ Line: 401 ]] end,
				Get = function(p12) --[[ Line: 402 | Upvalues: p1 (copy) ]]
					return p12.lastCollapsedTick == p1._cycleTick
				end
			},
			uncollapsed = {
				Init = function(p1) --[[ Line: 407 ]] end,
				Get = function(p12) --[[ Line: 408 | Upvalues: p1 (copy) ]]
					return p12.lastUncollapsedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 412 ]]
				return p1.Instance.WindowButton
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 417 | Upvalues: p1 (copy), t (copy), p2 (copy), v2 (ref), v3 (ref), v4 (ref), v11 (ref), v10 (ref), v6 (ref), Top (ref), Left (ref), v5 (ref), v7 (ref), v8 (ref) ]]
			p12.parentWidget = p1._rootWidget
			p12.usesScreenGUI = p1._config.UseScreenGUIs
			t[p12.ID] = p12

			local Iris_Window

			if p12.usesScreenGUI then
				local ScreenGui = Instance.new("ScreenGui")

				ScreenGui.ResetOnSpawn = false
				ScreenGui.DisplayOrder = p1._config.DisplayOrderOffset
				ScreenGui.IgnoreGuiInset = p1._config.IgnoreGuiInset
				Iris_Window = ScreenGui
			else
				Iris_Window = Instance.new("Folder")
			end

			Iris_Window.Name = "Iris_Window"

			local WindowButton = Instance.new("TextButton")

			WindowButton.Name = "WindowButton"
			WindowButton.Size = UDim2.fromOffset(0, 0)
			WindowButton.BackgroundTransparency = 1
			WindowButton.BorderSizePixel = 0
			WindowButton.Text = ""
			WindowButton.ClipsDescendants = false
			WindowButton.AutoButtonColor = false
			WindowButton.Selectable = false
			WindowButton.SelectionImageObject = p1.SelectionImageObject
			WindowButton.ZIndex = p12.ZIndex + 1
			WindowButton.LayoutOrder = p12.ZIndex + 1
			WindowButton.SelectionGroup = true
			WindowButton.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
			WindowButton.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
			p2.UIStroke(WindowButton, p1._config.WindowBorderSize, p1._config.BorderColor, p1._config.BorderTransparency)
			WindowButton.Parent = Iris_Window
			WindowButton.InputBegan:Connect(function(p13) --[[ Line: 462 | Upvalues: p12 (copy), p1 (ref), v2 (ref), v3 (ref), v4 (ref), p2 (ref) ]]
				if p13.UserInputType == Enum.UserInputType.MouseMovement or p13.UserInputType == Enum.UserInputType.Keyboard then
					return
				end

				if p12.state.isUncollapsed.value then
					p1.SetFocusedWindow(p12)
				end

				if p12.arguments.NoMove or p13.UserInputType ~= Enum.UserInputType.MouseButton1 then
					return
				end

				v2 = p12
				v3 = true
				v4 = p2.getMouseLocation() - p12.state.position.value
			end)

			local ChildContainer = Instance.new("ScrollingFrame")

			ChildContainer.Name = "ChildContainer"
			ChildContainer.Size = UDim2.fromScale(1, 1)
			ChildContainer.Position = UDim2.fromOffset(0, 0)
			ChildContainer.BackgroundColor3 = p1._config.WindowBgColor
			ChildContainer.BackgroundTransparency = p1._config.WindowBgTransparency
			ChildContainer.BorderSizePixel = 0
			ChildContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			ChildContainer.ScrollBarImageTransparency = p1._config.ScrollbarGrabTransparency
			ChildContainer.ScrollBarImageColor3 = p1._config.ScrollbarGrabColor
			ChildContainer.CanvasSize = UDim2.fromScale(0, 1)
			ChildContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			ChildContainer.ZIndex = p12.ZIndex + 3
			ChildContainer.LayoutOrder = p12.ZIndex + 3
			ChildContainer.ClipsDescendants = true
			p2.UIPadding(ChildContainer, p1._config.WindowPadding)
			ChildContainer.Parent = WindowButton
			ChildContainer:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 501 | Upvalues: p12 (copy), ChildContainer (copy) ]]
				p12.state.scrollDistance.value = ChildContainer.CanvasPosition.Y
			end)
			ChildContainer.InputBegan:Connect(function(p13) --[[ Line: 506 | Upvalues: p12 (copy), p1 (ref) ]]
				if p13.UserInputType == Enum.UserInputType.MouseMovement or p13.UserInputType == Enum.UserInputType.Keyboard then
					return
				end

				if not p12.state.isUncollapsed.value then
					return
				end

				p1.SetFocusedWindow(p12)
			end)

			local TerminatingFrame = Instance.new("Frame")

			TerminatingFrame.Name = "TerminatingFrame"
			TerminatingFrame.Size = UDim2.fromOffset(0, p1._config.WindowPadding.Y + p1._config.FramePadding.Y)
			TerminatingFrame.BackgroundTransparency = 1
			TerminatingFrame.BorderSizePixel = 0
			TerminatingFrame.LayoutOrder = 2147483632
			p2.UIListLayout(ChildContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
			TerminatingFrame.Parent = ChildContainer

			local TitleBar = Instance.new("Frame")

			TitleBar.Name = "TitleBar"
			TitleBar.Size = UDim2.fromScale(1, 0)
			TitleBar.AutomaticSize = Enum.AutomaticSize.Y
			TitleBar.BorderSizePixel = 0
			TitleBar.ZIndex = p12.ZIndex + 1
			TitleBar.LayoutOrder = p12.ZIndex + 1
			TitleBar.ClipsDescendants = true
			TitleBar.Parent = WindowButton
			TitleBar.InputBegan:Connect(function(p1) --[[ Line: 545 | Upvalues: p12 (copy), v2 (ref), v3 (ref), v4 (ref) ]]
				if p1.UserInputType ~= Enum.UserInputType.Touch or p12.arguments.NoMove then
					return
				end

				v2 = p12
				v3 = true

				local Position = p1.Position

				v4 = Vector2.new(Position.X, Position.Y) - p12.state.position.value
			end)

			local v22 = p1._config.TextSize + (p1._config.FramePadding.Y - 1) * 2
			local CollapseButton = Instance.new("TextButton")

			CollapseButton.Name = "CollapseButton"
			CollapseButton.AnchorPoint = Vector2.new(0, 0.5)
			CollapseButton.Size = UDim2.fromOffset(v22, v22)
			CollapseButton.Position = UDim2.new(0, p1._config.FramePadding.X + 1, 0.5, 0)
			CollapseButton.AutomaticSize = Enum.AutomaticSize.None
			CollapseButton.BackgroundTransparency = 1
			CollapseButton.BorderSizePixel = 0
			CollapseButton.AutoButtonColor = false
			CollapseButton.Text = ""
			CollapseButton.ZIndex = p12.ZIndex + 4
			p2.UICorner(CollapseButton)
			CollapseButton.Parent = TitleBar
			CollapseButton.MouseButton1Click:Connect(function() --[[ Line: 575 | Upvalues: p12 (copy) ]]
				p12.state.isUncollapsed:set(not p12.state.isUncollapsed.value)
			end)
			p2.applyInteractionHighlights(CollapseButton, CollapseButton, {
				ButtonTransparency = 1,
				ButtonColor = p1._config.ButtonColor,
				ButtonHoveredColor = p1._config.ButtonHoveredColor,
				ButtonHoveredTransparency = p1._config.ButtonHoveredTransparency,
				ButtonActiveColor = p1._config.ButtonActiveColor,
				ButtonActiveTransparency = p1._config.ButtonActiveTransparency
			})

			local Arrow = Instance.new("ImageLabel")

			Arrow.Name = "Arrow"
			Arrow.AnchorPoint = Vector2.new(0.5, 0.5)
			Arrow.Size = UDim2.fromOffset(math.floor(v22 * 0.7), (math.floor(v22 * 0.7)))
			Arrow.Position = UDim2.fromScale(0.5, 0.5)
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.Image = p2.ICONS.MULTIPLICATION_SIGN
			Arrow.ImageColor3 = p1._config.TextColor
			Arrow.ImageTransparency = p1._config.TextTransparency
			Arrow.ZIndex = p12.ZIndex + 5
			Arrow.Parent = CollapseButton

			local CloseButton = Instance.new("TextButton")

			CloseButton.Name = "CloseButton"
			CloseButton.AnchorPoint = Vector2.new(1, 0.5)
			CloseButton.Size = UDim2.fromOffset(v22, v22)
			CloseButton.Position = UDim2.new(1, -(p1._config.FramePadding.X + 1), 0.5, 0)
			CloseButton.AutomaticSize = Enum.AutomaticSize.None
			CloseButton.BackgroundTransparency = 1
			CloseButton.BorderSizePixel = 0
			CloseButton.Text = ""
			CloseButton.ZIndex = p12.ZIndex + 4
			CloseButton.AutoButtonColor = false
			p2.UICorner(CloseButton)
			CloseButton.MouseButton1Click:Connect(function() --[[ Line: 617 | Upvalues: p12 (copy) ]]
				p12.state.isOpened:set(false)
			end)
			p2.applyInteractionHighlights(CloseButton, CloseButton, {
				ButtonTransparency = 1,
				ButtonColor = p1._config.ButtonColor,
				ButtonHoveredColor = p1._config.ButtonHoveredColor,
				ButtonHoveredTransparency = p1._config.ButtonHoveredTransparency,
				ButtonActiveColor = p1._config.ButtonActiveColor,
				ButtonActiveTransparency = p1._config.ButtonActiveTransparency
			})
			CloseButton.Parent = TitleBar

			local Icon = Instance.new("ImageLabel")

			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0.5, 0.5)
			Icon.Size = UDim2.fromOffset(math.floor(v22 * 0.7), (math.floor(v22 * 0.7)))
			Icon.Position = UDim2.fromScale(0.5, 0.5)
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.Image = p2.ICONS.MULTIPLICATION_SIGN
			Icon.ImageColor3 = p1._config.TextColor
			Icon.ImageTransparency = p1._config.TextTransparency
			Icon.ZIndex = p12.ZIndex + 5
			Icon.Parent = CloseButton

			local v32 = if p1._config.WindowTitleAlign == Enum.LeftRight.Left then 0 elseif p1._config.WindowTitleAlign == Enum.LeftRight.Center then 0.5 else 1
			local Title = Instance.new("TextLabel")

			Title.Name = "Title"
			Title.AnchorPoint = Vector2.new(v32, 0)
			Title.Position = UDim2.fromScale(v32, 0)
			Title.AutomaticSize = Enum.AutomaticSize.XY
			Title.BorderSizePixel = 0
			Title.BackgroundTransparency = 1
			Title.ZIndex = p12.ZIndex + 3
			p2.applyTextStyle(Title)
			p2.UIPadding(Title, p1._config.FramePadding)
			Title.Parent = TitleBar

			local v42 = p1._config.TextSize + p1._config.FramePadding.X
			local ResizeGrip = Instance.new("TextButton")

			ResizeGrip.Name = "ResizeGrip"
			ResizeGrip.AnchorPoint = Vector2.new(1, 1)
			ResizeGrip.Size = UDim2.fromOffset(v42, v42)
			ResizeGrip.Position = UDim2.fromScale(1, 1)
			ResizeGrip.AutoButtonColor = false
			ResizeGrip.BorderSizePixel = 0
			ResizeGrip.BackgroundTransparency = 1
			ResizeGrip.Text = p2.ICONS.BOTTOM_RIGHT_CORNER
			ResizeGrip.TextSize = v42
			ResizeGrip.TextColor3 = p1._config.ButtonColor
			ResizeGrip.TextTransparency = p1._config.ButtonTransparency
			ResizeGrip.LineHeight = 1.1
			ResizeGrip.Selectable = false
			ResizeGrip.ZIndex = p12.ZIndex + 3
			ResizeGrip.Parent = WindowButton
			p2.applyTextInteractionHighlights(ResizeGrip, ResizeGrip, {
				ButtonColor = p1._config.ButtonColor,
				ButtonTransparency = p1._config.ButtonTransparency,
				ButtonHoveredColor = p1._config.ButtonHoveredColor,
				ButtonHoveredTransparency = p1._config.ButtonHoveredTransparency,
				ButtonActiveColor = p1._config.ButtonActiveColor,
				ButtonActiveTransparency = p1._config.ButtonActiveTransparency
			})
			ResizeGrip.MouseButton1Down:Connect(function() --[[ Line: 698 | Upvalues: v11 (ref), v10 (ref), p12 (copy), p1 (ref), v6 (ref), Top (ref), Left (ref), v5 (ref) ]]
				if v11 and v10 == p12 then
					v6 = true
					Top = Enum.TopBottom.Bottom
					Left = Enum.LeftRight.Right
					v5 = p12

					return
				end

				p1.SetFocusedWindow(p12)
				v6 = true
				Top = Enum.TopBottom.Bottom
				Left = Enum.LeftRight.Right
				v5 = p12
			end)

			local ResizeBorder = Instance.new("TextButton")

			ResizeBorder.Name = "ResizeBorder"
			ResizeBorder.Size = UDim2.new(1, p1._config.WindowResizePadding.X * 2, 1, p1._config.WindowResizePadding.Y * 2)
			ResizeBorder.Position = UDim2.fromOffset(-p1._config.WindowResizePadding.X, -p1._config.WindowResizePadding.Y)
			ResizeBorder.BackgroundTransparency = 1
			ResizeBorder.BorderSizePixel = 0
			ResizeBorder.Text = ""
			ResizeBorder.AutoButtonColor = false
			ResizeBorder.Active = true
			ResizeBorder.Selectable = false
			ResizeBorder.ZIndex = p12.ZIndex
			ResizeBorder.LayoutOrder = p12.ZIndex
			ResizeBorder.ClipsDescendants = false
			ResizeBorder.Parent = WindowButton
			ResizeBorder.MouseEnter:Connect(function() --[[ Line: 726 | Upvalues: v10 (ref), p12 (copy), v7 (ref) ]]
				if v10 ~= p12 then
					return
				end

				v7 = true
			end)
			ResizeBorder.MouseLeave:Connect(function() --[[ Line: 731 | Upvalues: v10 (ref), p12 (copy), v7 (ref) ]]
				if v10 ~= p12 then
					return
				end

				v7 = false
			end)
			WindowButton.MouseEnter:Connect(function() --[[ Line: 737 | Upvalues: v10 (ref), p12 (copy), v8 (ref) ]]
				if v10 ~= p12 then
					return
				end

				v8 = true
			end)
			WindowButton.MouseLeave:Connect(function() --[[ Line: 742 | Upvalues: v10 (ref), p12 (copy), v8 (ref) ]]
				if v10 ~= p12 then
					return
				end

				v8 = false
			end)

			return Iris_Window
		end,
		Update = function(p12) --[[ Update | Line: 750 | Upvalues: p1 (copy) ]]
			local WindowButton = p12.Instance.WindowButton
			local TitleBar = WindowButton.TitleBar
			local Title = TitleBar.Title
			local MenuBar = WindowButton:FindFirstChild("MenuBar")
			local ChildContainer = WindowButton.ChildContainer
			local ResizeGrip = WindowButton.ResizeGrip
			local sum = 0
			local sum2 = 0

			if p12.arguments.NoResize == true then
				ResizeGrip.Visible = false
			else
				ResizeGrip.Visible = true
			end

			if p12.arguments.NoScrollbar then
				ChildContainer.ScrollBarThickness = 0
			else
				ChildContainer.ScrollBarThickness = p1._config.ScrollbarSize
			end

			if p12.arguments.NoTitleBar then
				TitleBar.Visible = false
			else
				TitleBar.Visible = true

				local Y = TitleBar.AbsoluteSize.Y

				sum = sum + Y
				sum2 = sum2 + Y
			end

			if MenuBar then
				if p12.arguments.NoMenu then
					MenuBar.Visible = false
				else
					MenuBar.Visible = true
					sum = sum + MenuBar.AbsoluteSize.Y
				end

				MenuBar.Position = UDim2.fromOffset(0, sum2)
			end

			if p12.arguments.NoBackground then
				ChildContainer.BackgroundTransparency = 1
			else
				ChildContainer.BackgroundTransparency = p1._config.WindowBgTransparency
			end

			local v1 = p1._config.FramePadding.X + p1._config.TextSize + p1._config.FramePadding.X * 2

			if p12.arguments.NoCollapse then
				TitleBar.CollapseButton.Visible = false
				TitleBar.Title.UIPadding.PaddingLeft = UDim.new(0, p1._config.FramePadding.X)
			else
				TitleBar.CollapseButton.Visible = true
				TitleBar.Title.UIPadding.PaddingLeft = UDim.new(0, v1)
			end

			if p12.arguments.NoClose then
				TitleBar.CloseButton.Visible = false
				TitleBar.Title.UIPadding.PaddingRight = UDim.new(0, p1._config.FramePadding.X)
			else
				TitleBar.CloseButton.Visible = true
				TitleBar.Title.UIPadding.PaddingRight = UDim.new(0, v1)
			end

			ChildContainer.Size = UDim2.new(1, 0, 1, -sum)
			ChildContainer.CanvasSize = UDim2.new(0, 0, 1, -sum)
			ChildContainer.Position = UDim2.fromOffset(0, sum)
			Title.Text = p12.arguments.Title or ""
		end,
		Discard = function(p1) --[[ Discard | Line: 822 | Upvalues: v10 (ref), v11 (ref), v2 (ref), v3 (ref), v5 (ref), v6 (ref), t (copy), p2 (copy) ]]
			if v10 == p1 then
				v10 = nil
				v11 = false
			end

			if v2 == p1 then
				v2 = nil
				v3 = false
			end

			if v5 == p1 then
				v5 = nil
				v6 = false
			end

			t[p1.ID] = nil
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		ChildAdded = function(p1) --[[ ChildAdded | Line: 839 ]]
			return p1.Instance.WindowButton.ChildContainer
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 844 | Upvalues: p1 (copy), p2 (copy) ]]
			local value = p12.state.size.value
			local value2 = p12.state.position.value
			local value3 = p12.state.isUncollapsed.value
			local value4 = p12.state.isOpened.value
			local value5 = p12.state.scrollDistance.value
			local v1 = p12.Instance
			local WindowButton = v1.WindowButton
			local TitleBar = WindowButton.TitleBar
			local ChildContainer = WindowButton.ChildContainer
			local ResizeGrip = WindowButton.ResizeGrip

			WindowButton.Size = UDim2.fromOffset(value.X, value.Y)
			WindowButton.Position = UDim2.fromOffset(value2.X, value2.Y)

			if value4 then
				if p12.usesScreenGUI then
					v1.Enabled = true
				end

				WindowButton.Visible = true
				p12.lastOpenedTick = p1._cycleTick + 1
			else
				if p12.usesScreenGUI then
					v1.Enabled = false
				end

				WindowButton.Visible = false
				p12.lastClosedTick = p1._cycleTick + 1
			end

			if value3 then
				TitleBar.CollapseButton.Arrow.Image = p2.ICONS.DOWN_POINTING_TRIANGLE
				ChildContainer.Visible = true

				if p12.arguments.NoResize ~= true then
					ResizeGrip.Visible = true
				end

				WindowButton.AutomaticSize = Enum.AutomaticSize.None
				p12.lastUncollapsedTick = p1._cycleTick + 1
			else
				TitleBar.CollapseButton.Arrow.Image = p2.ICONS.RIGHT_POINTING_TRIANGLE
				ChildContainer.Visible = false
				ResizeGrip.Visible = false
				WindowButton.Size = UDim2.fromOffset(value.X, TitleBar.AbsoluteSize.Y)
				p12.lastCollapsedTick = p1._cycleTick + 1
			end

			if value4 and value3 then
				p1.SetFocusedWindow(p12)
			else
				TitleBar.BackgroundColor3 = p1._config.TitleBgCollapsedColor
				TitleBar.BackgroundTransparency = p1._config.TitleBgCollapsedTransparency
				WindowButton.UIStroke.Color = p1._config.BorderColor
				p1.SetFocusedWindow(nil)
			end

			if not value5 or value5 == 0 then
				return
			end

			local v2 = #p1._postCycleCallbacks + 1
			local v3 = p1._cycleTick + 1

			p1._postCycleCallbacks[v2] = function() --[[ Line: 910 | Upvalues: p1 (ref), v3 (copy), ChildContainer (copy), value5 (copy), v2 (copy) ]]
				if p1._cycleTick ~= v3 then
					return
				end

				ChildContainer.CanvasPosition = Vector2.new(0, value5)
				p1._postCycleCallbacks[v2] = nil
			end
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 918 | Upvalues: p1 (copy), v11 (ref), v10 (ref), fitPositionToWindowBounds (copy), fitSizeToWindowBounds (copy) ]]
			if p12.state.size == nil then
				p12.state.size = p1._widgetState(p12, "size", Vector2.new(400, 300))
			end

			if p12.state.position == nil then
				p12.state.position = p1._widgetState(p12, "position", if v11 and v10 then v10.state.position.value + Vector2.new(15, 45) else Vector2.new(150, 250))
			end

			p12.state.position.value = fitPositionToWindowBounds(p12, p12.state.position.value)
			p12.state.size.value = fitSizeToWindowBounds(p12, p12.state.size.value)

			if p12.state.isUncollapsed == nil then
				p12.state.isUncollapsed = p1._widgetState(p12, "isUncollapsed", true)
			end

			if p12.state.isOpened == nil then
				p12.state.isOpened = p1._widgetState(p12, "isOpened", true)
			end

			if p12.state.scrollDistance ~= nil then
				return
			end

			p12.state.scrollDistance = p1._widgetState(p12, "scrollDistance", 0)
		end
	})
end