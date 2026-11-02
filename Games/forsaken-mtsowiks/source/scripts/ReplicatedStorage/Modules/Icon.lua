-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

game:GetService("LocalizationService")
local v_u_1 = game:GetService("UserInputService")
local v2 = game:GetService("RunService")
game:GetService("TextService")
local v_u_3 = game:GetService("StarterGui")
local v4 = game:GetService("GuiService")
local v5 = game:GetService("Players")
if v2:IsServer() then
	return {}
end
local v_u_6 = script
local v7 = require(v_u_6.Reference)
local v8 = v7.getObject()
local v9
if v8 then
	v9 = v8.Value
else
	v9 = v8
end
if v9 and v9 ~= v_u_6 then
	return require(v9)
end
if not v8 then
	v7.addToReplicatedStorage()
end
local v_u_10 = require(v_u_6.Packages.GoodSignal)
local v_u_11 = require(v_u_6.Packages.Janitor)
local v_u_12 = require(v_u_6.Utility)
require(v_u_6.Attribute)
local v_u_13 = require(v_u_6.Features.Themes)
local v14 = require(v_u_6.Features.Gamepad)
local v15 = require(v_u_6.Features.Overflow)
local v_u_16 = {}
v_u_16.__index = v_u_16
local v17 = v5.LocalPlayer
local v18 = v_u_6.Features.Themes
local v19 = v17:WaitForChild("PlayerGui")
local v_u_20 = {}
local v_u_21 = v_u_10.new()
local v_u_22 = v_u_6.Elements
local v_u_23 = 0
if v4.TopbarInset.Height == 0 then
	v4:GetPropertyChangedSignal("TopbarInset"):Wait()
end
v_u_16.baseDisplayOrderChanged = v_u_10.new()
v_u_16.baseDisplayOrder = 10
v_u_16.baseTheme = require(v18.Default)
v_u_16.isOldTopbar = v4.TopbarInset.Height == 36
v_u_16.iconsDictionary = v_u_20
v_u_16.container = require(v_u_22.Container)(v_u_16)
v_u_16.topbarEnabled = true
v_u_16.iconAdded = v_u_10.new()
v_u_16.iconRemoved = v_u_10.new()
v_u_16.iconChanged = v_u_10.new()
function v_u_16.getIcons()
	-- upvalues: (copy) v_u_16
	return v_u_16.iconsDictionary
end
function v_u_16.getIconByUID(p24)
	-- upvalues: (copy) v_u_16
	local v25 = v_u_16.iconsDictionary[p24]
	if v25 then
		return v25
	end
end
function v_u_16.getIcon(p26)
	-- upvalues: (copy) v_u_16, (copy) v_u_20
	local v27 = v_u_16.getIconByUID(p26)
	if v27 then
		return v27
	end
	for _, v28 in pairs(v_u_20) do
		if v28.name == p26 then
			return v28
		end
	end
end
function v_u_16.setTopbarEnabled(p29, p30)
	-- upvalues: (copy) v_u_16
	if typeof(p29) ~= "boolean" then
		p29 = v_u_16.topbarEnabled
	end
	if not p30 then
		v_u_16.topbarEnabled = p29
	end
	for _, v31 in pairs(v_u_16.container) do
		v31.Enabled = p29
	end
end
function v_u_16.modifyBaseTheme(p32)
	-- upvalues: (copy) v_u_13, (copy) v_u_16, (copy) v_u_20
	local v33 = v_u_13.getModifications(p32)
	for _, v34 in pairs(v33) do
		for _, v35 in pairs(v_u_16.baseTheme) do
			v_u_13.merge(v35, v34)
		end
	end
	for _, v36 in pairs(v_u_20) do
		v36:setTheme(v_u_16.baseTheme)
	end
end
function v_u_16.setDisplayOrder(p37)
	-- upvalues: (copy) v_u_16
	v_u_16.baseDisplayOrder = p37
	v_u_16.baseDisplayOrderChanged:Fire(p37)
end
task.defer(v14.start, v_u_16)
task.defer(v15.start, v_u_16)
for _, v38 in pairs(v_u_16.container) do
	v38.Parent = v19
end
if v_u_16.isOldTopbar then
	v_u_16.modifyBaseTheme(require(v18.Classic))
end
function v_u_16.new()
	-- upvalues: (copy) v_u_16, (copy) v_u_11, (copy) v_u_12, (copy) v_u_20, (copy) v_u_10, (copy) v_u_6, (copy) v_u_22, (ref) v_u_23, (copy) v_u_1, (copy) v_u_21, (copy) v_u_3
	local v_u_39 = {}
	local v40 = v_u_16
	setmetatable(v_u_39, v40)
	local v41 = v_u_11.new()
	v_u_39.janitor = v41
	v_u_39.themesJanitor = v41:add(v_u_11.new())
	v_u_39.singleClickJanitor = v41:add(v_u_11.new())
	v_u_39.captionJanitor = v41:add(v_u_11.new())
	v_u_39.joinJanitor = v41:add(v_u_11.new())
	v_u_39.menuJanitor = v41:add(v_u_11.new())
	v_u_39.dropdownJanitor = v41:add(v_u_11.new())
	local v_u_42 = v_u_12.generateUID()
	v_u_20[v_u_42] = v_u_39
	v41:add(function()
		-- upvalues: (ref) v_u_20, (copy) v_u_42
		v_u_20[v_u_42] = nil
	end)
	v_u_39.selected = v41:add(v_u_10.new())
	v_u_39.deselected = v41:add(v_u_10.new())
	v_u_39.toggled = v41:add(v_u_10.new())
	v_u_39.viewingStarted = v41:add(v_u_10.new())
	v_u_39.viewingEnded = v41:add(v_u_10.new())
	v_u_39.stateChanged = v41:add(v_u_10.new())
	v_u_39.notified = v41:add(v_u_10.new())
	v_u_39.noticeStarted = v41:add(v_u_10.new())
	v_u_39.noticeChanged = v41:add(v_u_10.new())
	v_u_39.endNotices = v41:add(v_u_10.new())
	v_u_39.toggleKeyAdded = v41:add(v_u_10.new())
	v_u_39.fakeToggleKeyChanged = v41:add(v_u_10.new())
	v_u_39.alignmentChanged = v41:add(v_u_10.new())
	v_u_39.updateSize = v41:add(v_u_10.new())
	v_u_39.resizingComplete = v41:add(v_u_10.new())
	v_u_39.joinedParent = v41:add(v_u_10.new())
	v_u_39.menuSet = v41:add(v_u_10.new())
	v_u_39.dropdownSet = v41:add(v_u_10.new())
	v_u_39.updateMenu = v41:add(v_u_10.new())
	v_u_39.startMenuUpdate = v41:add(v_u_10.new())
	v_u_39.childThemeModified = v41:add(v_u_10.new())
	v_u_39.indicatorSet = v41:add(v_u_10.new())
	v_u_39.dropdownChildAdded = v41:add(v_u_10.new())
	v_u_39.menuChildAdded = v41:add(v_u_10.new())
	v_u_39.iconModule = v_u_6
	v_u_39.UID = v_u_42
	v_u_39.isEnabled = true
	v_u_39.isSelected = false
	v_u_39.isViewing = false
	v_u_39.joinedFrame = false
	v_u_39.parentIconUID = false
	v_u_39.deselectWhenOtherIconSelected = true
	v_u_39.totalNotices = 0
	v_u_39.activeState = "Deselected"
	v_u_39.alignment = ""
	v_u_39.originalAlignment = ""
	v_u_39.appliedTheme = {}
	v_u_39.appearance = {}
	v_u_39.cachedInstances = {}
	v_u_39.cachedNamesToInstances = {}
	v_u_39.cachedCollectives = {}
	v_u_39.bindedToggleKeys = {}
	v_u_39.customBehaviours = {}
	v_u_39.toggleItems = {}
	v_u_39.bindedEvents = {}
	v_u_39.notices = {}
	v_u_39.menuIcons = {}
	v_u_39.dropdownIcons = {}
	v_u_39.childIconsDict = {}
	v_u_39.isOldTopbar = v_u_16.isOldTopbar
	v_u_39.creationTime = os.clock()
	v_u_39.widget = v41:add(require(v_u_22.Widget)(v_u_39, v_u_16))
	v_u_39:setAlignment()
	v_u_23 = v_u_23 + 1
	v_u_39:setOrder(v_u_23)
	v_u_39:setTheme(v_u_16.baseTheme)
	local v43 = v_u_39:getInstance("ClickRegion")
	local v_u_44 = false
	local v_u_45 = false
	v43.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_44, (ref) v_u_45, (copy) v_u_39
		if v_u_44 then
			return
		else
			v_u_45 = true
			task.delay(0.01, function()
				-- upvalues: (ref) v_u_45
				v_u_45 = false
			end)
			if v_u_39.locked then
				return
			elseif v_u_39.isSelected then
				v_u_39:deselect("User", v_u_39)
			else
				v_u_39:select("User", v_u_39)
			end
		end
	end)
	v43.TouchTap:Connect(function()
		-- upvalues: (ref) v_u_45, (ref) v_u_44, (copy) v_u_39
		if v_u_45 then
			return
		else
			v_u_44 = true
			task.delay(0.01, function()
				-- upvalues: (ref) v_u_44
				v_u_44 = false
			end)
			if v_u_39.locked then
				return
			elseif v_u_39.isSelected then
				v_u_39:deselect("User", v_u_39)
			else
				v_u_39:select("User", v_u_39)
			end
		end
	end)
	v41:add(v_u_1.InputBegan:Connect(function(p46, p47)
		-- upvalues: (copy) v_u_39
		if not v_u_39.locked then
			if v_u_39.bindedToggleKeys[p46.KeyCode] and not p47 then
				if v_u_39.locked then
					return
				end
				if v_u_39.isSelected then
					v_u_39:deselect("User", v_u_39)
					return
				end
				v_u_39:select("User", v_u_39)
			end
		end
	end))
	local function v48()
		-- upvalues: (copy) v_u_39
		if not v_u_39.locked then
			v_u_39.isViewing = false
			v_u_39.viewingEnded:Fire(true)
			v_u_39:setState(nil, "User", v_u_39)
		end
	end
	v_u_39.joinedParent:Connect(function()
		-- upvalues: (copy) v_u_39
		if v_u_39.isViewing then
			if v_u_39.locked then
				return
			end
			v_u_39.isViewing = false
			v_u_39.viewingEnded:Fire(true)
			v_u_39:setState(nil, "User", v_u_39)
		end
	end)
	v43.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_1, (copy) v_u_39
		local v49 = not v_u_1.KeyboardEnabled
		if not v_u_39.locked then
			v_u_39.isViewing = true
			v_u_39.viewingStarted:Fire(true)
			if not v49 then
				v_u_39:setState("Viewing", "User", v_u_39)
			end
		end
	end)
	local v_u_50 = 0
	v41:add(v_u_1.TouchEnded:Connect(v48))
	v43.MouseLeave:Connect(v48)
	v43.SelectionGained:Connect(function(p51)
		-- upvalues: (copy) v_u_39
		if not v_u_39.locked then
			v_u_39.isViewing = true
			v_u_39.viewingStarted:Fire(true)
			if not p51 then
				v_u_39:setState("Viewing", "User", v_u_39)
			end
		end
	end)
	v43.SelectionLost:Connect(v48)
	v43.MouseButton1Down:Connect(function()
		-- upvalues: (copy) v_u_39, (ref) v_u_1, (ref) v_u_50
		if not v_u_39.locked and v_u_1.TouchEnabled then
			v_u_50 = v_u_50 + 1
			local v_u_52 = v_u_50
			task.delay(0.2, function()
				-- upvalues: (copy) v_u_52, (ref) v_u_50, (ref) v_u_39
				if v_u_52 == v_u_50 then
					if v_u_39.locked then
						return
					end
					v_u_39.isViewing = true
					v_u_39.viewingStarted:Fire(true)
					v_u_39:setState("Viewing", "User", v_u_39)
				end
			end)
		end
	end)
	v43.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_50
		v_u_50 = v_u_50 + 1
	end)
	local v_u_53 = v_u_39:getInstance("IconOverlay")
	v_u_39.viewingStarted:Connect(function()
		-- upvalues: (copy) v_u_53, (copy) v_u_39
		v_u_53.Visible = not v_u_39.overlayDisabled
	end)
	v_u_39.viewingEnded:Connect(function()
		-- upvalues: (copy) v_u_53
		v_u_53.Visible = false
	end)
	v41:add(v_u_21:Connect(function(p54)
		-- upvalues: (copy) v_u_39
		if p54 ~= v_u_39 and (v_u_39.deselectWhenOtherIconSelected and p54.deselectWhenOtherIconSelected) then
			v_u_39:deselect("AutoDeselect", p54)
		end
	end))
	local v55 = debug.info(2, "s")
	local v56 = string.split(v55, ".")
	local v57 = game
	local v58 = nil
	for _, v59 in pairs(v56) do
		v57 = v57:FindFirstChild(v59)
		if not v57 then
			break
		end
		if v57:IsA("ScreenGui") then
			v58 = v57
		end
	end
	if v57 and (v58 and v58.ResetOnSpawn == true) then
		v_u_12.localPlayerRespawned(function()
			-- upvalues: (copy) v_u_39
			v_u_39:destroy()
		end)
	end
	v_u_39:getInstance("NoticeLabel")
	v_u_39.toggled:Connect(function(p60)
		-- upvalues: (copy) v_u_39, (ref) v_u_16
		v_u_39.noticeChanged:Fire(v_u_39.totalNotices)
		for v61, _ in pairs(v_u_39.childIconsDict) do
			local v62 = v_u_16.getIconByUID(v61)
			v62.noticeChanged:Fire(v62.totalNotices)
			if not p60 and v62.isSelected then
				for _, _ in pairs(v62.childIconsDict) do
					v62:deselect("HideParentFeature", v_u_39)
				end
			end
		end
	end)
	v_u_39.selected:Connect(function()
		-- upvalues: (copy) v_u_39, (ref) v_u_3
		if #v_u_39.dropdownIcons > 0 then
			if v_u_3:GetCore("ChatActive") and v_u_39.alignment ~= "Right" then
				v_u_39.chatWasPreviouslyActive = true
				v_u_3:SetCore("ChatActive", false)
			end
			if v_u_3:GetCoreGuiEnabled("PlayerList") and v_u_39.alignment ~= "Left" then
				v_u_39.playerlistWasPreviouslyActive = true
				v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			end
		end
	end)
	v_u_39.deselected:Connect(function()
		-- upvalues: (copy) v_u_39, (ref) v_u_3
		if v_u_39.chatWasPreviouslyActive then
			v_u_39.chatWasPreviouslyActive = nil
			v_u_3:SetCore("ChatActive", true)
		end
		if v_u_39.playerlistWasPreviouslyActive then
			v_u_39.playerlistWasPreviouslyActive = nil
			v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end
	end)
	task.delay(0.1, function()
		-- upvalues: (copy) v_u_39
		if v_u_39.activeState == "Deselected" then
			v_u_39.stateChanged:Fire("Deselected")
			v_u_39:refresh()
		end
	end)
	v_u_16.iconAdded:Fire(v_u_39)
	return v_u_39
end
function v_u_16.setName(p63, p64)
	p63.widget.Name = p64
	p63.name = p64
	return p63
end
function v_u_16.setState(p65, p66, p67, p68)
	-- upvalues: (copy) v_u_12, (copy) v_u_21
	local v69 = p66 or (p65.isSelected and "Selected" or "Deselected")
	local v70 = v_u_12.formatStateName(v69)
	if p65.activeState ~= v70 then
		local v71 = p65.isSelected
		p65.activeState = v70
		if v70 == "Deselected" then
			p65.isSelected = false
			if v71 then
				p65.toggled:Fire(false, p67, p68)
				p65.deselected:Fire(p67, p68)
			end
			p65:_setToggleItemsVisible(false, p67, p68)
		elseif v70 == "Selected" then
			p65.isSelected = true
			if not v71 then
				p65.toggled:Fire(true, p67, p68)
				p65.selected:Fire(p67, p68)
				v_u_21:Fire(p65, p67, p68)
			end
			p65:_setToggleItemsVisible(true, p67, p68)
		end
		p65.stateChanged:Fire(v70, p67, p68)
	end
end
function v_u_16.getInstance(p_u_72, p_u_73)
	-- upvalues: (copy) v_u_13
	local v74 = p_u_72.cachedNamesToInstances[p_u_73]
	if v74 then
		return v74
	end
	local function v_u_78(p_u_75, p_u_76)
		-- upvalues: (copy) p_u_72
		if not p_u_72.cachedInstances[p_u_76] then
			local v77 = p_u_76:GetAttribute("Collective")
			if v77 then
				v77 = p_u_72.cachedCollectives[v77]
			end
			if v77 then
				table.insert(v77, p_u_76)
			end
			p_u_72.cachedNamesToInstances[p_u_75] = p_u_76
			p_u_72.cachedInstances[p_u_76] = true
			p_u_76.Destroying:Once(function()
				-- upvalues: (ref) p_u_72, (copy) p_u_75, (copy) p_u_76
				p_u_72.cachedNamesToInstances[p_u_75] = nil
				p_u_72.cachedInstances[p_u_76] = nil
			end)
		end
	end
	local v79 = p_u_72.widget
	v_u_78("Widget", v79)
	if p_u_73 == "Widget" then
		return v79
	end
	local v_u_80 = nil
	local function v_u_86(p81)
		-- upvalues: (copy) p_u_72, (ref) v_u_13, (copy) v_u_86, (copy) v_u_78, (copy) p_u_73, (ref) v_u_80
		for _, v82 in pairs(p81:GetChildren()) do
			local v83 = v82:GetAttribute("WidgetUID")
			if not v83 or v83 == p_u_72.UID then
				local v84 = v_u_13.getRealInstance(v82) or v82
				v_u_86(v84)
				if v84:IsA("GuiBase") or (v84:IsA("UIBase") or v84:IsA("ValueBase")) then
					local v85 = v84.Name
					v_u_78(v85, v84)
					if v85 == p_u_73 then
						v_u_80 = v84
					end
				end
			end
		end
	end
	v_u_86(v79)
	return v_u_80
end
function v_u_16.getCollective(p87, p88)
	local v89 = p87.cachedCollectives[p88]
	if v89 then
		return v89
	end
	local v90 = {}
	for v91, _ in pairs(p87.cachedInstances) do
		if v91:GetAttribute("Collective") == p88 then
			table.insert(v90, v91)
		end
	end
	p87.cachedCollectives[p88] = v90
	return v90
end
function v_u_16.getInstanceOrCollective(p92, p93)
	local v94 = {}
	local v95 = p92:getInstance(p93)
	if v95 then
		table.insert(v94, v95)
	end
	if #v94 == 0 then
		v94 = p92:getCollective(p93)
	end
	return v94
end
function v_u_16.getStateGroup(p96, p97)
	local v98 = p97 or p96.activeState
	local v99 = p96.appearance[v98]
	if not v99 then
		v99 = {}
		p96.appearance[v98] = v99
	end
	return v99
end
function v_u_16.refreshAppearance(p100, p101, p102)
	-- upvalues: (copy) v_u_13
	v_u_13.refresh(p100, p101, p102)
	return p100
end
function v_u_16.refresh(p103)
	p103:refreshAppearance(p103.widget)
	p103.updateSize:Fire()
	return p103
end
function v_u_16.updateParent(p104)
	-- upvalues: (copy) v_u_16
	local v105 = v_u_16.getIconByUID(p104.parentIconUID)
	if v105 then
		v105.updateSize:Fire()
	end
end
function v_u_16.setBehaviour(p106, p107, p108, p109, p110)
	local v111 = p107 .. "-" .. p108
	p106.customBehaviours[v111] = p109
	if p110 then
		local v112 = p106:getInstanceOrCollective(p107)
		for _, v113 in pairs(v112) do
			p106:refreshAppearance(v113, p108)
		end
	end
end
function v_u_16.modifyTheme(p114, p115, p116)
	-- upvalues: (copy) v_u_13
	return p114, v_u_13.modify(p114, p115, p116)
end
function v_u_16.modifyChildTheme(p117, p118, p119)
	-- upvalues: (copy) v_u_16
	p117.childModifications = p118
	p117.childModificationsUID = p119
	for v120, _ in pairs(p117.childIconsDict) do
		v_u_16.getIconByUID(v120):modifyTheme(p118, p119)
	end
	p117.childThemeModified:Fire()
	return p117
end
function v_u_16.removeModification(p121, p122)
	-- upvalues: (copy) v_u_13
	v_u_13.remove(p121, p122)
	return p121
end
function v_u_16.removeModificationWith(p123, p124, p125, p126)
	-- upvalues: (copy) v_u_13
	v_u_13.removeWith(p123, p124, p125, p126)
	return p123
end
function v_u_16.setTheme(p127, p128)
	-- upvalues: (copy) v_u_13
	v_u_13.set(p127, p128)
	return p127
end
function v_u_16.setEnabled(p129, p130)
	p129.isEnabled = p130
	p129.widget.Visible = p130
	p129:updateParent()
	return p129
end
function v_u_16.select(p131, p132, p133)
	p131:setState("Selected", p132, p133)
	return p131
end
function v_u_16.deselect(p134, p135, p136)
	p134:setState("Deselected", p135, p136)
	return p134
end
function v_u_16.notify(p137, p138, p139)
	-- upvalues: (copy) v_u_22, (copy) v_u_16
	if not p137.notice then
		p137.notice = require(v_u_22.Notice)(p137, v_u_16)
	end
	p137.noticeStarted:Fire(p138, p139)
	return p137
end
function v_u_16.clearNotices(p140)
	p140.endNotices:Fire()
	return p140
end
function v_u_16.disableOverlay(p141, p142)
	p141.overlayDisabled = p142
	return p141
end
v_u_16.disableStateOverlay = v_u_16.disableOverlay
function v_u_16.setImage(p143, p144, p145)
	p143:modifyTheme({
		"IconImage",
		"Image",
		p144,
		p145
	})
	return p143
end
function v_u_16.setLabel(p146, p147, p148)
	p146:modifyTheme({
		"IconLabel",
		"Text",
		p147,
		p148
	})
	return p146
end
function v_u_16.setOrder(p149, p150, p151)
	p149:modifyTheme({
		"Widget",
		"LayoutOrder",
		p150,
		p151
	})
	return p149
end
function v_u_16.setCornerRadius(p152, p153, p154)
	p152:modifyTheme({
		"IconCorners",
		"CornerRadius",
		p153,
		p154
	})
	return p152
end
function v_u_16.align(p155, p156, p157)
	-- upvalues: (copy) v_u_16
	local v158 = tostring(p156):lower()
	local v159 = (v158 == "mid" or v158 == "centre") and "center" or v158
	local v160 = v159 ~= "left" and (v159 ~= "center" and v159 ~= "right") and "left" or v159
	local v161 = v160 == "center" and v_u_16.container.TopbarCentered or v_u_16.container.TopbarStandard
	local v162 = v161.Holders
	local v163 = string.upper((string.sub(v160, 1, 1))) .. string.sub(v160, 2)
	if not p157 then
		p155.originalAlignment = v163
	end
	local v164 = p155.joinedFrame
	local v165 = v162[v163]
	p155.screenGui = v161
	p155.alignmentHolder = v165
	if not p155.isDestroyed then
		p155.widget.Parent = v164 or v165
	end
	p155.alignment = v163
	p155.alignmentChanged:Fire(v163)
	v_u_16.iconChanged:Fire(p155)
	return p155
end
v_u_16.setAlignment = v_u_16.align
function v_u_16.setLeft(p166)
	p166:setAlignment("Left")
	return p166
end
function v_u_16.setMid(p167)
	p167:setAlignment("Center")
	return p167
end
function v_u_16.setRight(p168)
	p168:setAlignment("Right")
	return p168
end
function v_u_16.setWidth(p169, p170, p171)
	p169:modifyTheme({
		"Widget",
		"Size",
		UDim2.fromOffset(p170, p169.widget.Size.Y.Offset),
		p171
	})
	p169:modifyTheme({
		"Widget",
		"DesiredWidth",
		p170,
		p171
	})
	return p169
end
function v_u_16.setImageScale(p172, p173, p174)
	p172:modifyTheme({
		"IconImageScale",
		"Value",
		p173,
		p174
	})
	return p172
end
function v_u_16.setImageRatio(p175, p176, p177)
	p175:modifyTheme({
		"IconImageRatio",
		"AspectRatio",
		p176,
		p177
	})
	return p175
end
function v_u_16.setTextSize(p178, p179, p180)
	p178:modifyTheme({
		"IconLabel",
		"TextSize",
		p179,
		p180
	})
	return p178
end
function v_u_16.setTextFont(p181, p182, p183, p184, p185)
	local v186 = p183 or Enum.FontWeight.Regular
	local v187 = p184 or Enum.FontStyle.Normal
	local v188 = nil
	local v189 = typeof(p182)
	if v189 == "number" then
		v188 = Font.fromId(p182, v186, v187)
	elseif v189 == "EnumItem" then
		v188 = Font.fromEnum(p182)
	elseif v189 == "string" and not p182:match("rbxasset") then
		v188 = Font.fromName(p182, v186, v187)
	end
	p181:modifyTheme({
		"IconLabel",
		"FontFace",
		v188 or Font.new(p182, v186, v187),
		p185
	})
	return p181
end
function v_u_16.bindToggleItem(p190, p191)
	if not (p191:IsA("GuiObject") or p191:IsA("LayerCollector")) then
		error("Toggle item must be a GuiObject or LayerCollector!")
	end
	p190.toggleItems[p191] = true
	p190:_updateSelectionInstances()
	return p190
end
function v_u_16.unbindToggleItem(p192, p193)
	p192.toggleItems[p193] = nil
	p192:_updateSelectionInstances()
	return p192
end
function v_u_16._updateSelectionInstances(p194)
	for v195, _ in pairs(p194.toggleItems) do
		local v196 = {}
		for _, v197 in pairs(v195:GetDescendants()) do
			if (v197:IsA("TextButton") or v197:IsA("ImageButton")) and v197.Active then
				table.insert(v196, v197)
			end
		end
		p194.toggleItems[v195] = v196
	end
end
function v_u_16._setToggleItemsVisible(p198, p199, _, p200)
	for v201, _ in pairs(p198.toggleItems) do
		if not p200 or (p200 == p198 or p200.toggleItems[v201] == nil) then
			v201[v201:IsA("LayerCollector") and "Enabled" or "Visible"] = p199
		end
	end
end
function v_u_16.bindEvent(p_u_202, p203, p_u_204)
	local v205 = p_u_202[p203]
	local v206
	if v205 then
		if typeof(v205) == "table" then
			v206 = v205.Connect
		else
			v206 = false
		end
	else
		v206 = v205
	end
	assert(v206, "argument[1] must be a valid topbarplus icon event name!")
	local v207 = typeof(p_u_204) == "function"
	assert(v207, "argument[2] must be a function!")
	p_u_202.bindedEvents[p203] = v205:Connect(function(...)
		-- upvalues: (copy) p_u_204, (copy) p_u_202
		p_u_204(p_u_202, ...)
	end)
	return p_u_202
end
function v_u_16.unbindEvent(p208, p209)
	local v210 = p208.bindedEvents[p209]
	if v210 then
		v210:Disconnect()
		p208.bindedEvents[p209] = nil
	end
	return p208
end
function v_u_16.bindToggleKey(p211, p212)
	local v213 = typeof(p212) == "EnumItem"
	assert(v213, "argument[1] must be a KeyCode EnumItem!")
	p211.bindedToggleKeys[p212] = true
	p211.toggleKeyAdded:Fire(p212)
	p211:setCaption("_hotkey_")
	return p211
end
function v_u_16.unbindToggleKey(p214, p215)
	local v216 = typeof(p215) == "EnumItem"
	assert(v216, "argument[1] must be a KeyCode EnumItem!")
	p214.bindedToggleKeys[p215] = nil
	return p214
end
function v_u_16.call(p_u_217, p_u_218, ...)
	local v_u_219 = table.pack(...)
	task.spawn(function()
		-- upvalues: (copy) p_u_218, (copy) p_u_217, (copy) v_u_219
		local v220 = v_u_219
		p_u_218(p_u_217, table.unpack(v220))
	end)
	return p_u_217
end
function v_u_16.addToJanitor(p221, p222)
	p221.janitor:add(p222)
	return p221
end
function v_u_16.lock(p223)
	p223:getInstance("ClickRegion").Visible = false
	p223.locked = true
	return p223
end
function v_u_16.unlock(p224)
	p224:getInstance("ClickRegion").Visible = true
	p224.locked = false
	return p224
end
function v_u_16.debounce(p225, p226)
	p225:lock()
	task.wait(p226)
	p225:unlock()
	return p225
end
function v_u_16.autoDeselect(p227, p228)
	p227.deselectWhenOtherIconSelected = p228 == nil and true or p228
	return p227
end
function v_u_16.oneClick(p_u_229, p230)
	local v231 = p_u_229.singleClickJanitor
	v231:clean()
	if p230 or p230 == nil then
		v231:add(p_u_229.selected:Connect(function()
			-- upvalues: (copy) p_u_229
			p_u_229:deselect("OneClick", p_u_229)
		end))
	end
	p_u_229.oneClickEnabled = true
	return p_u_229
end
function v_u_16.setCaption(p232, p233)
	-- upvalues: (copy) v_u_22
	if p233 == "_hotkey_" and p232.captionText then
		return p232
	end
	local v234 = p232.captionJanitor
	p232.captionJanitor:clean()
	if not p233 or p233 == "" then
		p232.caption = nil
		p232.captionText = nil
		return p232
	end
	local v235 = v234:add(require(v_u_22.Caption)(p232))
	v235:SetAttribute("CaptionText", p233)
	p232.caption = v235
	p232.captionText = p233
	return p232
end
function v_u_16.setCaptionHint(p236, p237)
	local v238 = typeof(p237) == "EnumItem"
	assert(v238, "argument[1] must be a KeyCode EnumItem!")
	p236.fakeToggleKey = p237
	p236.fakeToggleKeyChanged:Fire(p237)
	p236:setCaption("_hotkey_")
	return p236
end
function v_u_16.leave(p239)
	p239.joinJanitor:clean()
	return p239
end
function v_u_16.joinMenu(p240, p241)
	-- upvalues: (copy) v_u_12
	v_u_12.joinFeature(p240, p241, p241.menuIcons, p241:getInstance("Menu"))
	p241.menuChildAdded:Fire(p240)
	return p240
end
function v_u_16.setMenu(p242, p243)
	p242.menuSet:Fire(p243)
	return p242
end
function v_u_16.setFrozenMenu(p244, p245)
	p244:freezeMenu(p245)
	p244:setMenu(p245)
end
function v_u_16.freezeMenu(p_u_246)
	p_u_246:select("FrozenMenu", p_u_246)
	p_u_246:bindEvent("deselected", function(p247)
		-- upvalues: (copy) p_u_246
		p247:select("FrozenMenu", p_u_246)
	end)
	p_u_246:modifyTheme({ "IconSpot", "Visible", false })
end
function v_u_16.joinDropdown(p248, p249)
	-- upvalues: (copy) v_u_12
	p249:getDropdown()
	v_u_12.joinFeature(p248, p249, p249.dropdownIcons, p249:getInstance("DropdownScroller"))
	p249.dropdownChildAdded:Fire(p248)
	return p248
end
function v_u_16.getDropdown(p250)
	-- upvalues: (copy) v_u_22
	local v251 = p250.dropdown
	if not v251 then
		v251 = require(v_u_22.Dropdown)(p250)
		p250.dropdown = v251
		p250:clipOutside(v251)
	end
	return v251
end
function v_u_16.setDropdown(p252, p253)
	p252:getDropdown()
	p252.dropdownSet:Fire(p253)
	return p252
end
function v_u_16.clipOutside(p254, p255)
	-- upvalues: (copy) v_u_12
	local v256 = v_u_12.clipOutside(p254, p255)
	p254:refreshAppearance(p255)
	return p254, v256
end
function v_u_16.setIndicator(p257, p258)
	-- upvalues: (copy) v_u_22, (copy) v_u_16
	if not p257.indicator then
		p257.indicator = p257.janitor:add(require(v_u_22.Indicator)(p257, v_u_16))
	end
	p257.indicatorSet:Fire(p258)
end
function v_u_16.destroy(p259)
	-- upvalues: (copy) v_u_16
	if not p259.isDestroyed then
		p259:clearNotices()
		if p259.parentIconUID then
			p259:leave()
		end
		p259.isDestroyed = true
		p259.janitor:clean()
		v_u_16.iconRemoved:Fire(p259)
	end
end
v_u_16.Destroy = v_u_16.destroy
return v_u_16
