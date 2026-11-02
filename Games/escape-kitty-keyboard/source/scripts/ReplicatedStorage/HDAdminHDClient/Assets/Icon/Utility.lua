

local u1 = {}
local u2 = game:GetService("Players").LocalPlayer
function u1.createStagger(p3, u4, u5) 
	local u6 = false
	local u7 = false
	local u8 = (not p3 or p3 == 0) and 0.01 or p3
	local function u12(...) 

		if u6 then
			u7 = true
		else
			local u9 = table.pack(...)
			u6 = true
			u7 = false
			task.spawn(function()

				if u5 then
					task.wait(u8)
				end
				local v10 = u9
				u4(table.unpack(v10))
			end)
			task.delay(u8, function()

				u6 = false
				if u7 then
					local v11 = u9
					u12(table.unpack(v11))
				end
			end)
		end
	end
	return u12
end
function u1.round(p13) 
	local v14 = p13 + 0.5
	return math.floor(v14)
end
function u1.reverseTable(p15) 
	local v16 = #p15 / 2
	for v17 = 1, math.floor(v16) do
		local v18 = #p15 - v17 + 1
		local v19 = p15[v18]
		local v20 = p15[v17]
		p15[v17] = v19
		p15[v18] = v20
	end
end
function u1.copyTable(p21) 

	local v22 = type(p21) == "table"
	assert(v22, "First argument must be a table")
	local v23 = table.create(#p21)
	for v24, v25 in pairs(p21) do
		if type(v25) == "table" then
			v23[v24] = u1.copyTable(v25)
		else
			v23[v24] = v25
		end
	end
	return v23
end
local u26 = {
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"0",
	"<",
	">",
	"?",
	"@",
	"{",
	"}",
	"[",
	"]",
	"!",
	"(",
	")",
	"=",
	"+",
	"~",
	"#"
}
function u1.generateUID(p27) 

	local v28 = u26
	local v29 = #v28
	local v30 = ""
	for _ = 1, p27 or 8 do
		v30 = v30 .. v28[math.random(1, v29)]
	end
	return v30
end
local u31 = {}
function u1.setVisible(u32, p33, p34) 

	local v35 = u31[u32]
	if not v35 then
		v35 = {}
		u31[u32] = v35
		u32.Destroying:Once(function()

			u31[u32] = nil
		end)
	end
	if p33 then
		v35[p34] = nil
	else
		v35[p34] = true
	end
	if p33 then
		for _, _ in pairs(v35) do
			p33 = false
			break
		end
	end
	u32.Visible = p33
end
function u1.formatStateName(p36) 
	return string.upper((string.sub(p36, 1, 1))) .. string.lower((string.sub(p36, 2)))
end
function u1.localPlayerRespawned(p37) 

	u2.CharacterRemoving:Connect(p37)
end
function u1.getClippedContainer(p38) 
	local v39 = p38:FindFirstChild("ClippedContainer")
	if not v39 then
		v39 = Instance.new("Folder")
		v39.Name = "ClippedContainer"
		v39.Parent = p38
	end
	return v39
end
local u40 = require(script.Parent.Packages.Janitor)
local u41 = game:GetService("GuiService")
function u1.clipOutside(u42, u43) 

	local u44 = u42.janitor:add(u40.new())
	u43.Destroying:Once(function()

		u44:Destroy()
	end)
	u42.janitor:add(u43)
	local u45 = u43.Parent
	local u46 = u44:add(Instance.new("Frame"))
	u46:SetAttribute("IsAClippedClone", true)
	u46.Name = u43.Name
	u46.AnchorPoint = u43.AnchorPoint
	u46.Size = u43.Size
	u46.Position = u43.Position
	u46.BackgroundTransparency = 1
	u46.LayoutOrder = u43.LayoutOrder
	u46.Parent = u45
	local v47 = Instance.new("ObjectValue")
	v47.Name = "OriginalInstance"
	v47.Value = u43
	v47.Parent = u46
	local v48 = v47:Clone()
	u43:SetAttribute("HasAClippedClone", true)
	v48.Name = "ClippedClone"
	v48.Value = u46
	v48.Parent = u43
	local u49 = nil
	local u50 = require(u42.iconModule)
	local u51 = u50.container
	local function v53() 

		local v52 = u45:FindFirstAncestorWhichIsA("ScreenGui")
		if not string.match(v52.Name, "Clipped") then
			v52 = u51[v52.Name .. "Clipped"]
		end
		u49 = v52
		u43.AnchorPoint = Vector2.new(0, 0)
		u43.Parent = u1.getClippedContainer(u49)
	end
	u44:add(u42.alignmentChanged:Connect(v53))
	v53()
	local u54 = u49
	for _, v55 in pairs(u43:GetChildren()) do
		if v55:IsA("UIAspectRatioConstraint") then
			v55:Clone().Parent = u46
		end
	end
	local u56 = u42.widget
	local u57 = false
	local u58 = u43:GetAttribute("IgnoreVisibilityUpdater")
	local function v60() 

		if not u58 then
			local v59 = u56.Visible
			if u57 then
				v59 = false
			end
			u1.setVisible(u43, v59, "ClipHandler")
		end
	end
	u44:add(u56:GetPropertyChangedSignal("Visible"):Connect(v60))
	local u61 = nil
	local function u75() 

		task.defer(function()

			local v62 = nil
			local v63 = u42.UID
			local v64
			if u43:GetAttribute("ClipToJoinedParent") then
				v64 = v63
				for _ = 1, 10 do
					local v65 = u50.getIconByUID(v63)
					if not v65 then
						break
					end
					local v66 = v65.joinedFrame
					v63 = v65.parentIconUID
					if not v66 then
						break
					end
					if v66 and v66.Name == "DropdownScroller" then
						v62 = v66
						break
					end
					v62 = v66
				end
			else
				v64 = v63
			end
			if v62 then
				local v67 = u43.AbsolutePosition
				local v68 = u43.AbsoluteSize / 2
				local v69 = v62.AbsolutePosition
				local v70 = v62.AbsoluteSize
				local v71 = v67 + v68
				local v72 = v71.X < v69.X or (v71.X > v69.X + v70.X or (v71.Y < v69.Y or v71.Y > v69.Y + v70.Y))
				if v72 ~= u57 then
					u57 = v72
					if not u58 then
						local v73 = u56.Visible
						if u57 then
							v73 = false
						end
						u1.setVisible(u43, v73, "ClipHandler")
					end
				end
				if v62:IsA("ScrollingFrame") and u61 ~= v62 then
					u61 = v62
					u44:add(v62:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()

						u75()
					end), "Disconnect", "TrackUtilityScroller-" .. v64)
				end
				return
			else
				u57 = false
				if not u58 then
					local v74 = u56.Visible
					if u57 then
						v74 = false
					end
					u1.setVisible(u43, v74, "ClipHandler")
				end
			end
		end)
	end
	local u76 = workspace.CurrentCamera
	local u77 = u43:GetAttribute("AdditionalOffsetX") or 0
	local function v106(u78) 

		local u79 = "Absolute" .. u78
		local function v103() 

			local v80 = u46[u79]
			local v81 = UDim2.fromOffset(v80.X, v80.Y)
			if u78 == "Position" then
				local v82 = u76.ViewportSize.X - u43.AbsoluteSize.X - 4
				local v83 = v81.X.Offset
				if v83 < 4 then
					v82 = 4
				elseif v82 >= v83 then
					v82 = v83
				end
				local v84 = UDim2.fromOffset(v82, v81.Y.Offset)
				local v85 = u41.TopbarInset
				local v86 = workspace.CurrentCamera.ViewportSize.X
				local v87 = u54.AbsoluteSize.X
				local v88 = u54.AbsolutePosition.X
				if not u50.isOldTopbar then
					v88 = v86 - v87 - 0
				end
				local v89 = v88 - u77
				v81 = v84 + UDim2.fromOffset(-v89, v85.Height)
				task.defer(function()

					local v90 = nil
					local v91 = u42.UID
					local v92
					if u43:GetAttribute("ClipToJoinedParent") then
						v92 = v91
						for _ = 1, 10 do
							local v93 = u50.getIconByUID(v91)
							if not v93 then
								break
							end
							local v94 = v93.joinedFrame
							v91 = v93.parentIconUID
							if not v94 then
								break
							end
							if v94 and v94.Name == "DropdownScroller" then
								v90 = v94
								break
							end
							v90 = v94
						end
					else
						v92 = v91
					end
					if v90 then
						local v95 = u43.AbsolutePosition
						local v96 = u43.AbsoluteSize / 2
						local v97 = v90.AbsolutePosition
						local v98 = v90.AbsoluteSize
						local v99 = v95 + v96
						local v100 = v99.X < v97.X or (v99.X > v97.X + v98.X or (v99.Y < v97.Y or v99.Y > v97.Y + v98.Y))
						if v100 ~= u57 then
							u57 = v100
							if not u58 then
								local v101 = u56.Visible
								if u57 then
									v101 = false
								end
								u1.setVisible(u43, v101, "ClipHandler")
							end
						end
						if v90:IsA("ScrollingFrame") and u61 ~= v90 then
							u61 = v90
							u44:add(v90:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()

								u75()
							end), "Disconnect", "TrackUtilityScroller-" .. v92)
						end
						return
					else
						u57 = false
						if not u58 then
							local v102 = u56.Visible
							if u57 then
								v102 = false
							end
							u1.setVisible(u43, v102, "ClipHandler")
						end
					end
				end)
			end
			u43[u78] = v81
		end
		local u104 = u1.createStagger(0.01, v103)
		u44:add(u46:GetPropertyChangedSignal(u79):Connect(u104))
		u44:add(u46:GetAttributeChangedSignal("ForceUpdate"):Connect(function()

			u104()
		end))
		local v105 = u1.createStagger(0.5, v103, true)
		u44:add(u46:GetPropertyChangedSignal(u79):Connect(v105))
		if u78 == "Position" then
			u44:add(u54:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()

				u104()
			end))
		end
	end
	task.delay(0.1, u75)
	task.defer(function()

		local v107 = nil
		local v108 = u42.UID
		local v109
		if u43:GetAttribute("ClipToJoinedParent") then
			v109 = v108
			for _ = 1, 10 do
				local v110 = u50.getIconByUID(v108)
				if not v110 then
					break
				end
				local v111 = v110.joinedFrame
				v108 = v110.parentIconUID
				if not v111 then
					break
				end
				if v111 and v111.Name == "DropdownScroller" then
					v107 = v111
					break
				end
				v107 = v111
			end
		else
			v109 = v108
		end
		if v107 then
			local v112 = u43.AbsolutePosition
			local v113 = u43.AbsoluteSize / 2
			local v114 = v107.AbsolutePosition
			local v115 = v107.AbsoluteSize
			local v116 = v112 + v113
			local v117 = v116.X < v114.X or (v116.X > v114.X + v115.X or (v116.Y < v114.Y or v116.Y > v114.Y + v115.Y))
			if v117 ~= u57 then
				u57 = v117
				if not u58 then
					local v118 = u56.Visible
					if u57 then
						v118 = false
					end
					u1.setVisible(u43, v118, "ClipHandler")
				end
			end
			if v107:IsA("ScrollingFrame") and u61 ~= v107 then
				u61 = v107
				u44:add(v107:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()

					u75()
				end), "Disconnect", "TrackUtilityScroller-" .. v109)
			end
			return
		else
			u57 = false
			if not u58 then
				local v119 = u56.Visible
				if u57 then
					v119 = false
				end
				u1.setVisible(u43, v119, "ClipHandler")
			end
		end
	end)
	if not u58 then
		local v120 = u56.Visible
		if u57 then
			v120 = false
		end
		u1.setVisible(u43, v120, "ClipHandler")
	end
	v106("Position")
	u44:add(u43:GetPropertyChangedSignal("Visible"):Connect(function() end))
	if u43:GetAttribute("TrackCloneSize") then
		v106("Size")
	else
		u44:add(u43:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()

			local v121 = u43.AbsoluteSize
			u46.Size = UDim2.fromOffset(v121.X, v121.Y)
		end))
	end
	return u46
end
function u1.joinFeature(u122, u123, u124, p125) 
	local v126 = u122.joinJanitor
	v126:clean()
	if p125 then
		u122.parentIconUID = u123.UID
		u122.joinedFrame = p125
		v126:add(u123.alignmentChanged:Connect(function() 

			local v127 = u123.alignment
			u122:setAlignment(v127 == "Center" and "Left" or v127, true)
		end))
		local v128 = u123.alignment
		u122:setAlignment(v128 == "Center" and "Left" or v128, true)
		u122:modifyTheme({ "IconButton", "BackgroundTransparency", 1 }, "JoinModification")
		u122:modifyTheme({ "ClickRegion", "Active", false }, "JoinModification")
		if u123.childModifications then
			task.defer(function()

				u122:modifyTheme(u123.childModifications, u123.childModificationsUID)
			end)
		end
		local u129 = u122:getInstance("ClickRegion")
		local function v130() 

			u129.Selectable = u123.isSelected
		end
		v126:add(u123.toggled:Connect(v130))
		task.defer(v130)
		v126:add(function()

			u129.Selectable = true
		end)
		local u131 = u122.UID
		table.insert(u124, u131)
		u123:autoDeselect(false)
		u123.childIconsDict[u131] = true
		if not u123.isEnabled then
			u123:setEnabled(true)
		end
		u122.joinedParent:Fire(u123)
		v126:add(function()

			if not u122.joinedFrame then
				return
			end
			for v132, v133 in pairs(u124) do
				if v133 == u131 then
					table.remove(u124, v132)
					break
				end
			end
			local v134 = require(u122.iconModule).getIconByUID(u122.parentIconUID)
			if v134 then
				u122:setAlignment(u122.originalAlignment)
				u122.parentIconUID = false
				u122.joinedFrame = false
				u122:removeModification("JoinModification")
				local v135 = true
				local v136 = v134.childIconsDict
				v136[u131] = nil
				for _, _ in pairs(v136) do
					v135 = false
					break
				end
				if v135 and not v134.isAnOverflow then
					v134:setEnabled(false)
				end
				local v137 = u123.alignment
				u122:setAlignment(v137 == "Center" and "Left" or v137, true)
			end
		end)
	else
		u122:leave()
	end
end
return u1