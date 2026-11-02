-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Notice, time of decompilation: Sun May  3 10:09:32 2026 ]]
return function(p1, p2) -- line: 1
	local Frame = Instance.new("Frame")

	Frame.Name = "Notice"
	Frame.ZIndex = 25
	Frame.AutomaticSize = Enum.AutomaticSize.X
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.BackgroundTransparency = 0.1
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.Visible = false
	Frame.Parent = p1.widget

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame
	Instance.new("UIStroke").Parent = Frame

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = "NoticeLabel"
	TextLabel.ZIndex = 26
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.AutomaticSize = Enum.AutomaticSize.X
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Position = UDim2.new(0.5, 0, 0.515, 0)
	TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.FontSize = Enum.FontSize.Size14
	TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.Text = "1"
	TextLabel.TextWrapped = true
	TextLabel.TextWrap = true
	TextLabel.Font = Enum.Font.Arial
	TextLabel.Parent = Frame

	local ParentParent = script.Parent.Parent
	local Packages = ParentParent.Packages
	local Janitor = require(Packages.Janitor)
	local GoodSignal = require(Packages.GoodSignal)
	local Utility = require(ParentParent.Utility)

	p1.noticeChanged:Connect(function(p3) -- line: 43
		-- upvalues: TextLabel (copy), p2 (copy), p1 (copy), Utility (copy), Frame (copy)
		if not p3 then
			return
		end

		local v12 = p3 > 99

		TextLabel.Text = if not v12 then p3 else "99+"

		if v12 then
			TextLabel.TextSize = 11
		end

		local v13 = not (p3 < 1) or false
		local v14 = p2.getIconByUID(p1.parentIconUID)
		local v15 = #p1.dropdownIcons > 0 or #p1.menuIcons > 0

		if p1.isSelected and v15 then
			v13 = false
		elseif v14 and not v14.isSelected then
			v13 = false
		end

		Utility.setVisible(Frame, v13, "NoticeHandler")
	end)
	p1.noticeStarted:Connect(function(p4, p5) -- line: 71
		-- upvalues: p1 (copy), p2 (copy), Janitor (copy), GoodSignal (copy), Utility (copy)
		if not p4 then
			p4 = p1.deselected
		end

		local v18 = p2.getIconByUID(p1.parentIconUID)

		if v18 then
			v18:notify(p4)
		end

		local v19 = p1.janitor:add(Janitor.new())
		local v20 = v19:add(GoodSignal.new())

		v19:add(p1.endNotices:Connect(function() -- line: 83
			-- upvalues: v20 (copy)
			v20:Fire()
		end))
		v19:add(p4:Connect(function() -- line: 86
			-- upvalues: v20 (copy)
			v20:Fire()
		end))

		local u21 = p5 or Utility.generateUID()

		p1.notices[u21] = {
			completeSignal = v20,
			clearNoticeEvent = p4
		}
		p1.notified:Fire(u21)

		local v22 = p1

		v22.totalNotices = v22.totalNotices + 1
		p1.noticeChanged:Fire(p1.totalNotices)
		v20:Once(function() -- line: 100
			-- upvalues: v19 (copy), p1 (copy), u21 (ref)
			v19:destroy()

			local v23 = p1

			v23.totalNotices = v23.totalNotices - 1
			p1.notices[u21] = nil
			p1.noticeChanged:Fire(p1.totalNotices)
		end)
	end)
	Frame:SetAttribute("ClipToJoinedParent", true)
	p1:clipOutside(Frame)

	return Frame
end
