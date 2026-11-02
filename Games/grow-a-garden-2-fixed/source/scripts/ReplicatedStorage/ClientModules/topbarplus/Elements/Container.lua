--credit to leon games studio
local v1 = false
local v2 = 0

return function(p1) --[[ Line: 3 | Upvalues: v1 (ref), v2 (ref) ]]
	local GuiService = game:GetService("GuiService")
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local t = {}
	local v12 = require(script.Parent.Parent.Packages.GoodSignal).new()
	local v22 = GuiService:GetGuiInset()
	local v3 = 0
	local v4 = 0
	local v5 = 0
	local v6 = 0
	local v7 = false
	local v8 = false

	local function v9(p12) --[[ checkInset | Line: 20 | Upvalues: GuiService (copy), v7 (ref), v8 (ref), UserInputService (copy), p1 (copy), v6 (ref), v9 (copy), Players (copy), v1 (ref), v22 (ref), v3 (ref), v4 (ref), v5 (ref), v12 (copy), v2 (ref) ]]
		local Height = GuiService.TopbarInset.Height
		local v13 = if Height <= 36 then true else false

		v7 = GuiService:IsTenFootInterface()
		v8 = UserInputService.VREnabled
		p1.isOldTopbar = v13
		v6 = v6 + 1

		if Height == 0 and p12 == nil then
			task.defer(function() --[[ Line: 33 | Upvalues: v9 (ref) ]]
				task.wait(8)
				v9("ForceConvertToOld")
			end)
		elseif v6 == 1 then
			task.delay(5, function() --[[ Line: 38 | Upvalues: Players (ref), v6 (ref), v9 (ref) ]]
				Players.LocalPlayer:WaitForChild("PlayerGui")

				if v6 ~= 1 then
					return
				end

				v9()
			end)
		end

		if p1.isOldTopbar and (not v7 and (not v8 and (v1 == false and (Height ~= 0 or p12 == "ForceConvertToOld")))) then
			v1 = true
			task.defer(function() --[[ Line: 50 | Upvalues: p1 (ref), GuiService (ref) ]]
				local Classic = require(script.Parent.Parent.Features.Themes.Classic)

				p1.modifyBaseTheme(Classic)

				local function decideToHideTopbar() --[[ decideToHideTopbar | Line: 57 | Upvalues: GuiService (ref), p1 (ref) ]]
					if GuiService.MenuIsOpen then
						p1.setTopbarEnabled(false, true)
					else
						p1.setTopbarEnabled()
					end
				end

				GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(decideToHideTopbar)

				if GuiService.MenuIsOpen then
					p1.setTopbarEnabled(false, true)
				else
					p1.setTopbarEnabled()
				end
			end)
		end

		v22 = GuiService:GetGuiInset()
		v3 = if v13 then 12 else v22.Y - 50
		v4 = if v13 then 2 else 0
		v5 = -2

		if v7 then
			v3 = 10
			v4 = 0
		end

		if GuiService.TopbarInset.Height == 0 and not v1 then
			v4 = v4 + 13
			v5 = 50
		end

		v12:Fire(v22)

		local Y = v22.Y

		if Y == v2 then
			return
		end

		v2 = Y
		task.defer(function() --[[ Line: 88 | Upvalues: p1 (ref), Y (copy) ]]
			p1.insetHeightChanged:Fire(Y)
		end)
	end

	GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(v9)
	v9("FirstTime")

	local TopbarStandard = Instance.new("ScreenGui")

	v12:Connect(function() --[[ Line: 98 | Upvalues: TopbarStandard (copy), v3 (ref) ]]
		TopbarStandard:SetAttribute("StartInset", v3)
	end)
	TopbarStandard.Name = "TopbarStandard"
	TopbarStandard.Enabled = true
	TopbarStandard.DisplayOrder = p1.baseDisplayOrder
	TopbarStandard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	TopbarStandard.IgnoreGuiInset = true
	TopbarStandard.ResetOnSpawn = false
	TopbarStandard.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
	t[TopbarStandard.Name] = TopbarStandard
	p1.baseDisplayOrderChanged:Connect(function() --[[ Line: 109 | Upvalues: TopbarStandard (copy), p1 (copy) ]]
		TopbarStandard.DisplayOrder = p1.baseDisplayOrder
	end)

	local Holders = Instance.new("Frame")

	Holders.Name = "Holders"
	Holders.BackgroundTransparency = 1
	v12:Connect(function() --[[ Line: 116 | Upvalues: v8 (ref), v7 (ref), v5 (ref), Holders (copy), v4 (ref) ]]
		local v2 = if v7 then UDim2.new(1, 0, 0, if v8 then 36 else 56) else UDim2.new(1, 0, 1, v5)

		Holders.Position = UDim2.new(0, 0, 0, v4)
		Holders.Size = v2
	end)
	Holders.Visible = true
	Holders.ZIndex = 1
	Holders.Parent = TopbarStandard

	local TopbarCentered = TopbarStandard:Clone()
	local Holders2 = TopbarCentered.Holders

	local function updateCenteredHoldersHeight() --[[ updateCenteredHoldersHeight | Line: 128 | Upvalues: Holders2 (copy), GuiService (copy), v5 (ref) ]]
		Holders2.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + v5)
	end

	TopbarCentered.Name = "TopbarCentered"
	TopbarCentered.DisplayOrder = p1.baseDisplayOrder
	TopbarCentered.ScreenInsets = Enum.ScreenInsets.None
	p1.baseDisplayOrderChanged:Connect(function() --[[ Line: 134 | Upvalues: TopbarCentered (copy), p1 (copy) ]]
		TopbarCentered.DisplayOrder = p1.baseDisplayOrder
	end)
	t[TopbarCentered.Name] = TopbarCentered
	v12:Connect(updateCenteredHoldersHeight)
	Holders2.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + v5)

	local v10 = TopbarStandard:Clone()

	v10.Name = v10.Name .. "Clipped"
	v10.DisplayOrder = p1.baseDisplayOrder + 1
	p1.baseDisplayOrderChanged:Connect(function() --[[ Line: 145 | Upvalues: v10 (copy), p1 (copy) ]]
		v10.DisplayOrder = p1.baseDisplayOrder + 1
	end)
	t[v10.Name] = v10

	local v11 = TopbarCentered:Clone()

	v11.Name = v11.Name .. "Clipped"
	v11.DisplayOrder = p1.baseDisplayOrder + 1
	p1.baseDisplayOrderChanged:Connect(function() --[[ Line: 153 | Upvalues: v11 (copy), p1 (copy) ]]
		v11.DisplayOrder = p1.baseDisplayOrder + 1
	end)
	t[v11.Name] = v11

	local Left = Instance.new("ScrollingFrame")

	Left:SetAttribute("IsAHolder", true)
	Left.Name = "Left"
	v12:Connect(function() --[[ Line: 162 | Upvalues: Left (copy), v3 (ref) ]]
		Left.Position = UDim2.fromOffset(v3, 0)
	end)
	Left.Size = UDim2.new(1, -24, 1, 0)
	Left.BackgroundTransparency = 1
	Left.Visible = true
	Left.ZIndex = 1
	Left.Active = false
	Left.ClipsDescendants = true
	Left.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	Left.CanvasSize = UDim2.new(0, 0, 1, -1)
	Left.AutomaticCanvasSize = Enum.AutomaticSize.X
	Left.ScrollingDirection = Enum.ScrollingDirection.X
	Left.ScrollBarThickness = 0
	Left.BorderSizePixel = 0
	Left.Selectable = false
	Left.ScrollingEnabled = false
	Left.ElasticBehavior = Enum.ElasticBehavior.Never
	Left.Parent = Holders

	local UIListLayout = Instance.new("UIListLayout")

	v12:Connect(function() --[[ Line: 183 | Upvalues: UIListLayout (copy), v3 (ref) ]]
		UIListLayout.Padding = UDim.new(0, v3)
	end)
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout.Parent = Left

	local Center = Left:Clone()

	v12:Connect(function() --[[ Line: 193 | Upvalues: Center (copy), v3 (ref) ]]
		Center.UIListLayout.Padding = UDim.new(0, v3)
	end)
	Center.ScrollingEnabled = false
	Center.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Center.Name = "Center"
	Center.Parent = Holders2

	local Right = Left:Clone()

	v12:Connect(function() --[[ Line: 202 | Upvalues: Right (copy), v3 (ref) ]]
		Right.UIListLayout.Padding = UDim.new(0, v3)
	end)
	Right.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Right.Name = "Right"
	Right.AnchorPoint = Vector2.new(1, 0)
	Right.Position = UDim2.new(1, -12, 0, 0)
	Right.Parent = Holders
	v12:Fire(v22)

	return t
end