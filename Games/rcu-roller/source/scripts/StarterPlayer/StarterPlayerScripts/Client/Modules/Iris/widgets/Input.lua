-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:36
-- Luau version 6, Types version 3
-- Time taken: 0.049413 seconds

return function(arg1, arg2) -- Line 3
	local tbl_3_upvr = {
		Init = function(arg1_2) -- Line 5
		end;
		Get = function(arg1_3) -- Line 6
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			local var5
			if arg1_3.lastNumberChangedTick ~= arg1._cycleTick then
				var5 = false
			else
				var5 = true
			end
			return var5
		end;
	}
	local function getValueByIndex_upvr(arg1_4, arg2_2, arg3) -- Line 11, Named "getValueByIndex"
		-- KONSTANTERROR: [0] 1. Error Block 101 start (CF ANALYSIS FAILED)
		if typeof(arg1_4) == "number" then
			return arg1_4
		end
		if typeof(arg1_4) == "Vector2" then
			if arg2_2 == 1 then
				return arg1_4.X
			end
			if arg2_2 == 2 then
				do
					return arg1_4.Y
				end
				-- KONSTANTWARNING: GOTO [189] #124
			end
			-- KONSTANTWARNING: GOTO [189] #124
		end
		-- KONSTANTERROR: [0] 1. Error Block 101 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [26] 19. Error Block 98 start (CF ANALYSIS FAILED)
		if typeof(arg1_4) == "Vector3" then
			if arg2_2 == 1 then
				return arg1_4.X
			end
			if arg2_2 == 2 then
				return arg1_4.Y
			end
			if arg2_2 == 3 then
				do
					return arg1_4.Z
				end
				-- KONSTANTWARNING: GOTO [189] #124
			end
		elseif typeof(arg1_4) == "UDim" then
			if arg2_2 == 1 then
				return arg1_4.Scale
			end
			if arg2_2 == 2 then
				do
					return arg1_4.Offset
				end
				-- KONSTANTWARNING: GOTO [189] #124
			end
		elseif typeof(arg1_4) == "UDim2" then
			if arg2_2 == 1 then
				return arg1_4.X.Scale
			end
			if arg2_2 == 2 then
				return arg1_4.X.Offset
			end
			if arg2_2 == 3 then
				return arg1_4.Y.Scale
			end
			if arg2_2 == 4 then
				do
					return arg1_4.Y.Offset
				end
				-- KONSTANTWARNING: GOTO [189] #124
			end
		elseif typeof(arg1_4) == "Color3" then
			local function INLINED() -- Internal function, doesn't exist in bytecode
				tbl_6[1] = arg1_4:ToHSV()
				local tbl_6 = {}
				return tbl_6
			end
			if not arg3.UseHSV or not INLINED() then
				local module_3 = {arg1_4.R, arg1_4.G, arg1_4.B}
			end
			if arg2_2 == 1 then
				return module_3[1]
			end
			if arg2_2 == 2 then
				return module_3[2]
			end
			if arg2_2 == 3 then
				do
					return module_3[3]
				end
				-- KONSTANTWARNING: GOTO [189] #124
			end
		elseif typeof(arg1_4) == "Rect" then
			if arg2_2 == 1 then
				return arg1_4.Min.X
			end
			if arg2_2 == 2 then
				return arg1_4.Min.Y
			end
			if arg2_2 == 3 then
				return arg1_4.Max.X
			end
			if arg2_2 == 4 then
				do
					return arg1_4.Max.Y
				end
				-- KONSTANTWARNING: GOTO [189] #124
			end
		elseif typeof(arg1_4) == "table" then
			return arg1_4[arg2_2]
		end
		-- KONSTANTERROR: [26] 19. Error Block 98 end (CF ANALYSIS FAILED)
	end
	local function updateValueByIndex_upvr(arg1_5, arg2_3, arg3, arg4) -- Line 70, Named "updateValueByIndex"
		-- KONSTANTERROR: [0] 1. Error Block 102 start (CF ANALYSIS FAILED)
		if typeof(arg1_5) == "number" then
			return arg3
		end
		if typeof(arg1_5) == "Vector2" then
			if arg2_3 == 1 then
				return Vector2.new(arg3, arg1_5.Y)
			end
			if arg2_3 == 2 then
				do
					return Vector2.new(arg1_5.X, arg3)
				end
				-- KONSTANTWARNING: GOTO [324] #216
			end
			-- KONSTANTWARNING: GOTO [324] #216
		end
		-- KONSTANTERROR: [0] 1. Error Block 102 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [34] 25. Error Block 99 start (CF ANALYSIS FAILED)
		if typeof(arg1_5) == "Vector3" then
			if arg2_3 == 1 then
				return Vector3.new(arg3, arg1_5.Y, arg1_5.Z)
			end
			if arg2_3 == 2 then
				return Vector3.new(arg1_5.X, arg3, arg1_5.Z)
			end
			if arg2_3 == 3 then
				do
					return Vector3.new(arg1_5.X, arg1_5.Y, arg3)
				end
				-- KONSTANTWARNING: GOTO [324] #216
			end
		elseif typeof(arg1_5) == "UDim" then
			if arg2_3 == 1 then
				return UDim.new(arg3, arg1_5.Offset)
			end
			if arg2_3 == 2 then
				do
					return UDim.new(arg1_5.Scale, arg3)
				end
				-- KONSTANTWARNING: GOTO [324] #216
			end
		elseif typeof(arg1_5) == "UDim2" then
			if arg2_3 == 1 then
				return UDim2.new(UDim.new(arg3, arg1_5.X.Offset), arg1_5.Y)
			end
			if arg2_3 == 2 then
				return UDim2.new(UDim.new(arg1_5.X.Scale, arg3), arg1_5.Y)
			end
			if arg2_3 == 3 then
				return UDim2.new(arg1_5.X, UDim.new(arg3, arg1_5.Y.Offset))
			end
			if arg2_3 == 4 then
				do
					return UDim2.new(arg1_5.X, UDim.new(arg1_5.Y.Scale, arg3))
				end
				-- KONSTANTWARNING: GOTO [324] #216
			end
		elseif typeof(arg1_5) == "Rect" then
			if arg2_3 == 1 then
				return Rect.new(Vector2.new(arg3, arg1_5.Min.Y), arg1_5.Max)
			end
			if arg2_3 == 2 then
				return Rect.new(Vector2.new(arg1_5.Min.X, arg3), arg1_5.Max)
			end
			if arg2_3 == 3 then
				return Rect.new(arg1_5.Min, Vector2.new(arg3, arg1_5.Max.Y))
			end
			if arg2_3 == 4 then
				do
					return Rect.new(arg1_5.Min, Vector2.new(arg1_5.Max.X, arg3))
				end
				-- KONSTANTWARNING: GOTO [324] #216
			end
		elseif typeof(arg1_5) == "Color3" then
			if arg4.UseHSV then
				local any_ToHSV_result1, any_ToHSV_result2, any_ToHSV_result3 = arg1_5:ToHSV()
				if arg2_3 == 1 then
					return Color3.fromHSV(arg3, any_ToHSV_result2, any_ToHSV_result3)
				end
				if arg2_3 == 2 then
					return Color3.fromHSV(any_ToHSV_result1, arg3, any_ToHSV_result3)
				end
				if arg2_3 == 3 then
					return Color3.fromHSV(any_ToHSV_result1, any_ToHSV_result2, arg3)
				end
			end
			if arg2_3 == 1 then
				return Color3.new(arg3, arg1_5.G, arg1_5.B)
			end
			if arg2_3 == 2 then
				return Color3.new(arg1_5.R, arg3, arg1_5.B)
			end
			if arg2_3 == 3 then
				return Color3.new(arg1_5.R, arg1_5.G, arg3)
			end
		end
		-- KONSTANTERROR: [34] 25. Error Block 99 end (CF ANALYSIS FAILED)
	end
	local tbl_upvr_2 = {
		Num = {1};
		Vector2 = {1, 1};
		Vector3 = {1, 1, 1};
		UDim = {0.01, 1};
		UDim2 = {0.01, 1, 0.01, 1};
		Color3 = {1, 1, 1};
		Color4 = {1, 1, 1, 1};
		Rect = {1, 1, 1, 1};
	}
	local tbl_4_upvr = {
		Num = {0};
		Vector2 = {0, 0};
		Vector3 = {0, 0, 0};
		UDim = {0, 0};
		UDim2 = {0, 0, 0, 0};
		Rect = {0, 0, 0, 0};
	}
	local tbl_upvr_3 = {
		Num = {100};
		Vector2 = {100, 100};
		Vector3 = {100, 100, 100};
		UDim = {1, 960};
		UDim2 = {1, 960, 1, 960};
		Rect = {960, 960, 960, 960};
	}
	local tbl_upvr = {
		Num = {""};
		Vector2 = {"X: ", "Y: "};
		Vector3 = {"X: ", "Y: ", "Z: "};
		UDim = {"", ""};
		UDim2 = {"", "", "", ""};
		Color3_RGB = {"R: ", "G: ", "B: "};
		Color3_HSV = {"H: ", "S: ", "V: "};
		Color4_RGB = {"R: ", "G: ", "B: ", "T: "};
		Color4_HSV = {"H: ", "S: ", "V: ", "T: "};
		Rect = {"X: ", "Y: ", "X: ", "Y: "};
	}
	local tbl_2_upvr = {
		Num = {0};
		Vector2 = {0, 0};
		Vector3 = {0, 0, 0};
		UDim = {3, 0};
		UDim2 = {3, 0, 3, 0};
		Color3 = {0, 0, 0};
		Color4 = {0, 0, 0, 0};
		Rect = {0, 0, 0, 0};
	}
	local function generateDragScalar_upvr(arg1_6, arg2_4, arg3, arg4) -- Line 194, Named "generateButtons"
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
			[3]: getValueByIndex_upvr (readonly)
		]]
		local any_Generate_result1 = arg2.abstractButton.Generate(arg1_6)
		any_Generate_result1.Name = "SubButton"
		any_Generate_result1.ZIndex = 5
		any_Generate_result1.LayoutOrder = 5
		any_Generate_result1.TextXAlignment = Enum.TextXAlignment.Center
		any_Generate_result1.Text = '-'
		any_Generate_result1.Size = UDim2.fromOffset(arg1._config.TextSize + 2 * arg1._config.FramePadding.Y, arg1._config.TextSize)
		any_Generate_result1.Parent = arg2_4
		arg2.applyButtonClick(arg1_6, any_Generate_result1, function() -- Line 206
			--[[ Upvalues[4]:
				[1]: arg2 (copied, readonly)
				[2]: arg1_6 (readonly)
				[3]: getValueByIndex_upvr (copied, readonly)
				[4]: arg1 (copied, readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local any_IsKeyDown_result1_2 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
			if not any_IsKeyDown_result1_2 then
				any_IsKeyDown_result1_2 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			end
			if not arg1_6.arguments.Increment or not getValueByIndex_upvr(arg1_6.arguments.Increment, 1, arg1_6.arguments) then
			end
			if any_IsKeyDown_result1_2 then
			else
			end
			if arg1_6.arguments.Min ~= nil then
			end
			if arg1_6.arguments.Max ~= nil then
			end
			arg1_6.state.number:set(math.min(math.max(arg1_6.state.number.value - 1 * 1, getValueByIndex_upvr(arg1_6.arguments.Min, 1, arg1_6.arguments)), getValueByIndex_upvr(arg1_6.arguments.Max, 1, arg1_6.arguments)))
			arg1_6.lastNumberChangedTick = arg1._cycleTick + 1
		end)
		local any_Generate_result1_2 = arg2.abstractButton.Generate(arg1_6)
		any_Generate_result1_2.Name = "AddButton"
		any_Generate_result1_2.ZIndex = 6
		any_Generate_result1_2.LayoutOrder = 6
		any_Generate_result1_2.TextXAlignment = Enum.TextXAlignment.Center
		any_Generate_result1_2.Text = '+'
		any_Generate_result1_2.Size = UDim2.fromOffset(arg1._config.TextSize + 2 * arg1._config.FramePadding.Y, arg1._config.TextSize)
		any_Generate_result1_2.Parent = arg2_4
		arg2.applyButtonClick(arg1_6, any_Generate_result1_2, function() -- Line 229
			--[[ Upvalues[4]:
				[1]: arg2 (copied, readonly)
				[2]: arg1_6 (readonly)
				[3]: getValueByIndex_upvr (copied, readonly)
				[4]: arg1 (copied, readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local any_IsKeyDown_result1 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
			if not any_IsKeyDown_result1 then
				any_IsKeyDown_result1 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			end
			if not arg1_6.arguments.Increment or not getValueByIndex_upvr(arg1_6.arguments.Increment, 1, arg1_6.arguments) then
			end
			if any_IsKeyDown_result1 then
			else
			end
			if arg1_6.arguments.Min ~= nil then
			end
			if arg1_6.arguments.Max ~= nil then
			end
			arg1_6.state.number:set(math.min(math.max(arg1_6.state.number.value + 1 * 1, getValueByIndex_upvr(arg1_6.arguments.Min, 1, arg1_6.arguments)), getValueByIndex_upvr(arg1_6.arguments.Max, 1, arg1_6.arguments)))
			arg1_6.lastNumberChangedTick = arg1._cycleTick + 1
		end)
		return (arg3) + (2 * arg1._config.ItemInnerSpacing.X + arg4 * 2)
	end
	local function generateInputScalar(arg1_7, arg2_5, arg3) -- Line 246
		--[[ Upvalues[8]:
			[1]: tbl_3_upvr (readonly)
			[2]: arg2 (readonly)
			[3]: arg1 (readonly)
			[4]: generateDragScalar_upvr (readonly)
			[5]: getValueByIndex_upvr (readonly)
			[6]: updateValueByIndex_upvr (readonly)
			[7]: tbl_2_upvr (readonly)
			[8]: tbl_upvr (readonly)
		]]
		local module = {
			hasState = true;
			hasChildren = false;
			Args = {
				Text = 1;
				Increment = 2;
				Min = 3;
				Max = 4;
				Format = 5;
			};
			Events = {
				numberChanged = tbl_3_upvr;
				hovered = arg2.EVENTS.hover(function(arg1_8) -- Line 259
					return arg1_8.Instance
				end);
			};
		}
		local function Generate(arg1_9) -- Line 263
			--[[ Upvalues[7]:
				[1]: arg1_7 (readonly)
				[2]: arg2 (copied, readonly)
				[3]: arg1 (copied, readonly)
				[4]: arg2_5 (readonly)
				[5]: generateDragScalar_upvr (copied, readonly)
				[6]: getValueByIndex_upvr (copied, readonly)
				[7]: updateValueByIndex_upvr (copied, readonly)
			]]
			local Frame_4 = Instance.new("Frame")
			Frame_4.Name = "Input"..arg1_7
			Frame_4.Size = UDim2.fromScale(1, 0)
			Frame_4.BackgroundTransparency = 1
			Frame_4.BorderSizePixel = 0
			Frame_4.LayoutOrder = arg1_9.ZIndex
			Frame_4.AutomaticSize = Enum.AutomaticSize.Y
			arg2.UIListLayout(Frame_4, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local var67 = 0
			if arg2_5 == 1 then
				var67 = generateDragScalar_upvr(arg1_9, Frame_4, var67, arg1._config.TextSize + 2 * arg1._config.FramePadding.Y)
			end
			local udim_3 = UDim.new(arg1._config.ContentWidth.Scale / arg2_5, (arg1._config.ContentWidth.Offset - arg1._config.ItemInnerSpacing.X * (arg2_5 - 1) - var67) / arg2_5)
			for i_upvr = 1, arg2_5 do
				local TextBox_upvr_4 = Instance.new("TextBox")
				TextBox_upvr_4.Name = "InputField"..tostring(i_upvr)
				TextBox_upvr_4.LayoutOrder = i_upvr
				if i_upvr == arg2_5 then
					TextBox_upvr_4.Size = UDim2.new(arg1._config.ContentWidth - UDim.new(udim_3.Scale * (arg2_5 - 1), udim_3.Offset * (arg2_5 - 1) + arg1._config.ItemInnerSpacing.X * (arg2_5 - 1) + var67), arg1._config.ContentHeight)
				else
					TextBox_upvr_4.Size = UDim2.new(udim_3, arg1._config.ContentHeight)
				end
				TextBox_upvr_4.AutomaticSize = Enum.AutomaticSize.Y
				TextBox_upvr_4.BackgroundColor3 = arg1._config.FrameBgColor
				TextBox_upvr_4.BackgroundTransparency = arg1._config.FrameBgTransparency
				TextBox_upvr_4.ClearTextOnFocus = false
				TextBox_upvr_4.TextTruncate = Enum.TextTruncate.AtEnd
				TextBox_upvr_4.ClipsDescendants = true
				arg2.applyFrameStyle(TextBox_upvr_4)
				arg2.applyTextStyle(TextBox_upvr_4)
				arg2.UISizeConstraint(TextBox_upvr_4, Vector2.new(1, 0))
				TextBox_upvr_4.Parent = Frame_4
				TextBox_upvr_4.FocusLost:Connect(function() -- Line 312
					--[[ Upvalues[6]:
						[1]: TextBox_upvr_4 (readonly)
						[2]: arg1_9 (readonly)
						[3]: getValueByIndex_upvr (copied, readonly)
						[4]: i_upvr (readonly)
						[5]: updateValueByIndex_upvr (copied, readonly)
						[6]: arg1 (copied, readonly)
					]]
					-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
					local var71
					if var71 ~= nil then
						if arg1_9.arguments.Min ~= nil then
							var71 = math.max(var71, getValueByIndex_upvr(arg1_9.arguments.Min, i_upvr, arg1_9.arguments))
						end
						if arg1_9.arguments.Max ~= nil then
							var71 = math.min(var71, getValueByIndex_upvr(arg1_9.arguments.Max, i_upvr, arg1_9.arguments))
						end
						if arg1_9.arguments.Increment then
							var71 = math.round(var71 / getValueByIndex_upvr(arg1_9.arguments.Increment, i_upvr, arg1_9.arguments)) * getValueByIndex_upvr(arg1_9.arguments.Increment, i_upvr, arg1_9.arguments)
						end
						arg1_9.state.number:set(updateValueByIndex_upvr(arg1_9.state.number.value, i_upvr, var71, arg1_9.arguments))
						arg1_9.lastNumberChangedTick = arg1._cycleTick + 1
					end
					if not arg1_9.arguments.Format[i_upvr] then
					end
					if arg1_9.arguments.Prefix then
					end
					TextBox_upvr_4.Text = string.format(arg1_9.arguments.Prefix[i_upvr]..arg1_9.arguments.Format[1], getValueByIndex_upvr(arg1_9.state.number.value, i_upvr, arg1_9.arguments))
					arg1_9.state.editingText:set(0)
				end)
				TextBox_upvr_4.Focused:Connect(function() -- Line 338
					--[[ Upvalues[3]:
						[1]: TextBox_upvr_4 (readonly)
						[2]: arg1_9 (readonly)
						[3]: i_upvr (readonly)
					]]
					TextBox_upvr_4.CursorPosition = #TextBox_upvr_4.Text + 1
					TextBox_upvr_4.SelectionStart = 1
					arg1_9.state.editingText:set(i_upvr)
				end)
			end
			local TextLabel_4 = Instance.new("TextLabel")
			TextLabel_4.Name = "TextLabel"
			TextLabel_4.BackgroundTransparency = 1
			TextLabel_4.BorderSizePixel = 0
			TextLabel_4.LayoutOrder = 7
			TextLabel_4.AutomaticSize = Enum.AutomaticSize.XY
			arg2.applyTextStyle(TextLabel_4)
			TextLabel_4.Parent = Frame_4
			return Frame_4
		end
		module.Generate = Generate
		local function Update(arg1_10) -- Line 360
			--[[ Upvalues[5]:
				[1]: arg1_7 (readonly)
				[2]: arg2_5 (readonly)
				[3]: tbl_2_upvr (copied, readonly)
				[4]: getValueByIndex_upvr (copied, readonly)
				[5]: tbl_upvr (copied, readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local Instance = arg1_10.Instance
			local Text_3 = arg1_10.arguments.Text
			if not Text_3 then
				Text_3 = `Input {arg1_7}`
			end
			Instance.TextLabel.Text = Text_3
			if arg2_5 == 1 then
				Instance.SubButton.Visible = not arg1_10.arguments.NoButtons
				Instance.AddButton.Visible = not arg1_10.arguments.NoButtons
			end
			if arg1_10.arguments.Format and typeof(arg1_10.arguments.Format) ~= "table" then
				arg1_10.arguments.Format = {arg1_10.arguments.Format}
			elseif not arg1_10.arguments.Format then
				for i_11 = 1, arg2_5 do
					local var81 = tbl_2_upvr[arg1_7][i_11]
					local var82
					if arg1_10.arguments.Increment then
						local getValueByIndex_upvr_result1_8 = getValueByIndex_upvr(arg1_10.arguments.Increment, i_11, arg1_10.arguments)
						if getValueByIndex_upvr_result1_8 == 0 then
							var82 = 1
						else
							var82 = getValueByIndex_upvr_result1_8
						end
						local maximum_4 = math.max(var81, math.ceil(-math.log10(var82)), var81)
					end
					if arg1_10.arguments.Max then
						local getValueByIndex_upvr_result1_10 = getValueByIndex_upvr(arg1_10.arguments.Max, i_11, arg1_10.arguments)
						if getValueByIndex_upvr_result1_10 == 0 then
							var82 = 1
						else
							var82 = getValueByIndex_upvr_result1_10
						end
						local maximum_8 = math.max(maximum_4, math.ceil(-math.log10(var82)), maximum_4)
					end
					if arg1_10.arguments.Min then
						local getValueByIndex_upvr_result1_4 = getValueByIndex_upvr(arg1_10.arguments.Min, i_11, arg1_10.arguments)
						if getValueByIndex_upvr_result1_4 == 0 then
							var82 = 1
						else
							var82 = getValueByIndex_upvr_result1_4
						end
						local maximum_12 = math.max(maximum_8, math.ceil(-math.log10(var82)), maximum_8)
					end
					if 0 < maximum_12 then
						({})[i_11] = `%.{maximum_12}f`
					else
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						-- ({})[i_11] = "%d"
					end
				end
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				arg1_10.arguments.Format = {}
				arg1_10.arguments.Prefix = tbl_upvr[arg1_7]
			end
		end
		module.Update = Update
		local function Discard(arg1_11) -- Line 405
			--[[ Upvalues[1]:
				[1]: arg2 (copied, readonly)
			]]
			arg1_11.Instance:Destroy()
			arg2.discardState(arg1_11)
		end
		module.Discard = Discard
		local function GenerateState(arg1_12) -- Line 409
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: arg3 (readonly)
			]]
			if arg1_12.state.number == nil then
				arg1_12.state.number = arg1._widgetState(arg1_12, "number", arg3)
			end
			if arg1_12.state.editingText == nil then
				arg1_12.state.editingText = arg1._widgetState(arg1_12, "editingText", 0)
			end
		end
		module.GenerateState = GenerateState
		local function UpdateState(arg1_13) -- Line 417
			--[[ Upvalues[2]:
				[1]: arg2_5 (readonly)
				[2]: getValueByIndex_upvr (copied, readonly)
			]]
			for i_2 = 1, arg2_5 do
				local var91
				if not var91 then
					var91 = arg1_13.arguments.Format[1]
				end
				if arg1_13.arguments.Prefix then
					var91 = arg1_13.arguments.Prefix[i_2]..var91
				end
				arg1_13.Instance:FindFirstChild("InputField"..tostring(i_2)).Text = string.format(var91, getValueByIndex_upvr(arg1_13.state.number.value, i_2, arg1_13.arguments))
			end
		end
		module.UpdateState = UpdateState
		return module
	end
	generateDragScalar_upvr = nil
	local var92_upvw = false
	local var93_upvw
	local var94_upvw = 0
	local var95_upvw = ""
	local var96_upvw = 0
	local function updateActiveDrag_upvr() -- Line 445, Named "updateActiveDrag"
		--[[ Upvalues[10]:
			[1]: arg2 (readonly)
			[2]: var96_upvw (read and write)
			[3]: var92_upvw (read and write)
			[4]: var93_upvw (read and write)
			[5]: var95_upvw (read and write)
			[6]: var94_upvw (read and write)
			[7]: getValueByIndex_upvr (readonly)
			[8]: tbl_upvr_2 (readonly)
			[9]: updateValueByIndex_upvr (readonly)
			[10]: arg1 (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local X_3 = arg2.getMouseLocation().X
		var96_upvw = X_3
		local var98
		if var92_upvw == false then
		else
			if var93_upvw == nil then return end
			var98 = var93_upvw.state
			var98 = var95_upvw
			local function INLINED_2() -- Internal function, doesn't exist in bytecode
				var98 = var95_upvw
				return var98 == "Color4"
			end
			local function INLINED_3() -- Internal function, doesn't exist in bytecode
				var98 = var94_upvw
				var98 = var93_upvw.state
				return var98 == 4
			end
			if var98 == "Color3" or INLINED_2() or INLINED_3() then
				var98 = var93_upvw.state
				local transparency = var98.transparency
			end
			local function INLINED_4() -- Internal function, doesn't exist in bytecode
				var98 = getValueByIndex_upvr(var93_upvw.arguments.Increment, var94_upvw, var93_upvw.arguments)
				return var98
			end
			if not var93_upvw.arguments.Increment or not INLINED_4() then
				var98 = tbl_upvr_2[var95_upvw][var94_upvw]
			end
			if arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
			else
			end
			var98 *= 1
			if arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then
			else
			end
			var98 *= 1
			if var95_upvw == "Color3" or var95_upvw == "Color4" then
			else
			end
			var98 *= 1
			if var93_upvw.arguments.Min ~= nil then
			end
			if var93_upvw.arguments.Max ~= nil then
			end
			transparency:set(updateValueByIndex_upvr(transparency.value, var94_upvw, math.min(math.max(getValueByIndex_upvr(transparency.value, var94_upvw, var93_upvw.arguments) + (X_3 - var96_upvw) * var98, getValueByIndex_upvr(var93_upvw.arguments.Min, var94_upvw, var93_upvw.arguments)), getValueByIndex_upvr(var93_upvw.arguments.Max, var94_upvw, var93_upvw.arguments)), var93_upvw.arguments))
			var93_upvw.lastNumberChangedTick = arg1._cycleTick + 1
		end
	end
	local function DragMouseDown_upvr(arg1_14, arg2_6, arg3, arg4, arg5) -- Line 484, Named "DragMouseDown"
		--[[ Upvalues[7]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
			[3]: var92_upvw (read and write)
			[4]: var93_upvw (read and write)
			[5]: var94_upvw (read and write)
			[6]: var95_upvw (read and write)
			[7]: updateActiveDrag_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local any_getTime_result1 = arg2.getTime()
		local var101
		if any_getTime_result1 - arg1_14.lastClickedTime >= arg1._config.MouseDoubleClickTime then
			var101 = false
		else
			var101 = true
		end
		if not arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		end
		if var101 and (Vector2.new(arg4, arg5) - arg1_14.lastClickedPosition).Magnitude < arg1._config.MouseDoubleClickMaxDist or arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
			arg1_14.state.editingText:set(arg3)
		else
			arg1_14.lastClickedTime = any_getTime_result1
			arg1_14.lastClickedPosition = Vector2.new(arg4, arg5)
			var92_upvw = true
			var93_upvw = arg1_14
			var94_upvw = arg3
			var95_upvw = arg2_6
			updateActiveDrag_upvr()
		end
	end
	arg2.registerEvent("InputChanged", function() -- Line 502
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: updateActiveDrag_upvr (readonly)
		]]
		if not arg1._started then
		else
			updateActiveDrag_upvr()
		end
	end)
	arg2.registerEvent("InputEnded", function(arg1_15) -- Line 509
		--[[ Upvalues[4]:
			[1]: arg1 (readonly)
			[2]: var92_upvw (read and write)
			[3]: var93_upvw (read and write)
			[4]: var94_upvw (read and write)
		]]
		if not arg1._started then
		elseif arg1_15.UserInputType == Enum.UserInputType.MouseButton1 and var92_upvw then
			var92_upvw = false
			var93_upvw = nil
			var94_upvw = 0
		end
	end)
	function generateDragScalar_upvr(arg1_16, arg2_7, arg3) -- Line 520, Named "generateDragScalar"
		--[[ Upvalues[8]:
			[1]: tbl_3_upvr (readonly)
			[2]: arg2 (readonly)
			[3]: arg1 (readonly)
			[4]: getValueByIndex_upvr (readonly)
			[5]: updateValueByIndex_upvr (readonly)
			[6]: DragMouseDown_upvr (readonly)
			[7]: tbl_2_upvr (readonly)
			[8]: tbl_upvr (readonly)
		]]
		local module_2 = {
			hasState = true;
			hasChildren = false;
			Args = {
				Text = 1;
				Increment = 2;
				Min = 3;
				Max = 4;
				Format = 5;
			};
			Events = {
				numberChanged = tbl_3_upvr;
				hovered = arg2.EVENTS.hover(function(arg1_17) -- Line 533
					return arg1_17.Instance
				end);
			};
		}
		local function Generate(arg1_18) -- Line 537
			--[[ Upvalues[7]:
				[1]: arg1_16 (readonly)
				[2]: arg2 (copied, readonly)
				[3]: arg1 (copied, readonly)
				[4]: arg2_7 (readonly)
				[5]: getValueByIndex_upvr (copied, readonly)
				[6]: updateValueByIndex_upvr (copied, readonly)
				[7]: DragMouseDown_upvr (copied, readonly)
			]]
			arg1_18.lastClickedTime = -1
			arg1_18.lastClickedPosition = Vector2.zero
			local Frame_5 = Instance.new("Frame")
			Frame_5.Name = "Drag"..arg1_16
			Frame_5.Size = UDim2.fromScale(1, 0)
			Frame_5.BackgroundTransparency = 1
			Frame_5.BorderSizePixel = 0
			Frame_5.LayoutOrder = arg1_18.ZIndex
			Frame_5.AutomaticSize = Enum.AutomaticSize.Y
			arg2.UIListLayout(Frame_5, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local var112 = 0
			local var113 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
			if arg1_16 == "Color3" or arg1_16 == "Color4" then
				var112 += arg1._config.ItemInnerSpacing.X + var113
				local ImageLabel = Instance.new("ImageLabel")
				ImageLabel.Name = "ColorBox"
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Size = UDim2.fromOffset(var113, var113)
				ImageLabel.LayoutOrder = 5
				ImageLabel.Image = arg2.ICONS.ALPHA_BACKGROUND_TEXTURE
				ImageLabel.ImageTransparency = 1
				arg2.applyFrameStyle(ImageLabel, true)
				ImageLabel.Parent = Frame_5
			end
			local udim_2 = UDim.new(arg1._config.ContentWidth.Scale / arg2_7, (arg1._config.ContentWidth.Offset - arg1._config.ItemInnerSpacing.X * (arg2_7 - 1) - var112) / arg2_7)
			for i_3_upvr = 1, arg2_7 do
				local TextButton = Instance.new("TextButton")
				TextButton.Name = "DragField"..tostring(i_3_upvr)
				TextButton.LayoutOrder = i_3_upvr
				if i_3_upvr == arg2_7 then
					TextButton.Size = UDim2.new(arg1._config.ContentWidth - UDim.new(udim_2.Scale * (arg2_7 - 1), udim_2.Offset * (arg2_7 - 1) + arg1._config.ItemInnerSpacing.X * (arg2_7 - 1) + var112), arg1._config.ContentHeight)
				else
					TextButton.Size = UDim2.new(udim_2, arg1._config.ContentHeight)
				end
				TextButton.AutomaticSize = Enum.AutomaticSize.Y
				TextButton.BackgroundColor3 = arg1._config.FrameBgColor
				TextButton.BackgroundTransparency = arg1._config.FrameBgTransparency
				TextButton.AutoButtonColor = false
				TextButton.Text = ""
				TextButton.ClipsDescendants = true
				arg2.applyFrameStyle(TextButton)
				arg2.applyTextStyle(TextButton)
				arg2.UISizeConstraint(TextButton, Vector2.new(1, 0))
				TextButton.TextXAlignment = Enum.TextXAlignment.Center
				TextButton.Parent = Frame_5
				arg2.applyInteractionHighlights(arg1_18, TextButton, TextButton, {
					ButtonColor = arg1._config.FrameBgColor;
					ButtonTransparency = arg1._config.FrameBgTransparency;
					ButtonHoveredColor = arg1._config.FrameBgHoveredColor;
					ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency;
					ButtonActiveColor = arg1._config.FrameBgActiveColor;
					ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency;
				})
				local TextBox_upvr = Instance.new("TextBox")
				TextBox_upvr.Name = "InputField"
				TextBox_upvr.Size = UDim2.new(1, 0, 1, 0)
				TextBox_upvr.BackgroundTransparency = 1
				TextBox_upvr.ClearTextOnFocus = false
				TextBox_upvr.TextTruncate = Enum.TextTruncate.AtEnd
				TextBox_upvr.ClipsDescendants = true
				TextBox_upvr.Visible = false
				arg2.applyFrameStyle(TextBox_upvr, true)
				arg2.applyTextStyle(TextBox_upvr)
				TextBox_upvr.Parent = TextButton
				TextBox_upvr.FocusLost:Connect(function() -- Line 625
					--[[ Upvalues[7]:
						[1]: TextBox_upvr (readonly)
						[2]: arg1_18 (readonly)
						[3]: arg1_16 (copied, readonly)
						[4]: i_3_upvr (readonly)
						[5]: getValueByIndex_upvr (copied, readonly)
						[6]: updateValueByIndex_upvr (copied, readonly)
						[7]: arg1 (copied, readonly)
					]]
					-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
					local var120
					if arg1_16 == "Color4" and i_3_upvr == 4 then
						var120 = arg1_18.state.transparency
					elseif arg1_16 == "Color3" or arg1_16 == "Color4" then
						var120 = arg1_18.state.color
						local var121
					end
					if var121 ~= nil then
						if arg1_16 == "Color3" or arg1_16 == "Color4" and not arg1_18.arguments.UseFloats then
							var121 /= 255
						end
						if arg1_18.arguments.Min ~= nil then
							var121 = math.max(var121, getValueByIndex_upvr(arg1_18.arguments.Min, i_3_upvr, arg1_18.arguments))
						end
						if arg1_18.arguments.Max ~= nil then
							var121 = math.min(var121, getValueByIndex_upvr(arg1_18.arguments.Max, i_3_upvr, arg1_18.arguments))
						end
						if arg1_18.arguments.Increment then
							var121 = math.round(var121 / getValueByIndex_upvr(arg1_18.arguments.Increment, i_3_upvr, arg1_18.arguments)) * getValueByIndex_upvr(arg1_18.arguments.Increment, i_3_upvr, arg1_18.arguments)
						end
						var120:set(updateValueByIndex_upvr(var120.value, i_3_upvr, var121, arg1_18.arguments))
						arg1_18.lastNumberChangedTick = arg1._cycleTick + 1
					end
					local getValueByIndex_upvr_result1_9 = getValueByIndex_upvr(var120.value, i_3_upvr, arg1_18.arguments)
					if arg1_16 == "Color3" or arg1_16 == "Color4" and not arg1_18.arguments.UseFloats then
						getValueByIndex_upvr_result1_9 = math.round(getValueByIndex_upvr_result1_9 * 255)
					end
					if not arg1_18.arguments.Format[i_3_upvr] then
					end
					if arg1_18.arguments.Prefix then
					end
					TextBox_upvr.Text = string.format(arg1_18.arguments.Prefix[i_3_upvr]..arg1_18.arguments.Format[1], getValueByIndex_upvr_result1_9)
					arg1_18.state.editingText:set(0)
					TextBox_upvr:ReleaseFocus(true)
				end)
				TextBox_upvr.Focused:Connect(function() -- Line 667
					--[[ Upvalues[3]:
						[1]: TextBox_upvr (readonly)
						[2]: arg1_18 (readonly)
						[3]: i_3_upvr (readonly)
					]]
					TextBox_upvr.CursorPosition = #TextBox_upvr.Text + 1
					TextBox_upvr.SelectionStart = 1
					arg1_18.state.editingText:set(i_3_upvr)
				end)
				arg2.applyButtonDown(arg1_18, TextButton, function(arg1_19, arg2_8) -- Line 675
					--[[ Upvalues[4]:
						[1]: DragMouseDown_upvr (copied, readonly)
						[2]: arg1_18 (readonly)
						[3]: arg1_16 (copied, readonly)
						[4]: i_3_upvr (readonly)
					]]
					DragMouseDown_upvr(arg1_18, arg1_16, i_3_upvr, arg1_19, arg2_8)
				end)
			end
			local TextLabel_3 = Instance.new("TextLabel")
			TextLabel_3.Name = "TextLabel"
			TextLabel_3.BackgroundTransparency = 1
			TextLabel_3.BorderSizePixel = 0
			TextLabel_3.LayoutOrder = 6
			TextLabel_3.AutomaticSize = Enum.AutomaticSize.XY
			arg2.applyTextStyle(TextLabel_3)
			TextLabel_3.Parent = Frame_5
			return Frame_5
		end
		module_2.Generate = Generate
		local function Update(arg1_20) -- Line 693
			--[[ Upvalues[5]:
				[1]: arg1_16 (readonly)
				[2]: arg2_7 (readonly)
				[3]: tbl_2_upvr (copied, readonly)
				[4]: getValueByIndex_upvr (copied, readonly)
				[5]: tbl_upvr (copied, readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local Text_4 = arg1_20.arguments.Text
			if not Text_4 then
				Text_4 = `Drag {arg1_16}`
			end
			arg1_20.Instance.TextLabel.Text = Text_4
			if arg1_20.arguments.Format then
				if typeof(arg1_20.arguments.Format) ~= "table" then
					arg1_20.arguments.Format = {arg1_20.arguments.Format}
					return
				end
			end
			if not arg1_20.arguments.Format then
				for i_4 = 1, arg2_7 do
					local var146 = tbl_2_upvr[arg1_16][i_4]
					local var147
					if arg1_20.arguments.Increment then
						local getValueByIndex_result1_5 = getValueByIndex_upvr(arg1_20.arguments.Increment, i_4, arg1_20.arguments)
						if getValueByIndex_result1_5 == 0 then
							var147 = 1
						else
							var147 = getValueByIndex_result1_5
						end
						local maximum_5 = math.max(var146, math.ceil(-math.log10(var147)), var146)
					end
					if arg1_20.arguments.Max then
						local getValueByIndex_result1_3 = getValueByIndex_upvr(arg1_20.arguments.Max, i_4, arg1_20.arguments)
						if getValueByIndex_result1_3 == 0 then
							var147 = 1
						else
							var147 = getValueByIndex_result1_3
						end
						local maximum = math.max(maximum_5, math.ceil(-math.log10(var147)), maximum_5)
					end
					if arg1_20.arguments.Min then
						local getValueByIndex_upvr_result1_2 = getValueByIndex_upvr(arg1_20.arguments.Min, i_4, arg1_20.arguments)
						if getValueByIndex_upvr_result1_2 == 0 then
							var147 = 1
						else
							var147 = getValueByIndex_upvr_result1_2
						end
						local maximum_2 = math.max(maximum, math.ceil(-math.log10(var147)), maximum)
					end
					if 0 < maximum_2 then
						({})[i_4] = `%.{maximum_2}f`
					else
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						-- ({})[i_4] = "%d"
					end
				end
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				arg1_20.arguments.Format = {}
				arg1_20.arguments.Prefix = tbl_upvr[arg1_16]
			end
		end
		module_2.Update = Update
		local function Discard(arg1_21) -- Line 733
			--[[ Upvalues[1]:
				[1]: arg2 (copied, readonly)
			]]
			arg1_21.Instance:Destroy()
			arg2.discardState(arg1_21)
		end
		module_2.Discard = Discard
		local function GenerateState(arg1_22) -- Line 737
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: arg3 (readonly)
			]]
			if arg1_22.state.number == nil then
				arg1_22.state.number = arg1._widgetState(arg1_22, "number", arg3)
			end
			if arg1_22.state.editingText == nil then
				arg1_22.state.editingText = arg1._widgetState(arg1_22, "editingText", false)
			end
		end
		module_2.GenerateState = GenerateState
		local function UpdateState(arg1_23) -- Line 745
			--[[ Upvalues[4]:
				[1]: arg2_7 (readonly)
				[2]: arg1_16 (readonly)
				[3]: getValueByIndex_upvr (copied, readonly)
				[4]: arg1 (copied, readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local Instance_5 = arg1_23.Instance
			for i_5 = 1, arg2_7 do
				local var159
				local function INLINED_5() -- Internal function, doesn't exist in bytecode
					var159 = arg1_23.state.color
					return i_5 == 4
				end
				if arg1_16 == "Color3" or arg1_16 == "Color4" or INLINED_5() then
					var159 = arg1_23.state.transparency
				end
				local SOME_3 = Instance_5:FindFirstChild("DragField"..tostring(i_5))
				local InputField_3 = SOME_3.InputField
				local getValueByIndex_upvr_result1_3 = getValueByIndex_upvr(var159.value, i_5, arg1_23.arguments)
				if arg1_16 == "Color3" or arg1_16 == "Color4" or not arg1_23.arguments.UseFloats then
					getValueByIndex_upvr_result1_3 = math.round(getValueByIndex_upvr_result1_3 * 255)
				end
				if not arg1_23.arguments.Format[i_5] then
				end
				if arg1_23.arguments.Prefix then
				end
				SOME_3.Text = string.format(arg1_23.arguments.Prefix[i_5]..arg1_23.arguments.Format[1], getValueByIndex_upvr_result1_3)
				InputField_3.Text = tostring(getValueByIndex_upvr_result1_3)
				if arg1_23.state.editingText.value == i_5 then
					InputField_3.Visible = true
					InputField_3:CaptureFocus()
					SOME_3.TextTransparency = 1
				else
					InputField_3.Visible = false
					SOME_3.TextTransparency = arg1._config.TextTransparency
				end
			end
			if arg1_16 == "Color3" or arg1_16 == "Color4" then
				local ColorBox = Instance_5.ColorBox
				var159 = arg1_23.state
				i_5 = var159.color
				ColorBox.BackgroundColor3 = i_5.value
				if arg1_16 == "Color4" then
					var159 = arg1_23.state.transparency
					i_5 = var159.value
					ColorBox.ImageTransparency = 1 - i_5
				end
			end
		end
		module_2.UpdateState = UpdateState
		return module_2
	end
	local var104_upvw = generateDragScalar_upvr
	local function generateColorDragScalar(arg1_24, ...) -- Line 793
		--[[ Upvalues[4]:
			[1]: var104_upvw (read and write)
			[2]: arg2 (readonly)
			[3]: tbl_upvr (readonly)
			[4]: arg1 (readonly)
		]]
		local args_list_upvr = {...}
		local var165
		if arg1_24 == "Color4" then
			var165 = 4
		else
			var165 = 3
		end
		var165 = arg2
		var165 = var104_upvw(arg1_24, var165, args_list_upvr[1])
		local module_5 = {
			Args = {
				Text = 1;
				UseFloats = 2;
				UseHSV = 3;
				Format = 4;
			};
		}
		local function Update(arg1_25) -- Line 804
			--[[ Upvalues[3]:
				[1]: arg1_24 (readonly)
				[2]: tbl_upvr (copied, readonly)
				[3]: arg1 (copied, readonly)
			]]
			local Text_2 = arg1_25.arguments.Text
			if not Text_2 then
				Text_2 = `Drag {arg1_24}`
			end
			arg1_25.Instance.TextLabel.Text = Text_2
			if arg1_25.arguments.Format then
				if typeof(arg1_25.arguments.Format) ~= "table" then
					arg1_25.arguments.Format = {arg1_25.arguments.Format}
					-- KONSTANTWARNING: GOTO [90] #57
				end
			end
			local var170
			if not arg1_25.arguments.Format then
				if arg1_25.arguments.UseFloats then
					arg1_25.arguments.Format = {"%.3f"}
				else
					arg1_25.arguments.Format = {"%d"}
				end
				if arg1_25.arguments.UseHSV then
					var170 = "_HSV"
				else
					var170 = "_RGB"
				end
				arg1_25.arguments.Prefix = tbl_upvr[arg1_24..var170]
			end
			arg1_25.arguments.Min = {0, 0, 0, 0}
			arg1_25.arguments.Max = {1, 1, 1, 1}
			arg1_25.arguments.Increment = {0.001, 0.001, 0.001, 0.001}
			if arg1_25.state then
				arg1._widgets[arg1_25.type].UpdateState(arg1_25)
			end
		end
		module_5.Update = Update
		local function GenerateState(arg1_26) -- Line 831
			--[[ Upvalues[3]:
				[1]: arg1 (copied, readonly)
				[2]: args_list_upvr (readonly)
				[3]: arg1_24 (readonly)
			]]
			if arg1_26.state.color == nil then
				arg1_26.state.color = arg1._widgetState(arg1_26, "color", args_list_upvr[1])
			end
			if arg1_24 == "Color4" then
				if arg1_26.state.transparency == nil then
					arg1_26.state.transparency = arg1._widgetState(arg1_26, "transparency", args_list_upvr[2])
				end
			end
			if arg1_26.state.editingText == nil then
				arg1_26.state.editingText = arg1._widgetState(arg1_26, "editingText", false)
			end
		end
		module_5.GenerateState = GenerateState
		return var165.extend(var165, module_5)
	end
	local var176_upvw = false
	local var177_upvw
	local var178_upvw = 0
	local var179_upvw = ""
	local function updateActiveSlider_upvr() -- Line 859, Named "updateActiveSlider"
		--[[ Upvalues[11]:
			[1]: var176_upvw (read and write)
			[2]: var177_upvw (read and write)
			[3]: var178_upvw (read and write)
			[4]: getValueByIndex_upvr (readonly)
			[5]: tbl_upvr_2 (readonly)
			[6]: var179_upvw (read and write)
			[7]: tbl_4_upvr (readonly)
			[8]: tbl_upvr_3 (readonly)
			[9]: arg2 (readonly)
			[10]: updateValueByIndex_upvr (readonly)
			[11]: arg1 (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var180
		if var176_upvw == false then
		else
			if var177_upvw == nil then return end
			var180 = tostring(var178_upvw)
			local SOME_2 = var177_upvw.Instance:FindFirstChild("SliderField"..var180)
			var180 = var177_upvw.arguments
			local function INLINED_6() -- Internal function, doesn't exist in bytecode
				var180 = var178_upvw
				var180 = var177_upvw.arguments
				return getValueByIndex_upvr(var180.Increment, var180, var177_upvw.arguments)
			end
			if not var180.Increment or not INLINED_6() then
				var180 = tbl_upvr_2
				var180 = var178_upvw
				local var182 = var180[var179_upvw][var180]
			end
			var180 = var177_upvw.arguments.Min
			local function INLINED_7() -- Internal function, doesn't exist in bytecode
				var180 = var177_upvw.arguments.Min
				return getValueByIndex_upvr(var180, var178_upvw, var177_upvw.arguments)
			end
			if not var180 or not INLINED_7() then
				var180 = tbl_4_upvr[var179_upvw]
				local var183 = var180[var178_upvw]
			end
			local function INLINED_8() -- Internal function, doesn't exist in bytecode
				var180 = getValueByIndex_upvr(var177_upvw.arguments.Max, var178_upvw, var177_upvw.arguments)
				return var180
			end
			if not var177_upvw.arguments.Max or not INLINED_8() then
				var180 = tbl_upvr_3[var179_upvw][var178_upvw]
			end
			local X_2 = SOME_2.GrabBar.AbsoluteSize.X
			var177_upvw.state.number:set(updateValueByIndex_upvr(var177_upvw.state.number.value, var178_upvw, math.clamp(math.round(((arg2.getMouseLocation().X) - (SOME_2.AbsolutePosition.X - arg2.GuiOffset.X + X_2 / 2)) / (SOME_2.AbsoluteSize.X - X_2) * math.floor((var180 - var183) / var182)) * var182 + var183, var183, var180), var177_upvw.arguments))
			var177_upvw.lastNumberChangedTick = arg1._cycleTick + 1
		end
	end
	local function SliderMouseDown_upvr(arg1_27, arg2_9, arg3) -- Line 885, Named "SliderMouseDown"
		--[[ Upvalues[6]:
			[1]: arg2 (readonly)
			[2]: var176_upvw (read and write)
			[3]: var177_upvw (read and write)
			[4]: var178_upvw (read and write)
			[5]: var179_upvw (read and write)
			[6]: updateActiveSlider_upvr (readonly)
		]]
		local any_IsKeyDown_result1_3 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
		if not any_IsKeyDown_result1_3 then
			any_IsKeyDown_result1_3 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
		end
		if any_IsKeyDown_result1_3 then
			arg1_27.state.editingText:set(arg3)
		else
			var176_upvw = true
			var177_upvw = arg1_27
			var178_upvw = arg3
			var179_upvw = arg2_9
			updateActiveSlider_upvr()
		end
	end
	arg2.registerEvent("InputChanged", function() -- Line 898
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: updateActiveSlider_upvr (readonly)
		]]
		if not arg1._started then
		else
			updateActiveSlider_upvr()
		end
	end)
	arg2.registerEvent("InputEnded", function(arg1_28) -- Line 905
		--[[ Upvalues[5]:
			[1]: arg1 (readonly)
			[2]: var176_upvw (read and write)
			[3]: var177_upvw (read and write)
			[4]: var178_upvw (read and write)
			[5]: var179_upvw (read and write)
		]]
		if not arg1._started then
		elseif arg1_28.UserInputType == Enum.UserInputType.MouseButton1 and var176_upvw then
			var176_upvw = false
			var177_upvw = nil
			var178_upvw = 0
			var179_upvw = ""
		end
	end)
	local function generateSliderScalar_upvw(arg1_29, arg2_10, arg3) -- Line 917, Named "generateSliderScalar"
		--[[ Upvalues[11]:
			[1]: tbl_3_upvr (readonly)
			[2]: arg2 (readonly)
			[3]: arg1 (readonly)
			[4]: getValueByIndex_upvr (readonly)
			[5]: updateValueByIndex_upvr (readonly)
			[6]: SliderMouseDown_upvr (readonly)
			[7]: tbl_2_upvr (readonly)
			[8]: tbl_upvr (readonly)
			[9]: tbl_upvr_2 (readonly)
			[10]: tbl_4_upvr (readonly)
			[11]: tbl_upvr_3 (readonly)
		]]
		local module_6 = {
			hasState = true;
			hasChildren = false;
			Args = {
				Text = 1;
				Increment = 2;
				Min = 3;
				Max = 4;
				Format = 5;
			};
			Events = {
				numberChanged = tbl_3_upvr;
				hovered = arg2.EVENTS.hover(function(arg1_30) -- Line 930
					return arg1_30.Instance
				end);
			};
		}
		local function Generate(arg1_31) -- Line 934
			--[[ Upvalues[7]:
				[1]: arg1_29 (readonly)
				[2]: arg2 (copied, readonly)
				[3]: arg1 (copied, readonly)
				[4]: arg2_10 (readonly)
				[5]: getValueByIndex_upvr (copied, readonly)
				[6]: updateValueByIndex_upvr (copied, readonly)
				[7]: SliderMouseDown_upvr (copied, readonly)
			]]
			local Frame = Instance.new("Frame")
			Frame.Name = "Slider"..arg1_29
			Frame.Size = UDim2.fromScale(1, 0)
			Frame.BackgroundTransparency = 1
			Frame.BorderSizePixel = 0
			Frame.LayoutOrder = arg1_31.ZIndex
			Frame.AutomaticSize = Enum.AutomaticSize.Y
			arg2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local udim = UDim.new(arg1._config.ContentWidth.Scale / arg2_10, (arg1._config.ContentWidth.Offset - arg1._config.ItemInnerSpacing.X * (arg2_10 - 1)) / arg2_10)
			for i_6_upvr = 1, arg2_10 do
				local TextButton_2 = Instance.new("TextButton")
				TextButton_2.Name = "SliderField"..tostring(i_6_upvr)
				TextButton_2.LayoutOrder = i_6_upvr
				if i_6_upvr == arg2_10 then
					TextButton_2.Size = UDim2.new(arg1._config.ContentWidth - UDim.new(udim.Scale * (arg2_10 - 1), udim.Offset * (arg2_10 - 1) + arg1._config.ItemInnerSpacing.X * (arg2_10 - 1)), arg1._config.ContentHeight)
				else
					TextButton_2.Size = UDim2.new(udim, arg1._config.ContentHeight)
				end
				TextButton_2.AutomaticSize = Enum.AutomaticSize.Y
				TextButton_2.BackgroundColor3 = arg1._config.FrameBgColor
				TextButton_2.BackgroundTransparency = arg1._config.FrameBgTransparency
				TextButton_2.AutoButtonColor = false
				TextButton_2.Text = ""
				TextButton_2.ClipsDescendants = true
				arg2.applyFrameStyle(TextButton_2)
				arg2.applyTextStyle(TextButton_2)
				arg2.UISizeConstraint(TextButton_2, Vector2.new(1, 0))
				TextButton_2.Parent = Frame
				local TextLabel_2 = Instance.new("TextLabel")
				TextLabel_2.Name = "OverlayText"
				TextLabel_2.Size = UDim2.fromScale(1, 1)
				TextLabel_2.BackgroundTransparency = 1
				TextLabel_2.BorderSizePixel = 0
				TextLabel_2.ZIndex = 10
				TextLabel_2.ClipsDescendants = true
				arg2.applyTextStyle(TextLabel_2)
				TextLabel_2.TextXAlignment = Enum.TextXAlignment.Center
				TextLabel_2.Parent = TextButton_2
				arg2.applyInteractionHighlights(arg1_31, TextButton_2, TextButton_2, {
					ButtonColor = arg1._config.FrameBgColor;
					ButtonTransparency = arg1._config.FrameBgTransparency;
					ButtonHoveredColor = arg1._config.FrameBgHoveredColor;
					ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency;
					ButtonActiveColor = arg1._config.FrameBgActiveColor;
					ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency;
				})
				local TextBox_upvr_3 = Instance.new("TextBox")
				TextBox_upvr_3.Name = "InputField"
				TextBox_upvr_3.Size = UDim2.new(1, 0, 1, 0)
				TextBox_upvr_3.BackgroundTransparency = 1
				TextBox_upvr_3.ClearTextOnFocus = false
				TextBox_upvr_3.TextTruncate = Enum.TextTruncate.AtEnd
				TextBox_upvr_3.ClipsDescendants = true
				TextBox_upvr_3.Visible = false
				arg2.applyFrameStyle(TextBox_upvr_3, true)
				arg2.applyTextStyle(TextBox_upvr_3)
				TextBox_upvr_3.Parent = TextButton_2
				TextBox_upvr_3.FocusLost:Connect(function() -- Line 1011
					--[[ Upvalues[6]:
						[1]: TextBox_upvr_3 (readonly)
						[2]: arg1_31 (readonly)
						[3]: getValueByIndex_upvr (copied, readonly)
						[4]: i_6_upvr (readonly)
						[5]: updateValueByIndex_upvr (copied, readonly)
						[6]: arg1 (copied, readonly)
					]]
					-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
					local var200
					if var200 ~= nil then
						if arg1_31.arguments.Min ~= nil then
							var200 = math.max(var200, getValueByIndex_upvr(arg1_31.arguments.Min, i_6_upvr, arg1_31.arguments))
						end
						if arg1_31.arguments.Max ~= nil then
							var200 = math.min(var200, getValueByIndex_upvr(arg1_31.arguments.Max, i_6_upvr, arg1_31.arguments))
						end
						if arg1_31.arguments.Increment then
							var200 = math.round(var200 / getValueByIndex_upvr(arg1_31.arguments.Increment, i_6_upvr, arg1_31.arguments)) * getValueByIndex_upvr(arg1_31.arguments.Increment, i_6_upvr, arg1_31.arguments)
						end
						arg1_31.state.number:set(updateValueByIndex_upvr(arg1_31.state.number.value, i_6_upvr, var200, arg1_31.arguments))
						arg1_31.lastNumberChangedTick = arg1._cycleTick + 1
					end
					if not arg1_31.arguments.Format[i_6_upvr] then
					end
					if arg1_31.arguments.Prefix then
					end
					TextBox_upvr_3.Text = string.format(arg1_31.arguments.Prefix[i_6_upvr]..arg1_31.arguments.Format[1], getValueByIndex_upvr(arg1_31.state.number.value, i_6_upvr, arg1_31.arguments))
					arg1_31.state.editingText:set(0)
					TextBox_upvr_3:ReleaseFocus(true)
				end)
				TextBox_upvr_3.Focused:Connect(function() -- Line 1040
					--[[ Upvalues[3]:
						[1]: TextBox_upvr_3 (readonly)
						[2]: arg1_31 (readonly)
						[3]: i_6_upvr (readonly)
					]]
					TextBox_upvr_3.CursorPosition = #TextBox_upvr_3.Text + 1
					TextBox_upvr_3.SelectionStart = 1
					arg1_31.state.editingText:set(i_6_upvr)
				end)
				arg2.applyButtonDown(arg1_31, TextButton_2, function() -- Line 1048
					--[[ Upvalues[4]:
						[1]: SliderMouseDown_upvr (copied, readonly)
						[2]: arg1_31 (readonly)
						[3]: arg1_29 (copied, readonly)
						[4]: i_6_upvr (readonly)
					]]
					SliderMouseDown_upvr(arg1_31, arg1_29, i_6_upvr)
				end)
				local Frame_3 = Instance.new("Frame")
				Frame_3.Name = "GrabBar"
				Frame_3.ZIndex = 5
				Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame_3.Position = UDim2.new(0, 0, 0.5, 0)
				Frame_3.BorderSizePixel = 0
				Frame_3.BackgroundColor3 = arg1._config.SliderGrabColor
				Frame_3.Transparency = arg1._config.SliderGrabTransparency
				if 0 < arg1._config.GrabRounding then
					arg2.UICorner(Frame_3, arg1._config.GrabRounding)
				end
				arg2.UISizeConstraint(Frame_3, Vector2.new(arg1._config.GrabMinSize, 0))
				Frame_3.Parent = TextButton_2
			end
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.LayoutOrder = 5
			TextLabel.AutomaticSize = Enum.AutomaticSize.XY
			arg2.applyTextStyle(TextLabel)
			TextLabel.Parent = Frame
			return Frame
		end
		module_6.Generate = Generate
		local function Update(arg1_32) -- Line 1082
			--[[ Upvalues[9]:
				[1]: arg1_29 (readonly)
				[2]: arg2_10 (readonly)
				[3]: tbl_2_upvr (copied, readonly)
				[4]: getValueByIndex_upvr (copied, readonly)
				[5]: tbl_upvr (copied, readonly)
				[6]: tbl_upvr_2 (copied, readonly)
				[7]: tbl_4_upvr (copied, readonly)
				[8]: tbl_upvr_3 (copied, readonly)
				[9]: arg1 (copied, readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local Instance_4 = arg1_32.Instance
			local Text = arg1_32.arguments.Text
			if not Text then
				Text = `Slider {arg1_29}`
			end
			Instance_4.TextLabel.Text = Text
			if arg1_32.arguments.Format then
				if typeof(arg1_32.arguments.Format) ~= "table" then
					arg1_32.arguments.Format = {arg1_32.arguments.Format}
					-- KONSTANTWARNING: GOTO [193] #137
				end
			end
			if not arg1_32.arguments.Format then
				for i_7 = 1, arg2_10 do
					local var216 = tbl_2_upvr[arg1_29][i_7]
					local var217
					if arg1_32.arguments.Increment then
						local getValueByIndex_upvr_result1_7 = getValueByIndex_upvr(arg1_32.arguments.Increment, i_7, arg1_32.arguments)
						if getValueByIndex_upvr_result1_7 == 0 then
							var217 = 1
						else
							var217 = getValueByIndex_upvr_result1_7
						end
						local maximum_9 = math.max(var216, math.ceil(-math.log10(var217)), var216)
					end
					if arg1_32.arguments.Max then
						local getValueByIndex_upvr_result1 = getValueByIndex_upvr(arg1_32.arguments.Max, i_7, arg1_32.arguments)
						if getValueByIndex_upvr_result1 == 0 then
							var217 = 1
						else
							var217 = getValueByIndex_upvr_result1
						end
						local maximum_7 = math.max(maximum_9, math.ceil(-math.log10(var217)), maximum_9)
					end
					if arg1_32.arguments.Min then
						local getValueByIndex_upvr_result1_6 = getValueByIndex_upvr(arg1_32.arguments.Min, i_7, arg1_32.arguments)
						if getValueByIndex_upvr_result1_6 == 0 then
							var217 = 1
						else
							var217 = getValueByIndex_upvr_result1_6
						end
						local maximum_11 = math.max(maximum_7, math.ceil(-math.log10(var217)), maximum_7)
					end
					if 0 < maximum_11 then
						({})[i_7] = `%.{maximum_11}f`
					else
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						-- ({})[i_7] = "%d"
					end
				end
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				arg1_32.arguments.Format = {}
				arg1_32.arguments.Prefix = tbl_upvr[arg1_29]
			end
			for i_8 = 1, arg2_10 do
				local var224
				local function INLINED_9() -- Internal function, doesn't exist in bytecode
					var224 = i_8
					var224 = arg1_32.arguments
					return getValueByIndex_upvr(var224.Increment, var224, arg1_32.arguments)
				end
				if not arg1_32.arguments.Increment or not INLINED_9() then
					var224 = tbl_upvr_2
				end
				var224 = arg1_32.arguments.Min
				local function INLINED_10() -- Internal function, doesn't exist in bytecode
					var224 = arg1_32.arguments.Min
					return getValueByIndex_upvr(var224, i_8, arg1_32.arguments)
				end
				if not var224 or not INLINED_10() then
					var224 = tbl_4_upvr[arg1_29]
				end
				local function INLINED_11() -- Internal function, doesn't exist in bytecode
					var224 = getValueByIndex_upvr(arg1_32.arguments.Max, i_8, arg1_32.arguments)
					return var224
				end
				if not arg1_32.arguments.Max or not INLINED_11() then
					var224 = tbl_upvr_3[arg1_29][i_8]
				end
				Instance_4:FindFirstChild("SliderField"..tostring(i_8)).GrabBar.Size = UDim2.new(1 / math.floor((var224 + 1 - var224[i_8]) / var224[arg1_29][i_8]), 0, 1, 0)
			end
			local var225_upvr = #arg1._postCycleCallbacks + 1
			local var227_upvr = arg1._cycleTick + 1
			arg1._postCycleCallbacks[var225_upvr] = function() -- Line 1137
				--[[ Upvalues[5]:
					[1]: arg1 (copied, readonly)
					[2]: var227_upvr (readonly)
					[3]: arg1_32 (readonly)
					[4]: arg1_29 (copied, readonly)
					[5]: var225_upvr (readonly)
				]]
				if var227_upvr <= arg1._cycleTick then
					if arg1_32.lastCycleTick ~= -1 then
						arg1._widgets[`Slider{arg1_29}`].UpdateState(arg1_32)
					end
					arg1._postCycleCallbacks[var225_upvr] = nil
				end
			end
		end
		module_6.Update = Update
		local function Discard(arg1_33) -- Line 1146
			--[[ Upvalues[1]:
				[1]: arg2 (copied, readonly)
			]]
			arg1_33.Instance:Destroy()
			arg2.discardState(arg1_33)
		end
		module_6.Discard = Discard
		local function GenerateState(arg1_34) -- Line 1150
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: arg3 (readonly)
			]]
			if arg1_34.state.number == nil then
				arg1_34.state.number = arg1._widgetState(arg1_34, "number", arg3)
			end
			if arg1_34.state.editingText == nil then
				arg1_34.state.editingText = arg1._widgetState(arg1_34, "editingText", false)
			end
		end
		module_6.GenerateState = GenerateState
		local function UpdateState(arg1_35) -- Line 1158
			--[[ Upvalues[6]:
				[1]: arg2_10 (readonly)
				[2]: getValueByIndex_upvr (copied, readonly)
				[3]: tbl_upvr_2 (copied, readonly)
				[4]: arg1_29 (readonly)
				[5]: tbl_4_upvr (copied, readonly)
				[6]: tbl_upvr_3 (copied, readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			for i_9 = 1, arg2_10 do
				local SOME = arg1_35.Instance:FindFirstChild("SliderField"..tostring(i_9))
				local InputField = SOME.InputField
				local OverlayText = SOME.OverlayText
				local GrabBar = SOME.GrabBar
				local getValueByIndex_upvr_result1_5 = getValueByIndex_upvr(arg1_35.state.number.value, i_9, arg1_35.arguments)
				local var237
				if not var237 then
					var237 = arg1_35.arguments.Format[1]
				end
				if arg1_35.arguments.Prefix then
					var237 = arg1_35.arguments.Prefix[i_9]..var237
				end
				OverlayText.Text = string.format(var237, getValueByIndex_upvr_result1_5)
				InputField.Text = tostring(getValueByIndex_upvr_result1_5)
				if not arg1_35.arguments.Increment or not getValueByIndex_upvr(arg1_35.arguments.Increment, i_9, arg1_35.arguments) then
				end
				if not arg1_35.arguments.Min or not getValueByIndex_upvr(arg1_35.arguments.Min, i_9, arg1_35.arguments) then
					local var238 = tbl_4_upvr[arg1_29][i_9]
				end
				if not arg1_35.arguments.Max or not getValueByIndex_upvr(arg1_35.arguments.Max, i_9, arg1_35.arguments) then
					local var239 = tbl_upvr_3[arg1_29][i_9]
				end
				local X = SOME.AbsoluteSize.X
				local var241 = X - GrabBar.AbsoluteSize.X
				local floored = math.floor((var239 - var238) / tbl_upvr_2[arg1_29][i_9])
				GrabBar.Position = UDim2.new(var241 / X * math.clamp(math.floor((getValueByIndex_upvr_result1_5 - var238) / (var239 - var238) * floored) / floored, 0, 1) + (1 - var241 / X) / 2, 0, 0.5, 0)
				if arg1_35.state.editingText.value == i_9 then
					InputField.Visible = true
					OverlayText.Visible = false
					GrabBar.Visible = false
					InputField:CaptureFocus()
				else
					InputField.Visible = false
					OverlayText.Visible = true
					GrabBar.Visible = true
				end
			end
		end
		module_6.UpdateState = UpdateState
		return module_6
	end
	local function _(arg1_36, arg2_11) -- Line 1204, Named "generateEnumSliderScalar"
		--[[ Upvalues[3]:
			[1]: generateSliderScalar_upvw (read and write)
			[2]: arg2 (readonly)
			[3]: arg1 (readonly)
		]]
		local tbl_5 = {string}
		for _, v in arg1_36:GetEnumItems() do
			tbl_5[v.Value] = v.Name
		end
		local module_4 = {
			Args = {
				Text = 1;
			};
		}
		local function Update(arg1_37) -- Line 1216
			--[[ Upvalues[1]:
				[1]: arg1_36 (readonly)
			]]
			local Instance_2 = arg1_37.Instance
			Instance_2.TextLabel.Text = arg1_37.arguments.Text or "Input Enum"
			arg1_37.arguments.Increment = 1
			arg1_37.arguments.Min = 0
			arg1_37.arguments.Max = #arg1_36:GetEnumItems() - 1
			Instance_2:FindFirstChild("SliderField1").GrabBar.Size = UDim2.new(1 / math.floor(#arg1_36:GetEnumItems()), 0, 1, 0)
		end
		module_4.Update = Update
		local function GenerateState(arg1_38) -- Line 1232
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: arg2_11 (readonly)
			]]
			if arg1_38.state.number == nil then
				arg1_38.state.number = arg1._widgetState(arg1_38, "number", arg2_11.Value)
			end
			if arg1_38.state.enumItem == nil then
				arg1_38.state.enumItem = arg1._widgetState(arg1_38, "enumItem", arg2_11)
			end
			if arg1_38.state.editingText == nil then
				arg1_38.state.editingText = arg1._widgetState(arg1_38, "editingText", false)
			end
		end
		module_4.GenerateState = GenerateState
		return arg2.extend(generateSliderScalar_upvw("Enum", 1, arg2_11.Value), module_4)
	end
	local generateInputScalar_result1 = generateInputScalar("Num", 1, 0)
	generateInputScalar_result1.Args.NoButtons = 6
	arg1.WidgetConstructor("InputNum", generateInputScalar_result1)
	arg1.WidgetConstructor("InputVector2", generateInputScalar("Vector2", 2, Vector2.zero))
	arg1.WidgetConstructor("InputVector3", generateInputScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	arg1.WidgetConstructor("InputUDim", generateInputScalar("UDim", 2, UDim.new()))
	arg1.WidgetConstructor("InputUDim2", generateInputScalar("UDim2", 4, UDim2.new()))
	arg1.WidgetConstructor("InputRect", generateInputScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	arg1.WidgetConstructor("DragNum", var104_upvw("Num", 1, 0))
	arg1.WidgetConstructor("DragVector2", var104_upvw("Vector2", 2, Vector2.zero))
	arg1.WidgetConstructor("DragVector3", var104_upvw("Vector3", 3, Vector3.new(0, 0, 0)))
	arg1.WidgetConstructor("DragUDim", var104_upvw("UDim", 2, UDim.new()))
	arg1.WidgetConstructor("DragUDim2", var104_upvw("UDim2", 4, UDim2.new()))
	arg1.WidgetConstructor("DragRect", var104_upvw("Rect", 4, Rect.new(0, 0, 0, 0)))
	arg1.WidgetConstructor("InputColor3", generateColorDragScalar("Color3", Color3.fromRGB(0, 0, 0)))
	arg1.WidgetConstructor("InputColor4", generateColorDragScalar("Color4", Color3.fromRGB(0, 0, 0), 0))
	arg1.WidgetConstructor("SliderNum", generateSliderScalar_upvw("Num", 1, 0))
	arg1.WidgetConstructor("SliderVector2", generateSliderScalar_upvw("Vector2", 2, Vector2.zero))
	arg1.WidgetConstructor("SliderVector3", generateSliderScalar_upvw("Vector3", 3, Vector3.new(0, 0, 0)))
	arg1.WidgetConstructor("SliderUDim", generateSliderScalar_upvw("UDim", 2, UDim.new()))
	arg1.WidgetConstructor("SliderUDim2", generateSliderScalar_upvw("UDim2", 4, UDim2.new()))
	arg1.WidgetConstructor("SliderRect", generateSliderScalar_upvw("Rect", 4, Rect.new(0, 0, 0, 0)))
	local tbl = {
		hasState = true;
		hasChildren = false;
		Args = {
			Text = 1;
			TextHint = 2;
			ReadOnly = 3;
			MultiLine = 4;
		};
		Events = {
			textChanged = {
				Init = function(arg1_39) -- Line 1288
					arg1_39.lastTextchangeTick = 0
				end;
				Get = function(arg1_40) -- Line 1291
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var261
					if arg1_40.lastTextchangeTick ~= arg1._cycleTick then
						var261 = false
					else
						var261 = true
					end
					return var261
				end;
			};
			hovered = arg2.EVENTS.hover(function(arg1_41) -- Line 1295
				return arg1_41.Instance
			end);
		};
	}
	function tbl.Generate(arg1_42) -- Line 1299
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local Frame_2 = Instance.new("Frame")
		Frame_2.Name = "InputText"
		Frame_2.AutomaticSize = Enum.AutomaticSize.Y
		Frame_2.Size = UDim2.fromScale(1, 0)
		Frame_2.BackgroundTransparency = 1
		Frame_2.BorderSizePixel = 0
		Frame_2.ZIndex = arg1_42.ZIndex
		Frame_2.LayoutOrder = arg1_42.ZIndex
		arg2.UIListLayout(Frame_2, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local TextBox_upvr_2 = Instance.new("TextBox")
		TextBox_upvr_2.Name = "InputField"
		TextBox_upvr_2.Size = UDim2.new(arg1._config.ContentWidth, arg1._config.ContentHeight)
		TextBox_upvr_2.AutomaticSize = Enum.AutomaticSize.Y
		TextBox_upvr_2.BackgroundColor3 = arg1._config.FrameBgColor
		TextBox_upvr_2.BackgroundTransparency = arg1._config.FrameBgTransparency
		TextBox_upvr_2.Text = ""
		TextBox_upvr_2.TextYAlignment = Enum.TextYAlignment.Top
		TextBox_upvr_2.PlaceholderColor3 = arg1._config.TextDisabledColor
		TextBox_upvr_2.ClearTextOnFocus = false
		TextBox_upvr_2.ClipsDescendants = true
		arg2.applyFrameStyle(TextBox_upvr_2)
		arg2.applyTextStyle(TextBox_upvr_2)
		arg2.UISizeConstraint(TextBox_upvr_2, Vector2.new(1, 0))
		TextBox_upvr_2.Parent = Frame_2
		TextBox_upvr_2.FocusLost:Connect(function() -- Line 1330
			--[[ Upvalues[3]:
				[1]: arg1_42 (readonly)
				[2]: TextBox_upvr_2 (readonly)
				[3]: arg1 (copied, readonly)
			]]
			arg1_42.state.text:set(TextBox_upvr_2.Text)
			arg1_42.lastTextchangeTick = arg1._cycleTick + 1
		end)
		local TextLabel_5 = Instance.new("TextLabel")
		TextLabel_5.Name = "TextLabel"
		TextLabel_5.Size = UDim2.fromOffset(0, arg1._config.TextSize + 2 * arg1._config.FramePadding.Y)
		TextLabel_5.AutomaticSize = Enum.AutomaticSize.X
		TextLabel_5.BackgroundTransparency = 1
		TextLabel_5.BorderSizePixel = 0
		TextLabel_5.LayoutOrder = 1
		arg2.applyTextStyle(TextLabel_5)
		TextLabel_5.Parent = Frame_2
		return Frame_2
	end
	function tbl.Update(arg1_43) -- Line 1351
		local Instance_3 = arg1_43.Instance
		local InputField_2 = Instance_3.InputField
		Instance_3.TextLabel.Text = arg1_43.arguments.Text or "Input Text"
		InputField_2.PlaceholderText = arg1_43.arguments.TextHint or ""
		InputField_2.TextEditable = not arg1_43.arguments.ReadOnly
		InputField_2.MultiLine = arg1_43.arguments.MultiLine
	end
	function tbl.Discard(arg1_44) -- Line 1361
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		arg1_44.Instance:Destroy()
		arg2.discardState(arg1_44)
	end
	function tbl.GenerateState(arg1_45) -- Line 1365
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_45.state.text == nil then
			arg1_45.state.text = arg1._widgetState(arg1_45, "text", "")
		end
	end
	function tbl.UpdateState(arg1_46) -- Line 1370
		arg1_46.Instance.InputField.Text = arg1_46.state.text.value
	end
	arg1.WidgetConstructor("InputText", tbl)
end