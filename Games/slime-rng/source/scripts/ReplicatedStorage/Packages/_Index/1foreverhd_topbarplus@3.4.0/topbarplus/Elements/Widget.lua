-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Widget, time of decompilation: Sun May  3 10:09:33 2026 ]]
return function(p1, p2) -- line: 6
	local Frame = Instance.new("Frame")

	Frame:SetAttribute("WidgetUID", p1.UID)
	Frame.Name = "Widget"
	Frame.BackgroundTransparency = 1
	Frame.Visible = true
	Frame.ZIndex = 20
	Frame.Active = false
	Frame.ClipsDescendants = true

	local Frame2 = Instance.new("Frame")

	Frame2.Name = "IconButton"
	Frame2.Visible = true
	Frame2.ZIndex = 2
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame
	Frame2.ClipsDescendants = true
	Frame2.Active = false
	p1.deselected:Connect(function() -- line: 25
		-- upvalues: Frame2 (copy), p1 (copy)
		Frame2.ClipsDescendants = true
		task.delay(0.2, function() -- line: 27
			-- upvalues: p1 (copy), Frame2 (copy)
			if p1.isSelected then
				Frame2.ClipsDescendants = false
			end
		end)
	end)

	local GuiService = game:GetService("GuiService")

	p1:setBehaviour("IconButton", "BackgroundTransparency", function(p3) -- line: 36
		-- upvalues: GuiService (copy)
		local v35 = p3 * GuiService.PreferredTransparency

		if p3 == 1 then
			return p3
		end

		return v35
	end)
	p1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- line: 44
		-- upvalues: p1 (copy), Frame2 (copy)
		p1:refreshAppearance(Frame2, "BackgroundTransparency")
	end))

	local UICorner = Instance.new("UICorner")

	UICorner:SetAttribute("Collective", "IconCorners")
	UICorner.Name = "UICorner"
	UICorner.Parent = Frame2

	local v7 = require(script.Parent.Menu)(p1)
	local MenuUIListLayout = v7.MenuUIListLayout
	local MenuGap = v7.MenuGap

	v7.Parent = Frame2

	local Frame3 = Instance.new("Frame")

	Frame3.Name = "IconSpot"
	Frame3.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
	Frame3.BackgroundTransparency = 0.9
	Frame3.Visible = true
	Frame3.AnchorPoint = Vector2.new(0, 0.5)
	Frame3.ZIndex = 5
	Frame3.Parent = v7
	UICorner:Clone().Parent = Frame3

	local clone = Frame3:Clone()

	clone.UICorner.Name = "OverlayUICorner"
	clone.Name = "IconOverlay"
	clone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	clone.ZIndex = Frame3.ZIndex + 1
	clone.Size = UDim2.new(1, 0, 1, 0)
	clone.Position = UDim2.new(0, 0, 0, 0)
	clone.AnchorPoint = Vector2.new(0, 0)
	clone.Visible = false
	clone.Parent = Frame3

	local TextButton = Instance.new("TextButton")

	TextButton:SetAttribute("CorrespondingIconUID", p1.UID)
	TextButton.Name = "ClickRegion"
	TextButton.BackgroundTransparency = 1
	TextButton.Visible = true
	TextButton.Text = ""
	TextButton.ZIndex = 20
	TextButton.Selectable = true
	TextButton.SelectionGroup = true
	TextButton.Parent = Frame3
	require(script.Parent.Parent.Features.Gamepad).registerButton(TextButton)
	UICorner:Clone().Parent = TextButton

	local Frame4 = Instance.new("Frame")

	Frame4.Name = "Contents"
	Frame4.BackgroundTransparency = 1
	Frame4.Size = UDim2.fromScale(1, 1)
	Frame4.Parent = Frame3

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.Name = "ContentsList"
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
	UIListLayout.Padding = UDim.new(0, 3)
	UIListLayout.Parent = Frame4

	local Frame5 = Instance.new("Frame")

	Frame5.Name = "PaddingLeft"
	Frame5.LayoutOrder = 1
	Frame5.ZIndex = 5
	Frame5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame5.BackgroundTransparency = 1
	Frame5.BorderSizePixel = 0
	Frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame5.Parent = Frame4

	local Frame6 = Instance.new("Frame")

	Frame6.Name = "PaddingCenter"
	Frame6.LayoutOrder = 3
	Frame6.ZIndex = 5
	Frame6.Size = UDim2.new(0, 0, 1, 0)
	Frame6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame6.BackgroundTransparency = 1
	Frame6.BorderSizePixel = 0
	Frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame6.Parent = Frame4

	local Frame7 = Instance.new("Frame")

	Frame7.Name = "PaddingRight"
	Frame7.LayoutOrder = 5
	Frame7.ZIndex = 5
	Frame7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame7.BackgroundTransparency = 1
	Frame7.BorderSizePixel = 0
	Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame7.Parent = Frame4

	local Frame8 = Instance.new("Frame")

	Frame8.Name = "IconLabelContainer"
	Frame8.LayoutOrder = 4
	Frame8.ZIndex = 3
	Frame8.AnchorPoint = Vector2.new(0, 0.5)
	Frame8.Size = UDim2.new(0, 0, 0.5, 0)
	Frame8.BackgroundTransparency = 1
	Frame8.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame8.Parent = Frame4

	local TextLabel = Instance.new("TextLabel")
	local v20 = workspace.CurrentCamera.ViewportSize.X + 200

	TextLabel.Name = "IconLabel"
	TextLabel.LayoutOrder = 4
	TextLabel.ZIndex = 15
	TextLabel.AnchorPoint = Vector2.new(0, 0)
	TextLabel.Size = UDim2.new(0, v20, 1, 0)
	TextLabel.ClipsDescendants = false
	TextLabel.BackgroundTransparency = 1
	TextLabel.Position = UDim2.fromScale(0, 0)
	TextLabel.RichText = true
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Text = ""
	TextLabel.TextWrapped = true
	TextLabel.TextWrap = true
	TextLabel.TextScaled = false
	TextLabel.Active = false
	TextLabel.AutoLocalize = true
	TextLabel.Parent = Frame8

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Name = "IconImage"
	ImageLabel.LayoutOrder = 2
	ImageLabel.ZIndex = 15
	ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
	ImageLabel.Size = UDim2.new(0, 0, 0.5, 0)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Position = UDim2.new(0, 11, 0.5, 0)
	ImageLabel.ScaleType = Enum.ScaleType.Stretch
	ImageLabel.Active = false
	ImageLabel.Parent = Frame4

	local clone2 = UICorner:Clone()

	clone2:SetAttribute("Collective", nil)
	clone2.CornerRadius = UDim.new(0, 0)
	clone2.Name = "IconImageCorner"
	clone2.Parent = ImageLabel

	local TweenService = game:GetService("TweenService")
	local n1 = 0
	local v25 = require(script.Parent.Parent.Utility).createStagger(0.01, function(_) --[[ handleLabelAndImageChangesUnstaggered ]] -- line: 195
		-- upvalues: p1 (copy), TextLabel (copy), ImageLabel (copy), Frame8 (copy), Frame5 (copy), Frame6 (copy), Frame7 (copy), Frame2 (copy), UIListLayout (copy), Frame4 (copy), Frame (copy), v20 (copy), v7 (copy), Frame3 (copy), MenuUIListLayout (copy), MenuGap (copy), TweenService (copy), TextButton (copy), n1 (ref), p2 (copy)
		task.defer(function() -- line: 202
			-- upvalues: p1 (copy), TextLabel (copy), ImageLabel (copy), Frame8 (copy), Frame5 (copy), Frame6 (copy), Frame7 (copy), Frame2 (copy), UIListLayout (copy), Frame4 (copy), Frame (copy), v20 (copy), v7 (copy), Frame3 (copy), MenuUIListLayout (copy), MenuGap (copy), TweenService (copy), TextButton (copy), n1 (ref), p2 (copy)
			local indicator = p1.indicator
			local v42 = indicator and indicator.Visible
			local v43 = v42 or TextLabel.Text ~= ""
			local v44 = ImageLabel.Image ~= "" and ImageLabel.Image ~= nil
			local _ = Enum.HorizontalAlignment.Center
			local uDim2 = UDim2.fromScale(1, 1)

			if v44 and not v43 then
				Frame8.Visible = false
				ImageLabel.Visible = true
				Frame5.Visible = false
				Frame6.Visible = false
				Frame7.Visible = false
			elseif not v44 and v43 then
				Frame8.Visible = true
				ImageLabel.Visible = false
				Frame5.Visible = true
				Frame6.Visible = false
				Frame7.Visible = true
			elseif v44 and v43 then
				Frame8.Visible = true
				ImageLabel.Visible = true
				Frame5.Visible = true
				Frame6.Visible = not v42
				Frame7.Visible = not v42

				local _ = Enum.HorizontalAlignment.Left
			end

			Frame2.Size = uDim2

			local PaddingOffset = UIListLayout.Padding.Offset
			local v49 = PaddingOffset
			local TextBoundsX = TextLabel.TextBounds.X

			Frame8.Size = UDim2.new(0, TextBoundsX, TextLabel.Size.Y.Scale, 0)

			for _, v in pairs(Frame4:GetChildren()) do
				if v:IsA("GuiObject") and v.Visible == true then
					v49 += (v:GetAttribute("TargetWidth") or v.AbsoluteSize.X) + PaddingOffset
				end
			end

			local MinimumWidth = Frame:GetAttribute("MinimumWidth")
			local MinimumHeight = Frame:GetAttribute("MinimumHeight")
			local BorderSize = Frame:GetAttribute("BorderSize")
			local v56 = math.clamp(v49, MinimumWidth, v20)
			local n2 = 0
			local v58 = #p1.menuIcons > 0 and p1.isSelected

			if v58 then
				for _, v in pairs(v7:GetChildren()) do
					if v ~= Frame3 and v:IsA("GuiObject") and v.Visible then
						n2 += (v:GetAttribute("TargetWidth") or v.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset
					end
				end

				if not Frame3.Visible then
					local v61 = Frame3

					v56 -= (v61:GetAttribute("TargetWidth") or v61.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset * 2 + BorderSize
				end

				n2 -= BorderSize * 0.5
				v56 += n2 - BorderSize * 0.75
			end

			MenuGap.Visible = v58 and Frame3.Visible

			local DesiredWidth = Frame:GetAttribute("DesiredWidth")

			if DesiredWidth and v56 < DesiredWidth then
				v56 = DesiredWidth
			end

			p1.updateMenu:Fire()

			local v63 = math.max(v56 - n2, MinimumWidth) - BorderSize * 2
			local MenuWidth = v7:GetAttribute("MenuWidth")
			local v65 = MenuWidth and MenuWidth + v63 + MenuUIListLayout.Padding.Offset + 10

			if v65 then
				local MaxWidth = v7:GetAttribute("MaxWidth")

				if MaxWidth then
					v65 = math.max(MaxWidth, MinimumWidth)
				end

				v7:SetAttribute("MenuCanvasWidth", v56)

				if v65 < v56 then
					v56 = v65
				end
			end

			local Quint = Enum.EasingStyle.Quint
			local Out = Enum.EasingDirection.Out
			local v69 = Frame3
			local v70 = math.max(v63, v69:GetAttribute("TargetWidth") or v69.AbsoluteSize.X, Frame3.AbsoluteSize.X)
			local v71 = Frame
			local v72 = math.max(v56, v71:GetAttribute("TargetWidth") or v71.AbsoluteSize.X, Frame.AbsoluteSize.X)
			local tweenInfo = TweenInfo.new(v70 / 750, Quint, Out)
			local tweenInfo2 = TweenInfo.new(v72 / 750, Quint, Out)

			TweenService:Create(Frame3, tweenInfo, {
				Position = UDim2.new(0, BorderSize, 0.5, 0),
				Size = UDim2.new(0, v63, 1, -BorderSize * 2)
			}):Play()
			TweenService:Create(TextButton, tweenInfo, {
				Size = UDim2.new(0, v63, 1, 0)
			}):Play()

			local uDim2_2 = UDim2.fromOffset(v56, MinimumHeight)

			if MinimumHeight ~= Frame.Size.Y.Offset then
				Frame.Size = uDim2_2
			end

			Frame:SetAttribute("TargetWidth", uDim2_2.X.Offset)
			TweenService:Create(Frame, tweenInfo2, {
				Size = uDim2_2
			}):Play()
			n1 += 1

			for i = 1, tweenInfo2.Time * 100 do
				task.delay(i / 100, function() -- line: 314
					-- upvalues: p2 (copy), p1 (copy)
					p2.iconChanged:Fire(p1)
				end)
			end

			task.delay(tweenInfo2.Time - 0.2, function() -- line: 318
				-- upvalues: n1 (ref), p1 (copy)
				n1 -= 1
				task.defer(function() -- line: 320
					-- upvalues: n1 (ref), p1 (copy)
					if n1 == 0 then
						p1.resizingComplete:Fire()
					end
				end)
			end)
			p1:updateParent()
		end)
	end)
	local u26 = true

	p1:setBehaviour("IconLabel", "Text", v25)
	p1:setBehaviour("IconLabel", "FontFace", function(p5) -- line: 333
		-- upvalues: TextLabel (copy), v25 (copy), u26 (ref)
		if p5 == TextLabel.FontFace then
			return
		end

		task.spawn(function() -- line: 338
			-- upvalues: v25 (copy), u26 (ref)
			v25()

			if u26 then
				u26 = false

				for _ = 1, 10 do
					task.wait(1)
					v25()
				end
			end
		end)
	end)

	local function updateBorderSize() -- line: 360
		-- upvalues: Frame (copy), p1 (copy), Frame3 (copy), v7 (copy), MenuGap (copy), MenuUIListLayout (copy), v25 (copy)
		task.defer(function() -- line: 361
			-- upvalues: Frame (copy), p1 (copy), Frame3 (copy), v7 (copy), MenuGap (copy), MenuUIListLayout (copy), v25 (copy)
			local BorderSize = Frame:GetAttribute("BorderSize")
			local alignment = p1.alignment
			local v80 = if Frame3.Visible ~= false then alignment == "Right" and -BorderSize or BorderSize else 0

			v7.Position = UDim2.new(0, v80, 0, 0)
			MenuGap.Size = UDim2.fromOffset(BorderSize, 0)
			MenuUIListLayout.Padding = UDim.new(0, 0)
			v25()
		end)
	end

	p1:setBehaviour("Widget", "BorderSize", updateBorderSize)
	p1:setBehaviour("IconSpot", "Visible", updateBorderSize)
	p1.startMenuUpdate:Connect(v25)
	p1.updateSize:Connect(v25)
	p1:setBehaviour("ContentsList", "HorizontalAlignment", v25)
	p1:setBehaviour("Widget", "Visible", v25)
	p1:setBehaviour("Widget", "DesiredWidth", v25)
	p1:setBehaviour("Widget", "MinimumWidth", v25)
	p1:setBehaviour("Widget", "MinimumHeight", v25)
	p1:setBehaviour("Indicator", "Visible", v25)
	p1:setBehaviour("IconImageRatio", "AspectRatio", v25)
	p1:setBehaviour("IconImage", "Image", function(p6) -- line: 382
		-- upvalues: ImageLabel (copy), v25 (copy)
		local v39 = tonumber(p6) and "http://www.roblox.com/asset/?id=" .. p6 or (p6 or "")

		if v39 ~= ImageLabel.Image then
			v25()
		end

		return v39
	end)
	p1.alignmentChanged:Connect(function(p7) -- line: 389
		-- upvalues: MenuUIListLayout (copy), Frame (copy), p1 (copy), Frame3 (copy), v7 (copy), MenuGap (copy), v25 (copy)
		if p7 == "Center" then
			p7 = "Left"
		end

		MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[p7]
		task.defer(function() -- line: 361
			-- upvalues: Frame (copy), p1 (copy), Frame3 (copy), v7 (copy), MenuGap (copy), MenuUIListLayout (copy), v25 (copy)
			local BorderSize = Frame:GetAttribute("BorderSize")
			local alignment = p1.alignment
			local v83 = if Frame3.Visible ~= false then alignment == "Right" and -BorderSize or BorderSize else 0

			v7.Position = UDim2.new(0, v83, 0, 0)
			MenuGap.Size = UDim2.fromOffset(BorderSize, 0)
			MenuUIListLayout.Padding = UDim.new(0, 0)
			v25()
		end)
	end)

	local LocalPlayer = game:GetService("Players").LocalPlayer
	local LocaleId = LocalPlayer.LocaleId

	p1.janitor:add(LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(function() -- line: 401
		-- upvalues: LocalPlayer (copy), LocaleId (ref), p1 (copy)
		task.delay(0.2, function() -- line: 402
			-- upvalues: LocalPlayer (copy), LocaleId (ref), p1 (copy)
			local LocaleId2 = LocalPlayer.LocaleId

			if LocaleId2 ~= LocaleId then
				LocaleId = LocaleId2
				p1:refresh()
				task.wait(0.5)
				p1:refresh()
			end
		end)
	end))

	local NumberValue = Instance.new("NumberValue")

	NumberValue.Name = "IconImageScale"
	NumberValue.Parent = ImageLabel
	NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- line: 416
		-- upvalues: ImageLabel (copy), NumberValue (copy)
		ImageLabel.Size = UDim2.new(NumberValue.Value, 0, NumberValue.Value, 0)
	end)

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

	UIAspectRatioConstraint.Name = "IconImageRatio"
	UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
	UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint.Parent = ImageLabel

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Name = "IconGradient"
	UIGradient.Enabled = true
	UIGradient.Parent = Frame2

	local UIGradient2 = Instance.new("UIGradient")

	UIGradient2.Name = "IconSpotGradient"
	UIGradient2.Enabled = true
	UIGradient2.Parent = Frame3

	return Frame
end
