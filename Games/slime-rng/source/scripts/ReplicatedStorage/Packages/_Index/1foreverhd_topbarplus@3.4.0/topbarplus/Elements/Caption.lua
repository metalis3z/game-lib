-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Caption, time of decompilation: Sun May  3 10:09:30 2026 ]]
local color3 = Color3.fromRGB(39, 41, 48)

return function(p1) -- line: 3
	-- upvalues: color3 (copy)
	local v3 = p1:getInstance("ClickRegion")
	local CanvasGroup = Instance.new("CanvasGroup")

	CanvasGroup.Name = "Caption"
	CanvasGroup.AnchorPoint = Vector2.new(0.5, 0)
	CanvasGroup.BackgroundTransparency = 1
	CanvasGroup.BorderSizePixel = 0
	CanvasGroup.GroupTransparency = 1
	CanvasGroup.Position = UDim2.fromOffset(0, 0)
	CanvasGroup.Visible = true
	CanvasGroup.ZIndex = 30
	CanvasGroup.Parent = v3

	local Frame = Instance.new("Frame")

	Frame.Name = "Box"
	Frame.AutomaticSize = Enum.AutomaticSize.XY
	Frame.BackgroundColor3 = color3
	Frame.Position = UDim2.fromOffset(4, 7)
	Frame.ZIndex = 12
	Frame.Parent = CanvasGroup

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = "Header"
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	TextLabel.Text = "Caption"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 15
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

	local UIPadding = Instance.new("UIPadding")

	UIPadding.Name = "Padding"
	UIPadding.PaddingBottom = UDim.new(0, 12)
	UIPadding.PaddingLeft = UDim.new(0, 12)
	UIPadding.PaddingRight = UDim.new(0, 12)
	UIPadding.PaddingTop = UDim.new(0, 12)
	UIPadding.Parent = Frame

	local Frame2 = Instance.new("Frame")

	Frame2.Name = "Hotkeys"
	Frame2.AutomaticSize = Enum.AutomaticSize.Y
	Frame2.BackgroundTransparency = 1
	Frame2.LayoutOrder = 3
	Frame2.Size = UDim2.fromScale(1, 0)
	Frame2.Visible = false
	Frame2.Parent = Frame

	local UIListLayout2 = Instance.new("UIListLayout")

	UIListLayout2.Name = "Layout1"
	UIListLayout2.Padding = UDim.new(0, 6)
	UIListLayout2.FillDirection = Enum.FillDirection.Vertical
	UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout2.HorizontalFlex = Enum.UIFlexAlignment.None
	UIListLayout2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
	UIListLayout2.VerticalFlex = Enum.UIFlexAlignment.None
	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Parent = Frame2

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
	ImageLabel.Parent = Frame2

	local UIPadding2 = Instance.new("UIPadding")

	UIPadding2.Name = "Inset"
	UIPadding2.PaddingLeft = UDim.new(0, 8)
	UIPadding2.PaddingRight = UDim.new(0, 8)
	UIPadding2.Parent = ImageLabel

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.AutoLocalize = false
	TextLabel2.Name = "LabelContent"
	TextLabel2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	TextLabel2.Text = ""
	TextLabel2.TextColor3 = Color3.fromRGB(189, 190, 190)
	TextLabel2.TextSize = 15
	TextLabel2.AutomaticSize = Enum.AutomaticSize.X
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Position = UDim2.fromOffset(0, -1)
	TextLabel2.Size = UDim2.fromScale(1, 1)
	TextLabel2.ZIndex = 16
	TextLabel2.Parent = ImageLabel

	local ImageLabel2 = Instance.new("ImageLabel")

	ImageLabel2.Name = "Caret"
	ImageLabel2.Image = "rbxassetid://101906294438076"
	ImageLabel2.ImageColor3 = color3
	ImageLabel2.AnchorPoint = Vector2.new(0, 0.5)
	ImageLabel2.BackgroundTransparency = 1
	ImageLabel2.Position = UDim2.new(0, 0, 0, 4)
	ImageLabel2.Size = UDim2.fromOffset(16, 8)
	ImageLabel2.ZIndex = 12
	ImageLabel2.Parent = CanvasGroup

	local ImageLabel3 = Instance.new("ImageLabel")

	ImageLabel3.Visible = true
	ImageLabel3.Name = "DropShadow"
	ImageLabel3.Image = "rbxassetid://124920646932671"
	ImageLabel3.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel3.ImageTransparency = 0.45
	ImageLabel3.ScaleType = Enum.ScaleType.Slice
	ImageLabel3.SliceCenter = Rect.new(12, 12, 13, 13)
	ImageLabel3.BackgroundTransparency = 1
	ImageLabel3.Position = UDim2.fromOffset(0, 5)
	ImageLabel3.Size = UDim2.new(1, 0, 0, 48)
	ImageLabel3.Parent = CanvasGroup
	Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 145
		-- upvalues: ImageLabel3 (copy), Frame (copy)
		ImageLabel3.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8)
	end)

	local captionJanitor = p1.captionJanitor
	local _, v19 = p1:clipOutside(CanvasGroup)

	v19.AutomaticSize = Enum.AutomaticSize.None
	captionJanitor:add(CanvasGroup:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ matchSize ]] -- line: 155
		-- upvalues: CanvasGroup (copy), v19 (copy)
		local AbsoluteSize = CanvasGroup.AbsoluteSize

		v19.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
	end))

	local AbsoluteSize = CanvasGroup.AbsoluteSize

	v19.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)

	local u21 = false
	local Header = CanvasGroup.Box.Header
	local UserInputService = game:GetService("UserInputService")

	local function updateHotkey(p2) -- line: 168
		-- upvalues: UserInputService (copy), CanvasGroup (copy), p1 (copy), Header (copy), TextLabel2 (copy), Frame2 (copy)
		local KeyboardEnabled = UserInputService.KeyboardEnabled
		local v45 = CanvasGroup:GetAttribute("CaptionText") or ""
		local v46 = v45 == "_hotkey_"

		if not KeyboardEnabled and v46 then
			p1:setCaption()

			return
		end

		Header.Text = v45
		Header.Visible = not v46

		if p2 then
			TextLabel2.Text = p2.Name
			Frame2.Visible = true
		end

		if not KeyboardEnabled then
			Frame2.Visible = false
		end
	end

	CanvasGroup:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey)

	local Quad = Enum.EasingStyle.Quad
	local tweenInfo = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In)
	local tweenInfo2 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out)
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")

	local function updatePosition(p3) -- line: 201
		-- upvalues: u21 (ref), ImageLabel2 (copy), CanvasGroup (copy), v3 (copy), v19 (copy), tweenInfo (copy), tweenInfo2 (copy), TweenService (copy), RunService (copy)
		if not u21 then
			return
		end

		local v50 = if p3 == nil then u21 else p3
		local v51 = not v50
		local v52 = not (if v51 == nil then u21 else v51) and 2 or 10
		local uDim2 = UDim2.new(0.5, 0, 1, v52)
		local v54 = not (if v50 == nil then u21 else v50) and 2 or 10
		local uDim2_2 = UDim2.new(0.5, 0, 1, v54)

		if v50 then
			local YOffset = ImageLabel2.Position.Y.Offset

			ImageLabel2.Position = UDim2.fromOffset(0, YOffset)
			CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY
			CanvasGroup.Size = UDim2.fromOffset(32, 53)
		else
			local AbsoluteSize2 = CanvasGroup.AbsoluteSize

			CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y
			CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize2.X, AbsoluteSize2.Y)
		end

		local u58 = nil

		local function updateCaret() -- line: 230
			-- upvalues: v3 (copy), CanvasGroup (copy), ImageLabel2 (copy), u58 (ref)
			local v73 = v3.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + v3.AbsoluteSize.X / 2 - ImageLabel2.AbsoluteSize.X / 2
			local YOffset = ImageLabel2.Position.Y.Offset
			local uDim2_3 = UDim2.fromOffset(v73, YOffset)

			if v73 ~= u58 then
				u58 = v73
				ImageLabel2.Position = UDim2.fromOffset(0, YOffset)
				task.wait()
			end

			ImageLabel2.Position = uDim2_3
		end

		v19.Position = uDim2
		updateCaret()

		local v60 = v50 and tweenInfo or tweenInfo2
		local v61 = TweenService:Create(v19, v60, {
			Position = uDim2_2
		})
		local connection = RunService.Heartbeat:Connect(updateCaret)

		v61:Play()
		v61.Completed:Once(function() -- line: 253
			-- upvalues: connection (copy)
			connection:Disconnect()
		end)
	end

	captionJanitor:add(v3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 258
		-- upvalues: updatePosition (copy)
		updatePosition()
	end))
	updatePosition(false)
	captionJanitor:add(p1.toggleKeyAdded:Connect(updateHotkey))

	for k, _ in pairs(p1.bindedToggleKeys) do
		local KeyboardEnabled = UserInputService.KeyboardEnabled
		local v34 = CanvasGroup:GetAttribute("CaptionText") or ""
		local v35 = v34 == "_hotkey_"

		if not KeyboardEnabled and v35 then
			p1:setCaption()

			break
		end

		Header.Text = v34
		Header.Visible = not v35

		if k then
			TextLabel2.Text = k.Name
			Frame2.Visible = true
		end

		if KeyboardEnabled then
			break
		end

		Frame2.Visible = false

		break
	end

	captionJanitor:add(p1.fakeToggleKeyChanged:Connect(updateHotkey))

	local fakeToggleKey = p1.fakeToggleKey

	if fakeToggleKey then
		local KeyboardEnabled = UserInputService.KeyboardEnabled
		local v38 = CanvasGroup:GetAttribute("CaptionText") or ""
		local v39 = v38 == "_hotkey_"

		if not KeyboardEnabled and v39 then
			p1:setCaption()
		else
			Header.Text = v38
			Header.Visible = not v39

			if fakeToggleKey then
				TextLabel2.Text = fakeToggleKey.Name
				Frame2.Visible = true
			end

			if not KeyboardEnabled then
				Frame2.Visible = false
			end
		end
	end

	local function setCaptionEnabled(p4) -- line: 274
		-- upvalues: u21 (ref), p1 (copy), tweenInfo (copy), tweenInfo2 (copy), TweenService (copy), CanvasGroup (copy), v19 (copy), updatePosition (copy), UserInputService (copy), Header (copy), Frame2 (copy)
		if p4 == u21 then
			return
		end

		local joinedFrame = p1.joinedFrame

		if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then
			p4 = false
		end

		u21 = p4

		local v65 = not p4 and 1 or 0
		local v66 = p4 and tweenInfo or tweenInfo2

		TweenService:Create(CanvasGroup, v66, {
			GroupTransparency = v65
		}):Play()

		if p4 then
			v19:SetAttribute("ForceUpdate", true)
		end

		updatePosition()

		local KeyboardEnabled = UserInputService.KeyboardEnabled
		local v68 = CanvasGroup:GetAttribute("CaptionText") or ""
		local v69 = v68 == "_hotkey_"

		if not KeyboardEnabled and v69 then
			p1:setCaption()

			return
		end

		Header.Text = v68
		Header.Visible = not v69

		if not KeyboardEnabled then
			Frame2.Visible = false
		end
	end

	local iconModule = require(p1.iconModule)

	captionJanitor:add(p1.stateChanged:Connect(function(p5) -- line: 299
		-- upvalues: iconModule (copy), p1 (copy), setCaptionEnabled (copy)
		if p5 == "Viewing" then
			local captionLastClosedClock = iconModule.captionLastClosedClock
			local v72 = not ((captionLastClosedClock and os.clock() - captionLastClosedClock or 999) < 0.3) and 0.5 or 0

			task.delay(v72, function() -- line: 304
				-- upvalues: p1 (copy), setCaptionEnabled (copy)
				if p1.activeState == "Viewing" then
					setCaptionEnabled(true)
				end
			end)

			return
		end

		iconModule.captionLastClosedClock = os.clock()
		setCaptionEnabled(false)
	end))

	return CanvasGroup
end
