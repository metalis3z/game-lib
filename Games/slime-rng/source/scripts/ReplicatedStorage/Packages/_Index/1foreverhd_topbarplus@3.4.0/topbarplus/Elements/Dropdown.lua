-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dropdown, time of decompilation: Sun May  3 10:09:31 2026 ]]
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Themes = require(script.Parent.Parent.Features.Themes)

return function(p1) -- line: 5
	-- upvalues: Themes (copy), TweenService (copy), RunService (copy)
	local Frame = Instance.new("Frame")

	Frame.Name = "Dropdown"
	Frame.AutomaticSize = Enum.AutomaticSize.X
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.AnchorPoint = Vector2.new(0.5, 0)
	Frame.Position = UDim2.new(0.5, 0, 1, 10)
	Frame.ZIndex = -2
	Frame.ClipsDescendants = true
	Frame.Parent = p1.widget

	local GuiService = game:GetService("GuiService")

	p1:setBehaviour("Dropdown", "BackgroundTransparency", function(p2) -- line: 20
		-- upvalues: GuiService (copy)
		local v27 = p2 * GuiService.PreferredTransparency

		if p2 == 1 then
			return p2
		end

		return v27
	end)
	p1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- line: 28
		-- upvalues: p1 (copy), Frame (copy)
		p1:refreshAppearance(Frame, "BackgroundTransparency")
	end))

	local UICorner = Instance.new("UICorner")

	UICorner.Name = "DropdownCorner"
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Frame

	local ScrollingFrame = Instance.new("ScrollingFrame")

	ScrollingFrame.Name = "DropdownScroller"
	ScrollingFrame.AutomaticSize = Enum.AutomaticSize.X
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
	ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.ZIndex = -1
	ScrollingFrame.ClipsDescendants = true
	ScrollingFrame.Visible = true
	ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None
	ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	ScrollingFrame.Active = false
	ScrollingFrame.ScrollingEnabled = true
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ScrollingFrame.ScrollBarThickness = 5
	ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.ScrollBarImageTransparency = 0.8
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.Selectable = false
	ScrollingFrame.Active = true
	ScrollingFrame.Parent = Frame

	local NumberValue = Instance.new("NumberValue")

	NumberValue.Name = "DropdownSpeed"
	NumberValue.Value = 0.07
	NumberValue.Parent = Frame

	local UIPadding = Instance.new("UIPadding")

	UIPadding.Name = "DropdownPadding"
	UIPadding.PaddingTop = UDim.new(0, 0)
	UIPadding.PaddingBottom = UDim.new(0, 0)
	UIPadding.Parent = ScrollingFrame

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.Name = "DropdownList"
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
	UIListLayout.Parent = ScrollingFrame

	local dropdownJanitor = p1.dropdownJanitor
	local iconModule = require(p1.iconModule)

	p1.dropdownChildAdded:Connect(function(p3) -- line: 81
		local _, v30 = p3:modifyTheme({
			{
				"Widget",
				"BorderSize",
				0
			},
			{
				"IconCorners",
				"CornerRadius",
				UDim.new(0, 10)
			},
			{
				"Widget",
				"MinimumWidth",
				190
			},
			{
				"Widget",
				"MinimumHeight",
				58
			},
			{
				"IconLabel",
				"TextSize",
				20
			},
			{
				"IconOverlay",
				"Size",
				UDim2.new(1, 0, 1, 0)
			},
			{
				"PaddingLeft",
				"Size",
				UDim2.fromOffset(25, 0)
			},
			{
				"Notice",
				"Position",
				UDim2.new(1, -24, 0, 5)
			},
			{
				"ContentsList",
				"HorizontalAlignment",
				Enum.HorizontalAlignment.Left
			},
			{
				"Selection",
				"Size",
				UDim2.new(1, -0, 1, -0)
			},
			{
				"Selection",
				"Position",
				UDim2.new(0, 0, 0, 0)
			}
		})

		task.defer(function() -- line: 95
			-- upvalues: p3 (copy), v30 (copy)
			p3.joinJanitor:add(function() -- line: 96
				-- upvalues: p3 (copy), v30 (copy)
				p3:removeModification(v30)
			end)
		end)
	end)
	p1.dropdownSet:Connect(function(p4) -- line: 101
		-- upvalues: p1 (copy), iconModule (copy)
		for _, v in pairs(p1.dropdownIcons) do
			iconModule.getIconByUID(v):destroy()
		end

		if type(p4) == "table" then
			for _, v in pairs(p4) do
				v:joinDropdown(p1)
			end
		end
	end)

	local function updateMaxIcons() -- line: 113
		-- upvalues: Frame (copy), ScrollingFrame (copy), UIPadding (copy)
		local MaxIcons = Frame:GetAttribute("MaxIcons")

		if not MaxIcons then
			return 0
		end

		local t1 = {}

		for _, v in pairs(ScrollingFrame:GetChildren()) do
			if v:IsA("GuiObject") and v.Visible then
				table.insert(t1, v)
			end
		end

		table.sort(t1, function(p5, p6) -- line: 124
			return p5.AbsolutePosition.Y < p6.AbsolutePosition.Y
		end)

		local n1 = 0
		local v41 = math.ceil(MaxIcons)

		for i = 1, v41 do
			local v43 = t1[i]

			if not v43 then
				return n1 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)
			end

			local AbsoluteSizeY = v43.AbsoluteSize.Y

			if i == v41 and v41 ~= MaxIcons then
				AbsoluteSizeY *= MaxIcons - v41 + 1
			end

			n1 += AbsoluteSizeY
		end

		return n1 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)
	end

	local u15 = nil
	local u16 = nil
	local u17 = nil
	local u18 = nil

	local function updateVisibility() -- line: 159
		-- upvalues: Themes (copy), Frame (copy), u17 (ref), u18 (ref), NumberValue (copy), u15 (ref), u16 (ref), p1 (copy), updateMaxIcons (copy), TweenService (copy)
		local v47 = Themes.getInstanceValue(Frame, "MaxIcons") or 1
		local v48

		if u17 and (v47 == u17 and u18) then
			v48 = u18
		else
			v48 = TweenInfo.new(NumberValue.Value * v47, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			u18 = v48
			u17 = v47
		end

		if u15 then
			u15:Cancel()
			u15 = nil
		end

		if u16 then
			u16:Cancel()
			u16 = nil
		end

		if p1.isSelected then
			local v49 = updateMaxIcons()

			Frame.Visible = true
			Frame.BackgroundTransparency = 0
			Frame.Size = UDim2.new(0, Frame.Size.X.Offset, 0, 0)
			u15 = TweenService:Create(Frame, v48, {
				Size = UDim2.new(0, Frame.Size.X.Offset, 0, v49)
			})
			u15:Play()
			u15.Completed:Connect(function() -- line: 180
				-- upvalues: u15 (ref)
				u15 = nil
			end)

			return
		end

		local tweenInfo = TweenInfo.new(0)

		u16 = TweenService:Create(Frame, tweenInfo, {
			Size = UDim2.new(0, Frame.Size.X.Offset, 0, 0)
		})
		u16:Play()
		u16.Completed:Connect(function() -- line: 187
			-- upvalues: u16 (ref)
			u16 = nil
		end)
	end

	dropdownJanitor:add(p1.toggled:Connect(updateVisibility))
	updateVisibility()

	local function updateChildSize() -- line: 197
		-- upvalues: Themes (copy), Frame (copy), u17 (ref), u18 (ref), NumberValue (copy), p1 (copy), u15 (ref), u16 (ref), RunService (copy), updateMaxIcons (copy), TweenService (copy)
		local v51 = Themes.getInstanceValue(Frame, "MaxIcons") or 1
		local v52

		if u17 and (v51 == u17 and u18) then
			v52 = u18
		else
			v52 = TweenInfo.new(NumberValue.Value * v51, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			u18 = v52
			u17 = v51
		end

		if not p1.isSelected then
			return
		end

		if u15 then
			u15:Cancel()
			u15 = nil
		end

		if u16 then
			u16:Cancel()
			u16 = nil
		end

		RunService.Heartbeat:Wait()

		local v53 = updateMaxIcons()

		u15 = TweenService:Create(Frame, v52, {
			Size = UDim2.new(0, Frame.Size.X.Offset, 0, v53)
		})
		u15:Play()
		u15.Completed:Connect(function() -- line: 215
			-- upvalues: u15 (ref)
			u15 = nil
		end)
	end

	dropdownJanitor:add(p1.toggled:Connect(updateVisibility))

	local n2 = 0
	local u22 = false

	local function updateMaxIconsListener() -- line: 228
		-- upvalues: n2 (ref), u22 (ref), updateMaxIconsListener (copy), Frame (copy), ScrollingFrame (copy), iconModule (copy), p1 (copy), UIPadding (copy)
		n2 += 1

		if u22 then
			return
		end

		local v54 = n2

		u22 = true
		task.defer(function() -- line: 233
			-- upvalues: u22 (ref), n2 (ref), v54 (copy), updateMaxIconsListener (copy)
			u22 = false

			if n2 ~= v54 then
				updateMaxIconsListener()
			end
		end)

		local MaxIcons = Frame:GetAttribute("MaxIcons")

		if not MaxIcons then
			return
		end

		local t2 = {}

		for _, v in pairs(ScrollingFrame:GetChildren()) do
			if v:IsA("GuiObject") and v.Visible then
				table.insert(t2, {
					v,
					v.AbsolutePosition.Y
				})
			end
		end

		table.sort(t2, function(p7, p8) -- line: 248
			return p7[2] < p8[2]
		end)

		local n3 = 0
		local v60 = false
		local v61 = math.ceil(MaxIcons)

		for i = 1, v61 do
			local v63 = t2[i]

			if not v63 then
				break
			end

			local v64 = v63[1]
			local AbsoluteSizeY = v64.AbsoluteSize.Y
			local v66 = i == v61 and v61 ~= MaxIcons

			if v66 then
				AbsoluteSizeY *= MaxIcons - v61 + 1
			end

			n3 += AbsoluteSizeY

			if not v66 then
				local WidgetUID = v64:GetAttribute("WidgetUID")
				local v68 = WidgetUID and iconModule.getIconByUID(WidgetUID)

				if v68 then
					local v69 = nil

					if not v60 then
						v60 = true
						v69 = p1:getInstance("ClickRegion")
					end

					v68:getInstance("ClickRegion").NextSelectionUp = v69
				end
			end
		end

		local v70 = n3 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)

		ScrollingFrame.Size = UDim2.fromOffset(0, v70)
	end

	dropdownJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateMaxIconsListener))
	dropdownJanitor:add(ScrollingFrame.ChildAdded:Connect(updateMaxIconsListener))
	dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateChildSize))
	dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateMaxIconsListener))
	dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateMaxIconsListener))
	dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateChildSize))
	dropdownJanitor:add(p1.childThemeModified:Connect(updateMaxIconsListener))
	updateMaxIconsListener()

	for _, v in pairs(ScrollingFrame:GetChildren()) do
		if v:IsA("GuiObject") then
			v:GetPropertyChangedSignal("Visible"):Connect(updateChildSize)
			v:GetPropertyChangedSignal("Size"):Connect(updateChildSize)
		end
	end

	ScrollingFrame.ChildAdded:Connect(function(child) -- line: 305
		-- upvalues: RunService (copy), updateChildSize (copy)
		RunService.Heartbeat:Wait()

		if child:IsA("GuiObject") then
			child:GetPropertyChangedSignal("Visible"):Connect(updateChildSize)
			child:GetPropertyChangedSignal("Size"):Connect(updateChildSize)
		end

		updateChildSize()
	end)
	Frame.Visible = false

	return Frame
end
