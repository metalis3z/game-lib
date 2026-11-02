-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types)

return function(p1) --[[ Line: 3 ]]
	local function wrapper(p12) --[[ wrapper | Line: 5 | Upvalues: p1 (copy) ]]
		return function(p13, p2) --[[ Line: 6 | Upvalues: p1 (ref), p12 (copy) ]]
			return p1.Internal._Insert(p12, p13, p2)
		end
	end

	local v1 = "Window"

	function p1.Window(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v1 (copy) ]]
		return p1.Internal._Insert(v1, p13, p2)
	end
	p1.SetFocusedWindow = p1.Internal.SetFocusedWindow

	local v2 = "Tooltip"

	function p1.Tooltip(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v2 (copy) ]]
		return p1.Internal._Insert(v2, p13, p2)
	end

	local v3 = "MenuBar"

	function p1.MenuBar(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v3 (copy) ]]
		return p1.Internal._Insert(v3, p13, p2)
	end

	local v4 = "Menu"

	function p1.Menu(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v4 (copy) ]]
		return p1.Internal._Insert(v4, p13, p2)
	end

	local v5 = "MenuItem"

	function p1.MenuItem(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v5 (copy) ]]
		return p1.Internal._Insert(v5, p13, p2)
	end

	local v6 = "MenuToggle"

	function p1.MenuToggle(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v6 (copy) ]]
		return p1.Internal._Insert(v6, p13, p2)
	end

	local v7 = "Separator"

	function p1.Separator(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v7 (copy) ]]
		return p1.Internal._Insert(v7, p13, p2)
	end

	local v8 = "Indent"

	function p1.Indent(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v8 (copy) ]]
		return p1.Internal._Insert(v8, p13, p2)
	end

	local v9 = "SameLine"

	function p1.SameLine(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v9 (copy) ]]
		return p1.Internal._Insert(v9, p13, p2)
	end

	local v10 = "Group"

	function p1.Group(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v10 (copy) ]]
		return p1.Internal._Insert(v10, p13, p2)
	end

	local v11 = "Text"

	function p1.Text(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v11 (copy) ]]
		return p1.Internal._Insert(v11, p13, p2)
	end
	function p1.TextWrapped(p12) --[[ Line: 41 | Upvalues: p1 (copy) ]]
		p12[2] = true

		return p1.Internal._Insert("Text", p12)
	end
	function p1.TextColored(p12) --[[ Line: 46 | Upvalues: p1 (copy) ]]
		p12[3] = p12[2]
		p12[2] = nil

		return p1.Internal._Insert("Text", p12)
	end

	local v12 = "SeparatorText"

	function p1.SeparatorText(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v12 (copy) ]]
		return p1.Internal._Insert(v12, p13, p2)
	end

	local v13 = "InputText"

	function p1.InputText(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v13 (copy) ]]
		return p1.Internal._Insert(v13, p13, p2)
	end

	local v14 = "Button"

	function p1.Button(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v14 (copy) ]]
		return p1.Internal._Insert(v14, p13, p2)
	end

	local v15 = "SmallButton"

	function p1.SmallButton(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v15 (copy) ]]
		return p1.Internal._Insert(v15, p13, p2)
	end

	local v16 = "Checkbox"

	function p1.Checkbox(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v16 (copy) ]]
		return p1.Internal._Insert(v16, p13, p2)
	end

	local v17 = "RadioButton"

	function p1.RadioButton(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v17 (copy) ]]
		return p1.Internal._Insert(v17, p13, p2)
	end

	local v18 = "Tree"

	function p1.Tree(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v18 (copy) ]]
		return p1.Internal._Insert(v18, p13, p2)
	end

	local v19 = "CollapsingHeader"

	function p1.CollapsingHeader(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v19 (copy) ]]
		return p1.Internal._Insert(v19, p13, p2)
	end

	local v20 = "InputNum"

	function p1.InputNum(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v20 (copy) ]]
		return p1.Internal._Insert(v20, p13, p2)
	end

	local v21 = "InputVector2"

	function p1.InputVector2(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v21 (copy) ]]
		return p1.Internal._Insert(v21, p13, p2)
	end

	local v22 = "InputVector3"

	function p1.InputVector3(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v22 (copy) ]]
		return p1.Internal._Insert(v22, p13, p2)
	end

	local v23 = "InputUDim"

	function p1.InputUDim(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v23 (copy) ]]
		return p1.Internal._Insert(v23, p13, p2)
	end

	local v24 = "InputUDim2"

	function p1.InputUDim2(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v24 (copy) ]]
		return p1.Internal._Insert(v24, p13, p2)
	end

	local v25 = "InputRect"

	function p1.InputRect(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v25 (copy) ]]
		return p1.Internal._Insert(v25, p13, p2)
	end

	local v26 = "DragNum"

	function p1.DragNum(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v26 (copy) ]]
		return p1.Internal._Insert(v26, p13, p2)
	end

	local v27 = "DragVector2"

	function p1.DragVector2(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v27 (copy) ]]
		return p1.Internal._Insert(v27, p13, p2)
	end

	local v28 = "DragVector3"

	function p1.DragVector3(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v28 (copy) ]]
		return p1.Internal._Insert(v28, p13, p2)
	end

	local v29 = "DragUDim"

	function p1.DragUDim(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v29 (copy) ]]
		return p1.Internal._Insert(v29, p13, p2)
	end

	local v30 = "DragUDim2"

	function p1.DragUDim2(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v30 (copy) ]]
		return p1.Internal._Insert(v30, p13, p2)
	end

	local v31 = "DragRect"

	function p1.DragRect(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v31 (copy) ]]
		return p1.Internal._Insert(v31, p13, p2)
	end

	local v32 = "InputColor3"

	function p1.InputColor3(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v32 (copy) ]]
		return p1.Internal._Insert(v32, p13, p2)
	end

	local v33 = "InputColor4"

	function p1.InputColor4(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v33 (copy) ]]
		return p1.Internal._Insert(v33, p13, p2)
	end

	local v34 = "SliderNum"

	function p1.SliderNum(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v34 (copy) ]]
		return p1.Internal._Insert(v34, p13, p2)
	end

	local v35 = "SliderVector2"

	function p1.SliderVector2(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v35 (copy) ]]
		return p1.Internal._Insert(v35, p13, p2)
	end

	local v36 = "SliderVector3"

	function p1.SliderVector3(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v36 (copy) ]]
		return p1.Internal._Insert(v36, p13, p2)
	end

	local v37 = "SliderUDim"

	function p1.SliderUDim(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v37 (copy) ]]
		return p1.Internal._Insert(v37, p13, p2)
	end

	local v38 = "SliderUDim2"

	function p1.SliderUDim2(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v38 (copy) ]]
		return p1.Internal._Insert(v38, p13, p2)
	end

	local v39 = "SliderRect"

	function p1.SliderRect(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v39 (copy) ]]
		return p1.Internal._Insert(v39, p13, p2)
	end

	local v40 = "Selectable"

	function p1.Selectable(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v40 (copy) ]]
		return p1.Internal._Insert(v40, p13, p2)
	end

	local v41 = "Combo"

	function p1.Combo(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v41 (copy) ]]
		return p1.Internal._Insert(v41, p13, p2)
	end
	function p1.ComboArray(p12, p2, p3) --[[ Line: 112 | Upvalues: p1 (copy) ]]
		local v3 = p1.Internal._Insert("Combo", p12, if p2 == nil then p1.State(p3[1]) else p2)
		local index = v3.state.index

		for v4, v5 in p3 do
			p1.Internal._Insert("Selectable", { v5, v5 }, {
				index = index
			})
		end

		p1.End()

		return v3
	end
	function p1.ComboEnum(p12, p2, p3) --[[ Line: 129 | Upvalues: p1 (copy) ]]
		local v3 = p1.Internal._Insert("Combo", p12, if p2 == nil then p1.State(p3[1]) else p2)
		local index = v3.state.index

		for v4, v5 in p3:GetEnumItems() do
			p1.Internal._Insert("Selectable", { v5.Name, v5 }, {
				index = index
			})
		end

		p1.End()

		return v3
	end
	p1.InputEnum = p1.ComboEnum

	local v42 = "Table"

	function p1.Table(p13, p2) --[[ Line: 6 | Upvalues: p1 (copy), v42 (copy) ]]
		return p1.Internal._Insert(v42, p13, p2)
	end
	function p1.NextColumn() --[[ Line: 149 | Upvalues: p1 (copy) ]]
		local v1 = p1.Internal._GetParentWidget()

		v1.RowColumnIndex = v1.RowColumnIndex + 1
	end
	function p1.SetColumnIndex(p12) --[[ Line: 153 | Upvalues: p1 (copy) ]]
		local v1 = p1.Internal._GetParentWidget()

		assert(v1.InitialNumColumns <= p12, "Iris.SetColumnIndex Argument must be in column range")
		v1.RowColumnIndex = math.floor(v1.RowColumnIndex / v1.InitialNumColumns) + (p12 - 1)
	end
	function p1.NextRow() --[[ Line: 160 | Upvalues: p1 (copy) ]]
		local v1 = p1.Internal._GetParentWidget()
		local InitialNumColumns = v1.InitialNumColumns

		v1.RowColumnIndex = math.floor((v1.RowColumnIndex + 1) / InitialNumColumns) * InitialNumColumns
	end
end