

return function(u1, u2)
	local u3 = Instance.new("Frame")
	u3.Name = "Notice"
	u3.ZIndex = 25
	u3.AutomaticSize = Enum.AutomaticSize.X
	u3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	u3.BorderSizePixel = 0
	u3.BackgroundTransparency = 0.1
	u3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	u3.Visible = false
	u3.Parent = u1.widget
	local v4 = Instance.new("UICorner")
	v4.CornerRadius = UDim.new(1, 0)
	v4.Parent = u3
	Instance.new("UIStroke").Parent = u3
	local u5 = Instance.new("TextLabel")
	u5.Name = "NoticeLabel"
	u5.ZIndex = 26
	u5.AnchorPoint = Vector2.new(0.5, 0.5)
	u5.AutomaticSize = Enum.AutomaticSize.X
	u5.Size = UDim2.new(1, 0, 1, 0)
	u5.BackgroundTransparency = 1
	u5.Position = UDim2.new(0.5, 0, 0.515, 0)
	u5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	u5.FontSize = Enum.FontSize.Size14
	u5.TextColor3 = Color3.fromRGB(0, 0, 0)
	u5.Text = "1"
	u5.TextWrapped = true
	u5.TextWrap = true
	u5.Font = Enum.Font.Arial
	u5.Parent = u3
	local v6 = script.Parent.Parent
	local v7 = v6.Packages
	local u8 = require(v7.Janitor)
	local u9 = require(v7.GoodSignal)
	local u10 = require(v6.Utility)
	u1.noticeChanged:Connect(function(p11)

		if p11 then
			local v12 = p11 > 99
			u5.Text = v12 and "99+" or p11
			if v12 then
				u5.TextSize = 11
			end
			local v13 = p11 >= 1
			local v14 = u2.getIconByUID(u1.parentIconUID)
			local v15 = #u1.dropdownIcons > 0 and true or #u1.menuIcons > 0
			if u1.isSelected and v15 then
				v13 = false
			elseif v14 and not v14.isSelected then
				v13 = false
			end
			u10.setVisible(u3, v13, "NoticeHandler")
		end
	end)
	u1.noticeStarted:Connect(function(p16, p17)

		local v18 = p16 or u1.deselected
		local v19 = u2.getIconByUID(u1.parentIconUID)
		if v19 then
			v19:notify(v18)
		end
		local u20 = u1.janitor:add(u8.new())
		local u21 = u20:add(u9.new())
		u20:add(u1.endNotices:Connect(function()

			u21:Fire()
		end))
		u20:add(v18:Connect(function()

			u21:Fire()
		end))
		local u22 = p17 or u10.generateUID()
		u1.notices[u22] = {
			["completeSignal"] = u21,
			["clearNoticeEvent"] = v18
		}
		u1.notified:Fire(u22)
		local v23 = u1
		v23.totalNotices = v23.totalNotices + 1
		u1.noticeChanged:Fire(u1.totalNotices)
		u21:Once(function()

			u20:destroy()
			local v24 = u1
			v24.totalNotices = v24.totalNotices - 1
			u1.notices[u22] = nil
			u1.noticeChanged:Fire(u1.totalNotices)
		end)
	end)
	u3:SetAttribute("ClipToJoinedParent", true)
	u1:clipOutside(u3)
	return u3
end