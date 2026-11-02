-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	p1.WidgetConstructor("Separator", {
		hasState = false,
		hasChildren = false,
		Args = {},
		Events = {},
		Generate = function(p12) --[[ Generate | Line: 11 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_Separator = Instance.new("Frame")

			Iris_Separator.Name = "Iris_Separator"
			Iris_Separator.BackgroundColor3 = p1._config.SeparatorColor
			Iris_Separator.BackgroundTransparency = p1._config.SeparatorTransparency
			Iris_Separator.BorderSizePixel = 0

			if p12.parentWidget.type == "SameLine" then
				Iris_Separator.Size = UDim2.new(0, 1, 1, 0)
			else
				Iris_Separator.Size = UDim2.new(1, 0, 0, 1)
			end

			Iris_Separator.ZIndex = p12.ZIndex
			Iris_Separator.LayoutOrder = p12.ZIndex
			p2.UIListLayout(Iris_Separator, Enum.FillDirection.Vertical, UDim.new(0, 0))

			return Iris_Separator
		end,
		Update = function(p1) --[[ Update | Line: 30 ]] end,
		Discard = function(p1) --[[ Discard | Line: 31 ]]
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("Indent", {
		hasState = false,
		hasChildren = true,
		Args = {
			Width = 1
		},
		Events = {},
		Generate = function(p12) --[[ Generate | Line: 46 | Upvalues: p2 (copy), p1 (copy) ]]
			local Iris_Indent = Instance.new("Frame")

			Iris_Indent.Name = "Iris_Indent"
			Iris_Indent.BackgroundTransparency = 1
			Iris_Indent.BorderSizePixel = 0
			Iris_Indent.Size = UDim2.fromScale(1, 0)
			Iris_Indent.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Indent.ZIndex = p12.ZIndex
			Iris_Indent.LayoutOrder = p12.ZIndex
			p2.UIListLayout(Iris_Indent, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			p2.UIPadding(Iris_Indent, Vector2.new(0, 0))

			return Iris_Indent
		end,
		Update = function(p12) --[[ Update | Line: 61 | Upvalues: p1 (copy) ]]
			p12.Instance.UIPadding.PaddingLeft = UDim.new(0, if p12.arguments.Width then p12.arguments.Width else p1._config.IndentSpacing)
		end,
		Discard = function(p1) --[[ Discard | Line: 72 ]]
			p1.Instance:Destroy()
		end,
		ChildAdded = function(p1, p2) --[[ ChildAdded | Line: 75 ]]
			return p1.Instance
		end
	})
	p1.WidgetConstructor("SameLine", {
		hasState = false,
		hasChildren = true,
		Args = {
			Width = 1,
			VerticalAlignment = 2
		},
		Events = {},
		Generate = function(p1) --[[ Generate | Line: 91 | Upvalues: p2 (copy) ]]
			local Iris_SameLine = Instance.new("Frame")

			Iris_SameLine.Name = "Iris_SameLine"
			Iris_SameLine.BackgroundTransparency = 1
			Iris_SameLine.BorderSizePixel = 0
			Iris_SameLine.Size = UDim2.fromScale(1, 0)
			Iris_SameLine.AutomaticSize = Enum.AutomaticSize.Y
			Iris_SameLine.ZIndex = p1.ZIndex
			Iris_SameLine.LayoutOrder = p1.ZIndex
			p2.UIListLayout(Iris_SameLine, Enum.FillDirection.Horizontal, UDim.new(0, 0))

			return Iris_SameLine
		end,
		Update = function(p12) --[[ Update | Line: 105 | Upvalues: p1 (copy) ]]
			local UIListLayout = p12.Instance.UIListLayout

			UIListLayout.Padding = UDim.new(0, if p12.arguments.Width then p12.arguments.Width else p1._config.ItemSpacing.X)

			if p12.arguments.VerticalAlignment then
				UIListLayout.VerticalAlignment = p12.arguments.VerticalAlignment
			else
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			end
		end,
		Discard = function(p1) --[[ Discard | Line: 121 ]]
			p1.Instance:Destroy()
		end,
		ChildAdded = function(p1, p2) --[[ ChildAdded | Line: 124 ]]
			return p1.Instance
		end
	})
	p1.WidgetConstructor("Group", {
		hasState = false,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(p12) --[[ Generate | Line: 137 | Upvalues: p2 (copy), p1 (copy) ]]
			local Iris_Group = Instance.new("Frame")

			Iris_Group.Name = "Iris_Group"
			Iris_Group.BackgroundTransparency = 1
			Iris_Group.BorderSizePixel = 0
			Iris_Group.Size = UDim2.fromOffset(0, 0)
			Iris_Group.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Group.ZIndex = p12.ZIndex
			Iris_Group.LayoutOrder = p12.ZIndex
			Iris_Group.ClipsDescendants = true
			p2.UIListLayout(Iris_Group, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.X))

			return Iris_Group
		end,
		Update = function(p1) --[[ Update | Line: 152 ]] end,
		Discard = function(p1) --[[ Discard | Line: 153 ]]
			p1.Instance:Destroy()
		end,
		ChildAdded = function(p1, p2) --[[ ChildAdded | Line: 156 ]]
			return p1.Instance
		end
	})
end