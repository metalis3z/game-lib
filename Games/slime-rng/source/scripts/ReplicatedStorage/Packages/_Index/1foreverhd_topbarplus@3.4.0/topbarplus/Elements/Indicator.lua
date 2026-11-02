-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Indicator, time of decompilation: Sun May  3 10:09:31 2026 ]]
return function(p1, _) -- line: 1
	local widget = p1.widget
	local v4 = p1:getInstance("Contents")
	local Frame = Instance.new("Frame")

	Frame.Name = "Indicator"
	Frame.LayoutOrder = 9999999
	Frame.ZIndex = 6
	Frame.Size = UDim2.new(0, 42, 0, 42)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BackgroundTransparency = 1
	Frame.Position = UDim2.new(1, 0, 0.5, 0)
	Frame.BorderSizePixel = 0
	Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Frame.Parent = v4

	local Frame2 = Instance.new("Frame")

	Frame2.Name = "IndicatorButton"
	Frame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame2.BorderSizePixel = 0
	Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Frame2.Parent = Frame

	local GuiService = game:GetService("GuiService")
	local GamepadService = game:GetService("GamepadService")
	local v9 = p1:getInstance("ClickRegion")

	local function selectionChanged() -- line: 28
		-- upvalues: GuiService (copy), v9 (copy), Frame2 (copy)
		if GuiService.SelectedObject == v9 then
			Frame2.BackgroundTransparency = 1
			Frame2.Position = UDim2.new(0.5, -2, 0.5, 0)
			Frame2.Size = UDim2.fromScale(1.2, 1.2)

			return
		end

		Frame2.BackgroundTransparency = 0.75
		Frame2.Position = UDim2.new(0.5, 2, 0.5, 0)
		Frame2.Size = UDim2.fromScale(1, 1)
	end

	p1.janitor:add(GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(selectionChanged))
	selectionChanged()

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.LayoutOrder = 2
	ImageLabel.ZIndex = 15
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
	ImageLabel.Parent = Frame2

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame2

	local UserInputService = game:GetService("UserInputService")

	local function setIndicatorVisible(p3) -- line: 58
		-- upvalues: Frame (copy), GamepadService (copy), p1 (copy)
		if p3 == nil then
			p3 = Frame.Visible
		end

		if GamepadService.GamepadCursorEnabled then
			p3 = false
		end

		if p3 then
			p1:modifyTheme({
				"PaddingRight",
				"Size",
				UDim2.new(0, 0, 1, 0)
			}, "IndicatorPadding")
		elseif Frame.Visible then
			p1:removeModification("IndicatorPadding")
		end

		p1:modifyTheme({
			"Indicator",
			"Visible",
			p3
		})
		p1.updateSize:Fire()
	end

	p1.janitor:add(GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(setIndicatorVisible))
	p1.indicatorSet:Connect(function(p4) -- line: 74
		-- upvalues: ImageLabel (copy), UserInputService (copy), setIndicatorVisible (copy)
		local v18 = false

		if p4 then
			ImageLabel.Image = UserInputService:GetImageForKeyCode(p4)
			v18 = true
		end

		setIndicatorVisible(v18)
	end)
	widget:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ updateSize ]] -- line: 83
		-- upvalues: widget (copy), Frame (copy)
		local v19 = widget.AbsoluteSize.Y * 0.96

		Frame.Size = UDim2.new(0, v19, 0, v19)
	end)

	local v15 = widget.AbsoluteSize.Y * 0.96

	Frame.Size = UDim2.new(0, v15, 0, v15)

	return Frame
end
