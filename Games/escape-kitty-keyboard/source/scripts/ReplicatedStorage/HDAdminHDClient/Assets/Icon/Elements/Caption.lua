

local u1 = Color3.fromRGB(39, 41, 48)
return function(u2)

	local u3 = u2:getInstance("ClickRegion")
	local u4 = Instance.new("CanvasGroup")
	u4.Name = "Caption"
	u4.AnchorPoint = Vector2.new(0.5, 0)
	u4.BackgroundTransparency = 1
	u4.BorderSizePixel = 0
	u4.GroupTransparency = 1
	u4.Position = UDim2.fromOffset(0, 0)
	u4.Visible = true
	u4.ZIndex = 30
	u4.Parent = u3
	local u5 = Instance.new("Frame")
	u5.Name = "Box"
	u5.AutomaticSize = Enum.AutomaticSize.XY
	u5.BackgroundColor3 = u1
	u5.Position = UDim2.fromOffset(4, 7)
	u5.ZIndex = 12
	u5.Parent = u4
	local v6 = Instance.new("TextLabel")
	v6.Name = "Header"
	v6.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	v6.Text = "Caption"
	v6.TextColor3 = Color3.fromRGB(255, 255, 255)
	v6.TextSize = 15
	v6.TextTruncate = Enum.TextTruncate.None
	v6.TextWrapped = false
	v6.TextXAlignment = Enum.TextXAlignment.Left
	v6.AutomaticSize = Enum.AutomaticSize.X
	v6.BackgroundTransparency = 1
	v6.LayoutOrder = 1
	v6.Size = UDim2.fromOffset(0, 16)
	v6.ZIndex = 18
	v6.Parent = u5
	local v7 = Instance.new("UIListLayout")
	v7.Name = "Layout"
	v7.Padding = UDim.new(0, 8)
	v7.SortOrder = Enum.SortOrder.LayoutOrder
	v7.Parent = u5
	local v8 = Instance.new("UICorner")
	v8.Name = "CaptionCorner"
	v8.Parent = u5
	local v9 = Instance.new("UIPadding")
	v9.Name = "Padding"
	v9.PaddingBottom = UDim.new(0, 12)
	v9.PaddingLeft = UDim.new(0, 12)
	v9.PaddingRight = UDim.new(0, 12)
	v9.PaddingTop = UDim.new(0, 12)
	v9.Parent = u5
	local u10 = Instance.new("Frame")
	u10.Name = "Hotkeys"
	u10.AutomaticSize = Enum.AutomaticSize.Y
	u10.BackgroundTransparency = 1
	u10.LayoutOrder = 3
	u10.Size = UDim2.fromScale(1, 0)
	u10.Visible = false
	u10.Parent = u5
	local v11 = Instance.new("UIListLayout")
	v11.Name = "Layout1"
	v11.Padding = UDim.new(0, 6)
	v11.FillDirection = Enum.FillDirection.Vertical
	v11.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v11.HorizontalFlex = Enum.UIFlexAlignment.None
	v11.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
	v11.VerticalFlex = Enum.UIFlexAlignment.None
	v11.SortOrder = Enum.SortOrder.LayoutOrder
	v11.Parent = u10
	local v12 = Instance.new("ImageLabel")
	v12.Name = "Key1"
	v12.Image = "rbxasset://textures/ui/Controls/key_single.png"
	v12.ImageTransparency = 0.7
	v12.ScaleType = Enum.ScaleType.Slice
	v12.SliceCenter = Rect.new(5, 5, 23, 24)
	v12.AutomaticSize = Enum.AutomaticSize.X
	v12.BackgroundTransparency = 1
	v12.LayoutOrder = 1
	v12.Size = UDim2.fromOffset(0, 30)
	v12.ZIndex = 15
	v12.Parent = u10
	local v13 = Instance.new("UIPadding")
	v13.Name = "Inset"
	v13.PaddingLeft = UDim.new(0, 8)
	v13.PaddingRight = UDim.new(0, 8)
	v13.Parent = v12
	local u14 = Instance.new("TextLabel")
	u14.AutoLocalize = false
	u14.Name = "LabelContent"
	u14.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	u14.Text = ""
	u14.TextColor3 = Color3.fromRGB(189, 190, 190)
	u14.TextSize = 15
	u14.AutomaticSize = Enum.AutomaticSize.X
	u14.BackgroundTransparency = 1
	u14.Position = UDim2.fromOffset(0, -1)
	u14.Size = UDim2.fromScale(1, 1)
	u14.ZIndex = 16
	u14.Parent = v12
	local u15 = Instance.new("ImageLabel")
	u15.Name = "Caret"
	u15.Image = "rbxassetid://101906294438076"
	u15.ImageColor3 = u1
	u15.AnchorPoint = Vector2.new(0, 0.5)
	u15.BackgroundTransparency = 1
	u15.Position = UDim2.new(0, 0, 0, 4)
	u15.Size = UDim2.fromOffset(16, 8)
	u15.ZIndex = 12
	u15.Parent = u4
	local u16 = Instance.new("ImageLabel")
	u16.Visible = true
	u16.Name = "DropShadow"
	u16.Image = "rbxassetid://124920646932671"
	u16.ImageColor3 = Color3.fromRGB(0, 0, 0)
	u16.ImageTransparency = 0.45
	u16.ScaleType = Enum.ScaleType.Slice
	u16.SliceCenter = Rect.new(12, 12, 13, 13)
	u16.BackgroundTransparency = 1
	u16.Position = UDim2.fromOffset(0, 5)
	u16.Size = UDim2.new(1, 0, 0, 48)
	u16.Parent = u4
	u5:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()

		u16.Size = UDim2.new(1, 0, 0, u5.AbsoluteSize.Y + 8)
	end)
	local v17 = u2.captionJanitor
	local _, u18 = u2:clipOutside(u4)
	u18.AutomaticSize = Enum.AutomaticSize.None
	v17:add(u4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() 

		local v19 = u4.AbsoluteSize
		u18.Size = UDim2.fromOffset(v19.X, v19.Y)
	end))
	local v20 = u4.AbsoluteSize
	u18.Size = UDim2.fromOffset(v20.X, v20.Y)
	local u21 = false
	local u22 = u4.Box.Header
	local u23 = game:GetService("UserInputService")
	local function v28(p24) 

		local v25 = u23.KeyboardEnabled
		local v26 = u4:GetAttribute("CaptionText") or ""
		local v27 = v26 == "_hotkey_"
		if v25 or not v27 then
			u22.Text = v26
			u22.Visible = not v27
			if p24 then
				u14.Text = p24.Name
				u10.Visible = true
			end
			if not v25 then
				u10.Visible = false
			end
		else
			u2:setCaption()
		end
	end
	u4:GetAttributeChangedSignal("CaptionText"):Connect(v28)
	local v29 = Enum.EasingStyle.Quad
	local u30 = TweenInfo.new(0.2, v29, Enum.EasingDirection.In)
	local u31 = TweenInfo.new(0.2, v29, Enum.EasingDirection.Out)
	local u32 = game:GetService("TweenService")
	local u33 = game:GetService("RunService")
	local function u48(p34) 

		if u21 then
			if p34 == nil then
				p34 = u21
			end
			local v35 = not p34
			if v35 == nil then
				v35 = u21
			end
			local v36 = UDim2.new(0.5, 0, 1, v35 and 10 or 2)
			local v37
			if p34 == nil then
				v37 = u21
			else
				v37 = p34
			end
			local v38 = UDim2.new(0.5, 0, 1, v37 and 10 or 2)
			if p34 then
				local v39 = u15.Position.Y.Offset
				u15.Position = UDim2.fromOffset(0, v39)
				u4.AutomaticSize = Enum.AutomaticSize.XY
				u4.Size = UDim2.fromOffset(32, 53)
			else
				local v40 = u4.AbsoluteSize
				u4.AutomaticSize = Enum.AutomaticSize.Y
				u4.Size = UDim2.fromOffset(v40.X, v40.Y)
			end
			local u41 = nil
			local function v45() 

				local v42 = u3.AbsolutePosition.X - u4.AbsolutePosition.X + u3.AbsoluteSize.X / 2 - u15.AbsoluteSize.X / 2
				local v43 = u15.Position.Y.Offset
				local v44 = UDim2.fromOffset(v42, v43)
				if u41 ~= v42 then
					u41 = v42
					u15.Position = UDim2.fromOffset(0, v43)
					task.wait()
				end
				u15.Position = v44
			end
			u18.Position = v36
			v45()
			local v46 = u32:Create(u18, p34 and u30 or u31, {
				["Position"] = v38
			})
			local u47 = u33.Heartbeat:Connect(v45)
			v46:Play()
			v46.Completed:Once(function()

				u47:Disconnect()
			end)
		end
	end
	v17:add(u3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()

		u48()
	end))
	u48(false)
	v17:add(u2.toggleKeyAdded:Connect(v28))
	for v49, _ in pairs(u2.bindedToggleKeys) do
		local v50 = u23.KeyboardEnabled
		local v51 = u4:GetAttribute("CaptionText") or ""
		local v52 = v51 == "_hotkey_"
		if v50 or not v52 then
			u22.Text = v51
			u22.Visible = not v52
			if v49 then
				u14.Text = v49.Name
				u10.Visible = true
			end
			if not v50 then
				u10.Visible = false
			end
		else
			u2:setCaption()
		end
		break
	end
	v17:add(u2.fakeToggleKeyChanged:Connect(v28))
	local v53 = u2.fakeToggleKey
	if v53 then
		local v54 = u23.KeyboardEnabled
		local v55 = u4:GetAttribute("CaptionText") or ""
		local v56 = v55 == "_hotkey_"
		if v54 or not v56 then
			u22.Text = v55
			u22.Visible = not v56
			if v53 then
				u14.Text = v53.Name
				u10.Visible = true
			end
			if not v54 then
				u10.Visible = false
			end
		else
			u2:setCaption()
		end
	end
	local function u62(p57) 

		if u21 == p57 then
			return
		else
			local v58 = u2.joinedFrame
			if v58 and string.match(v58.Name, "Dropdown") then
				p57 = false
			end
			u21 = p57
			u32:Create(u4, p57 and u30 or u31, {
				["GroupTransparency"] = p57 and 0 or 1
			}):Play()
			if p57 then
				u18:SetAttribute("ForceUpdate", true)
			end
			u48()
			local v59 = u23.KeyboardEnabled
			local v60 = u4:GetAttribute("CaptionText") or ""
			local v61 = v60 == "_hotkey_"
			if v59 or not v61 then
				u22.Text = v60
				u22.Visible = not v61
				if not v59 then
					u10.Visible = false
				end
			else
				u2:setCaption()
			end
		end
	end
	local u63 = require(u2.iconModule)
	v17:add(u2.stateChanged:Connect(function(p64)

		if p64 == "Viewing" then
			local v65 = u63.captionLastClosedClock
			local v66 = (v65 and os.clock() - v65 or 999) < 0.3 and 0 or 0.5
			task.delay(v66, function()

				if u2.activeState == "Viewing" then
					u62(true)
				end
			end)
		else
			u63.captionLastClosedClock = os.clock()
			u62(false)
		end
	end))
	return u4
end