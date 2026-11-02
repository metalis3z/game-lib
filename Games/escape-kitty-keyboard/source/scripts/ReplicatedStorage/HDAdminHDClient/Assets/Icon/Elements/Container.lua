

local u1 = false
local u2 = 0
return function(u3)

	local u4 = game:GetService("GuiService")
	local u5 = game:GetService("Players")
	local u6 = game:GetService("UserInputService")
	local v7 = {}
	local u8 = require(script.Parent.Parent.Packages.GoodSignal).new()
	local u9 = u4:GetGuiInset()
	local u10 = 0
	local u11 = 0
	local u12 = 0
	local u13 = 0
	local u14 = false
	local u15 = false
	local function u23(p16) 

		local v17 = u4.TopbarInset.Height
		local v18 = v17 <= 36
		u14 = u4:IsTenFootInterface()
		u15 = u6.VREnabled
		u3.isOldTopbar = v18
		u13 = u13 + 1
		if v17 == 0 and p16 == nil then
			task.defer(function()

				task.wait(8)
				u23("ForceConvertToOld")
			end)
		elseif u13 == 1 then
			task.delay(5, function()

				u5.LocalPlayer:WaitForChild("PlayerGui")
				if u13 == 1 then
					u23()
				end
			end)
		end
		if u3.isOldTopbar and (not u14 and (not u15 and (u1 == false and (v17 ~= 0 or p16 == "ForceConvertToOld")))) then
			u1 = true
			task.defer(function()

				local v19 = script.Parent.Parent.Features.Themes
				local v20 = require(v19.Classic)
				u3.modifyBaseTheme(v20)
				local function v21() 

					if u4.MenuIsOpen then
						u3.setTopbarEnabled(false, true)
					else
						u3.setTopbarEnabled()
					end
				end
				u4:GetPropertyChangedSignal("MenuIsOpen"):Connect(v21)
				if u4.MenuIsOpen then
					u3.setTopbarEnabled(false, true)
				else
					u3.setTopbarEnabled()
				end
			end)
		end
		u9 = u4:GetGuiInset()
		u10 = v18 and 12 or u9.Y - 50
		u11 = v18 and 2 or 0
		u12 = -2
		if u14 then
			u10 = 10
			u11 = 0
		end
		if u4.TopbarInset.Height == 0 and not u1 then
			u11 = u11 + 13
			u12 = 50
		end
		u8:Fire(u9)
		local u22 = u9.Y
		if u22 ~= u2 then
			u2 = u22
			task.defer(function()

				u3.insetHeightChanged:Fire(u22)
			end)
		end
	end
	u4:GetPropertyChangedSignal("TopbarInset"):Connect(u23)
	u23("FirstTime")
	local u24 = Instance.new("ScreenGui")
	u8:Connect(function()

		u24:SetAttribute("StartInset", u10)
	end)
	u24.Name = "TopbarStandard"
	u24.Enabled = true
	u24.DisplayOrder = u3.baseDisplayOrder
	u24.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	u24.IgnoreGuiInset = true
	u24.ResetOnSpawn = false
	u24.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
	v7[u24.Name] = u24
	u3.baseDisplayOrderChanged:Connect(function()

		u24.DisplayOrder = u3.baseDisplayOrder
	end)
	local u25 = Instance.new("Frame")
	u25.Name = "Holders"
	u25.BackgroundTransparency = 1
	u8:Connect(function()

		local v26 = u15 and 36 or 56
		local v27
		if u14 then
			v27 = UDim2.new(1, 0, 0, v26)
		else
			v27 = UDim2.new(1, 0, 1, u12)
		end
		u25.Position = UDim2.new(0, 0, 0, u11)
		u25.Size = v27
	end)
	u25.Visible = true
	u25.ZIndex = 1
	u25.Parent = u24
	local u28 = u24:Clone()
	local u29 = u28.Holders
	local function v30() 

		u29.Size = UDim2.new(1, 0, 0, u4.TopbarInset.Height + u12)
	end
	u28.Name = "TopbarCentered"
	u28.DisplayOrder = u3.baseDisplayOrder
	u28.ScreenInsets = Enum.ScreenInsets.None
	u3.baseDisplayOrderChanged:Connect(function()

		u28.DisplayOrder = u3.baseDisplayOrder
	end)
	v7[u28.Name] = u28
	u8:Connect(v30)
	u29.Size = UDim2.new(1, 0, 0, u4.TopbarInset.Height + u12)
	local u31 = u24:Clone()
	u31.Name = u31.Name .. "Clipped"
	u31.DisplayOrder = u3.baseDisplayOrder + 1
	u3.baseDisplayOrderChanged:Connect(function()

		u31.DisplayOrder = u3.baseDisplayOrder + 1
	end)
	v7[u31.Name] = u31
	local u32 = u28:Clone()
	u32.Name = u32.Name .. "Clipped"
	u32.DisplayOrder = u3.baseDisplayOrder + 1
	u3.baseDisplayOrderChanged:Connect(function()

		u32.DisplayOrder = u3.baseDisplayOrder + 1
	end)
	v7[u32.Name] = u32
	local u33 = Instance.new("ScrollingFrame")
	u33:SetAttribute("IsAHolder", true)
	u33.Name = "Left"
	u8:Connect(function()

		u33.Position = UDim2.fromOffset(u10, 0)
	end)
	u33.Size = UDim2.new(1, -24, 1, 0)
	u33.BackgroundTransparency = 1
	u33.Visible = true
	u33.ZIndex = 1
	u33.Active = false
	u33.ClipsDescendants = true
	u33.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	u33.CanvasSize = UDim2.new(0, 0, 1, -1)
	u33.AutomaticCanvasSize = Enum.AutomaticSize.X
	u33.ScrollingDirection = Enum.ScrollingDirection.X
	u33.ScrollBarThickness = 0
	u33.BorderSizePixel = 0
	u33.Selectable = false
	u33.ScrollingEnabled = false
	u33.ElasticBehavior = Enum.ElasticBehavior.Never
	u33.Parent = u25
	local u34 = Instance.new("UIListLayout")
	u8:Connect(function()

		u34.Padding = UDim.new(0, u10)
	end)
	u34.FillDirection = Enum.FillDirection.Horizontal
	u34.SortOrder = Enum.SortOrder.LayoutOrder
	u34.VerticalAlignment = Enum.VerticalAlignment.Bottom
	u34.HorizontalAlignment = Enum.HorizontalAlignment.Left
	u34.Parent = u33
	local u35 = u33:Clone()
	u8:Connect(function()

		u35.UIListLayout.Padding = UDim.new(0, u10)
	end)
	u35.ScrollingEnabled = false
	u35.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	u35.Name = "Center"
	u35.Parent = u29
	local u36 = u33:Clone()
	u8:Connect(function()

		u36.UIListLayout.Padding = UDim.new(0, u10)
	end)
	u36.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	u36.Name = "Right"
	u36.AnchorPoint = Vector2.new(1, 0)
	u36.Position = UDim2.new(1, -12, 0, 0)
	u36.Parent = u25
	u8:Fire(u9)
	return v7
end