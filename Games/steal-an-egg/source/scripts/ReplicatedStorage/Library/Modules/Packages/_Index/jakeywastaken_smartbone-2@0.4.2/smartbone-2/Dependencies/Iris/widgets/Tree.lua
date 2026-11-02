-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	local t = {
		hasState = true,
		hasChildren = true,
		Events = {
			collasped = {
				Init = function(p1) --[[ Line: 9 ]] end,
				Get = function(p12) --[[ Line: 10 | Upvalues: p1 (copy) ]]
					return p12.lastCollapsedTick == p1._cycleTick
				end
			},
			uncollapsed = {
				Init = function(p1) --[[ Line: 15 ]] end,
				Get = function(p12) --[[ Line: 16 | Upvalues: p1 (copy) ]]
					return p12.lastUncollapsedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 20 ]]
				return p1.Instance
			end)
		},
		Discard = function(p1) --[[ Discard | Line: 24 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		ChildAdded = function(p1) --[[ ChildAdded | Line: 28 ]]
			local ChildContainer = p1.Instance.ChildContainer

			ChildContainer.Visible = p1.state.isUncollapsed.value

			return ChildContainer
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 36 | Upvalues: p2 (copy), p1 (copy) ]]
			local value = p12.state.isUncollapsed.value
			local v1 = p12.Instance

			v1.Header.Button.Arrow.Image = value and p2.ICONS.DOWN_POINTING_TRIANGLE or p2.ICONS.RIGHT_POINTING_TRIANGLE

			if value then
				p12.lastUncollapsedTick = p1._cycleTick + 1
			else
				p12.lastCollapsedTick = p1._cycleTick + 1
			end

			v1.ChildContainer.Visible = value
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 55 | Upvalues: p1 (copy) ]]
			if p12.state.isUncollapsed ~= nil then
				return
			end

			p12.state.isUncollapsed = p1._widgetState(p12, "isUncollapsed", false)
		end
	}

	p1.WidgetConstructor("Tree", p2.extend(t, {
		Args = {
			Text = 1,
			SpanAvailWidth = 2,
			NoIndent = 3
		},
		Generate = function(p12) --[[ Generate | Line: 70 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_Tree = Instance.new("Frame")

			Iris_Tree.Name = "Iris_Tree"
			Iris_Tree.Size = UDim2.new(p1._config.ItemWidth, UDim.new(0, 0))
			Iris_Tree.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Tree.BackgroundTransparency = 1
			Iris_Tree.BorderSizePixel = 0
			Iris_Tree.ZIndex = p12.ZIndex
			Iris_Tree.LayoutOrder = p12.ZIndex
			p2.UIListLayout(Iris_Tree, Enum.FillDirection.Vertical, UDim.new(0, 0))

			local ChildContainer = Instance.new("Frame")

			ChildContainer.Name = "ChildContainer"
			ChildContainer.Size = UDim2.fromScale(1, 0)
			ChildContainer.AutomaticSize = Enum.AutomaticSize.Y
			ChildContainer.BackgroundTransparency = 1
			ChildContainer.BorderSizePixel = 0
			ChildContainer.ZIndex = p12.ZIndex + 1
			ChildContainer.LayoutOrder = p12.ZIndex + 1
			ChildContainer.Visible = false
			p2.UIListLayout(ChildContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			p2.UIPadding(ChildContainer, Vector2.new(0, 0)).PaddingTop = UDim.new(0, p1._config.ItemSpacing.Y)
			ChildContainer.Parent = Iris_Tree

			local Header = Instance.new("Frame")

			Header.Name = "Header"
			Header.Size = UDim2.fromScale(1, 0)
			Header.AutomaticSize = Enum.AutomaticSize.Y
			Header.BackgroundTransparency = 1
			Header.BorderSizePixel = 0
			Header.ZIndex = p12.ZIndex
			Header.LayoutOrder = p12.ZIndex
			Header.Parent = Iris_Tree

			local Button = Instance.new("TextButton")

			Button.Name = "Button"
			Button.BackgroundTransparency = 1
			Button.BorderSizePixel = 0
			Button.Text = ""
			Button.ZIndex = p12.ZIndex
			Button.LayoutOrder = p12.ZIndex
			Button.AutoButtonColor = false
			p2.applyInteractionHighlights(Button, Header, {
				ButtonTransparency = 1,
				ButtonColor = Color3.fromRGB(0, 0, 0),
				ButtonHoveredColor = p1._config.HeaderHoveredColor,
				ButtonHoveredTransparency = p1._config.HeaderHoveredTransparency,
				ButtonActiveColor = p1._config.HeaderActiveColor,
				ButtonActiveTransparency = p1._config.HeaderActiveTransparency
			})
			p2.UIPadding(Button, Vector2.zero).PaddingLeft = UDim.new(0, p1._config.FramePadding.X)
			p2.UIListLayout(Button, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			Button.Parent = Header

			local Arrow = Instance.new("ImageLabel")

			Arrow.Name = "Arrow"
			Arrow.Size = UDim2.fromOffset(p1._config.TextSize, (math.floor(p1._config.TextSize * 0.7)))
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.ImageColor3 = p1._config.TextColor
			Arrow.ImageTransparency = p1._config.TextTransparency
			Arrow.ScaleType = Enum.ScaleType.Fit
			Arrow.ZIndex = p12.ZIndex
			Arrow.LayoutOrder = p12.ZIndex
			Arrow.Parent = Button

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = p12.ZIndex
			TextLabel.LayoutOrder = p12.ZIndex
			p2.UIPadding(TextLabel, Vector2.new(0, 0)).PaddingRight = UDim.new(0, 21)
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Button
			Button.MouseButton1Click:Connect(function() --[[ Line: 170 | Upvalues: p12 (copy) ]]
				p12.state.isUncollapsed:set(not p12.state.isUncollapsed.value)
			end)

			return Iris_Tree
		end,
		Update = function(p12) --[[ Update | Line: 176 | Upvalues: p1 (copy) ]]
			local v1 = p12.Instance
			local Button = v1.Header.Button
			local UIPadding = v1.ChildContainer.UIPadding

			Button.TextLabel.Text = p12.arguments.Text or "Tree"

			if p12.arguments.SpanAvailWidth then
				Button.AutomaticSize = Enum.AutomaticSize.Y
				Button.Size = UDim2.fromScale(1, 0)
			else
				Button.AutomaticSize = Enum.AutomaticSize.XY
				Button.Size = UDim2.fromScale(0, 0)
			end

			if p12.arguments.NoIndent then
				UIPadding.PaddingLeft = UDim.new(0, 0)
			else
				UIPadding.PaddingLeft = UDim.new(0, p1._config.IndentSpacing)
			end
		end
	}))
	p1.WidgetConstructor("CollapsingHeader", p2.extend(t, {
		Args = {
			Text = 1
		},
		Generate = function(p12) --[[ Generate | Line: 208 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_CollapsingHeader = Instance.new("Frame")

			Iris_CollapsingHeader.Name = "Iris_CollapsingHeader"
			Iris_CollapsingHeader.Size = UDim2.new(p1._config.ItemWidth, UDim.new(0, 0))
			Iris_CollapsingHeader.AutomaticSize = Enum.AutomaticSize.Y
			Iris_CollapsingHeader.BackgroundTransparency = 1
			Iris_CollapsingHeader.BorderSizePixel = 0
			Iris_CollapsingHeader.ZIndex = p12.ZIndex
			Iris_CollapsingHeader.LayoutOrder = p12.ZIndex
			p2.UIListLayout(Iris_CollapsingHeader, Enum.FillDirection.Vertical, UDim.new(0, 0))

			local ChildContainer = Instance.new("Frame")

			ChildContainer.Name = "ChildContainer"
			ChildContainer.Size = UDim2.fromScale(1, 0)
			ChildContainer.AutomaticSize = Enum.AutomaticSize.Y
			ChildContainer.BackgroundTransparency = 1
			ChildContainer.BorderSizePixel = 0
			ChildContainer.ZIndex = p12.ZIndex + 1
			ChildContainer.LayoutOrder = p12.ZIndex + 1
			ChildContainer.Visible = false
			p2.UIListLayout(ChildContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			p2.UIPadding(ChildContainer, Vector2.new(0, 0)).PaddingTop = UDim.new(0, p1._config.ItemSpacing.Y)
			ChildContainer.Parent = Iris_CollapsingHeader

			local Header = Instance.new("Frame")

			Header.Name = "Header"
			Header.Size = UDim2.fromScale(1, 0)
			Header.AutomaticSize = Enum.AutomaticSize.Y
			Header.BackgroundTransparency = 1
			Header.BorderSizePixel = 0
			Header.ZIndex = p12.ZIndex
			Header.LayoutOrder = p12.ZIndex
			Header.Parent = Iris_CollapsingHeader

			local Button = Instance.new("TextButton")

			Button.Name = "Button"
			Button.Size = UDim2.new(1, 2 * p1._config.FramePadding.X, 0, 0)
			Button.Position = UDim2.fromOffset(-4, 0)
			Button.AutomaticSize = Enum.AutomaticSize.Y
			Button.BackgroundColor3 = p1._config.HeaderColor
			Button.BackgroundTransparency = p1._config.HeaderTransparency
			Button.BorderSizePixel = 0
			Button.Text = ""
			Button.ZIndex = p12.ZIndex
			Button.LayoutOrder = p12.ZIndex
			Button.AutoButtonColor = false
			Button.ClipsDescendants = true
			p2.UIPadding(Button, Vector2.new(2 * p1._config.FramePadding.X, p1._config.FramePadding.Y))
			p2.applyFrameStyle(Button, true, true)
			p2.UIListLayout(Button, Enum.FillDirection.Horizontal, UDim.new(0, 2 * p1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			p2.applyInteractionHighlights(Button, Button, {
				ButtonColor = p1._config.HeaderColor,
				ButtonTransparency = p1._config.HeaderTransparency,
				ButtonHoveredColor = p1._config.HeaderHoveredColor,
				ButtonHoveredTransparency = p1._config.HeaderHoveredTransparency,
				ButtonActiveColor = p1._config.HeaderActiveColor,
				ButtonActiveTransparency = p1._config.HeaderActiveTransparency
			})
			Button.Parent = Header

			local Arrow = Instance.new("ImageLabel")

			Arrow.Name = "Arrow"
			Arrow.Size = UDim2.fromOffset(p1._config.TextSize, (math.ceil(p1._config.TextSize * 0.8)))
			Arrow.AutomaticSize = Enum.AutomaticSize.Y
			Arrow.BackgroundTransparency = 1
			Arrow.BorderSizePixel = 0
			Arrow.ImageColor3 = p1._config.TextColor
			Arrow.ImageTransparency = p1._config.TextTransparency
			Arrow.ScaleType = Enum.ScaleType.Fit
			Arrow.ZIndex = p12.ZIndex
			Arrow.LayoutOrder = p12.ZIndex
			Arrow.Parent = Button

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			TextLabel.Size = UDim2.fromOffset(0, 0)
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = p12.ZIndex
			TextLabel.LayoutOrder = p12.ZIndex
			p2.UIPadding(TextLabel, Vector2.new(0, 0)).PaddingRight = UDim.new(0, 21)
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Button
			Button.MouseButton1Click:Connect(function() --[[ Line: 314 | Upvalues: p12 (copy) ]]
				p12.state.isUncollapsed:set(not p12.state.isUncollapsed.value)
			end)

			return Iris_CollapsingHeader
		end,
		Update = function(p1) --[[ Update | Line: 320 ]]
			p1.Instance.Header.Button.TextLabel.Text = p1.arguments.Text or "Collapsing Header"
		end
	}))
end