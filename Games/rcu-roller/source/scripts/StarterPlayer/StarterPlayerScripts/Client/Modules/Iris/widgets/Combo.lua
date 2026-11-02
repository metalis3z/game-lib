-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:33
-- Luau version 6, Types version 3
-- Time taken: 0.011957 seconds

return function(arg1, arg2) -- Line 3
	local tbl = {
		hasState = true;
		hasChildren = false;
		Args = {
			Text = 1;
			Index = 2;
			NoClick = 3;
		};
		Events = {
			selected = {
				Init = function(arg1_2) -- Line 15
				end;
				Get = function(arg1_3) -- Line 16
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var8
					if arg1_3.lastSelectedTick ~= arg1._cycleTick then
						var8 = false
					else
						var8 = true
					end
					return var8
				end;
			};
			unselected = {
				Init = function(arg1_4) -- Line 21
				end;
				Get = function(arg1_5) -- Line 22
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var12
					if arg1_5.lastUnselectedTick ~= arg1._cycleTick then
						var12 = false
					else
						var12 = true
					end
					return var12
				end;
			};
			active = {
				Init = function(arg1_6) -- Line 27
				end;
				Get = function(arg1_7) -- Line 28
					local var16
					if arg1_7.state.index.value ~= arg1_7.arguments.Index then
						var16 = false
					else
						var16 = true
					end
					return var16
				end;
			};
			clicked = arg2.EVENTS.click(function(arg1_8) -- Line 32
				return arg1_8.Instance.SelectableButton
			end);
			rightClicked = arg2.EVENTS.rightClick(function(arg1_9) -- Line 36
				return arg1_9.Instance.SelectableButton
			end);
			doubleClicked = arg2.EVENTS.doubleClick(function(arg1_10) -- Line 40
				return arg1_10.Instance.SelectableButton
			end);
			ctrlClicked = arg2.EVENTS.ctrlClick(function(arg1_11) -- Line 44
				return arg1_11.Instance.SelectableButton
			end);
			hovered = arg2.EVENTS.hover(function(arg1_12) -- Line 48
				return arg1_12.Instance.SelectableButton
			end);
		};
	}
	local function Generate(arg1_13) -- Line 53
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local Frame = Instance.new("Frame")
		Frame.Name = "Selectable"
		Frame.Size = UDim2.new(arg1._config.ItemWidth, UDim.new(0, arg1._config.TextSize + 2 * arg1._config.FramePadding.Y - arg1._config.ItemSpacing.Y))
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.ZIndex = 0
		Frame.LayoutOrder = arg1_13.ZIndex
		local TextButton_2 = Instance.new("TextButton")
		TextButton_2.Name = "SelectableButton"
		TextButton_2.Size = UDim2.new(1, 0, 0, arg1._config.TextSize + 2 * arg1._config.FramePadding.Y)
		TextButton_2.Position = UDim2.fromOffset(0, -bit32.rshift(arg1._config.ItemSpacing.Y, 1))
		TextButton_2.BackgroundColor3 = arg1._config.HeaderColor
		TextButton_2.ClipsDescendants = true
		arg2.applyFrameStyle(TextButton_2)
		arg2.applyTextStyle(TextButton_2)
		arg2.UISizeConstraint(TextButton_2, Vector2.xAxis)
		arg1_13.ButtonColors = {
			ButtonColor = arg1._config.HeaderColor;
			ButtonTransparency = 1;
			ButtonHoveredColor = arg1._config.HeaderHoveredColor;
			ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency;
			ButtonActiveColor = arg1._config.HeaderActiveColor;
			ButtonActiveTransparency = arg1._config.HeaderActiveTransparency;
		}
		arg2.applyInteractionHighlights(arg1_13, TextButton_2, TextButton_2, arg1_13.ButtonColors)
		arg2.applyButtonClick(arg1_13, TextButton_2, function() -- Line 84
			--[[ Upvalues[1]:
				[1]: arg1_13 (readonly)
			]]
			if arg1_13.arguments.NoClick ~= true then
				if type(arg1_13.state.index.value) == "boolean" then
					arg1_13.state.index:set(not arg1_13.state.index.value)
					return
				end
				arg1_13.state.index:set(arg1_13.arguments.Index)
			end
		end)
		TextButton_2.Parent = Frame
		return Frame
	end
	tbl.Generate = Generate
	local function Update(arg1_14) -- Line 98
		arg1_14.Instance.SelectableButton.Text = arg1_14.arguments.Text or "Selectable"
	end
	tbl.Update = Update
	local function Discard(arg1_15) -- Line 103
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		arg1_15.Instance:Destroy()
		arg2.discardState(arg1_15)
	end
	tbl.Discard = Discard
	local function GenerateState(arg1_16) -- Line 107
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_16.state.index == nil then
			if arg1_16.arguments.Index ~= nil then
				error("a shared state index is required for Selectables with an Index argument", 5)
			end
			arg1_16.state.index = arg1._widgetState(arg1_16, "index", false)
		end
	end
	tbl.GenerateState = GenerateState
	local function UpdateState(arg1_17) -- Line 115
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local SelectableButton = arg1_17.Instance.SelectableButton
		if arg1_17.state.index.value == (arg1_17.arguments.Index or true) then
			arg1_17.ButtonColors.ButtonTransparency = arg1._config.HeaderTransparency
			SelectableButton.BackgroundTransparency = arg1._config.HeaderTransparency
			arg1_17.lastSelectedTick = arg1._cycleTick + 1
		else
			arg1_17.ButtonColors.ButtonTransparency = 1
			SelectableButton.BackgroundTransparency = 1
			arg1_17.lastUnselectedTick = arg1._cycleTick + 1
		end
	end
	tbl.UpdateState = UpdateState
	arg1.WidgetConstructor("Selectable", tbl)
	local var27_upvw = false
	local var28_upvw = -1
	local var29_upvw
	local function UpdateChildContainerTransform_upvr(arg1_18) -- Line 134, Named "UpdateChildContainerTransform"
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local ChildContainer_2 = arg1_18.ChildContainer
		local PreviewContainer = arg1_18.Instance.PreviewContainer
		ChildContainer_2.Size = UDim2.fromOffset(PreviewContainer.AbsoluteSize.X, 0)
		local var32 = PreviewContainer.AbsolutePosition - arg2.GuiOffset
		local var33
		local zero = Vector2.zero
		if ChildContainer_2.Parent.AbsoluteSize.Y < var32.Y + ChildContainer_2.AbsoluteSize.Y then
			var33 = var32.Y - arg1._config.PopupBorderSize
			zero = Vector2.yAxis
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			var33 = var32.Y + PreviewContainer.AbsoluteSize.Y + arg1._config.PopupBorderSize
		end
		ChildContainer_2.AnchorPoint = zero
		ChildContainer_2.Position = UDim2.fromOffset(var32.X, var33)
	end
	arg2.registerEvent("InputBegan", function(arg1_19) -- Line 161
		--[[ Upvalues[5]:
			[1]: arg1 (readonly)
			[2]: var27_upvw (read and write)
			[3]: var29_upvw (read and write)
			[4]: var28_upvw (read and write)
			[5]: arg2 (readonly)
		]]
		if not arg1._started then
		else
			if arg1_19.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1_19.UserInputType ~= Enum.UserInputType.MouseButton2 and arg1_19.UserInputType ~= Enum.UserInputType.Touch then return end
			if var27_upvw == false or not var29_upvw then return end
			if var28_upvw == arg1._cycleTick then return end
			local any_getMouseLocation_result1 = arg2.getMouseLocation()
			local PreviewContainer_3 = var29_upvw.Instance.PreviewContainer
			local ChildContainer = var29_upvw.ChildContainer
			if arg2.isPosInsideRect(any_getMouseLocation_result1, PreviewContainer_3.AbsolutePosition - arg2.GuiOffset, PreviewContainer_3.AbsolutePosition - arg2.GuiOffset + PreviewContainer_3.AbsoluteSize) then return end
			if arg2.isPosInsideRect(any_getMouseLocation_result1, ChildContainer.AbsolutePosition - arg2.GuiOffset, ChildContainer.AbsolutePosition - arg2.GuiOffset + ChildContainer.AbsoluteSize) then return end
			var29_upvw.state.isOpened:set(false)
		end
	end)
	local tbl_2 = {
		hasState = true;
		hasChildren = true;
		Args = {
			Text = 1;
			NoButton = 2;
			NoPreview = 3;
		};
		Events = {
			opened = {
				Init = function(arg1_20) -- Line 205
				end;
				Get = function(arg1_21) -- Line 206
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var45
					if arg1_21.lastOpenedTick ~= arg1._cycleTick then
						var45 = false
					else
						var45 = true
					end
					return var45
				end;
			};
			closed = {
				Init = function(arg1_22) -- Line 211
				end;
				Get = function(arg1_23) -- Line 212
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var49
					if arg1_23.lastClosedTick ~= arg1._cycleTick then
						var49 = false
					else
						var49 = true
					end
					return var49
				end;
			};
			clicked = arg2.EVENTS.click(function(arg1_24) -- Line 216
				return arg1_24.Instance
			end);
			hovered = arg2.EVENTS.hover(function(arg1_25) -- Line 219
				return arg1_25.Instance
			end);
		};
	}
	function tbl_2.Generate(arg1_26) -- Line 223
		--[[ Upvalues[4]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
			[3]: var27_upvw (read and write)
			[4]: var29_upvw (read and write)
		]]
		local var52 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
		local Frame_2 = Instance.new("Frame")
		Frame_2.Name = "Combo"
		Frame_2.Size = UDim2.fromScale(1, 0)
		Frame_2.AutomaticSize = Enum.AutomaticSize.Y
		Frame_2.BackgroundTransparency = 1
		Frame_2.BorderSizePixel = 0
		Frame_2.LayoutOrder = arg1_26.ZIndex
		arg2.UIListLayout(Frame_2, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local TextButton = Instance.new("TextButton")
		TextButton.Name = "PreviewContainer"
		TextButton.Size = UDim2.new(arg1._config.ContentWidth, UDim.new(0, 0))
		TextButton.AutomaticSize = Enum.AutomaticSize.Y
		TextButton.BackgroundTransparency = 1
		TextButton.Text = ""
		TextButton.ZIndex = arg1_26.ZIndex + 2
		TextButton.AutoButtonColor = false
		arg2.applyFrameStyle(TextButton, true)
		arg2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, 0))
		arg2.UISizeConstraint(TextButton, Vector2.xAxis * (var52 + 1))
		TextButton.Parent = Frame_2
		local TextLabel_3 = Instance.new("TextLabel")
		TextLabel_3.Name = "PreviewLabel"
		TextLabel_3.Size = UDim2.new(UDim.new(1, 0), arg1._config.ContentHeight)
		TextLabel_3.AutomaticSize = Enum.AutomaticSize.Y
		TextLabel_3.BackgroundColor3 = arg1._config.FrameBgColor
		TextLabel_3.BackgroundTransparency = arg1._config.FrameBgTransparency
		TextLabel_3.BorderSizePixel = 0
		TextLabel_3.ClipsDescendants = true
		arg2.applyTextStyle(TextLabel_3)
		arg2.UIPadding(TextLabel_3, arg1._config.FramePadding)
		TextLabel_3.Parent = TextButton
		local TextLabel_2 = Instance.new("TextLabel")
		TextLabel_2.Name = "DropdownButton"
		TextLabel_2.Size = UDim2.new(0, var52, arg1._config.ContentHeight.Scale, math.max(arg1._config.ContentHeight.Offset, var52))
		TextLabel_2.BorderSizePixel = 0
		TextLabel_2.BackgroundColor3 = arg1._config.ButtonColor
		TextLabel_2.BackgroundTransparency = arg1._config.ButtonTransparency
		TextLabel_2.Text = ""
		local var57 = var52 - math.round(var52 * 0.2) * 2
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.Name = "Dropdown"
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.Size = UDim2.fromOffset(var57, var57)
		ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.BorderSizePixel = 0
		ImageLabel.ImageColor3 = arg1._config.TextColor
		ImageLabel.ImageTransparency = arg1._config.TextTransparency
		ImageLabel.Parent = TextLabel_2
		TextLabel_2.Parent = TextButton
		arg2.applyInteractionHighlightsWithMultiHighlightee(arg1_26, TextButton, {{TextLabel_3, {
			ButtonColor = arg1._config.FrameBgColor;
			ButtonTransparency = arg1._config.FrameBgTransparency;
			ButtonHoveredColor = arg1._config.FrameBgHoveredColor;
			ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency;
			ButtonActiveColor = arg1._config.FrameBgActiveColor;
			ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency;
		}}, {TextLabel_2, {
			ButtonColor = arg1._config.ButtonColor;
			ButtonTransparency = arg1._config.ButtonTransparency;
			ButtonHoveredColor = arg1._config.ButtonHoveredColor;
			ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency;
			ButtonActiveColor = arg1._config.ButtonHoveredColor;
			ButtonActiveTransparency = arg1._config.ButtonHoveredTransparency;
		}}})
		arg2.applyButtonClick(arg1_26, TextButton, function() -- Line 319
			--[[ Upvalues[3]:
				[1]: var27_upvw (copied, read and write)
				[2]: var29_upvw (copied, read and write)
				[3]: arg1_26 (readonly)
			]]
			if var27_upvw and var29_upvw ~= arg1_26 then
			else
				arg1_26.state.isOpened:set(not arg1_26.state.isOpened.value)
			end
		end)
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Name = "TextLabel"
		TextLabel.Size = UDim2.fromOffset(0, var52)
		TextLabel.AutomaticSize = Enum.AutomaticSize.X
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderSizePixel = 0
		arg2.applyTextStyle(TextLabel)
		TextLabel.Parent = Frame_2
		local ScrollingFrame = Instance.new("ScrollingFrame")
		ScrollingFrame.Name = "ComboContainer"
		ScrollingFrame.AutomaticSize = Enum.AutomaticSize.Y
		ScrollingFrame.BackgroundColor3 = arg1._config.PopupBgColor
		ScrollingFrame.BackgroundTransparency = arg1._config.PopupBgTransparency
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		ScrollingFrame.ScrollBarImageTransparency = arg1._config.ScrollbarGrabTransparency
		ScrollingFrame.ScrollBarImageColor3 = arg1._config.ScrollbarGrabColor
		ScrollingFrame.ScrollBarThickness = arg1._config.ScrollbarSize
		ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0)
		ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		ScrollingFrame.ClipsDescendants = true
		arg2.UIStroke(ScrollingFrame, arg1._config.WindowBorderSize, arg1._config.BorderColor, arg1._config.BorderTransparency)
		arg2.UIPadding(ScrollingFrame, Vector2.new(2, arg1._config.WindowPadding.Y))
		arg2.UISizeConstraint(ScrollingFrame, 100 * Vector2.xAxis)
		arg2.UIListLayout(ScrollingFrame, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
		local _rootInstance = arg1._rootInstance
		if _rootInstance then
			_rootInstance = arg1._rootInstance:WaitForChild("PopupScreenGui")
		end
		ScrollingFrame.Parent = _rootInstance
		arg1_26.ChildContainer = ScrollingFrame
		return Frame_2
	end
	function tbl_2.Update(arg1_27) -- Line 372
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local Instance = arg1_27.Instance
		local PreviewContainer_4 = Instance.PreviewContainer
		local PreviewLabel = PreviewContainer_4.PreviewLabel
		Instance.TextLabel.Text = arg1_27.arguments.Text or "Combo"
		if arg1_27.arguments.NoButton then
			PreviewContainer_4.DropdownButton.Visible = false
			PreviewLabel.Size = UDim2.new(UDim.new(1, 0), PreviewLabel.Size.Height)
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			PreviewContainer_4.DropdownButton.Visible = true
			PreviewLabel.Size = UDim2.new(UDim.new(1, -(arg1._config.TextSize + 2 * arg1._config.FramePadding.Y)), PreviewLabel.Size.Height)
		end
		if arg1_27.arguments.NoPreview then
			PreviewLabel.Visible = false
			PreviewContainer_4.Size = UDim2.new(0, 0, 0, 0)
			PreviewContainer_4.AutomaticSize = Enum.AutomaticSize.XY
		else
			PreviewLabel.Visible = true
			PreviewContainer_4.Size = UDim2.new(arg1._config.ContentWidth, arg1._config.ContentHeight)
			PreviewContainer_4.AutomaticSize = Enum.AutomaticSize.Y
		end
	end
	function tbl_2.ChildAdded(arg1_28, arg2_2) -- Line 400
		--[[ Upvalues[1]:
			[1]: UpdateChildContainerTransform_upvr (readonly)
		]]
		UpdateChildContainerTransform_upvr(arg1_28)
		return arg1_28.ChildContainer
	end
	function tbl_2.GenerateState(arg1_29) -- Line 405
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_29.state.index == nil then
			arg1_29.state.index = arg1._widgetState(arg1_29, "index", "No Selection")
		end
		arg1_29.state.index:onChange(function() -- Line 409
			--[[ Upvalues[1]:
				[1]: arg1_29 (readonly)
			]]
			if arg1_29.state.isOpened.value then
				arg1_29.state.isOpened:set(false)
			end
		end)
		if arg1_29.state.isOpened == nil then
			arg1_29.state.isOpened = arg1._widgetState(arg1_29, "isOpened", false)
		end
	end
	function tbl_2.UpdateState(arg1_30) -- Line 418
		--[[ Upvalues[6]:
			[1]: var27_upvw (read and write)
			[2]: var29_upvw (read and write)
			[3]: var28_upvw (read and write)
			[4]: arg1 (readonly)
			[5]: arg2 (readonly)
			[6]: UpdateChildContainerTransform_upvr (readonly)
		]]
		local PreviewContainer_2 = arg1_30.Instance.PreviewContainer
		if arg1_30.state.isOpened.value then
			var27_upvw = true
			var29_upvw = arg1_30
			var28_upvw = arg1._cycleTick
			arg1_30.lastOpenedTick = arg1._cycleTick + 1
			PreviewContainer_2.DropdownButton.Dropdown.Image = arg2.ICONS.RIGHT_POINTING_TRIANGLE
			arg1_30.ChildContainer.Visible = true
			UpdateChildContainerTransform_upvr(arg1_30)
		else
			if var27_upvw then
				var27_upvw = false
				var29_upvw = nil
				arg1_30.lastClosedTick = arg1._cycleTick + 1
			end
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			PreviewContainer_2.DropdownButton.Dropdown.Image = arg2.ICONS.DOWN_POINTING_TRIANGLE
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			arg1_30.ChildContainer.Visible = false
		end
		local index = arg1_30.state.index
		local value = index.value
		if typeof(value) == "EnumItem" then
			index = value.Name
		else
			index = tostring(value)
		end
		PreviewContainer_2.PreviewLabel.Text = index
	end
	function tbl_2.Discard(arg1_31) -- Line 450
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		arg1_31.Instance:Destroy()
		arg2.discardState(arg1_31)
	end
	arg1.WidgetConstructor("Combo", tbl_2)
end