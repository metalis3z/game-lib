-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	local t = {}

	table.insert(p1._postCycleCallbacks, function() --[[ Line: 7 | Upvalues: t (copy) ]]
		for v1, v2 in t do
			v2.RowColumnIndex = 0
		end
	end)
	p1.WidgetConstructor("Table", {
		hasState = false,
		hasChildren = true,
		Args = {
			NumColumns = 1,
			RowBg = 2,
			BordersOuter = 3,
			BordersInner = 4
		},
		Events = {
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 25 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 29 | Upvalues: t (copy), p1 (copy), p2 (copy) ]]
			t[p12.ID] = p12
			p12.InitialNumColumns = -1
			p12.RowColumnIndex = 0
			p12.ColumnInstances = {}
			p12.CellInstances = {}

			local Iris_Table = Instance.new("Frame")

			Iris_Table.Name = "Iris_Table"
			Iris_Table.Size = UDim2.new(p1._config.ItemWidth, UDim.new(0, 0))
			Iris_Table.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Table.BackgroundTransparency = 1
			Iris_Table.BorderSizePixel = 0
			Iris_Table.ZIndex = p12.ZIndex + 1024
			Iris_Table.LayoutOrder = p12.ZIndex
			Iris_Table.ClipsDescendants = true
			p2.UIListLayout(Iris_Table, Enum.FillDirection.Horizontal, UDim.new(0, 0))
			p2.UIStroke(Iris_Table, 1, p1._config.TableBorderStrongColor, p1._config.TableBorderStrongTransparency)

			return Iris_Table
		end,
		Update = function(p12) --[[ Update | Line: 58 | Upvalues: p2 (copy), p1 (copy) ]]
			local v1 = p12.Instance

			if p12.arguments.BordersOuter == false then
				v1.UIStroke.Thickness = 0
			else
				v1.UIStroke.Thickness = 1
			end

			if p12.InitialNumColumns == -1 then
				if p12.arguments.NumColumns == nil then
					error("Iris.Table NumColumns argument is required", 5)
				end

				p12.InitialNumColumns = p12.arguments.NumColumns

				for i = 1, p12.InitialNumColumns do
					local v2 = p12.ZIndex + 1 + i
					local Frame = Instance.new("Frame")

					Frame.Name = ("Column_%*"):format(i)
					Frame.Size = UDim2.new(1 / p12.InitialNumColumns, 0, 0, 0)
					Frame.AutomaticSize = Enum.AutomaticSize.Y
					Frame.BackgroundTransparency = 1
					Frame.BorderSizePixel = 0
					Frame.ZIndex = v2
					Frame.LayoutOrder = v2
					Frame.ClipsDescendants = true
					p2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, 0))
					p12.ColumnInstances[i] = Frame
					Frame.Parent = v1
				end
			elseif p12.arguments.NumColumns ~= p12.InitialNumColumns then
				error("Iris.Table NumColumns Argument must be static")
			end

			if p12.arguments.RowBg == false then
				for v3, v4 in p12.CellInstances do
					v4.BackgroundTransparency = 1
				end
			else
				for v5, v6 in p12.CellInstances do
					v6.BackgroundTransparency = if math.ceil(v5 / p12.InitialNumColumns) % 2 == 0 then p1._config.TableRowBgAltTransparency else p1._config.TableRowBgTransparency
				end
			end

			if p12.arguments.BordersInner == false then
				for v9, v10 in p12.CellInstances do
					v10.UIStroke.Thickness = 0
				end
			else
				for v11, v12 in p12.CellInstances do
					v12.UIStroke.Thickness = 0.5
				end
			end
		end,
		Discard = function(p1) --[[ Discard | Line: 122 | Upvalues: t (copy) ]]
			t[p1.ID] = nil
			p1.Instance:Destroy()
		end,
		ChildAdded = function(p12) --[[ ChildAdded | Line: 126 | Upvalues: p2 (copy), p1 (copy) ]]
			if p12.RowColumnIndex == 0 then
				p12.RowColumnIndex = 1
			end

			local v1 = p12.CellInstances[p12.RowColumnIndex]

			if v1 then
				return v1
			end

			local v2 = p12.ColumnInstances[(p12.RowColumnIndex - 1) % p12.InitialNumColumns + 1]
			local v3 = v2.ZIndex + p12.RowColumnIndex
			local Frame = Instance.new("Frame")

			Frame.Name = ("Cell_%*"):format(p12.RowColumnIndex)
			Frame.Size = UDim2.new(1, 0, 0, 0)
			Frame.AutomaticSize = Enum.AutomaticSize.Y
			Frame.BackgroundTransparency = 1
			Frame.BorderSizePixel = 0
			Frame.ZIndex = v3
			Frame.LayoutOrder = v3
			Frame.ClipsDescendants = true
			p2.UIPadding(Frame, p1._config.CellPadding)
			p2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))

			if p12.arguments.BordersInner == false then
				p2.UIStroke(Frame, 0, p1._config.TableBorderLightColor, p1._config.TableBorderLightTransparency)
			else
				p2.UIStroke(Frame, 0.5, p1._config.TableBorderLightColor, p1._config.TableBorderLightTransparency)
			end

			if p12.arguments.RowBg ~= false then
				local v5 = math.ceil(p12.RowColumnIndex / p12.InitialNumColumns)
				local v6 = if v5 % 2 == 0 then p1._config.TableRowBgAltColor else p1._config.TableRowBgColor
				local v7 = if v5 % 2 == 0 then p1._config.TableRowBgAltTransparency else p1._config.TableRowBgTransparency

				Frame.BackgroundColor3 = v6
				Frame.BackgroundTransparency = v7
			end

			p12.CellInstances[p12.RowColumnIndex] = Frame
			Frame.Parent = v2

			return Frame
		end
	})
end