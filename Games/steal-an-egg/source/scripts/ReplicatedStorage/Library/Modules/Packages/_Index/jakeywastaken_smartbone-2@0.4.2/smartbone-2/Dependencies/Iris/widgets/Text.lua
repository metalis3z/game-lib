-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	p1.WidgetConstructor("Text", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1,
			Wrapped = 2,
			Color = 3,
			RichText = 4
		},
		Events = {
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 16 ]]
				return p1.Instance
			end)
		},
		Generate = function(p1) --[[ Generate | Line: 20 | Upvalues: p2 (copy) ]]
			local Iris_Text = Instance.new("TextLabel")

			Iris_Text.Name = "Iris_Text"
			Iris_Text.Size = UDim2.fromOffset(0, 0)
			Iris_Text.BackgroundTransparency = 1
			Iris_Text.BorderSizePixel = 0
			Iris_Text.ZIndex = p1.ZIndex
			Iris_Text.LayoutOrder = p1.ZIndex
			Iris_Text.AutomaticSize = Enum.AutomaticSize.XY
			p2.applyTextStyle(Iris_Text)
			p2.UIPadding(Iris_Text, Vector2.new(0, 2))

			return Iris_Text
		end,
		Update = function(p12) --[[ Update | Line: 35 | Upvalues: p1 (copy) ]]
			local v1 = p12.Instance

			if p12.arguments.Text == nil then
				error("Iris.Text Text Argument is required", 5)
			end

			if p12.arguments.Wrapped then
				v1.TextWrapped = true
			else
				v1.TextWrapped = false
			end

			if p12.arguments.Color then
				v1.TextColor3 = p12.arguments.Color
			else
				v1.TextColor3 = p1._config.TextColor
			end

			if p12.arguments.RichText then
				v1.RichText = true
			else
				v1.RichText = false
			end

			v1.Text = p12.arguments.Text
		end,
		Discard = function(p1) --[[ Discard | Line: 58 ]]
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("SeparatorText", {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 73 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 77 | Upvalues: p2 (copy), p1 (copy) ]]
			local Iris_SeparatorText = Instance.new("Frame")

			Iris_SeparatorText.Name = "Iris_SeparatorText"
			Iris_SeparatorText.Size = UDim2.fromScale(1, 0)
			Iris_SeparatorText.BackgroundTransparency = 1
			Iris_SeparatorText.BorderSizePixel = 0
			Iris_SeparatorText.AutomaticSize = Enum.AutomaticSize.Y
			Iris_SeparatorText.ZIndex = p12.ZIndex
			Iris_SeparatorText.LayoutOrder = p12.ZIndex
			Iris_SeparatorText.ClipsDescendants = true
			p2.UIPadding(Iris_SeparatorText, Vector2.new(0, p1._config.SeparatorTextPadding.Y))
			p2.UIListLayout(Iris_SeparatorText, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemSpacing.X))
			Iris_SeparatorText.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			TextLabel.ZIndex = p12.ZIndex + 1
			TextLabel.LayoutOrder = p12.ZIndex + 1
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_SeparatorText

			local Left = Instance.new("Frame")

			Left.Name = "Left"
			Left.AnchorPoint = Vector2.new(1, 0.5)
			Left.BackgroundColor3 = p1._config.SeparatorColor
			Left.BackgroundTransparency = p1._config.SeparatorTransparency
			Left.BorderSizePixel = 0
			Left.Size = UDim2.fromOffset(p1._config.SeparatorTextPadding.X - p1._config.ItemSpacing.X, p1._config.SeparatorTextBorderSize)
			Left.ZIndex = p12.ZIndex
			Left.LayoutOrder = p12.ZIndex
			Left.Parent = Iris_SeparatorText

			local Right = Instance.new("Frame")

			Right.Name = "Right"
			Right.AnchorPoint = Vector2.new(1, 0.5)
			Right.BackgroundColor3 = p1._config.SeparatorColor
			Right.BackgroundTransparency = p1._config.SeparatorTransparency
			Right.BorderSizePixel = 0
			Right.Size = UDim2.new(1, 0, 0, p1._config.SeparatorTextBorderSize)
			Right.ZIndex = p12.ZIndex + 2
			Right.LayoutOrder = p12.ZIndex + 2
			Right.Parent = Iris_SeparatorText

			return Iris_SeparatorText
		end,
		Update = function(p1) --[[ Update | Line: 138 ]]
			local TextLabel = p1.Instance.TextLabel

			if p1.arguments.Text ~= nil then
				TextLabel.Text = p1.arguments.Text

				return
			end

			error("Iris.Text Text Argument is required", 5)
		end,
		Discard = function(p1) --[[ Discard | Line: 146 ]]
			p1.Instance:Destroy()
		end
	})
end