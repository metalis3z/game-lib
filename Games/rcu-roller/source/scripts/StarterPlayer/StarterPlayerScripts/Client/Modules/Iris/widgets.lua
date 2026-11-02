-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:29
-- Luau version 6, Types version 3
-- Time taken: 0.013916 seconds

local tbl_upvr = {}
return function(arg1) -- Line 5
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	tbl_upvr.GuiService = game:GetService("GuiService")
	tbl_upvr.RunService = game:GetService("RunService")
	tbl_upvr.UserInputService = game:GetService("UserInputService")
	tbl_upvr.ContextActionService = game:GetService("ContextActionService")
	tbl_upvr.TextService = game:GetService("TextService")
	tbl_upvr.ICONS = {
		RIGHT_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_right.png";
		DOWN_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_down.png";
		MULTIPLICATION_SIGN = "rbxasset://textures/AnimationEditor/icon_close.png";
		BOTTOM_RIGHT_CORNER = "rbxasset://textures/ui/InspectMenu/gr-item-selector-triangle.png";
		CHECK_MARK = "rbxasset://textures/AnimationEditor/icon_checkmark.png";
		ALPHA_BACKGROUND_TEXTURE = "rbxasset://textures/meshPartFallback.png";
		UNKNOWN_TEXTURE = "rbxasset://textures/ui/GuiImagePlaceholder.png";
	}
	tbl_upvr.IS_STUDIO = tbl_upvr.RunService:IsStudio()
	function tbl_upvr.getTime() -- Line 23
		--[[ Upvalues[1]:
			[1]: tbl_upvr (copied, readonly)
		]]
		if tbl_upvr.IS_STUDIO then
			return os.clock()
		end
		return time()
	end
	local zero = Vector2.zero
	tbl_upvr.GuiOffset = zero
	if arg1._config.IgnoreGuiInset then
		zero = Vector2.zero
	else
		zero = tbl_upvr.GuiService:GetGuiInset()
	end
	tbl_upvr.MouseOffset = zero
	local any_Once_result1_upvr = tbl_upvr.GuiService:GetPropertyChangedSignal("TopbarInset"):Once(function() -- Line 38
		--[[ Upvalues[2]:
			[1]: tbl_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		local var6
		if arg1._config.IgnoreGuiInset then
			var6 = Vector2.zero
		else
			var6 = tbl_upvr.GuiService:GetGuiInset()
		end
		tbl_upvr.MouseOffset = var6
	end)
	task.delay(3, function() -- Line 42
		--[[ Upvalues[1]:
			[1]: any_Once_result1_upvr (readonly)
		]]
		any_Once_result1_upvr:Disconnect()
	end)
	function tbl_upvr.getMouseLocation() -- Line 46
		--[[ Upvalues[1]:
			[1]: tbl_upvr (copied, readonly)
		]]
		return tbl_upvr.UserInputService:GetMouseLocation() - tbl_upvr.MouseOffset
	end
	function tbl_upvr.isPosInsideRect(arg1_2, arg2, arg3) -- Line 50
		local var11 = false
		if arg2.X < arg1_2.X then
			var11 = false
			if arg1_2.X < arg3.X then
				var11 = false
				if arg2.Y < arg1_2.Y then
					if arg1_2.Y >= arg3.Y then
						var11 = false
					else
						var11 = true
					end
				end
			end
		end
		return var11
	end
	function tbl_upvr.findBestWindowPosForPopup(arg1_3, arg2, arg3, arg4) -- Line 54
		local var12
		if arg4.X < arg1_3.X + arg2.X + 20 then
			if arg4.Y < var12.Y + arg2.Y + 20 then
				var12 += Vector2.new(0, -(20 + arg2.Y))
			else
				var12 += Vector2.new(0, 20)
			end
		else
			var12 += Vector2.new(20, 0)
		end
		return Vector2.new(math.max(math.min(var12.X + arg2.X, arg4.X) - arg2.X, arg3.X), math.max(math.min(var12.Y + arg2.Y, arg4.Y) - arg2.Y, arg3.Y))
	end
	function tbl_upvr.getScreenSizeForWindow(arg1_4) -- Line 74
		if arg1_4.Instance:IsA("GuiBase2d") then
			return arg1_4.Instance.AbsoluteSize
		end
		local Parent = arg1_4.Instance.Parent
		if Parent:IsA("GuiBase2d") then
			return Parent.AbsoluteSize
		end
		if Parent.Parent:IsA("GuiBase2d") then
			return Parent.AbsoluteSize
		end
		return workspace.CurrentCamera.ViewportSize
	end
	function tbl_upvr.extend(arg1_5, arg2) -- Line 91
		local clone = table.clone(arg1_5)
		for i, v in arg2 do
			clone[i] = v
		end
		return clone
	end
	function tbl_upvr.UIPadding(arg1_6, arg2) -- Line 99
		local UIPadding_2 = Instance.new("UIPadding")
		UIPadding_2.PaddingLeft = UDim.new(0, arg2.X)
		UIPadding_2.PaddingRight = UDim.new(0, arg2.X)
		UIPadding_2.PaddingTop = UDim.new(0, arg2.Y)
		UIPadding_2.PaddingBottom = UDim.new(0, arg2.Y)
		UIPadding_2.Parent = arg1_6
		return UIPadding_2
	end
	function tbl_upvr.UIListLayout(arg1_7, arg2, arg3) -- Line 109
		local UIListLayout_2 = Instance.new("UIListLayout")
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = arg3
		UIListLayout_2.FillDirection = arg2
		UIListLayout_2.Parent = arg1_7
		return UIListLayout_2
	end
	function tbl_upvr.UIStroke(arg1_8, arg2, arg3, arg4) -- Line 118
		local UIStroke_2 = Instance.new("UIStroke")
		UIStroke_2.Thickness = arg2
		UIStroke_2.Color = arg3
		UIStroke_2.Transparency = arg4
		UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke_2.LineJoinMode = Enum.LineJoinMode.Round
		UIStroke_2.Parent = arg1_8
		return UIStroke_2
	end
	function tbl_upvr.UICorner(arg1_9, arg2) -- Line 129
		local UICorner_2 = Instance.new("UICorner")
		local var23
		if arg2 then
			var23 = 0
		else
			var23 = 1
		end
		UICorner_2.CornerRadius = UDim.new(var23, arg2 or 0)
		UICorner_2.Parent = arg1_9
		return UICorner_2
	end
	function tbl_upvr.UISizeConstraint(arg1_10, arg2, arg3) -- Line 136
		local UISizeConstraint_2 = Instance.new("UISizeConstraint")
		local var25 = arg2
		if not var25 then
			var25 = UISizeConstraint_2.MinSize
		end
		UISizeConstraint_2.MinSize = var25
		var25 = arg3
		local var26 = var25
		if not var26 then
			var26 = UISizeConstraint_2.MaxSize
		end
		UISizeConstraint_2.MaxSize = var26
		UISizeConstraint_2.Parent = arg1_10
		return UISizeConstraint_2
	end
	function tbl_upvr.UIReference(arg1_11, arg2, arg3) -- Line 144
		local ObjectValue = Instance.new("ObjectValue")
		ObjectValue.Name = arg3
		ObjectValue.Value = arg2
		ObjectValue.Parent = arg1_11
		return ObjectValue
	end
	local GetTextBoundsParams_upvr = Instance.new("GetTextBoundsParams")
	GetTextBoundsParams_upvr.Font = arg1._config.TextFont
	GetTextBoundsParams_upvr.Size = arg1._config.TextSize
	GetTextBoundsParams_upvr.Width = math.huge
	function tbl_upvr.calculateTextSize(arg1_12, arg2) -- Line 159
		--[[ Upvalues[2]:
			[1]: GetTextBoundsParams_upvr (readonly)
			[2]: tbl_upvr (copied, readonly)
		]]
		if arg2 then
			GetTextBoundsParams_upvr.Width = arg2
		end
		GetTextBoundsParams_upvr.Text = arg1_12
		if arg2 then
			GetTextBoundsParams_upvr.Width = math.huge
		end
		return tbl_upvr.TextService:GetTextBoundsAsync(GetTextBoundsParams_upvr)
	end
	function tbl_upvr.applyTextStyle(arg1_13) -- Line 174
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1_13.FontFace = arg1._config.TextFont
		arg1_13.TextSize = arg1._config.TextSize
		arg1_13.TextColor3 = arg1._config.TextColor
		arg1_13.TextTransparency = arg1._config.TextTransparency
		arg1_13.TextXAlignment = Enum.TextXAlignment.Left
		arg1_13.RichText = arg1._config.RichText
		arg1_13.TextWrapped = arg1._config.TextWrapped
		arg1_13.AutoLocalize = false
	end
	function tbl_upvr.applyInteractionHighlights(arg1_14, arg2, arg3, arg4) -- Line 186
		--[[ Upvalues[2]:
			[1]: tbl_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		local var29_upvw = false
		tbl_upvr.applyMouseEnter(arg1_14, arg2, function() -- Line 188
			--[[ Upvalues[3]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
				[3]: var29_upvw (read and write)
			]]
			arg3.BackgroundColor3 = arg4.ButtonHoveredColor
			arg3.BackgroundTransparency = arg4.ButtonHoveredTransparency
			var29_upvw = false
		end)
		tbl_upvr.applyMouseLeave(arg1_14, arg2, function() -- Line 195
			--[[ Upvalues[3]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
				[3]: var29_upvw (read and write)
			]]
			arg3.BackgroundColor3 = arg4.ButtonColor
			arg3.BackgroundTransparency = arg4.ButtonTransparency
			var29_upvw = true
		end)
		tbl_upvr.applyInputBegan(arg1_14, arg2, function(arg1_15) -- Line 202
			--[[ Upvalues[2]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
			]]
			if arg1_15.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1_15.UserInputType ~= Enum.UserInputType.Gamepad1 then
			else
				arg3.BackgroundColor3 = arg4.ButtonActiveColor
				arg3.BackgroundTransparency = arg4.ButtonActiveTransparency
			end
		end)
		tbl_upvr.applyInputEnded(arg1_14, arg2, function(arg1_16) -- Line 210
			--[[ Upvalues[3]:
				[1]: var29_upvw (read and write)
				[2]: arg3 (readonly)
				[3]: arg4 (readonly)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 4. Error Block 2 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 4. Error Block 2 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [12] 7. Error Block 17 start (CF ANALYSIS FAILED)
			if var29_upvw then
				-- KONSTANTERROR: [14] 9. Error Block 5 start (CF ANALYSIS FAILED)
				do
					return
				end
				-- KONSTANTERROR: [14] 9. Error Block 5 end (CF ANALYSIS FAILED)
			end
			if arg1_16.UserInputType == Enum.UserInputType.MouseButton1 then
				arg3.BackgroundColor3 = arg4.ButtonHoveredColor
				arg3.BackgroundTransparency = arg4.ButtonHoveredTransparency
			end
			if arg1_16.UserInputType == Enum.UserInputType.Gamepad1 then
				arg3.BackgroundColor3 = arg4.ButtonColor
				arg3.BackgroundTransparency = arg4.ButtonTransparency
			end
			-- KONSTANTERROR: [12] 7. Error Block 17 end (CF ANALYSIS FAILED)
		end)
		arg2.SelectionImageObject = arg1.SelectionImageObject
	end
	function tbl_upvr.applyInteractionHighlightsWithMultiHighlightee(arg1_17, arg2, arg3) -- Line 227
		--[[ Upvalues[2]:
			[1]: tbl_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		local var34_upvw = false
		tbl_upvr.applyMouseEnter(arg1_17, arg2, function() -- Line 229
			--[[ Upvalues[2]:
				[1]: arg3 (readonly)
				[2]: var34_upvw (read and write)
			]]
			for _, v_2 in arg3 do
				v_2[1].BackgroundColor3 = v_2[2].ButtonHoveredColor
				v_2[1].BackgroundTransparency = v_2[2].ButtonHoveredTransparency
				var34_upvw = false
			end
		end)
		tbl_upvr.applyMouseLeave(arg1_17, arg2, function() -- Line 238
			--[[ Upvalues[2]:
				[1]: arg3 (readonly)
				[2]: var34_upvw (read and write)
			]]
			for _, v_3 in arg3 do
				v_3[1].BackgroundColor3 = v_3[2].ButtonColor
				v_3[1].BackgroundTransparency = v_3[2].ButtonTransparency
				var34_upvw = true
			end
		end)
		tbl_upvr.applyInputBegan(arg1_17, arg2, function(arg1_18) -- Line 247
			--[[ Upvalues[1]:
				[1]: arg3 (readonly)
			]]
			if arg1_18.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1_18.UserInputType ~= Enum.UserInputType.Gamepad1 then
			else
				for _, var43 in arg3 do
					var43[1].BackgroundColor3 = var43[2].ButtonActiveColor
					var43[1].BackgroundTransparency = var43[2].ButtonActiveTransparency
				end
			end
		end)
		tbl_upvr.applyInputEnded(arg1_17, arg2, function(arg1_19) -- Line 257
			--[[ Upvalues[2]:
				[1]: var34_upvw (read and write)
				[2]: arg3 (readonly)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 4. Error Block 2 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 4. Error Block 2 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [12] 7. Error Block 19 start (CF ANALYSIS FAILED)
			if var34_upvw then
				-- KONSTANTERROR: [14] 9. Error Block 5 start (CF ANALYSIS FAILED)
				do
					return
				end
				-- KONSTANTERROR: [14] 9. Error Block 5 end (CF ANALYSIS FAILED)
			end
			for _, v_4 in arg3 do
				if arg1_19.UserInputType == Enum.UserInputType.MouseButton1 then
					v_4[1].BackgroundColor3 = v_4[2].ButtonHoveredColor
					v_4[1].BackgroundTransparency = v_4[2].ButtonHoveredTransparency
				end
				if arg1_19.UserInputType == Enum.UserInputType.Gamepad1 then
					v_4[1].BackgroundColor3 = v_4[2].ButtonColor
					v_4[1].BackgroundTransparency = v_4[2].ButtonTransparency
				end
			end
			-- KONSTANTERROR: [12] 7. Error Block 19 end (CF ANALYSIS FAILED)
		end)
		arg2.SelectionImageObject = arg1.SelectionImageObject
	end
	function tbl_upvr.applyImageInteractionHighlights(arg1_20, arg2, arg3, arg4) -- Line 276
		--[[ Upvalues[2]:
			[1]: tbl_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		local var47_upvw = false
		tbl_upvr.applyMouseEnter(arg1_20, arg2, function() -- Line 278
			--[[ Upvalues[3]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
				[3]: var47_upvw (read and write)
			]]
			arg3.ImageColor3 = arg4.ButtonHoveredColor
			arg3.ImageTransparency = arg4.ButtonHoveredTransparency
			var47_upvw = false
		end)
		tbl_upvr.applyMouseLeave(arg1_20, arg2, function() -- Line 285
			--[[ Upvalues[3]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
				[3]: var47_upvw (read and write)
			]]
			arg3.ImageColor3 = arg4.ButtonColor
			arg3.ImageTransparency = arg4.ButtonTransparency
			var47_upvw = true
		end)
		tbl_upvr.applyInputBegan(arg1_20, arg2, function(arg1_21) -- Line 292
			--[[ Upvalues[2]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
			]]
			if arg1_21.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1_21.UserInputType ~= Enum.UserInputType.Gamepad1 then
			else
				arg3.ImageColor3 = arg4.ButtonActiveColor
				arg3.ImageTransparency = arg4.ButtonActiveTransparency
			end
		end)
		tbl_upvr.applyInputEnded(arg1_20, arg2, function(arg1_22) -- Line 300
			--[[ Upvalues[3]:
				[1]: var47_upvw (read and write)
				[2]: arg3 (readonly)
				[3]: arg4 (readonly)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 4. Error Block 2 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 4. Error Block 2 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [12] 7. Error Block 17 start (CF ANALYSIS FAILED)
			if var47_upvw then
				-- KONSTANTERROR: [14] 9. Error Block 5 start (CF ANALYSIS FAILED)
				do
					return
				end
				-- KONSTANTERROR: [14] 9. Error Block 5 end (CF ANALYSIS FAILED)
			end
			if arg1_22.UserInputType == Enum.UserInputType.MouseButton1 then
				arg3.ImageColor3 = arg4.ButtonHoveredColor
				arg3.ImageTransparency = arg4.ButtonHoveredTransparency
			end
			if arg1_22.UserInputType == Enum.UserInputType.Gamepad1 then
				arg3.ImageColor3 = arg4.ButtonColor
				arg3.ImageTransparency = arg4.ButtonTransparency
			end
			-- KONSTANTERROR: [12] 7. Error Block 17 end (CF ANALYSIS FAILED)
		end)
		arg2.SelectionImageObject = arg1.SelectionImageObject
	end
	function tbl_upvr.applyTextInteractionHighlights(arg1_23, arg2, arg3, arg4) -- Line 317
		--[[ Upvalues[2]:
			[1]: tbl_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		local var52_upvw = false
		tbl_upvr.applyMouseEnter(arg1_23, arg2, function() -- Line 319
			--[[ Upvalues[3]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
				[3]: var52_upvw (read and write)
			]]
			arg3.TextColor3 = arg4.ButtonHoveredColor
			arg3.TextTransparency = arg4.ButtonHoveredTransparency
			var52_upvw = false
		end)
		tbl_upvr.applyMouseLeave(arg1_23, arg2, function() -- Line 326
			--[[ Upvalues[3]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
				[3]: var52_upvw (read and write)
			]]
			arg3.TextColor3 = arg4.ButtonColor
			arg3.TextTransparency = arg4.ButtonTransparency
			var52_upvw = true
		end)
		tbl_upvr.applyInputBegan(arg1_23, arg2, function(arg1_24) -- Line 333
			--[[ Upvalues[2]:
				[1]: arg3 (readonly)
				[2]: arg4 (readonly)
			]]
			if arg1_24.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1_24.UserInputType ~= Enum.UserInputType.Gamepad1 then
			else
				arg3.TextColor3 = arg4.ButtonActiveColor
				arg3.TextTransparency = arg4.ButtonActiveTransparency
			end
		end)
		tbl_upvr.applyInputEnded(arg1_23, arg2, function(arg1_25) -- Line 341
			--[[ Upvalues[3]:
				[1]: var52_upvw (read and write)
				[2]: arg3 (readonly)
				[3]: arg4 (readonly)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 4. Error Block 2 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 4. Error Block 2 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [12] 7. Error Block 17 start (CF ANALYSIS FAILED)
			if var52_upvw then
				-- KONSTANTERROR: [14] 9. Error Block 5 start (CF ANALYSIS FAILED)
				do
					return
				end
				-- KONSTANTERROR: [14] 9. Error Block 5 end (CF ANALYSIS FAILED)
			end
			if arg1_25.UserInputType == Enum.UserInputType.MouseButton1 then
				arg3.TextColor3 = arg4.ButtonHoveredColor
				arg3.TextTransparency = arg4.ButtonHoveredTransparency
			end
			if arg1_25.UserInputType == Enum.UserInputType.Gamepad1 then
				arg3.TextColor3 = arg4.ButtonColor
				arg3.TextTransparency = arg4.ButtonTransparency
			end
			-- KONSTANTERROR: [12] 7. Error Block 17 end (CF ANALYSIS FAILED)
		end)
		arg2.SelectionImageObject = arg1.SelectionImageObject
	end
	function tbl_upvr.applyFrameStyle(arg1_26, arg2, arg3) -- Line 358
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: tbl_upvr (copied, readonly)
		]]
		local FrameBorderSize = arg1._config.FrameBorderSize
		local FrameRounding = arg1._config.FrameRounding
		arg1_26.BorderSizePixel = 0
		if 0 < FrameBorderSize then
			tbl_upvr.UIStroke(arg1_26, FrameBorderSize, arg1._config.BorderColor, arg1._config.BorderTransparency)
		end
		if 0 < FrameRounding and not arg3 then
			tbl_upvr.UICorner(arg1_26, FrameRounding)
		end
		if not arg2 then
			tbl_upvr.UIPadding(arg1_26, arg1._config.FramePadding)
		end
	end
	function tbl_upvr.applyButtonClick(arg1_27, arg2, arg3) -- Line 376
		arg2.MouseButton1Click:Connect(function() -- Line 377
			--[[ Upvalues[1]:
				[1]: arg3 (readonly)
			]]
			arg3()
		end)
	end
	function tbl_upvr.applyButtonDown(arg1_28, arg2, arg3) -- Line 382
		arg2.MouseButton1Down:Connect(function(...) -- Line 383
			--[[ Upvalues[1]:
				[1]: arg3 (readonly)
			]]
			arg3(...)
		end)
	end
	function tbl_upvr.applyMouseEnter(arg1_29, arg2, arg3) -- Line 388
		arg2.MouseEnter:Connect(function(...) -- Line 389
			--[[ Upvalues[1]:
				[1]: arg3 (readonly)
			]]
			arg3(...)
		end)
	end
	function tbl_upvr.applyMouseLeave(arg1_30, arg2, arg3) -- Line 394
		arg2.MouseLeave:Connect(function(...) -- Line 395
			--[[ Upvalues[1]:
				[1]: arg3 (readonly)
			]]
			arg3(...)
		end)
	end
	function tbl_upvr.applyInputBegan(arg1_31, arg2, arg3) -- Line 400
		arg2.InputBegan:Connect(function(...) -- Line 401
			--[[ Upvalues[1]:
				[1]: arg3 (readonly)
			]]
			arg3(...)
		end)
	end
	function tbl_upvr.applyInputEnded(arg1_32, arg2, arg3) -- Line 406
		arg2.InputEnded:Connect(function(...) -- Line 407
			--[[ Upvalues[1]:
				[1]: arg3 (readonly)
			]]
			arg3(...)
		end)
	end
	function tbl_upvr.discardState(arg1_33) -- Line 412
		for _, v_5 in arg1_33.state do
			v_5.ConnectedWidgets[arg1_33.ID] = nil
		end
	end
	function tbl_upvr.registerEvent(arg1_34, arg2) -- Line 418
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: tbl_upvr (copied, readonly)
		]]
		table.insert(arg1._initFunctions, function() -- Line 419
			--[[ Upvalues[4]:
				[1]: arg1 (copied, readonly)
				[2]: tbl_upvr (copied, readonly)
				[3]: arg1_34 (readonly)
				[4]: arg2 (readonly)
			]]
			table.insert(arg1._connections, tbl_upvr.UserInputService[arg1_34]:Connect(arg2))
		end)
	end
	tbl_upvr.EVENTS = {
		hover = function(arg1_35) -- Line 425, Named "hover"
			--[[ Upvalues[1]:
				[1]: tbl_upvr (copied, readonly)
			]]
			return {
				Init = function(arg1_36) -- Line 427
					--[[ Upvalues[2]:
						[1]: arg1_35 (readonly)
						[2]: tbl_upvr (copied, readonly)
					]]
					local arg1_35_result1 = arg1_35(arg1_36)
					tbl_upvr.applyMouseEnter(arg1_36, arg1_35_result1, function() -- Line 429
						--[[ Upvalues[1]:
							[1]: arg1_36 (readonly)
						]]
						arg1_36.isHoveredEvent = true
					end)
					tbl_upvr.applyMouseLeave(arg1_36, arg1_35_result1, function() -- Line 432
						--[[ Upvalues[1]:
							[1]: arg1_36 (readonly)
						]]
						arg1_36.isHoveredEvent = false
					end)
					arg1_36.isHoveredEvent = false
				end;
				Get = function(arg1_37) -- Line 437
					return arg1_37.isHoveredEvent
				end;
			}
		end;
		click = function(arg1_38) -- Line 443, Named "click"
			--[[ Upvalues[2]:
				[1]: tbl_upvr (copied, readonly)
				[2]: arg1 (readonly)
			]]
			return {
				Init = function(arg1_39) -- Line 445
					--[[ Upvalues[3]:
						[1]: arg1_38 (readonly)
						[2]: tbl_upvr (copied, readonly)
						[3]: arg1 (copied, readonly)
					]]
					arg1_39.lastClickedTick = -1
					tbl_upvr.applyButtonClick(arg1_39, arg1_38(arg1_39), function() -- Line 449
						--[[ Upvalues[2]:
							[1]: arg1_39 (readonly)
							[2]: arg1 (copied, readonly)
						]]
						arg1_39.lastClickedTick = arg1._cycleTick + 1
					end)
				end;
				Get = function(arg1_40) -- Line 453
					--[[ Upvalues[1]:
						[1]: arg1 (copied, readonly)
					]]
					local var79
					if arg1_40.lastClickedTick ~= arg1._cycleTick then
						var79 = false
					else
						var79 = true
					end
					return var79
				end;
			}
		end;
		rightClick = function(arg1_41) -- Line 459, Named "rightClick"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			return {
				Init = function(arg1_42) -- Line 461
					--[[ Upvalues[2]:
						[1]: arg1_41 (readonly)
						[2]: arg1 (copied, readonly)
					]]
					arg1_42.lastRightClickedTick = -1
					arg1_41(arg1_42).MouseButton2Click:Connect(function() -- Line 465
						--[[ Upvalues[2]:
							[1]: arg1_42 (readonly)
							[2]: arg1 (copied, readonly)
						]]
						arg1_42.lastRightClickedTick = arg1._cycleTick + 1
					end)
				end;
				Get = function(arg1_43) -- Line 469
					--[[ Upvalues[1]:
						[1]: arg1 (copied, readonly)
					]]
					local var84
					if arg1_43.lastRightClickedTick ~= arg1._cycleTick then
						var84 = false
					else
						var84 = true
					end
					return var84
				end;
			}
		end;
		doubleClick = function(arg1_44) -- Line 475, Named "doubleClick"
			--[[ Upvalues[2]:
				[1]: tbl_upvr (copied, readonly)
				[2]: arg1 (readonly)
			]]
			return {
				Init = function(arg1_45) -- Line 477
					--[[ Upvalues[3]:
						[1]: arg1_44 (readonly)
						[2]: tbl_upvr (copied, readonly)
						[3]: arg1 (copied, readonly)
					]]
					arg1_45.lastClickedTime = -1
					arg1_45.lastClickedPosition = Vector2.zero
					arg1_45.lastDoubleClickedTick = -1
					tbl_upvr.applyButtonDown(arg1_45, arg1_44(arg1_45), function(arg1_46, arg2) -- Line 483
						--[[ Upvalues[3]:
							[1]: tbl_upvr (copied, readonly)
							[2]: arg1_45 (readonly)
							[3]: arg1 (copied, readonly)
						]]
						local any_getTime_result1 = tbl_upvr.getTime()
						local var89
						if any_getTime_result1 - arg1_45.lastClickedTime >= arg1._config.MouseDoubleClickTime then
							var89 = false
						else
							var89 = true
						end
						if var89 and (Vector2.new(arg1_46, arg2) - arg1_45.lastClickedPosition).Magnitude < arg1._config.MouseDoubleClickMaxDist then
							arg1_45.lastDoubleClickedTick = arg1._cycleTick + 1
						else
							arg1_45.lastClickedTime = any_getTime_result1
							arg1_45.lastClickedPosition = Vector2.new(arg1_46, arg2)
						end
					end)
				end;
				Get = function(arg1_47) -- Line 494
					--[[ Upvalues[1]:
						[1]: arg1 (copied, readonly)
					]]
					local var91
					if arg1_47.lastDoubleClickedTick ~= arg1._cycleTick then
						var91 = false
					else
						var91 = true
					end
					return var91
				end;
			}
		end;
		ctrlClick = function(arg1_48) -- Line 500, Named "ctrlClick"
			--[[ Upvalues[2]:
				[1]: tbl_upvr (copied, readonly)
				[2]: arg1 (readonly)
			]]
			return {
				Init = function(arg1_49) -- Line 502
					--[[ Upvalues[3]:
						[1]: arg1_48 (readonly)
						[2]: tbl_upvr (copied, readonly)
						[3]: arg1 (copied, readonly)
					]]
					arg1_49.lastCtrlClickedTick = -1
					tbl_upvr.applyButtonClick(arg1_49, arg1_48(arg1_49), function() -- Line 506
						--[[ Upvalues[3]:
							[1]: tbl_upvr (copied, readonly)
							[2]: arg1_49 (readonly)
							[3]: arg1 (copied, readonly)
						]]
						if tbl_upvr.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or tbl_upvr.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
							arg1_49.lastCtrlClickedTick = arg1._cycleTick + 1
						end
					end)
				end;
				Get = function(arg1_50) -- Line 512
					--[[ Upvalues[1]:
						[1]: arg1 (copied, readonly)
					]]
					local var96
					if arg1_50.lastCtrlClickedTick ~= arg1._cycleTick then
						var96 = false
					else
						var96 = true
					end
					return var96
				end;
			}
		end;
	}
	arg1._utility = tbl_upvr
	require(script.Root)(arg1, tbl_upvr)
	require(script.Window)(arg1, tbl_upvr)
	require(script.Menu)(arg1, tbl_upvr)
	require(script.Format)(arg1, tbl_upvr)
	require(script.Text)(arg1, tbl_upvr)
	require(script.Button)(arg1, tbl_upvr)
	require(script.Checkbox)(arg1, tbl_upvr)
	require(script.RadioButton)(arg1, tbl_upvr)
	require(script.Image)(arg1, tbl_upvr)
	require(script.Tree)(arg1, tbl_upvr)
	require(script.Input)(arg1, tbl_upvr)
	require(script.Combo)(arg1, tbl_upvr)
	require(script.Plot)(arg1, tbl_upvr)
	require(script.Table)(arg1, tbl_upvr)
end