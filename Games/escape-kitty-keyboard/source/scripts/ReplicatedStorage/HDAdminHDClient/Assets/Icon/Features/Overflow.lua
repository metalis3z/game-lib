

local u1 = {}
local u2 = {}
local u3 = {}
local u4 = nil
local u5 = workspace.CurrentCamera
local u6 = {}
local u7 = {}
local u8 = require(script.Parent.Parent.Utility)
local u9 = false
local u10 = false
local u11 = nil
function u1.start(p12) 

	u11 = p12
	u4 = u11.iconsDictionary
	local v13 = nil
	for _, v14 in pairs(u11.container) do
		if v13 == nil then
			if v14.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
				v13 = v14
			end
		end
		for _, v15 in pairs(v14.Holders:GetChildren()) do
			if v15:GetAttribute("IsAHolder") then
				u2[v15.Name] = v15
			end
		end
	end
	local u16 = false
	local u18 = u8.createStagger(0.1, function(p17)

		if u16 then
			if not p17 then
				u1.updateAvailableIcons("Center")
			end
			u1.updateBoundary("Left")
			u1.updateBoundary("Right")
		end
	end)
	task.delay(0.5, function()

		u16 = true
		u18()
	end)
	task.delay(2, function()

		u9 = true
		u18()
	end)
	u11.iconAdded:Connect(u18)
	u11.iconRemoved:Connect(u18)
	u11.iconChanged:Connect(u18)
	u5:GetPropertyChangedSignal("ViewportSize"):Connect(function()

		u18(true)
	end)
	v13:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()

		u18(true)
	end)
end
function u1.getWidth(p19, _) 
	local v20 = p19.widget
	return v20:GetAttribute("TargetWidth") or v20.AbsoluteSize.X
end
function u1.getAvailableIcons(p21) 

	return u3[p21] or u1.updateAvailableIcons(p21)
end
function u1.updateAvailableIcons(p22) 

	local v23 = {}
	local v24 = 0
	for _, v25 in pairs(u4) do
		local v26 = v25.parentIconUID
		local v27 = not v26 or u7[v26]
		local v28 = u7[v25.UID]
		if v27 and (v25.alignment == p22 and (not v28 and v25.isEnabled)) then
			table.insert(v23, v25)
			v24 = v24 + 1
		end
	end
	if v24 <= 0 then
		return {}
	end
	table.sort(v23, function(p29, p30)
		local v31 = p29.widget.LayoutOrder
		local v32 = p30.widget.LayoutOrder
		local v33 = p29.parentIconUID
		local v34 = p30.parentIconUID
		if v33 == v34 then
			if v31 < v32 then
				return true
			elseif v32 < v31 then
				return false
			else
				return p29.widget.AbsolutePosition.X < p30.widget.AbsolutePosition.X
			end
		elseif v34 then
			return false
		else
			return v33 and true or nil
		end
	end)
	u3[p22] = v23
	return v23
end
function u1.getRealXPositions(p35, p36) 

	local v37 = p35 == "Left"
	local v38 = u2[p35]
	local v39 = v38.AbsolutePosition.X
	local v40 = v38.AbsoluteSize.X
	local v41 = v38.UIListLayout.Padding.Offset
	local v42 = v37 and v39 and v39 or v39 + v40
	local v43 = {}
	if v37 then
		u8.reverseTable(p36)
	end
	for v44 = #p36, 1, -1 do
		local v45 = p36[v44]
		local v46 = u1.getWidth(v45)
		if not v37 then
			v42 = v42 - v46
		end
		v43[v45.UID] = v42
		if v37 then
			v42 = v42 + v46
		end
		v42 = v42 + (v37 and v41 and v41 or -v41)
	end
	return v43
end
function u1.updateBoundary(u47) 

	local v48 = u2[u47]
	local v49 = v48.UIListLayout
	local v50 = v48.AbsolutePosition.X
	local v51 = v48.AbsoluteSize.X
	local u52 = v49.Padding.Offset
	local v53 = v49.Padding.Offset
	local u54 = u1.updateAvailableIcons(u47)
	local v55 = 0
	local v56 = 0
	for _, v57 in pairs(u54) do
		v55 = v55 + (u1.getWidth(v57) + v53)
		v56 = v56 + 1
	end
	if v56 > 0 then
		local v58 = u47 == "Center"
		local u59 = u47 == "Left"
		local u60 = not u59
		local v61 = u6[u47]
		if not v61 and (not v58 and #u54 > 0) then
			v61 = u11.new()
			v61:setImage(6069276526, "Deselected")
			v61:setName("Overflow" .. u47)
			v61:setOrder(u59 and -9999999 or 9999999)
			v61:setAlignment(u47)
			v61:autoDeselect(false)
			v61.isAnOverflow = true
			v61:select("OverflowStart", v61)
			v61:setEnabled(false)
			u6[u47] = v61
			u7[v61.UID] = true
			if not u11.closeableOverflowMenus then
				v61:getInstance("IconSpot").Visible = false
			end
		end
		local v62 = u47 == "Left" and "Right" or "Left"
		local v63 = u1.updateAvailableIcons(v62)
		local v64 = u59 and v63[1]
		if not v64 then
			if u60 then
				v64 = v63[#v63]
			else
				v64 = u60
			end
		end
		local v65 = u6[v62]
		local v66
		if u59 then
			v66 = v50 + v51 or v50
		else
			v66 = v50
		end
		if v64 then
			local v67 = u1.getRealXPositions(v62, v63)[v64.UID]
			local v68 = u1.getWidth(v64)
			v66 = u59 and v67 - u52 or v67 + v68 + u52
		end
		local u69 = 0
		local function u78() 

			local v70 = u1.getAvailableIcons("Center")
			local v71 = v70[u59 and 1 or #v70]
			if v71 and not v71.hasRelocatedInOverflow then
				local v72 = not (u59 and u54[#u54]) and u60
				if v72 then
					v72 = u54[1]
				end
				local v73 = v71.widget.AbsolutePosition.X
				local v74 = v72.widget.AbsolutePosition.X
				local v75 = u1.getWidth(v72)
				local v76 = u59 and v73 - u52 or v73 + u1.getWidth(v71) + u52
				if u59 then
					v74 = v74 + v75 or v74
				end
				local v77 = false
				if u59 then
					if v76 < v74 then
						if not u9 then
							if not u10 then
								u10 = true
								task.delay(3, u1.updateBoundary, u47)
							end
							return
						end
						v71:align("Left")
						v71.hasRelocatedInOverflow = true
						v77 = true
					end
				elseif u60 and v74 < v76 then
					if not u9 or v74 < 0 then
						if not u10 then
							u10 = true
							task.delay(3, u1.updateBoundary, u47)
						end
						return
					end
					v71:align("Right")
					v71.hasRelocatedInOverflow = true
					v77 = true
				end
				if v77 then
					u69 = u69 + 1
					if u69 <= 4 then
						u1.updateAvailableIcons("Center")
						u78()
					end
				end
			end
		end
		u78()
		if v61 then
			local v79 = v61:getInstance("Menu")
			local v80 = v50 + v51
			if v79 and v65 then
				local v81 = v65.widget.AbsolutePosition.X
				local v82 = u1.getWidth(v65)
				local v83 = u59 and v81 - u52 or v81 + v82 + u52
				local v84 = v65:getInstance("Menu")
				local v85 = v79.AbsoluteCanvasSize.X >= v84.AbsoluteCanvasSize.X
				local v86 = v50 + v51 / 2
				local v87 = u59 and v86 - u52 / 2 or v86 + u52 / 2
				if v85 then
					v87 = v83
				end
				v51 = u59 and v87 - v50 or v80 - v87
			end
			local v88
			if v79 then
				v88 = v79:GetAttribute("MaxWidth")
			else
				v88 = v79
			end
			local v89 = u8.round(v51)
			if v79 and v88 ~= v89 then
				v79:SetAttribute("MaxWidth", v89)
			end
		end
		local v90 = u1.getRealXPositions(u47, u54)
		local v91 = false
		for v92 = #u54, 1, -1 do
			local v93 = u54[v92]
			local v94 = u1.getWidth(v93)
			local v95 = v90[v93.UID]
			if u59 and v66 <= v95 + v94 or u60 and v95 <= v66 then
				v91 = true
			end
		end
		for v96 = #u54, 1, -1 do
			local v97 = u54[v96]
			if not u7[v97.UID] then
				if v91 and not v97.parentIconUID then
					v97:joinMenu(v61)
				elseif not v91 and v97.parentIconUID then
					v97:leave()
				end
			end
		end
		if v61.isEnabled ~= v91 then
			v61:setEnabled(v91)
		end
		if v61.isEnabled and not v61.overflowAlreadyOpened then
			v61.overflowAlreadyOpened = true
			v61:select()
		end
	end
end
return u1