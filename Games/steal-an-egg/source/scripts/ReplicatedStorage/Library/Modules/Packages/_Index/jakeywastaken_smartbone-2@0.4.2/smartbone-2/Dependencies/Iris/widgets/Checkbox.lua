-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	p1.WidgetConstructor("Checkbox", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {
			checked = {
				Init = function(p1) --[[ Line: 14 ]] end,
				Get = function(p12) --[[ Line: 15 | Upvalues: p1 (copy) ]]
					return p12.lastCheckedTick == p1._cycleTick
				end
			},
			unchecked = {
				Init = function(p1) --[[ Line: 20 ]] end,
				Get = function(p12) --[[ Line: 21 | Upvalues: p1 (copy) ]]
					return p12.lastUncheckedTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 25 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 29 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_Checkbox = Instance.new("TextButton")

			Iris_Checkbox.Name = "Iris_Checkbox"
			Iris_Checkbox.BackgroundTransparency = 1
			Iris_Checkbox.BorderSizePixel = 0
			Iris_Checkbox.Size = UDim2.fromOffset(0, 0)
			Iris_Checkbox.Text = ""
			Iris_Checkbox.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Checkbox.ZIndex = p12.ZIndex
			Iris_Checkbox.AutoButtonColor = false
			Iris_Checkbox.LayoutOrder = p12.ZIndex

			local v1 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
			local CheckboxBox = Instance.new("Frame")

			CheckboxBox.Name = "CheckboxBox"
			CheckboxBox.Size = UDim2.fromOffset(v1, v1)
			CheckboxBox.BackgroundColor3 = p1._config.FrameBgColor
			CheckboxBox.BackgroundTransparency = p1._config.FrameBgTransparency
			CheckboxBox.ZIndex = p12.ZIndex + 1
			CheckboxBox.LayoutOrder = p12.ZIndex + 1
			p2.applyFrameStyle(CheckboxBox, true)
			p2.applyInteractionHighlights(Iris_Checkbox, CheckboxBox, {
				ButtonColor = p1._config.FrameBgColor,
				ButtonTransparency = p1._config.FrameBgTransparency,
				ButtonHoveredColor = p1._config.FrameBgHoveredColor,
				ButtonHoveredTransparency = p1._config.FrameBgHoveredTransparency,
				ButtonActiveColor = p1._config.FrameBgActiveColor,
				ButtonActiveTransparency = p1._config.FrameBgActiveTransparency
			})
			CheckboxBox.Parent = Iris_Checkbox

			local v2 = math.ceil(v1 * 0.1)
			local v3 = v1 - v2 * 2
			local Checkmark = Instance.new("ImageLabel")

			Checkmark.Name = "Checkmark"
			Checkmark.Size = UDim2.fromOffset(v3, v3)
			Checkmark.Position = UDim2.fromOffset(v2, v2)
			Checkmark.BackgroundTransparency = 1
			Checkmark.ImageColor3 = p1._config.CheckMarkColor
			Checkmark.ImageTransparency = p1._config.CheckMarkTransparency
			Checkmark.ScaleType = Enum.ScaleType.Fit
			Checkmark.ZIndex = p12.ZIndex + 2
			Checkmark.LayoutOrder = p12.ZIndex + 2
			Checkmark.Parent = Iris_Checkbox
			Iris_Checkbox.MouseButton1Click:Connect(function() --[[ Line: 79 | Upvalues: p12 (copy) ]]
				p12.state.isChecked:set(not p12.state.isChecked.value)
			end)

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			p2.applyTextStyle(TextLabel)
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.Position = UDim2.new(0, v1 + p1._config.ItemInnerSpacing.X, 0.5, 0)
			TextLabel.ZIndex = p12.ZIndex + 1
			TextLabel.LayoutOrder = p12.ZIndex + 1
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.Parent = Iris_Checkbox

			return Iris_Checkbox
		end,
		Update = function(p1) --[[ Update | Line: 98 ]]
			p1.Instance.TextLabel.Text = p1.arguments.Text or "Checkbox"
		end,
		Discard = function(p1) --[[ Discard | Line: 102 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 106 | Upvalues: p1 (copy) ]]
			if p12.state.isChecked ~= nil then
				return
			end

			p12.state.isChecked = p1._widgetState(p12, "checked", false)
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 111 | Upvalues: p2 (copy), p1 (copy) ]]
			local Checkmark = p12.Instance.Checkmark

			if p12.state.isChecked.value then
				Checkmark.Image = p2.ICONS.CHECK_MARK
				p12.lastCheckedTick = p1._cycleTick + 1
			else
				Checkmark.Image = ""
				p12.lastUncheckedTick = p1._cycleTick + 1
			end
		end
	})
end