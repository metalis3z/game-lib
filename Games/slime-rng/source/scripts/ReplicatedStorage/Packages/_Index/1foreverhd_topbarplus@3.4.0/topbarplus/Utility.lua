-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Utility, time of decompilation: Sun May  3 10:09:28 2026 ]]
local t1 = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

function t1.createStagger(p1, p2, p3) -- line: 13
	local u11 = false
	local u12 = false
	local staggeredCallback = nil

	if not p1 or p1 == 0 then
		p1 = 0.01
	end

	function staggeredCallback(...) -- line: 29
		-- upvalues: u11 (ref), u12 (ref), p3 (copy), p1 (ref), p2 (copy), staggeredCallback (copy)
		if u11 then
			u12 = true

			return
		end

		local v71 = table.pack(...)

		u11 = true
		u12 = false
		task.spawn(function() -- line: 37
			-- upvalues: p3 (copy), p1 (ref), p2 (copy), v71 (copy)
			if p3 then
				task.wait(p1)
			end

			p2(table.unpack(v71))
		end)
		task.delay(p1, function() -- line: 43
			-- upvalues: u11 (ref), u12 (ref), staggeredCallback (copy), v71 (copy)
			u11 = false

			if u12 then
				staggeredCallback(table.unpack(v71))
			end
		end)
	end

	return staggeredCallback
end
function t1.round(p4) -- line: 55
	return (math.floor(p4 + 0.5))
end
function t1.reverseTable(p5) -- line: 60
	for i = 1, math.floor(#p5 / 2) do
		local v17 = #p5 - i + 1
		local v18 = p5[v17]
		local v19 = p5[i]

		p5[i] = v18
		p5[v17] = v19
	end
end
function t1.copyTable(p6) -- line: 67
	-- upvalues: t1 (copy)
	assert(type(p6) == "table", "First argument must be a table")

	local t2 = table.create(#p6)

	for k, v in pairs(p6) do
		if type(v) == "table" then
			t2[k] = t1.copyTable(v)
		else
			t2[k] = v
		end
	end

	return t2
end

local t3 = {
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

function t1.generateUID(p7) -- line: 82
	-- upvalues: t3 (copy)
	local v25 = p7 or 8
	local s1 = ""
	local v27 = t3
	local v28 = #v27

	for _ = 1, v25 do
		s1 ..= v27[math.random(1, v28)]
	end

	return s1
end

local t4 = {}

function t1.setVisible(p8, p9, p10) -- line: 95
	-- upvalues: t4 (copy)
	local v33 = t4[p8]

	if not v33 then
		v33 = {}
		t4[p8] = v33
		p8.Destroying:Once(function() -- line: 104
			-- upvalues: t4 (copy), p8 (copy)
			t4[p8] = nil
		end)
	end

	if not p9 then
		v33[p10] = true
	else
		v33[p10] = nil
	end

	if p9 then
		for _, _ in pairs(v33) do
			p9 = false

			break
		end
	end

	p8.Visible = p9
end
function t1.formatStateName(p11) -- line: 123
	return string.upper((string.sub(p11, 1, 1))) .. string.lower((string.sub(p11, 2)))
end
function t1.localPlayerRespawned(p12) -- line: 127
	-- upvalues: LocalPlayer (copy)
	LocalPlayer.CharacterRemoving:Connect(p12)
end
function t1.getClippedContainer(p13) -- line: 137
	local ClippedContainer = p13:FindFirstChild("ClippedContainer")

	if not ClippedContainer then
		ClippedContainer = Instance.new("Folder")
		ClippedContainer.Name = "ClippedContainer"
		ClippedContainer.Parent = p13
	end

	return ClippedContainer
end

local Janitor = require(script.Parent.Packages.Janitor)
local GuiService = game:GetService("GuiService")

function t1.clipOutside(p14, p15) -- line: 151
	-- upvalues: Janitor (copy), t1 (copy), GuiService (copy)
	local v42 = p14.janitor:add(Janitor.new())

	p15.Destroying:Once(function() -- line: 153
		-- upvalues: v42 (copy)
		v42:Destroy()
	end)
	p14.janitor:add(p15)

	local p15Parent = p15.Parent
	local v44 = v42:add(Instance.new("Frame"))

	v44:SetAttribute("IsAClippedClone", true)
	v44.Name = p15.Name
	v44.AnchorPoint = p15.AnchorPoint
	v44.Size = p15.Size
	v44.Position = p15.Position
	v44.BackgroundTransparency = 1
	v44.LayoutOrder = p15.LayoutOrder
	v44.Parent = p15Parent

	local ObjectValue = Instance.new("ObjectValue")

	ObjectValue.Name = "OriginalInstance"
	ObjectValue.Value = p15
	ObjectValue.Parent = v44

	local clone = ObjectValue:Clone()

	p15:SetAttribute("HasAClippedClone", true)
	clone.Name = "ClippedClone"
	clone.Value = v44
	clone.Parent = p15

	local u47 = nil
	local iconModule = require(p14.iconModule)
	local container = iconModule.container

	local function updateScreenGui() -- line: 183
		-- upvalues: p15Parent (copy), u47 (ref), container (copy), p15 (copy), t1 (copy)
		local ScreenGui = p15Parent:FindFirstAncestorWhichIsA("ScreenGui")

		u47 = if not string.match(ScreenGui.Name, "Clipped") then container[ScreenGui.Name .. "Clipped"] else ScreenGui
		p15.AnchorPoint = Vector2.new(0, 0)
		p15.Parent = t1.getClippedContainer(u47)
	end

	v42:add(p14.alignmentChanged:Connect(updateScreenGui))
	updateScreenGui()

	local checkIfOutsideParentXBounds = nil

	for _, v in pairs(p15:GetChildren()) do
		if v:IsA("UIAspectRatioConstraint") then
			v:Clone().Parent = v44
		end
	end

	local widget = p14.widget
	local u54 = false
	local IgnoreVisibilityUpdater = p15:GetAttribute("IgnoreVisibilityUpdater")

	v42:add(widget:GetPropertyChangedSignal("Visible"):Connect(function() --[[ updateVisibility ]] -- line: 205
		-- upvalues: IgnoreVisibilityUpdater (copy), widget (copy), u54 (ref), t1 (copy), p15 (copy)
		if IgnoreVisibilityUpdater then
			return
		end

		local widgetVisible = widget.Visible

		if u54 then
			widgetVisible = false
		end

		t1.setVisible(p15, widgetVisible, "ClipHandler")
	end))

	local u56 = nil

	function checkIfOutsideParentXBounds() -- line: 218
		-- upvalues: p14 (copy), p15 (copy), iconModule (copy), u54 (ref), IgnoreVisibilityUpdater (copy), widget (copy), t1 (copy), u56 (ref), checkIfOutsideParentXBounds (copy), v42 (copy)
		task.defer(function() -- line: 220
			-- upvalues: p14 (copy), p15 (copy), iconModule (copy), u54 (ref), IgnoreVisibilityUpdater (copy), widget (copy), t1 (copy), u56 (ref), checkIfOutsideParentXBounds (copy), v42 (copy)
			local v108 = nil
			local UID = p14.UID
			local v110 = UID

			if p15:GetAttribute("ClipToJoinedParent") then
				for _ = 1, 10 do
					local v112 = iconModule.getIconByUID(v110)

					if not v112 then
						break
					end

					local joinedFrame = v112.joinedFrame

					v110 = v112.parentIconUID

					if not joinedFrame then
						break
					end

					v108 = joinedFrame

					if v108 and v108.Name == "DropdownScroller" then
						break
					end
				end
			end

			if not v108 then
				u54 = false

				if IgnoreVisibilityUpdater then
					return
				end

				local widgetVisible = widget.Visible

				if u54 then
					widgetVisible = false
				end

				t1.setVisible(p15, widgetVisible, "ClipHandler")

				return
			end

			local AbsolutePosition = p15.AbsolutePosition
			local v116 = p15.AbsoluteSize / 2
			local AbsolutePosition2 = v108.AbsolutePosition
			local AbsoluteSize = v108.AbsoluteSize
			local v119 = AbsolutePosition + v116
			local v120 = v119.X < AbsolutePosition2.X
			local v121 = v119.X > AbsolutePosition2.X + AbsoluteSize.X
			local v122 = v119.Y < AbsolutePosition2.Y
			local v123 = v119.Y > AbsolutePosition2.Y + AbsoluteSize.Y
			local v124 = v120 or (v121 or (v122 or v123))

			if v124 ~= u54 then
				u54 = v124

				if not IgnoreVisibilityUpdater then
					local widgetVisible = widget.Visible

					if u54 then
						widgetVisible = false
					end

					t1.setVisible(p15, widgetVisible, "ClipHandler")
				end
			end

			if v108:IsA("ScrollingFrame") and v108 ~= u56 then
				u56 = v108

				local connection = v108:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line: 265
					-- upvalues: checkIfOutsideParentXBounds (copy)
					checkIfOutsideParentXBounds()
				end)

				v42:add(connection, "Disconnect", "TrackUtilityScroller-" .. UID)
			end
		end)
	end

	local CurrentCamera = workspace.CurrentCamera
	local v59 = p15:GetAttribute("AdditionalOffsetX") or 0

	local function trackProperty(p16) -- line: 275
		-- upvalues: v44 (copy), CurrentCamera (copy), p15 (copy), GuiService (copy), u47 (ref), iconModule (copy), v59 (copy), p14 (copy), u54 (ref), IgnoreVisibilityUpdater (copy), widget (copy), t1 (copy), u56 (ref), checkIfOutsideParentXBounds (copy), v42 (copy)
		local v75 = "Absolute" .. p16

		local function updateProperty() -- line: 277
			-- upvalues: v44 (copy), v75 (copy), p16 (copy), CurrentCamera (copy), p15 (copy), GuiService (copy), u47 (ref), iconModule (copy), v59 (copy), p14 (copy), u54 (ref), IgnoreVisibilityUpdater (copy), widget (copy), t1 (copy), u56 (ref), checkIfOutsideParentXBounds (copy), v42 (copy)
			local v127 = v44[v75]
			local uDim2 = UDim2.fromOffset(v127.X, v127.Y)

			if p16 == "Position" then
				local v129 = CurrentCamera.ViewportSize.X - p15.AbsoluteSize.X - 4
				local XOffset = uDim2.X.Offset

				if XOffset < 4 then
					XOffset = 4
				elseif v129 < XOffset then
					XOffset = v129
				end

				local uDim2_2 = UDim2.fromOffset(XOffset, uDim2.Y.Offset)
				local TopbarInset = GuiService.TopbarInset
				local ViewportSizeX = workspace.CurrentCamera.ViewportSize.X
				local AbsoluteSizeX = u47.AbsoluteSize.X
				local AbsolutePositionX = u47.AbsolutePosition.X
				local v136 = ((if not iconModule.isOldTopbar then ViewportSizeX - AbsoluteSizeX - 0 else AbsolutePositionX)) - v59

				uDim2 = uDim2_2 + UDim2.fromOffset(-v136, TopbarInset.Height)
				task.defer(function() -- line: 220
					-- upvalues: p14 (copy), p15 (copy), iconModule (copy), u54 (ref), IgnoreVisibilityUpdater (copy), widget (copy), t1 (copy), u56 (ref), checkIfOutsideParentXBounds (copy), v42 (copy)
					local v137 = nil
					local UID = p14.UID
					local v139 = UID

					if p15:GetAttribute("ClipToJoinedParent") then
						for _ = 1, 10 do
							local v141 = iconModule.getIconByUID(v139)

							if not v141 then
								break
							end

							local joinedFrame = v141.joinedFrame

							v139 = v141.parentIconUID

							if not joinedFrame then
								break
							end

							v137 = joinedFrame

							if v137 and v137.Name == "DropdownScroller" then
								break
							end
						end
					end

					if not v137 then
						u54 = false

						if IgnoreVisibilityUpdater then
							return
						end

						local widgetVisible = widget.Visible

						if u54 then
							widgetVisible = false
						end

						t1.setVisible(p15, widgetVisible, "ClipHandler")

						return
					end

					local AbsolutePosition = p15.AbsolutePosition
					local v145 = p15.AbsoluteSize / 2
					local AbsolutePosition3 = v137.AbsolutePosition
					local AbsoluteSize = v137.AbsoluteSize
					local v148 = AbsolutePosition + v145
					local v149 = v148.X < AbsolutePosition3.X
					local v150 = v148.X > AbsolutePosition3.X + AbsoluteSize.X
					local v151 = v148.Y < AbsolutePosition3.Y
					local v152 = v148.Y > AbsolutePosition3.Y + AbsoluteSize.Y
					local v153 = v149 or (v150 or (v151 or v152))

					if v153 ~= u54 then
						u54 = v153

						if not IgnoreVisibilityUpdater then
							local widgetVisible = widget.Visible

							if u54 then
								widgetVisible = false
							end

							t1.setVisible(p15, widgetVisible, "ClipHandler")
						end
					end

					if v137:IsA("ScrollingFrame") and v137 ~= u56 then
						u56 = v137

						local connection = v137:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line: 265
							-- upvalues: checkIfOutsideParentXBounds (copy)
							checkIfOutsideParentXBounds()
						end)

						v42:add(connection, "Disconnect", "TrackUtilityScroller-" .. UID)
					end
				end)
			end

			p15[p16] = uDim2
		end

		local v77 = t1.createStagger(0.01, updateProperty)

		v42:add(v44:GetPropertyChangedSignal(v75):Connect(v77))
		v42:add(v44:GetAttributeChangedSignal("ForceUpdate"):Connect(function() -- line: 317
			-- upvalues: v77 (copy)
			v77()
		end))

		local v78 = t1.createStagger(0.5, updateProperty, true)

		v42:add(v44:GetPropertyChangedSignal(v75):Connect(v78))

		if p16 == "Position" then
			v42:add(u47:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 336
				-- upvalues: v77 (copy)
				v77()
			end))
		end
	end

	task.delay(0.1, checkIfOutsideParentXBounds)
	task.defer(function() -- line: 220
		-- upvalues: p14 (copy), p15 (copy), iconModule (copy), u54 (ref), IgnoreVisibilityUpdater (copy), widget (copy), t1 (copy), u56 (ref), checkIfOutsideParentXBounds (copy), v42 (copy)
		local v79 = nil
		local UID = p14.UID
		local v81 = UID

		if p15:GetAttribute("ClipToJoinedParent") then
			for _ = 1, 10 do
				local v83 = iconModule.getIconByUID(v81)

				if not v83 then
					break
				end

				local joinedFrame = v83.joinedFrame

				v81 = v83.parentIconUID

				if not joinedFrame then
					break
				end

				v79 = joinedFrame

				if v79 and v79.Name == "DropdownScroller" then
					break
				end
			end
		end

		if not v79 then
			u54 = false

			if IgnoreVisibilityUpdater then
				return
			end

			local widgetVisible = widget.Visible

			if u54 then
				widgetVisible = false
			end

			t1.setVisible(p15, widgetVisible, "ClipHandler")

			return
		end

		local AbsolutePosition = p15.AbsolutePosition
		local v87 = p15.AbsoluteSize / 2
		local AbsolutePosition4 = v79.AbsolutePosition
		local AbsoluteSize = v79.AbsoluteSize
		local v90 = AbsolutePosition + v87
		local v91 = v90.X < AbsolutePosition4.X
		local v92 = v90.X > AbsolutePosition4.X + AbsoluteSize.X
		local v93 = v90.Y < AbsolutePosition4.Y
		local v94 = v90.Y > AbsolutePosition4.Y + AbsoluteSize.Y
		local v95 = v91 or (v92 or (v93 or v94))

		if v95 ~= u54 then
			u54 = v95

			if not IgnoreVisibilityUpdater then
				local widgetVisible = widget.Visible

				if u54 then
					widgetVisible = false
				end

				t1.setVisible(p15, widgetVisible, "ClipHandler")
			end
		end

		if v79:IsA("ScrollingFrame") and v79 ~= u56 then
			u56 = v79

			local connection = v79:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line: 265
				-- upvalues: checkIfOutsideParentXBounds (copy)
				checkIfOutsideParentXBounds()
			end)

			v42:add(connection, "Disconnect", "TrackUtilityScroller-" .. UID)
		end
	end)

	if not IgnoreVisibilityUpdater then
		local widgetVisible = widget.Visible

		if u54 then
			widgetVisible = false
		end

		t1.setVisible(p15, widgetVisible, "ClipHandler")
	end

	trackProperty("Position")
	v42:add(p15:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 348
	end))

	if p15:GetAttribute("TrackCloneSize") then
		trackProperty("Size")
	else
		v42:add(p15:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 358
			-- upvalues: p15 (copy), v44 (copy)
			local AbsoluteSize = p15.AbsoluteSize

			v44.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
		end))
	end

	return v44
end
function t1.joinFeature(p17, p18, p19, p20) -- line: 367
	local joinJanitor = p17.joinJanitor

	joinJanitor:clean()

	if not p20 then
		p17:leave()

		return
	end

	p17.parentIconUID = p18.UID
	p17.joinedFrame = p20
	joinJanitor:add(p18.alignmentChanged:Connect(function() --[[ updateAlignent ]] -- line: 378
		-- upvalues: p18 (copy), p17 (copy)
		local alignment = p18.alignment

		if alignment == "Center" then
			alignment = "Left"
		end

		p17:setAlignment(alignment, true)
	end))

	local alignment = p18.alignment

	if alignment == "Center" then
		alignment = "Left"
	end

	p17:setAlignment(alignment, true)
	p17:modifyTheme({
		"IconButton",
		"BackgroundTransparency",
		1
	}, "JoinModification")
	p17:modifyTheme({
		"ClickRegion",
		"Active",
		false
	}, "JoinModification")

	if p18.childModifications then
		task.defer(function() -- line: 393
			-- upvalues: p17 (copy), p18 (copy)
			p17:modifyTheme(p18.childModifications, p18.childModificationsUID)
		end)
	end

	local v68 = p17:getInstance("ClickRegion")

	local function makeSelectable() -- line: 399
		-- upvalues: v68 (copy), p18 (copy)
		v68.Selectable = p18.isSelected
	end

	joinJanitor:add(p18.toggled:Connect(makeSelectable))
	task.defer(makeSelectable)
	joinJanitor:add(function() -- line: 404
		-- upvalues: v68 (copy)
		v68.Selectable = true
	end)

	local UID = p17.UID

	table.insert(p19, UID)
	p18:autoDeselect(false)
	p18.childIconsDict[UID] = true

	if not p18.isEnabled then
		p18:setEnabled(true)
	end

	p17.joinedParent:Fire(p18)
	joinJanitor:add(function() -- line: 422
		-- upvalues: p17 (copy), p19 (copy), UID (copy), p18 (copy)
		if not p17.joinedFrame then
			return
		end

		for k, v in pairs(p19) do
			if v == UID then
				table.remove(p19, k)

				break
			end
		end

		local v102 = require(p17.iconModule).getIconByUID(p17.parentIconUID)

		if not v102 then
			return
		end

		p17:setAlignment(p17.originalAlignment)
		p17.parentIconUID = false
		p17.joinedFrame = false
		p17:removeModification("JoinModification")

		local v103 = true
		local childIconsDict = v102.childIconsDict

		childIconsDict[UID] = nil

		for _, _ in pairs(childIconsDict) do
			v103 = false

			break
		end

		if v103 and not v102.isAnOverflow then
			v102:setEnabled(false)
		end

		local alignment2 = p18.alignment

		if alignment2 == "Center" then
			alignment2 = "Left"
		end

		p17:setAlignment(alignment2, true)
	end)
end

return t1
