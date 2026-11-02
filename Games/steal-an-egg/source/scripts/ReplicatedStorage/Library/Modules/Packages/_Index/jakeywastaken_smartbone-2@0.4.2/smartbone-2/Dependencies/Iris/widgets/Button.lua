-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	local t = {
		hasState = false,
		hasChildren = false,
		Args = {
			Text = 1
		},
		Events = {
			clicked = p2.EVENTS.click(function(p1) --[[ Line: 11 ]]
				return p1.Instance
			end),
			rightClicked = p2.EVENTS.rightClick(function(p1) --[[ Line: 14 ]]
				return p1.Instance
			end),
			doubleClicked = p2.EVENTS.doubleClick(function(p1) --[[ Line: 17 ]]
				return p1.Instance
			end),
			ctrlClicked = p2.EVENTS.ctrlClick(function(p1) --[[ Line: 20 ]]
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 23 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 27 | Upvalues: p1 (copy), p2 (copy) ]]
			local TextButton = Instance.new("TextButton")

			TextButton.Size = UDim2.fromOffset(0, 0)
			TextButton.BackgroundColor3 = p1._config.ButtonColor
			TextButton.BackgroundTransparency = p1._config.ButtonTransparency
			TextButton.AutoButtonColor = false
			p2.applyTextStyle(TextButton)
			TextButton.AutomaticSize = Enum.AutomaticSize.XY
			p2.applyFrameStyle(TextButton)
			p2.applyInteractionHighlights(TextButton, TextButton, {
				ButtonColor = p1._config.ButtonColor,
				ButtonTransparency = p1._config.ButtonTransparency,
				ButtonHoveredColor = p1._config.ButtonHoveredColor,
				ButtonHoveredTransparency = p1._config.ButtonHoveredTransparency,
				ButtonActiveColor = p1._config.ButtonActiveColor,
				ButtonActiveTransparency = p1._config.ButtonActiveTransparency
			})
			TextButton.ZIndex = p12.ZIndex
			TextButton.LayoutOrder = p12.ZIndex

			return TextButton
		end,
		Update = function(p1) --[[ Update | Line: 53 ]]
			p1.Instance.Text = p1.arguments.Text or "Button"
		end,
		Discard = function(p1) --[[ Discard | Line: 57 ]]
			p1.Instance:Destroy()
		end
	}

	p2.abstractButton = t
	p1.WidgetConstructor("Button", p2.extend(t, {
		Generate = function(p1) --[[ Generate | Line: 68 | Upvalues: t (copy) ]]
			local Iris_Button = t.Generate(p1)

			Iris_Button.Name = "Iris_Button"

			return Iris_Button
		end
	}))
	p1.WidgetConstructor("SmallButton", p2.extend(t, {
		Generate = function(p1) --[[ Generate | Line: 83 | Upvalues: t (copy) ]]
			local Iris_SmallButton = t.Generate(p1)

			Iris_SmallButton.Name = "Iris_SmallButton"

			local UIPadding = Iris_SmallButton.UIPadding

			UIPadding.PaddingLeft = UDim.new(0, 2)
			UIPadding.PaddingRight = UDim.new(0, 2)
			UIPadding.PaddingTop = UDim.new(0, 0)
			UIPadding.PaddingBottom = UDim.new(0, 0)

			return Iris_SmallButton
		end
	}))
end