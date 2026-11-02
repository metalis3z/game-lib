-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Container, time of decompilation: Sun May  3 10:09:30 2026 ]]
local u1 = false
local n1 = 0

return function(p1) -- line: 3
	-- upvalues: u1 (ref), n1 (ref)
	local GuiService = game:GetService("GuiService")
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local t1 = {}
	local v8 = require(script.Parent.Parent.Packages.GoodSignal).new()
	local GuiInset = GuiService:GetGuiInset()
	local n2 = 0
	local n3 = 0
	local n4 = 0
	local n5 = 0
	local u14 = false
	local u15 = false

	local function checkInset(p2) -- line: 20
		-- upvalues: GuiService (copy), u14 (ref), u15 (ref), UserInputService (copy), p1 (copy), n5 (ref), checkInset (copy), Players (copy), u1 (ref), GuiInset (ref), n2 (ref), n3 (ref), n4 (ref), v8 (copy), n1 (ref)
		local TopbarInsetHeight = GuiService.TopbarInset.Height
		local v29 = TopbarInsetHeight <= 36

		u14 = GuiService:IsTenFootInterface()
		u15 = UserInputService.VREnabled
		p1.isOldTopbar = v29
		n5 += 1

		if TopbarInsetHeight == 0 and p2 == nil then
			task.defer(function() -- line: 33
				-- upvalues: checkInset (copy)
				task.wait(8)
				checkInset("ForceConvertToOld")
			end)
		elseif n5 == 1 then
			task.delay(5, function() -- line: 38
				-- upvalues: Players (copy), n5 (ref), checkInset (copy)
				Players.LocalPlayer:WaitForChild("PlayerGui")

				if n5 == 1 then
					checkInset()
				end
			end)
		end

		if p1.isOldTopbar and not u14 and not u15 and u1 == false and (TopbarInsetHeight ~= 0 or p2 == "ForceConvertToOld") then
			u1 = true
			task.defer(function() -- line: 50
				-- upvalues: p1 (copy), GuiService (copy)
				local Themes = script.Parent.Parent.Features.Themes
				local Classic = require(Themes.Classic)

				p1.modifyBaseTheme(Classic)
				GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() --[[ decideToHideTopbar ]] -- line: 57
					-- upvalues: GuiService (copy), p1 (copy)
					if GuiService.MenuIsOpen then
						p1.setTopbarEnabled(false, true)

						return
					end

					p1.setTopbarEnabled()
				end)

				if GuiService.MenuIsOpen then
					p1.setTopbarEnabled(false, true)

					return
				end

				p1.setTopbarEnabled()
			end)
		end

		GuiInset = GuiService:GetGuiInset()
		n2 = if not v29 then GuiInset.Y - 50 else 12
		n3 = not v29 and 0 or 2
		n4 = -2

		if u14 then
			n2 = 10
			n3 = 0
		end

		if GuiService.TopbarInset.Height == 0 and not u1 then
			n3 += 13
			n4 = 50
		end

		v8:Fire(GuiInset)

		local GuiInsetY = GuiInset.Y

		if GuiInsetY ~= n1 then
			n1 = GuiInsetY
			task.defer(function() -- line: 88
				-- upvalues: p1 (copy), GuiInsetY (copy)
				p1.insetHeightChanged:Fire(GuiInsetY)
			end)
		end
	end

	GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(checkInset)
	checkInset("FirstTime")

	local ScreenGui = Instance.new("ScreenGui")

	v8:Connect(function() -- line: 98
		-- upvalues: ScreenGui (copy), n2 (ref)
		ScreenGui:SetAttribute("StartInset", n2)
	end)
	ScreenGui.Name = "TopbarStandard"
	ScreenGui.Enabled = true
	ScreenGui.DisplayOrder = p1.baseDisplayOrder
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
	t1[ScreenGui.Name] = ScreenGui
	p1.baseDisplayOrderChanged:Connect(function() -- line: 109
		-- upvalues: ScreenGui (copy), p1 (copy)
		ScreenGui.DisplayOrder = p1.baseDisplayOrder
	end)

	local Frame = Instance.new("Frame")

	Frame.Name = "Holders"
	Frame.BackgroundTransparency = 1
	v8:Connect(function() -- line: 116
		-- upvalues: u15 (ref), u14 (ref), n4 (ref), Frame (copy), n3 (ref)
		local v31 = not u15 and 56 or 36
		local v32 = if not u14 then UDim2.new(1, 0, 1, n4) else UDim2.new(1, 0, 0, v31)

		Frame.Position = UDim2.new(0, 0, 0, n3)
		Frame.Size = v32
	end)
	Frame.Visible = true
	Frame.ZIndex = 1
	Frame.Parent = ScreenGui

	local clone = ScreenGui:Clone()
	local Holders = clone.Holders

	clone.Name = "TopbarCentered"
	clone.DisplayOrder = p1.baseDisplayOrder
	clone.ScreenInsets = Enum.ScreenInsets.None
	p1.baseDisplayOrderChanged:Connect(function() -- line: 134
		-- upvalues: clone (copy), p1 (copy)
		clone.DisplayOrder = p1.baseDisplayOrder
	end)
	t1[clone.Name] = clone
	v8:Connect(function() --[[ updateCenteredHoldersHeight ]] -- line: 128
		-- upvalues: Holders (copy), GuiService (copy), n4 (ref)
		Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + n4)
	end)
	Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + n4)

	local clone2 = ScreenGui:Clone()

	clone2.Name = clone2.Name .. "Clipped"
	clone2.DisplayOrder = p1.baseDisplayOrder + 1
	p1.baseDisplayOrderChanged:Connect(function() -- line: 145
		-- upvalues: clone2 (copy), p1 (copy)
		clone2.DisplayOrder = p1.baseDisplayOrder + 1
	end)
	t1[clone2.Name] = clone2

	local clone3 = clone:Clone()

	clone3.Name = clone3.Name .. "Clipped"
	clone3.DisplayOrder = p1.baseDisplayOrder + 1
	p1.baseDisplayOrderChanged:Connect(function() -- line: 153
		-- upvalues: clone3 (copy), p1 (copy)
		clone3.DisplayOrder = p1.baseDisplayOrder + 1
	end)
	t1[clone3.Name] = clone3

	local ScrollingFrame = Instance.new("ScrollingFrame")

	ScrollingFrame:SetAttribute("IsAHolder", true)
	ScrollingFrame.Name = "Left"
	v8:Connect(function() -- line: 162
		-- upvalues: ScrollingFrame (copy), n2 (ref)
		ScrollingFrame.Position = UDim2.fromOffset(n2, 0)
	end)
	ScrollingFrame.Size = UDim2.new(1, -24, 1, 0)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.Visible = true
	ScrollingFrame.ZIndex = 1
	ScrollingFrame.Active = false
	ScrollingFrame.ClipsDescendants = true
	ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
	ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
	ScrollingFrame.ScrollBarThickness = 0
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Selectable = false
	ScrollingFrame.ScrollingEnabled = false
	ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never
	ScrollingFrame.Parent = Frame

	local UIListLayout = Instance.new("UIListLayout")

	v8:Connect(function() -- line: 183
		-- upvalues: UIListLayout (copy), n2 (ref)
		UIListLayout.Padding = UDim.new(0, n2)
	end)
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout.Parent = ScrollingFrame

	local clone4 = ScrollingFrame:Clone()

	v8:Connect(function() -- line: 193
		-- upvalues: clone4 (copy), n2 (ref)
		clone4.UIListLayout.Padding = UDim.new(0, n2)
	end)
	clone4.ScrollingEnabled = false
	clone4.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	clone4.Name = "Center"
	clone4.Parent = Holders

	local clone5 = ScrollingFrame:Clone()

	v8:Connect(function() -- line: 202
		-- upvalues: clone5 (copy), n2 (ref)
		clone5.UIListLayout.Padding = UDim.new(0, n2)
	end)
	clone5.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	clone5.Name = "Right"
	clone5.AnchorPoint = Vector2.new(1, 0)
	clone5.Position = UDim2.new(1, -12, 0, 0)
	clone5.Parent = Frame
	v8:Fire(GuiInset)

	return t1
end
