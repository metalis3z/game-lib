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
-- CQNMDlJvd0NvbHVtbkluZGV4CEluc3RhbmNlAklEEUluaXRpYWxOdW1Db2x1bW5zD0NvbHVtbkluc3RhbmNlcw1DZWxsSW5zdGFuY2VzA25ldwVGcmFtZQpJcmlzX1RhYmxlBE5hbWUFVURpbTIHX2NvbmZpZwlJdGVtV2lkdGgEVURpbQRTaXplBEVudW0NQXV0b21hdGljU2l6ZQFZFkJhY2tncm91bmRUcmFuc3BhcmVuY3kPQm9yZGVyU2l6ZVBpeGVsBlpJbmRleAtMYXlvdXRPcmRlchBDbGlwc0Rlc2NlbmRhbnRzDFVJTGlzdExheW91dA1GaWxsRGlyZWN0aW9uCkhvcml6b250YWwIVUlTdHJva2UWVGFibGVCb3JkZXJTdHJvbmdDb2xvch1UYWJsZUJvcmRlclN0cm9uZ1RyYW5zcGFyZW5jeQhHZW5lcmF0ZQlhcmd1bWVudHMMQm9yZGVyc091dGVyCVRoaWNrbmVzcwpOdW1Db2x1bW5zBWVycm9yKklyaXMuVGFibGUgTnVtQ29sdW1ucyBhcmd1bWVudCBpcyByZXF1aXJlZAlDb2x1bW5fJSoGZm9ybWF0CFZlcnRpY2FsBlBhcmVudC1JcmlzLlRhYmxlIE51bUNvbHVtbnMgQXJndW1lbnQgbXVzdCBiZSBzdGF0aWMFUm93QmcEbWF0aARjZWlsGVRhYmxlUm93QmdBbHRUcmFuc3BhcmVuY3kWVGFibGVSb3dCZ1RyYW5zcGFyZW5jeQxCb3JkZXJzSW5uZXIGVXBkYXRlB0Rlc3Ryb3kHRGlzY2FyZAdDZWxsXyUqCVVJUGFkZGluZwtDZWxsUGFkZGluZwtJdGVtU3BhY2luZxVUYWJsZUJvcmRlckxpZ2h0Q29sb3IcVGFibGVCb3JkZXJMaWdodFRyYW5zcGFyZW5jeRJUYWJsZVJvd0JnQWx0Q29sb3IPVGFibGVSb3dCZ0NvbG9yEEJhY2tncm91bmRDb2xvcjMKQ2hpbGRBZGRlZBNfcG9zdEN5Y2xlQ2FsbGJhY2tzBXRhYmxlBmluc2VydBFXaWRnZXRDb25zdHJ1Y3RvcgVUYWJsZQhoYXNTdGF0ZQtoYXNDaGlsZHJlbgRBcmdzBkV2ZW50cwZFVkVOVFMFaG92ZXIHaG92ZXJlZAdyZXF1aXJlBnNjcmlwdAVU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

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
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 23 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 27 | Upvalues: t (copy), p1 (copy), p2 (copy) ]]
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
		Update = function(p12) --[[ Update | Line: 51 | Upvalues: p2 (copy), p1 (copy) ]]
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
		Discard = function(p1) --[[ Discard | Line: 113 | Upvalues: t (copy) ]]
			t[p1.ID] = nil
			p1.Instance:Destroy()
		end,
		ChildAdded = function(p12) --[[ ChildAdded | Line: 117 | Upvalues: p2 (copy), p1 (copy) ]]
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