-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:34
-- Luau version 6, Types version 3
-- Time taken: 0.003093 seconds

return function(arg1, arg2) -- Line 3
	local tbl_2 = {
		hasState = false;
		hasChildren = false;
		Args = {};
		Events = {};
	}
	local function Generate(arg1_2) -- Line 10
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local Frame_2 = Instance.new("Frame")
		Frame_2.Name = "Separator"
		Frame_2.BackgroundColor3 = arg1._config.SeparatorColor
		Frame_2.BackgroundTransparency = arg1._config.SeparatorTransparency
		Frame_2.BorderSizePixel = 0
		if arg1_2.parentWidget.type == "SameLine" then
			Frame_2.Size = UDim2.new(0, 1, 1, 0)
		else
			Frame_2.Size = UDim2.new(1, 0, 0, 1)
		end
		Frame_2.LayoutOrder = arg1_2.ZIndex
		arg2.UIListLayout(Frame_2, Enum.FillDirection.Vertical, UDim.new(0, 0))
		return Frame_2
	end
	tbl_2.Generate = Generate
	local function Update(arg1_3) -- Line 28
	end
	tbl_2.Update = Update
	local function Discard(arg1_4) -- Line 29
		arg1_4.Instance:Destroy()
	end
	tbl_2.Discard = Discard
	arg1.WidgetConstructor("Separator", tbl_2)
	local tbl = {
		hasState = false;
		hasChildren = true;
		Args = {
			Width = 1;
		};
		Events = {};
	}
	local function Generate(arg1_5) -- Line 42
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local Frame_3 = Instance.new("Frame")
		Frame_3.Name = "Indent"
		Frame_3.BackgroundTransparency = 1
		Frame_3.BorderSizePixel = 0
		Frame_3.Size = UDim2.fromScale(1, 0)
		Frame_3.AutomaticSize = Enum.AutomaticSize.Y
		Frame_3.LayoutOrder = arg1_5.ZIndex
		arg2.UIListLayout(Frame_3, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
		arg2.UIPadding(Frame_3, Vector2.new(0, 0))
		return Frame_3
	end
	tbl.Generate = Generate
	local function Update(arg1_6) -- Line 56
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local var7
		if arg1_6.arguments.Width then
			var7 = arg1_6.arguments.Width
		else
			var7 = arg1._config.IndentSpacing
		end
		arg1_6.Instance.UIPadding.PaddingLeft = UDim.new(0, var7)
	end
	tbl.Update = Update
	local function Discard(arg1_7) -- Line 67
		arg1_7.Instance:Destroy()
	end
	tbl.Discard = Discard
	local function ChildAdded(arg1_8, arg2_2) -- Line 70
		return arg1_8.Instance
	end
	tbl.ChildAdded = ChildAdded
	arg1.WidgetConstructor("Indent", tbl)
	local tbl_3 = {
		hasState = false;
		hasChildren = true;
		Args = {
			Width = 1;
			VerticalAlignment = 2;
		};
		Events = {};
	}
	local function Generate(arg1_9) -- Line 84
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		local Frame = Instance.new("Frame")
		Frame.Name = "SameLine"
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.fromScale(1, 0)
		Frame.AutomaticSize = Enum.AutomaticSize.Y
		Frame.LayoutOrder = arg1_9.ZIndex
		arg2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, 0))
		return Frame
	end
	tbl_3.Generate = Generate
	local function Update(arg1_10) -- Line 97
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local UIListLayout = arg1_10.Instance.UIListLayout
		local var12
		if arg1_10.arguments.Width then
			var12 = arg1_10.arguments.Width
		else
			var12 = arg1._config.ItemSpacing.X
		end
		UIListLayout.Padding = UDim.new(0, var12)
		if arg1_10.arguments.VerticalAlignment then
			UIListLayout.VerticalAlignment = arg1_10.arguments.VerticalAlignment
		else
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		end
	end
	tbl_3.Update = Update
	local function Discard(arg1_11) -- Line 113
		arg1_11.Instance:Destroy()
	end
	tbl_3.Discard = Discard
	local function ChildAdded(arg1_12, arg2_3) -- Line 116
		return arg1_12.Instance
	end
	tbl_3.ChildAdded = ChildAdded
	arg1.WidgetConstructor("SameLine", tbl_3)
	arg1.WidgetConstructor("Group", {
		hasState = false;
		hasChildren = true;
		Args = {};
		Events = {};
		Generate = function(arg1_13) -- Line 127, Named "Generate"
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: arg1 (readonly)
			]]
			local Frame_4 = Instance.new("Frame")
			Frame_4.Name = "Group"
			Frame_4.AutomaticSize = Enum.AutomaticSize.XY
			Frame_4.Size = UDim2.fromOffset(0, 0)
			Frame_4.BackgroundTransparency = 1
			Frame_4.BorderSizePixel = 0
			Frame_4.LayoutOrder = arg1_13.ZIndex
			Frame_4.ClipsDescendants = false
			arg2.UIListLayout(Frame_4, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.X))
			return Frame_4
		end;
		Update = function(arg1_14) -- Line 141, Named "Update"
		end;
		Discard = function(arg1_15) -- Line 142, Named "Discard"
			arg1_15.Instance:Destroy()
		end;
		ChildAdded = function(arg1_16, arg2_4) -- Line 145, Named "ChildAdded"
			return arg1_16.Instance
		end;
	})
end