-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	local function onSelectionChange(p1) --[[ onSelectionChange | Line: 4 ]]
		if type(p1.state.index.value) == "boolean" then
			p1.state.index:set(not p1.state.index.value)
		else
			p1.state.index:set(p1.arguments.Index)
		end
	end

	p1.WidgetConstructor("Selectable", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Index = 2,
			NoClick = 3
		},
		Events = {
			selected = {
				Init = function(p1) --[[ Line: 24 ]] end,
				Get = function(p12) --[[ Line: 25 | Upvalues: p1 (copy) ]]
					return p12.lastSelectedTick == p1._cycleTick
				end
			},
			unselected = {
				Init = function(p1) --[[ Line: 30 ]] end,
				Get = function(p12) --[[ Line: 31 | Upvalues: p1 (copy) ]]
					return p12.lastUnselectedTick == p1._cycleTick
				end
			},
			active = {
				Init = function(p1) --[[ Line: 36 ]] end,
				Get = function(p1) --[[ Line: 37 ]]
					return p1.state.index.value == p1.arguments.Index
				end
			},
			clicked = p2.EVENTS.click(function(p1) --[[ Line: 41 ]]
				return p1.Instance.SelectableButton
			end),
			rightClicked = p2.EVENTS.rightClick(function(p1) --[[ Line: 45 ]]
				return p1.Instance.SelectableButton
			end),
			doubleClicked = p2.EVENTS.doubleClick(function(p1) --[[ Line: 49 ]]
				return p1.Instance.SelectableButton
			end),
			ctrlClicked = p2.EVENTS.ctrlClick(function(p1) --[[ Line: 53 ]]
				return p1.Instance.SelectableButton
			end),
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 57 ]]
				return p1.Instance.SelectableButton
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 62 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_Selectable = Instance.new("Frame")

			Iris_Selectable.Name = "Iris_Selectable"
			Iris_Selectable.Size = UDim2.new(p1._config.ItemWidth, UDim.new(0, p1._config.TextSize))
			Iris_Selectable.AutomaticSize = Enum.AutomaticSize.None
			Iris_Selectable.BackgroundTransparency = 1
			Iris_Selectable.BorderSizePixel = 0
			Iris_Selectable.ZIndex = p12.ZIndex
			Iris_Selectable.LayoutOrder = p12.ZIndex

			local SelectableButton = Instance.new("TextButton")

			SelectableButton.Name = "SelectableButton"
			SelectableButton.Size = UDim2.new(1, 0, 1, p1._config.ItemSpacing.Y - 1)

			local fromOffset = UDim2.fromOffset

			SelectableButton.Position = fromOffset(0, -bit32.rshift(p1._config.ItemSpacing.Y, 1))
			SelectableButton.BackgroundColor3 = p1._config.HeaderColor
			SelectableButton.ZIndex = p12.ZIndex + 1
			SelectableButton.LayoutOrder = p12.ZIndex + 1
			p2.applyFrameStyle(SelectableButton)
			p2.applyTextStyle(SelectableButton)
			p12.ButtonColors = {
				ButtonTransparency = 1,
				ButtonColor = p1._config.HeaderColor,
				ButtonHoveredColor = p1._config.HeaderHoveredColor,
				ButtonHoveredTransparency = p1._config.HeaderHoveredTransparency,
				ButtonActiveColor = p1._config.HeaderActiveColor,
				ButtonActiveTransparency = p1._config.HeaderActiveTransparency
			}
			p2.applyInteractionHighlights(SelectableButton, SelectableButton, p12.ButtonColors)
			SelectableButton.MouseButton1Click:Connect(function() --[[ Line: 94 | Upvalues: p12 (copy) ]]
				if p12.arguments.NoClick == true then
					return
				end

				local v1 = p12

				if type(v1.state.index.value) == "boolean" then
					v1.state.index:set(not v1.state.index.value)

					return
				end

				v1.state.index:set(v1.arguments.Index)
			end)
			SelectableButton.Parent = Iris_Selectable

			return Iris_Selectable
		end,
		Update = function(p1) --[[ Update | Line: 104 ]]
			p1.Instance.SelectableButton.Text = p1.arguments.Text or "Selectable"
		end,
		Discard = function(p1) --[[ Discard | Line: 109 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 113 | Upvalues: p1 (copy) ]]
			if p12.state.index ~= nil then
				return
			end

			if p12.arguments.Index ~= nil then
				error("a shared state index is required for Selectables with an Index argument", 5)
			end

			p12.state.index = p1._widgetState(p12, "index", false)
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 121 | Upvalues: p1 (copy) ]]
			local SelectableButton = p12.Instance.SelectableButton

			if p12.state.index.value == (p12.arguments.Index or true) then
				p12.ButtonColors.ButtonTransparency = p1._config.HeaderTransparency
				SelectableButton.BackgroundTransparency = p1._config.HeaderTransparency
				p12.lastSelectedTick = p1._cycleTick + 1
			else
				p12.ButtonColors.ButtonTransparency = 1
				SelectableButton.BackgroundTransparency = 1
				p12.lastUnselectedTick = p1._cycleTick + 1
			end
		end
	})

	local v1 = false
	local v2 = -1
	local v3 = nil

	local function UpdateChildContainerTransform(p12) --[[ UpdateChildContainerTransform | Line: 141 | Upvalues: p1 (copy) ]]
		local PreviewContainer = p12.Instance.PreviewContainer
		local PreviewLabel = PreviewContainer.PreviewLabel
		local ChildContainer = p12.ChildContainer
		local v1 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
		local PopupBorderSize = p1._config.PopupBorderSize
		local v2 = v1 * math.min(p12.ComboChildrenHeight, 8) - PopupBorderSize * 2 + 3 * p1._config.FramePadding.Y

		ChildContainer.Size = UDim2.new(UDim.new(0, PreviewContainer.AbsoluteSize.X - PopupBorderSize * 2), UDim.new(0, v2))

		if PreviewLabel.AbsolutePosition.Y + v1 + v2 > ChildContainer.Parent.AbsoluteSize.Y then
			ChildContainer.Position = UDim2.new(0, PreviewLabel.AbsolutePosition.X + PopupBorderSize, 0, PreviewLabel.AbsolutePosition.Y - PopupBorderSize - v2)
		else
			ChildContainer.Position = UDim2.new(0, PreviewLabel.AbsolutePosition.X + PopupBorderSize, 0, PreviewLabel.AbsolutePosition.Y + v1 + PopupBorderSize)
		end
	end

	p2.UserInputService.InputBegan:Connect(function(p12) --[[ Line: 176 | Upvalues: v1 (ref), v2 (ref), p1 (copy), p2 (copy), v3 (ref) ]]
		if p12.UserInputType ~= Enum.UserInputType.MouseButton1 and (p12.UserInputType ~= Enum.UserInputType.MouseButton2 and p12.UserInputType ~= Enum.UserInputType.Touch) then
			return
		end

		if v1 == false then
			return
		end

		if v2 == p1._cycleTick then
			return
		end

		local v12 = p2.getMouseLocation()
		local ChildContainer = v3.ChildContainer
		local v22 = ChildContainer.AbsolutePosition - Vector2.new(0, v3.LabelHeight)

		if p2.isPosInsideRect(v12, v22, ChildContainer.AbsolutePosition + ChildContainer.AbsoluteSize) then
			return
		end

		v3.state.isOpened:set(false)
	end)
	p1.WidgetConstructor("Combo", {
		hasState = true,
		hasChildren = true,
		Args = {
			Text = 1,
			NoButton = 2,
			NoPreview = 3
		},
		Events = {
			opened = {
				Init = function(p1) --[[ Line: 211 ]] end,
				Get = function(p12) --[[ Line: 212 | Upvalues: p1 (copy) ]]
					return p12.lastOpenedTick == p1._cycleTick
				end
			},
			closed = {
				Init = function(p1) --[[ Line: 217 ]] end,
				Get = function(p12) --[[ Line: 218 | Upvalues: p1 (copy) ]]
					return p12.lastClosedTick == p1._cycleTick
				end
			},
			clicked = p2.EVENTS.click(function(p1) --[[ Line: 222 ]]
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 225 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 229 | Upvalues: p1 (copy), p2 (copy), v1 (ref), v3 (ref) ]]
			local v12 = p1._config.TextSize + 2 * p1._config.FramePadding.Y

			p12.ComboChildrenHeight = 0

			local Iris_Combo = Instance.new("Frame")

			Iris_Combo.Name = "Iris_Combo"
			Iris_Combo.Size = UDim2.fromScale(1, 0)
			Iris_Combo.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Combo.BackgroundTransparency = 1
			Iris_Combo.BorderSizePixel = 0
			Iris_Combo.ZIndex = p12.ZIndex
			Iris_Combo.LayoutOrder = p12.ZIndex
			p2.UIListLayout(Iris_Combo, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.Y + 1))

			local PreviewContainer = Instance.new("TextButton")

			PreviewContainer.Name = "PreviewContainer"
			PreviewContainer.Size = UDim2.new(p1._config.ContentWidth, UDim.new(0, 0))
			PreviewContainer.AutomaticSize = Enum.AutomaticSize.Y
			PreviewContainer.BackgroundTransparency = 1
			PreviewContainer.Text = ""
			PreviewContainer.ZIndex = p12.ZIndex + 2
			PreviewContainer.LayoutOrder = p12.ZIndex + 2
			PreviewContainer.AutoButtonColor = false
			p2.applyFrameStyle(PreviewContainer, true, true)
			p2.UIListLayout(PreviewContainer, Enum.FillDirection.Horizontal, UDim.new(0, 0))
			PreviewContainer.Parent = Iris_Combo

			local PreviewLabel = Instance.new("TextLabel")

			PreviewLabel.Name = "PreviewLabel"
			PreviewLabel.Size = UDim2.new(1, 0, 0, 0)
			PreviewLabel.AutomaticSize = Enum.AutomaticSize.Y
			PreviewLabel.BackgroundColor3 = p1._config.FrameBgColor
			PreviewLabel.BackgroundTransparency = p1._config.FrameBgTransparency
			PreviewLabel.BorderSizePixel = 0
			PreviewLabel.ZIndex = p12.ZIndex + 3
			PreviewLabel.LayoutOrder = p12.ZIndex + 3
			p2.applyTextStyle(PreviewLabel)
			p2.UIPadding(PreviewLabel, p1._config.FramePadding)
			PreviewLabel.Parent = PreviewContainer

			local DropdownButton = Instance.new("TextLabel")

			DropdownButton.Name = "DropdownButton"
			DropdownButton.Size = UDim2.new(0, v12, 0, v12)
			DropdownButton.BorderSizePixel = 0
			DropdownButton.BackgroundColor3 = p1._config.ButtonColor
			DropdownButton.BackgroundTransparency = p1._config.ButtonTransparency
			DropdownButton.Text = ""
			DropdownButton.ZIndex = p12.ZIndex + 4
			DropdownButton.LayoutOrder = p12.ZIndex + 4

			local v2 = math.round(v12 * 0.2)
			local v32 = v12 - v2 * 2
			local Dropdown = Instance.new("ImageLabel")

			Dropdown.Name = "Dropdown"
			Dropdown.Size = UDim2.fromOffset(v32, v32)
			Dropdown.Position = UDim2.fromOffset(v2, v2)
			Dropdown.BackgroundTransparency = 1
			Dropdown.BorderSizePixel = 0
			Dropdown.ImageColor3 = p1._config.TextColor
			Dropdown.ImageTransparency = p1._config.TextTransparency
			Dropdown.ZIndex = p12.ZIndex + 5
			Dropdown.LayoutOrder = p12.ZIndex + 5
			Dropdown.Parent = DropdownButton
			DropdownButton.Parent = PreviewContainer
			p2.applyInteractionHighlightsWithMultiHighlightee(PreviewContainer, {
				{
					PreviewLabel,
					{
						ButtonColor = p1._config.FrameBgColor,
						ButtonTransparency = p1._config.FrameBgTransparency,
						ButtonHoveredColor = p1._config.FrameBgHoveredColor,
						ButtonHoveredTransparency = p1._config.FrameBgHoveredTransparency,
						ButtonActiveColor = p1._config.FrameBgActiveColor,
						ButtonActiveTransparency = p1._config.FrameBgActiveTransparency
					}
				},
				{
					DropdownButton,
					{
						ButtonColor = p1._config.ButtonColor,
						ButtonTransparency = p1._config.ButtonTransparency,
						ButtonHoveredColor = p1._config.ButtonHoveredColor,
						ButtonHoveredTransparency = p1._config.ButtonHoveredTransparency,
						ButtonActiveColor = p1._config.ButtonHoveredColor,
						ButtonActiveTransparency = p1._config.ButtonHoveredColor
					}
				}
			})
			PreviewContainer.InputBegan:Connect(function(p1) --[[ Line: 333 | Upvalues: v1 (ref), v3 (ref), p12 (copy) ]]
				if v1 and v3 ~= p12 then
					return
				end

				if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				p12.state.isOpened:set(not p12.state.isOpened.value)
			end)

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			TextLabel.Size = UDim2.fromOffset(0, v12)
			TextLabel.AutomaticSize = Enum.AutomaticSize.X
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = p12.ZIndex + 5
			TextLabel.LayoutOrder = p12.ZIndex + 5
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_Combo

			local ChildContainer = Instance.new("ScrollingFrame")

			ChildContainer.Name = "ChildContainer"
			ChildContainer.BackgroundColor3 = p1._config.WindowBgColor
			ChildContainer.BackgroundTransparency = p1._config.WindowBgTransparency
			ChildContainer.BorderSizePixel = 0
			ChildContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
			ChildContainer.ScrollBarImageTransparency = p1._config.ScrollbarGrabTransparency
			ChildContainer.ScrollBarImageColor3 = p1._config.ScrollbarGrabColor
			ChildContainer.ScrollBarThickness = p1._config.ScrollbarSize
			ChildContainer.CanvasSize = UDim2.fromScale(0, 0)
			ChildContainer.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			ChildContainer.ZIndex = p12.ZIndex + 6
			ChildContainer.LayoutOrder = p12.ZIndex + 6
			ChildContainer.ClipsDescendants = true
			p2.UIStroke(ChildContainer, p1._config.WindowBorderSize, p1._config.BorderColor, p1._config.BorderTransparency)
			p2.UIPadding(ChildContainer, Vector2.new(2, 2 * p1._config.FramePadding.Y))
			p2.UIListLayout(ChildContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
			ChildContainer.Parent = p1._rootInstance and p1._rootInstance:WaitForChild("PopupScreenGui")
			p12.ChildContainer = ChildContainer

			return Iris_Combo
		end,
		Update = function(p12) --[[ Update | Line: 403 | Upvalues: p1 (copy) ]]
			local v1 = p12.Instance
			local PreviewContainer = v1.PreviewContainer
			local PreviewLabel = PreviewContainer.PreviewLabel
			local DropdownButton = PreviewContainer.DropdownButton

			v1.TextLabel.Text = p12.arguments.Text or "Combo"

			if p12.arguments.NoButton then
				DropdownButton.Visible = false
				PreviewLabel.Size = UDim2.new(1, 0, 0, 0)
			else
				DropdownButton.Visible = true
				PreviewLabel.Size = UDim2.new(1, -(p1._config.TextSize + 2 * p1._config.FramePadding.Y), 0, 0)
			end

			if p12.arguments.NoPreview then
				PreviewLabel.Visible = false
				PreviewContainer.Size = UDim2.new(0, 0, 0, 0)
				PreviewContainer.AutomaticSize = Enum.AutomaticSize.X
			else
				PreviewLabel.Visible = true
				PreviewContainer.Size = UDim2.new(p1._config.ContentWidth, UDim.new(0, 0))
				PreviewContainer.AutomaticSize = Enum.AutomaticSize.Y
			end
		end,
		ChildAdded = function(p1, p2) --[[ ChildAdded | Line: 431 | Upvalues: UpdateChildContainerTransform (copy) ]]
			if p2.type == "Selectable" then
				p1.ComboChildrenHeight = p1.ComboChildrenHeight + 1
			else
				p1.ComboChildrenHeight = p1.ComboChildrenHeight + 10
			end

			UpdateChildContainerTransform(p1)

			return p1.ChildContainer
		end,
		ChildDiscarded = function(p1, p2) --[[ ChildDiscarded | Line: 441 ]]
			if p2.type == "Selectable" then
				p1.ComboChildrenHeight = p1.ComboChildrenHeight - 1
			else
				p1.ComboChildrenHeight = p1.ComboChildrenHeight - 10
			end
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 448 | Upvalues: p1 (copy) ]]
			if p12.state.index == nil then
				p12.state.index = p1._widgetState(p12, "index", "No Selection")
			end

			p12.state.index:onChange(function() --[[ Line: 452 | Upvalues: p12 (copy) ]]
				if not p12.state.isOpened.value then
					return
				end

				p12.state.isOpened:set(false)
			end)

			if p12.state.isOpened ~= nil then
				return
			end

			p12.state.isOpened = p1._widgetState(p12, "isOpened", false)
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 461 | Upvalues: v1 (ref), v3 (ref), v2 (ref), p1 (copy), p2 (copy), UpdateChildContainerTransform (copy) ]]
			local PreviewContainer = p12.Instance.PreviewContainer
			local Dropdown = PreviewContainer.DropdownButton.Dropdown
			local ChildContainer = p12.ChildContainer

			if p12.state.isOpened.value then
				v1 = true
				v3 = p12
				v2 = p1._cycleTick
				p12.lastOpenedTick = p1._cycleTick + 1
				Dropdown.Image = p2.ICONS.RIGHT_POINTING_TRIANGLE
				ChildContainer.Visible = true
				UpdateChildContainerTransform(p12)
			else
				if v1 then
					v1 = false
					v3 = nil
					p12.lastClosedTick = p1._cycleTick + 1
				end

				Dropdown.Image = p2.ICONS.DOWN_POINTING_TRIANGLE
				ChildContainer.Visible = false
			end

			local value = p12.state.index.value

			PreviewContainer.PreviewLabel.Text = if typeof(value) == "EnumItem" then value.Name else tostring(value)
		end,
		Discard = function(p1) --[[ Discard | Line: 493 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end
	})
end