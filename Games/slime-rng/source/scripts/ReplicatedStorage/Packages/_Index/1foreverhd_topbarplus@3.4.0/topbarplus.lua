-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: topbarplus, time of decompilation: Sun May  3 10:09:27 2026 ]]
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

require(script.Types)

local _script = script
local Reference = require(_script.Reference)
local v7 = Reference.getObject()
local v8 = v7 and v7.Value

if v8 and v8 ~= _script then
	return (require(v8))
end

if not v7 then
	Reference.addToReplicatedStorage()
end

local GoodSignal = require(_script.Packages.GoodSignal)
local Janitor = require(_script.Packages.Janitor)
local Utility = require(_script.Utility)
local Themes = require(_script.Features.Themes)
local Gamepad = require(_script.Features.Gamepad)
local Overflow = require(_script.Features.Overflow)
local t1 = {}

t1.__index = t1

local LocalPlayer = Players.LocalPlayer
local Themes2 = _script.Features.Themes
local t2 = {}
local v19 = GoodSignal.new()
local Elements = _script.Elements
local n1 = 0
local t3 = {
	mobile = Enum.PreferredInput.Touch,
	desktop = Enum.PreferredInput.KeyboardAndMouse,
	console = Enum.PreferredInput.Gamepad
}

t1.baseDisplayOrderChanged = GoodSignal.new()
t1.baseDisplayOrder = 10
t1.baseTheme = require(Themes2.Default)
t1.isOldTopbar = false
t1.iconsDictionary = t2
t1.insetHeightChanged = GoodSignal.new()
t1.container = require(Elements.Container)(t1)
t1.topbarEnabled = true
t1.iconAdded = GoodSignal.new()
t1.iconRemoved = GoodSignal.new()
t1.iconChanged = GoodSignal.new()

function t1.getIcons() -- line: 110
	-- upvalues: t1 (copy)
	return t1.iconsDictionary
end
function t1.getIconByUID(p1) -- line: 114
	-- upvalues: t1 (copy)
	local v24 = t1.iconsDictionary[p1]

	if v24 then
		return v24
	end

	return nil
end
function t1.getIcon(p2) -- line: 122
	-- upvalues: t1 (copy), t2 (copy)
	local v26 = t1.getIconByUID(p2)

	if v26 then
		return v26
	end

	for _, v in pairs(t2) do
		if p2 == v.name then
			return v
		end
	end

	return nil
end
function t1.setTopbarEnabled(p3, p4) -- line: 135
	-- upvalues: t1 (copy)
	if typeof(p3) ~= "boolean" then
		p3 = t1.topbarEnabled
	end

	if not p4 then
		t1.topbarEnabled = p3
	end

	for _, v in pairs(t1.container) do
		v.Enabled = p3
	end
end
function t1.modifyBaseTheme(p5) -- line: 147
	-- upvalues: Themes (copy), t1 (copy), t2 (copy)
	local v34 = Themes.getModifications(p5)

	for _, v in pairs(v34) do
		for _, v2 in pairs(t1.baseTheme) do
			Themes.merge(v2, v)
		end
	end

	for _, v in pairs(t2) do
		v:setTheme(t1.baseTheme)
	end
end
function t1.setDisplayOrder(p6) -- line: 159
	-- upvalues: t1 (copy)
	t1.baseDisplayOrder = p6
	t1.baseDisplayOrderChanged:Fire(p6)
end

task.defer(Gamepad.start, t1)
task.defer(Overflow.start, t1)
task.defer(function() -- line: 169
	-- upvalues: LocalPlayer (copy), t1 (copy), _script (copy)
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

	for _, v in pairs(t1.container) do
		v.Parent = PlayerGui
	end

	require(_script.Attribute)
end)

function t1.new() -- line: 180
	-- upvalues: t1 (copy), Janitor (copy), Utility (copy), t2 (copy), GoodSignal (copy), _script (copy), Elements (copy), n1 (ref), UserInputService (copy), t3 (copy), v19 (copy), StarterGui (copy)
	local t4 = {}

	setmetatable(t4, t1)

	local v46 = Janitor.new()

	t4.janitor = v46
	t4.themesJanitor = v46:add(Janitor.new())
	t4.singleClickJanitor = v46:add(Janitor.new())
	t4.captionJanitor = v46:add(Janitor.new())
	t4.joinJanitor = v46:add(Janitor.new())
	t4.menuJanitor = v46:add(Janitor.new())
	t4.dropdownJanitor = v46:add(Janitor.new())

	local v47 = Utility.generateUID()

	t2[v47] = t4
	v46:add(function() -- line: 197
		-- upvalues: t2 (copy), v47 (copy)
		t2[v47] = nil
	end)
	t4.selected = v46:add(GoodSignal.new())
	t4.deselected = v46:add(GoodSignal.new())
	t4.toggled = v46:add(GoodSignal.new())
	t4.viewingStarted = v46:add(GoodSignal.new())
	t4.viewingEnded = v46:add(GoodSignal.new())
	t4.stateChanged = v46:add(GoodSignal.new())
	t4.notified = v46:add(GoodSignal.new())
	t4.noticeStarted = v46:add(GoodSignal.new())
	t4.noticeChanged = v46:add(GoodSignal.new())
	t4.endNotices = v46:add(GoodSignal.new())
	t4.toggleKeyAdded = v46:add(GoodSignal.new())
	t4.fakeToggleKeyChanged = v46:add(GoodSignal.new())
	t4.alignmentChanged = v46:add(GoodSignal.new())
	t4.updateSize = v46:add(GoodSignal.new())
	t4.resizingComplete = v46:add(GoodSignal.new())
	t4.joinedParent = v46:add(GoodSignal.new())
	t4.menuSet = v46:add(GoodSignal.new())
	t4.dropdownSet = v46:add(GoodSignal.new())
	t4.updateMenu = v46:add(GoodSignal.new())
	t4.startMenuUpdate = v46:add(GoodSignal.new())
	t4.childThemeModified = v46:add(GoodSignal.new())
	t4.indicatorSet = v46:add(GoodSignal.new())
	t4.dropdownChildAdded = v46:add(GoodSignal.new())
	t4.menuChildAdded = v46:add(GoodSignal.new())
	t4.iconModule = _script
	t4.UID = v47
	t4.isEnabled = true
	t4.enabled = t4.isEnabled
	t4.isSelected = false
	t4.isViewing = false
	t4.joinedFrame = false
	t4.parentIconUID = false
	t4.deselectWhenOtherIconSelected = true
	t4.totalNotices = 0
	t4.activeState = "Deselected"
	t4.alignment = ""
	t4.originalAlignment = ""
	t4.appliedTheme = {}
	t4.appearance = {}
	t4.cachedInstances = {}
	t4.cachedNamesToInstances = {}
	t4.cachedCollectives = {}
	t4.bindedToggleKeys = {}
	t4.customBehaviours = {}
	t4.toggleItems = {}
	t4.bindedEvents = {}
	t4.notices = {}
	t4.menuIcons = {}
	t4.dropdownIcons = {}
	t4.childIconsDict = {}
	t4.creationTime = os.clock()
	t4.widget = v46:add(require(Elements.Widget)(t4, t1))
	t4:setAlignment()
	n1 += 1

	local v48 = n1 * 0.01 + 1

	t4:setOrder(v48, "deselected")
	t4:setOrder(v48, "selected")
	t4:setTheme(t1.baseTheme)

	local v49 = t4:getInstance("ClickRegion")
	local u50 = false
	local n2 = 0

	v49.MouseButton1Click:Connect(function() -- line: 296
		-- upvalues: u50 (ref), t4 (copy), n2 (ref)
		u50 = true

		if t4.locked then
			return
		end

		local timestamp = tick()

		if timestamp - n2 < 0.1 then
			return
		end

		n2 = timestamp

		if t4.isSelected then
			t4:deselect("User", t4)

			return
		end

		t4:select("User", t4)
	end)
	v49.TouchTap:Connect(function() -- line: 301
		-- upvalues: u50 (ref), t4 (copy), n2 (ref)
		if not u50 then
			if t4.locked then
				return
			end

			local timestamp = tick()

			if timestamp - n2 < 0.1 then
				return
			end

			n2 = timestamp

			if t4.isSelected then
				t4:deselect("User", t4)

				return
			end

			t4:select("User", t4)
		end
	end)
	v46:add(UserInputService.InputBegan:Connect(function(input, p7) -- line: 314
		-- upvalues: t4 (copy), n2 (ref)
		if t4.locked then
			return
		end

		if t4.bindedToggleKeys[input.KeyCode] and not p7 then
			if t4.locked then
				return
			end

			local timestamp = tick()

			if timestamp - n2 < 0.1 then
				return
			end

			n2 = timestamp

			if t4.isSelected then
				t4:deselect("User", t4)

				return
			end

			t4:select("User", t4)
		end
	end))

	local function viewingEnded() -- line: 336
		-- upvalues: t4 (copy)
		if t4.locked then
			return
		end

		t4.isViewing = false
		t4.viewingEnded:Fire(true)
		t4:setState(nil, "User", t4)
	end

	t4.joinedParent:Connect(function() -- line: 344
		-- upvalues: t4 (copy)
		if t4.isViewing then
			if t4.locked then
				return
			end

			t4.isViewing = false
			t4.viewingEnded:Fire(true)
			t4:setState(nil, "User", t4)
		end
	end)
	v49.MouseEnter:Connect(function() -- line: 349
		-- upvalues: UserInputService (copy), t3 (copy), t4 (copy)
		local v264 = UserInputService.PreferredInput ~= t3.desktop

		if t4.locked then
			return
		end

		t4.isViewing = true
		t4.viewingStarted:Fire(true)

		if not v264 then
			t4:setState("Viewing", "User", t4)
		end
	end)

	local n3 = 0

	v46:add(UserInputService.TouchEnded:Connect(viewingEnded))
	v49.MouseLeave:Connect(viewingEnded)
	v49.SelectionGained:Connect(function(p8) --[[ viewingStarted ]] -- line: 326
		-- upvalues: t4 (copy)
		if t4.locked then
			return
		end

		t4.isViewing = true
		t4.viewingStarted:Fire(true)

		if not p8 then
			t4:setState("Viewing", "User", t4)
		end
	end)
	v49.SelectionLost:Connect(viewingEnded)
	v49.MouseButton1Down:Connect(function() -- line: 358
		-- upvalues: t4 (copy), UserInputService (copy), t3 (copy), n3 (ref)
		if not t4.locked and UserInputService.PreferredInput == t3.mobile then
			n3 += 1

			local v265 = n3

			task.delay(0.2, function() -- line: 362
				-- upvalues: v265 (copy), n3 (ref), t4 (copy)
				if v265 == n3 then
					if t4.locked then
						return
					end

					t4.isViewing = true
					t4.viewingStarted:Fire(true)
					t4:setState("Viewing", "User", t4)
				end
			end)
		end
	end)
	v49.MouseButton1Up:Connect(function() -- line: 369
		-- upvalues: n3 (ref)
		n3 += 1
	end)

	local v54 = t4:getInstance("IconOverlay")

	t4.viewingStarted:Connect(function() -- line: 375
		-- upvalues: v54 (copy), t4 (copy)
		v54.Visible = not t4.overlayDisabled
	end)
	t4.viewingEnded:Connect(function() -- line: 378
		-- upvalues: v54 (copy)
		v54.Visible = false
	end)
	v46:add(v19:Connect(function(p9) -- line: 383
		-- upvalues: t4 (copy)
		if p9 ~= t4 and (t4.deselectWhenOtherIconSelected and p9.deselectWhenOtherIconSelected) then
			t4:deselect("AutoDeselect", p9)
		end
	end))

	local v55 = debug.info(2, "s")
	local parts = string.split(v55, ".")
	local _game = game
	local v58 = nil

	for _, v in pairs(parts) do
		_game = _game:FindFirstChild(v)

		if not _game then
			break
		end

		if _game:IsA("ScreenGui") then
			v58 = _game
		end
	end

	if _game and v58 and v58.ResetOnSpawn == true then
		t4.originsScreenGui = v58
		Utility.localPlayerRespawned(function() -- line: 409
			-- upvalues: t4 (copy)
			t4:destroy()
		end)
	end

	t4.toggled:Connect(function(p10) -- line: 415
		-- upvalues: t4 (copy), t1 (copy)
		t4.noticeChanged:Fire(t4.totalNotices)

		for k, _ in pairs(t4.childIconsDict) do
			local v270 = t1.getIconByUID(k)

			v270.noticeChanged:Fire(v270.totalNotices)

			if not p10 and v270.isSelected then
				for _, _ in pairs(v270.childIconsDict) do
					v270:deselect("HideParentFeature", t4)
				end
			end
		end
	end)
	t4.selected:Connect(function() -- line: 438
		-- upvalues: t4 (copy), StarterGui (copy)
		if #t4.dropdownIcons > 0 then
			if StarterGui:GetCore("ChatActive") and t4.alignment ~= "Right" then
				t4.chatWasPreviouslyActive = true
				StarterGui:SetCore("ChatActive", false)
			end

			if StarterGui:GetCoreGuiEnabled("PlayerList") and t4.alignment ~= "Left" then
				t4.playerlistWasPreviouslyActive = true
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			end
		end
	end)
	t4.deselected:Connect(function() -- line: 451
		-- upvalues: t4 (copy), StarterGui (copy)
		if t4.chatWasPreviouslyActive then
			t4.chatWasPreviouslyActive = nil
			StarterGui:SetCore("ChatActive", true)
		end

		if t4.playerlistWasPreviouslyActive then
			t4.playerlistWasPreviouslyActive = nil
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end
	end)
	task.delay(0.1, function() -- line: 465
		-- upvalues: t4 (copy)
		if t4.activeState == "Deselected" then
			t4.stateChanged:Fire("Deselected")
			t4:refresh()
		end
	end)
	t1.iconAdded:Fire(t4)

	return t4
end
function t1.setName(p11, p12) -- line: 481
	p11.widget.Name = p12
	p11.name = p12

	return p11
end
function t1.setState(p13, p14, p15, p16) -- line: 487
	-- upvalues: Utility (copy), v19 (copy)
	if not p14 then
		p14 = not p13.isSelected and "Deselected" or "Selected"
	end

	local v67 = Utility.formatStateName(p14)

	if v67 == p13.activeState then
		return
	end

	local isSelected = p13.isSelected

	p13.activeState = v67

	if v67 == "Deselected" then
		p13.isSelected = false

		if isSelected then
			p13.toggled:Fire(false, p15, p16)
			p13.deselected:Fire(p15, p16)
		end

		p13:_setToggleItemsVisible(false, p15, p16)
	elseif v67 == "Selected" then
		p13.isSelected = true

		if not isSelected then
			p13.toggled:Fire(true, p15, p16)
			p13.selected:Fire(p15, p16)
			v19:Fire(p13, p15, p16)
		end

		p13:_setToggleItemsVisible(true, p15, p16)
	end

	p13.stateChanged:Fire(v67, p15, p16)
end
function t1.getInstance(p17, p18) -- line: 520
	-- upvalues: Themes (copy)
	local v71 = p17.cachedNamesToInstances[p18]

	if v71 then
		return v71
	end

	local function cacheInstance(p19, p20) -- line: 528
		-- upvalues: p17 (copy)
		if not p17.cachedInstances[p20] then
			local Collective = p20:GetAttribute("Collective")
			local v276 = Collective and p17.cachedCollectives[Collective]

			if v276 then
				table.insert(v276, p20)
			end

			p17.cachedNamesToInstances[p19] = p20
			p17.cachedInstances[p20] = true
			p20.Destroying:Once(function() -- line: 538
				-- upvalues: p17 (copy), p19 (copy), p20 (copy)
				p17.cachedNamesToInstances[p19] = nil
				p17.cachedInstances[p20] = nil
			end)
		end
	end

	local widget = p17.widget

	cacheInstance("Widget", widget)

	if p18 == "Widget" then
		return widget
	end

	local u74 = nil

	local function scanChildren(p21) -- line: 551
		-- upvalues: p17 (copy), Themes (copy), scanChildren (copy), cacheInstance (copy), p18 (copy), u74 (ref)
		for _, v in pairs(p21:GetChildren()) do
			local v280 = v
			local WidgetUID = v280:GetAttribute("WidgetUID")

			if not WidgetUID or WidgetUID == p17.UID then
				local v282 = Themes.getRealInstance(v280)

				if v282 then
					v280 = v282
				end

				scanChildren(v280)

				if v280:IsA("GuiBase") or v280:IsA("UIBase") or v280:IsA("ValueBase") then
					local Name = v280.Name

					cacheInstance(Name, v280)

					if Name == p18 then
						u74 = v280
					end
				end
			end
		end
	end

	scanChildren(widget)

	return u74
end
function t1.getCollective(p22, p23) -- line: 580
	local v78 = p22.cachedCollectives[p23]

	if v78 then
		return v78
	end

	local t5 = {}

	for k, _ in pairs(p22.cachedInstances) do
		if p23 == k:GetAttribute("Collective") then
			table.insert(t5, k)
		end
	end

	p22.cachedCollectives[p23] = t5

	return t5
end
function t1.getInstanceOrCollective(p24, p25) -- line: 601
	local t6 = {}
	local v85 = p24:getInstance(p25)

	if v85 then
		table.insert(t6, v85)
	end

	if #t6 == 0 then
		t6 = p24:getCollective(p25)
	end

	return t6
end
function t1.getStateGroup(p26, p27) -- line: 615
	local v88 = p27 or p26.activeState
	local v89 = p26.appearance[v88]

	if not v89 then
		v89 = {}
		p26.appearance[v88] = v89
	end

	return v89
end
function t1.refreshAppearance(p28, p29, p30) -- line: 625
	-- upvalues: Themes (copy)
	Themes.refresh(p28, p29, p30)

	return p28
end
function t1.refresh(p31) -- line: 630
	p31:refreshAppearance(p31.widget)
	p31.updateSize:Fire()

	return p31
end
function t1.updateParent(p32) -- line: 636
	-- upvalues: t1 (copy)
	local v95 = t1.getIconByUID(p32.parentIconUID)

	if v95 then
		v95.updateSize:Fire()
	end
end
function t1.setBehaviour(p33, p34, p35, p36, p37) -- line: 643
	local v101 = p34 .. "-" .. p35

	p33.customBehaviours[v101] = p36

	if p37 then
		local v102 = p33:getInstanceOrCollective(p34)

		for _, v in pairs(v102) do
			p33:refreshAppearance(v, p35)
		end
	end
end
function t1.modifyTheme(p38, p39, p40) -- line: 656
	-- upvalues: Themes (copy)
	return p38, (Themes.modify(p38, p39, p40))
end
function t1.modifyChildTheme(p41, p42, p43) -- line: 661
	-- upvalues: t1 (copy)
	p41.childModifications = p42
	p41.childModificationsUID = p43

	for k, _ in pairs(p41.childIconsDict) do
		t1.getIconByUID(k):modifyTheme(p42, p43)
	end

	p41.childThemeModified:Fire()

	return p41
end
function t1.removeModification(p44, p45) -- line: 674
	-- upvalues: Themes (copy)
	Themes.remove(p44, p45)

	return p44
end
function t1.removeModificationWith(p46, p47, p48, p49) -- line: 679
	-- upvalues: Themes (copy)
	Themes.removeWith(p46, p47, p48, p49)

	return p46
end
function t1.setTheme(p50, p51) -- line: 684
	-- upvalues: Themes (copy)
	Themes.set(p50, p51)

	return p50
end
function t1.setEnabled(p52, p53) -- line: 689
	p52.isEnabled = p53
	p52.enabled = p52.isEnabled
	p52.widget.Visible = p53
	p52:updateParent()

	return p52
end
function t1.select(p54, p55, p56) -- line: 697
	p54:setState("Selected", p55, p56)

	return p54
end
function t1.deselect(p57, p58, p59) -- line: 702
	p57:setState("Deselected", p58, p59)

	return p57
end
function t1.notify(p60, p61, p62) -- line: 707
	-- upvalues: Elements (copy), t1 (copy)
	if not p60.notice then
		p60.notice = require(Elements.Notice)(p60, t1)
	end

	p60.noticeStarted:Fire(p61, p62)

	return p60
end
function t1.clearNotices(p63) -- line: 721
	p63.endNotices:Fire()

	return p63
end
function t1.disableOverlay(p64, p65) -- line: 726
	p64.overlayDisabled = p65

	return p64
end

t1.disableStateOverlay = t1.disableOverlay

function t1.setImage(p66, p67, p68) -- line: 732
	-- upvalues: ContentProvider (copy)
	p66:modifyTheme({
		"IconImage",
		"Image",
		p67,
		p68
	})
	task.spawn(function() -- line: 736
		-- upvalues: p67 (copy), ContentProvider (copy)
		local v284 = if not tonumber(p67) then p67 else `rbxassetid://{ p67 }`

		if ContentProvider:GetAssetFetchStatus(v284) ~= Enum.AssetFetchStatus.Success then
			pcall(ContentProvider.PreloadAsync, ContentProvider, { v284 })
		end
	end)

	return p66
end
function t1.setLabel(p69, p70, p71) -- line: 748
	p69:modifyTheme({
		"IconLabel",
		"Text",
		p70,
		p71
	})

	return p69
end
function t1.setOrder(p72, p73, p74) -- line: 753
	local v144 = p73 * 100

	p72:modifyTheme({
		"IconSpot",
		"LayoutOrder",
		v144,
		p74
	})
	p72:modifyTheme({
		"Widget",
		"LayoutOrder",
		v144,
		p74
	})

	return p72
end
function t1.setCornerRadius(p75, p76, p77) -- line: 762
	p75:modifyTheme({
		"IconCorners",
		"CornerRadius",
		p76,
		p77
	})

	return p75
end
function t1.align(p78, p79, p80) -- line: 767
	-- upvalues: t1 (copy)
	local v151 = tostring(p79):lower()

	if v151 == "mid" or v151 == "centre" then
		v151 = "center"
	end

	if v151 ~= "left" and v151 ~= "center" and v151 ~= "right" then
		v151 = "left"
	end

	local v152 = v151 == "center" and t1.container.TopbarCentered or t1.container.TopbarStandard
	local Holders = v152.Holders
	local v154 = string.upper((string.sub(v151, 1, 1))) .. string.sub(v151, 2)

	if not p80 then
		p78.originalAlignment = v154
	end

	local joinedFrame = p78.joinedFrame
	local v156 = Holders[v154]

	p78.screenGui = v152
	p78.alignmentHolder = v156

	if not p78.isDestroyed then
		p78.widget.Parent = joinedFrame or v156
	end

	p78.alignment = v154
	p78.alignmentChanged:Fire(v154)
	t1.iconChanged:Fire(p78)

	return p78
end

t1.setAlignment = t1.align

function t1.setLeft(p81) -- line: 796
	p81:setAlignment("Left")

	return p81
end
function t1.setMid(p82) -- line: 801
	p82:setAlignment("Center")

	return p82
end
function t1.setRight(p83) -- line: 806
	p83:setAlignment("Right")

	return p83
end
function t1.setWidth(p84, p85, p86) -- line: 811
	p84:modifyTheme({
		"Widget",
		"DesiredWidth",
		p85,
		p86
	})

	return p84
end
function t1.setImageScale(p87, p88, p89) -- line: 819
	p87:modifyTheme({
		"IconImageScale",
		"Value",
		p88,
		p89
	})

	return p87
end
function t1.setImageRatio(p90, p91, p92) -- line: 824
	p90:modifyTheme({
		"IconImageRatio",
		"AspectRatio",
		p91,
		p92
	})

	return p90
end
function t1.setTextSize(p93, p94, p95) -- line: 829
	p93:modifyTheme({
		"IconLabel",
		"TextSize",
		p94,
		p95
	})

	return p93
end
function t1.setTextFont(p96, p97, p98, p99, p100) -- line: 834
	local v177 = p98 or Enum.FontWeight.Regular
	local v178 = p99 or Enum.FontStyle.Normal
	local v179 = nil
	local v180 = typeof(p97)

	if v180 == "number" then
		v179 = Font.fromId(p97, v177, v178)
	elseif v180 == "EnumItem" then
		v179 = Font.fromEnum(p97)
	elseif v180 == "string" and not p97:match("rbxasset") then
		v179 = Font.fromName(p97, v177, v178)
	end

	if not v179 then
		v179 = Font.new(p97, v177, v178)
	end

	p96:modifyTheme({
		"IconLabel",
		"FontFace",
		v179,
		p100
	})

	return p96
end
function t1.setTextColor(p101, p102, p103) -- line: 855
	if p102 == nil or (p102 == "" or type(p102) ~= "userdata" or typeof(p102) ~= "Color3") then
		if p102 ~= nil and p102 ~= "" then
			warn("setTextColor item must be a Color3 value! Changed the color to white.")
		end

		p102 = Color3.fromRGB(255, 255, 255)
	end

	p101:modifyTheme({
		"IconLabel",
		"TextColor3",
		p102,
		p103
	})

	return p101
end
function t1.bindToggleItem(p104, p105) -- line: 867
	if not p105:IsA("GuiObject") and not p105:IsA("LayerCollector") then
		error("Toggle item must be a GuiObject or LayerCollector!")
	end

	p104.toggleItems[p105] = true
	p104:_updateSelectionInstances()

	return p104
end
function t1.unbindToggleItem(p106, p107) -- line: 876
	p106.toggleItems[p107] = nil
	p106:_updateSelectionInstances()

	return p106
end
function t1._updateSelectionInstances(p108) -- line: 882
	for k, _ in pairs(p108.toggleItems) do
		local t7 = {}

		for _, v in pairs(k:GetDescendants()) do
			if (v:IsA("TextButton") or v:IsA("ImageButton")) and v.Active then
				table.insert(t7, v)
			end
		end

		p108.toggleItems[k] = t7
	end
end
function t1._setToggleItemsVisible(p109, p110, _, p112) -- line: 896
	for k, _ in pairs(p109.toggleItems) do
		if not p112 or p112 == p109 or p112.toggleItems[k] == nil then
			local s1 = "Visible"

			if k:IsA("LayerCollector") then
				s1 = "Enabled"
			end

			k[s1] = p110
		end
	end
end
function t1.bindEvent(p113, p114, p115) -- line: 908
	local v204 = p113[p114]

	assert(v204 and (typeof(v204) == "table" and v204.Connect), "argument[1] must be a valid topbarplus icon event name!")
	assert(typeof(p115) == "function", "argument[2] must be a function!")
	p113.bindedEvents[p114] = v204:Connect(function(...) -- line: 912
		-- upvalues: p115 (copy), p113 (copy)
		p115(p113, ...)
	end)

	return p113
end
function t1.unbindEvent(p116, p117) -- line: 918
	local v207 = p116.bindedEvents[p117]

	if v207 then
		v207:Disconnect()
		p116.bindedEvents[p117] = nil
	end

	return p116
end
function t1.bindToggleKey(p118, p119) -- line: 927
	assert(typeof(p119) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
	p118.bindedToggleKeys[p119] = true
	p118.toggleKeyAdded:Fire(p119)
	p118:setCaption("_hotkey_")

	return p118
end
function t1.unbindToggleKey(p120, p121) -- line: 935
	assert(typeof(p121) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
	p120.bindedToggleKeys[p121] = nil

	return p120
end
function t1.call(p122, p123, ...) -- line: 941
	local v214 = table.pack(...)

	task.spawn(function() -- line: 943
		-- upvalues: p123 (copy), p122 (copy), v214 (copy)
		p123(p122, table.unpack(v214))
	end)

	return p122
end
function t1.addToJanitor(p124, p125, p126, p127) -- line: 949
	p124.janitor:add(p125, p126, p127)

	return p124
end
function t1.lock(p128) -- line: 954
	p128:getInstance("ClickRegion").Visible = false
	p128.locked = true

	return p128
end
function t1.unlock(p129) -- line: 962
	p129:getInstance("ClickRegion").Visible = true
	p129.locked = false

	return p129
end
function t1.debounce(p130, p131) -- line: 969
	p130:lock()
	task.wait(p131)
	p130:unlock()

	return p130
end
function t1.autoDeselect(p132, p133) -- line: 976
	if p133 == nil then
		p133 = true
	end

	p132.deselectWhenOtherIconSelected = p133

	return p132
end
function t1.oneClick(p134, p135) -- line: 986
	local singleClickJanitor = p134.singleClickJanitor

	singleClickJanitor:clean()

	if p135 or p135 == nil then
		singleClickJanitor:add(p134.selected:Connect(function() -- line: 992
			-- upvalues: p134 (copy)
			p134:deselect("OneClick", p134)
		end))
	end

	p134.oneClickEnabled = true

	return p134
end
function t1.setCaption(p136, p137) -- line: 1000
	-- upvalues: Elements (copy)
	if p137 == "_hotkey_" and p136.captionText then
		return p136
	end

	local captionJanitor = p136.captionJanitor

	p136.captionJanitor:clean()

	if not p137 or p137 == "" then
		p136.caption = nil
		p136.captionText = nil

		return p136
	end

	local v231 = captionJanitor:add(require(Elements.Caption)(p136))

	v231:SetAttribute("CaptionText", p137)
	p136.caption = v231
	p136.captionText = p137

	return p136
end
function t1.setCaptionHint(p138, p139) -- line: 1018
	assert(typeof(p139) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
	p138.fakeToggleKey = p139
	p138.fakeToggleKeyChanged:Fire(p139)
	p138:setCaption("_hotkey_")

	return p138
end
function t1.leave(p140) -- line: 1026
	p140.joinJanitor:clean()

	return p140
end
function t1.joinMenu(p141, p142) -- line: 1032
	-- upvalues: Utility (copy)
	Utility.joinFeature(p141, p142, p142.menuIcons, p142:getInstance("Menu"))
	p142.menuChildAdded:Fire(p141)

	return p141
end
function t1.setMenu(p143, p144) -- line: 1038
	p143.menuSet:Fire(p144)

	return p143
end
function t1.setFixedMenu(p145, p146) -- line: 1043
	p145:freezeMenu(p146)
	p145:setMenu(p146)
end

t1.setFrozenMenu = t1.setFixedMenu

function t1.freezeMenu(p147) -- line: 1049
	p147:select("FrozenMenu", p147)
	p147:bindEvent("deselected", function(p148) -- line: 1053
		-- upvalues: p147 (copy)
		p148:select("FrozenMenu", p147)
	end)
	p147:modifyTheme({
		"IconSpot",
		"Visible",
		false
	})
end
function t1.joinDropdown(p149, p150) -- line: 1059
	-- upvalues: Utility (copy)
	p150:getDropdown()
	Utility.joinFeature(p149, p150, p150.dropdownIcons, p150:getInstance("DropdownScroller"))
	p150.dropdownChildAdded:Fire(p149)

	return p149
end
function t1.getDropdown(p151) -- line: 1066
	-- upvalues: Elements (copy)
	local dropdown = p151.dropdown

	if not dropdown then
		dropdown = require(Elements.Dropdown)(p151)
		p151.dropdown = dropdown
		p151:clipOutside(dropdown)
	end

	return dropdown
end
function t1.setDropdown(p152, p153) -- line: 1076
	p152:getDropdown()
	p152.dropdownSet:Fire(p153)

	return p152
end
function t1.clipOutside(p154, p155) -- line: 1082
	-- upvalues: Utility (copy)
	local v250 = Utility.clipOutside(p154, p155)

	p154:refreshAppearance(p155)

	return p154, v250
end
function t1.setIndicator(p156, p157) -- line: 1093
	-- upvalues: Elements (copy), t1 (copy)
	if not p156.indicator then
		p156.indicator = p156.janitor:add(require(Elements.Indicator)(p156, t1))
	end

	p156.indicatorSet:Fire(p157)
end
function t1.convertLabelToNumberSpinner(p158, p159, p160) -- line: 1105
	task.defer(function() -- line: 1106
		-- upvalues: p158 (copy), p159 (copy), p160 (copy)
		local v286 = p158:getInstance("IconLabel")

		v286.Transparency = 1
		p159.Parent = v286.Parent
		p159.Size = UDim2.fromScale(1, 1)
		p159.AnchorPoint = Vector2.new(0.5, 0.5)
		p159.Position = UDim2.new(0.5, 0, 0.5, 0)
		p159.TextXAlignment = Enum.TextXAlignment.Center
		p159.ClipsDescendants = false

		for _, v in ipairs({
			"FontFace",
			"BorderSizePixel",
			"BorderColor3",
			"Rotation",
			"TextStrokeTransparency",
			"TextStrokeColor3",
			"TextStrokeTransparency",
			"TextColor3"
		}) do
			p159[v] = v286[v]
			p158:addToJanitor(v286:GetPropertyChangedSignal(v):Connect(function() -- line: 1129
				-- upvalues: p159 (copy), v (copy), v286 (copy)
				p159[v] = v286[v]
			end))
		end

		local function getSpinnerSizeAndDigitCount() -- line: 1136
			-- upvalues: p159 (copy)
			local n4 = 0
			local n5 = 0

			for _, v294 in p159.Frame:GetChildren() do
				local v295 = string.lower(v294.Name)

				if v295 == "digit" then
					n4 += v294.AbsoluteSize.X
					n5 += 1
				elseif (v295 == "prefix" or v295 == "suffix" or v295 == "comma") and v294.Text ~= "" then
					n4 += v294.AbsoluteSize.X
					n5 += 1
				end
			end

			return n4, n5
		end
		local function adjustSize() -- line: 1170
			-- upvalues: getSpinnerSizeAndDigitCount (copy), p158 (copy), p159 (copy), v286 (copy)
			local v298, v299 = getSpinnerSizeAndDigitCount()

			if v299 < 18 then
				p158:setLabel(p159.Value)
			end

			local AbsoluteSizeX = p159.Frame.AbsoluteSize.X

			while v298 < AbsoluteSizeX and p158.isDestroyed ~= true do
				task.wait(0.05)

				if v299 > 0 and v299 < 8 then
					p159.TextSize = v286.TextSize

					break
				end

				local v301 = p159

				v301.TextSize = v301.TextSize + 1
				AbsoluteSizeX = p159.Frame.AbsoluteSize.X
				v298, v299 = getSpinnerSizeAndDigitCount()
			end

			local Parent = v286.Parent
			local v303 = Parent and Parent.Parent
			local v304 = if v303 ~= nil then if v303.IconImage.Visible ~= true then v303.AbsoluteSize.X else p159.Frame.AbsoluteSize.X + v286.Parent.Parent.IconImage.AbsoluteSize.X else 0

			while v304 < v298 and p158.isDestroyed ~= true do
				task.wait(0.05)

				if v299 < 8 and v299 > 0 then
					p159.TextSize = v286.TextSize

					return
				end

				local v305 = p159

				v305.TextSize = v305.TextSize - 1

				local Parent2 = v286.Parent
				local v307 = Parent2 and Parent2.Parent

				v304 = if v307 ~= nil then if v307.IconImage.Visible ~= true then v307.AbsoluteSize.X else p159.Frame.AbsoluteSize.X + v286.Parent.Parent.IconImage.AbsoluteSize.X else 0
				v298, v299 = getSpinnerSizeAndDigitCount()
			end
		end

		p158:addToJanitor(p159.Frame.ChildAdded:Connect(adjustSize))
		p158:addToJanitor(p159.Frame.ChildRemoved:Connect(adjustSize))
		p158:addToJanitor(p158.iconAdded:Connect(function() -- line: 1208
			-- upvalues: adjustSize (copy)
			task.wait(1)
			adjustSize()
		end))
		p158:updateParent()
		p159.Name = "LabelSpinner"
		p159.Prefix = "$"
		p159.Commas = true
		p159.Decimals = 0
		p159.Duration = 0.25
		p159.Value = 10
		task.wait(0.2)

		if typeof(p160) == "function" then
			p160()
		end
	end)

	return p158
end
function t1.destroy(p161) -- line: 1235
	-- upvalues: t1 (copy)
	if p161.isDestroyed then
		return
	end

	p161:clearNotices()

	if p161.parentIconUID then
		p161:leave()
	end

	p161.isDestroyed = true
	p161.janitor:clean()
	t1.iconRemoved:Fire(p161)
end

t1.Destroy = t1.destroy

return t1
