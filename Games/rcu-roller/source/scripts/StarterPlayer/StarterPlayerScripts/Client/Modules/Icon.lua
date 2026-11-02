-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:07
-- Luau version 6, Types version 3
-- Time taken: 0.025882 seconds

local HttpService_upvr = game:GetService("HttpService")
local script = script
local GoodSignal_upvr = require(script.Packages.GoodSignal)
local Janitor_upvr = require(script.Packages.Janitor)
local Utility_upvr = require(script.Utility)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
local Default_upvr = require(script.Themes.Default)
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local any_new_result1_2_upvr = GoodSignal_upvr.new()
local Elements_upvr = script.Elements
local var15_upvr = require(Elements_upvr.Container)()
for _, v in pairs(var15_upvr) do
	v.Parent = PlayerGui
end
module_upvr_2.container = var15_upvr
local UserInputService_upvr = game:GetService("UserInputService")
function module_upvr_2.new() -- Line 63
	--[[ Upvalues[9]:
		[1]: module_upvr_2 (readonly)
		[2]: Janitor_upvr (readonly)
		[3]: GoodSignal_upvr (readonly)
		[4]: HttpService_upvr (readonly)
		[5]: Elements_upvr (readonly)
		[6]: Default_upvr (readonly)
		[7]: UserInputService_upvr (readonly)
		[8]: any_new_result1_2_upvr (readonly)
		[9]: Utility_upvr (readonly)
	]]
	local module_upvr = {}
	setmetatable(module_upvr, module_upvr_2)
	local any_new_result1 = Janitor_upvr.new()
	module_upvr.janitor = any_new_result1
	module_upvr.themesJanitor = any_new_result1:add(Janitor_upvr.new())
	module_upvr.singleClickJanitor = any_new_result1:add(Janitor_upvr.new())
	module_upvr.captionJanitor = any_new_result1:add(Janitor_upvr.new())
	module_upvr.joinJanitor = any_new_result1:add(Janitor_upvr.new())
	module_upvr.menuJanitor = any_new_result1:add(Janitor_upvr.new())
	module_upvr.dropdownJanitor = any_new_result1:add(Janitor_upvr.new())
	module_upvr.selected = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.deselected = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.toggled = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.hoverStarted = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.hoverEnded = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.pressStarted = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.pressEnded = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.stateChanged = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.notified = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.noticeChanged = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.endNotices = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.dropdownOpened = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.dropdownClosed = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.menuOpened = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.menuClosed = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.toggleKeyAdded = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.alignmentChanged = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.updateSize = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.resizingComplete = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.joinedParent = any_new_result1:add(GoodSignal_upvr.new())
	module_upvr.Icon = module_upvr_2
	module_upvr.UID = HttpService_upvr:GenerateGUID(true)
	module_upvr.isEnabled = true
	module_upvr.isSelected = false
	module_upvr.isHovering = false
	module_upvr.isPressing = false
	module_upvr.isDragging = false
	module_upvr.joinedFrame = false
	module_upvr.parentIcon = false
	module_upvr.deselectWhenOtherIconSelected = true
	module_upvr.totalNotices = 0
	module_upvr.activeState = "Deselected"
	module_upvr.alignment = ""
	module_upvr.originalAlignment = ""
	module_upvr.appliedTheme = {}
	module_upvr.cachedInstances = {}
	module_upvr.cachedNamesToInstances = {}
	module_upvr.cachedCollectives = {}
	module_upvr.bindedToggleKeys = {}
	module_upvr.customBehaviours = {}
	module_upvr.toggleItems = {}
	module_upvr.bindedEvents = {}
	module_upvr.notices = {}
	module_upvr.menuIcons = {}
	module_upvr.dropdownIcons = {}
	module_upvr.childIconsDict = {}
	module_upvr.widget = any_new_result1:add(require(Elements_upvr.Widget)(module_upvr))
	module_upvr:setAlignment()
	module_upvr:setTheme(Default_upvr)
	local any_getInstance_result1 = module_upvr:getInstance("ClickRegion")
	any_getInstance_result1.MouseButton1Click:Connect(function() -- Line 137, Named "handleToggle"
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if module_upvr.locked then
		else
			if module_upvr.isSelected then
				module_upvr:deselect(module_upvr)
				return
			end
			module_upvr:select(module_upvr)
		end
	end)
	any_new_result1:add(UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 150
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if module_upvr.locked then
		elseif module_upvr.bindedToggleKeys[arg1.KeyCode] and not arg2 then
			if module_upvr.locked then return end
			if module_upvr.isSelected then
				module_upvr:deselect(module_upvr)
				return
			end
			module_upvr:select(module_upvr)
		end
	end))
	any_getInstance_result1.MouseButton1Down:Connect(function() -- Line 160
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if module_upvr.locked then
		else
			module_upvr:setState("Pressing", module_upvr)
		end
	end)
	local function hoveringStarted() -- Line 168
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if module_upvr.locked then
		else
			module_upvr.isHovering = true
			module_upvr.hoverStarted:Fire(true)
			module_upvr:setState("Hovering", module_upvr)
		end
	end
	local function hoveringEnded() -- Line 176
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if module_upvr.locked then
		else
			module_upvr.isHovering = false
			module_upvr.hoverEnded:Fire(true)
			module_upvr:setState(nil, module_upvr)
		end
	end
	module_upvr.joinedParent:Connect(function() -- Line 184
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if module_upvr.isHovering then
			if module_upvr.locked then return end
			module_upvr.isHovering = false
			module_upvr.hoverEnded:Fire(true)
			module_upvr:setState(nil, module_upvr)
		end
	end)
	any_getInstance_result1.MouseEnter:Connect(hoveringStarted)
	any_getInstance_result1.MouseLeave:Connect(hoveringEnded)
	any_getInstance_result1.SelectionGained:Connect(hoveringStarted)
	any_getInstance_result1.SelectionLost:Connect(hoveringEnded)
	any_getInstance_result1.MouseButton1Down:Connect(function() -- Line 193
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if module_upvr.isDragging then
			if module_upvr.locked then return end
			module_upvr.isHovering = true
			module_upvr.hoverStarted:Fire(true)
			module_upvr:setState("Hovering", module_upvr)
		end
	end)
	local var34
	if UserInputService_upvr.TouchEnabled then
		any_getInstance_result1.MouseButton1Up:Connect(function() -- Line 199
			--[[ Upvalues[1]:
				[1]: module_upvr (readonly)
			]]
			if module_upvr.locked then
			elseif module_upvr.hovering then
				if module_upvr.locked then return end
				module_upvr.isHovering = false
				module_upvr.hoverEnded:Fire(true)
				module_upvr:setState(nil, module_upvr)
			end
		end)
		function var34(arg1, arg2) -- Line 210
			--[[ Upvalues[1]:
				[1]: module_upvr (readonly)
			]]
			if arg2 then
			else
				module_upvr.isDragging = true
			end
		end
		any_new_result1:add(UserInputService_upvr.TouchMoved:Connect(var34))
		function var34() -- Line 216
			--[[ Upvalues[1]:
				[1]: module_upvr (readonly)
			]]
			module_upvr.isDragging = false
		end
		any_new_result1:add(UserInputService_upvr.TouchEnded:Connect(var34))
	end
	local any_getInstance_result1_2_upvr = module_upvr:getInstance("IconOverlay")
	module_upvr.hoverStarted:Connect(function() -- Line 223
		--[[ Upvalues[2]:
			[1]: any_getInstance_result1_2_upvr (readonly)
			[2]: module_upvr (readonly)
		]]
		any_getInstance_result1_2_upvr.Visible = not module_upvr.overlayDisabled
	end)
	module_upvr.hoverEnded:Connect(function() -- Line 226
		--[[ Upvalues[1]:
			[1]: any_getInstance_result1_2_upvr (readonly)
		]]
		any_getInstance_result1_2_upvr.Visible = false
	end)
	any_new_result1:add(any_new_result1_2_upvr:Connect(function(arg1) -- Line 231
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if arg1 ~= module_upvr and module_upvr.deselectWhenOtherIconSelected and arg1.deselectWhenOtherIconSelected then
			module_upvr:deselect()
		end
	end))
	var34 = '.'
	var34 = nil
	for var44, v_2 in pairs(string.split(debug.info(2, 's'), var34)) do
		local SOME = game:FindFirstChild(v_2)
		if not SOME then break end
		if SOME:IsA("ScreenGui") then
			var34 = SOME
		end
	end
	if SOME and var34 and var34.ResetOnSpawn == true then
		Utility_upvr.localPlayerRespawned(function() -- Line 256
			--[[ Upvalues[1]:
				[1]: module_upvr (readonly)
			]]
			module_upvr:destroy()
		end)
	end
	function var44() -- Line 263
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		module_upvr.noticeChanged:Fire(module_upvr.totalNotices)
		for i_3, _ in pairs(module_upvr.childIconsDict) do
			i_3.noticeChanged:Fire(i_3.totalNotices)
		end
	end
	module_upvr.toggled:Connect(var44)
	task.defer(function() -- Line 271
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		module_upvr.activeState = ""
		module_upvr.isSelected = true
		module_upvr:deselect()
		module_upvr:refresh()
	end)
	return module_upvr
end
function module_upvr_2.setName(arg1, arg2) -- Line 289
	arg1.widget.Name = arg2
	arg1.name = arg2
	return arg1
end
function module_upvr_2.setState(arg1, arg2, arg3, arg4) -- Line 295
	--[[ Upvalues[2]:
		[1]: Utility_upvr (readonly)
		[2]: any_new_result1_2_upvr (readonly)
	]]
	if not arg2 then
		if arg1.isSelected then
		else
		end
	end
	local any_formatStateName_result1 = Utility_upvr.formatStateName("Deselected")
	local activeState_2 = arg1.activeState
	if activeState_2 == any_formatStateName_result1 then
	else
		arg1.activeState = any_formatStateName_result1
		if any_formatStateName_result1 == "Deselected" then
			arg1.isSelected = false
			if arg1.isSelected then
				arg1.toggled:Fire(false, arg3)
				if not arg4 then
					arg1.deselected:Fire(arg3)
				end
			end
			arg1:_setToggleItemsVisible(false, arg3)
		elseif any_formatStateName_result1 == "Selected" then
			arg1.isSelected = true
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			if not arg1.isSelected then
				arg1.toggled:Fire(true, arg3)
				if not arg4 then
					arg1.selected:Fire(arg3)
				end
				any_new_result1_2_upvr:Fire(arg1)
			end
			arg1:_setToggleItemsVisible(true, arg3)
		elseif any_formatStateName_result1 == "Pressing" then
			arg1.isPressing = true
			arg1.pressStarted:Fire(arg3)
		end
		if activeState_2 == "Pressing" then
			arg1.isPressing = false
			arg1.pressEnded:Fire(arg3)
		end
		arg1.stateChanged:Fire(any_formatStateName_result1, arg3)
	end
end
function module_upvr_2.getInstance(arg1, arg2) -- Line 339
	local var56 = arg1.cachedNamesToInstances[arg2]
	if var56 then
		return var56
	end
	local function cacheInstance_upvr(arg1_2, arg2_2) -- Line 347, Named "cacheInstance"
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local var57
		if not arg1.cachedInstances[arg2_2] then
			local Collective = arg2_2:GetAttribute("Collective")
			var57 = Collective
			if var57 then
				var57 = arg1.cachedCollectives[Collective]
			end
			if var57 then
				table.insert(var57, arg2_2)
			end
			arg1.cachedNamesToInstances[arg1_2] = arg2_2
			arg1.cachedInstances[arg2_2] = true
			arg2_2.Destroying:Once(function() -- Line 357
				--[[ Upvalues[3]:
					[1]: arg1 (copied, readonly)
					[2]: arg1_2 (readonly)
					[3]: arg2_2 (readonly)
				]]
				arg1.cachedNamesToInstances[arg1_2] = nil
				arg1.cachedInstances[arg2_2] = nil
			end)
		end
	end
	local widget = arg1.widget
	cacheInstance_upvr("Widget", widget)
	if arg2 == "Widget" then
		return widget
	end
	local var61_upvw
	local function scanChildren_upvr(arg1_3) -- Line 370, Named "scanChildren"
		--[[ Upvalues[5]:
			[1]: arg1 (readonly)
			[2]: scanChildren_upvr (readonly)
			[3]: cacheInstance_upvr (readonly)
			[4]: arg2 (readonly)
			[5]: var61_upvw (read and write)
		]]
		for _, v_4 in pairs(arg1_3:GetChildren()) do
			local WidgetUID = v_4:GetAttribute("WidgetUID")
			local function INLINED() -- Internal function, doesn't exist in bytecode
				scanChildren_upvr(v_4)
				return v_4:IsA("GuiBase")
			end
			if not WidgetUID or WidgetUID == arg1.UID or INLINED() or v_4:IsA("UIBase") or v_4:IsA("ValueBase") then
				local Name = v_4.Name
				cacheInstance_upvr(Name, v_4)
				if Name == arg2 then
					var61_upvw = v_4
				end
			end
		end
	end
	scanChildren_upvr(widget)
	return var61_upvw
end
function module_upvr_2.getCollective(arg1, arg2) -- Line 392
	local var71 = arg1.cachedCollectives[arg2]
	if var71 then
		return var71
	end
	local module = {}
	for i_5, _ in pairs(arg1.cachedInstances) do
		if i_5:GetAttribute("Collective") == arg2 then
			table.insert(module, i_5)
		end
	end
	arg1.cachedCollectives[arg2] = module
	return module
end
function module_upvr_2.get(arg1, arg2) -- Line 413
	local any_getInstance_result1_4 = arg1:getInstance(arg2)
	local var77
	if any_getInstance_result1_4 then
		table.insert(var77, any_getInstance_result1_4)
	end
	if #var77 == 0 then
		var77 = arg1:getCollective(arg2)
	end
	return var77
end
function module_upvr_2.getValue(arg1, arg2, arg3) -- Line 427
	local pcall_result1, pcall_result2 = pcall(function() -- Line 428
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg3 (readonly)
		]]
		return arg2[arg3]
	end)
	if not pcall_result1 then
		pcall_result2 = arg2:GetAttribute(arg3)
	end
	return pcall_result2
end
function module_upvr_2.refreshAppearance(arg1, arg2, arg3) -- Line 437
	arg1:set(arg2, arg3, arg1:getValue(arg2, arg3), true)
end
function module_upvr_2.set(arg1, arg2, arg3, arg4, arg5) -- Line 442
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var107
	local var108 = arg2
	if typeof(arg2) == "Instance" then
		local tbl = {}
		tbl[1] = arg2
		var107 = tbl
		var108 = arg2.Name
	else
		var107 = arg1:get(arg2)
	end
	local var110 = arg1.customBehaviours[var108..'-'..arg3]
	for _, v_6_upvr in pairs(var107) do
		local var114
		if arg5 or var114 ~= arg1:getValue(v_6_upvr, arg3) then
			if var110 then
				local var110_result1_upvw = var110(var114, v_6_upvr, arg3)
				if var110_result1_upvw ~= nil then
				end
			end
			if not pcall(function() -- Line 468
				--[[ Upvalues[3]:
					[1]: v_6_upvr (readonly)
					[2]: arg3 (readonly)
					[3]: var110_result1_upvw (read and write)
				]]
				v_6_upvr[arg3] = var110_result1_upvw
			end) then
				v_6_upvr:SetAttribute(arg3, var110_result1_upvw)
			end
		end
	end
	return arg1
end
function module_upvr_2.setBehaviour(arg1, arg2, arg3, arg4, arg5) -- Line 483
	arg1.customBehaviours[arg2..'-'..arg3] = arg4
	if arg5 then
		for _, v_7 in pairs(arg1:get(arg2)) do
			arg1:refreshAppearance(v_7, arg3)
		end
	end
end
function module_upvr_2.getThemeValue(arg1, arg2, arg3, arg4) -- Line 496
	if not arg4 then
	end
	for _, v_8 in pairs(arg1.appliedTheme[arg1.activeState]) do
		local unpack_result1_2, unpack_result2_3, unpack_result3_2 = unpack(v_8)
		if arg2 == unpack_result1_2 and arg3 == unpack_result2_3 then
			return unpack_result3_2
		end
	end
end
function module_upvr_2.modifyTheme(arg1, arg2, arg3, arg4, arg5) -- Line 509
	--[[ Upvalues[1]:
		[1]: Utility_upvr (readonly)
	]]
	task.spawn(function() -- Line 515
		--[[ Upvalues[6]:
			[1]: arg5 (readonly)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
			[4]: arg3 (readonly)
			[5]: arg4 (readonly)
			[6]: Utility_upvr (copied, readonly)
		]]
		if arg5 == nil then
			arg1:modifyTheme(arg2, arg3, arg4, "Selected")
		end
		local any_formatStateName_result1_2_upvr = Utility_upvr.formatStateName(arg5 or "Deselected")
		local var136 = arg1.appliedTheme[any_formatStateName_result1_2_upvr]
		local function _() -- Line 522, Named "nowSetIt"
			--[[ Upvalues[5]:
				[1]: any_formatStateName_result1_2_upvr (readonly)
				[2]: arg1 (copied, readonly)
				[3]: arg2 (copied, readonly)
				[4]: arg3 (copied, readonly)
				[5]: arg4 (copied, readonly)
			]]
			if any_formatStateName_result1_2_upvr == arg1.activeState then
				arg1:set(arg2, arg3, arg4)
			end
		end
		for _, v_9 in pairs(var136) do
			local unpack_result1_3, unpack_result2, _ = unpack(v_9)
			if arg2 == unpack_result1_3 and arg3 == unpack_result2 then
				v_9[3] = arg4
				if any_formatStateName_result1_2_upvr == arg1.activeState then
					arg1:set(arg2, arg3, arg4)
				end
				return
			end
		end
		local tbl_2 = {}
		tbl_2[1] = arg2
		tbl_2[2] = arg3
		tbl_2[3] = arg4
		table.insert(var136, tbl_2)
		if any_formatStateName_result1_2_upvr == arg1.activeState then
			arg1:set(arg2, arg3, arg4)
		end
	end)
	return arg1
end
function module_upvr_2.setTheme(arg1, arg2) -- Line 542
	--[[ Upvalues[2]:
		[1]: Default_upvr (readonly)
		[2]: Utility_upvr (readonly)
	]]
	local themesJanitor = arg1.themesJanitor
	themesJanitor:clean()
	local var145_upvw
	if typeof(arg2) == "Instance" and var145_upvw:IsA("ModuleScript") then
		var145_upvw = require(var145_upvw)
	end
	local function applyTheme_upvr() -- Line 551, Named "applyTheme"
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		for _, v_10 in pairs(arg1.appliedTheme[arg1.activeState]) do
			local unpack_result1, unpack_result2_2, unpack_result3 = unpack(v_10)
			arg1:set(unpack_result1, unpack_result2_2, unpack_result3)
		end
	end
	;(function() -- Line 558, Named "generateTheme"
		--[[ Upvalues[5]:
			[1]: Default_upvr (copied, readonly)
			[2]: var145_upvw (read and write)
			[3]: arg1 (readonly)
			[4]: Utility_upvr (copied, readonly)
			[5]: applyTheme_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		for i_11, _ in pairs(Default_upvr) do
			local tbl_upvr = {}
			local function _(arg1_4) -- Line 561, Named "updateDetails"
				--[[ Upvalues[1]:
					[1]: tbl_upvr (readonly)
				]]
				if not arg1_4 then
				else
					for _, v_23 in pairs(arg1_4) do
						tbl_upvr[v_23[1]..'-'..v_23[2]] = v_23
					end
				end
			end
			if i_11 == "Selected" then
				local Deselected = Default_upvr.Deselected
				if not Deselected then
				else
					for _, v_12 in pairs(Deselected) do
						tbl_upvr[v_12[1]..'-'..v_12[2]] = v_12
					end
				end
			end
			if i_11 == "Pressing" then
				local Hovering = var145_upvw.Hovering
				if not Hovering then
				else
					for _, v_13 in pairs(Hovering) do
						tbl_upvr[v_13[1]..'-'..v_13[2]] = v_13
					end
				end
			end
			local var211 = var145_upvw[i_11]
			if not var211 then
			else
				for _, v_14 in pairs(var211) do
					tbl_upvr[v_14[1]..'-'..v_14[2]] = v_14
				end
			end
			for _, v_15 in pairs(tbl_upvr) do
				table.insert({}, v_15)
				local var219
			end
			arg1.appliedTheme[i_11] = Utility_upvr.copyTable(var219)
		end
		applyTheme_upvr()
	end)()
	themesJanitor:add(arg1.stateChanged:Connect(applyTheme_upvr))
	return arg1
end
function module_upvr_2.setEnabled(arg1, arg2) -- Line 594
	arg1.isEnabled = arg2
	arg1.widget.Visible = arg2
	return arg1
end
function module_upvr_2.select(arg1, arg2) -- Line 600
	arg1:setState("Selected", arg2)
	return arg1
end
function module_upvr_2.deselect(arg1, arg2, arg3) -- Line 605
	arg1:setState("Deselected", arg2, arg3)
	return arg1
end
function module_upvr_2.notify(arg1, arg2, arg3) -- Line 610
	--[[ Upvalues[3]:
		[1]: Janitor_upvr (readonly)
		[2]: GoodSignal_upvr (readonly)
		[3]: HttpService_upvr (readonly)
	]]
	if not arg2 then
		local deselected = arg1.deselected
	end
	if arg1.parentIcon then
		arg1.parentIcon:notify(deselected)
	end
	local any_add_result1_4_upvr = arg1.janitor:add(Janitor_upvr.new())
	local any_add_result1_3_upvr = any_add_result1_4_upvr:add(GoodSignal_upvr.new())
	any_add_result1_4_upvr:add(arg1.endNotices:Connect(function() -- Line 623
		--[[ Upvalues[1]:
			[1]: any_add_result1_3_upvr (readonly)
		]]
		any_add_result1_3_upvr:Fire()
	end))
	any_add_result1_4_upvr:add(deselected:Connect(function() -- Line 626
		--[[ Upvalues[1]:
			[1]: any_add_result1_3_upvr (readonly)
		]]
		any_add_result1_3_upvr:Fire()
	end))
	local var225 = arg3
	if not var225 then
		var225 = HttpService_upvr:GenerateGUID(true)
	end
	local var226_upvw = var225
	arg1.notices[var226_upvw] = {
		completeSignal = any_add_result1_3_upvr;
		clearNoticeEvent = deselected;
	}
	local function _() -- Line 635, Named "updateNotice"
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1.noticeChanged:Fire(arg1.totalNotices)
	end
	arg1.notified:Fire(var226_upvw)
	arg1.totalNotices += 1
	arg1.noticeChanged:Fire(arg1.totalNotices)
	any_add_result1_3_upvr:Once(function() -- Line 641
		--[[ Upvalues[3]:
			[1]: any_add_result1_4_upvr (readonly)
			[2]: arg1 (readonly)
			[3]: var226_upvw (read and write)
		]]
		any_add_result1_4_upvr:destroy()
		local var229 = arg1
		var229.totalNotices -= 1
		arg1.notices[var226_upvw] = nil
		arg1.noticeChanged:Fire(arg1.totalNotices)
	end)
	return arg1
end
function module_upvr_2.clearNotices(arg1) -- Line 650
	arg1.endNotices:Fire()
	return arg1
end
function module_upvr_2.disableOverlay(arg1, arg2) -- Line 655
	arg1.overlayDisabled = arg2
	return arg1
end
module_upvr_2.disableStateOverlay = module_upvr_2.disableOverlay
function module_upvr_2.setImage(arg1, arg2, arg3) -- Line 661
	arg1:modifyTheme("IconImage", "Image", arg2, arg3)
	return arg1
end
function module_upvr_2.setLabel(arg1, arg2, arg3) -- Line 666
	arg1:modifyTheme("IconLabel", "Text", arg2, arg3)
	return arg1
end
function module_upvr_2.setOrder(arg1, arg2, arg3) -- Line 671
	arg1:modifyTheme("Widget", "LayoutOrder", arg2, arg3)
	return arg1
end
function module_upvr_2.setCornerRadius(arg1, arg2, arg3) -- Line 676
	arg1:modifyTheme("IconCorners", "CornerRadius", arg2, arg3)
	return arg1
end
function module_upvr_2.setAlignment(arg1, arg2, arg3) -- Line 681
	--[[ Upvalues[1]:
		[1]: var15_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_lower_result1 = tostring(arg2):lower()
	if any_lower_result1 == "mid" or any_lower_result1 == "centre" then
	end
	if "center" ~= "left" then
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
		if "center" ~= "center" and "center" ~= "right" then
		end
	end
	if "left" ~= "center" or not var15_upvr.TopbarCentered then
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
	local var234 = string.upper(string.sub("left", 1, 1))..string.sub("left", 2)
	if not arg3 then
		arg1.originalAlignment = var234
	end
	local joinedFrame = arg1.joinedFrame
	if not joinedFrame then
		joinedFrame = var15_upvr.TopbarStandard.Holders[var234]
	end
	arg1.widget.Parent = joinedFrame
	arg1.alignment = var234
	arg1.alignmentChanged:Fire(var234)
	return arg1
end
function module_upvr_2.setLeft(arg1) -- Line 703
	arg1:setAlignment("Left")
	return arg1
end
function module_upvr_2.setMid(arg1) -- Line 708
	arg1:setAlignment("Center")
	return arg1
end
function module_upvr_2.setRight(arg1) -- Line 713
	arg1:setAlignment("Right")
	return arg1
end
function module_upvr_2.setWidth(arg1, arg2, arg3) -- Line 718
	arg1:modifyTheme("Widget", "Size", UDim2.fromOffset(arg2, arg1.widget.Size.Y.Offset), arg3)
	arg1:modifyTheme("Widget", "DesiredWidth", arg2, arg3)
	return arg1
end
function module_upvr_2.setImageScale(arg1, arg2, arg3) -- Line 728
	arg1:modifyTheme("IconImageScale", "Value", arg2, arg3)
	return arg1
end
function module_upvr_2.setImageRatio(arg1, arg2, arg3) -- Line 733
	arg1:modifyTheme("IconImageRatio", "AspectRatio", arg2, arg3)
	return arg1
end
function module_upvr_2.setTextSize(arg1, arg2, arg3) -- Line 738
	arg1:modifyTheme("IconLabel", "TextSize", arg2, arg3)
	return arg1
end
function module_upvr_2.setTextFont(arg1, arg2, arg3, arg4, arg5) -- Line 743
	local var236 = arg3
	if not var236 then
		var236 = Enum.FontWeight.Regular
	end
	var236 = arg4
	local var237 = var236
	if not var237 then
		var237 = Enum.FontStyle.Normal
	end
	arg1:modifyTheme("IconLabel", "FontFace", Font.new(arg2, var236, var237), arg5)
	return arg1
end
function module_upvr_2.bindToggleItem(arg1, arg2) -- Line 751
	if not arg2:IsA("GuiObject") and not arg2:IsA("LayerCollector") then
		error("Toggle item must be a GuiObject or LayerCollector!")
	end
	arg1.toggleItems[arg2] = true
	arg1:_updateSelectionInstances()
	return arg1
end
function module_upvr_2.unbindToggleItem(arg1, arg2) -- Line 760
	arg1.toggleItems[arg2] = nil
	arg1:_updateSelectionInstances()
	return arg1
end
function module_upvr_2._updateSelectionInstances(arg1) -- Line 766
	for i_16, _ in pairs(arg1.toggleItems) do
		for _, v_17 in pairs(i_16:GetDescendants()) do
			if v_17:IsA("TextButton") or v_17:IsA("ImageButton") then
				if v_17.Active then
					table.insert({}, v_17)
				end
			end
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		arg1.toggleItems[i_16] = {}
	end
end
function module_upvr_2._setToggleItemsVisible(arg1, arg2, arg3) -- Line 780
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local _
	for i_18, _ in pairs(arg1.toggleItems) do
		if not arg3 or arg3 == arg1 or arg3.toggleItems[i_18] == nil then
			if i_18:IsA("LayerCollector") then
			end
			i_18.Enabled = arg2
		end
	end
end
function module_upvr_2.bindEvent(arg1, arg2, arg3) -- Line 792
	local var263 = arg1[arg2]
	local var264
	if var264 then
		var264 = false
		if typeof(var263) == "table" then
			var264 = var263.Connect
		end
	end
	assert(var264, "argument[1] must be a valid topbarplus icon event name!")
	if typeof(arg3) ~= "function" then
		var264 = false
	else
		var264 = true
	end
	assert(var264, "argument[2] must be a function!")
	var264 = var263:Connect(function(...) -- Line 796
		--[[ Upvalues[2]:
			[1]: arg3 (readonly)
			[2]: arg1 (readonly)
		]]
		arg3(arg1, ...)
	end)
	arg1.bindedEvents[arg2] = var264
	return arg1
end
function module_upvr_2.unbindEvent(arg1, arg2) -- Line 802
	local var266 = arg1.bindedEvents[arg2]
	if var266 then
		var266:Disconnect()
		arg1.bindedEvents[arg2] = nil
	end
	return arg1
end
function module_upvr_2.bindToggleKey(arg1, arg2) -- Line 811
	local var267
	if typeof(arg2) ~= "EnumItem" then
		var267 = false
	else
		var267 = true
	end
	assert(var267, "argument[1] must be a KeyCode EnumItem!")
	var267 = true
	arg1.bindedToggleKeys[arg2] = var267
	arg1.toggleKeyAdded:Fire(arg2)
	return arg1
end
function module_upvr_2.unbindToggleKey(arg1, arg2) -- Line 818
	local var268
	if typeof(arg2) ~= "EnumItem" then
		var268 = false
	else
		var268 = true
	end
	assert(var268, "argument[1] must be a KeyCode EnumItem!")
	var268 = nil
	arg1.bindedToggleKeys[arg2] = var268
	return arg1
end
function module_upvr_2.call(arg1, arg2) -- Line 824
	task.spawn(function() -- Line 825
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		arg2(arg1)
	end)
	return arg1
end
function module_upvr_2.addToJanitor(arg1, arg2) -- Line 831
	arg1.janitor:add(arg2)
	return arg1
end
function module_upvr_2.lock(arg1) -- Line 836
	arg1:getInstance("IconButton").Active = false
	arg1.locked = true
	return arg1
end
function module_upvr_2.unlock(arg1) -- Line 844
	arg1:getInstance("IconButton").Active = true
	arg1.locked = false
	return arg1
end
function module_upvr_2.debounce(arg1, arg2) -- Line 851
	arg1:lock()
	task.wait(arg2)
	arg1:unlock()
	return arg1
end
function module_upvr_2.autoDeselect(arg1, arg2) -- Line 858
	if arg2 == nil then
	end
	arg1.deselectWhenOtherIconSelected = true
	return arg1
end
function module_upvr_2.oneClick(arg1, arg2) -- Line 868
	local singleClickJanitor = arg1.singleClickJanitor
	singleClickJanitor:clean()
	if arg2 or arg2 == nil then
		singleClickJanitor:add(arg1.selected:Connect(function() -- Line 874
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:deselect()
		end))
	end
	return arg1
end
function module_upvr_2.setCaption(arg1, arg2) -- Line 881
	--[[ Upvalues[1]:
		[1]: Elements_upvr (readonly)
	]]
	arg1.captionJanitor:clean()
	if not arg2 or arg2 == "" then
		arg1.caption = nil
		arg1.captionText = nil
		return
	end
	local any_add_result1 = arg1.captionJanitor:add(require(Elements_upvr.Caption)(arg1))
	any_add_result1:SetAttribute("CaptionText", arg2)
	arg1.caption = any_add_result1
	arg1.captionText = arg2
	return arg1
end
function module_upvr_2.refresh(arg1) -- Line 896
	arg1.updateSize:Fire()
end
function module_upvr_2._join(arg1, arg2, arg3, arg4) -- Line 900
	local joinJanitor = arg1.joinJanitor
	joinJanitor:clean()
	if not arg4 then
		arg1:leave()
		return
	end
	arg1.parentIcon = arg2
	arg1.joinedFrame = arg4
	local function updateAlignent() -- Line 911
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local alignment = arg2.alignment
		if alignment == "Center" then
			alignment = "Left"
		end
		arg1:setAlignment(alignment, true)
	end
	joinJanitor:add(arg2.alignmentChanged:Connect(updateAlignent))
	local alignment_2 = arg2.alignment
	if alignment_2 == "Center" then
		alignment_2 = "Left"
	end
	arg1:setAlignment(alignment_2, true)
	arg1:setBehaviour("IconButton", "BackgroundTransparency", function() -- Line 920
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1.joinedFrame then
			return 1
		end
	end, true)
	arg1.parentIconsArray = arg3
	table.insert(arg3, arg1)
	arg2:autoDeselect(false)
	arg2.childIconsDict[arg1] = true
	if not arg2.isEnabled then
		arg2:setEnabled(true)
	end
	arg1.joinedParent:Fire(arg2)
	joinJanitor:add(function() -- Line 936
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 13 start (CF ANALYSIS FAILED)
		if not arg1.joinedFrame then return end
		arg1:setAlignment(arg1.originalAlignment)
		arg1.parentIcon = false
		arg1.joinedFrame = false
		arg1:setBehaviour("IconButton", "BackgroundTransparency", nil, true)
		local parentIconsArray = arg1.parentIconsArray
		local pairs_result1_4, pairs_result2_9, pairs_result3_8 = pairs(parentIconsArray)
		-- KONSTANTERROR: [0] 1. Error Block 13 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [50] 40. Error Block 6 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [50] 40. Error Block 6 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [40] 32. Error Block 4 start (CF ANALYSIS FAILED)
		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.8]
		-- KONSTANTERROR: [40] 32. Error Block 4 end (CF ANALYSIS FAILED)
	end)
	return arg1
end
function module_upvr_2.leave(arg1) -- Line 964
	arg1.joinJanitor:clean()
	return arg1
end
function module_upvr_2.joinMenu(arg1, arg2) -- Line 970
	arg1:_join(arg2, arg2.menuIcons, arg2:getInstance("IconHolder"))
end
function module_upvr_2.setMenu(arg1, arg2) -- Line 974
	for _, v_19 in pairs(arg1.menuIcons) do
		v_19:leave()
	end
	local menuJanitor = arg1.menuJanitor
	menuJanitor:clean()
	menuJanitor:add(arg1.toggled:Connect(function() -- Line 984
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if 0 < #arg1.menuIcons then
			arg1.updateSize:Fire()
		end
	end))
	if type(arg2) == "table" then
		for _, v_20 in pairs(arg2) do
			v_20:joinMenu(arg1)
		end
	end
	if arg1:getThemeValue("IconImage", "Image", "Deselected") == arg1:getThemeValue("IconImage", "Image", "Selected") then
		arg1:modifyTheme("IconLabel", "FontFace", Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), "Selected")
		arg1:modifyTheme("IconLabel", "Text", 'X', "Selected")
		arg1:modifyTheme("IconLabel", "TextSize", 20, "Selected")
		arg1:modifyTheme("IconLabel", "TextStrokeTransparency", 0.8, "Selected")
		arg1:modifyTheme("IconImage", "Image", "", "Selected")
	end
	local any_getInstance_result1_5_upvr = arg1:getInstance("IconSpot")
	local any_getInstance_result1_3_upvr = arg1:getInstance("MenuGap")
	menuJanitor:add(arg1.alignmentChanged:Connect(function() -- Line 1014, Named "updateAlignent"
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: any_getInstance_result1_5_upvr (readonly)
			[3]: any_getInstance_result1_3_upvr (readonly)
		]]
		if arg1.alignment == "Right" then
			any_getInstance_result1_5_upvr.LayoutOrder = 99999
			any_getInstance_result1_3_upvr.LayoutOrder = 99998
		else
			any_getInstance_result1_5_upvr.LayoutOrder = -99999
			any_getInstance_result1_3_upvr.LayoutOrder = -99998
		end
	end))
	if arg1.alignment == "Right" then
		any_getInstance_result1_5_upvr.LayoutOrder = 99999
		any_getInstance_result1_3_upvr.LayoutOrder = 99998
		return arg1
	end
	any_getInstance_result1_5_upvr.LayoutOrder = -99999
	any_getInstance_result1_3_upvr.LayoutOrder = -99998
	return arg1
end
function module_upvr_2.joinDropdown(arg1, arg2) -- Line 1030
	--[[ Upvalues[1]:
		[1]: Utility_upvr (readonly)
	]]
	local any_copyTable_result1_upvr = Utility_upvr.copyTable(arg1.appliedTheme)
	task.defer(function() -- Line 1034
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: any_copyTable_result1_upvr (readonly)
		]]
		arg1.joinJanitor:add(function() -- Line 1035
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: any_copyTable_result1_upvr (copied, readonly)
			]]
			arg1:setTheme(any_copyTable_result1_upvr)
		end)
	end)
	arg1:modifyTheme("Widget", "BorderSize", 0)
	arg1:modifyTheme("IconCorners", "CornerRadius", UDim.new(0, 4))
	arg1:modifyTheme("Widget", "MinimumWidth", 190)
	arg1:modifyTheme("Widget", "MinimumHeight", 56)
	arg1:modifyTheme("IconLabel", "TextSize", 19)
	arg1:modifyTheme("PaddingLeft", "Size", UDim2.fromOffset(20, 0))
	arg1:_join(arg2, arg2.dropdownIcons, arg2:getInstance("DropdownHolder"))
end
function module_upvr_2.setDropdown(arg1, arg2) -- Line 1049
	--[[ Upvalues[1]:
		[1]: Elements_upvr (readonly)
	]]
	for _, v_21 in pairs(arg1.dropdownIcons) do
		v_21:leave()
	end
	local dropdownJanitor = arg1.dropdownJanitor
	dropdownJanitor:clean()
	local any_add_result1_2_upvr = dropdownJanitor:add(require(Elements_upvr.Dropdown)(arg1))
	any_add_result1_2_upvr.Parent = arg1.widget
	if type(arg2) == "table" then
		for _, v_22 in pairs(arg2) do
			v_22:joinDropdown(arg1)
		end
	end
	dropdownJanitor:add(arg1.toggled:Connect(function() -- Line 1072, Named "updateVisibility"
		--[[ Upvalues[2]:
			[1]: any_add_result1_2_upvr (readonly)
			[2]: arg1 (readonly)
		]]
		any_add_result1_2_upvr.Visible = arg1.isSelected
	end))
	any_add_result1_2_upvr.Visible = arg1.isSelected
	return arg1
end
function module_upvr_2.destroy(arg1) -- Line 1082
	if arg1.isDestroyed then
	else
		arg1:clearNotices()
		if arg1.parentIcon then
			arg1:leave()
		end
		arg1.isDestroyed = true
		arg1.janitor:clean()
	end
end
module_upvr_2.Destroy = module_upvr_2.destroy
return module_upvr_2