-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:15
-- Luau version 6, Types version 3
-- Time taken: 0.040089 seconds

return function(arg1) -- Line 6
	local Frame_upvr_7 = Instance.new("Frame")
	Frame_upvr_7:SetAttribute("WidgetUID", arg1.UID)
	Frame_upvr_7.Name = "Widget"
	Frame_upvr_7.BackgroundTransparency = 1
	Frame_upvr_7.Visible = true
	Frame_upvr_7.ZIndex = 20
	Frame_upvr_7.Active = false
	local Frame_upvr_9 = Instance.new("Frame")
	Frame_upvr_9.Name = "IconButton"
	Frame_upvr_9.Visible = true
	Frame_upvr_9.ZIndex = 2
	Frame_upvr_9.BorderSizePixel = 0
	Frame_upvr_9.Parent = Frame_upvr_7
	Frame_upvr_9.ClipsDescendants = true
	Frame_upvr_9.Active = true
	arg1.deselected:Connect(function() -- Line 24
		--[[ Upvalues[1]:
			[1]: Frame_upvr_9 (readonly)
		]]
		Frame_upvr_9.ClipsDescendants = true
	end)
	arg1.selected:Connect(function() -- Line 27
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: Frame_upvr_9 (readonly)
		]]
		task.defer(function() -- Line 28
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: Frame_upvr_9 (copied, readonly)
			]]
			arg1.resizingComplete:Once(function() -- Line 29
				--[[ Upvalues[2]:
					[1]: arg1 (copied, readonly)
					[2]: Frame_upvr_9 (copied, readonly)
				]]
				if arg1.isSelected then
					Frame_upvr_9.ClipsDescendants = false
				end
			end)
		end)
	end)
	local UICorner_2 = Instance.new("UICorner")
	UICorner_2:SetAttribute("Collective", "IconCorners")
	UICorner_2.Parent = Frame_upvr_9
	local Frame_upvr_6 = Instance.new("Frame")
	Frame_upvr_6.Name = "IconHolder"
	Frame_upvr_6.BackgroundTransparency = 1
	Frame_upvr_6.Visible = true
	Frame_upvr_6.ZIndex = 1
	Frame_upvr_6.Active = false
	Frame_upvr_6.Size = UDim2.fromScale(1, 1)
	Frame_upvr_6.Parent = Frame_upvr_9
	local clone_3_upvr = arg1.Icon.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone()
	clone_3_upvr.Name = "MenuUIListLayout"
	clone_3_upvr.VerticalAlignment = Enum.VerticalAlignment.Center
	clone_3_upvr.Parent = Frame_upvr_6
	local Frame_upvr_3 = Instance.new("Frame")
	Frame_upvr_3.Name = "IconSpot"
	Frame_upvr_3.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
	Frame_upvr_3.BackgroundTransparency = 0.9
	Frame_upvr_3.Visible = true
	Frame_upvr_3.AnchorPoint = Vector2.new(0, 0.5)
	Frame_upvr_3.ZIndex = 5
	Frame_upvr_3.Parent = Frame_upvr_6
	local Frame_upvr_11 = Instance.new("Frame")
	Frame_upvr_11.Name = "MenuGap"
	Frame_upvr_11.BackgroundTransparency = 1
	Frame_upvr_11.Visible = false
	Frame_upvr_11.AnchorPoint = Vector2.new(0, 0.5)
	Frame_upvr_11.ZIndex = 5
	Frame_upvr_11.Parent = Frame_upvr_6
	UICorner_2:Clone().Parent = Frame_upvr_3
	local clone = Frame_upvr_3:Clone()
	clone.Name = "IconOverlay"
	clone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	clone.ZIndex = Frame_upvr_3.ZIndex + 1
	clone.Size = UDim2.new(1, 0, 1, 0)
	clone.Position = UDim2.new(0, 0, 0, 0)
	clone.AnchorPoint = Vector2.new(0, 0)
	clone.Visible = false
	clone.Parent = Frame_upvr_3
	local TextButton_upvr = Instance.new("TextButton")
	TextButton_upvr.Name = "ClickRegion"
	TextButton_upvr.BackgroundTransparency = 1
	TextButton_upvr.Visible = true
	TextButton_upvr.Text = ""
	TextButton_upvr.ZIndex = 20
	TextButton_upvr.Parent = Frame_upvr_3
	UICorner_2:Clone().Parent = TextButton_upvr
	local Frame_upvr_4 = Instance.new("Frame")
	Frame_upvr_4.Name = "Contents"
	Frame_upvr_4.BackgroundTransparency = 1
	Frame_upvr_4.Size = UDim2.fromScale(1, 1)
	Frame_upvr_4.Parent = Frame_upvr_3
	local UIListLayout_upvr = Instance.new("UIListLayout")
	UIListLayout_upvr.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_upvr.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout_upvr.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_upvr.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
	UIListLayout_upvr.Padding = UDim.new(0, 5)
	UIListLayout_upvr.Parent = Frame_upvr_4
	local Frame_upvr = Instance.new("Frame")
	Frame_upvr.Name = "PaddingLeft"
	Frame_upvr.LayoutOrder = 1
	Frame_upvr.ZIndex = 5
	Frame_upvr.Size = UDim2.new(0, 5, 1, 0)
	Frame_upvr.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_upvr.BackgroundTransparency = 1
	Frame_upvr.BorderSizePixel = 0
	Frame_upvr.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_upvr.Parent = Frame_upvr_4
	local Frame_upvr_10 = Instance.new("Frame")
	Frame_upvr_10.Name = "PaddingCenter"
	Frame_upvr_10.LayoutOrder = 3
	Frame_upvr_10.ZIndex = 5
	Frame_upvr_10.Size = UDim2.new(0, 0, 1, 0)
	Frame_upvr_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_upvr_10.BackgroundTransparency = 1
	Frame_upvr_10.BorderSizePixel = 0
	Frame_upvr_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_upvr_10.Parent = Frame_upvr_4
	local Frame_upvr_5 = Instance.new("Frame")
	Frame_upvr_5.Name = "PaddingRight"
	Frame_upvr_5.LayoutOrder = 5
	Frame_upvr_5.ZIndex = 5
	Frame_upvr_5.Size = UDim2.new(0, 5, 1, 0)
	Frame_upvr_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_upvr_5.BackgroundTransparency = 1
	Frame_upvr_5.BorderSizePixel = 0
	Frame_upvr_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_upvr_5.Parent = Frame_upvr_4
	local Frame_upvr_8 = Instance.new("Frame")
	Frame_upvr_8.Name = "IconLabelContainer"
	Frame_upvr_8.LayoutOrder = 4
	Frame_upvr_8.ZIndex = 3
	Frame_upvr_8.AnchorPoint = Vector2.new(0, 0.5)
	Frame_upvr_8.Size = UDim2.new(0, 0, 0.5, 0)
	Frame_upvr_8.BackgroundTransparency = 1
	Frame_upvr_8.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame_upvr_8.Parent = Frame_upvr_4
	local TextLabel_upvr_2 = Instance.new("TextLabel")
	local var22_upvr = workspace.CurrentCamera.ViewportSize.X + 200
	TextLabel_upvr_2.Name = "IconLabel"
	TextLabel_upvr_2.LayoutOrder = 4
	TextLabel_upvr_2.ZIndex = 15
	TextLabel_upvr_2.AnchorPoint = Vector2.new(0, 0)
	TextLabel_upvr_2.Size = UDim2.new(0, var22_upvr, 1, 0)
	TextLabel_upvr_2.ClipsDescendants = false
	TextLabel_upvr_2.BackgroundTransparency = 1
	TextLabel_upvr_2.Position = UDim2.fromScale(0, 0)
	TextLabel_upvr_2.RichText = true
	TextLabel_upvr_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_upvr_2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_upvr_2.Text = ""
	TextLabel_upvr_2.TextWrapped = true
	TextLabel_upvr_2.TextWrap = true
	TextLabel_upvr_2.TextScaled = false
	TextLabel_upvr_2.Active = false
	TextLabel_upvr_2.AutoLocalize = true
	TextLabel_upvr_2.Parent = Frame_upvr_8
	local ImageLabel_upvr = Instance.new("ImageLabel")
	ImageLabel_upvr.Name = "IconImage"
	ImageLabel_upvr.LayoutOrder = 2
	ImageLabel_upvr.ZIndex = 15
	ImageLabel_upvr.AnchorPoint = Vector2.new(0, 0.5)
	ImageLabel_upvr.Size = UDim2.new(0, 0, 0.5, 0)
	ImageLabel_upvr.BackgroundTransparency = 1
	ImageLabel_upvr.Position = UDim2.new(0, 11, 0.5, 0)
	ImageLabel_upvr.ScaleType = Enum.ScaleType.Stretch
	ImageLabel_upvr.Active = false
	ImageLabel_upvr.Parent = Frame_upvr_4
	local clone_2 = UICorner_2:Clone()
	clone_2.CornerRadius = UDim.new(0, 0)
	clone_2.Name = "IconImageCorner"
	clone_2.Parent = ImageLabel_upvr
	local TweenService_upvr = game:GetService("TweenService")
	local var26_upvw = 0
	local var27_upvw = 0
	local var28_upvw = false
	local function handleLabelAndImageChanges_upvr(arg1_2) -- Line 198, Named "handleLabelAndImageChanges"
		--[[ Upvalues[22]:
			[1]: var26_upvw (read and write)
			[2]: var28_upvw (read and write)
			[3]: handleLabelAndImageChanges_upvr (readonly)
			[4]: TextLabel_upvr_2 (readonly)
			[5]: ImageLabel_upvr (readonly)
			[6]: Frame_upvr_8 (readonly)
			[7]: Frame_upvr_10 (readonly)
			[8]: Frame_upvr (readonly)
			[9]: Frame_upvr_5 (readonly)
			[10]: UIListLayout_upvr (readonly)
			[11]: Frame_upvr_9 (readonly)
			[12]: Frame_upvr_4 (readonly)
			[13]: Frame_upvr_7 (readonly)
			[14]: var22_upvr (readonly)
			[15]: arg1 (readonly)
			[16]: Frame_upvr_6 (readonly)
			[17]: Frame_upvr_3 (readonly)
			[18]: clone_3_upvr (readonly)
			[19]: Frame_upvr_11 (readonly)
			[20]: TweenService_upvr (readonly)
			[21]: TextButton_upvr (readonly)
			[22]: var27_upvw (read and write)
		]]
		var26_upvw += 1
		task.defer(function() -- Line 207
			--[[ Upvalues[24]:
				[1]: var26_upvw (copied, read and write)
				[2]: var26_upvw (readonly)
				[3]: arg1_2 (readonly)
				[4]: var28_upvw (copied, read and write)
				[5]: handleLabelAndImageChanges_upvr (copied, readonly)
				[6]: TextLabel_upvr_2 (copied, readonly)
				[7]: ImageLabel_upvr (copied, readonly)
				[8]: Frame_upvr_8 (copied, readonly)
				[9]: Frame_upvr_10 (copied, readonly)
				[10]: Frame_upvr (copied, readonly)
				[11]: Frame_upvr_5 (copied, readonly)
				[12]: UIListLayout_upvr (copied, readonly)
				[13]: Frame_upvr_9 (copied, readonly)
				[14]: Frame_upvr_4 (copied, readonly)
				[15]: Frame_upvr_7 (copied, readonly)
				[16]: var22_upvr (copied, readonly)
				[17]: arg1 (copied, readonly)
				[18]: Frame_upvr_6 (copied, readonly)
				[19]: Frame_upvr_3 (copied, readonly)
				[20]: clone_3_upvr (copied, readonly)
				[21]: Frame_upvr_11 (copied, readonly)
				[22]: TweenService_upvr (copied, readonly)
				[23]: TextButton_upvr (copied, readonly)
				[24]: var27_upvw (copied, read and write)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			-- KONSTANTERROR: [0] 1. Error Block 106 start (CF ANALYSIS FAILED)
			local var98
			if var26_upvw ~= var98 and arg1_2 ~= "FORCE_UPDATE" then
				if not var28_upvw then
					var28_upvw = true
					var98 = 0.01
					task.delay(var98, function() -- Line 211
						--[[ Upvalues[2]:
							[1]: handleLabelAndImageChanges_upvr (copied, readonly)
							[2]: var28_upvw (copied, read and write)
						]]
						handleLabelAndImageChanges_upvr()
						var28_upvw = false
					end)
				end
			else
				var98 = TextLabel_upvr_2.Text
				if var98 == "" then
					local _ = false
					-- KONSTANTWARNING: Skipped task `defvar` above
				else
				end
				var98 = false
				if ImageLabel_upvr.Image ~= "" then
					if ImageLabel_upvr.Image == nil then
						var98 = false
					else
						var98 = true
					end
				end
				local var101
				if var98 and not true then
					Frame_upvr_8.Visible = false
					ImageLabel_upvr.Visible = true
					Frame_upvr_10.Visible = false
					Frame_upvr.Visible = false
					Frame_upvr_5.Visible = false
					-- KONSTANTWARNING: GOTO [116] #90
				end
				-- KONSTANTERROR: [0] 1. Error Block 106 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [69] 54. Error Block 107 start (CF ANALYSIS FAILED)
				if not var98 then
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					if true then
						Frame_upvr_8.Visible = true
						ImageLabel_upvr.Visible = false
						Frame_upvr_10.Visible = false
						Frame_upvr.Visible = true
						Frame_upvr_5.Visible = true
						-- KONSTANTWARNING: GOTO [116] #90
					end
				end
				if var98 then
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					if true then
						Frame_upvr_8.Visible = true
						ImageLabel_upvr.Visible = true
						Frame_upvr_10.Visible = true
						Frame_upvr.Visible = true
						Frame_upvr_5.Visible = true
						var101 = Enum.HorizontalAlignment.Left
					end
				end
				UIListLayout_upvr.HorizontalAlignment = var101
				Frame_upvr_9.Size = UDim2.fromScale(1, 1)
				local function getItemWidth(arg1_4) -- Line 247
					local TargetWidth_30 = arg1_4:GetAttribute("TargetWidth")
					if not TargetWidth_30 then
						TargetWidth_30 = arg1_4.AbsoluteSize.X
					end
					return TargetWidth_30
				end
				Frame_upvr_8.Size = UDim2.new(0, TextLabel_upvr_2.TextBounds.X, TextLabel_upvr_2.Size.Y.Scale, 0)
				for _, v in pairs(Frame_upvr_4:GetChildren()) do
					if v:IsA("GuiObject") and v.Visible == true then
						local TargetWidth_26 = v:GetAttribute("TargetWidth")
						if not TargetWidth_26 then
							TargetWidth_26 = v.AbsoluteSize.X
						end
					end
				end
				local MinimumHeight = Frame_upvr_7:GetAttribute("MinimumHeight")
				local BorderSize = Frame_upvr_7:GetAttribute("BorderSize")
				if 0 >= #arg1.menuIcons then
				else
				end
				if true then
					local isSelected_4 = arg1.isSelected
					local var110
				end
				if isSelected_4 then
					for _, v_2 in pairs(Frame_upvr_6:GetChildren()) do
						if v_2 ~= Frame_upvr_3 and v_2:IsA("GuiObject") and v_2.Visible then
							local TargetWidth_6 = v_2:GetAttribute("TargetWidth")
							if not TargetWidth_6 then
								TargetWidth_6 = v_2.AbsoluteSize.X
							end
							var110 += TargetWidth_6 + clone_3_upvr.Padding.Offset
						end
					end
					var110 -= BorderSize
				end
				Frame_upvr_11.Visible = isSelected_4
				local DesiredWidth_2 = Frame_upvr_7:GetAttribute("DesiredWidth")
				local var116
				if DesiredWidth_2 and var116 < DesiredWidth_2 then
					var116 = DesiredWidth_2
				end
				local var117 = var116 - var110 - BorderSize * 2
				local Quint_6 = Enum.EasingStyle.Quint
				local Out_7 = Enum.EasingDirection.Out
				local var120 = Frame_upvr_3
				local TargetWidth_34 = var120:GetAttribute("TargetWidth")
				if not TargetWidth_34 then
					TargetWidth_34 = var120.AbsoluteSize.X
				end
				local var122 = Frame_upvr_7
				local TargetWidth_18 = var122:GetAttribute("TargetWidth")
				if not TargetWidth_18 then
					TargetWidth_18 = var122.AbsoluteSize.X
				end
				local TweenInfo_new_result1 = TweenInfo.new(math.max(var117, TargetWidth_34, Frame_upvr_3.AbsoluteSize.X) / 750, Quint_6, Out_7)
				local TweenInfo_new_result1_8 = TweenInfo.new(math.max(var116, TargetWidth_18, Frame_upvr_7.AbsoluteSize.X) / 750, Quint_6, Out_7)
				TweenService_upvr:Create(Frame_upvr_3, TweenInfo_new_result1, {
					Position = UDim2.new(0, BorderSize, 0.5, 0);
					Size = UDim2.new(0, var117, 1, -BorderSize * 2);
				}):Play()
				TweenService_upvr:Create(TextButton_upvr, TweenInfo_new_result1, {
					Size = UDim2.new(0, var117, 1, 0);
				}):Play()
				local var128 = var116
				local udim2_3 = UDim2.fromOffset(var128, MinimumHeight)
				if Frame_upvr_7.Size.Y.Offset == MinimumHeight then
					var128 = false
				else
					var128 = true
				end
				if var128 then
					Frame_upvr_7.Size = udim2_3
				end
				Frame_upvr_7:SetAttribute("TargetWidth", udim2_3.X.Offset)
				TweenService_upvr:Create(Frame_upvr_7, TweenInfo_new_result1_8, {
					Size = udim2_3;
				}):Play()
				var27_upvw += 1
				task.delay(TweenInfo_new_result1_8.Time - 0.2, function() -- Line 308
					--[[ Upvalues[2]:
						[1]: var27_upvw (copied, read and write)
						[2]: arg1 (copied, readonly)
					]]
					var27_upvw -= 1
					task.defer(function() -- Line 310
						--[[ Upvalues[2]:
							[1]: var27_upvw (copied, read and write)
							[2]: arg1 (copied, readonly)
						]]
						if var27_upvw == 0 then
							arg1.resizingComplete:Fire()
						end
					end)
				end)
				local parentIcon_7 = arg1.parentIcon
				if parentIcon_7 then
					parentIcon_7.updateSize:Fire()
				end
				-- KONSTANTERROR: [69] 54. Error Block 107 end (CF ANALYSIS FAILED)
			end
		end)
	end
	arg1:setBehaviour("IconLabel", "Text", handleLabelAndImageChanges_upvr)
	local var135_upvw = true
	arg1:setBehaviour("IconLabel", "FontFace", function(arg1_5) -- Line 326
		--[[ Upvalues[23]:
			[1]: TextLabel_upvr_2 (readonly)
			[2]: var26_upvw (read and write)
			[3]: var28_upvw (read and write)
			[4]: handleLabelAndImageChanges_upvr (readonly)
			[5]: ImageLabel_upvr (readonly)
			[6]: Frame_upvr_8 (readonly)
			[7]: Frame_upvr_10 (readonly)
			[8]: Frame_upvr (readonly)
			[9]: Frame_upvr_5 (readonly)
			[10]: UIListLayout_upvr (readonly)
			[11]: Frame_upvr_9 (readonly)
			[12]: Frame_upvr_4 (readonly)
			[13]: Frame_upvr_7 (readonly)
			[14]: var22_upvr (readonly)
			[15]: arg1 (readonly)
			[16]: Frame_upvr_6 (readonly)
			[17]: Frame_upvr_3 (readonly)
			[18]: clone_3_upvr (readonly)
			[19]: Frame_upvr_11 (readonly)
			[20]: TweenService_upvr (readonly)
			[21]: TextButton_upvr (readonly)
			[22]: var27_upvw (read and write)
			[23]: var135_upvw (read and write)
		]]
		if TextLabel_upvr_2.FontFace == arg1_5 then
		else
			task.spawn(function() -- Line 331
				--[[ Upvalues[23]:
					[1]: var26_upvw (copied, read and write)
					[2]: var28_upvw (copied, read and write)
					[3]: handleLabelAndImageChanges_upvr (copied, readonly)
					[4]: TextLabel_upvr_2 (copied, readonly)
					[5]: ImageLabel_upvr (copied, readonly)
					[6]: Frame_upvr_8 (copied, readonly)
					[7]: Frame_upvr_10 (copied, readonly)
					[8]: Frame_upvr (copied, readonly)
					[9]: Frame_upvr_5 (copied, readonly)
					[10]: UIListLayout_upvr (copied, readonly)
					[11]: Frame_upvr_9 (copied, readonly)
					[12]: Frame_upvr_4 (copied, readonly)
					[13]: Frame_upvr_7 (copied, readonly)
					[14]: var22_upvr (copied, readonly)
					[15]: arg1 (copied, readonly)
					[16]: Frame_upvr_6 (copied, readonly)
					[17]: Frame_upvr_3 (copied, readonly)
					[18]: clone_3_upvr (copied, readonly)
					[19]: Frame_upvr_11 (copied, readonly)
					[20]: TweenService_upvr (copied, readonly)
					[21]: TextButton_upvr (copied, readonly)
					[22]: var27_upvw (copied, read and write)
					[23]: var135_upvw (copied, read and write)
				]]
				var26_upvw += 1
				local var139_upvr
				task.defer(function() -- Line 207
					--[[ Upvalues[24]:
						[1]: var26_upvw (copied, read and write)
						[2]: var26_upvw (readonly)
						[3]: var139_upvr (readonly)
						[4]: var28_upvw (copied, read and write)
						[5]: handleLabelAndImageChanges_upvr (copied, readonly)
						[6]: TextLabel_upvr_2 (copied, readonly)
						[7]: ImageLabel_upvr (copied, readonly)
						[8]: Frame_upvr_8 (copied, readonly)
						[9]: Frame_upvr_10 (copied, readonly)
						[10]: Frame_upvr (copied, readonly)
						[11]: Frame_upvr_5 (copied, readonly)
						[12]: UIListLayout_upvr (copied, readonly)
						[13]: Frame_upvr_9 (copied, readonly)
						[14]: Frame_upvr_4 (copied, readonly)
						[15]: Frame_upvr_7 (copied, readonly)
						[16]: var22_upvr (copied, readonly)
						[17]: arg1 (copied, readonly)
						[18]: Frame_upvr_6 (copied, readonly)
						[19]: Frame_upvr_3 (copied, readonly)
						[20]: clone_3_upvr (copied, readonly)
						[21]: Frame_upvr_11 (copied, readonly)
						[22]: TweenService_upvr (copied, readonly)
						[23]: TextButton_upvr (copied, readonly)
						[24]: var27_upvw (copied, read and write)
					]]
					-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
					-- KONSTANTERROR: [0] 1. Error Block 106 start (CF ANALYSIS FAILED)
					local var156
					if var26_upvw ~= var156 and var139_upvr ~= "FORCE_UPDATE" then
						if not var28_upvw then
							var28_upvw = true
							var156 = 0.01
							task.delay(var156, function() -- Line 211
								--[[ Upvalues[2]:
									[1]: handleLabelAndImageChanges_upvr (copied, readonly)
									[2]: var28_upvw (copied, read and write)
								]]
								handleLabelAndImageChanges_upvr()
								var28_upvw = false
							end)
						end
					else
						var156 = TextLabel_upvr_2.Text
						if var156 == "" then
							local _ = false
							-- KONSTANTWARNING: Skipped task `defvar` above
						else
						end
						var156 = false
						if ImageLabel_upvr.Image ~= "" then
							if ImageLabel_upvr.Image == nil then
								var156 = false
							else
								var156 = true
							end
						end
						local var159
						if var156 and not true then
							Frame_upvr_8.Visible = false
							ImageLabel_upvr.Visible = true
							Frame_upvr_10.Visible = false
							Frame_upvr.Visible = false
							Frame_upvr_5.Visible = false
							-- KONSTANTWARNING: GOTO [116] #90
						end
						-- KONSTANTERROR: [0] 1. Error Block 106 end (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [69] 54. Error Block 107 start (CF ANALYSIS FAILED)
						if not var156 then
							-- KONSTANTERROR: Expression was reused, decompilation is incorrect
							if true then
								Frame_upvr_8.Visible = true
								ImageLabel_upvr.Visible = false
								Frame_upvr_10.Visible = false
								Frame_upvr.Visible = true
								Frame_upvr_5.Visible = true
								-- KONSTANTWARNING: GOTO [116] #90
							end
						end
						if var156 then
							-- KONSTANTERROR: Expression was reused, decompilation is incorrect
							if true then
								Frame_upvr_8.Visible = true
								ImageLabel_upvr.Visible = true
								Frame_upvr_10.Visible = true
								Frame_upvr.Visible = true
								Frame_upvr_5.Visible = true
								var159 = Enum.HorizontalAlignment.Left
							end
						end
						UIListLayout_upvr.HorizontalAlignment = var159
						Frame_upvr_9.Size = UDim2.fromScale(1, 1)
						local function getItemWidth(arg1_6) -- Line 247
							local TargetWidth_35 = arg1_6:GetAttribute("TargetWidth")
							if not TargetWidth_35 then
								TargetWidth_35 = arg1_6.AbsoluteSize.X
							end
							return TargetWidth_35
						end
						Frame_upvr_8.Size = UDim2.new(0, TextLabel_upvr_2.TextBounds.X, TextLabel_upvr_2.Size.Y.Scale, 0)
						for _, v_9 in pairs(Frame_upvr_4:GetChildren()) do
							if v_9:IsA("GuiObject") and v_9.Visible == true then
								local TargetWidth_10 = v_9:GetAttribute("TargetWidth")
								if not TargetWidth_10 then
									TargetWidth_10 = v_9.AbsoluteSize.X
								end
							end
						end
						local MinimumHeight_6 = Frame_upvr_7:GetAttribute("MinimumHeight")
						local BorderSize_6 = Frame_upvr_7:GetAttribute("BorderSize")
						if 0 >= #arg1.menuIcons then
						else
						end
						if true then
							local isSelected_2 = arg1.isSelected
							local var168
						end
						if isSelected_2 then
							for _, v_10 in pairs(Frame_upvr_6:GetChildren()) do
								if v_10 ~= Frame_upvr_3 and v_10:IsA("GuiObject") and v_10.Visible then
									local TargetWidth_33 = v_10:GetAttribute("TargetWidth")
									if not TargetWidth_33 then
										TargetWidth_33 = v_10.AbsoluteSize.X
									end
									var168 += TargetWidth_33 + clone_3_upvr.Padding.Offset
								end
							end
							var168 -= BorderSize_6
						end
						Frame_upvr_11.Visible = isSelected_2
						local DesiredWidth_5 = Frame_upvr_7:GetAttribute("DesiredWidth")
						local var174
						if DesiredWidth_5 and var174 < DesiredWidth_5 then
							var174 = DesiredWidth_5
						end
						local var175 = var174 - var168 - BorderSize_6 * 2
						local Quint_2 = Enum.EasingStyle.Quint
						local Out_2 = Enum.EasingDirection.Out
						local var178 = Frame_upvr_3
						local TargetWidth_28 = var178:GetAttribute("TargetWidth")
						if not TargetWidth_28 then
							TargetWidth_28 = var178.AbsoluteSize.X
						end
						local var180 = Frame_upvr_7
						local TargetWidth_29 = var180:GetAttribute("TargetWidth")
						if not TargetWidth_29 then
							TargetWidth_29 = var180.AbsoluteSize.X
						end
						local TweenInfo_new_result1_14 = TweenInfo.new(math.max(var175, TargetWidth_28, Frame_upvr_3.AbsoluteSize.X) / 750, Quint_2, Out_2)
						local TweenInfo_new_result1_13 = TweenInfo.new(math.max(var174, TargetWidth_29, Frame_upvr_7.AbsoluteSize.X) / 750, Quint_2, Out_2)
						TweenService_upvr:Create(Frame_upvr_3, TweenInfo_new_result1_14, {
							Position = UDim2.new(0, BorderSize_6, 0.5, 0);
							Size = UDim2.new(0, var175, 1, -BorderSize_6 * 2);
						}):Play()
						TweenService_upvr:Create(TextButton_upvr, TweenInfo_new_result1_14, {
							Size = UDim2.new(0, var175, 1, 0);
						}):Play()
						local var186 = var174
						local udim2_2 = UDim2.fromOffset(var186, MinimumHeight_6)
						if Frame_upvr_7.Size.Y.Offset == MinimumHeight_6 then
							var186 = false
						else
							var186 = true
						end
						if var186 then
							Frame_upvr_7.Size = udim2_2
						end
						Frame_upvr_7:SetAttribute("TargetWidth", udim2_2.X.Offset)
						TweenService_upvr:Create(Frame_upvr_7, TweenInfo_new_result1_13, {
							Size = udim2_2;
						}):Play()
						var27_upvw += 1
						task.delay(TweenInfo_new_result1_13.Time - 0.2, function() -- Line 308
							--[[ Upvalues[2]:
								[1]: var27_upvw (copied, read and write)
								[2]: arg1 (copied, readonly)
							]]
							var27_upvw -= 1
							task.defer(function() -- Line 310
								--[[ Upvalues[2]:
									[1]: var27_upvw (copied, read and write)
									[2]: arg1 (copied, readonly)
								]]
								if var27_upvw == 0 then
									arg1.resizingComplete:Fire()
								end
							end)
						end)
						local parentIcon_2 = arg1.parentIcon
						if parentIcon_2 then
							parentIcon_2.updateSize:Fire()
						end
						-- KONSTANTERROR: [69] 54. Error Block 107 end (CF ANALYSIS FAILED)
					end
				end)
				if var135_upvw then
					var135_upvw = false
					for _ = 1, 10 do
						var139_upvr = task.wait
						var139_upvr(1)
						var139_upvr = var26_upvw
						var139_upvr += 1
						var26_upvw = var139_upvr
						var139_upvr = var26_upvw
						local var193_upvr
						task.defer(function() -- Line 207
							--[[ Upvalues[24]:
								[1]: var26_upvw (copied, read and write)
								[2]: var139_upvr (readonly)
								[3]: var193_upvr (readonly)
								[4]: var28_upvw (copied, read and write)
								[5]: handleLabelAndImageChanges_upvr (copied, readonly)
								[6]: TextLabel_upvr_2 (copied, readonly)
								[7]: ImageLabel_upvr (copied, readonly)
								[8]: Frame_upvr_8 (copied, readonly)
								[9]: Frame_upvr_10 (copied, readonly)
								[10]: Frame_upvr (copied, readonly)
								[11]: Frame_upvr_5 (copied, readonly)
								[12]: UIListLayout_upvr (copied, readonly)
								[13]: Frame_upvr_9 (copied, readonly)
								[14]: Frame_upvr_4 (copied, readonly)
								[15]: Frame_upvr_7 (copied, readonly)
								[16]: var22_upvr (copied, readonly)
								[17]: arg1 (copied, readonly)
								[18]: Frame_upvr_6 (copied, readonly)
								[19]: Frame_upvr_3 (copied, readonly)
								[20]: clone_3_upvr (copied, readonly)
								[21]: Frame_upvr_11 (copied, readonly)
								[22]: TweenService_upvr (copied, readonly)
								[23]: TextButton_upvr (copied, readonly)
								[24]: var27_upvw (copied, read and write)
							]]
							-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
							-- KONSTANTERROR: [0] 1. Error Block 106 start (CF ANALYSIS FAILED)
							local var210
							if var26_upvw ~= var210 and var193_upvr ~= "FORCE_UPDATE" then
								if not var28_upvw then
									var28_upvw = true
									var210 = 0.01
									task.delay(var210, function() -- Line 211
										--[[ Upvalues[2]:
											[1]: handleLabelAndImageChanges_upvr (copied, readonly)
											[2]: var28_upvw (copied, read and write)
										]]
										handleLabelAndImageChanges_upvr()
										var28_upvw = false
									end)
								end
							else
								var210 = TextLabel_upvr_2.Text
								if var210 == "" then
									local _ = false
									-- KONSTANTWARNING: Skipped task `defvar` above
								else
								end
								var210 = false
								if ImageLabel_upvr.Image ~= "" then
									if ImageLabel_upvr.Image == nil then
										var210 = false
									else
										var210 = true
									end
								end
								local var213
								if var210 and not true then
									Frame_upvr_8.Visible = false
									ImageLabel_upvr.Visible = true
									Frame_upvr_10.Visible = false
									Frame_upvr.Visible = false
									Frame_upvr_5.Visible = false
									-- KONSTANTWARNING: GOTO [116] #90
								end
								-- KONSTANTERROR: [0] 1. Error Block 106 end (CF ANALYSIS FAILED)
								-- KONSTANTERROR: [69] 54. Error Block 107 start (CF ANALYSIS FAILED)
								if not var210 then
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									if true then
										Frame_upvr_8.Visible = true
										ImageLabel_upvr.Visible = false
										Frame_upvr_10.Visible = false
										Frame_upvr.Visible = true
										Frame_upvr_5.Visible = true
										-- KONSTANTWARNING: GOTO [116] #90
									end
								end
								if var210 then
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									if true then
										Frame_upvr_8.Visible = true
										ImageLabel_upvr.Visible = true
										Frame_upvr_10.Visible = true
										Frame_upvr.Visible = true
										Frame_upvr_5.Visible = true
										var213 = Enum.HorizontalAlignment.Left
									end
								end
								UIListLayout_upvr.HorizontalAlignment = var213
								Frame_upvr_9.Size = UDim2.fromScale(1, 1)
								local function _(arg1_7) -- Line 247, Named "getItemWidth"
									local TargetWidth_3 = arg1_7:GetAttribute("TargetWidth")
									if not TargetWidth_3 then
										TargetWidth_3 = arg1_7.AbsoluteSize.X
									end
									return TargetWidth_3
								end
								Frame_upvr_8.Size = UDim2.new(0, TextLabel_upvr_2.TextBounds.X, TextLabel_upvr_2.Size.Y.Scale, 0)
								for _, v_11 in pairs(Frame_upvr_4:GetChildren()) do
									if v_11:IsA("GuiObject") and v_11.Visible == true then
										local TargetWidth_32 = v_11:GetAttribute("TargetWidth")
										if not TargetWidth_32 then
											TargetWidth_32 = v_11.AbsoluteSize.X
										end
									end
								end
								local MinimumHeight_5 = Frame_upvr_7:GetAttribute("MinimumHeight")
								local BorderSize_2 = Frame_upvr_7:GetAttribute("BorderSize")
								if 0 >= #arg1.menuIcons then
								else
								end
								if true then
									local isSelected_5 = arg1.isSelected
									local var222
								end
								if isSelected_5 then
									for _, v_12 in pairs(Frame_upvr_6:GetChildren()) do
										if v_12 ~= Frame_upvr_3 and v_12:IsA("GuiObject") and v_12.Visible then
											local TargetWidth_20 = v_12:GetAttribute("TargetWidth")
											if not TargetWidth_20 then
												TargetWidth_20 = v_12.AbsoluteSize.X
											end
											var222 += TargetWidth_20 + clone_3_upvr.Padding.Offset
										end
									end
									var222 -= BorderSize_2
								end
								Frame_upvr_11.Visible = isSelected_5
								local DesiredWidth_6 = Frame_upvr_7:GetAttribute("DesiredWidth")
								local var228
								if DesiredWidth_6 and var228 < DesiredWidth_6 then
									var228 = DesiredWidth_6
								end
								local var229 = var228 - var222 - BorderSize_2 * 2
								local Quint_5 = Enum.EasingStyle.Quint
								local Out_5 = Enum.EasingDirection.Out
								local var232 = Frame_upvr_3
								local TargetWidth_17 = var232:GetAttribute("TargetWidth")
								if not TargetWidth_17 then
									TargetWidth_17 = var232.AbsoluteSize.X
								end
								local var234 = Frame_upvr_7
								local TargetWidth_7 = var234:GetAttribute("TargetWidth")
								if not TargetWidth_7 then
									TargetWidth_7 = var234.AbsoluteSize.X
								end
								local TweenInfo_new_result1_6 = TweenInfo.new(math.max(var229, TargetWidth_17, Frame_upvr_3.AbsoluteSize.X) / 750, Quint_5, Out_5)
								local TweenInfo_new_result1_11 = TweenInfo.new(math.max(var228, TargetWidth_7, Frame_upvr_7.AbsoluteSize.X) / 750, Quint_5, Out_5)
								TweenService_upvr:Create(Frame_upvr_3, TweenInfo_new_result1_6, {
									Position = UDim2.new(0, BorderSize_2, 0.5, 0);
									Size = UDim2.new(0, var229, 1, -BorderSize_2 * 2);
								}):Play()
								TweenService_upvr:Create(TextButton_upvr, TweenInfo_new_result1_6, {
									Size = UDim2.new(0, var229, 1, 0);
								}):Play()
								local var240 = var228
								local udim2 = UDim2.fromOffset(var240, MinimumHeight_5)
								if Frame_upvr_7.Size.Y.Offset == MinimumHeight_5 then
									var240 = false
								else
									var240 = true
								end
								if var240 then
									Frame_upvr_7.Size = udim2
								end
								Frame_upvr_7:SetAttribute("TargetWidth", udim2.X.Offset)
								TweenService_upvr:Create(Frame_upvr_7, TweenInfo_new_result1_11, {
									Size = udim2;
								}):Play()
								var27_upvw += 1
								task.delay(TweenInfo_new_result1_11.Time - 0.2, function() -- Line 308
									--[[ Upvalues[2]:
										[1]: var27_upvw (copied, read and write)
										[2]: arg1 (copied, readonly)
									]]
									var27_upvw -= 1
									task.defer(function() -- Line 310
										--[[ Upvalues[2]:
											[1]: var27_upvw (copied, read and write)
											[2]: arg1 (copied, readonly)
										]]
										if var27_upvw == 0 then
											arg1.resizingComplete:Fire()
										end
									end)
								end)
								local parentIcon = arg1.parentIcon
								if parentIcon then
									parentIcon.updateSize:Fire()
								end
								-- KONSTANTERROR: [69] 54. Error Block 107 end (CF ANALYSIS FAILED)
							end
						end)
					end
				end
			end)
		end
	end)
	arg1.updateSize:Connect(handleLabelAndImageChanges_upvr)
	arg1:setBehaviour("Widget", "Visible", handleLabelAndImageChanges_upvr)
	arg1:setBehaviour("Widget", "DesiredWidth", handleLabelAndImageChanges_upvr)
	arg1:setBehaviour("Widget", "MinimumWidth", handleLabelAndImageChanges_upvr)
	arg1:setBehaviour("Widget", "MinimumHeight", handleLabelAndImageChanges_upvr)
	arg1:setBehaviour("Widget", "BorderSize", function() -- Line 354, Named "updateBorderSize"
		--[[ Upvalues[22]:
			[1]: Frame_upvr_7 (readonly)
			[2]: arg1 (readonly)
			[3]: Frame_upvr_6 (readonly)
			[4]: Frame_upvr_11 (readonly)
			[5]: clone_3_upvr (readonly)
			[6]: var26_upvw (read and write)
			[7]: var28_upvw (read and write)
			[8]: handleLabelAndImageChanges_upvr (readonly)
			[9]: TextLabel_upvr_2 (readonly)
			[10]: ImageLabel_upvr (readonly)
			[11]: Frame_upvr_8 (readonly)
			[12]: Frame_upvr_10 (readonly)
			[13]: Frame_upvr (readonly)
			[14]: Frame_upvr_5 (readonly)
			[15]: UIListLayout_upvr (readonly)
			[16]: Frame_upvr_9 (readonly)
			[17]: Frame_upvr_4 (readonly)
			[18]: var22_upvr (readonly)
			[19]: Frame_upvr_3 (readonly)
			[20]: TweenService_upvr (readonly)
			[21]: TextButton_upvr (readonly)
			[22]: var27_upvw (read and write)
		]]
		task.defer(function() -- Line 355
			--[[ Upvalues[22]:
				[1]: Frame_upvr_7 (copied, readonly)
				[2]: arg1 (copied, readonly)
				[3]: Frame_upvr_6 (copied, readonly)
				[4]: Frame_upvr_11 (copied, readonly)
				[5]: clone_3_upvr (copied, readonly)
				[6]: var26_upvw (copied, read and write)
				[7]: var28_upvw (copied, read and write)
				[8]: handleLabelAndImageChanges_upvr (copied, readonly)
				[9]: TextLabel_upvr_2 (copied, readonly)
				[10]: ImageLabel_upvr (copied, readonly)
				[11]: Frame_upvr_8 (copied, readonly)
				[12]: Frame_upvr_10 (copied, readonly)
				[13]: Frame_upvr (copied, readonly)
				[14]: Frame_upvr_5 (copied, readonly)
				[15]: UIListLayout_upvr (copied, readonly)
				[16]: Frame_upvr_9 (copied, readonly)
				[17]: Frame_upvr_4 (copied, readonly)
				[18]: var22_upvr (copied, readonly)
				[19]: Frame_upvr_3 (copied, readonly)
				[20]: TweenService_upvr (copied, readonly)
				[21]: TextButton_upvr (copied, readonly)
				[22]: var27_upvw (copied, read and write)
			]]
			local BorderSize_9 = Frame_upvr_7:GetAttribute("BorderSize")
			local var248
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var248 = -BorderSize_9
				return var248
			end
			if arg1.alignment ~= "Right" or not INLINED() then
				var248 = BorderSize_9
			end
			Frame_upvr_6.Position = UDim2.new(0, var248, 0, 0)
			Frame_upvr_11.Size = UDim2.fromOffset(BorderSize_9, 0)
			clone_3_upvr.Padding = UDim.new(0, 0)
			var26_upvw += 1
			local var250_upvr
			task.defer(function() -- Line 207
				--[[ Upvalues[24]:
					[1]: var26_upvw (copied, read and write)
					[2]: var26_upvw (readonly)
					[3]: var250_upvr (readonly)
					[4]: var28_upvw (copied, read and write)
					[5]: handleLabelAndImageChanges_upvr (copied, readonly)
					[6]: TextLabel_upvr_2 (copied, readonly)
					[7]: ImageLabel_upvr (copied, readonly)
					[8]: Frame_upvr_8 (copied, readonly)
					[9]: Frame_upvr_10 (copied, readonly)
					[10]: Frame_upvr (copied, readonly)
					[11]: Frame_upvr_5 (copied, readonly)
					[12]: UIListLayout_upvr (copied, readonly)
					[13]: Frame_upvr_9 (copied, readonly)
					[14]: Frame_upvr_4 (copied, readonly)
					[15]: Frame_upvr_7 (copied, readonly)
					[16]: var22_upvr (copied, readonly)
					[17]: arg1 (copied, readonly)
					[18]: Frame_upvr_6 (copied, readonly)
					[19]: Frame_upvr_3 (copied, readonly)
					[20]: clone_3_upvr (copied, readonly)
					[21]: Frame_upvr_11 (copied, readonly)
					[22]: TweenService_upvr (copied, readonly)
					[23]: TextButton_upvr (copied, readonly)
					[24]: var27_upvw (copied, read and write)
				]]
				-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
				-- KONSTANTERROR: [0] 1. Error Block 106 start (CF ANALYSIS FAILED)
				local var267
				if var26_upvw ~= var267 and var250_upvr ~= "FORCE_UPDATE" then
					if not var28_upvw then
						var28_upvw = true
						var267 = 0.01
						task.delay(var267, function() -- Line 211
							--[[ Upvalues[2]:
								[1]: handleLabelAndImageChanges_upvr (copied, readonly)
								[2]: var28_upvw (copied, read and write)
							]]
							handleLabelAndImageChanges_upvr()
							var28_upvw = false
						end)
					end
				else
					var267 = TextLabel_upvr_2.Text
					if var267 == "" then
						local _ = false
						-- KONSTANTWARNING: Skipped task `defvar` above
					else
					end
					var267 = false
					if ImageLabel_upvr.Image ~= "" then
						if ImageLabel_upvr.Image == nil then
							var267 = false
						else
							var267 = true
						end
					end
					local var270
					if var267 and not true then
						Frame_upvr_8.Visible = false
						ImageLabel_upvr.Visible = true
						Frame_upvr_10.Visible = false
						Frame_upvr.Visible = false
						Frame_upvr_5.Visible = false
						-- KONSTANTWARNING: GOTO [116] #90
					end
					-- KONSTANTERROR: [0] 1. Error Block 106 end (CF ANALYSIS FAILED)
					-- KONSTANTERROR: [69] 54. Error Block 107 start (CF ANALYSIS FAILED)
					if not var267 then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						if true then
							Frame_upvr_8.Visible = true
							ImageLabel_upvr.Visible = false
							Frame_upvr_10.Visible = false
							Frame_upvr.Visible = true
							Frame_upvr_5.Visible = true
							-- KONSTANTWARNING: GOTO [116] #90
						end
					end
					if var267 then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						if true then
							Frame_upvr_8.Visible = true
							ImageLabel_upvr.Visible = true
							Frame_upvr_10.Visible = true
							Frame_upvr.Visible = true
							Frame_upvr_5.Visible = true
							var270 = Enum.HorizontalAlignment.Left
						end
					end
					UIListLayout_upvr.HorizontalAlignment = var270
					Frame_upvr_9.Size = UDim2.fromScale(1, 1)
					local function getItemWidth(arg1_8) -- Line 247
						local TargetWidth_22 = arg1_8:GetAttribute("TargetWidth")
						if not TargetWidth_22 then
							TargetWidth_22 = arg1_8.AbsoluteSize.X
						end
						return TargetWidth_22
					end
					Frame_upvr_8.Size = UDim2.new(0, TextLabel_upvr_2.TextBounds.X, TextLabel_upvr_2.Size.Y.Scale, 0)
					for _, v_3 in pairs(Frame_upvr_4:GetChildren()) do
						if v_3:IsA("GuiObject") and v_3.Visible == true then
							local TargetWidth_31 = v_3:GetAttribute("TargetWidth")
							if not TargetWidth_31 then
								TargetWidth_31 = v_3.AbsoluteSize.X
							end
						end
					end
					local MinimumHeight_7 = Frame_upvr_7:GetAttribute("MinimumHeight")
					local BorderSize_7 = Frame_upvr_7:GetAttribute("BorderSize")
					if 0 >= #arg1.menuIcons then
					else
					end
					if true then
						local isSelected = arg1.isSelected
						local var279
					end
					if isSelected then
						for _, v_4 in pairs(Frame_upvr_6:GetChildren()) do
							if v_4 ~= Frame_upvr_3 and v_4:IsA("GuiObject") and v_4.Visible then
								local TargetWidth_8 = v_4:GetAttribute("TargetWidth")
								if not TargetWidth_8 then
									TargetWidth_8 = v_4.AbsoluteSize.X
								end
								var279 += TargetWidth_8 + clone_3_upvr.Padding.Offset
							end
						end
						var279 -= BorderSize_7
					end
					Frame_upvr_11.Visible = isSelected
					local DesiredWidth_7 = Frame_upvr_7:GetAttribute("DesiredWidth")
					local var285
					if DesiredWidth_7 and var285 < DesiredWidth_7 then
						var285 = DesiredWidth_7
					end
					local var286 = var285 - var279 - BorderSize_7 * 2
					local Quint_4 = Enum.EasingStyle.Quint
					local Out_6 = Enum.EasingDirection.Out
					local var289 = Frame_upvr_3
					local TargetWidth_2 = var289:GetAttribute("TargetWidth")
					if not TargetWidth_2 then
						TargetWidth_2 = var289.AbsoluteSize.X
					end
					local var291 = Frame_upvr_7
					local TargetWidth_21 = var291:GetAttribute("TargetWidth")
					if not TargetWidth_21 then
						TargetWidth_21 = var291.AbsoluteSize.X
					end
					local TweenInfo_new_result1_5 = TweenInfo.new(math.max(var286, TargetWidth_2, Frame_upvr_3.AbsoluteSize.X) / 750, Quint_4, Out_6)
					local TweenInfo_new_result1_9 = TweenInfo.new(math.max(var285, TargetWidth_21, Frame_upvr_7.AbsoluteSize.X) / 750, Quint_4, Out_6)
					TweenService_upvr:Create(Frame_upvr_3, TweenInfo_new_result1_5, {
						Position = UDim2.new(0, BorderSize_7, 0.5, 0);
						Size = UDim2.new(0, var286, 1, -BorderSize_7 * 2);
					}):Play()
					TweenService_upvr:Create(TextButton_upvr, TweenInfo_new_result1_5, {
						Size = UDim2.new(0, var286, 1, 0);
					}):Play()
					local var297 = var285
					local udim2_4 = UDim2.fromOffset(var297, MinimumHeight_7)
					if Frame_upvr_7.Size.Y.Offset == MinimumHeight_7 then
						var297 = false
					else
						var297 = true
					end
					if var297 then
						Frame_upvr_7.Size = udim2_4
					end
					Frame_upvr_7:SetAttribute("TargetWidth", udim2_4.X.Offset)
					TweenService_upvr:Create(Frame_upvr_7, TweenInfo_new_result1_9, {
						Size = udim2_4;
					}):Play()
					var27_upvw += 1
					task.delay(TweenInfo_new_result1_9.Time - 0.2, function() -- Line 308
						--[[ Upvalues[2]:
							[1]: var27_upvw (copied, read and write)
							[2]: arg1 (copied, readonly)
						]]
						var27_upvw -= 1
						task.defer(function() -- Line 310
							--[[ Upvalues[2]:
								[1]: var27_upvw (copied, read and write)
								[2]: arg1 (copied, readonly)
							]]
							if var27_upvw == 0 then
								arg1.resizingComplete:Fire()
							end
						end)
					end)
					local parentIcon_6 = arg1.parentIcon
					if parentIcon_6 then
						parentIcon_6.updateSize:Fire()
					end
					-- KONSTANTERROR: [69] 54. Error Block 107 end (CF ANALYSIS FAILED)
				end
			end)
		end)
	end)
	arg1:setBehaviour("IconImageRatio", "AspectRatio", handleLabelAndImageChanges_upvr)
	arg1:setBehaviour("IconImage", "Image", function(arg1_9) -- Line 372
		--[[ Upvalues[22]:
			[1]: ImageLabel_upvr (readonly)
			[2]: var26_upvw (read and write)
			[3]: var28_upvw (read and write)
			[4]: handleLabelAndImageChanges_upvr (readonly)
			[5]: TextLabel_upvr_2 (readonly)
			[6]: Frame_upvr_8 (readonly)
			[7]: Frame_upvr_10 (readonly)
			[8]: Frame_upvr (readonly)
			[9]: Frame_upvr_5 (readonly)
			[10]: UIListLayout_upvr (readonly)
			[11]: Frame_upvr_9 (readonly)
			[12]: Frame_upvr_4 (readonly)
			[13]: Frame_upvr_7 (readonly)
			[14]: var22_upvr (readonly)
			[15]: arg1 (readonly)
			[16]: Frame_upvr_6 (readonly)
			[17]: Frame_upvr_3 (readonly)
			[18]: clone_3_upvr (readonly)
			[19]: Frame_upvr_11 (readonly)
			[20]: TweenService_upvr (readonly)
			[21]: TextButton_upvr (readonly)
			[22]: var27_upvw (read and write)
		]]
		local var304
		local function INLINED_2() -- Internal function, doesn't exist in bytecode
			var304 = "http://www.roblox.com/asset/?id="..arg1_9
			return var304
		end
		if not tonumber(arg1_9) or not INLINED_2() then
			var304 = arg1_9
			if not var304 then
				var304 = ""
			end
		end
		if ImageLabel_upvr.Image ~= var304 then
			var26_upvw += 1
			local var306_upvr
			task.defer(function() -- Line 207
				--[[ Upvalues[24]:
					[1]: var26_upvw (copied, read and write)
					[2]: var26_upvw (readonly)
					[3]: var306_upvr (readonly)
					[4]: var28_upvw (copied, read and write)
					[5]: handleLabelAndImageChanges_upvr (copied, readonly)
					[6]: TextLabel_upvr_2 (copied, readonly)
					[7]: ImageLabel_upvr (copied, readonly)
					[8]: Frame_upvr_8 (copied, readonly)
					[9]: Frame_upvr_10 (copied, readonly)
					[10]: Frame_upvr (copied, readonly)
					[11]: Frame_upvr_5 (copied, readonly)
					[12]: UIListLayout_upvr (copied, readonly)
					[13]: Frame_upvr_9 (copied, readonly)
					[14]: Frame_upvr_4 (copied, readonly)
					[15]: Frame_upvr_7 (copied, readonly)
					[16]: var22_upvr (copied, readonly)
					[17]: arg1 (copied, readonly)
					[18]: Frame_upvr_6 (copied, readonly)
					[19]: Frame_upvr_3 (copied, readonly)
					[20]: clone_3_upvr (copied, readonly)
					[21]: Frame_upvr_11 (copied, readonly)
					[22]: TweenService_upvr (copied, readonly)
					[23]: TextButton_upvr (copied, readonly)
					[24]: var27_upvw (copied, read and write)
				]]
				-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
				-- KONSTANTERROR: [0] 1. Error Block 106 start (CF ANALYSIS FAILED)
				local var323
				if var26_upvw ~= var323 and var306_upvr ~= "FORCE_UPDATE" then
					if not var28_upvw then
						var28_upvw = true
						var323 = 0.01
						task.delay(var323, function() -- Line 211
							--[[ Upvalues[2]:
								[1]: handleLabelAndImageChanges_upvr (copied, readonly)
								[2]: var28_upvw (copied, read and write)
							]]
							handleLabelAndImageChanges_upvr()
							var28_upvw = false
						end)
					end
				else
					var323 = TextLabel_upvr_2.Text
					if var323 == "" then
						local _ = false
						-- KONSTANTWARNING: Skipped task `defvar` above
					else
					end
					var323 = false
					if ImageLabel_upvr.Image ~= "" then
						if ImageLabel_upvr.Image == nil then
							var323 = false
						else
							var323 = true
						end
					end
					local var326
					if var323 and not true then
						Frame_upvr_8.Visible = false
						ImageLabel_upvr.Visible = true
						Frame_upvr_10.Visible = false
						Frame_upvr.Visible = false
						Frame_upvr_5.Visible = false
						-- KONSTANTWARNING: GOTO [116] #90
					end
					-- KONSTANTERROR: [0] 1. Error Block 106 end (CF ANALYSIS FAILED)
					-- KONSTANTERROR: [69] 54. Error Block 107 start (CF ANALYSIS FAILED)
					if not var323 then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						if true then
							Frame_upvr_8.Visible = true
							ImageLabel_upvr.Visible = false
							Frame_upvr_10.Visible = false
							Frame_upvr.Visible = true
							Frame_upvr_5.Visible = true
							-- KONSTANTWARNING: GOTO [116] #90
						end
					end
					if var323 then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						if true then
							Frame_upvr_8.Visible = true
							ImageLabel_upvr.Visible = true
							Frame_upvr_10.Visible = true
							Frame_upvr.Visible = true
							Frame_upvr_5.Visible = true
							var326 = Enum.HorizontalAlignment.Left
						end
					end
					UIListLayout_upvr.HorizontalAlignment = var326
					Frame_upvr_9.Size = UDim2.fromScale(1, 1)
					local function getItemWidth(arg1_10) -- Line 247
						local TargetWidth_25 = arg1_10:GetAttribute("TargetWidth")
						if not TargetWidth_25 then
							TargetWidth_25 = arg1_10.AbsoluteSize.X
						end
						return TargetWidth_25
					end
					Frame_upvr_8.Size = UDim2.new(0, TextLabel_upvr_2.TextBounds.X, TextLabel_upvr_2.Size.Y.Scale, 0)
					for _, v_5 in pairs(Frame_upvr_4:GetChildren()) do
						if v_5:IsA("GuiObject") and v_5.Visible == true then
							local TargetWidth_24 = v_5:GetAttribute("TargetWidth")
							if not TargetWidth_24 then
								TargetWidth_24 = v_5.AbsoluteSize.X
							end
						end
					end
					local MinimumHeight_3 = Frame_upvr_7:GetAttribute("MinimumHeight")
					local BorderSize_4 = Frame_upvr_7:GetAttribute("BorderSize")
					if 0 >= #arg1.menuIcons then
					else
					end
					if true then
						local isSelected_3 = arg1.isSelected
						local var335
					end
					if isSelected_3 then
						for _, v_6 in pairs(Frame_upvr_6:GetChildren()) do
							if v_6 ~= Frame_upvr_3 and v_6:IsA("GuiObject") and v_6.Visible then
								local TargetWidth_23 = v_6:GetAttribute("TargetWidth")
								if not TargetWidth_23 then
									TargetWidth_23 = v_6.AbsoluteSize.X
								end
								var335 += TargetWidth_23 + clone_3_upvr.Padding.Offset
							end
						end
						var335 -= BorderSize_4
					end
					Frame_upvr_11.Visible = isSelected_3
					local DesiredWidth = Frame_upvr_7:GetAttribute("DesiredWidth")
					local var341
					if DesiredWidth and var341 < DesiredWidth then
						var341 = DesiredWidth
					end
					local var342 = var341 - var335 - BorderSize_4 * 2
					local Quint_3 = Enum.EasingStyle.Quint
					local Out_3 = Enum.EasingDirection.Out
					local var345 = Frame_upvr_3
					local TargetWidth_4 = var345:GetAttribute("TargetWidth")
					if not TargetWidth_4 then
						TargetWidth_4 = var345.AbsoluteSize.X
					end
					local var347 = Frame_upvr_7
					local TargetWidth_19 = var347:GetAttribute("TargetWidth")
					if not TargetWidth_19 then
						TargetWidth_19 = var347.AbsoluteSize.X
					end
					local TweenInfo_new_result1_2 = TweenInfo.new(math.max(var342, TargetWidth_4, Frame_upvr_3.AbsoluteSize.X) / 750, Quint_3, Out_3)
					local TweenInfo_new_result1_7 = TweenInfo.new(math.max(var341, TargetWidth_19, Frame_upvr_7.AbsoluteSize.X) / 750, Quint_3, Out_3)
					TweenService_upvr:Create(Frame_upvr_3, TweenInfo_new_result1_2, {
						Position = UDim2.new(0, BorderSize_4, 0.5, 0);
						Size = UDim2.new(0, var342, 1, -BorderSize_4 * 2);
					}):Play()
					TweenService_upvr:Create(TextButton_upvr, TweenInfo_new_result1_2, {
						Size = UDim2.new(0, var342, 1, 0);
					}):Play()
					local var353 = var341
					local udim2_5 = UDim2.fromOffset(var353, MinimumHeight_3)
					if Frame_upvr_7.Size.Y.Offset == MinimumHeight_3 then
						var353 = false
					else
						var353 = true
					end
					if var353 then
						Frame_upvr_7.Size = udim2_5
					end
					Frame_upvr_7:SetAttribute("TargetWidth", udim2_5.X.Offset)
					TweenService_upvr:Create(Frame_upvr_7, TweenInfo_new_result1_7, {
						Size = udim2_5;
					}):Play()
					var27_upvw += 1
					task.delay(TweenInfo_new_result1_7.Time - 0.2, function() -- Line 308
						--[[ Upvalues[2]:
							[1]: var27_upvw (copied, read and write)
							[2]: arg1 (copied, readonly)
						]]
						var27_upvw -= 1
						task.defer(function() -- Line 310
							--[[ Upvalues[2]:
								[1]: var27_upvw (copied, read and write)
								[2]: arg1 (copied, readonly)
							]]
							if var27_upvw == 0 then
								arg1.resizingComplete:Fire()
							end
						end)
					end)
					local parentIcon_3 = arg1.parentIcon
					if parentIcon_3 then
						parentIcon_3.updateSize:Fire()
					end
					-- KONSTANTERROR: [69] 54. Error Block 107 end (CF ANALYSIS FAILED)
				end
			end)
		end
		return var304
	end)
	arg1.alignmentChanged:Connect(function(arg1_11) -- Line 379
		--[[ Upvalues[22]:
			[1]: clone_3_upvr (readonly)
			[2]: Frame_upvr_7 (readonly)
			[3]: arg1 (readonly)
			[4]: Frame_upvr_6 (readonly)
			[5]: Frame_upvr_11 (readonly)
			[6]: var26_upvw (read and write)
			[7]: var28_upvw (read and write)
			[8]: handleLabelAndImageChanges_upvr (readonly)
			[9]: TextLabel_upvr_2 (readonly)
			[10]: ImageLabel_upvr (readonly)
			[11]: Frame_upvr_8 (readonly)
			[12]: Frame_upvr_10 (readonly)
			[13]: Frame_upvr (readonly)
			[14]: Frame_upvr_5 (readonly)
			[15]: UIListLayout_upvr (readonly)
			[16]: Frame_upvr_9 (readonly)
			[17]: Frame_upvr_4 (readonly)
			[18]: var22_upvr (readonly)
			[19]: Frame_upvr_3 (readonly)
			[20]: TweenService_upvr (readonly)
			[21]: TextButton_upvr (readonly)
			[22]: var27_upvw (read and write)
		]]
		if arg1_11 == "Center" then
		end
		clone_3_upvr.HorizontalAlignment = Enum.HorizontalAlignment.Left
		task.defer(function() -- Line 355
			--[[ Upvalues[22]:
				[1]: Frame_upvr_7 (copied, readonly)
				[2]: arg1 (copied, readonly)
				[3]: Frame_upvr_6 (copied, readonly)
				[4]: Frame_upvr_11 (copied, readonly)
				[5]: clone_3_upvr (copied, readonly)
				[6]: var26_upvw (copied, read and write)
				[7]: var28_upvw (copied, read and write)
				[8]: handleLabelAndImageChanges_upvr (copied, readonly)
				[9]: TextLabel_upvr_2 (copied, readonly)
				[10]: ImageLabel_upvr (copied, readonly)
				[11]: Frame_upvr_8 (copied, readonly)
				[12]: Frame_upvr_10 (copied, readonly)
				[13]: Frame_upvr (copied, readonly)
				[14]: Frame_upvr_5 (copied, readonly)
				[15]: UIListLayout_upvr (copied, readonly)
				[16]: Frame_upvr_9 (copied, readonly)
				[17]: Frame_upvr_4 (copied, readonly)
				[18]: var22_upvr (copied, readonly)
				[19]: Frame_upvr_3 (copied, readonly)
				[20]: TweenService_upvr (copied, readonly)
				[21]: TextButton_upvr (copied, readonly)
				[22]: var27_upvw (copied, read and write)
			]]
			local BorderSize_5 = Frame_upvr_7:GetAttribute("BorderSize")
			local var362
			local function INLINED_3() -- Internal function, doesn't exist in bytecode
				var362 = -BorderSize_5
				return var362
			end
			if arg1.alignment ~= "Right" or not INLINED_3() then
				var362 = BorderSize_5
			end
			Frame_upvr_6.Position = UDim2.new(0, var362, 0, 0)
			Frame_upvr_11.Size = UDim2.fromOffset(BorderSize_5, 0)
			clone_3_upvr.Padding = UDim.new(0, 0)
			var26_upvw += 1
			local var364_upvr
			task.defer(function() -- Line 207
				--[[ Upvalues[24]:
					[1]: var26_upvw (copied, read and write)
					[2]: var26_upvw (readonly)
					[3]: var364_upvr (readonly)
					[4]: var28_upvw (copied, read and write)
					[5]: handleLabelAndImageChanges_upvr (copied, readonly)
					[6]: TextLabel_upvr_2 (copied, readonly)
					[7]: ImageLabel_upvr (copied, readonly)
					[8]: Frame_upvr_8 (copied, readonly)
					[9]: Frame_upvr_10 (copied, readonly)
					[10]: Frame_upvr (copied, readonly)
					[11]: Frame_upvr_5 (copied, readonly)
					[12]: UIListLayout_upvr (copied, readonly)
					[13]: Frame_upvr_9 (copied, readonly)
					[14]: Frame_upvr_4 (copied, readonly)
					[15]: Frame_upvr_7 (copied, readonly)
					[16]: var22_upvr (copied, readonly)
					[17]: arg1 (copied, readonly)
					[18]: Frame_upvr_6 (copied, readonly)
					[19]: Frame_upvr_3 (copied, readonly)
					[20]: clone_3_upvr (copied, readonly)
					[21]: Frame_upvr_11 (copied, readonly)
					[22]: TweenService_upvr (copied, readonly)
					[23]: TextButton_upvr (copied, readonly)
					[24]: var27_upvw (copied, read and write)
				]]
				-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
				-- KONSTANTERROR: [0] 1. Error Block 106 start (CF ANALYSIS FAILED)
				local var381
				if var26_upvw ~= var381 and var364_upvr ~= "FORCE_UPDATE" then
					if not var28_upvw then
						var28_upvw = true
						var381 = 0.01
						task.delay(var381, function() -- Line 211
							--[[ Upvalues[2]:
								[1]: handleLabelAndImageChanges_upvr (copied, readonly)
								[2]: var28_upvw (copied, read and write)
							]]
							handleLabelAndImageChanges_upvr()
							var28_upvw = false
						end)
					end
				else
					var381 = TextLabel_upvr_2.Text
					if var381 == "" then
						local _ = false
						-- KONSTANTWARNING: Skipped task `defvar` above
					else
					end
					var381 = false
					if ImageLabel_upvr.Image ~= "" then
						if ImageLabel_upvr.Image == nil then
							var381 = false
						else
							var381 = true
						end
					end
					local var384
					if var381 and not true then
						Frame_upvr_8.Visible = false
						ImageLabel_upvr.Visible = true
						Frame_upvr_10.Visible = false
						Frame_upvr.Visible = false
						Frame_upvr_5.Visible = false
						-- KONSTANTWARNING: GOTO [116] #90
					end
					-- KONSTANTERROR: [0] 1. Error Block 106 end (CF ANALYSIS FAILED)
					-- KONSTANTERROR: [69] 54. Error Block 107 start (CF ANALYSIS FAILED)
					if not var381 then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						if true then
							Frame_upvr_8.Visible = true
							ImageLabel_upvr.Visible = false
							Frame_upvr_10.Visible = false
							Frame_upvr.Visible = true
							Frame_upvr_5.Visible = true
							-- KONSTANTWARNING: GOTO [116] #90
						end
					end
					if var381 then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						if true then
							Frame_upvr_8.Visible = true
							ImageLabel_upvr.Visible = true
							Frame_upvr_10.Visible = true
							Frame_upvr.Visible = true
							Frame_upvr_5.Visible = true
							var384 = Enum.HorizontalAlignment.Left
						end
					end
					UIListLayout_upvr.HorizontalAlignment = var384
					Frame_upvr_9.Size = UDim2.fromScale(1, 1)
					local function getItemWidth(arg1_12) -- Line 247
						local TargetWidth_14 = arg1_12:GetAttribute("TargetWidth")
						if not TargetWidth_14 then
							TargetWidth_14 = arg1_12.AbsoluteSize.X
						end
						return TargetWidth_14
					end
					Frame_upvr_8.Size = UDim2.new(0, TextLabel_upvr_2.TextBounds.X, TextLabel_upvr_2.Size.Y.Scale, 0)
					for _, v_7 in pairs(Frame_upvr_4:GetChildren()) do
						if v_7:IsA("GuiObject") and v_7.Visible == true then
							local TargetWidth_13 = v_7:GetAttribute("TargetWidth")
							if not TargetWidth_13 then
								TargetWidth_13 = v_7.AbsoluteSize.X
							end
						end
					end
					local MinimumHeight_2 = Frame_upvr_7:GetAttribute("MinimumHeight")
					local BorderSize_3 = Frame_upvr_7:GetAttribute("BorderSize")
					if 0 >= #arg1.menuIcons then
					else
					end
					if true then
						local isSelected_6 = arg1.isSelected
						local var393
					end
					if isSelected_6 then
						for _, v_8 in pairs(Frame_upvr_6:GetChildren()) do
							if v_8 ~= Frame_upvr_3 and v_8:IsA("GuiObject") and v_8.Visible then
								local TargetWidth_11 = v_8:GetAttribute("TargetWidth")
								if not TargetWidth_11 then
									TargetWidth_11 = v_8.AbsoluteSize.X
								end
								var393 += TargetWidth_11 + clone_3_upvr.Padding.Offset
							end
						end
						var393 -= BorderSize_3
					end
					Frame_upvr_11.Visible = isSelected_6
					local DesiredWidth_4 = Frame_upvr_7:GetAttribute("DesiredWidth")
					local var399
					if DesiredWidth_4 and var399 < DesiredWidth_4 then
						var399 = DesiredWidth_4
					end
					local var400 = var399 - var393 - BorderSize_3 * 2
					local Quint = Enum.EasingStyle.Quint
					local Out = Enum.EasingDirection.Out
					local var403 = Frame_upvr_3
					local TargetWidth_9 = var403:GetAttribute("TargetWidth")
					if not TargetWidth_9 then
						TargetWidth_9 = var403.AbsoluteSize.X
					end
					local var405 = Frame_upvr_7
					local TargetWidth_12 = var405:GetAttribute("TargetWidth")
					if not TargetWidth_12 then
						TargetWidth_12 = var405.AbsoluteSize.X
					end
					local TweenInfo_new_result1_10 = TweenInfo.new(math.max(var400, TargetWidth_9, Frame_upvr_3.AbsoluteSize.X) / 750, Quint, Out)
					local TweenInfo_new_result1_4 = TweenInfo.new(math.max(var399, TargetWidth_12, Frame_upvr_7.AbsoluteSize.X) / 750, Quint, Out)
					TweenService_upvr:Create(Frame_upvr_3, TweenInfo_new_result1_10, {
						Position = UDim2.new(0, BorderSize_3, 0.5, 0);
						Size = UDim2.new(0, var400, 1, -BorderSize_3 * 2);
					}):Play()
					TweenService_upvr:Create(TextButton_upvr, TweenInfo_new_result1_10, {
						Size = UDim2.new(0, var400, 1, 0);
					}):Play()
					local var411 = var399
					local udim2_6 = UDim2.fromOffset(var411, MinimumHeight_2)
					if Frame_upvr_7.Size.Y.Offset == MinimumHeight_2 then
						var411 = false
					else
						var411 = true
					end
					if var411 then
						Frame_upvr_7.Size = udim2_6
					end
					Frame_upvr_7:SetAttribute("TargetWidth", udim2_6.X.Offset)
					TweenService_upvr:Create(Frame_upvr_7, TweenInfo_new_result1_4, {
						Size = udim2_6;
					}):Play()
					var27_upvw += 1
					task.delay(TweenInfo_new_result1_4.Time - 0.2, function() -- Line 308
						--[[ Upvalues[2]:
							[1]: var27_upvw (copied, read and write)
							[2]: arg1 (copied, readonly)
						]]
						var27_upvw -= 1
						task.defer(function() -- Line 310
							--[[ Upvalues[2]:
								[1]: var27_upvw (copied, read and write)
								[2]: arg1 (copied, readonly)
							]]
							if var27_upvw == 0 then
								arg1.resizingComplete:Fire()
							end
						end)
					end)
					local parentIcon_8 = arg1.parentIcon
					if parentIcon_8 then
						parentIcon_8.updateSize:Fire()
					end
					-- KONSTANTERROR: [69] 54. Error Block 107 end (CF ANALYSIS FAILED)
				end
			end)
		end)
	end)
	local NumberValue_upvr = Instance.new("NumberValue")
	NumberValue_upvr.Name = "IconImageScale"
	NumberValue_upvr.Parent = ImageLabel_upvr
	NumberValue_upvr:GetPropertyChangedSignal("Value"):Connect(function() -- Line 390
		--[[ Upvalues[2]:
			[1]: ImageLabel_upvr (readonly)
			[2]: NumberValue_upvr (readonly)
		]]
		ImageLabel_upvr.Size = UDim2.new(0, 0, NumberValue_upvr.Value, 0)
	end)
	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Name = "IconImageRatio"
	UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
	UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint.Parent = ImageLabel_upvr
	local UIGradient = Instance.new("UIGradient")
	UIGradient.Name = "IconGradient"
	UIGradient.Enabled = true
	UIGradient.Parent = Frame_upvr_9
	local UIGradient_2 = Instance.new("UIGradient")
	UIGradient_2.Name = "IconSpotGradient"
	UIGradient_2.Enabled = true
	UIGradient_2.Parent = Frame_upvr_3
	local Frame_upvr_2 = Instance.new("Frame")
	Frame_upvr_2.Name = "Notice"
	Frame_upvr_2.ZIndex = 25
	Frame_upvr_2.AutomaticSize = Enum.AutomaticSize.X
	Frame_upvr_2.Size = UDim2.new(0, 20, 0, 20)
	Frame_upvr_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_upvr_2.Position = UDim2.new(1, -12, 0, -1)
	Frame_upvr_2.BorderSizePixel = 0
	Frame_upvr_2.BackgroundTransparency = 0.1
	Frame_upvr_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_upvr_2.Visible = false
	Frame_upvr_2.Parent = Frame_upvr_7
	local TextLabel_upvr = Instance.new("TextLabel")
	TextLabel_upvr.Name = "NoticeLabel"
	TextLabel_upvr.ZIndex = 26
	TextLabel_upvr.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel_upvr.AutomaticSize = Enum.AutomaticSize.X
	TextLabel_upvr.Size = UDim2.new(1, 0, 1, 0)
	TextLabel_upvr.BackgroundTransparency = 1
	TextLabel_upvr.Position = UDim2.new(0.5, 0, 0.515, 0)
	TextLabel_upvr.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_upvr.FontSize = Enum.FontSize.Size14
	TextLabel_upvr.TextSize = 13
	TextLabel_upvr.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_upvr.Text = '1'
	TextLabel_upvr.TextWrapped = true
	TextLabel_upvr.TextWrap = true
	TextLabel_upvr.Font = Enum.Font.Arial
	TextLabel_upvr.Parent = Frame_upvr_2
	arg1.noticeChanged:Connect(function(arg1_13) -- Line 440
		--[[ Upvalues[3]:
			[1]: TextLabel_upvr (readonly)
			[2]: arg1 (readonly)
			[3]: Frame_upvr_2 (readonly)
		]]
		if not arg1_13 then
		else
			if arg1_13 >= 100 or not arg1_13 then
			end
			TextLabel_upvr.Text = "99+"
			if arg1_13 < 1 then
			end
			local parentIcon_4 = arg1.parentIcon
			local var426 = true
			if 0 >= #arg1.dropdownIcons then
				if 0 >= #arg1.menuIcons then
					var426 = false
				else
					var426 = true
				end
			end
			local var427
			if arg1.isSelected and var426 then
				var427 = false
			elseif parentIcon_4 and not parentIcon_4.isSelected then
				var427 = false
			end
			Frame_upvr_2.Visible = var427
		end
	end)
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame_upvr_2
	Instance.new("UIStroke").Parent = Frame_upvr_2
	return Frame_upvr_7
end