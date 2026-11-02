

local u1 = game:GetService("UserInputService")
local u2 = game:GetService("ContentProvider")
local u3 = game:GetService("StarterGui")
local v4 = game:GetService("Players")
require(script.Types)
local u5 = script
local v6 = require(u5.Reference)
local v7 = v6.getObject()
local v8
if v7 then
	v8 = v7.Value
else
	v8 = v7
end
if v8 and v8 ~= u5 then
	return require(v8)
end
if not v7 then
	v6.addToReplicatedStorage()
end
local u9 = require(u5.Packages.GoodSignal)
local u10 = require(u5.Packages.Janitor)
local u11 = require(u5.Utility)
local u12 = require(u5.Features.Themes)
local v13 = require(u5.Features.Gamepad)
local v14 = require(u5.Features.Overflow)
local u15 = {}
u15.__index = u15
local u16 = v4.LocalPlayer
local v17 = u5.Features.Themes
local u18 = {}
local u19 = u9.new()
local u20 = u5.Elements
local u21 = 0
local u22 = {
	["mobile"] = Enum.PreferredInput.Touch,
	["desktop"] = Enum.PreferredInput.KeyboardAndMouse,
	["console"] = Enum.PreferredInput.Gamepad
}
u15.baseDisplayOrderChanged = u9.new()
u15.baseDisplayOrder = 10
u15.baseTheme = require(v17.Default)
u15.isOldTopbar = false
u15.iconsDictionary = u18
u15.insetHeightChanged = u9.new()
u15.container = require(u20.Container)(u15)
u15.topbarEnabled = true
u15.iconAdded = u9.new()
u15.iconRemoved = u9.new()
u15.iconChanged = u9.new()
function u15.getIcons() 

	return u15.iconsDictionary
end
function u15.getIconByUID(p23) 

	return u15.iconsDictionary[p23] or nil
end
function u15.getIcon(p24) 

	local v25 = u15.getIconByUID(p24)
	if v25 then
		return v25
	end
	for _, v26 in pairs(u18) do
		if v26.name == p24 then
			return v26
		end
	end
	return nil
end
function u15.setTopbarEnabled(p27, p28) 

	if typeof(p27) ~= "boolean" then
		p27 = u15.topbarEnabled
	end
	if not p28 then
		u15.topbarEnabled = p27
	end
	for _, v29 in pairs(u15.container) do
		v29.Enabled = p27
	end
end
function u15.modifyBaseTheme(p30) 

	local v31 = u12.getModifications(p30)
	for _, v32 in pairs(v31) do
		for _, v33 in pairs(u15.baseTheme) do
			u12.merge(v33, v32)
		end
	end
	for _, v34 in pairs(u18) do
		v34:setTheme(u15.baseTheme)
	end
end
function u15.setDisplayOrder(p35) 

	u15.baseDisplayOrder = p35
	u15.baseDisplayOrderChanged:Fire(p35)
end
task.defer(v13.start, u15)
task.defer(v14.start, u15)
task.defer(function()

	local v36 = u16:WaitForChild("PlayerGui")
	for _, v37 in pairs(u15.container) do
		v37.Parent = v36
	end
	require(u5.Attribute)
end)
function u15.new() 

	local u38 = {}
	local v39 = u15
	setmetatable(u38, v39)
	local v40 = u10.new()
	u38.janitor = v40
	u38.themesJanitor = v40:add(u10.new())
	u38.singleClickJanitor = v40:add(u10.new())
	u38.captionJanitor = v40:add(u10.new())
	u38.joinJanitor = v40:add(u10.new())
	u38.menuJanitor = v40:add(u10.new())
	u38.dropdownJanitor = v40:add(u10.new())
	local u41 = u11.generateUID()
	u18[u41] = u38
	v40:add(function()

		u18[u41] = nil
	end)
	u38.selected = v40:add(u9.new())
	u38.deselected = v40:add(u9.new())
	u38.toggled = v40:add(u9.new())
	u38.viewingStarted = v40:add(u9.new())
	u38.viewingEnded = v40:add(u9.new())
	u38.stateChanged = v40:add(u9.new())
	u38.notified = v40:add(u9.new())
	u38.noticeStarted = v40:add(u9.new())
	u38.noticeChanged = v40:add(u9.new())
	u38.endNotices = v40:add(u9.new())
	u38.toggleKeyAdded = v40:add(u9.new())
	u38.fakeToggleKeyChanged = v40:add(u9.new())
	u38.alignmentChanged = v40:add(u9.new())
	u38.updateSize = v40:add(u9.new())
	u38.resizingComplete = v40:add(u9.new())
	u38.joinedParent = v40:add(u9.new())
	u38.menuSet = v40:add(u9.new())
	u38.dropdownSet = v40:add(u9.new())
	u38.updateMenu = v40:add(u9.new())
	u38.startMenuUpdate = v40:add(u9.new())
	u38.childThemeModified = v40:add(u9.new())
	u38.indicatorSet = v40:add(u9.new())
	u38.dropdownChildAdded = v40:add(u9.new())
	u38.menuChildAdded = v40:add(u9.new())
	u38.iconModule = u5
	u38.UID = u41
	u38.isEnabled = true
	u38.enabled = u38.isEnabled
	u38.isSelected = false
	u38.isViewing = false
	u38.joinedFrame = false
	u38.parentIconUID = false
	u38.deselectWhenOtherIconSelected = true
	u38.totalNotices = 0
	u38.activeState = "Deselected"
	u38.alignment = ""
	u38.originalAlignment = ""
	u38.appliedTheme = {}
	u38.appearance = {}
	u38.cachedInstances = {}
	u38.cachedNamesToInstances = {}
	u38.cachedCollectives = {}
	u38.bindedToggleKeys = {}
	u38.customBehaviours = {}
	u38.toggleItems = {}
	u38.bindedEvents = {}
	u38.notices = {}
	u38.menuIcons = {}
	u38.dropdownIcons = {}
	u38.childIconsDict = {}
	u38.creationTime = os.clock()
	u38.widget = v40:add(require(u20.Widget)(u38, u15))
	u38:setAlignment()
	u21 = u21 + 1
	local v42 = u21 * 0.01 + 1
	u38:setOrder(v42, "deselected")
	u38:setOrder(v42, "selected")
	u38:setTheme(u15.baseTheme)
	local v43 = u38:getInstance("ClickRegion")
	local u44 = false
	local u45 = 0
	v43.MouseButton1Click:Connect(function()

		u44 = true
		if u38.locked then
			return
		else
			local v46 = tick()
			if v46 - u45 < 0.1 then
				return
			else
				u45 = v46
				if u38.isSelected then
					u38:deselect("User", u38)
				else
					u38:select("User", u38)
				end
			end
		end
	end)
	v43.TouchTap:Connect(function()

		if not u44 then
			if u38.locked then
				return
			end
			local v47 = tick()
			if v47 - u45 < 0.1 then
				return
			end
			u45 = v47
			if u38.isSelected then
				u38:deselect("User", u38)
				return
			end
			u38:select("User", u38)
		end
	end)
	v40:add(u1.InputBegan:Connect(function(p48, p49)

		if not u38.locked then
			if u38.bindedToggleKeys[p48.KeyCode] and not p49 then
				if u38.locked then
					return
				end
				local v50 = tick()
				if v50 - u45 < 0.1 then
					return
				end
				u45 = v50
				if u38.isSelected then
					u38:deselect("User", u38)
					return
				end
				u38:select("User", u38)
			end
		end
	end))
	local function v51() 

		if not u38.locked then
			u38.isViewing = false
			u38.viewingEnded:Fire(true)
			u38:setState(nil, "User", u38)
		end
	end
	u38.joinedParent:Connect(function()

		if u38.isViewing then
			if u38.locked then
				return
			end
			u38.isViewing = false
			u38.viewingEnded:Fire(true)
			u38:setState(nil, "User", u38)
		end
	end)
	v43.MouseEnter:Connect(function()

		local v52 = u1.PreferredInput ~= u22.desktop
		if not u38.locked then
			u38.isViewing = true
			u38.viewingStarted:Fire(true)
			if not v52 then
				u38:setState("Viewing", "User", u38)
			end
		end
	end)
	local u53 = 0
	v40:add(u1.TouchEnded:Connect(v51))
	v43.MouseLeave:Connect(v51)
	v43.SelectionGained:Connect(function(p54) 

		if not u38.locked then
			u38.isViewing = true
			u38.viewingStarted:Fire(true)
			if not p54 then
				u38:setState("Viewing", "User", u38)
			end
		end
	end)
	v43.SelectionLost:Connect(v51)
	v43.MouseButton1Down:Connect(function()

		if not u38.locked and u1.PreferredInput == u22.mobile then
			u53 = u53 + 1
			local u55 = u53
			task.delay(0.2, function()

				if u55 == u53 then
					if u38.locked then
						return
					end
					u38.isViewing = true
					u38.viewingStarted:Fire(true)
					u38:setState("Viewing", "User", u38)
				end
			end)
		end
	end)
	v43.MouseButton1Up:Connect(function()

		u53 = u53 + 1
	end)
	local u56 = u38:getInstance("IconOverlay")
	u38.viewingStarted:Connect(function()

		u56.Visible = not u38.overlayDisabled
	end)
	u38.viewingEnded:Connect(function()

		u56.Visible = false
	end)
	v40:add(u19:Connect(function(p57)

		if p57 ~= u38 and (u38.deselectWhenOtherIconSelected and p57.deselectWhenOtherIconSelected) then
			u38:deselect("AutoDeselect", p57)
		end
	end))
	local v58 = debug.info(2, "s")
	local v59 = string.split(v58, ".")
	local v60 = game
	local v61 = nil
	for _, v62 in pairs(v59) do
		v60 = v60:FindFirstChild(v62)
		if not v60 then
			break
		end
		if v60:IsA("ScreenGui") then
			v61 = v60
		end
	end
	if v60 and (v61 and v61.ResetOnSpawn == true) then
		u38.originsScreenGui = v61
		u11.localPlayerRespawned(function()

			u38:destroy()
		end)
	end
	u38.toggled:Connect(function(p63)

		u38.noticeChanged:Fire(u38.totalNotices)
		for v64, _ in pairs(u38.childIconsDict) do
			local v65 = u15.getIconByUID(v64)
			v65.noticeChanged:Fire(v65.totalNotices)
			if not p63 and v65.isSelected then
				for _, _ in pairs(v65.childIconsDict) do
					v65:deselect("HideParentFeature", u38)
				end
			end
		end
	end)
	u38.selected:Connect(function()

		if #u38.dropdownIcons > 0 then
			if u3:GetCore("ChatActive") and u38.alignment ~= "Right" then
				u38.chatWasPreviouslyActive = true
				u3:SetCore("ChatActive", false)
			end
			if u3:GetCoreGuiEnabled("PlayerList") and u38.alignment ~= "Left" then
				u38.playerlistWasPreviouslyActive = true
				u3:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			end
		end
	end)
	u38.deselected:Connect(function()

		if u38.chatWasPreviouslyActive then
			u38.chatWasPreviouslyActive = nil
			u3:SetCore("ChatActive", true)
		end
		if u38.playerlistWasPreviouslyActive then
			u38.playerlistWasPreviouslyActive = nil
			u3:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end
	end)
	task.delay(0.1, function()

		if u38.activeState == "Deselected" then
			u38.stateChanged:Fire("Deselected")
			u38:refresh()
		end
	end)
	u15.iconAdded:Fire(u38)
	return u38
end
function u15.setName(p66, p67) 
	p66.widget.Name = p67
	p66.name = p67
	return p66
end
function u15.setState(p68, p69, p70, p71) 

	local v72 = p69 or (p68.isSelected and "Selected" or "Deselected")
	local v73 = u11.formatStateName(v72)
	if p68.activeState ~= v73 then
		local v74 = p68.isSelected
		p68.activeState = v73
		if v73 == "Deselected" then
			p68.isSelected = false
			if v74 then
				p68.toggled:Fire(false, p70, p71)
				p68.deselected:Fire(p70, p71)
			end
			p68:_setToggleItemsVisible(false, p70, p71)
		elseif v73 == "Selected" then
			p68.isSelected = true
			if not v74 then
				p68.toggled:Fire(true, p70, p71)
				p68.selected:Fire(p70, p71)
				u19:Fire(p68, p70, p71)
			end
			p68:_setToggleItemsVisible(true, p70, p71)
		end
		p68.stateChanged:Fire(v73, p70, p71)
	end
end
function u15.getInstance(u75, u76) 

	local v77 = u75.cachedNamesToInstances[u76]
	if v77 then
		return v77
	end
	local function u81(u78, u79) 

		if not u75.cachedInstances[u79] then
			local v80 = u79:GetAttribute("Collective")
			if v80 then
				v80 = u75.cachedCollectives[v80]
			end
			if v80 then
				table.insert(v80, u79)
			end
			u75.cachedNamesToInstances[u78] = u79
			u75.cachedInstances[u79] = true
			u79.Destroying:Once(function()

				u75.cachedNamesToInstances[u78] = nil
				u75.cachedInstances[u79] = nil
			end)
		end
	end
	local v82 = u75.widget
	u81("Widget", v82)
	if u76 == "Widget" then
		return v82
	end
	local u83 = nil
	local function u89(p84) 

		for _, v85 in pairs(p84:GetChildren()) do
			local v86 = v85:GetAttribute("WidgetUID")
			if not v86 or v86 == u75.UID then
				local v87 = u12.getRealInstance(v85) or v85
				u89(v87)
				if v87:IsA("GuiBase") or (v87:IsA("UIBase") or v87:IsA("ValueBase")) then
					local v88 = v87.Name
					u81(v88, v87)
					if v88 == u76 then
						u83 = v87
					end
				end
			end
		end
	end
	u89(v82)
	return u83
end
function u15.getCollective(p90, p91) 
	local v92 = p90.cachedCollectives[p91]
	if v92 then
		return v92
	end
	local v93 = {}
	for v94, _ in pairs(p90.cachedInstances) do
		if v94:GetAttribute("Collective") == p91 then
			table.insert(v93, v94)
		end
	end
	p90.cachedCollectives[p91] = v93
	return v93
end
function u15.getInstanceOrCollective(p95, p96) 
	local v97 = {}
	local v98 = p95:getInstance(p96)
	if v98 then
		table.insert(v97, v98)
	end
	if #v97 == 0 then
		v97 = p95:getCollective(p96)
	end
	return v97
end
function u15.getStateGroup(p99, p100) 
	local v101 = p100 or p99.activeState
	local v102 = p99.appearance[v101]
	if not v102 then
		v102 = {}
		p99.appearance[v101] = v102
	end
	return v102
end
function u15.refreshAppearance(p103, p104, p105) 

	u12.refresh(p103, p104, p105)
	return p103
end
function u15.refresh(p106) 
	p106:refreshAppearance(p106.widget)
	p106.updateSize:Fire()
	return p106
end
function u15.updateParent(p107) 

	local v108 = u15.getIconByUID(p107.parentIconUID)
	if v108 then
		v108.updateSize:Fire()
	end
end
function u15.setBehaviour(p109, p110, p111, p112, p113) 
	local v114 = p110 .. "-" .. p111
	p109.customBehaviours[v114] = p112
	if p113 then
		local v115 = p109:getInstanceOrCollective(p110)
		for _, v116 in pairs(v115) do
			p109:refreshAppearance(v116, p111)
		end
	end
end
function u15.modifyTheme(p117, p118, p119) 

	return p117, u12.modify(p117, p118, p119)
end
function u15.modifyChildTheme(p120, p121, p122) 

	p120.childModifications = p121
	p120.childModificationsUID = p122
	for v123, _ in pairs(p120.childIconsDict) do
		u15.getIconByUID(v123):modifyTheme(p121, p122)
	end
	p120.childThemeModified:Fire()
	return p120
end
function u15.removeModification(p124, p125) 

	u12.remove(p124, p125)
	return p124
end
function u15.removeModificationWith(p126, p127, p128, p129) 

	u12.removeWith(p126, p127, p128, p129)
	return p126
end
function u15.setTheme(p130, p131) 

	u12.set(p130, p131)
	return p130
end
function u15.setEnabled(p132, p133) 
	p132.isEnabled = p133
	p132.enabled = p132.isEnabled
	p132.widget.Visible = p133
	p132:updateParent()
	return p132
end
function u15.select(p134, p135, p136) 
	p134:setState("Selected", p135, p136)
	return p134
end
function u15.deselect(p137, p138, p139) 
	p137:setState("Deselected", p138, p139)
	return p137
end
function u15.notify(p140, p141, p142) 

	if not p140.notice then
		p140.notice = require(u20.Notice)(p140, u15)
	end
	p140.noticeStarted:Fire(p141, p142)
	return p140
end
function u15.clearNotices(p143) 
	p143.endNotices:Fire()
	return p143
end
function u15.disableOverlay(p144, p145) 
	p144.overlayDisabled = p145
	return p144
end
u15.disableStateOverlay = u15.disableOverlay
function u15.setImage(p146, u147, p148) 

	p146:modifyTheme({
		"IconImage",
		"Image",
		u147,
		p148
	})
	task.spawn(function()

		local v149 = u147
		local v150
		if tonumber(v149) then
			v150 = ("rbxassetid://%*"):format(u147)
		else
			v150 = u147
		end
		if u2:GetAssetFetchStatus(v150) ~= Enum.AssetFetchStatus.Success then
			pcall(u2.PreloadAsync, u2, { v150 })
		end
	end)
	return p146
end
function u15.setLabel(p151, p152, p153) 
	p151:modifyTheme({
		"IconLabel",
		"Text",
		p152,
		p153
	})
	return p151
end
function u15.setOrder(p154, p155, p156) 
	local v157 = p155 * 100
	p154:modifyTheme({
		"IconSpot",
		"LayoutOrder",
		v157,
		p156
	})
	p154:modifyTheme({
		"Widget",
		"LayoutOrder",
		v157,
		p156
	})
	return p154
end
function u15.setCornerRadius(p158, p159, p160) 
	p158:modifyTheme({
		"IconCorners",
		"CornerRadius",
		p159,
		p160
	})
	return p158
end
function u15.align(p161, p162, p163) 

	local v164 = tostring(p162):lower()
	local v165 = (v164 == "mid" or v164 == "centre") and "center" or v164
	local v166 = v165 ~= "left" and (v165 ~= "center" and v165 ~= "right") and "left" or v165
	local v167 = v166 == "center" and u15.container.TopbarCentered or u15.container.TopbarStandard
	local v168 = v167.Holders
	local v169 = string.upper((string.sub(v166, 1, 1))) .. string.sub(v166, 2)
	if not p163 then
		p161.originalAlignment = v169
	end
	local v170 = p161.joinedFrame
	local v171 = v168[v169]
	p161.screenGui = v167
	p161.alignmentHolder = v171
	if not p161.isDestroyed then
		p161.widget.Parent = v170 or v171
	end
	p161.alignment = v169
	p161.alignmentChanged:Fire(v169)
	u15.iconChanged:Fire(p161)
	return p161
end
u15.setAlignment = u15.align
function u15.setLeft(p172) 
	p172:setAlignment("Left")
	return p172
end
function u15.setMid(p173) 
	p173:setAlignment("Center")
	return p173
end
function u15.setRight(p174) 
	p174:setAlignment("Right")
	return p174
end
function u15.setWidth(p175, p176, p177) 
	p175:modifyTheme({
		"Widget",
		"DesiredWidth",
		p176,
		p177
	})
	return p175
end
function u15.setImageScale(p178, p179, p180) 
	p178:modifyTheme({
		"IconImageScale",
		"Value",
		p179,
		p180
	})
	return p178
end
function u15.setImageRatio(p181, p182, p183) 
	p181:modifyTheme({
		"IconImageRatio",
		"AspectRatio",
		p182,
		p183
	})
	return p181
end
function u15.setTextSize(p184, p185, p186) 
	p184:modifyTheme({
		"IconLabel",
		"TextSize",
		p185,
		p186
	})
	return p184
end
function u15.setTextFont(p187, p188, p189, p190, p191) 
	local v192 = p189 or Enum.FontWeight.Regular
	local v193 = p190 or Enum.FontStyle.Normal
	local v194 = nil
	local v195 = typeof(p188)
	if v195 == "number" then
		v194 = Font.fromId(p188, v192, v193)
	elseif v195 == "EnumItem" then
		v194 = Font.fromEnum(p188)
	elseif v195 == "string" and not p188:match("rbxasset") then
		v194 = Font.fromName(p188, v192, v193)
	end
	p187:modifyTheme({
		"IconLabel",
		"FontFace",
		v194 or Font.new(p188, v192, v193),
		p191
	})
	return p187
end
function u15.setTextColor(p196, p197, p198) 
	if p197 == nil or (p197 == "" or (type(p197) ~= "userdata" or typeof(p197) ~= "Color3")) then
		if p197 ~= nil and p197 ~= "" then
			warn("setTextColor item must be a Color3 value! Changed the color to white.")
		end
		p197 = Color3.fromRGB(255, 255, 255)
	end
	p196:modifyTheme({
		"IconLabel",
		"TextColor3",
		p197,
		p198
	})
	return p196
end
function u15.bindToggleItem(p199, p200) 
	if not (p200:IsA("GuiObject") or p200:IsA("LayerCollector")) then
		error("Toggle item must be a GuiObject or LayerCollector!")
	end
	p199.toggleItems[p200] = true
	p199:_updateSelectionInstances()
	return p199
end
function u15.unbindToggleItem(p201, p202) 
	p201.toggleItems[p202] = nil
	p201:_updateSelectionInstances()
	return p201
end
function u15._updateSelectionInstances(p203) 
	for v204, _ in pairs(p203.toggleItems) do
		local v205 = {}
		for _, v206 in pairs(v204:GetDescendants()) do
			if (v206:IsA("TextButton") or v206:IsA("ImageButton")) and v206.Active then
				table.insert(v205, v206)
			end
		end
		p203.toggleItems[v204] = v205
	end
end
function u15._setToggleItemsVisible(p207, p208, _, p209) 
	for v210, _ in pairs(p207.toggleItems) do
		if not p209 or (p209 == p207 or p209.toggleItems[v210] == nil) then
			v210[v210:IsA("LayerCollector") and "Enabled" or "Visible"] = p208
		end
	end
end
function u15.bindEvent(u211, p212, u213) 
	local v214 = u211[p212]
	local v215
	if v214 then
		if typeof(v214) == "table" then
			v215 = v214.Connect
		else
			v215 = false
		end
	else
		v215 = v214
	end
	assert(v215, "argument[1] must be a valid topbarplus icon event name!")
	local v216 = typeof(u213) == "function"
	assert(v216, "argument[2] must be a function!")
	u211.bindedEvents[p212] = v214:Connect(function(...)

		u213(u211, ...)
	end)
	return u211
end
function u15.unbindEvent(p217, p218) 
	local v219 = p217.bindedEvents[p218]
	if v219 then
		v219:Disconnect()
		p217.bindedEvents[p218] = nil
	end
	return p217
end
function u15.bindToggleKey(p220, p221) 
	local v222 = typeof(p221) == "EnumItem"
	assert(v222, "argument[1] must be a KeyCode EnumItem!")
	p220.bindedToggleKeys[p221] = true
	p220.toggleKeyAdded:Fire(p221)
	p220:setCaption("_hotkey_")
	return p220
end
function u15.unbindToggleKey(p223, p224) 
	local v225 = typeof(p224) == "EnumItem"
	assert(v225, "argument[1] must be a KeyCode EnumItem!")
	p223.bindedToggleKeys[p224] = nil
	return p223
end
function u15.call(u226, u227, ...) 
	local u228 = table.pack(...)
	task.spawn(function()

		local v229 = u228
		u227(u226, table.unpack(v229))
	end)
	return u226
end
function u15.addToJanitor(p230, p231, p232, p233) 
	p230.janitor:add(p231, p232, p233)
	return p230
end
function u15.lock(p234) 
	p234:getInstance("ClickRegion").Visible = false
	p234.locked = true
	return p234
end
function u15.unlock(p235) 
	p235:getInstance("ClickRegion").Visible = true
	p235.locked = false
	return p235
end
function u15.debounce(p236, p237) 
	p236:lock()
	task.wait(p237)
	p236:unlock()
	return p236
end
function u15.autoDeselect(p238, p239) 
	p238.deselectWhenOtherIconSelected = p239 == nil and true or p239
	return p238
end
function u15.oneClick(u240, p241) 
	local v242 = u240.singleClickJanitor
	v242:clean()
	if p241 or p241 == nil then
		v242:add(u240.selected:Connect(function()

			u240:deselect("OneClick", u240)
		end))
	end
	u240.oneClickEnabled = true
	return u240
end
function u15.setCaption(p243, p244) 

	if p244 == "_hotkey_" and p243.captionText then
		return p243
	end
	local v245 = p243.captionJanitor
	p243.captionJanitor:clean()
	if not p244 or p244 == "" then
		p243.caption = nil
		p243.captionText = nil
		return p243
	end
	local v246 = v245:add(require(u20.Caption)(p243))
	v246:SetAttribute("CaptionText", p244)
	p243.caption = v246
	p243.captionText = p244
	return p243
end
function u15.setCaptionHint(p247, p248) 
	local v249 = typeof(p248) == "EnumItem"
	assert(v249, "argument[1] must be a KeyCode EnumItem!")
	p247.fakeToggleKey = p248
	p247.fakeToggleKeyChanged:Fire(p248)
	p247:setCaption("_hotkey_")
	return p247
end
function u15.leave(p250) 
	p250.joinJanitor:clean()
	return p250
end
function u15.joinMenu(p251, p252) 

	u11.joinFeature(p251, p252, p252.menuIcons, p252:getInstance("Menu"))
	p252.menuChildAdded:Fire(p251)
	return p251
end
function u15.setMenu(p253, p254) 
	p253.menuSet:Fire(p254)
	return p253
end
function u15.setFixedMenu(p255, p256) 
	p255:freezeMenu(p256)
	p255:setMenu(p256)
end
u15.setFrozenMenu = u15.setFixedMenu
function u15.freezeMenu(u257) 
	u257:select("FrozenMenu", u257)
	u257:bindEvent("deselected", function(p258)

		p258:select("FrozenMenu", u257)
	end)
	u257:modifyTheme({ "IconSpot", "Visible", false })
end
function u15.joinDropdown(p259, p260) 

	p260:getDropdown()
	u11.joinFeature(p259, p260, p260.dropdownIcons, p260:getInstance("DropdownScroller"))
	p260.dropdownChildAdded:Fire(p259)
	return p259
end
function u15.getDropdown(p261) 

	local v262 = p261.dropdown
	if not v262 then
		v262 = require(u20.Dropdown)(p261)
		p261.dropdown = v262
		p261:clipOutside(v262)
	end
	return v262
end
function u15.setDropdown(p263, p264) 
	p263:getDropdown()
	p263.dropdownSet:Fire(p264)
	return p263
end
function u15.clipOutside(p265, p266) 

	local v267 = u11.clipOutside(p265, p266)
	p265:refreshAppearance(p266)
	return p265, v267
end
function u15.setIndicator(p268, p269) 

	if not p268.indicator then
		p268.indicator = p268.janitor:add(require(u20.Indicator)(p268, u15))
	end
	p268.indicatorSet:Fire(p269)
end
function u15.convertLabelToNumberSpinner(u270, u271, u272) 
	task.defer(function()

		local u273 = u270:getInstance("IconLabel")
		u273.Transparency = 1
		u271.Parent = u273.Parent
		u271.Size = UDim2.fromScale(1, 1)
		u271.AnchorPoint = Vector2.new(0.5, 0.5)
		u271.Position = UDim2.new(0.5, 0, 0.5, 0)
		u271.TextXAlignment = Enum.TextXAlignment.Center
		u271.ClipsDescendants = false
		for _, u274 in ipairs({
			"FontFace",
			"BorderSizePixel",
			"BorderColor3",
			"Rotation",
			"TextStrokeTransparency",
			"TextStrokeColor3",
			"TextStrokeTransparency",
			"TextColor3"
		}) do
			u271[u274] = u273[u274]
			u270:addToJanitor(u273:GetPropertyChangedSignal(u274):Connect(function()

				u271[u274] = u273[u274]
			end))
		end
		local function u279() 

			local v275 = 0
			local v276 = 0
			for _, v277 in u271.Frame:GetChildren() do
				local v278 = string.lower(v277.Name)
				if v278 == "digit" then
					v275 = v275 + v277.AbsoluteSize.X
					v276 = v276 + 1
				elseif (v278 == "prefix" or (v278 == "suffix" or v278 == "comma")) and v277.Text ~= "" then
					v275 = v275 + v277.AbsoluteSize.X
					v276 = v276 + 1
				end
			end
			return v275, v276
		end
		local function u288() 

			local v280, v281 = u279()
			if v281 < 18 then
				u270:setLabel(u271.Value)
			end
			local v282 = u271.Frame.AbsoluteSize.X
			while v280 < v282 and u270.isDestroyed ~= true do
				task.wait(0.05)
				if v281 > 0 and v281 < 8 then
					u271.TextSize = u273.TextSize
					break
				end
				local v283 = u271
				v283.TextSize = v283.TextSize + 1
				v282 = u271.Frame.AbsoluteSize.X
				v280, v281 = u279()
			end
			local v284 = u273.Parent
			if v284 then
				v284 = v284.Parent
			end
			local v285
			if v284 == nil then
				v285 = 0
			elseif v284.IconImage.Visible == true then
				v285 = u271.Frame.AbsoluteSize.X + u273.Parent.Parent.IconImage.AbsoluteSize.X
			else
				v285 = v284.AbsoluteSize.X
			end
			while v285 < v280 and u270.isDestroyed ~= true do
				task.wait(0.05)
				if v281 < 8 and v281 > 0 then
					u271.TextSize = u273.TextSize
					return
				end
				local v286 = u271
				v286.TextSize = v286.TextSize - 1
				local v287 = u273.Parent
				if v287 then
					v287 = v287.Parent
				end
				if v287 == nil then
					v285 = 0
				elseif v287.IconImage.Visible == true then
					v285 = u271.Frame.AbsoluteSize.X + u273.Parent.Parent.IconImage.AbsoluteSize.X
				else
					v285 = v287.AbsoluteSize.X
				end
				v280, v281 = u279()
			end
		end
		u270:addToJanitor(u271.Frame.ChildAdded:Connect(u288))
		u270:addToJanitor(u271.Frame.ChildRemoved:Connect(u288))
		u270:addToJanitor(u270.iconAdded:Connect(function()

			task.wait(1)
			u288()
		end))
		u270:updateParent()
		u271.Name = "LabelSpinner"
		u271.Prefix = "$"
		u271.Commas = true
		u271.Decimals = 0
		u271.Duration = 0.25
		u271.Value = 10
		task.wait(0.2)
		local v289 = u272
		if typeof(v289) == "function" then
			u272()
		end
	end)
	return u270
end
function u15.destroy(p290) 

	if not p290.isDestroyed then
		p290:clearNotices()
		if p290.parentIconUID then
			p290:leave()
		end
		p290.isDestroyed = true
		p290.janitor:clean()
		u15.iconRemoved:Fire(p290)
	end
end
u15.Destroy = u15.destroy
return u15