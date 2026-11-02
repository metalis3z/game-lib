--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQNaEGxhc3RTZWxlY3RlZFRpY2sKX2N5Y2xlVGljaxJsYXN0VW5zZWxlY3RlZFRpY2sFc3RhdGUFaW5kZXgFdmFsdWUJYXJndW1lbnRzBUluZGV4CEluc3RhbmNlA3NldANuZXcKVGV4dEJ1dHRvbhBJcmlzX1JhZGlvQnV0dG9uBE5hbWUWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQ9Cb3JkZXJTaXplUGl4ZWwFVURpbTIKZnJvbU9mZnNldARTaXplAARUZXh0BEVudW0NQXV0b21hdGljU2l6ZQJYWQZaSW5kZXgPQXV0b0J1dHRvbkNvbG9yC0xheW91dE9yZGVyB19jb25maWcIVGV4dFNpemUMRnJhbWVQYWRkaW5nAVkFRnJhbWUGQnV0dG9uBlBhcmVudAxGcmFtZUJnQ29sb3IQQmFja2dyb3VuZENvbG9yMxNGcmFtZUJnVHJhbnNwYXJlbmN5CFVJQ29ybmVyBkNpcmNsZQhQb3NpdGlvbg5DaGVja01hcmtDb2xvchVDaGVja01hcmtUcmFuc3BhcmVuY3kaYXBwbHlJbnRlcmFjdGlvbkhpZ2hsaWdodHMLQnV0dG9uQ29sb3ISQnV0dG9uVHJhbnNwYXJlbmN5EkJ1dHRvbkhvdmVyZWRDb2xvchlCdXR0b25Ib3ZlcmVkVHJhbnNwYXJlbmN5EUJ1dHRvbkFjdGl2ZUNvbG9yGEJ1dHRvbkFjdGl2ZVRyYW5zcGFyZW5jeRNGcmFtZUJnSG92ZXJlZENvbG9yGkZyYW1lQmdIb3ZlcmVkVHJhbnNwYXJlbmN5EkZyYW1lQmdBY3RpdmVDb2xvchlGcmFtZUJnQWN0aXZlVHJhbnNwYXJlbmN5EU1vdXNlQnV0dG9uMUNsaWNrB0Nvbm5lY3QJVGV4dExhYmVsDmFwcGx5VGV4dFN0eWxlEEl0ZW1Jbm5lclNwYWNpbmcBWAdWZWN0b3IyC0FuY2hvclBvaW50CEdlbmVyYXRlDFJhZGlvIEJ1dHRvbghfd2lkZ2V0cwR0eXBlC1VwZGF0ZVN0YXRlBlVwZGF0ZQdEZXN0cm95DGRpc2NhcmRTdGF0ZQdEaXNjYXJkDF93aWRnZXRTdGF0ZQVWYWx1ZQ1HZW5lcmF0ZVN0YXRlEVdpZGdldENvbnN0cnVjdG9yC1JhZGlvQnV0dG9uCGhh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

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
				Init = function(p1) --[[ Line: 13 ]] end,
				Get = function(p12) --[[ Line: 14 | Upvalues: p1 (copy) ]]
					return p12.lastSelectedTick == p1._cycleTick
				end
			},
			unselected = {
				Init = function(p1) --[[ Line: 19 ]] end,
				Get = function(p12) --[[ Line: 20 | Upvalues: p1 (copy) ]]
					return p12.lastUnselectedTick == p1._cycleTick
				end
			},
			active = {
				Init = function(p1) --[[ Line: 25 ]] end,
				Get = function(p1) --[[ Line: 26 ]]
					return p1.state.index.value == p1.arguments.Index
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 30 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 34 | Upvalues: p1 (copy), p2 (copy) ]]
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
			Iris_RadioButton.MouseButton1Click:Connect(function() --[[ Line: 78 | Upvalues: p12 (copy) ]]
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
		Update = function(p12) --[[ Update | Line: 96 | Upvalues: p1 (copy) ]]
			p12.Instance.TextLabel.Text = p12.arguments.Text or "Radio Button"

			if not p12.state then
				return
			end

			p1._widgets[p12.type].UpdateState(p12)
		end,
		Discard = function(p1) --[[ Discard | Line: 105 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 109 | Upvalues: p1 (copy) ]]
			if p12.state.index ~= nil then
				return
			end

			p12.state.index = p1._widgetState(p12, "index", p12.arguments.Value)
		end,
		UpdateState = function(p12) --[[ UpdateState | Line: 114 | Upvalues: p1 (copy) ]]
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