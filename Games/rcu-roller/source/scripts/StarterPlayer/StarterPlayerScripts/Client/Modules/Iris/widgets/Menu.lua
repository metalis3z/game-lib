-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:38
-- Luau version 6, Types version 3
-- Time taken: 0.013369 seconds

return function(arg1, arg2) -- Line 3
	local var2_upvw = false
	local var3_upvw
	local tbl_upvr = {}
	local function EmptyMenuStack_upvr(arg1_2) -- Line 8, Named "EmptyMenuStack"
		--[[ Upvalues[4]:
			[1]: tbl_upvr (readonly)
			[2]: arg1 (readonly)
			[3]: var2_upvw (read and write)
			[4]: var3_upvw (read and write)
		]]
		local var7
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var7 = arg1_2 + 1
			return var7
		end
		if not arg1_2 or not INLINED() then
			var7 = 1
		end
		for i = #tbl_upvr, var7, -1 do
			local var8 = tbl_upvr[i]
			var8.state.isOpened:set(false)
			var8.Instance.BackgroundColor3 = arg1._config.HeaderColor
			var8.Instance.BackgroundTransparency = 1
			table.remove(tbl_upvr, i)
		end
		var7 = #tbl_upvr
		if var7 == 0 then
			var7 = false
			var2_upvw = var7
			var7 = nil
			var3_upvw = var7
		end
	end
	local function UpdateChildContainerTransform_upvr(arg1_3) -- Line 25, Named "UpdateChildContainerTransform"
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var9
		if arg1_3.parentWidget.type ~= "Menu" then
			var9 = false
		else
			var9 = true
		end
		local Instance_2 = arg1_3.Instance
		local ChildContainer = arg1_3.ChildContainer
		ChildContainer.Size = UDim2.fromOffset(Instance_2.AbsoluteSize.X, 0)
		if ChildContainer.Parent == nil then
		else
			local var12 = Instance_2.AbsolutePosition - arg2.GuiOffset
			local AbsoluteSize = Instance_2.AbsoluteSize
			local AbsoluteSize_2 = ChildContainer.AbsoluteSize
			local X = var12.X
			local zero = Vector2.zero
			if var9 then
				if ChildContainer.Parent.AbsoluteSize.X < var12.X + AbsoluteSize_2.X then
					zero = Vector2.xAxis
				else
					X = var12.X + AbsoluteSize.X
				end
			end
			local var19
			if var19 < var12.Y + AbsoluteSize_2.Y then
				var19 = var12.Y
				local function INLINED_2() -- Internal function, doesn't exist in bytecode
					var19 = AbsoluteSize.Y
					return var19
				end
				if not var9 or not INLINED_2() then
					var19 = 0
				end
				zero += Vector2.yAxis
				-- KONSTANTWARNING: GOTO [100] #64
			end
			var19 = var12.Y
			if var9 then
			else
			end
			ChildContainer.Position = UDim2.fromOffset(X, var19 + arg1._config.PopupBorderSize + AbsoluteSize.Y)
			ChildContainer.AnchorPoint = zero
		end
	end
	arg2.registerEvent("InputBegan", function(arg1_4) -- Line 65
		--[[ Upvalues[6]:
			[1]: arg1 (readonly)
			[2]: var2_upvw (read and write)
			[3]: var3_upvw (read and write)
			[4]: arg2 (readonly)
			[5]: tbl_upvr (readonly)
			[6]: EmptyMenuStack_upvr (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 25 start (CF ANALYSIS FAILED)
		if not arg1._started then return end
		if arg1_4.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1_4.UserInputType ~= Enum.UserInputType.MouseButton2 then return end
		if var2_upvw == false then return end
		if var3_upvw == nil then return end
		-- KONSTANTERROR: [0] 1. Error Block 25 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [68] 50. Error Block 16 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [68] 50. Error Block 16 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [35] 26. Error Block 11 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [35] 26. Error Block 11 end (CF ANALYSIS FAILED)
	end)
	local tbl_3 = {
		hasState = false;
		hasChildren = true;
		Args = {};
		Events = {};
	}
	local function Generate(arg1_5) -- Line 107
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local Frame = Instance.new("Frame")
		Frame.Name = "MenuBar"
		Frame.Size = UDim2.fromScale(1, 0)
		Frame.AutomaticSize = Enum.AutomaticSize.Y
		Frame.BackgroundColor3 = arg1._config.MenubarBgColor
		Frame.BackgroundTransparency = arg1._config.MenubarBgTransparency
		Frame.BorderSizePixel = 0
		Frame.LayoutOrder = arg1_5.ZIndex
		Frame.ClipsDescendants = true
		arg2.UIPadding(Frame, Vector2.new(arg1._config.WindowPadding.X, 1))
		arg2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center
		arg2.applyFrameStyle(Frame, true, true)
		return Frame
	end
	tbl_3.Generate = Generate
	local function Update() -- Line 124
	end
	tbl_3.Update = Update
	local function ChildAdded(arg1_6) -- Line 127
		return arg1_6.Instance
	end
	tbl_3.ChildAdded = ChildAdded
	local function Discard(arg1_7) -- Line 130
		arg1_7.Instance:Destroy()
	end
	tbl_3.Discard = Discard
	arg1.WidgetConstructor("MenuBar", tbl_3)
	local tbl_2 = {
		hasState = true;
		hasChildren = true;
		Args = {
			Text = 1;
		};
		Events = {
			clicked = arg2.EVENTS.click(function(arg1_8) -- Line 143
				return arg1_8.Instance
			end);
			hovered = arg2.EVENTS.hover(function(arg1_9) -- Line 146
				return arg1_9.Instance
			end);
			opened = {
				Init = function(arg1_10) -- Line 150
				end;
				Get = function(arg1_11) -- Line 151
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var31
					if arg1_11.lastOpenedTick ~= arg1._cycleTick then
						var31 = false
					else
						var31 = true
					end
					return var31
				end;
			};
			closed = {
				Init = function(arg1_12) -- Line 156
				end;
				Get = function(arg1_13) -- Line 157
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var35
					if arg1_13.lastClosedTick ~= arg1._cycleTick then
						var35 = false
					else
						var35 = true
					end
					return var35
				end;
			};
		};
	}
	local function Generate(arg1_14) -- Line 162
		--[[ Upvalues[6]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
			[3]: tbl_upvr (readonly)
			[4]: var2_upvw (read and write)
			[5]: var3_upvw (read and write)
			[6]: EmptyMenuStack_upvr (readonly)
		]]
		arg1_14.ButtonColors = {
			ButtonColor = arg1._config.HeaderColor;
			ButtonTransparency = 1;
			ButtonHoveredColor = arg1._config.HeaderHoveredColor;
			ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency;
			ButtonActiveColor = arg1._config.HeaderHoveredColor;
			ButtonActiveTransparency = arg1._config.HeaderHoveredTransparency;
		}
		if arg1_14.parentWidget.type == "Menu" then
			local TextButton = Instance.new("TextButton")
			TextButton.Name = "Menu"
			TextButton.BackgroundColor3 = arg1._config.HeaderColor
			TextButton.BackgroundTransparency = 1
			TextButton.BorderSizePixel = 0
			TextButton.Size = UDim2.fromScale(1, 0)
			TextButton.Text = ""
			TextButton.AutomaticSize = Enum.AutomaticSize.Y
			TextButton.LayoutOrder = arg1_14.ZIndex
			TextButton.AutoButtonColor = false
			local any_UIPadding_result1_2 = arg2.UIPadding(TextButton, arg1._config.FramePadding)
			any_UIPadding_result1_2.PaddingTop -= UDim.new(0, 1)
			arg2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local TextLabel_5 = Instance.new("TextLabel")
			TextLabel_5.Name = "TextLabel"
			TextLabel_5.AnchorPoint = Vector2.new(0, 0)
			TextLabel_5.BackgroundTransparency = 1
			TextLabel_5.BorderSizePixel = 0
			TextLabel_5.AutomaticSize = Enum.AutomaticSize.XY
			arg2.applyTextStyle(TextLabel_5)
			TextLabel_5.Parent = TextButton
			local var40 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
			local var41 = var40 - math.round(var40 * 0.2) * 2
			local ImageLabel_2 = Instance.new("ImageLabel")
			ImageLabel_2.Name = "Icon"
			ImageLabel_2.Size = UDim2.fromOffset(var41, var41)
			ImageLabel_2.BackgroundTransparency = 1
			ImageLabel_2.BorderSizePixel = 0
			ImageLabel_2.ImageColor3 = arg1._config.TextColor
			ImageLabel_2.ImageTransparency = arg1._config.TextTransparency
			ImageLabel_2.Image = arg2.ICONS.RIGHT_POINTING_TRIANGLE
			ImageLabel_2.LayoutOrder = 1
			ImageLabel_2.Parent = TextButton
		else
			local TextButton_3 = Instance.new("TextButton")
			TextButton_3.Name = "Menu"
			TextButton_3.AutomaticSize = Enum.AutomaticSize.XY
			TextButton_3.Size = UDim2.fromScale(0, 0)
			TextButton_3.BackgroundColor3 = arg1._config.HeaderColor
			TextButton_3.BackgroundTransparency = 1
			TextButton_3.BorderSizePixel = 0
			TextButton_3.Text = ""
			TextButton_3.LayoutOrder = arg1_14.ZIndex
			TextButton_3.AutoButtonColor = false
			TextButton_3.ClipsDescendants = true
			arg2.applyTextStyle(TextButton_3)
			arg2.UIPadding(TextButton_3, Vector2.new(arg1._config.ItemSpacing.X, arg1._config.FramePadding.Y))
		end
		arg2.applyInteractionHighlights(arg1_14, TextButton_3, TextButton_3, arg1_14.ButtonColors)
		arg2.applyButtonClick(arg1_14, TextButton_3, function() -- Line 233
			--[[ Upvalues[4]:
				[1]: tbl_upvr (copied, readonly)
				[2]: arg1_14 (readonly)
				[3]: var2_upvw (copied, read and write)
				[4]: var3_upvw (copied, read and write)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local var45
			if #tbl_upvr <= 1 then
				var45 = not arg1_14.state.isOpened.value
			else
				var45 = true
			end
			arg1_14.state.isOpened:set(var45)
			var2_upvw = var45
			if not var45 or not arg1_14 then
			end
			var3_upvw = nil
			if #tbl_upvr <= 1 then
				if var45 then
					table.insert(tbl_upvr, arg1_14)
					return
				end
				table.remove(tbl_upvr)
			end
		end)
		arg2.applyMouseEnter(arg1_14, TextButton_3, function() -- Line 249
			--[[ Upvalues[5]:
				[1]: var2_upvw (copied, read and write)
				[2]: var3_upvw (copied, read and write)
				[3]: arg1_14 (readonly)
				[4]: tbl_upvr (copied, readonly)
				[5]: EmptyMenuStack_upvr (copied, readonly)
			]]
			if var2_upvw and var3_upvw and var3_upvw ~= arg1_14 then
				EmptyMenuStack_upvr(table.find(tbl_upvr, arg1_14.parentWidget))
				arg1_14.state.isOpened:set(true)
				var3_upvw = arg1_14
				var2_upvw = true
				table.insert(tbl_upvr, arg1_14)
			end
		end)
		local ScrollingFrame = Instance.new("ScrollingFrame")
		ScrollingFrame.Name = "MenuContainer"
		ScrollingFrame.BackgroundColor3 = arg1._config.PopupBgColor
		ScrollingFrame.BackgroundTransparency = arg1._config.PopupBgTransparency
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.Size = UDim2.fromOffset(0, 0)
		ScrollingFrame.AutomaticSize = Enum.AutomaticSize.XY
		ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		ScrollingFrame.ScrollBarImageTransparency = arg1._config.ScrollbarGrabTransparency
		ScrollingFrame.ScrollBarImageColor3 = arg1._config.ScrollbarGrabColor
		ScrollingFrame.ScrollBarThickness = arg1._config.ScrollbarSize
		ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0)
		ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		ScrollingFrame.ZIndex = 6
		ScrollingFrame.LayoutOrder = 6
		ScrollingFrame.ClipsDescendants = true
		arg2.UIStroke(ScrollingFrame, arg1._config.WindowBorderSize, arg1._config.BorderColor, arg1._config.BorderTransparency)
		arg2.UIPadding(ScrollingFrame, Vector2.new(2, arg1._config.WindowPadding.Y - arg1._config.ItemSpacing.Y))
		arg2.UIListLayout(ScrollingFrame, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top
		local _rootInstance = arg1._rootInstance
		if _rootInstance then
			_rootInstance = arg1._rootInstance:FindFirstChild("PopupScreenGui")
		end
		ScrollingFrame.Parent = _rootInstance
		arg1_14.ChildContainer = ScrollingFrame
		return TextButton_3
	end
	tbl_2.Generate = Generate
	local function Update(arg1_15) -- Line 299
		local var49
		if arg1_15.parentWidget.type == "Menu" then
			var49 = arg1_15.Instance.TextLabel
		else
			var49 = arg1_15.Instance
		end
		var49.Text = arg1_15.arguments.Text or "Menu"
	end
	tbl_2.Update = Update
	function tbl_2.ChildAdded(arg1_16, arg2_2) -- Line 309
		--[[ Upvalues[1]:
			[1]: UpdateChildContainerTransform_upvr (readonly)
		]]
		UpdateChildContainerTransform_upvr(arg1_16)
		return arg1_16.ChildContainer
	end
	function tbl_2.ChildDiscarded(arg1_17, arg2_3) -- Line 313
		--[[ Upvalues[1]:
			[1]: UpdateChildContainerTransform_upvr (readonly)
		]]
		UpdateChildContainerTransform_upvr(arg1_17)
	end
	local function GenerateState(arg1_18) -- Line 316
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_18.state.isOpened == nil then
			arg1_18.state.isOpened = arg1._widgetState(arg1_18, "isOpened", false)
		end
	end
	tbl_2.GenerateState = GenerateState
	local function UpdateState(arg1_19) -- Line 321
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: UpdateChildContainerTransform_upvr (readonly)
		]]
		local ChildContainer_2 = arg1_19.ChildContainer
		if arg1_19.state.isOpened.value then
			arg1_19.lastOpenedTick = arg1._cycleTick + 1
			arg1_19.ButtonColors.ButtonTransparency = arg1._config.HeaderTransparency
			ChildContainer_2.Visible = true
			UpdateChildContainerTransform_upvr(arg1_19)
		else
			arg1_19.lastClosedTick = arg1._cycleTick + 1
			arg1_19.ButtonColors.ButtonTransparency = 1
			ChildContainer_2.Visible = false
		end
	end
	tbl_2.UpdateState = UpdateState
	local function Discard(arg1_20) -- Line 336
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		arg1_20.Instance:Destroy()
		arg2.discardState(arg1_20)
	end
	tbl_2.Discard = Discard
	arg1.WidgetConstructor("Menu", tbl_2)
	local tbl = {
		hasState = false;
		hasChildren = false;
		Args = {
			Text = 1;
			KeyCode = 2;
			ModifierKey = 3;
		};
		Events = {
			clicked = arg2.EVENTS.click(function(arg1_21) -- Line 352
				return arg1_21.Instance
			end);
			hovered = arg2.EVENTS.hover(function(arg1_22) -- Line 355
				return arg1_22.Instance
			end);
		};
	}
	local function Generate(arg1_23) -- Line 359
		--[[ Upvalues[6]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
			[3]: EmptyMenuStack_upvr (readonly)
			[4]: var2_upvw (read and write)
			[5]: var3_upvw (read and write)
			[6]: tbl_upvr (readonly)
		]]
		local TextButton_2 = Instance.new("TextButton")
		TextButton_2.Name = "MenuItem"
		TextButton_2.BackgroundTransparency = 1
		TextButton_2.BorderSizePixel = 0
		TextButton_2.Size = UDim2.fromScale(1, 0)
		TextButton_2.Text = ""
		TextButton_2.AutomaticSize = Enum.AutomaticSize.Y
		TextButton_2.LayoutOrder = arg1_23.ZIndex
		TextButton_2.AutoButtonColor = false
		local any_UIPadding_result1_3 = arg2.UIPadding(TextButton_2, arg1._config.FramePadding)
		any_UIPadding_result1_3.PaddingTop -= UDim.new(0, 1)
		arg2.UIListLayout(TextButton_2, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X))
		arg2.applyInteractionHighlights(arg1_23, TextButton_2, TextButton_2, {
			ButtonColor = arg1._config.HeaderColor;
			ButtonTransparency = 1;
			ButtonHoveredColor = arg1._config.HeaderHoveredColor;
			ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency;
			ButtonActiveColor = arg1._config.HeaderHoveredColor;
			ButtonActiveTransparency = arg1._config.HeaderHoveredTransparency;
		})
		arg2.applyButtonClick(arg1_23, TextButton_2, function() -- Line 383
			--[[ Upvalues[1]:
				[1]: EmptyMenuStack_upvr (copied, readonly)
			]]
			EmptyMenuStack_upvr()
		end)
		arg2.applyMouseEnter(arg1_23, TextButton_2, function() -- Line 387
			--[[ Upvalues[5]:
				[1]: arg1_23 (readonly)
				[2]: var2_upvw (copied, read and write)
				[3]: var3_upvw (copied, read and write)
				[4]: tbl_upvr (copied, readonly)
				[5]: EmptyMenuStack_upvr (copied, readonly)
			]]
			local parentWidget_2 = arg1_23.parentWidget
			if var2_upvw and var3_upvw and var3_upvw ~= parentWidget_2 then
				EmptyMenuStack_upvr(table.find(tbl_upvr, parentWidget_2))
				var3_upvw = parentWidget_2
				var2_upvw = true
			end
		end)
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Name = "TextLabel"
		TextLabel.AnchorPoint = Vector2.new(0, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderSizePixel = 0
		TextLabel.AutomaticSize = Enum.AutomaticSize.XY
		arg2.applyTextStyle(TextLabel)
		TextLabel.Parent = TextButton_2
		local TextLabel_2 = Instance.new("TextLabel")
		TextLabel_2.Name = "Shortcut"
		TextLabel_2.AnchorPoint = Vector2.new(0, 0)
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.BorderSizePixel = 0
		TextLabel_2.LayoutOrder = 1
		TextLabel_2.AutomaticSize = Enum.AutomaticSize.XY
		arg2.applyTextStyle(TextLabel_2)
		TextLabel_2.Text = ""
		TextLabel_2.TextColor3 = arg1._config.TextDisabledColor
		TextLabel_2.TextTransparency = arg1._config.TextDisabledTransparency
		TextLabel_2.Parent = TextButton_2
		return TextButton_2
	end
	tbl.Generate = Generate
	local function Update(arg1_24) -- Line 427
		local Instance_3 = arg1_24.Instance
		local Shortcut_2 = Instance_3.Shortcut
		Instance_3.TextLabel.Text = arg1_24.arguments.Text
		if arg1_24.arguments.KeyCode then
			if arg1_24.arguments.ModifierKey then
				Shortcut_2.Text = arg1_24.arguments.ModifierKey.Name.." + "..arg1_24.arguments.KeyCode.Name
				return
			end
			Shortcut_2.Text = arg1_24.arguments.KeyCode.Name
		end
	end
	tbl.Update = Update
	local function Discard(arg1_25) -- Line 441
		arg1_25.Instance:Destroy()
	end
	tbl.Discard = Discard
	arg1.WidgetConstructor("MenuItem", tbl)
	local tbl_4 = {
		hasState = true;
		hasChildren = false;
		Args = {
			Text = 1;
			KeyCode = 2;
			ModifierKey = 3;
		};
		Events = {
			checked = {
				Init = function(arg1_26) -- Line 457
				end;
				Get = function(arg1_27) -- Line 458
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var72
					if arg1_27.lastCheckedTick ~= arg1._cycleTick then
						var72 = false
					else
						var72 = true
					end
					return var72
				end;
			};
			unchecked = {
				Init = function(arg1_28) -- Line 463
				end;
				Get = function(arg1_29) -- Line 464
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var76
					if arg1_29.lastUncheckedTick ~= arg1._cycleTick then
						var76 = false
					else
						var76 = true
					end
					return var76
				end;
			};
			hovered = arg2.EVENTS.hover(function(arg1_30) -- Line 468
				return arg1_30.Instance
			end);
		};
	}
	function tbl_4.Generate(arg1_31) -- Line 472
		--[[ Upvalues[6]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
			[3]: EmptyMenuStack_upvr (readonly)
			[4]: var2_upvw (read and write)
			[5]: var3_upvw (read and write)
			[6]: tbl_upvr (readonly)
		]]
		local TextButton_4 = Instance.new("TextButton")
		TextButton_4.Name = "MenuItem"
		TextButton_4.BackgroundTransparency = 1
		TextButton_4.BorderSizePixel = 0
		TextButton_4.Size = UDim2.fromScale(1, 0)
		TextButton_4.Text = ""
		TextButton_4.AutomaticSize = Enum.AutomaticSize.Y
		TextButton_4.LayoutOrder = arg1_31.ZIndex
		TextButton_4.AutoButtonColor = false
		local any_UIPadding_result1 = arg2.UIPadding(TextButton_4, arg1._config.FramePadding)
		any_UIPadding_result1.PaddingTop -= UDim.new(0, 1)
		arg2.UIListLayout(TextButton_4, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		arg2.applyInteractionHighlights(arg1_31, TextButton_4, TextButton_4, {
			ButtonColor = arg1._config.HeaderColor;
			ButtonTransparency = 1;
			ButtonHoveredColor = arg1._config.HeaderHoveredColor;
			ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency;
			ButtonActiveColor = arg1._config.HeaderHoveredColor;
			ButtonActiveTransparency = arg1._config.HeaderHoveredTransparency;
		})
		arg2.applyButtonClick(arg1_31, TextButton_4, function() -- Line 496
			--[[ Upvalues[2]:
				[1]: arg1_31 (readonly)
				[2]: EmptyMenuStack_upvr (copied, readonly)
			]]
			arg1_31.state.isChecked:set(not arg1_31.state.isChecked.value)
			EmptyMenuStack_upvr()
		end)
		arg2.applyMouseEnter(arg1_31, TextButton_4, function() -- Line 502
			--[[ Upvalues[5]:
				[1]: arg1_31 (readonly)
				[2]: var2_upvw (copied, read and write)
				[3]: var3_upvw (copied, read and write)
				[4]: tbl_upvr (copied, readonly)
				[5]: EmptyMenuStack_upvr (copied, readonly)
			]]
			local parentWidget = arg1_31.parentWidget
			if var2_upvw and var3_upvw and var3_upvw ~= parentWidget then
				EmptyMenuStack_upvr(table.find(tbl_upvr, parentWidget))
				var3_upvw = parentWidget
				var2_upvw = true
			end
		end)
		local TextLabel_3 = Instance.new("TextLabel")
		TextLabel_3.Name = "TextLabel"
		TextLabel_3.AnchorPoint = Vector2.new(0, 0)
		TextLabel_3.BackgroundTransparency = 1
		TextLabel_3.BorderSizePixel = 0
		TextLabel_3.AutomaticSize = Enum.AutomaticSize.XY
		arg2.applyTextStyle(TextLabel_3)
		TextLabel_3.Parent = TextButton_4
		local TextLabel_4 = Instance.new("TextLabel")
		TextLabel_4.Name = "Shortcut"
		TextLabel_4.AnchorPoint = Vector2.new(0, 0)
		TextLabel_4.BackgroundTransparency = 1
		TextLabel_4.BorderSizePixel = 0
		TextLabel_4.LayoutOrder = 1
		TextLabel_4.AutomaticSize = Enum.AutomaticSize.XY
		arg2.applyTextStyle(TextLabel_4)
		TextLabel_4.Text = ""
		TextLabel_4.TextColor3 = arg1._config.TextDisabledColor
		TextLabel_4.TextTransparency = arg1._config.TextDisabledTransparency
		TextLabel_4.Parent = TextButton_4
		local var86 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
		local var87 = var86 - math.round(var86 * 0.2) * 2
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.Name = "Icon"
		ImageLabel.Size = UDim2.fromOffset(var87, var87)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.BorderSizePixel = 0
		ImageLabel.ImageColor3 = arg1._config.TextColor
		ImageLabel.ImageTransparency = arg1._config.TextTransparency
		ImageLabel.Image = arg2.ICONS.CHECK_MARK
		ImageLabel.LayoutOrder = 2
		ImageLabel.Parent = TextButton_4
		return TextButton_4
	end
	function tbl_4.GenerateState(arg1_32) -- Line 558
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_32.state.isChecked == nil then
			arg1_32.state.isChecked = arg1._widgetState(arg1_32, "isChecked", false)
		end
	end
	function tbl_4.Update(arg1_33) -- Line 563
		local Instance = arg1_33.Instance
		local Shortcut = Instance.Shortcut
		Instance.TextLabel.Text = arg1_33.arguments.Text
		if arg1_33.arguments.KeyCode then
			if arg1_33.arguments.ModifierKey then
				Shortcut.Text = arg1_33.arguments.ModifierKey.Name.." + "..arg1_33.arguments.KeyCode.Name
				return
			end
			Shortcut.Text = arg1_33.arguments.KeyCode.Name
		end
	end
	function tbl_4.UpdateState(arg1_34) -- Line 577
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local Icon = arg1_34.Instance.Icon
		if arg1_34.state.isChecked.value then
			Icon.Image = arg2.ICONS.CHECK_MARK
			arg1_34.lastCheckedTick = arg1._cycleTick + 1
		else
			Icon.Image = ""
			arg1_34.lastUncheckedTick = arg1._cycleTick + 1
		end
	end
	function tbl_4.Discard(arg1_35) -- Line 589
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		arg1_35.Instance:Destroy()
		arg2.discardState(arg1_35)
	end
	arg1.WidgetConstructor("MenuToggle", tbl_4)
end