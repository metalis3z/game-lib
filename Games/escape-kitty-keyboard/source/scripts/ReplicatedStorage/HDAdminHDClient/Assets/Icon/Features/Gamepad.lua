

local u1 = game:GetService("GamepadService")
local u2 = game:GetService("UserInputService")
local u3 = game:GetService("GuiService")
local u4 = Enum.KeyCode.DPadUp
local u5 = Enum.PreferredInput.Gamepad
local u6 = {}
local u7 = nil
function u6.start(p8) 

	u7 = p8
	local v9 = u7
	local v10
	if u7.highlightKey == nil then
		v10 = u4
	else
		v10 = u7.highlightKey
	end
	v9.highlightKey = v10
	u7.highlightIcon = false
	task.delay(1, function()

		local u11 = u7.iconsDictionary
		local u12 = nil
		local u13 = u4 ~= u7.highlightKey
		local u14 = u4 ~= u7.highlightKey
		local u15 = require(script.Parent.Parent.Elements.Selection)
		local function u22() 

			local v16 = u3.SelectedObject
			if v16 then
				v16 = v16:GetAttribute("CorrespondingIconUID")
			end
			if v16 then
				v16 = u11[v16]
			end
			local v17 = u2.PreferredInput == u5
			if v16 then
				if v17 then
					local v18 = v16:getInstance("ClickRegion")
					local v19 = v16.selection
					if not v19 then
						v19 = v16.janitor:add(u15(u7))
						v19:SetAttribute("IgnoreVisibilityUpdater", true)
						v19.Parent = v16.widget
						v16.selection = v19
						v16:refreshAppearance(v19)
					end
					v18.SelectionImageObject = v19.Selection
				end
				if u12 and u12 ~= v16 then
					u12:setIndicator()
				end
				local v20
				if v17 and not (u14 or v16.parentIconUID) then
					v20 = Enum.KeyCode.ButtonB
				else
					v20 = nil
				end
				u12 = v16
				u7.lastHighlightedIcon = v16
				v16:setIndicator(v20)
			else
				local v21
				if v17 and not u13 then
					v21 = u7.highlightKey
				else
					v21 = nil
				end
				if not u12 then
					u12 = u6.getIconToHighlight()
				end
				if v21 == u7.highlightKey then
					u13 = true
				end
				if u12 then
					u12:setIndicator(v21)
				end
			end
		end
		u3:GetPropertyChangedSignal("SelectedObject"):Connect(u22)
		local function v23() 

			if u2.PreferredInput ~= u5 then
				u13 = false
				u14 = false
			end
			u22()
		end
		u2:GetPropertyChangedSignal("PreferredInput"):Connect(v23)
		if u2.PreferredInput ~= u5 then
			local _ = false
			u14 = false
		end
		u22()
		u2.InputBegan:Connect(function(p24, _)

			if p24.UserInputType == Enum.UserInputType.MouseButton1 then
				local v25 = u3.SelectedObject
				if v25 then
					v25 = v25:GetAttribute("CorrespondingIconUID")
				end
				if v25 then
					v25 = u11[v25]
				end
				if v25 then
					u3.SelectedObject = nil
				end
				return
			elseif p24.KeyCode == u7.highlightKey then
				local v26 = u6.getIconToHighlight()
				if v26 then
					if u1.GamepadCursorEnabled then
						task.wait(0.2)
						u1:DisableGamepadCursor()
					end
					u3.SelectedObject = v26:getInstance("ClickRegion")
				end
			end
		end)
	end)
end
function u6.getIconToHighlight() 

	local v27 = u7.iconsDictionary
	local v28 = u7.highlightIcon or u7.lastHighlightedIcon
	if not v28 then
		local v29 = nil
		for _, v30 in pairs(v27) do
			if not v30.parentIconUID and (not v29 or v30.widget.AbsolutePosition.X < v29) then
				v29 = v30.widget.AbsolutePosition.X
				v28 = v30
			end
		end
	end
	return v28
end
function u6.registerButton(u31) 

	local u32 = false
	u31.InputBegan:Connect(function(_)

		u32 = true
		task.wait()
		task.wait()
		u32 = false
	end)
	local u36 = u2.InputBegan:Connect(function(p33)

		task.wait()
		if p33.KeyCode == Enum.KeyCode.ButtonA and u32 then
			task.wait(0.2)
			u1:DisableGamepadCursor()
			u3.SelectedObject = u31
		else
			local v34 = u3.SelectedObject == u31
			local v35 = p33.KeyCode.Name
			if table.find({ "ButtonB", "ButtonSelect" }, v35) and (v34 and (v35 ~= "ButtonSelect" or u1.GamepadCursorEnabled)) then
				u3.SelectedObject = nil
			end
		end
	end)
	u31.Destroying:Once(function()

		u36:Disconnect()
	end)
end
return u6