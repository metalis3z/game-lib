-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Overflow, time of decompilation: Sun May  3 10:09:34 2026 ]]
local t1 = {}
local t2 = {}
local t3 = {}
local iconsDictionary = nil
local CurrentCamera = workspace.CurrentCamera
local t4 = {}
local t5 = {}
local Utility = require(script.Parent.Parent.Utility)
local u9 = false
local u10 = false
local u11 = nil

function t1.start(p1) -- line: 25
	-- upvalues: u11 (ref), iconsDictionary (ref), t2 (copy), Utility (copy), t1 (copy), u9 (ref), CurrentCamera (copy)
	u11 = p1
	iconsDictionary = u11.iconsDictionary

	local v13 = nil

	for _, v in pairs(u11.container) do
		if v13 == nil and v.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
			v13 = v
		end

		for _, v2 in pairs(v.Holders:GetChildren()) do
			if v2:GetAttribute("IsAHolder") then
				t2[v2.Name] = v2
			end
		end
	end

	local u18 = false
	local v19 = Utility.createStagger(0.1, function(p2) -- line: 43
		-- upvalues: u18 (ref), t1 (copy)
		if not u18 then
			return
		end

		if not p2 then
			t1.updateAvailableIcons("Center")
		end

		t1.updateBoundary("Left")
		t1.updateBoundary("Right")
	end)

	task.delay(0.5, function() -- line: 53
		-- upvalues: u18 (ref), v19 (copy)
		u18 = true
		v19()
	end)
	task.delay(2, function() -- line: 57
		-- upvalues: u9 (ref), v19 (copy)
		u9 = true
		v19()
	end)
	u11.iconAdded:Connect(v19)
	u11.iconRemoved:Connect(v19)
	u11.iconChanged:Connect(v19)
	CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- line: 67
		-- upvalues: v19 (copy)
		v19(true)
	end)
	v13:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 70
		-- upvalues: v19 (copy)
		v19(true)
	end)
end
function t1.getWidth(p3, _) -- line: 75
	local widget = p3.widget

	return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X
end
function t1.getAvailableIcons(p5) -- line: 80
	-- upvalues: t3 (copy), t1 (copy)
	return t3[p5] or t1.updateAvailableIcons(p5)
end
function t1.updateAvailableIcons(p6) -- line: 88
	-- upvalues: iconsDictionary (ref), t5 (copy), t3 (copy)
	local n1 = 0
	local t6 = {}

	for _, v in pairs(iconsDictionary) do
		local parentIconUID = v.parentIconUID
		local v30 = not parentIconUID or t5[parentIconUID]
		local v31 = t5[v.UID]

		if v30 and p6 == v.alignment and not v31 and v.isEnabled then
			table.insert(t6, v)
			n1 += 1
		end
	end

	if n1 <= 0 then
		return {}
	end

	table.sort(t6, function(p7, p8) -- line: 110
		local widgetLayoutOrder = p7.widget.LayoutOrder
		local widgetLayoutOrder2 = p8.widget.LayoutOrder
		local parentIconUID = p7.parentIconUID
		local parentIconUID2 = p8.parentIconUID

		if parentIconUID == parentIconUID2 then
			if widgetLayoutOrder < widgetLayoutOrder2 then
				return true
			end

			if widgetLayoutOrder2 < widgetLayoutOrder then
				return false
			end

			return p7.widget.AbsolutePosition.X < p8.widget.AbsolutePosition.X
		end

		if parentIconUID2 then
			return false
		end

		if parentIconUID then
			return true
		end

		return nil
	end)
	t3[p6] = t6

	return t6
end
function t1.getRealXPositions(p9, p10) -- line: 137
	-- upvalues: t2 (copy), Utility (copy), t1 (copy)
	local v34 = p9 == "Left"
	local v35 = t2[p9]
	local AbsolutePositionX = v35.AbsolutePosition.X
	local AbsoluteSizeX = v35.AbsoluteSize.X
	local PaddingOffset = v35.UIListLayout.Padding.Offset
	local v39 = v34 and AbsolutePositionX or AbsolutePositionX + AbsoluteSizeX
	local t7 = {}

	if v34 then
		Utility.reverseTable(p10)
	end

	for i = #p10, 1, -1 do
		local v42 = p10[i]
		local v43 = t1.getWidth(v42)

		if not v34 then
			v39 -= v43
		end

		t7[v42.UID] = v39

		if v34 then
			v39 += v43
		end

		v39 += v34 and PaddingOffset or -PaddingOffset
	end

	return t7
end
function t1.updateBoundary(p11) -- line: 166
	-- upvalues: t2 (copy), t1 (copy), t4 (copy), u11 (ref), t5 (copy), u10 (ref), u9 (ref), Utility (copy)
	local v45 = t2[p11]
	local UIListLayout = v45.UIListLayout
	local AbsolutePositionX = v45.AbsolutePosition.X
	local AbsoluteSizeX = v45.AbsoluteSize.X
	local PaddingOffset = UIListLayout.Padding.Offset
	local PaddingOffset2 = UIListLayout.Padding.Offset
	local v51 = t1.updateAvailableIcons(p11)
	local n2 = 0
	local n3 = 0
	local checkToShiftCentralIcon = nil

	for _, v in pairs(v51) do
		n2 += t1.getWidth(v) + PaddingOffset2
		n3 += 1
	end

	if n3 <= 0 then
		return
	end

	local v56 = p11 == "Center"
	local v57 = p11 == "Left"
	local v58 = not v57
	local v59 = t4[p11]

	if not v59 and not v56 and #v51 > 0 then
		local v60 = not v57 and 9999999 or -9999999

		v59 = u11.new()
		v59:setImage(6069276526, "Deselected")
		v59:setName("Overflow" .. p11)
		v59:setOrder(v60)
		v59:setAlignment(p11)
		v59:autoDeselect(false)
		v59.isAnOverflow = true
		v59:select("OverflowStart", v59)
		v59:setEnabled(false)
		t4[p11] = v59
		t5[v59.UID] = true

		if not u11.closeableOverflowMenus then
			v59:getInstance("IconSpot").Visible = false
		end
	end

	local v61 = p11 ~= "Left" and "Left" or "Right"
	local v62 = t1.updateAvailableIcons(v61)
	local v63 = v57 and v62[1] or v58 and v62[#v62]
	local v64 = t4[v61]
	local v65 = v57 and AbsolutePositionX + AbsoluteSizeX or AbsolutePositionX

	if v63 then
		local v66 = t1.getRealXPositions(v61, v62)[v63.UID]
		local v67 = t1.getWidth(v63)

		v65 = v57 and v66 - PaddingOffset or v66 + v67 + PaddingOffset
	end

	local n4 = 0

	function checkToShiftCentralIcon() -- line: 233
		-- upvalues: t1 (copy), v57 (copy), u10 (ref), p11 (copy), v51 (copy), v58 (copy), PaddingOffset (copy), u9 (ref), n4 (ref), checkToShiftCentralIcon (copy)
		local v96 = t1.getAvailableIcons("Center")
		local v97 = v96[if not v57 then #v96 else 1]

		if v97 and not v97.hasRelocatedInOverflow then
			local v98 = v57 and v51[#v51] or v58 and v51[1]
			local AbsolutePositionX2 = v97.widget.AbsolutePosition.X
			local AbsolutePositionX3 = v98.widget.AbsolutePosition.X
			local v101 = t1.getWidth(v98)
			local v102 = v57 and AbsolutePositionX2 - PaddingOffset or AbsolutePositionX2 + t1.getWidth(v97) + PaddingOffset
			local v103 = v57 and AbsolutePositionX3 + v101 or AbsolutePositionX3
			local v104 = false

			if v57 then
				if v102 < v103 then
					if not u9 then
						if not u10 then
							u10 = true
							task.delay(3, t1.updateBoundary, p11)
						end

						return
					end

					v97:align("Left")
					v97.hasRelocatedInOverflow = true
					v104 = true
				end
			elseif v58 and v103 < v102 then
				if not u9 or v103 < 0 then
					if not u10 then
						u10 = true
						task.delay(3, t1.updateBoundary, p11)
					end

					return
				end

				v97:align("Right")
				v97.hasRelocatedInOverflow = true
				v104 = true
			end

			if v104 then
				n4 += 1

				if n4 <= 4 then
					t1.updateAvailableIcons("Center")
					checkToShiftCentralIcon()
				end
			end
		end
	end

	checkToShiftCentralIcon()

	if v59 then
		local v70 = v59:getInstance("Menu")
		local v71 = AbsolutePositionX + AbsoluteSizeX

		if v70 and v64 then
			local AbsolutePositionX4 = v64.widget.AbsolutePosition.X
			local v73 = t1.getWidth(v64)
			local v74 = v57 and AbsolutePositionX4 - PaddingOffset or AbsolutePositionX4 + v73 + PaddingOffset
			local v75 = v64:getInstance("Menu")
			local v76 = v70.AbsoluteCanvasSize.X >= v75.AbsoluteCanvasSize.X
			local v77 = AbsolutePositionX + AbsoluteSizeX / 2
			local v78 = v57 and v77 - PaddingOffset / 2 or v77 + PaddingOffset / 2

			if v76 then
				v78 = v74
			end

			AbsoluteSizeX = v57 and v78 - AbsolutePositionX or v71 - v78
		end

		local v79 = v70 and v70:GetAttribute("MaxWidth")
		local v80 = Utility.round(AbsoluteSizeX)

		if v70 and v79 ~= v80 then
			v70:SetAttribute("MaxWidth", v80)
		end
	end

	local v81 = false
	local v82 = t1.getRealXPositions(p11, v51)

	for i = #v51, 1, -1 do
		local v84 = v51[i]
		local v85 = t1.getWidth(v84)
		local v86 = v82[v84.UID]

		if v57 and v65 <= v86 + v85 or v58 and v86 <= v65 then
			v81 = true
		end
	end

	for i = #v51, 1, -1 do
		local v88 = v51[i]

		if not t5[v88.UID] then
			if v81 and not v88.parentIconUID then
				v88:joinMenu(v59)
			elseif not v81 and v88.parentIconUID then
				v88:leave()
			end
		end
	end

	if v81 ~= v59.isEnabled then
		v59:setEnabled(v81)
	end

	if v59.isEnabled and not v59.overflowAlreadyOpened then
		v59.overflowAlreadyOpened = true
		v59:select()
	end
end

return t1
