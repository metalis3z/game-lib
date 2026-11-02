-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:45
-- Luau version 6, Types version 3
-- Time taken: 0.017690 seconds

return function(arg1, arg2) -- Line 3
	local function relocateTooltips_upvr() -- Line 4, Named "relocateTooltips"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		if arg1._rootInstance == nil then
		else
			local PopupScreenGui = arg1._rootInstance:FindFirstChild("PopupScreenGui")
			local TooltipContainer = PopupScreenGui.TooltipContainer
			local any_findBestWindowPosForPopup_result1 = arg2.findBestWindowPosForPopup(arg2.getMouseLocation(), TooltipContainer.AbsoluteSize, arg1._config.DisplaySafeAreaPadding, PopupScreenGui.AbsoluteSize)
			TooltipContainer.Position = UDim2.fromOffset(any_findBestWindowPosForPopup_result1.X, any_findBestWindowPosForPopup_result1.Y)
		end
	end
	arg2.registerEvent("InputChanged", function() -- Line 15
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: relocateTooltips_upvr (readonly)
		]]
		if not arg1._started then
		else
			relocateTooltips_upvr()
		end
	end)
	local tbl_3 = {
		hasState = false;
		hasChildren = false;
		Args = {
			Text = 1;
		};
		Events = {};
	}
	local function Generate(arg1_2) -- Line 30
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		arg1_2.parentWidget = arg1._rootWidget
		local Frame_4 = Instance.new("Frame")
		Frame_4.Name = "Tooltip"
		Frame_4.Size = UDim2.new(arg1._config.ContentWidth, UDim.new(0, 0))
		Frame_4.AutomaticSize = Enum.AutomaticSize.Y
		Frame_4.BorderSizePixel = 0
		Frame_4.BackgroundTransparency = 1
		Frame_4.ZIndex = arg1_2.ZIndex + 1
		Frame_4.LayoutOrder = arg1_2.ZIndex + 1
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Name = "TooltipText"
		TextLabel.Size = UDim2.fromOffset(0, 0)
		TextLabel.AutomaticSize = Enum.AutomaticSize.XY
		TextLabel.BackgroundColor3 = arg1._config.PopupBgColor
		TextLabel.BackgroundTransparency = arg1._config.PopupBgTransparency
		TextLabel.BorderSizePixel = arg1._config.PopupBorderSize
		TextLabel.TextWrapped = arg1._config.TextWrapped
		arg2.applyTextStyle(TextLabel)
		arg2.UIStroke(TextLabel, arg1._config.WindowBorderSize, arg1._config.BorderActiveColor, arg1._config.BorderActiveTransparency)
		arg2.UIPadding(TextLabel, arg1._config.WindowPadding)
		if 0 < arg1._config.PopupRounding then
			arg2.UICorner(TextLabel, arg1._config.PopupRounding)
		end
		TextLabel.Parent = Frame_4
		return Frame_4
	end
	tbl_3.Generate = Generate
	local function Update(arg1_3) -- Line 62
		--[[ Upvalues[1]:
			[1]: relocateTooltips_upvr (readonly)
		]]
		if arg1_3.arguments.Text == nil then
			error("Iris.Text Text Argument is required", 5)
		end
		arg1_3.Instance.TooltipText.Text = arg1_3.arguments.Text
		relocateTooltips_upvr()
	end
	tbl_3.Update = Update
	local function Discard(arg1_4) -- Line 71
		arg1_4.Instance:Destroy()
	end
	tbl_3.Discard = Discard
	arg1.WidgetConstructor("Tooltip", tbl_3)
	local var10_upvw
	local var11_upvw = false
	local var12_upvw
	local var13_upvw
	local var14_upvw = false
	local var15_upvw = false
	local var16_upvw = false
	local Top_upvw = Enum.TopBottom.Top
	local Left_upvw = Enum.LeftRight.Left
	local var19_upvw
	local var20_upvw = false
	local tbl_2_upvr = {}
	local function quickSwapWindows_upvr() -- Line 95, Named "quickSwapWindows"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: tbl_2_upvr (readonly)
		]]
		local var26
		if arg1._config.UseScreenGUIs == false then
		else
			var26 = nil
			for _, v in tbl_2_upvr do
				if v.state.isOpened.value and not v.arguments.NoNav and v.Instance:IsA("ScreenGui") and v.Instance.DisplayOrder < 65535 then
					var26 = v
				end
			end
			if not var26 then return end
			if var26.state.isUncollapsed.value == false then
				var26.state.isUncollapsed:set(true)
			end
			arg1.SetFocusedWindow(var26)
		end
	end
	local function fitSizeToWindowBounds_upvr(arg1_5, arg2_2) -- Line 126, Named "fitSizeToWindowBounds"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local var27 = (arg1._config.TextSize + 2 * arg1._config.FramePadding.Y) * 2
		local var28 = arg2.getScreenSizeForWindow(arg1_5) - Vector2.new(arg1_5.state.position.value.X, arg1_5.state.position.value.Y) - Vector2.new(arg1._config.WindowBorderSize + arg1._config.DisplaySafeAreaPadding.X, arg1._config.WindowBorderSize + arg1._config.DisplaySafeAreaPadding.Y)
		return Vector2.new(math.clamp(arg2_2.X, var27, math.max(var28.X, var27)), math.clamp(arg2_2.Y, var27, math.max(var28.Y, var27)))
	end
	local function fitPositionToWindowBounds_upvr(arg1_6, arg2_3) -- Line 136, Named "fitPositionToWindowBounds"
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local Instance = arg1_6.Instance
		local any_getScreenSizeForWindow_result1 = arg2.getScreenSizeForWindow(arg1_6)
		local vector2 = Vector2.new(arg1._config.WindowBorderSize + arg1._config.DisplaySafeAreaPadding.X, arg1._config.WindowBorderSize + arg1._config.DisplaySafeAreaPadding.Y)
		return Vector2.new(math.clamp(arg2_3.X, vector2.X, math.max(vector2.X, any_getScreenSizeForWindow_result1.X - Instance.WindowButton.AbsoluteSize.X - vector2.X)), math.clamp(arg2_3.Y, vector2.Y, math.max(vector2.Y, any_getScreenSizeForWindow_result1.Y - Instance.WindowButton.AbsoluteSize.Y - vector2.Y)))
	end
	local var33_upvw = 0
	function arg1.SetFocusedWindow(arg1_7) -- Line 147
		--[[ Upvalues[6]:
			[1]: var19_upvw (read and write)
			[2]: var20_upvw (read and write)
			[3]: tbl_2_upvr (readonly)
			[4]: arg1 (readonly)
			[5]: var33_upvw (read and write)
			[6]: arg2 (readonly)
		]]
		if var19_upvw == arg1_7 then
		else
			if var20_upvw and var19_upvw ~= nil then
				if tbl_2_upvr[var19_upvw.ID] then
					local WindowButton_3 = var19_upvw.Instance.WindowButton
					local TitleBar = WindowButton_3.Content.TitleBar
					if var19_upvw.state.isUncollapsed.value then
						TitleBar.BackgroundColor3 = arg1._config.TitleBgColor
						TitleBar.BackgroundTransparency = arg1._config.TitleBgTransparency
					else
						TitleBar.BackgroundColor3 = arg1._config.TitleBgCollapsedColor
						TitleBar.BackgroundTransparency = arg1._config.TitleBgCollapsedTransparency
					end
					WindowButton_3.UIStroke.Color = arg1._config.BorderColor
				end
				var20_upvw = false
				var19_upvw = nil
			end
			if arg1_7 ~= nil then
				var20_upvw = true
				var19_upvw = arg1_7
				local Instance_3 = arg1_7.Instance
				local WindowButton_2 = Instance_3.WindowButton
				local TitleBar_2 = WindowButton_2.Content.TitleBar
				TitleBar_2.BackgroundColor3 = arg1._config.TitleBgActiveColor
				TitleBar_2.BackgroundTransparency = arg1._config.TitleBgActiveTransparency
				WindowButton_2.UIStroke.Color = arg1._config.BorderActiveColor
				var33_upvw += 1
				if arg1_7.usesScreenGUI then
					Instance_3.DisplayOrder = var33_upvw + arg1._config.DisplayOrderOffset
				else
					Instance_3.ZIndex = var33_upvw + arg1._config.DisplayOrderOffset
				end
				if arg1_7.state.isUncollapsed.value == false then
					arg1_7.state.isUncollapsed:set(true)
				end
				if arg2.GuiService.SelectedObject then
					if TitleBar_2.Visible then
						arg2.GuiService:Select(TitleBar_2)
						return
					end
					arg2.GuiService:Select(arg1_7.ChildContainer)
				end
			end
		end
	end
	arg2.registerEvent("InputBegan", function(arg1_8) -- Line 208
		--[[ Upvalues[12]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
			[3]: tbl_2_upvr (readonly)
			[4]: quickSwapWindows_upvr (readonly)
			[5]: var15_upvw (read and write)
			[6]: var16_upvw (read and write)
			[7]: var20_upvw (read and write)
			[8]: var19_upvw (read and write)
			[9]: Top_upvw (read and write)
			[10]: Left_upvw (read and write)
			[11]: var14_upvw (read and write)
			[12]: var13_upvw (read and write)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [4] 4. Error Block 2 start (CF ANALYSIS FAILED)
		do
			return
		end
		-- KONSTANTERROR: [4] 4. Error Block 2 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [5] 5. Error Block 3 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [5] 5. Error Block 3 end (CF ANALYSIS FAILED)
	end)
	arg2.registerEvent("TouchTapInWorld", function(arg1_9, arg2_4) -- Line 249
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if not arg1._started then
		elseif not arg2_4 then
			arg1.SetFocusedWindow(nil)
		end
	end)
	local var42_upvw
	arg2.registerEvent("InputChanged", function(arg1_10) -- Line 258
		--[[ Upvalues[12]:
			[1]: arg1 (readonly)
			[2]: var11_upvw (read and write)
			[3]: var10_upvw (read and write)
			[4]: arg2 (readonly)
			[5]: var12_upvw (read and write)
			[6]: fitPositionToWindowBounds_upvr (readonly)
			[7]: var14_upvw (read and write)
			[8]: var13_upvw (read and write)
			[9]: var42_upvw (read and write)
			[10]: Left_upvw (read and write)
			[11]: Top_upvw (read and write)
			[12]: fitSizeToWindowBounds_upvr (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [4] 4. Error Block 2 start (CF ANALYSIS FAILED)
		do
			return
		end
		-- KONSTANTERROR: [4] 4. Error Block 2 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [5] 5. Error Block 3 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [5] 5. Error Block 3 end (CF ANALYSIS FAILED)
	end)
	arg2.registerEvent("InputEnded", function(arg1_11, arg2_5) -- Line 312
		--[[ Upvalues[6]:
			[1]: arg1 (readonly)
			[2]: var11_upvw (read and write)
			[3]: var10_upvw (read and write)
			[4]: var14_upvw (read and write)
			[5]: var13_upvw (read and write)
			[6]: quickSwapWindows_upvr (readonly)
		]]
		if not arg1._started then
		else
			if arg1_11.UserInputType == Enum.UserInputType.MouseButton1 or arg1_11.UserInputType == Enum.UserInputType.Touch or var11_upvw and var10_upvw then
				local WindowButton_4 = var10_upvw.Instance.WindowButton
				var11_upvw = false
				var10_upvw.state.position:set(Vector2.new(WindowButton_4.Position.X.Offset, WindowButton_4.Position.Y.Offset))
			end
			if arg1_11.UserInputType == Enum.UserInputType.MouseButton1 or arg1_11.UserInputType == Enum.UserInputType.Touch then
				if var14_upvw and var13_upvw then
					var14_upvw = false
					var13_upvw.state.size:set(var13_upvw.Instance.WindowButton.AbsoluteSize)
				end
			end
			if arg1_11.KeyCode == Enum.KeyCode.ButtonX then
				quickSwapWindows_upvr()
			end
		end
	end)
	local tbl = {
		hasState = true;
		hasChildren = true;
		Args = {
			Title = 1;
			NoTitleBar = 2;
			NoBackground = 3;
			NoCollapse = 4;
			NoClose = 5;
			NoMove = 6;
			NoScrollbar = 7;
			NoResize = 8;
			NoNav = 9;
			NoMenu = 10;
		};
		Events = {
			closed = {
				Init = function(arg1_12) -- Line 351
				end;
				Get = function(arg1_13) -- Line 352
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var51
					if arg1_13.lastClosedTick ~= arg1._cycleTick then
						var51 = false
					else
						var51 = true
					end
					return var51
				end;
			};
			opened = {
				Init = function(arg1_14) -- Line 357
				end;
				Get = function(arg1_15) -- Line 358
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var55
					if arg1_15.lastOpenedTick ~= arg1._cycleTick then
						var55 = false
					else
						var55 = true
					end
					return var55
				end;
			};
			collapsed = {
				Init = function(arg1_16) -- Line 363
				end;
				Get = function(arg1_17) -- Line 364
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var59
					if arg1_17.lastCollapsedTick ~= arg1._cycleTick then
						var59 = false
					else
						var59 = true
					end
					return var59
				end;
			};
			uncollapsed = {
				Init = function(arg1_18) -- Line 369
				end;
				Get = function(arg1_19) -- Line 370
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var63
					if arg1_19.lastUncollapsedTick ~= arg1._cycleTick then
						var63 = false
					else
						var63 = true
					end
					return var63
				end;
			};
			hovered = arg2.EVENTS.hover(function(arg1_20) -- Line 374
				return arg1_20.Instance.WindowButton
			end);
		};
	}
	function tbl.Generate(arg1_21) -- Line 379
		--[[ Upvalues[14]:
			[1]: arg1 (readonly)
			[2]: tbl_2_upvr (readonly)
			[3]: arg2 (readonly)
			[4]: var10_upvw (read and write)
			[5]: var11_upvw (read and write)
			[6]: var12_upvw (read and write)
			[7]: var20_upvw (read and write)
			[8]: var19_upvw (read and write)
			[9]: var14_upvw (read and write)
			[10]: Top_upvw (read and write)
			[11]: Left_upvw (read and write)
			[12]: var13_upvw (read and write)
			[13]: var15_upvw (read and write)
			[14]: var16_upvw (read and write)
		]]
		arg1_21.parentWidget = arg1._rootWidget
		arg1_21.usesScreenGUI = arg1._config.UseScreenGUIs
		tbl_2_upvr[arg1_21.ID] = arg1_21
		if arg1_21.usesScreenGUI then
			local ScreenGui = Instance.new("ScreenGui")
			ScreenGui.ResetOnSpawn = false
			ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			ScreenGui.DisplayOrder = arg1._config.DisplayOrderOffset
			ScreenGui.IgnoreGuiInset = arg1._config.IgnoreGuiInset
		else
			local Frame_5 = Instance.new("Frame")
			Frame_5.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame_5.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame_5.Size = UDim2.new(1, 0, 1, 0)
			Frame_5.BackgroundTransparency = 1
			Frame_5.ZIndex = arg1._config.DisplayOrderOffset
		end
		Frame_5.Name = "Window"
		local TextButton = Instance.new("TextButton")
		TextButton.Name = "WindowButton"
		TextButton.Size = UDim2.fromOffset(0, 0)
		TextButton.BackgroundTransparency = 1
		TextButton.BorderSizePixel = 0
		TextButton.Text = ""
		TextButton.ClipsDescendants = false
		TextButton.AutoButtonColor = false
		TextButton.Selectable = false
		TextButton.SelectionImageObject = arg1.SelectionImageObject
		TextButton.SelectionGroup = true
		TextButton.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
		TextButton.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
		TextButton.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
		TextButton.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
		arg2.UIStroke(TextButton, arg1._config.WindowBorderSize, arg1._config.BorderColor, arg1._config.BorderTransparency)
		TextButton.Parent = Frame_5
		arg2.applyInputBegan(arg1_21, TextButton, function(arg1_22) -- Line 423
			--[[ Upvalues[6]:
				[1]: arg1_21 (readonly)
				[2]: arg1 (copied, readonly)
				[3]: var10_upvw (copied, read and write)
				[4]: var11_upvw (copied, read and write)
				[5]: var12_upvw (copied, read and write)
				[6]: arg2 (copied, readonly)
			]]
			if arg1_22.UserInputType == Enum.UserInputType.MouseMovement or arg1_22.UserInputType == Enum.UserInputType.Keyboard then
			else
				if arg1_21.state.isUncollapsed.value then
					arg1.SetFocusedWindow(arg1_21)
				end
				if not arg1_21.arguments.NoMove and arg1_22.UserInputType == Enum.UserInputType.MouseButton1 then
					var10_upvw = arg1_21
					var11_upvw = true
					var12_upvw = arg2.getMouseLocation() - arg1_21.state.position.value
				end
			end
		end)
		local Frame_3 = Instance.new("Frame")
		Frame_3.Name = "Content"
		Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame_3.Position = UDim2.fromScale(0.5, 0.5)
		Frame_3.Size = UDim2.fromScale(1, 1)
		Frame_3.BackgroundTransparency = 1
		Frame_3.ClipsDescendants = true
		Frame_3.Parent = TextButton
		local any_UIListLayout_result1 = arg2.UIListLayout(Frame_3, Enum.FillDirection.Vertical, UDim.new(0, 0))
		any_UIListLayout_result1.HorizontalAlignment = Enum.HorizontalAlignment.Center
		any_UIListLayout_result1.VerticalAlignment = Enum.VerticalAlignment.Top
		local ScrollingFrame_upvr = Instance.new("ScrollingFrame")
		ScrollingFrame_upvr.Name = "WindowContainer"
		ScrollingFrame_upvr.Size = UDim2.fromScale(1, 1)
		ScrollingFrame_upvr.Position = UDim2.fromOffset(0, 0)
		ScrollingFrame_upvr.BackgroundColor3 = arg1._config.WindowBgColor
		ScrollingFrame_upvr.BackgroundTransparency = arg1._config.WindowBgTransparency
		ScrollingFrame_upvr.BorderSizePixel = 0
		ScrollingFrame_upvr.AutomaticCanvasSize = Enum.AutomaticSize.Y
		ScrollingFrame_upvr.ScrollBarImageTransparency = arg1._config.ScrollbarGrabTransparency
		ScrollingFrame_upvr.ScrollBarImageColor3 = arg1._config.ScrollbarGrabColor
		ScrollingFrame_upvr.CanvasSize = UDim2.fromScale(0, 0)
		ScrollingFrame_upvr.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		ScrollingFrame_upvr.LayoutOrder = arg1_21.ZIndex + 65535
		ScrollingFrame_upvr.ClipsDescendants = true
		arg2.UIPadding(ScrollingFrame_upvr, arg1._config.WindowPadding)
		ScrollingFrame_upvr.Parent = Frame_3
		local UIFlexItem_2 = Instance.new("UIFlexItem")
		UIFlexItem_2.FlexMode = Enum.UIFlexMode.Fill
		UIFlexItem_2.ItemLineAlignment = Enum.ItemLineAlignment.End
		UIFlexItem_2.Parent = ScrollingFrame_upvr
		ScrollingFrame_upvr:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line 476
			--[[ Upvalues[2]:
				[1]: arg1_21 (readonly)
				[2]: ScrollingFrame_upvr (readonly)
			]]
			arg1_21.state.scrollDistance.value = ScrollingFrame_upvr.CanvasPosition.Y
		end)
		arg2.applyInputBegan(arg1_21, ScrollingFrame_upvr, function(arg1_23) -- Line 481
			--[[ Upvalues[2]:
				[1]: arg1_21 (readonly)
				[2]: arg1 (copied, readonly)
			]]
			if arg1_23.UserInputType == Enum.UserInputType.MouseMovement or arg1_23.UserInputType == Enum.UserInputType.Keyboard then
			elseif arg1_21.state.isUncollapsed.value then
				arg1.SetFocusedWindow(arg1_21)
			end
		end)
		local Frame_6 = Instance.new("Frame")
		Frame_6.Name = "TerminatingFrame"
		Frame_6.Size = UDim2.fromOffset(0, arg1._config.WindowPadding.Y + arg1._config.FramePadding.Y)
		Frame_6.BackgroundTransparency = 1
		Frame_6.BorderSizePixel = 0
		Frame_6.LayoutOrder = 2147483632
		arg2.UIListLayout(ScrollingFrame_upvr, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
		Frame_6.Parent = ScrollingFrame_upvr
		local Frame_2 = Instance.new("Frame")
		Frame_2.Name = "TitleBar"
		Frame_2.AutomaticSize = Enum.AutomaticSize.Y
		Frame_2.Size = UDim2.fromScale(1, 0)
		Frame_2.BorderSizePixel = 0
		Frame_2.ClipsDescendants = true
		Frame_2.Parent = Frame_3
		arg2.UIPadding(Frame_2, Vector2.xAxis * arg1._config.FramePadding.X)
		arg2.UIListLayout(Frame_2, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		arg2.applyInputBegan(arg1_21, Frame_2, function(arg1_24) -- Line 513
			--[[ Upvalues[4]:
				[1]: arg1_21 (readonly)
				[2]: var10_upvw (copied, read and write)
				[3]: var11_upvw (copied, read and write)
				[4]: var12_upvw (copied, read and write)
			]]
			if arg1_24.UserInputType == Enum.UserInputType.Touch and not arg1_21.arguments.NoMove then
				var10_upvw = arg1_21
				var11_upvw = true
				local Position = arg1_24.Position
				var12_upvw = Vector2.new(Position.X, Position.Y) - arg1_21.state.position.value
			end
		end)
		local var79 = arg1._config.TextSize + (arg1._config.FramePadding.Y - 1) * 2
		local TextButton_3 = Instance.new("TextButton")
		TextButton_3.Name = "CollapseButton"
		TextButton_3.AnchorPoint = Vector2.new(0, 0.5)
		TextButton_3.Size = UDim2.fromOffset(var79, var79)
		TextButton_3.Position = UDim2.new(0, 0, 0.5, 0)
		TextButton_3.AutomaticSize = Enum.AutomaticSize.None
		TextButton_3.BackgroundTransparency = 1
		TextButton_3.BorderSizePixel = 0
		TextButton_3.AutoButtonColor = false
		TextButton_3.Text = ""
		arg2.UICorner(TextButton_3)
		TextButton_3.Parent = Frame_2
		arg2.applyButtonClick(arg1_21, TextButton_3, function() -- Line 541
			--[[ Upvalues[1]:
				[1]: arg1_21 (readonly)
			]]
			arg1_21.state.isUncollapsed:set(not arg1_21.state.isUncollapsed.value)
		end)
		arg2.applyInteractionHighlights(arg1_21, TextButton_3, TextButton_3, {
			ButtonColor = arg1._config.ButtonColor;
			ButtonTransparency = 1;
			ButtonHoveredColor = arg1._config.ButtonHoveredColor;
			ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency;
			ButtonActiveColor = arg1._config.ButtonActiveColor;
			ButtonActiveTransparency = arg1._config.ButtonActiveTransparency;
		})
		local ImageLabel_2 = Instance.new("ImageLabel")
		ImageLabel_2.Name = "Arrow"
		ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel_2.Size = UDim2.fromOffset(math.floor(var79 * 0.7), math.floor(var79 * 0.7))
		ImageLabel_2.Position = UDim2.fromScale(0.5, 0.5)
		ImageLabel_2.BackgroundTransparency = 1
		ImageLabel_2.BorderSizePixel = 0
		ImageLabel_2.Image = arg2.ICONS.MULTIPLICATION_SIGN
		ImageLabel_2.ImageColor3 = arg1._config.TextColor
		ImageLabel_2.ImageTransparency = arg1._config.TextTransparency
		ImageLabel_2.Parent = TextButton_3
		local TextButton_2 = Instance.new("TextButton")
		TextButton_2.Name = "CloseButton"
		TextButton_2.AnchorPoint = Vector2.new(1, 0.5)
		TextButton_2.Size = UDim2.fromOffset(var79, var79)
		TextButton_2.Position = UDim2.new(1, 0, 0.5, 0)
		TextButton_2.AutomaticSize = Enum.AutomaticSize.None
		TextButton_2.BackgroundTransparency = 1
		TextButton_2.BorderSizePixel = 0
		TextButton_2.Text = ""
		TextButton_2.LayoutOrder = 2
		TextButton_2.AutoButtonColor = false
		arg2.UICorner(TextButton_2)
		arg2.applyButtonClick(arg1_21, TextButton_2, function() -- Line 580
			--[[ Upvalues[1]:
				[1]: arg1_21 (readonly)
			]]
			arg1_21.state.isOpened:set(false)
		end)
		arg2.applyInteractionHighlights(arg1_21, TextButton_2, TextButton_2, {
			ButtonColor = arg1._config.ButtonColor;
			ButtonTransparency = 1;
			ButtonHoveredColor = arg1._config.ButtonHoveredColor;
			ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency;
			ButtonActiveColor = arg1._config.ButtonActiveColor;
			ButtonActiveTransparency = arg1._config.ButtonActiveTransparency;
		})
		TextButton_2.Parent = Frame_2
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.Name = "Icon"
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.Size = UDim2.fromOffset(math.floor(var79 * 0.7), math.floor(var79 * 0.7))
		ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Image = arg2.ICONS.MULTIPLICATION_SIGN
		ImageLabel.ImageColor3 = arg1._config.TextColor
		ImageLabel.ImageTransparency = arg1._config.TextTransparency
		ImageLabel.Parent = TextButton_2
		local TextLabel_2 = Instance.new("TextLabel")
		TextLabel_2.Name = "Title"
		TextLabel_2.AutomaticSize = Enum.AutomaticSize.XY
		TextLabel_2.BorderSizePixel = 0
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.LayoutOrder = 1
		TextLabel_2.ClipsDescendants = true
		arg2.UIPadding(TextLabel_2, Vector2.yAxis * arg1._config.FramePadding.Y)
		arg2.applyTextStyle(TextLabel_2)
		TextLabel_2.TextXAlignment = Enum.TextXAlignment[arg1._config.WindowTitleAlign.Name]
		local UIFlexItem = Instance.new("UIFlexItem")
		UIFlexItem.FlexMode = Enum.UIFlexMode.Fill
		UIFlexItem.ItemLineAlignment = Enum.ItemLineAlignment.Center
		UIFlexItem.Parent = TextLabel_2
		TextLabel_2.Parent = Frame_2
		local var90 = arg1._config.TextSize + arg1._config.FramePadding.X
		local ImageButton = Instance.new("ImageButton")
		ImageButton.Name = "ResizeGrip"
		ImageButton.AnchorPoint = Vector2.new(1, 1)
		ImageButton.Size = UDim2.fromOffset(var90, var90)
		ImageButton.Position = UDim2.fromScale(1, 1)
		ImageButton.Rotation = 90
		ImageButton.AutoButtonColor = false
		ImageButton.BorderSizePixel = 0
		ImageButton.BackgroundTransparency = 1
		ImageButton.Image = arg2.ICONS.BOTTOM_RIGHT_CORNER
		ImageButton.ImageColor3 = arg1._config.ButtonColor
		ImageButton.ImageTransparency = arg1._config.ButtonTransparency
		ImageButton.Selectable = false
		ImageButton.ZIndex = 3
		ImageButton.Parent = TextButton
		arg2.applyImageInteractionHighlights(arg1_21, ImageButton, ImageButton, {
			ButtonColor = arg1._config.ButtonColor;
			ButtonTransparency = arg1._config.ButtonTransparency;
			ButtonHoveredColor = arg1._config.ButtonHoveredColor;
			ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency;
			ButtonActiveColor = arg1._config.ButtonActiveColor;
			ButtonActiveTransparency = arg1._config.ButtonActiveTransparency;
		})
		arg2.applyButtonDown(arg1_21, ImageButton, function() -- Line 656
			--[[ Upvalues[8]:
				[1]: var20_upvw (copied, read and write)
				[2]: var19_upvw (copied, read and write)
				[3]: arg1_21 (readonly)
				[4]: arg1 (copied, readonly)
				[5]: var14_upvw (copied, read and write)
				[6]: Top_upvw (copied, read and write)
				[7]: Left_upvw (copied, read and write)
				[8]: var13_upvw (copied, read and write)
			]]
			if not var20_upvw or var19_upvw ~= arg1_21 then
				arg1.SetFocusedWindow(arg1_21)
			end
			var14_upvw = true
			Top_upvw = Enum.TopBottom.Bottom
			Left_upvw = Enum.LeftRight.Right
			var13_upvw = arg1_21
		end)
		local Frame = Instance.new("Frame")
		Frame.Name = "ResizeBorder"
		Frame.Size = UDim2.new(1, arg1._config.WindowResizePadding.X * 2, 1, arg1._config.WindowResizePadding.Y * 2)
		Frame.Position = UDim2.fromOffset(-arg1._config.WindowResizePadding.X, -arg1._config.WindowResizePadding.Y)
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.Active = true
		Frame.Selectable = false
		Frame.ClipsDescendants = false
		Frame.Parent = TextButton
		arg2.applyMouseEnter(arg1_21, Frame, function() -- Line 678
			--[[ Upvalues[3]:
				[1]: var19_upvw (copied, read and write)
				[2]: arg1_21 (readonly)
				[3]: var15_upvw (copied, read and write)
			]]
			if var19_upvw == arg1_21 then
				var15_upvw = true
			end
		end)
		arg2.applyMouseLeave(arg1_21, Frame, function() -- Line 683
			--[[ Upvalues[3]:
				[1]: var19_upvw (copied, read and write)
				[2]: arg1_21 (readonly)
				[3]: var15_upvw (copied, read and write)
			]]
			if var19_upvw == arg1_21 then
				var15_upvw = false
			end
		end)
		arg2.applyMouseEnter(arg1_21, TextButton, function() -- Line 689
			--[[ Upvalues[3]:
				[1]: var19_upvw (copied, read and write)
				[2]: arg1_21 (readonly)
				[3]: var16_upvw (copied, read and write)
			]]
			if var19_upvw == arg1_21 then
				var16_upvw = true
			end
		end)
		arg2.applyMouseLeave(arg1_21, TextButton, function() -- Line 694
			--[[ Upvalues[3]:
				[1]: var19_upvw (copied, read and write)
				[2]: arg1_21 (readonly)
				[3]: var16_upvw (copied, read and write)
			]]
			if var19_upvw == arg1_21 then
				var16_upvw = false
			end
		end)
		arg1_21.ChildContainer = ScrollingFrame_upvr
		return Frame_5
	end
	function tbl.Update(arg1_25) -- Line 703
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local ChildContainer = arg1_25.ChildContainer
		local WindowButton = arg1_25.Instance.WindowButton
		local Content = WindowButton.Content
		local TitleBar_4 = Content.TitleBar
		local MenuBar_2 = Content:FindFirstChild("MenuBar")
		if arg1_25.arguments.NoResize ~= true then
			WindowButton.ResizeGrip.Visible = true
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			WindowButton.ResizeGrip.Visible = false
		end
		if arg1_25.arguments.NoScrollbar then
			ChildContainer.ScrollBarThickness = 0
		else
			ChildContainer.ScrollBarThickness = arg1._config.ScrollbarSize
		end
		if arg1_25.arguments.NoTitleBar then
			TitleBar_4.Visible = false
		else
			TitleBar_4.Visible = true
		end
		if MenuBar_2 then
			if arg1_25.arguments.NoMenu then
				MenuBar_2.Visible = false
			else
				MenuBar_2.Visible = true
			end
		end
		if arg1_25.arguments.NoBackground then
			ChildContainer.BackgroundTransparency = 1
		else
			ChildContainer.BackgroundTransparency = arg1._config.WindowBgTransparency
		end
		if arg1_25.arguments.NoCollapse then
			TitleBar_4.CollapseButton.Visible = false
		else
			TitleBar_4.CollapseButton.Visible = true
		end
		if arg1_25.arguments.NoClose then
			TitleBar_4.CloseButton.Visible = false
		else
			TitleBar_4.CloseButton.Visible = true
		end
		TitleBar_4.Title.Text = arg1_25.arguments.Title or ""
	end
	function tbl.Discard(arg1_26) -- Line 755
		--[[ Upvalues[8]:
			[1]: var19_upvw (read and write)
			[2]: var20_upvw (read and write)
			[3]: var10_upvw (read and write)
			[4]: var11_upvw (read and write)
			[5]: var13_upvw (read and write)
			[6]: var14_upvw (read and write)
			[7]: tbl_2_upvr (readonly)
			[8]: arg2 (readonly)
		]]
		if var19_upvw == arg1_26 then
			var19_upvw = nil
			var20_upvw = false
		end
		if var10_upvw == arg1_26 then
			var10_upvw = nil
			var11_upvw = false
		end
		if var13_upvw == arg1_26 then
			var13_upvw = nil
			var14_upvw = false
		end
		tbl_2_upvr[arg1_26.ID] = nil
		arg1_26.Instance:Destroy()
		arg2.discardState(arg1_26)
	end
	function tbl.ChildAdded(arg1_27, arg2_6) -- Line 772
		if arg2_6.type == "MenuBar" then
			local ChildContainer_2 = arg1_27.ChildContainer
			arg2_6.Instance.ZIndex = ChildContainer_2.ZIndex + 1
			arg2_6.Instance.LayoutOrder = ChildContainer_2.LayoutOrder - 1
			return arg1_27.Instance.WindowButton.Content
		end
		return arg1_27.ChildContainer
	end
	function tbl.UpdateState(arg1_28) -- Line 784
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local value_5 = arg1_28.state.size.value
		local value_3 = arg1_28.state.position.value
		local value_2 = arg1_28.state.isUncollapsed.value
		local value = arg1_28.state.isOpened.value
		local value_4_upvr = arg1_28.state.scrollDistance.value
		local Instance_2 = arg1_28.Instance
		local WindowButton_5 = Instance_2.WindowButton
		local Content_2 = WindowButton_5.Content
		local TitleBar_3 = Content_2.TitleBar
		local MenuBar = Content_2:FindFirstChild("MenuBar")
		WindowButton_5.Size = UDim2.fromOffset(value_5.X, value_5.Y)
		WindowButton_5.Position = UDim2.fromOffset(value_3.X, value_3.Y)
		if value then
			if arg1_28.usesScreenGUI then
				Instance_2.Enabled = true
				WindowButton_5.Visible = true
			else
				Instance_2.Visible = true
				WindowButton_5.Visible = true
			end
			arg1_28.lastOpenedTick = arg1._cycleTick + 1
		else
			if arg1_28.usesScreenGUI then
				Instance_2.Enabled = false
				WindowButton_5.Visible = false
			else
				Instance_2.Visible = false
				WindowButton_5.Visible = false
			end
			arg1_28.lastClosedTick = arg1._cycleTick + 1
		end
		if value_2 then
			TitleBar_3.CollapseButton.Arrow.Image = arg2.ICONS.DOWN_POINTING_TRIANGLE
			if MenuBar then
				MenuBar.Visible = not arg1_28.arguments.NoMenu
			end
			arg1_28.ChildContainer.Visible = true
			if arg1_28.arguments.NoResize ~= true then
				WindowButton_5.ResizeGrip.Visible = true
			end
			WindowButton_5.AutomaticSize = Enum.AutomaticSize.None
			arg1_28.lastUncollapsedTick = arg1._cycleTick + 1
		else
			TitleBar_3.CollapseButton.Arrow.Image = arg2.ICONS.RIGHT_POINTING_TRIANGLE
			if MenuBar then
				MenuBar.Visible = false
			end
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			arg1_28.ChildContainer.Visible = false
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			WindowButton_5.ResizeGrip.Visible = false
			WindowButton_5.Size = UDim2.fromOffset(value_5.X, TitleBar_3.AbsoluteSize.Y)
			arg1_28.lastCollapsedTick = arg1._cycleTick + 1
		end
		if value and value_2 then
			arg1.SetFocusedWindow(arg1_28)
		else
			TitleBar_3.BackgroundColor3 = arg1._config.TitleBgCollapsedColor
			TitleBar_3.BackgroundTransparency = arg1._config.TitleBgCollapsedTransparency
			WindowButton_5.UIStroke.Color = arg1._config.BorderColor
			arg1.SetFocusedWindow(nil)
		end
		if value_4_upvr and value_4_upvr ~= 0 then
			local var115_upvr = #arg1._postCycleCallbacks + 1
			local var117_upvr = arg1._cycleTick + 1
			local ChildContainer_3_upvr = arg1_28.ChildContainer
			arg1._postCycleCallbacks[var115_upvr] = function() -- Line 860
				--[[ Upvalues[6]:
					[1]: arg1 (copied, readonly)
					[2]: var117_upvr (readonly)
					[3]: arg1_28 (readonly)
					[4]: ChildContainer_3_upvr (readonly)
					[5]: value_4_upvr (readonly)
					[6]: var115_upvr (readonly)
				]]
				if var117_upvr <= arg1._cycleTick then
					if arg1_28.lastCycleTick ~= -1 then
						ChildContainer_3_upvr.CanvasPosition = Vector2.new(0, value_4_upvr)
					end
					arg1._postCycleCallbacks[var115_upvr] = nil
				end
			end
		end
	end
	function tbl.GenerateState(arg1_29) -- Line 870
		--[[ Upvalues[5]:
			[1]: arg1 (readonly)
			[2]: var20_upvw (read and write)
			[3]: var19_upvw (read and write)
			[4]: fitPositionToWindowBounds_upvr (readonly)
			[5]: fitSizeToWindowBounds_upvr (readonly)
		]]
		if arg1_29.state.size == nil then
			arg1_29.state.size = arg1._widgetState(arg1_29, "size", Vector2.new(400, 300))
		end
		if arg1_29.state.position == nil then
			local var119
			if var20_upvw and var19_upvw then
				var119 = var19_upvw.state.position.value + Vector2.new(15, 45)
			else
				var119 = Vector2.new(150, 350)
			end
			arg1_29.state.position = arg1._widgetState(arg1_29, "position", var119)
		end
		arg1_29.state.position.value = fitPositionToWindowBounds_upvr(arg1_29, arg1_29.state.position.value)
		arg1_29.state.size.value = fitSizeToWindowBounds_upvr(arg1_29, arg1_29.state.size.value)
		if arg1_29.state.isUncollapsed == nil then
			arg1_29.state.isUncollapsed = arg1._widgetState(arg1_29, "isUncollapsed", true)
		end
		if arg1_29.state.isOpened == nil then
			arg1_29.state.isOpened = arg1._widgetState(arg1_29, "isOpened", true)
		end
		if arg1_29.state.scrollDistance == nil then
			arg1_29.state.scrollDistance = arg1._widgetState(arg1_29, "scrollDistance", 0)
		end
	end
	arg1.WidgetConstructor("Window", tbl)
end