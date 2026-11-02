-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:18
-- Luau version 6, Types version 3
-- Time taken: 0.005033 seconds

return function(arg1) -- Line 1
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local CanvasGroup_upvr = Instance.new("CanvasGroup")
	CanvasGroup_upvr.Name = "Caption"
	CanvasGroup_upvr.AnchorPoint = Vector2.new(0.5, 0)
	CanvasGroup_upvr.AutomaticSize = Enum.AutomaticSize.XY
	CanvasGroup_upvr.BackgroundTransparency = 1
	CanvasGroup_upvr.BorderSizePixel = 0
	CanvasGroup_upvr.GroupTransparency = 1
	CanvasGroup_upvr.Position = UDim2.fromOffset(0, 0)
	CanvasGroup_upvr.Size = UDim2.fromOffset(32, 53)
	CanvasGroup_upvr.Visible = true
	CanvasGroup_upvr.Parent = arg1.widget
	local Frame = Instance.new("Frame")
	Frame.Name = "Box"
	Frame.AutomaticSize = Enum.AutomaticSize.XY
	Frame.BackgroundColor3 = Color3.fromRGB(101, 102, 104)
	Frame.Position = UDim2.fromOffset(4, 7)
	Frame.ZIndex = 12
	Frame.Parent = CanvasGroup_upvr
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = "Header"
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	TextLabel.Text = "Caption"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 14
	TextLabel.TextTruncate = Enum.TextTruncate.None
	TextLabel.TextWrapped = false
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.AutomaticSize = Enum.AutomaticSize.X
	TextLabel.BackgroundTransparency = 1
	TextLabel.LayoutOrder = 1
	TextLabel.Size = UDim2.fromOffset(0, 16)
	TextLabel.ZIndex = 18
	TextLabel.Parent = Frame
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Name = "Layout"
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Frame
	local UICorner = Instance.new("UICorner")
	UICorner.Name = "CaptionCorner"
	UICorner.Parent = Frame
	local UIPadding_2 = Instance.new("UIPadding")
	UIPadding_2.Name = "Padding"
	UIPadding_2.PaddingBottom = UDim.new(0, 12)
	UIPadding_2.PaddingLeft = UDim.new(0, 12)
	UIPadding_2.PaddingRight = UDim.new(0, 12)
	UIPadding_2.PaddingTop = UDim.new(0, 12)
	UIPadding_2.Parent = Frame
	local Frame_2_upvr = Instance.new("Frame")
	Frame_2_upvr.Name = "Hotkeys"
	Frame_2_upvr.AutomaticSize = Enum.AutomaticSize.Y
	Frame_2_upvr.BackgroundTransparency = 1
	Frame_2_upvr.LayoutOrder = 3
	Frame_2_upvr.Size = UDim2.fromScale(1, 0)
	Frame_2_upvr.Visible = false
	Frame_2_upvr.Parent = Frame
	local UIListLayout_2 = Instance.new("UIListLayout")
	UIListLayout_2.Name = "Layout1"
	UIListLayout_2.Padding = UDim.new(0, 6)
	UIListLayout_2.FillDirection = Enum.FillDirection.Vertical
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.HorizontalFlex = Enum.UIFlexAlignment.None
	UIListLayout_2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
	UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.None
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Parent = Frame_2_upvr
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.Name = "Key1"
	ImageLabel.Image = "rbxasset://textures/ui/Controls/key_single.png"
	ImageLabel.ImageTransparency = 0.7
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.SliceCenter = Rect.new(5, 5, 23, 24)
	ImageLabel.AutomaticSize = Enum.AutomaticSize.X
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.LayoutOrder = 1
	ImageLabel.Size = UDim2.fromOffset(0, 30)
	ImageLabel.ZIndex = 15
	ImageLabel.Parent = Frame_2_upvr
	local UIPadding = Instance.new("UIPadding")
	UIPadding.Name = "Inset"
	UIPadding.PaddingLeft = UDim.new(0, 8)
	UIPadding.PaddingRight = UDim.new(0, 8)
	UIPadding.Parent = ImageLabel
	local TextLabel_2_upvr = Instance.new("TextLabel")
	TextLabel_2_upvr.Name = "LabelContent"
	TextLabel_2_upvr.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	TextLabel_2_upvr.Text = ""
	TextLabel_2_upvr.TextColor3 = Color3.fromRGB(189, 190, 190)
	TextLabel_2_upvr.TextSize = 14
	TextLabel_2_upvr.AutomaticSize = Enum.AutomaticSize.X
	TextLabel_2_upvr.BackgroundTransparency = 1
	TextLabel_2_upvr.Position = UDim2.fromOffset(0, -1)
	TextLabel_2_upvr.Size = UDim2.fromScale(1, 1)
	TextLabel_2_upvr.ZIndex = 16
	TextLabel_2_upvr.Parent = ImageLabel
	local ImageLabel_3 = Instance.new("ImageLabel")
	ImageLabel_3.Name = "Caret"
	ImageLabel_3.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
	ImageLabel_3.ImageColor3 = Color3.fromRGB(101, 102, 104)
	ImageLabel_3.ImageRectOffset = Vector2.new(260, 440)
	ImageLabel_3.ImageRectSize = Vector2.new(16, 8)
	ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_3.BackgroundTransparency = 1
	ImageLabel_3.Position = UDim2.new(0.5, 0, 0, 4)
	ImageLabel_3.Rotation = 180
	ImageLabel_3.Size = UDim2.fromOffset(16, 8)
	ImageLabel_3.ZIndex = 12
	ImageLabel_3.Parent = CanvasGroup_upvr
	local ImageLabel_2 = Instance.new("ImageLabel")
	ImageLabel_2.Name = "DropShadow"
	ImageLabel_2.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
	ImageLabel_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel_2.ImageRectOffset = Vector2.new(217, 486)
	ImageLabel_2.ImageRectSize = Vector2.new(25, 25)
	ImageLabel_2.ImageTransparency = 0.5
	ImageLabel_2.ScaleType = Enum.ScaleType.Slice
	ImageLabel_2.SliceCenter = Rect.new(12, 12, 13, 13)
	ImageLabel_2.BackgroundTransparency = 1
	ImageLabel_2.Position = UDim2.fromOffset(0, 5)
	ImageLabel_2.Size = UDim2.new(1, 0, 0, 48)
	ImageLabel_2.Parent = CanvasGroup_upvr
	local widget_upvr = arg1.widget
	local captionJanitor = arg1.captionJanitor
	local Header_upvr = CanvasGroup_upvr.Box.Header
	CanvasGroup_upvr:GetAttributeChangedSignal("CaptionText"):Connect(function() -- Line 151
		--[[ Upvalues[2]:
			[1]: CanvasGroup_upvr (readonly)
			[2]: Header_upvr (readonly)
		]]
		Header_upvr.Text = CanvasGroup_upvr:GetAttribute("CaptionText")
	end)
	local Quad = Enum.EasingStyle.Quad
	local TweenInfo_new_result1_upvr_2 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In)
	local TweenInfo_new_result1_upvr = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out)
	local TweenService_upvr = game:GetService("TweenService")
	local var23_upvw = false
	local function _(arg1_2) -- Line 163, Named "getCaptionPosition"
		--[[ Upvalues[2]:
			[1]: var23_upvw (read and write)
			[2]: widget_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var24 = arg1_2
		if not var24 then
			var24 = var23_upvw
		end
		if var24 then
		else
		end
		return UDim2.new(0, widget_upvr.AbsoluteSize.X / 2, 1, -2)
	end
	local function updatePosition_upvr(arg1_3, arg2) -- Line 168, Named "updatePosition"
		--[[ Upvalues[6]:
			[1]: var23_upvw (read and write)
			[2]: widget_upvr (readonly)
			[3]: CanvasGroup_upvr (readonly)
			[4]: TweenInfo_new_result1_upvr_2 (readonly)
			[5]: TweenInfo_new_result1_upvr (readonly)
			[6]: TweenService_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var25
		if not arg2 then
		end
		if var23_upvw then
			var25 = 4
		else
			var25 = -2
		end
		local Y = UDim2.new(0, widget_upvr.AbsoluteSize.X / 2, 1, var25).Y
		var25 = UDim2.new(0.5, 0, Y.Scale, Y.Offset)
		if arg1_3 ~= true then
			CanvasGroup_upvr.Position = var25
		else
			if not var23_upvw or not TweenInfo_new_result1_upvr_2 then
			end
			TweenService_upvr:Create(CanvasGroup_upvr, TweenInfo_new_result1_upvr, {
				Position = var25;
			}):Play()
		end
	end
	captionJanitor:add(widget_upvr:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line 184
		--[[ Upvalues[1]:
			[1]: updatePosition_upvr (readonly)
		]]
		updatePosition_upvr()
	end))
	captionJanitor:add(widget_upvr:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line 187
		--[[ Upvalues[1]:
			[1]: updatePosition_upvr (readonly)
		]]
		updatePosition_upvr()
	end))
	updatePosition_upvr(nil, false)
	captionJanitor:add(arg1.toggleKeyAdded:Connect(function(arg1_4) -- Line 192, Named "updateHotkey"
		--[[ Upvalues[2]:
			[1]: TextLabel_2_upvr (readonly)
			[2]: Frame_2_upvr (readonly)
		]]
		TextLabel_2_upvr.Text = arg1_4.Name
		Frame_2_upvr.Visible = true
	end))
	local pairs_result1, pairs_result2, pairs_result3 = pairs(arg1.bindedToggleKeys)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [648] 443. Error Block 3 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [648] 443. Error Block 3 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [640] 438. Error Block 7 start (CF ANALYSIS FAILED)
	local function setCaptionEnabled_upvr(arg1_5) -- Line 202, Named "setCaptionEnabled"
		--[[ Upvalues[7]:
			[1]: var23_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: TweenInfo_new_result1_upvr_2 (readonly)
			[4]: TweenInfo_new_result1_upvr (readonly)
			[5]: TweenService_upvr (readonly)
			[6]: CanvasGroup_upvr (readonly)
			[7]: updatePosition_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		if var23_upvw == arg1_5 then
		else
			local joinedFrame = arg1.joinedFrame
			local var34
			if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then
				var34 = false
			end
			var23_upvw = var34
			if var34 then
			else
			end
			if not var34 or not TweenInfo_new_result1_upvr_2 then
			end
			TweenService_upvr:Create(CanvasGroup_upvr, TweenInfo_new_result1_upvr, {
				GroupTransparency = 1;
			}):Play()
			updatePosition_upvr(true)
		end
	end
	local Icon_upvr = arg1.Icon
	captionJanitor:add(arg1.stateChanged:Connect(function(arg1_6) -- Line 223
		--[[ Upvalues[3]:
			[1]: Icon_upvr (readonly)
			[2]: arg1 (readonly)
			[3]: setCaptionEnabled_upvr (readonly)
		]]
		if arg1_6 == "Hovering" then
			local captionLastClosedClock = Icon_upvr.captionLastClosedClock
			if not captionLastClosedClock or not (os.clock() - captionLastClosedClock) then
			end
			if 999 < 0.3 then
			else
			end
			task.delay(0.5, function() -- Line 228
				--[[ Upvalues[2]:
					[1]: arg1 (copied, readonly)
					[2]: setCaptionEnabled_upvr (copied, readonly)
				]]
				if arg1.activeState == "Hovering" then
					setCaptionEnabled_upvr(true)
				end
			end)
		else
			Icon_upvr.captionLastClosedClock = os.clock()
			setCaptionEnabled_upvr(false)
		end
	end))
	do
		return CanvasGroup_upvr
	end
	-- KONSTANTERROR: [640] 438. Error Block 7 end (CF ANALYSIS FAILED)
end