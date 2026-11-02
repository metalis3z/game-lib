local t = {}
local t2 = {}

function t.ResizeList(p1, p2, p3) --[[ ResizeList | Line: 4 | Upvalues: t2 (copy) ]]
	local v1 = p3 or "Y"
	local v2 = #p1:GetChildren() - 1
	local v3 = p1.AbsoluteSize[v1]
	local v5 = t2[p1.UIListLayout] and t2[p1.UIListLayout].Padding.Scale

	if not v5 then
		t2[p1.UIListLayout] = {
			Padding = p1.UIListLayout.Padding
		}
		v5 = t2[p1.UIListLayout].Padding.Scale
	end

	local v6 = v3 * p2.Size[v1].Scale * v2 / v3 + v5 * (v2 - 1)

	if v6 < 1 or v6 - 1 < 1 then
		v6 = math.ceil(v6)
	end

	if not p2:FindFirstChild("UIAspectRatioConstraint") then
		p2.Size = UDim2.new(1, -p1.ScrollBarThickness, p2.Size[v1].Scale / v6, 0)
	end

	p1.UIListLayout.Padding = UDim.new(v5 / v6, 0)

	if v1 == "Y" then
		p1.CanvasSize = UDim2.new(v6 - 1, 0, 0, 0)
	else
		p1.CanvasSize = UDim2.new(0, 0, v6 - 1, 0)
	end

	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("GuiObject") then
			v.Size = p2.Size
		end
	end

	return p2.Size
end
function t.ResizeGrid(p1, p2) --[[ ResizeGrid | Line: 44 | Upvalues: t2 (copy) ]]
	local v1 = if p2 then p2 else #p1:GetChildren() - 1
	local Y = p1.Parent.AbsoluteSize.Y
	local v2 = t2[p1.UIGridLayout]

	if not v2 then
		t2[p1.UIGridLayout] = {
			CellSize = p1.UIGridLayout.CellSize,
			CellPadding = p1.UIGridLayout.CellPadding
		}
		v2 = t2[p1.UIGridLayout]
	end

	local Scale = v2.CellPadding.Y.Scale
	local _ = Y * v2.CellSize.X.Scale
	local FillDirectionMaxCells = p1.UIGridLayout.FillDirectionMaxCells

	if FillDirectionMaxCells == 0 then
		local v5 = math.floor(1 / v2.CellSize.Y.Scale)

		p1.UIGridLayout.FillDirectionMaxCells = v5
		FillDirectionMaxCells = v5
	end

	local v6 = math.ceil(v1 / FillDirectionMaxCells)
	local v7 = Y * v2.CellSize.Y.Scale * v6
	local v8 = v7 / Y + Scale * (v6 - 1)

	if v8 < 1 then
		v8 = 1
	end

	local v9 = v7 / Y + Scale * (v6 - 1)

	if v9 < 1 then
		v9 = 1
	end

	p1.UIGridLayout.CellSize = UDim2.new(v2.CellSize.X.Scale, 0, v2.CellSize.Y.Scale / v9, 0)
	p1.UIGridLayout.CellPadding = UDim2.new(v2.CellPadding.X.Scale, 0, Scale / v8, 0)

	if v8 == 1 then
		p1.CanvasSize = UDim2.new(0, 0, v8 - 1, 0)
	else
		p1.CanvasSize = UDim2.new(0, 0, v8, 0)
	end

	return v2.CellSize
end

return t