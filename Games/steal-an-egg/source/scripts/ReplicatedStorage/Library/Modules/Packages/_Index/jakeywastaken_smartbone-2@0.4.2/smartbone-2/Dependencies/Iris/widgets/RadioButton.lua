-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	p1.WidgetConstructor("RadioButton", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			Index = 2
		},
		Events = {
			selected = {
				Init = function(p1) --[[ Line: 15 ]] end,
				Get = function(p12) --[[ Line: 16 | Upvalues: p1 (copy) ]]
					return p12.lastSelectedTick == p1._cycleTick
				end
			},
			unselected = {
				Init = function(p1) --[[ Line: 21 ]] end,
				Get = function(p12) --[[ Line: 22 | Upvalues: p1 (copy) ]]
					return p12.lastUnselectedTick == p1._cycleTick
				end
			},
			active = {
				Init = function(p1) --[[ Line: 27 ]] end,
				Get = function(p1) --[[ Line: 28 ]]
					return p1.state.index.value == p1.arguments.Index
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 32 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 36 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_RadioButton = Instance.new("TextButton")

			Iris_RadioButton.Name = "Iris_RadioButton"
			Iris_RadioButton.BackgroundTransparency = 1
			Iris_RadioButton.BorderSizePixel = 0
			Iris_RadioButton.Size = UDim2.fromOffset(0, 0)
			Iris_RadioButton.Text = ""
			Iris_RadioButton.AutomaticSize = Enum.AutomaticSize.XY
			Iris_RadioButton.ZIndex = p12.ZIndex
			Iris_RadioButton.AutoButtonColor = false
			Iris_RadioButton.LayoutOrder = p12.ZIndex

			local v1 = p1._config.TextSize + 2 * (p1._config.FramePadding.Y - 1)
			local Button = Instance.new("Frame")

			Button.Name = "Button"
			Button.Size = UDim2.fromOffset(v1, v1)
			Button.ZIndex = p12.ZIndex + 1
			Button.LayoutOrder = p12.ZIndex + 1
			Button.Parent = Iris_RadioButton
			Button.BackgroundColor3 = p1._config.FrameBgColor
			Button.BackgroundTransparency = p1._config.FrameBgTransparency
			p2.UICorner(Button)

			local Circle = Instance.new("Frame")

			Circle.Name = "Circle"
			Circle.Position = UDim2.fromOffset(p1._config.FramePadding.Y, p1._config.FramePadding.Y)
			Circle.Size = UDim2.fromOffset(p1._config.TextSize - 2, p1._config.TextSize - 2)
			Circle.ZIndex = p12.ZIndex + 1
			Circle.LayoutOrder = p12.ZIndex + 1
			Circle.Parent = Button
			Circle.BackgroundColor3 = p1._config.CheckMarkColor
			Circle.BackgroundTransparency = p1._config.CheckMarkTransparency
			p2.UICorner(Circle)
			p2.applyInteractionHighlights(Iris_RadioButton, Button, {
				ButtonColor = p1._config.FrameBgColor,
				ButtonTransparency = p1._config.FrameBgTransparency,
				ButtonHoveredColor = p1._config.FrameBgHoveredColor,
				ButtonHoveredTransparency = p1._config.FrameBgHoveredTransparency,
				ButtonActiveColor = p1._config.FrameBgActiveColor,
				ButtonActiveTransparency = p1._config.FrameBgActiveTransparency
			})
			Iris_RadioButton.MouseButton1Click:Connect(function() --[[ Line: 80 | Upvalues: p12 (copy) ]]
				p12.state.index:set(p12.arguments.Index)
			end)

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			p2.applyTextStyle(TextLabel)
			TextLabel.Position = UDim2.new(0, v1 + p1._config.ItemInnerSpacing.X, 0.5, 0)
			TextLabel.ZIndex = p12.ZIndex + 1
			TextLabel.LayoutOrder = p12.ZIndex + 1
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.Parent = Iris_RadioButton

			return Iris_RadioButton
		end,
		Update = function(p12) --[[ Update | Line: 98 | Upvalues: p1 (copy) ]]
			p12.Instance.TextLabel.Text = p12.arguments.Text or "Radio Button"

			if not p12.state then
				return
			end

			p1._widgets[p12.type].UpdateState(p12)
		end,
		Discard = function(p1) --[[ Discard | Line: 107 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 111 | Upvalues: p1 (copy) ]]
			if p12.state.index ~= nil then
				return
			end

			p12.state.index = p1._widgetState(p12, "index", p12.arguments.Value)
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 116 | Upvalues: p1 (copy) ]]
			local Circle = p12.Instance.Button.Circle

			if p12.state.index.value == p12.arguments.Index then
				Circle.BackgroundTransparency = p1._config.CheckMarkTransparency
				p12.lastSelectedTick = p1._cycleTick + 1
			else
				Circle.BackgroundTransparency = 1
				p12.lastUnselectedTick = p1._cycleTick + 1
			end
		end
	})
end