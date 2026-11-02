

return function(u1, u2)
	local u3 = Instance.new("Frame")
	u3:SetAttribute("WidgetUID", u1.UID)
	u3.Name = "Widget"
	u3.BackgroundTransparency = 1
	u3.Visible = true
	u3.ZIndex = 20
	u3.Active = false
	u3.ClipsDescendants = true
	local u4 = Instance.new("Frame")
	u4.Name = "IconButton"
	u4.Visible = true
	u4.ZIndex = 2
	u4.BorderSizePixel = 0
	u4.Parent = u3
	u4.ClipsDescendants = true
	u4.Active = false
	u1.deselected:Connect(function()

		u4.ClipsDescendants = true
		task.delay(0.2, function()

			if u1.isSelected then
				u4.ClipsDescendants = false
			end
		end)
	end)
	local u5 = game:GetService("GuiService")
	u1:setBehaviour("IconButton", "BackgroundTransparency", function(p6)

		local v7 = p6 * u5.PreferredTransparency
		if p6 == 1 then
			return p6
		else
			return v7
		end
	end)
	u1.janitor:add(u5:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()

		u1:refreshAppearance(u4, "BackgroundTransparency")
	end))
	local v8 = Instance.new("UICorner")
	v8:SetAttribute("Collective", "IconCorners")
	v8.Name = "UICorner"
	v8.Parent = u4
	local u9 = require(script.Parent.Menu)(u1)
	local u10 = u9.MenuUIListLayout
	local u11 = u9.MenuGap
	u9.Parent = u4
	local u12 = Instance.new("Frame")
	u12.Name = "IconSpot"
	u12.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
	u12.BackgroundTransparency = 0.9
	u12.Visible = true
	u12.AnchorPoint = Vector2.new(0, 0.5)
	u12.ZIndex = 5
	u12.Parent = u9
	v8:Clone().Parent = u12
	local v13 = u12:Clone()
	v13.UICorner.Name = "OverlayUICorner"
	v13.Name = "IconOverlay"
	v13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v13.ZIndex = u12.ZIndex + 1
	v13.Size = UDim2.new(1, 0, 1, 0)
	v13.Position = UDim2.new(0, 0, 0, 0)
	v13.AnchorPoint = Vector2.new(0, 0)
	v13.Visible = false
	v13.Parent = u12
	local u14 = Instance.new("TextButton")
	u14:SetAttribute("CorrespondingIconUID", u1.UID)
	u14.Name = "ClickRegion"
	u14.BackgroundTransparency = 1
	u14.Visible = true
	u14.Text = ""
	u14.ZIndex = 20
	u14.Selectable = true
	u14.SelectionGroup = true
	u14.Parent = u12
	require(script.Parent.Parent.Features.Gamepad).registerButton(u14)
	v8:Clone().Parent = u14
	local u15 = Instance.new("Frame")
	u15.Name = "Contents"
	u15.BackgroundTransparency = 1
	u15.Size = UDim2.fromScale(1, 1)
	u15.Parent = u12
	local u16 = Instance.new("UIListLayout")
	u16.Name = "ContentsList"
	u16.FillDirection = Enum.FillDirection.Horizontal
	u16.VerticalAlignment = Enum.VerticalAlignment.Center
	u16.SortOrder = Enum.SortOrder.LayoutOrder
	u16.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
	u16.Padding = UDim.new(0, 3)
	u16.Parent = u15
	local u17 = Instance.new("Frame")
	u17.Name = "PaddingLeft"
	u17.LayoutOrder = 1
	u17.ZIndex = 5
	u17.BorderColor3 = Color3.fromRGB(0, 0, 0)
	u17.BackgroundTransparency = 1
	u17.BorderSizePixel = 0
	u17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	u17.Parent = u15
	local u18 = Instance.new("Frame")
	u18.Name = "PaddingCenter"
	u18.LayoutOrder = 3
	u18.ZIndex = 5
	u18.Size = UDim2.new(0, 0, 1, 0)
	u18.BorderColor3 = Color3.fromRGB(0, 0, 0)
	u18.BackgroundTransparency = 1
	u18.BorderSizePixel = 0
	u18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	u18.Parent = u15
	local u19 = Instance.new("Frame")
	u19.Name = "PaddingRight"
	u19.LayoutOrder = 5
	u19.ZIndex = 5
	u19.BorderColor3 = Color3.fromRGB(0, 0, 0)
	u19.BackgroundTransparency = 1
	u19.BorderSizePixel = 0
	u19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	u19.Parent = u15
	local u20 = Instance.new("Frame")
	u20.Name = "IconLabelContainer"
	u20.LayoutOrder = 4
	u20.ZIndex = 3
	u20.AnchorPoint = Vector2.new(0, 0.5)
	u20.Size = UDim2.new(0, 0, 0.5, 0)
	u20.BackgroundTransparency = 1
	u20.Position = UDim2.new(0.5, 0, 0.5, 0)
	u20.Parent = u15
	local u21 = Instance.new("TextLabel")
	local u22 = workspace.CurrentCamera.ViewportSize.X + 200
	u21.Name = "IconLabel"
	u21.LayoutOrder = 4
	u21.ZIndex = 15
	u21.AnchorPoint = Vector2.new(0, 0)
	u21.Size = UDim2.new(0, u22, 1, 0)
	u21.ClipsDescendants = false
	u21.BackgroundTransparency = 1
	u21.Position = UDim2.fromScale(0, 0)
	u21.RichText = true
	u21.TextColor3 = Color3.fromRGB(255, 255, 255)
	u21.TextXAlignment = Enum.TextXAlignment.Left
	u21.Text = ""
	u21.TextWrapped = true
	u21.TextWrap = true
	u21.TextScaled = false
	u21.Active = false
	u21.AutoLocalize = true
	u21.Parent = u20
	local u23 = Instance.new("ImageLabel")
	u23.Name = "IconImage"
	u23.LayoutOrder = 2
	u23.ZIndex = 15
	u23.AnchorPoint = Vector2.new(0, 0.5)
	u23.Size = UDim2.new(0, 0, 0.5, 0)
	u23.BackgroundTransparency = 1
	u23.Position = UDim2.new(0, 11, 0.5, 0)
	u23.ScaleType = Enum.ScaleType.Stretch
	u23.Active = false
	u23.Parent = u15
	local v24 = v8:Clone()
	v24:SetAttribute("Collective", nil)
	v24.CornerRadius = UDim.new(0, 0)
	v24.Name = "IconImageCorner"
	v24.Parent = u23
	local u25 = game:GetService("TweenService")
	local u26 = 0
	local function v64(_) 

		task.defer(function()

			local v27 = u1.indicator
			if v27 then
				v27 = v27.Visible
			end
			local v28 = v27 or u21.Text ~= ""
			local v29
			if u23.Image == "" then
				v29 = false
			else
				v29 = u23.Image ~= nil
			end
			local _ = Enum.HorizontalAlignment.Center
			local v30 = UDim2.fromScale(1, 1)
			if v29 and not v28 then
				u20.Visible = false
				u23.Visible = true
				u17.Visible = false
				u18.Visible = false
				u19.Visible = false
			elseif v29 or not v28 then
				if v29 and v28 then
					u20.Visible = true
					u23.Visible = true
					u17.Visible = true
					u18.Visible = not v27
					u19.Visible = not v27
					local _ = Enum.HorizontalAlignment.Left
				end
			else
				u20.Visible = true
				u23.Visible = false
				u17.Visible = true
				u18.Visible = false
				u19.Visible = true
			end
			u4.Size = v30
			local v31 = u16.Padding.Offset
			local v32 = u21.TextBounds.X
			u20.Size = UDim2.new(0, v32, u21.Size.Y.Scale, 0)
			local v33 = v31
			for _, v34 in pairs(u15:GetChildren()) do
				if v34:IsA("GuiObject") and v34.Visible == true then
					v33 = v33 + ((v34:GetAttribute("TargetWidth") or v34.AbsoluteSize.X) + v31)
				end
			end
			local v35 = u3:GetAttribute("MinimumWidth")
			local v36 = u3:GetAttribute("MinimumHeight")
			local v37 = u3:GetAttribute("BorderSize")
			local v38 = u22
			local v39 = math.clamp(v33, v35, v38)
			local v40 = 0
			local v41 = #u1.menuIcons > 0
			if v41 then
				v41 = u1.isSelected
			end
			if v41 then
				for _, v42 in pairs(u9:GetChildren()) do
					if v42 ~= u12 and (v42:IsA("GuiObject") and v42.Visible) then
						v40 = v40 + ((v42:GetAttribute("TargetWidth") or v42.AbsoluteSize.X) + u10.Padding.Offset)
					end
				end
				if not u12.Visible then
					local v43 = u12
					v39 = v39 - ((v43:GetAttribute("TargetWidth") or v43.AbsoluteSize.X) + u10.Padding.Offset * 2 + v37)
				end
				v40 = v40 - v37 * 0.5
				v39 = v39 + (v40 - v37 * 0.75)
			end
			local v44 = u11
			if v41 then
				v41 = u12.Visible
			end
			v44.Visible = v41
			local v45 = u3:GetAttribute("DesiredWidth")
			if v45 then
				if v39 >= v45 then
					v45 = v39
				end
			else
				v45 = v39
			end
			u1.updateMenu:Fire()
			local v46 = v45 - v40
			local v47 = math.max(v46, v35) - v37 * 2
			local v48 = u9:GetAttribute("MenuWidth")
			if v48 then
				v48 = v48 + v47 + u10.Padding.Offset + 10
			end
			if v48 then
				local v49 = u9:GetAttribute("MaxWidth")
				if v49 then
					v48 = math.max(v49, v35)
				end
				u9:SetAttribute("MenuCanvasWidth", v45)
				if v48 >= v45 then
					v48 = v45
				end
			else
				v48 = v45
			end
			local v50 = Enum.EasingStyle.Quint
			local v51 = Enum.EasingDirection.Out
			local v52 = u12
			local v53 = v52:GetAttribute("TargetWidth") or v52.AbsoluteSize.X
			local v54 = u12.AbsoluteSize.X
			local v55 = math.max(v47, v53, v54)
			local v56 = u3
			local v57 = v56:GetAttribute("TargetWidth") or v56.AbsoluteSize.X
			local v58 = u3.AbsoluteSize.X
			local v59 = math.max(v48, v57, v58)
			local v60 = TweenInfo.new(v55 / 750, v50, v51)
			local v61 = TweenInfo.new(v59 / 750, v50, v51)
			u25:Create(u12, v60, {
				["Position"] = UDim2.new(0, v37, 0.5, 0),
				["Size"] = UDim2.new(0, v47, 1, -v37 * 2)
			}):Play()
			u25:Create(u14, v60, {
				["Size"] = UDim2.new(0, v47, 1, 0)
			}):Play()
			local v62 = UDim2.fromOffset(v48, v36)
			if u3.Size.Y.Offset ~= v36 then
				u3.Size = v62
			end
			u3:SetAttribute("TargetWidth", v62.X.Offset)
			u25:Create(u3, v61, {
				["Size"] = v62
			}):Play()
			u26 = u26 + 1
			for v63 = 1, v61.Time * 100 do
				task.delay(v63 / 100, function()

					u2.iconChanged:Fire(u1)
				end)
			end
			task.delay(v61.Time - 0.2, function()

				u26 = u26 - 1
				task.defer(function()

					if u26 == 0 then
						u1.resizingComplete:Fire()
					end
				end)
			end)
			u1:updateParent()
		end)
	end
	local u65 = require(script.Parent.Parent.Utility).createStagger(0.01, v64)
	local u66 = true
	u1:setBehaviour("IconLabel", "Text", u65)
	u1:setBehaviour("IconLabel", "FontFace", function(p67)

		if u21.FontFace ~= p67 then
			task.spawn(function()

				u65()
				if u66 then
					u66 = false
					for _ = 1, 10 do
						task.wait(1)
						u65()
					end
				end
			end)
		end
	end)
	local function v71() 

		task.defer(function()

			local v68 = u3:GetAttribute("BorderSize")
			local v69 = u1.alignment
			local v70
			if u12.Visible == false then
				v70 = 0
			elseif v69 == "Right" then
				v70 = -v68 or v68
			else
				v70 = v68
			end
			u9.Position = UDim2.new(0, v70, 0, 0)
			u11.Size = UDim2.fromOffset(v68, 0)
			u10.Padding = UDim.new(0, 0)
			u65()
		end)
	end
	u1:setBehaviour("Widget", "BorderSize", v71)
	u1:setBehaviour("IconSpot", "Visible", v71)
	u1.startMenuUpdate:Connect(u65)
	u1.updateSize:Connect(u65)
	u1:setBehaviour("ContentsList", "HorizontalAlignment", u65)
	u1:setBehaviour("Widget", "Visible", u65)
	u1:setBehaviour("Widget", "DesiredWidth", u65)
	u1:setBehaviour("Widget", "MinimumWidth", u65)
	u1:setBehaviour("Widget", "MinimumHeight", u65)
	u1:setBehaviour("Indicator", "Visible", u65)
	u1:setBehaviour("IconImageRatio", "AspectRatio", u65)
	u1:setBehaviour("IconImage", "Image", function(p72)

		local v73 = tonumber(p72) and "http://www.roblox.com/asset/?id=" .. p72 or (p72 or "")
		if u23.Image ~= v73 then
			u65()
		end
		return v73
	end)
	u1.alignmentChanged:Connect(function(p74)

		local v75 = p74 == "Center" and "Left" or p74
		u10.HorizontalAlignment = Enum.HorizontalAlignment[v75]
		task.defer(function()

			local v76 = u3:GetAttribute("BorderSize")
			local v77 = u1.alignment
			local v78
			if u12.Visible == false then
				v78 = 0
			elseif v77 == "Right" then
				v78 = -v76 or v76
			else
				v78 = v76
			end
			u9.Position = UDim2.new(0, v78, 0, 0)
			u11.Size = UDim2.fromOffset(v76, 0)
			u10.Padding = UDim.new(0, 0)
			u65()
		end)
	end)
	local u79 = game:GetService("Players").LocalPlayer
	local u80 = u79.LocaleId
	u1.janitor:add(u79:GetPropertyChangedSignal("LocaleId"):Connect(function()

		task.delay(0.2, function()

			local v81 = u79.LocaleId
			if v81 ~= u80 then
				u80 = v81
				u1:refresh()
				task.wait(0.5)
				u1:refresh()
			end
		end)
	end))
	local u82 = Instance.new("NumberValue")
	u82.Name = "IconImageScale"
	u82.Parent = u23
	u82:GetPropertyChangedSignal("Value"):Connect(function()

		u23.Size = UDim2.new(u82.Value, 0, u82.Value, 0)
	end)
	local v83 = Instance.new("UIAspectRatioConstraint")
	v83.Name = "IconImageRatio"
	v83.AspectType = Enum.AspectType.FitWithinMaxSize
	v83.DominantAxis = Enum.DominantAxis.Height
	v83.Parent = u23
	local v84 = Instance.new("UIGradient")
	v84.Name = "IconGradient"
	v84.Enabled = true
	v84.Parent = u4
	local v85 = Instance.new("UIGradient")
	v85.Name = "IconSpotGradient"
	v85.Enabled = true
	v85.Parent = u12
	return u3
end