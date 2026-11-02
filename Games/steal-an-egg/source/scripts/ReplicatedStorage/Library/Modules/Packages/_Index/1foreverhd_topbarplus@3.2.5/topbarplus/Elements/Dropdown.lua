-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 2 ]]
	local Dropdown = Instance.new("Frame")

	Dropdown.Name = "Dropdown"
	Dropdown.AutomaticSize = Enum.AutomaticSize.XY
	Dropdown.BackgroundTransparency = 1
	Dropdown.BorderSizePixel = 0
	Dropdown.AnchorPoint = Vector2.new(0.5, 0)
	Dropdown.Position = UDim2.new(0.5, 0, 1, 10)
	Dropdown.ZIndex = -2
	Dropdown.ClipsDescendants = true
	Dropdown.Parent = p1.widget

	local GuiService = game:GetService("GuiService")

	p1:setBehaviour("Dropdown", "BackgroundTransparency", function(p1) --[[ Line: 16 | Upvalues: GuiService (copy) ]]
		if p1 == 1 then
			return p1
		end

		return p1 * GuiService.PreferredTransparency
	end)
	p1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() --[[ Line: 24 | Upvalues: p1 (copy), Dropdown (copy) ]]
		p1:refreshAppearance(Dropdown, "BackgroundTransparency")
	end))

	local DropdownCorner = Instance.new("UICorner")

	DropdownCorner.Name = "DropdownCorner"
	DropdownCorner.CornerRadius = UDim.new(0, 10)
	DropdownCorner.Parent = Dropdown

	local DropdownScroller = Instance.new("ScrollingFrame")

	DropdownScroller.Name = "DropdownScroller"
	DropdownScroller.AutomaticSize = Enum.AutomaticSize.X
	DropdownScroller.BackgroundTransparency = 1
	DropdownScroller.BorderSizePixel = 0
	DropdownScroller.AnchorPoint = Vector2.new(0, 0)
	DropdownScroller.Position = UDim2.new(0, 0, 0, 0)
	DropdownScroller.ZIndex = -1
	DropdownScroller.ClipsDescendants = true
	DropdownScroller.Visible = true
	DropdownScroller.VerticalScrollBarInset = Enum.ScrollBarInset.None
	DropdownScroller.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	DropdownScroller.Active = false
	DropdownScroller.ScrollingEnabled = true
	DropdownScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
	DropdownScroller.ScrollBarThickness = 5
	DropdownScroller.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	DropdownScroller.ScrollBarImageTransparency = 0.8
	DropdownScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
	DropdownScroller.Selectable = false
	DropdownScroller.Active = true
	DropdownScroller.Parent = Dropdown

	local DropdownPadding = Instance.new("UIPadding")

	DropdownPadding.Name = "DropdownPadding"
	DropdownPadding.PaddingTop = UDim.new(0, 0)
	DropdownPadding.PaddingBottom = UDim.new(0, 0)
	DropdownPadding.Parent = DropdownScroller

	local DropdownList = Instance.new("UIListLayout")

	DropdownList.Name = "DropdownList"
	DropdownList.FillDirection = Enum.FillDirection.Vertical
	DropdownList.SortOrder = Enum.SortOrder.LayoutOrder
	DropdownList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	DropdownList.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
	DropdownList.Parent = DropdownScroller

	local dropdownJanitor = p1.dropdownJanitor
	local iconModule = require(p1.iconModule)

	p1.dropdownChildAdded:Connect(function(p1) --[[ Line: 72 ]]
		local _, v1 = p1:modifyTheme({
			{ "Widget", "BorderSize", 0 },
			{ "IconCorners", "CornerRadius", UDim.new(0, 10) },
			{ "Widget", "MinimumWidth", 190 },
			{ "Widget", "MinimumHeight", 58 },
			{ "IconLabel", "TextSize", 20 },
			{ "IconOverlay", "Size", UDim2.new(1, 0, 1, 0) },
			{ "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
			{ "Notice", "Position", UDim2.new(1, -24, 0, 5) },
			{ "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
			{ "Selection", "Size", UDim2.new(1, -0, 1, -0) },
			{ "Selection", "Position", UDim2.new(0, 0, 0, 0) }
		})

		task.defer(function() --[[ Line: 87 | Upvalues: p1 (copy), v1 (copy) ]]
			p1.joinJanitor:add(function() --[[ Line: 88 | Upvalues: p1 (ref), v1 (ref) ]]
				p1:removeModification(v1)
			end)
		end)
	end)
	p1.dropdownSet:Connect(function(p12) --[[ Line: 93 | Upvalues: p1 (copy), iconModule (copy) ]]
		for k, v in pairs(p1.dropdownIcons) do
			iconModule.getIconByUID(v):destroy()
		end

		if type(p12) ~= "table" then
			return
		end

		for k, v in pairs(p12) do
			v:joinDropdown(p1)
		end
	end)

	local Utility = require(script.Parent.Parent.Utility)

	local function updateVisibility() --[[ updateVisibility | Line: 109 | Upvalues: Utility (copy), Dropdown (copy), p1 (copy) ]]
		Utility.setVisible(Dropdown, p1.isSelected, "InternalDropdown")
	end

	dropdownJanitor:add(p1.toggled:Connect(updateVisibility))
	Utility.setVisible(Dropdown, p1.isSelected, "InternalDropdown")

	local v1 = 0
	local v2 = false

	local function v3() --[[ updateMaxIcons | Line: 121 | Upvalues: v1 (ref), v2 (ref), v3 (copy), Dropdown (copy), DropdownScroller (copy), iconModule (copy), p1 (copy), DropdownPadding (copy) ]]
		v1 = v1 + 1

		if v2 then
			return
		end

		local v12 = v1

		v2 = true
		task.defer(function() --[[ Line: 129 | Upvalues: v2 (ref), v1 (ref), v12 (copy), v3 (ref) ]]
			v2 = false

			if v1 == v12 then
				return
			end

			v3()
		end)

		local v22 = Dropdown:GetAttribute("MaxIcons")

		if not v22 then
			return
		end

		local t = {}

		for k, v in pairs(DropdownScroller:GetChildren()) do
			if v:IsA("GuiObject") then
				table.insert(t, { v, v.AbsolutePosition.Y })
			end
		end

		table.sort(t, function(p1, p2) --[[ Line: 146 ]]
			return p1[2] < p2[2]
		end)

		local v32 = math.ceil(v22)
		local sum = 0
		local v4 = false

		for i = 1, v32 do
			local v5
			local v6 = t[i]

			if not v6 then
				break
			end

			local v7 = v6[1]
			local Y = v7.AbsoluteSize.Y
			local v8 = if i == v32 then if v32 == v22 then false else true else false

			if v8 then
				Y = Y * (v22 - v32 + 1)
			end

			sum = sum + Y

			if not v8 then
				local v9 = v7:GetAttribute("WidgetUID")
				local v10 = if v9 then iconModule.getIconByUID(v9) else v9

				if v10 then
					if v4 then
						v5 = nil
					else
						v5, v4 = p1:getInstance("ClickRegion"), true
					end

					v10:getInstance("ClickRegion").NextSelectionUp = v5
				end
			end
		end

		DropdownScroller.Size = UDim2.fromOffset(0, sum + DropdownPadding.PaddingTop.Offset + DropdownPadding.PaddingBottom.Offset)
	end

	dropdownJanitor:add(DropdownScroller:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(v3))
	dropdownJanitor:add(DropdownScroller.ChildAdded:Connect(v3))
	dropdownJanitor:add(DropdownScroller.ChildRemoved:Connect(v3))
	dropdownJanitor:add(Dropdown:GetAttributeChangedSignal("MaxIcons"):Connect(v3))
	dropdownJanitor:add(p1.childThemeModified:Connect(v3))
	v3()

	return Dropdown
end