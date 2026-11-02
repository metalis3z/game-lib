-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:23
-- Luau version 6, Types version 3
-- Time taken: 0.006418 seconds

return function(arg1) -- Line 3
	local function _(arg1_2) -- Line 5, Named "wrapper"
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		return function(arg1_3, arg2) -- Line 6
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: arg1_2 (readonly)
			]]
			return arg1.Internal._Insert(arg1_2, arg1_3, arg2)
		end
	end
	local var4_upvr = "Window"
	function arg1.Window(arg1_4, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_4, arg2)
	end
	var4_upvr = arg1.Internal
	arg1.SetFocusedWindow = var4_upvr.SetFocusedWindow
	var4_upvr = "Tooltip"
	function arg1.Tooltip(arg1_5, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_5, arg2)
	end
	var4_upvr = "MenuBar"
	function arg1.MenuBar(arg1_6, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_6, arg2)
	end
	var4_upvr = "Menu"
	function arg1.Menu(arg1_7, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_7, arg2)
	end
	var4_upvr = "MenuItem"
	function arg1.MenuItem(arg1_8, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_8, arg2)
	end
	var4_upvr = "MenuToggle"
	function arg1.MenuToggle(arg1_9, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_9, arg2)
	end
	var4_upvr = "Separator"
	function arg1.Separator(arg1_10, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_10, arg2)
	end
	var4_upvr = "Indent"
	function arg1.Indent(arg1_11, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_11, arg2)
	end
	var4_upvr = "SameLine"
	function arg1.SameLine(arg1_12, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_12, arg2)
	end
	var4_upvr = "Group"
	function arg1.Group(arg1_13, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_13, arg2)
	end
	var4_upvr = "Text"
	function arg1.Text(arg1_14, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_14, arg2)
	end
	function arg1.TextWrapped(arg1_15) -- Line 365
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1_15[2] = true
		return arg1.Internal._Insert("Text", arg1_15)
	end
	function arg1.TextColored(arg1_16) -- Line 390
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1_16[3] = arg1_16[2]
		arg1_16[2] = nil
		return arg1.Internal._Insert("Text", arg1_16)
	end
	var4_upvr = "SeparatorText"
	function arg1.SeparatorText(arg1_17, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_17, arg2)
	end
	var4_upvr = "InputText"
	function arg1.InputText(arg1_18, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_18, arg2)
	end
	var4_upvr = "Button"
	function arg1.Button(arg1_19, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_19, arg2)
	end
	var4_upvr = "SmallButton"
	function arg1.SmallButton(arg1_20, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_20, arg2)
	end
	var4_upvr = "Checkbox"
	function arg1.Checkbox(arg1_21, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_21, arg2)
	end
	var4_upvr = "RadioButton"
	function arg1.RadioButton(arg1_22, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_22, arg2)
	end
	var4_upvr = "Image"
	function arg1.Image(arg1_23, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_23, arg2)
	end
	var4_upvr = "ImageButton"
	function arg1.ImageButton(arg1_24, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_24, arg2)
	end
	var4_upvr = "Tree"
	function arg1.Tree(arg1_25, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_25, arg2)
	end
	var4_upvr = "CollapsingHeader"
	function arg1.CollapsingHeader(arg1_26, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_26, arg2)
	end
	var4_upvr = "InputNum"
	function arg1.InputNum(arg1_27, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_27, arg2)
	end
	var4_upvr = "InputVector2"
	function arg1.InputVector2(arg1_28, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_28, arg2)
	end
	var4_upvr = "InputVector3"
	function arg1.InputVector3(arg1_29, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_29, arg2)
	end
	var4_upvr = "InputUDim"
	function arg1.InputUDim(arg1_30, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_30, arg2)
	end
	var4_upvr = "InputUDim2"
	function arg1.InputUDim2(arg1_31, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_31, arg2)
	end
	var4_upvr = "InputRect"
	function arg1.InputRect(arg1_32, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_32, arg2)
	end
	var4_upvr = "DragNum"
	function arg1.DragNum(arg1_33, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_33, arg2)
	end
	var4_upvr = "DragVector2"
	function arg1.DragVector2(arg1_34, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_34, arg2)
	end
	var4_upvr = "DragVector3"
	function arg1.DragVector3(arg1_35, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_35, arg2)
	end
	var4_upvr = "DragUDim"
	function arg1.DragUDim(arg1_36, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_36, arg2)
	end
	var4_upvr = "DragUDim2"
	function arg1.DragUDim2(arg1_37, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_37, arg2)
	end
	var4_upvr = "DragRect"
	function arg1.DragRect(arg1_38, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_38, arg2)
	end
	var4_upvr = "InputColor3"
	function arg1.InputColor3(arg1_39, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_39, arg2)
	end
	var4_upvr = "InputColor4"
	function arg1.InputColor4(arg1_40, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_40, arg2)
	end
	var4_upvr = "SliderNum"
	function arg1.SliderNum(arg1_41, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_41, arg2)
	end
	var4_upvr = "SliderVector2"
	function arg1.SliderVector2(arg1_42, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_42, arg2)
	end
	var4_upvr = "SliderVector3"
	function arg1.SliderVector3(arg1_43, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_43, arg2)
	end
	var4_upvr = "SliderUDim"
	function arg1.SliderUDim(arg1_44, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_44, arg2)
	end
	var4_upvr = "SliderUDim2"
	function arg1.SliderUDim2(arg1_45, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_45, arg2)
	end
	var4_upvr = "SliderRect"
	function arg1.SliderRect(arg1_46, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_46, arg2)
	end
	var4_upvr = "Selectable"
	function arg1.Selectable(arg1_47, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_47, arg2)
	end
	var4_upvr = "Combo"
	function arg1.Combo(arg1_48, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_48, arg2)
	end
	function arg1.ComboArray(arg1_49, arg2, arg3) -- Line 1530
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var58
		if arg2 == nil then
			var58 = arg1.State(arg3[1])
		else
			var58 = arg2
		end
		local any__Insert_result1 = arg1.Internal._Insert("Combo", arg1_49, var58)
		for _, v in arg3 do
			arg1.Internal._Insert("Selectable", {v, v}, {
				index = any__Insert_result1.state.index;
			})
			local _
		end
		arg1.End()
		return any__Insert_result1
	end
	function arg1.ComboEnum(arg1_50, arg2, arg3) -- Line 1579
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var72
		if arg2 == nil then
			var72 = arg1.State(arg3[1])
		else
			var72 = arg2
		end
		local any__Insert_result1_2 = arg1.Internal._Insert("Combo", arg1_50, var72)
		for _, v_2 in arg3:GetEnumItems() do
			arg1.Internal._Insert("Selectable", {v_2.Name, v_2}, {
				index = any__Insert_result1_2.state.index;
			})
			local _
		end
		arg1.End()
		return any__Insert_result1_2
	end
	arg1.InputEnum = arg1.ComboEnum
	var4_upvr = "ProgressBar"
	function arg1.ProgressBar(arg1_51, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_51, arg2)
	end
	var4_upvr = "Table"
	function arg1.Table(arg1_52, arg2) -- Line 6
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var4_upvr (readonly)
		]]
		return arg1.Internal._Insert(var4_upvr, arg1_52, arg2)
	end
	function arg1.NextColumn() -- Line 1674
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local any__GetParentWidget_result1_3 = arg1.Internal._GetParentWidget()
		any__GetParentWidget_result1_3.RowColumnIndex += 1
	end
	function arg1.SetColumnIndex(arg1_53) -- Line 1685
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local var85 = arg1
		local any__GetParentWidget_result1 = var85.Internal._GetParentWidget()
		if any__GetParentWidget_result1.InitialNumColumns > arg1_53 then
			var85 = false
		else
			var85 = true
		end
		assert(var85, "Iris.SetColumnIndex Argument must be in column range")
		any__GetParentWidget_result1.RowColumnIndex = (math.floor(any__GetParentWidget_result1.RowColumnIndex / any__GetParentWidget_result1.InitialNumColumns)) + (arg1_53 - 1)
	end
	function arg1.NextRow() -- Line 1698
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local any__GetParentWidget_result1_2 = arg1.Internal._GetParentWidget()
		local InitialNumColumns = any__GetParentWidget_result1_2.InitialNumColumns
		any__GetParentWidget_result1_2.RowColumnIndex = math.floor((any__GetParentWidget_result1_2.RowColumnIndex + 1) / InitialNumColumns) * InitialNumColumns
	end
end