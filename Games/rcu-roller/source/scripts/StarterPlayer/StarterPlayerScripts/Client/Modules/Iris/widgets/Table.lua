-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:42
-- Luau version 6, Types version 3
-- Time taken: 0.003395 seconds

return function(arg1, arg2) -- Line 5
	local tbl_upvr = {}
	table.insert(arg1._postCycleCallbacks, function() -- Line 9
		--[[ Upvalues[1]:
			[1]: tbl_upvr (readonly)
		]]
		for _, v in tbl_upvr do
			v.RowColumnIndex = 0
		end
	end)
	local tbl = {
		hasState = false;
		hasChildren = true;
		Args = {
			NumColumns = 1;
			RowBg = 2;
			BordersOuter = 3;
			BordersInner = 4;
		};
		Events = {
			hovered = arg2.EVENTS.hover(function(arg1_2) -- Line 26
				return arg1_2.Instance
			end);
		};
	}
	function tbl.Generate(arg1_3) -- Line 30
		--[[ Upvalues[3]:
			[1]: tbl_upvr (readonly)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		tbl_upvr[arg1_3.ID] = arg1_3
		arg1_3.InitialNumColumns = -1
		arg1_3.RowColumnIndex = 0
		arg1_3.ColumnInstances = {}
		arg1_3.CellInstances = {}
		local Frame = Instance.new("Frame")
		Frame.Name = "Table"
		Frame.Size = UDim2.new(arg1._config.ItemWidth, UDim.new(0, 0))
		Frame.AutomaticSize = Enum.AutomaticSize.Y
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.ZIndex = arg1_3.ZIndex + 1024
		Frame.LayoutOrder = arg1_3.ZIndex
		Frame.ClipsDescendants = true
		arg2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, 0))
		arg2.UIStroke(Frame, 1, arg1._config.TableBorderStrongColor, arg1._config.TableBorderStrongTransparency)
		return Frame
	end
	function tbl.Update(arg1_4) -- Line 54
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 55 start (CF ANALYSIS FAILED)
		if arg1_4.arguments.BordersOuter == false then
			arg1_4.Instance.UIStroke.Thickness = 0
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			arg1_4.Instance.UIStroke.Thickness = 1
		end
		-- KONSTANTERROR: [0] 1. Error Block 55 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [108] 72. Error Block 49 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [108] 72. Error Block 49 end (CF ANALYSIS FAILED)
	end
	function tbl.Discard(arg1_5) -- Line 116
		--[[ Upvalues[1]:
			[1]: tbl_upvr (readonly)
		]]
		tbl_upvr[arg1_5.ID] = nil
		arg1_5.Instance:Destroy()
	end
	function tbl.ChildAdded(arg1_6) -- Line 120
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var11
		if arg1_6.RowColumnIndex == 0 then
			arg1_6.RowColumnIndex = 1
		end
		local var12 = arg1_6.CellInstances[arg1_6.RowColumnIndex]
		if var12 then
			return var12
		end
		local var13 = arg1_6.ColumnInstances[(arg1_6.RowColumnIndex - 1) % arg1_6.InitialNumColumns + 1]
		local var14 = var13.ZIndex + arg1_6.RowColumnIndex
		local Frame_2 = Instance.new("Frame")
		Frame_2.Name = `Cell_{arg1_6.RowColumnIndex}`
		Frame_2.Size = UDim2.new(1, 0, 0, 0)
		Frame_2.AutomaticSize = Enum.AutomaticSize.Y
		Frame_2.BackgroundTransparency = 1
		Frame_2.BorderSizePixel = 0
		Frame_2.ZIndex = var14
		Frame_2.LayoutOrder = var14
		Frame_2.ClipsDescendants = true
		arg2.UIPadding(Frame_2, arg1._config.CellPadding)
		arg2.UIListLayout(Frame_2, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
		if arg1_6.arguments.BordersInner == false then
			arg2.UIStroke(Frame_2, 0, arg1._config.TableBorderLightColor, arg1._config.TableBorderLightTransparency)
		else
			arg2.UIStroke(Frame_2, 0.5, arg1._config.TableBorderLightColor, arg1._config.TableBorderLightTransparency)
		end
		if arg1_6.arguments.RowBg ~= false then
			local var16 = arg1_6.RowColumnIndex / arg1_6.InitialNumColumns
			local ceiled = math.ceil(var16)
			if ceiled % 2 == 0 then
				var16 = arg1._config.TableRowBgAltColor
			else
				var16 = arg1._config.TableRowBgColor
			end
			if ceiled % 2 == 0 then
			else
			end
			Frame_2.BackgroundColor3 = var16
			Frame_2.BackgroundTransparency = arg1._config.TableRowBgTransparency
		end
		arg1_6.CellInstances[arg1_6.RowColumnIndex] = Frame_2
		Frame_2.Parent = var13
		return Frame_2
	end
	arg1.WidgetConstructor("Table", tbl)
end