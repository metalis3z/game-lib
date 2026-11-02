-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:21:22

-- Luau version 6, Types version 3

-- Time taken: 0.027171 seconds


local StarterGui_upvr = game:GetService("StarterGui")

local GuiService_upvr = game:GetService("GuiService")

local RunService_upvr = game:GetService("RunService")

local Players_upvr = game:GetService("Players")

local module_upvr = {}

local Signal = require(script.Parent.Signal)

local TopbarPlusGui_upvr = require(script.Parent.TopbarPlusGui)

local tbl_3_upvr = {}

local var9_upvw

local function _() -- Line 166, Named "checkTopbarEnabled"

	--[[ Upvalues[1]:

		[1]: StarterGui_upvr (readonly)

	]]

	local xpcall_result1_11, xpcall_result2_4 = xpcall(function() -- Line 167

		--[[ Upvalues[1]:

			[1]: StarterGui_upvr (copied, readonly)

		]]

		return StarterGui_upvr:GetCore("TopbarEnabled")

	end, function(arg1) -- Line 169

		return true

	end)

	return xpcall_result1_11 and xpcall_result2_4

end

local function _() -- Line 176, Named "checkTopbarEnabledAccountingForMimic"

	--[[ Upvalues[2]:

		[1]: StarterGui_upvr (readonly)

		[2]: module_upvr (readonly)

	]]

	local xpcall_result1_3, xpcall_result2_2 = xpcall(function() -- Line 167

		--[[ Upvalues[1]:

			[1]: StarterGui_upvr (copied, readonly)

		]]

		return StarterGui_upvr:GetCore("TopbarEnabled")

	end, function(arg1) -- Line 169

		return true

	end)

	local var18 = xpcall_result1_3 and xpcall_result2_2

	if not var18 then

		var18 = not module_upvr.mimicCoreGui

	end

	return var18

end

local tbl_2_upvr = {}

local tbl_4 = {

	startScale = 0;

}

local function getOffset() -- Line 187

	--[[ Upvalues[2]:

		[1]: module_upvr (readonly)

		[2]: StarterGui_upvr (readonly)

	]]

	local xpcall_result1_2, xpcall_result2_7 = xpcall(function() -- Line 167

		--[[ Upvalues[1]:

			[1]: StarterGui_upvr (copied, readonly)

		]]

		return StarterGui_upvr:GetCore("TopbarEnabled")

	end, function(arg1) -- Line 169

		return true

	end)

	local var25 = 0

	if xpcall_result1_2 and xpcall_result2_7 and StarterGui_upvr:GetCoreGuiEnabled("Chat") then

		var25 += 44

	end

	return var25

end

tbl_4.getOffset = getOffset

local function getStartOffset() -- Line 194

	--[[ Upvalues[2]:

		[1]: module_upvr (readonly)

		[2]: tbl_2_upvr (readonly)

	]]

	return tbl_2_upvr.left.getOffset() + module_upvr.leftGap

end

tbl_4.getStartOffset = getStartOffset

tbl_4.records = {}

tbl_2_upvr.left = tbl_4

local tbl = {

	startScale = 0.5;

}

local function getOffset() -- Line 203

	return 0

end

tbl.getOffset = getOffset

local function getStartOffset(arg1) -- Line 206

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	return -arg1 / 2 + module_upvr.midGap / 2

end

tbl.getStartOffset = getStartOffset

tbl.records = {}

tbl_2_upvr.mid = tbl

tbl_2_upvr.right = {

	startScale = 1;

	getOffset = function() -- Line 214, Named "getOffset"

		--[[ Upvalues[2]:

			[1]: module_upvr (readonly)

			[2]: StarterGui_upvr (readonly)

		]]

		local rightOffset = module_upvr.rightOffset

		local xpcall_result1_6, xpcall_result2_8 = xpcall(function() -- Line 167

			--[[ Upvalues[1]:

				[1]: StarterGui_upvr (copied, readonly)

			]]

			return StarterGui_upvr:GetCore("TopbarEnabled")

		end, function(arg1) -- Line 169

			return true

		end)

		if xpcall_result1_6 and xpcall_result2_8 and (StarterGui_upvr:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) or StarterGui_upvr:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) or StarterGui_upvr:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)) then

			rightOffset += 48

		end

		return rightOffset

	end;

	getStartOffset = function(arg1) -- Line 221, Named "getStartOffset"

		--[[ Upvalues[1]:

			[1]: tbl_2_upvr (readonly)

		]]

		return -arg1 - tbl_2_upvr.right.getOffset()

	end;

	records = {};

}

module_upvr.topbarEnabled = true

module_upvr.controllerModeEnabled = false

local xpcall_result1_5, xpcall_result2_3 = xpcall(function() -- Line 167

	--[[ Upvalues[1]:

		[1]: StarterGui_upvr (readonly)

	]]

	return StarterGui_upvr:GetCore("TopbarEnabled")

end, function(arg1) -- Line 169

	return true

end)

module_upvr.previousTopbarEnabled = xpcall_result1_5 and xpcall_result2_3

module_upvr.leftGap = 12

module_upvr.midGap = 12

module_upvr.rightGap = 12

module_upvr.leftOffset = 0

module_upvr.rightOffset = 0

module_upvr.mimicCoreGui = true

module_upvr.healthbarDisabled = false

module_upvr.iconAdded = Signal.new()

module_upvr.iconRemoved = Signal.new()

module_upvr.controllerModeStarted = Signal.new()

module_upvr.controllerModeEnded = Signal.new()

module_upvr.healthbarDisabledSignal = Signal.new()

local var38_upvw = 0

module_upvr.iconAdded:Connect(function(arg1) -- Line 256

	--[[ Upvalues[3]:

		[1]: tbl_3_upvr (readonly)

		[2]: module_upvr (readonly)

		[3]: var38_upvw (read and write)

	]]

	tbl_3_upvr[arg1] = true

	if module_upvr.gameTheme then

		arg1:setTheme(module_upvr.gameTheme)

	end

	arg1.updated:Connect(function() -- Line 261

		--[[ Upvalues[1]:

			[1]: module_upvr (copied, readonly)

		]]

		module_upvr.updateTopbar()

	end)

	arg1.selected:Connect(function() -- Line 265

		--[[ Upvalues[2]:

			[1]: module_upvr (copied, readonly)

			[2]: arg1 (readonly)

		]]

		for _, v in pairs(module_upvr.getIcons()) do

			if arg1.deselectWhenOtherIconSelected and v ~= arg1 and v.deselectWhenOtherIconSelected and v:getToggleState() == "selected" then

				v:deselect(arg1)

			end

		end

	end)

	var38_upvw += 1

	arg1:setOrder(var38_upvw)

	if module_upvr.controllerModeEnabled then

		module_upvr._enableControllerModeForIcon(arg1, true)

	end

	module_upvr:_updateSelectionGroup()

	module_upvr.updateTopbar()

end)

module_upvr.iconRemoved:Connect(function(arg1) -- Line 284

	--[[ Upvalues[2]:

		[1]: tbl_3_upvr (readonly)

		[2]: module_upvr (readonly)

	]]

	tbl_3_upvr[arg1] = nil

	arg1:setEnabled(false)

	arg1:deselect()

	arg1.updated:Fire()

	module_upvr:_updateSelectionGroup()

end)

function module_upvr.setGameTheme(arg1) -- Line 295

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	module_upvr.gameTheme = arg1

	for _, v_2 in pairs(module_upvr.getIcons()) do

		v_2:setTheme(arg1)

	end

end

function module_upvr.setDisplayOrder(arg1) -- Line 303

	--[[ Upvalues[1]:

		[1]: TopbarPlusGui_upvr (readonly)

	]]

	local tonumber_result1 = tonumber(arg1)

	if not tonumber_result1 then

		tonumber_result1 = TopbarPlusGui_upvr.DisplayOrder

	end

	TopbarPlusGui_upvr.DisplayOrder = tonumber_result1

end

module_upvr.setDisplayOrder(10)

function module_upvr.getIcons() -- Line 309

	--[[ Upvalues[1]:

		[1]: tbl_3_upvr (readonly)

	]]

	local module = {}

	for i_3, _ in pairs(tbl_3_upvr) do

		table.insert(module, i_3)

	end

	return module

end

function module_upvr.getIcon(arg1) -- Line 317

	--[[ Upvalues[1]:

		[1]: tbl_3_upvr (readonly)

	]]

	for i_4, _ in pairs(tbl_3_upvr) do

		if i_4.name == arg1 then

			return i_4

		end

	end

	return false

end

function module_upvr.disableHealthbar(arg1) -- Line 326

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	local var66 = true

	if arg1 ~= nil then

		var66 = arg1

	end

	module_upvr.healthbarDisabled = var66

	module_upvr.healthbarDisabledSignal:Fire(var66)

end

function module_upvr.canShowIconOnTopbar(arg1) -- Line 332

	if arg1.enabled == true or arg1.accountForWhenDisabled then

		if arg1.presentOnTopbar then

			return true

		end

	end

	return false

end

function module_upvr.getMenuOffset(arg1) -- Line 339

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	local var67 = module_upvr[arg1:get("alignment").."Gap"]

	local any_get_result1_7 = arg1:get("iconSize")

	if not any_get_result1_7 then

		any_get_result1_7 = UDim2.new(0, 32, 0, 32)

	end

	local var69 = 0

	local var70 = 0

	local var71 = 0

	if arg1.menuOpen then

		local Offset = arg1:get("menuSize").X.Offset

		local any__getMenuDirection_result1 = arg1:_getMenuDirection()

		if any__getMenuDirection_result1 == "right" then

			var70 += Offset + var67 / 6

			return var69, var70, var71

		end

		if any__getMenuDirection_result1 == "left" then

			var69 = Offset + 4

			var70 += var67 / 3

			var71 = Offset

		end

	end

	return var69, var70, var71

end

local var74_upvw = false

local var75_upvw = false

local TweenService_upvr = game:GetService("TweenService")

function module_upvr.updateTopbar() -- Line 365

	--[[ Upvalues[8]:

		[1]: module_upvr (readonly)

		[2]: var74_upvw (read and write)

		[3]: var75_upvw (read and write)

		[4]: RunService_upvr (readonly)

		[5]: tbl_2_upvr (readonly)

		[6]: tbl_3_upvr (readonly)

		[7]: TopbarPlusGui_upvr (readonly)

		[8]: TweenService_upvr (readonly)

	]]

	local function getIncrement_upvr(arg1, arg2) -- Line 366, Named "getIncrement"

		--[[ Upvalues[1]:

			[1]: module_upvr (copied, readonly)

		]]

		local any_get_result1_2 = arg1:get("iconSize", arg1:getIconState())

		if not any_get_result1_2 then

			any_get_result1_2 = UDim2.new(0, 32, 0, 32)

		end

		local var78 = any_get_result1_2.X.Offset + module_upvr[arg2.."Gap"]

		local var79 = 0

		if arg1._parentIcon == nil then

			local any_getMenuOffset_result1_2, any_getMenuOffset_result2_2, any_getMenuOffset_result3 = module_upvr.getMenuOffset(arg1)

			var79 += any_getMenuOffset_result1_2

			var78 += any_getMenuOffset_result2_2 + any_getMenuOffset_result3

		end

		return var78, var79

	end

	if var74_upvw then

		var75_upvw = true

		return false

	end

	coroutine.wrap(function() -- Line 386

		--[[ Upvalues[9]:

			[1]: var74_upvw (copied, read and write)

			[2]: RunService_upvr (copied, readonly)

			[3]: tbl_2_upvr (copied, readonly)

			[4]: tbl_3_upvr (copied, readonly)

			[5]: module_upvr (copied, readonly)

			[6]: getIncrement_upvr (readonly)

			[7]: TopbarPlusGui_upvr (copied, readonly)

			[8]: TweenService_upvr (copied, readonly)

			[9]: var75_upvw (copied, read and write)

		]]

		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

		-- KONSTANTERROR: [0] 1. Error Block 168 start (CF ANALYSIS FAILED)

		var74_upvw = true

		RunService_upvr.Heartbeat:Wait()

		var74_upvw = false

		local var135

		for _, v_5 in pairs(tbl_2_upvr) do

			v_5.records = {}

		end

		for i_6, _ in pairs(tbl_3_upvr) do

			if module_upvr.canShowIconOnTopbar(i_6) then

			var135 = tbl_2_upvr[i_6:get("alignment")]
			if var135 then
				table.insert(var135.records, i_6)
			end

			end

		end

		local ViewportSize = workspace.CurrentCamera.ViewportSize

		for i_7, v_7 in pairs(tbl_2_upvr) do

			local records = v_7.records

			var135 = #records

			if 1 < var135 then

				var135 = v_7.reverseSort

				if var135 then

					var135 = table.sort

					var135(records, function(arg1, arg2) -- Line 406

						local var145

						if arg2:get("order") >= arg1:get("order") then

							var145 = false

						else

							var145 = true

						end

						return var145

					end)

				else

					var135 = table.sort

					var135(records, function(arg1, arg2) -- Line 408

						local var147

						if arg1:get("order") >= arg2:get("order") then

							var147 = false

						else

							var147 = true

						end

						return var147

					end)

				end

			end

			var135 = 0

			for _, v_8 in pairs(records) do

				var135 += getIncrement_upvr(v_8, i_7)

			end

			local any_getStartOffset_result1 = v_7.getStartOffset(var135, i_7)

			local _ = any_getStartOffset_result1

			for _, v_9 in pairs(records) do

				local _, _ = getIncrement_upvr(v_9, i_7)

				local var158

			end

			for _, v_10 in pairs(records) do

				local getIncrement_upvr_result1, getIncrement_upvr_result2 = getIncrement_upvr(v_10, i_7)

				local topPadding = v_10.topPadding

				local udim2 = UDim2.new(v_7.startScale, any_getStartOffset_result1 + getIncrement_upvr_result2, topPadding.Scale, topPadding.Offset)

				local any_get_result1_6 = v_10:get("repositionInfo")

				if any_get_result1_6 then

					TweenService_upvr:Create(v_10.instances.iconContainer, any_get_result1_6, {

						Position = udim2;

					}):Play()

				else

					-- KONSTANTERROR: Expression was reused, decompilation is incorrect

					v_10.instances.iconContainer.Position = udim2

				end

				v_10.targetPosition = UDim2.new(0, udim2.X.Scale * ViewportSize.X + udim2.X.Offset, 0, udim2.Y.Scale * ViewportSize.Y + udim2.Y.Offset)

			end

		end

		local function _(arg1, arg2, arg3) -- Line 444, Named "getBoundaryX"

			--[[ Upvalues[1]:

				[1]: module_upvr (copied, readonly)

			]]

			local var168 = arg3 or 0

			local any_getMenuOffset_result1_4, any_getMenuOffset_result2 = module_upvr.getMenuOffset(arg1)

			local var171

			local function INLINED() -- Internal function, doesn't exist in bytecode

				var171 = -var168 - any_getMenuOffset_result1_4

				return var171

			end

			if arg2 ~= "left" or not INLINED() then

				var171 = false

				if arg2 == "right" then

					var171 = arg1:get("iconSize", arg1:getIconState()).X.Offset + var168 + any_getMenuOffset_result2

				end

			end

			return arg1.targetPosition.X.Offset + var171

		end

		local function _(arg1, arg2) -- Line 453, Named "getSizeX"

			--[[ Upvalues[1]:

				[1]: module_upvr (copied, readonly)

			]]

			local any_get_result1_4, any_get_result2_2 = arg1:get("iconSize", arg1:getIconState(), "beforeDropdown")

			local any_get_result1_5 = arg1:get("iconSize", "hovering")

			local var181

			if var181 and any_get_result2_2 and any_get_result1_5 then

				var181 = any_get_result1_5.X.Offset

				if any_get_result2_2.X.Offset < var181 then

					any_get_result2_2 = any_get_result1_5

				end

			end

			local function INLINED_3() -- Internal function, doesn't exist in bytecode

				var181 = any_get_result2_2

				return var181

			end

			if not arg2 or not INLINED_3() then

				var181 = any_get_result1_4

			end

			local any_getMenuOffset_result1_3, any_getMenuOffset_result2_4 = module_upvr.getMenuOffset(arg1)

			return var181.X.Offset + any_getMenuOffset_result1_3 + any_getMenuOffset_result2_4

		end

		local pairs_result1_8, pairs_result2_7, pairs_result3_2 = pairs(tbl_2_upvr)

		-- KONSTANTERROR: [0] 1. Error Block 168 end (CF ANALYSIS FAILED)

		-- KONSTANTERROR: [700] 505. Error Block 128 start (CF ANALYSIS FAILED)

		-- KONSTANTERROR: [700] 505. Error Block 128 end (CF ANALYSIS FAILED)

		-- KONSTANTERROR: [218] 158. Error Block 25 start (CF ANALYSIS FAILED)

		-- KONSTANTERROR: [218] 158. Error Block 25 end (CF ANALYSIS FAILED)

	end)()

end

local var187_upvw = false

local HapticService_upvr = game:GetService("HapticService")

function module_upvr.setTopbarEnabled(arg1, arg2) -- Line 631

	--[[ Upvalues[9]:

		[1]: TopbarPlusGui_upvr (readonly)

		[2]: var187_upvw (read and write)

		[3]: StarterGui_upvr (readonly)

		[4]: module_upvr (readonly)

		[5]: var9_upvw (read and write)

		[6]: HapticService_upvr (readonly)

		[7]: RunService_upvr (readonly)

		[8]: tbl_3_upvr (readonly)

		[9]: GuiService_upvr (readonly)

	]]

	if arg2 == nil then

		local var215 = true

	end

	local Indicator = TopbarPlusGui_upvr.Indicator

	if var215 and not arg1 then

		var187_upvw = true

	elseif var215 and arg1 then

		var187_upvw = false

	end

	local xpcall_result1_10, xpcall_result2_5 = xpcall(function() -- Line 167

		--[[ Upvalues[1]:

			[1]: StarterGui_upvr (copied, readonly)

		]]

		return StarterGui_upvr:GetCore("TopbarEnabled")

	end, function(arg1_3) -- Line 169

		return true

	end)

	local var221 = xpcall_result1_10 and xpcall_result2_5

	if not var221 then

		var221 = not module_upvr.mimicCoreGui

	end

	local var222 = var221

	local var223

	if var223 then

		if arg1 then

			var223 = TopbarPlusGui_upvr.TopbarContainer.Visible

			local function INLINED_4() -- Internal function, doesn't exist in bytecode

				var223 = var187_upvw

				return var223

			end

			local function INLINED_5() -- Internal function, doesn't exist in bytecode

				var223 = var9_upvw

				return var223

			end

			if var223 or INLINED_4() or INLINED_5() or not var222 then

			else

				if var215 then

					Indicator.Visible = var222

					return

				end

				var223 = HapticService_upvr:IsVibrationSupported(Enum.UserInputType.Gamepad1)

				if var223 then

					var223 = HapticService_upvr:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small)

					if var223 then

						var223 = HapticService_upvr.SetMotor

						var223(HapticService_upvr, Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 1)

						var223 = delay

						var223(0.2, function() -- Line 650

							--[[ Upvalues[1]:

								[1]: HapticService_upvr (copied, readonly)

							]]

							pcall(function() -- Line 651

								--[[ Upvalues[1]:

									[1]: HapticService_upvr (copied, readonly)

								]]

								HapticService_upvr:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0)

							end)

						end)

					end

				end

				var223 = TopbarPlusGui_upvr.TopbarContainer

				var223.Visible = true

				var223 = TopbarPlusGui_upvr.TopbarContainer.TweenPosition

				var223(TopbarPlusGui_upvr.TopbarContainer, UDim2.new(0, 0, 0, 37), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)

				var223 = nil

				local var226 = var223

				module_upvr:_updateSelectionGroup()

				RunService_upvr.Heartbeat:Wait()

				for i_13, _ in pairs(tbl_3_upvr) do

					if module_upvr.canShowIconOnTopbar(i_13) and (var226 == nil or var226:get("order") < i_13:get("order")) then

						var226 = i_13

					end

					local var230 = -27 + i_13.instances.iconContainer.AbsoluteSize.Y + 50

					if 0 < var230 then

					end

				end

				if GuiService_upvr:GetEmotesMenuOpen() then

					GuiService_upvr:SetEmotesMenuOpen(false)

				end

				if GuiService_upvr:GetInspectMenuEnabled() then

					GuiService_upvr:CloseInspectMenu()

				end

				local _previousSelectedObject = module_upvr._previousSelectedObject

				if not _previousSelectedObject then

					_previousSelectedObject = var226.instances.iconButton

				end

				module_upvr._setControllerSelectedObject(_previousSelectedObject)

				Indicator.Image = "rbxassetid://5278151071"

				Indicator:TweenPosition(UDim2.new(0.5, 0, 0, var230 + 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)

			end

		end

		if var215 then

			var226 = false

			Indicator.Visible = var226

		else

			Indicator.Visible = var222

		end

		var226 = TopbarPlusGui_upvr.TopbarContainer.Visible

		if not var226 then

		else

			var226 = GuiService_upvr

			var226.AutoSelectGuiEnabled = true

			var226 = module_upvr._updateSelectionGroup

			var226(module_upvr, true)

			var226 = TopbarPlusGui_upvr.TopbarContainer

			var226 = var226.TweenPosition

			var226(UDim2.new(0, 0, 0, -TopbarPlusGui_upvr.TopbarContainer.Size.Y.Offset + 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() -- Line 713

				--[[ Upvalues[1]:

					[1]: TopbarPlusGui_upvr (copied, readonly)

				]]

				TopbarPlusGui_upvr.TopbarContainer.Visible = false

			end)

			var226 = "rbxassetid://5278151556"

			Indicator.Image = var226

			var226 = Indicator.TweenPosition

			var226(Indicator, UDim2.new(0.5, 0, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)

		end

	end

	var226 = TopbarPlusGui_upvr.TopbarContainer

	local var233 = var226

	if var222 then

		var233.Visible = arg1

	else

		var233.Visible = false

	end

end

function module_upvr.setGap(arg1, arg2) -- Line 736

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	local var234 = tonumber(arg1) or 12

	local any_lower_result1 = tostring(arg2):lower()

	if any_lower_result1 == "left" or any_lower_result1 == "mid" or any_lower_result1 == "right" then

		module_upvr[any_lower_result1.."Gap"] = var234

		module_upvr.updateTopbar()

	else

		module_upvr.leftGap = var234

		module_upvr.midGap = var234

		module_upvr.rightGap = var234

		module_upvr.updateTopbar()

	end

end

function module_upvr.setLeftOffset(arg1) -- Line 750

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	module_upvr.leftOffset = tonumber(arg1) or 0

	module_upvr.updateTopbar()

end

function module_upvr.setRightOffset(arg1) -- Line 755

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	module_upvr.rightOffset = tonumber(arg1) or 0

	module_upvr.updateTopbar()

end

local LocalPlayer_upvr = Players_upvr.LocalPlayer

local tbl_5_upvw = {}

LocalPlayer_upvr.CharacterAdded:Connect(function() -- Line 762

	--[[ Upvalues[1]:

		[1]: tbl_5_upvw (read and write)

	]]

	for _, v_11 in pairs(tbl_5_upvw) do

		v_11:destroy()

	end

	tbl_5_upvw = {}

end)

function module_upvr.clearIconOnSpawn(arg1) -- Line 768

	--[[ Upvalues[2]:

		[1]: LocalPlayer_upvr (readonly)

		[2]: tbl_5_upvw (read and write)

	]]

	coroutine.wrap(function() -- Line 769

		--[[ Upvalues[3]:

			[1]: LocalPlayer_upvr (copied, readonly)

			[2]: tbl_5_upvw (copied, read and write)

			[3]: arg1 (readonly)

		]]

		if not LocalPlayer_upvr.Character then

		end

		table.insert(tbl_5_upvw, arg1)

	end)()

end

function module_upvr._updateSelectionGroup(arg1, arg2) -- Line 778

	--[[ Upvalues[2]:

		[1]: module_upvr (readonly)

		[2]: GuiService_upvr (readonly)

	]]

	if module_upvr._navigationEnabled then

		GuiService_upvr:RemoveSelectionGroup("TopbarPlusIcons")

	end

	if arg2 then

		GuiService_upvr.CoreGuiNavigationEnabled = module_upvr._originalCoreGuiNavigationEnabled

		GuiService_upvr.GuiNavigationEnabled = module_upvr._originalGuiNavigationEnabled

		module_upvr._navigationEnabled = nil

	elseif module_upvr.controllerModeEnabled then

		for _, v_15 in pairs(module_upvr.getIcons()) do

			if not v_15.joinedFeatureName or v_15._parentIcon[v_15.joinedFeatureName.."Open"] == true then

				table.insert({}, v_15.instances.iconButton)

			end

		end

		-- KONSTANTERROR: Expression was reused, decompilation is incorrect

		GuiService_upvr:AddSelectionTuple("TopbarPlusIcons", table.unpack({}))

		if not module_upvr._navigationEnabled then

			module_upvr._originalCoreGuiNavigationEnabled = GuiService_upvr.CoreGuiNavigationEnabled

			module_upvr._originalGuiNavigationEnabled = GuiService_upvr.GuiNavigationEnabled

			GuiService_upvr.CoreGuiNavigationEnabled = false

			GuiService_upvr.GuiNavigationEnabled = true

			module_upvr._navigationEnabled = true

		end

	end

end

local function _() -- Line 806, Named "getScaleMultiplier"

	--[[ Upvalues[1]:

		[1]: GuiService_upvr (readonly)

	]]

	if GuiService_upvr:IsTenFootInterface() then

		return 3

	end

	return 1.3

end

function module_upvr._setControllerSelectedObject(arg1) -- Line 814

	--[[ Upvalues[2]:

		[1]: module_upvr (readonly)

		[2]: GuiService_upvr (readonly)

	]]

	local var250_upvr

	local function INLINED_6() -- Internal function, doesn't exist in bytecode

		var250_upvr = module_upvr._controllerSetCount + 1

		return var250_upvr

	end

	if not module_upvr._controllerSetCount or not INLINED_6() then

		var250_upvr = 0

	end

	module_upvr._controllerSetCount = var250_upvr

	GuiService_upvr.SelectedObject = arg1

	delay(0.1, function() -- Line 818

		--[[ Upvalues[4]:

			[1]: module_upvr (copied, readonly)

			[2]: var250_upvr (readonly)

			[3]: GuiService_upvr (copied, readonly)

			[4]: arg1 (readonly)

		]]

		if var250_upvr == module_upvr._controllerSetCount then

			GuiService_upvr.SelectedObject = arg1

		end

	end)

end

function module_upvr._enableControllerMode(arg1) -- Line 826

	--[[ Upvalues[5]:

		[1]: TopbarPlusGui_upvr (readonly)

		[2]: module_upvr (readonly)

		[3]: GuiService_upvr (readonly)

		[4]: StarterGui_upvr (readonly)

		[5]: tbl_3_upvr (readonly)

	]]

	local Indicator_3 = TopbarPlusGui_upvr.Indicator

	if module_upvr.controllerModeEnabled == arg1 then

	else

		module_upvr.controllerModeEnabled = arg1

		if arg1 then

			TopbarPlusGui_upvr.TopbarContainer.Position = UDim2.new(0, 0, 0, 5)

			local TopbarContainer = TopbarPlusGui_upvr.TopbarContainer

			TopbarContainer.Visible = false

			if GuiService_upvr:IsTenFootInterface() then

				TopbarContainer = 3

			else

				TopbarContainer = 1.3

			end

			Indicator_3.Position = UDim2.new(0.5, 0, 0, 5)

			Indicator_3.Size = UDim2.new(0, 18 * TopbarContainer, 0, 18 * TopbarContainer)

			Indicator_3.Image = "rbxassetid://5278151556"

			local xpcall_result1_9, xpcall_result2 = xpcall(function() -- Line 167

				--[[ Upvalues[1]:

					[1]: StarterGui_upvr (copied, readonly)

				]]

				return StarterGui_upvr:GetCore("TopbarEnabled")

			end, function(arg1_4) -- Line 169

				return true

			end)

			local var262 = xpcall_result1_9 and xpcall_result2

			if not var262 then

				var262 = not module_upvr.mimicCoreGui

			end

			Indicator_3.Visible = var262

			Indicator_3.Position = UDim2.new(0.5, 0, 0, 5)

		else

			TopbarPlusGui_upvr.TopbarContainer.Position = UDim2.new(0, 0, 0, 0)

			local xpcall_result1_4, xpcall_result2_11 = xpcall(function() -- Line 167

				--[[ Upvalues[1]:

					[1]: StarterGui_upvr (copied, readonly)

				]]

				return StarterGui_upvr:GetCore("TopbarEnabled")

			end, function(arg1_5) -- Line 169

				return true

			end)

			local var267 = xpcall_result1_4 and xpcall_result2_11

			if not var267 then

				var267 = not module_upvr.mimicCoreGui

			end

			TopbarPlusGui_upvr.TopbarContainer.Visible = var267

			Indicator_3.Visible = false

			module_upvr._setControllerSelectedObject(nil)

		end

		for i_14, _ in pairs(tbl_3_upvr) do

			module_upvr._enableControllerModeForIcon(i_14, arg1)

		end

	end

end

function module_upvr._enableControllerModeForIcon(arg1, arg2) -- Line 853

	--[[ Upvalues[1]:

		[1]: GuiService_upvr (readonly)

	]]

	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [5] 4. Error Block 2 start (CF ANALYSIS FAILED)

	arg1:leave()

	-- KONSTANTERROR: [5] 4. Error Block 2 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [8] 6. Error Block 3 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [8] 6. Error Block 3 end (CF ANALYSIS FAILED)

end

local var271_upvw = false

function module_upvr.setupHealthbar() -- Line 890

	--[[ Upvalues[5]:

		[1]: var271_upvw (read and write)

		[2]: RunService_upvr (readonly)

		[3]: StarterGui_upvr (readonly)

		[4]: module_upvr (readonly)

		[5]: LocalPlayer_upvr (readonly)

	]]

	if var271_upvw then

	else

		var271_upvw = true

		task.defer(function() -- Line 898

			--[[ Upvalues[4]:

				[1]: RunService_upvr (copied, readonly)

				[2]: StarterGui_upvr (copied, readonly)

				[3]: module_upvr (copied, readonly)

				[4]: LocalPlayer_upvr (copied, readonly)

			]]

			RunService_upvr.Heartbeat:Wait()

			require(script.Parent).new():setProperty("internalIcon", true):setName("_FakeHealthbar"):setRight():setOrder(-420):setSize(80, 32):lock():set("iconBackgroundTransparency", 1):give(function(arg1) -- Line 910

				--[[ Upvalues[3]:

					[1]: StarterGui_upvr (copied, readonly)

					[2]: module_upvr (copied, readonly)

					[3]: LocalPlayer_upvr (copied, readonly)

				]]

				local Frame = Instance.new("Frame")

				Frame.Name = "HealthContainer"

				Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

				Frame.BorderSizePixel = 0

				Frame.AnchorPoint = Vector2.new(0, 0.5)

				Frame.Position = UDim2.new(0, 0, 0.5, 0)

				Frame.Size = UDim2.new(1, 0, 0.2, 0)

				Frame.Visible = true

				Frame.ZIndex = 11

				Frame.Parent = arg1.instances.iconButton

				local UICorner = Instance.new("UICorner")

				UICorner.CornerRadius = UDim.new(1, 0)

				UICorner.Parent = Frame

				local clone = Frame:Clone()

				clone.Name = "HealthFrame"

				clone.BackgroundColor3 = Color3.fromRGB(167, 167, 167)

				clone.BorderSizePixel = 0

				clone.AnchorPoint = Vector2.new(0.5, 0.5)

				clone.Position = UDim2.new(0.5, 0, 0.5, 0)

				clone.Size = UDim2.new(1, -2, 1, -2)

				clone.Visible = true

				clone.ZIndex = 12

				clone.Parent = Frame

				local clone_2_upvr = clone:Clone()

				clone_2_upvr.Name = "HealthBar"

				clone_2_upvr.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

				clone_2_upvr.BorderSizePixel = 0

				clone_2_upvr.AnchorPoint = Vector2.new(0, 0.5)

				clone_2_upvr.Position = UDim2.new(0, 0, 0.5, 0)

				clone_2_upvr.Size = UDim2.new(0.5, 0, 1, 0)

				clone_2_upvr.Visible = true

				clone_2_upvr.ZIndex = 13

				clone_2_upvr.Parent = clone

				local function powColor3_upvr(arg1_6, arg2) -- Line 953, Named "powColor3"

					return Color3.new(math.pow(arg1_6.R, arg2), math.pow(arg1_6.G, arg2), math.pow(arg1_6.B, arg2))

				end

				local function _(arg1_7, arg2, arg3, arg4) -- Line 961, Named "lerpColor"

					--[[ Upvalues[1]:

						[1]: powColor3_upvr (readonly)

					]]

					local var278 = arg4 or 2

					local var279 = var278

					local var280 = var278

					return powColor3_upvr(Color3.new(math.pow(arg1_7.R, var279), math.pow(arg1_7.G, var279), math.pow(arg1_7.B, var279)):Lerp(Color3.new(math.pow(arg2.R, var280), math.pow(arg2.G, var280), math.pow(arg2.B, var280)), arg3), 1 / var278)

				end

				local var281_upvw = true

				local Color3_fromRGB_result1_upvr_2 = Color3.fromRGB(27, 252, 107)

				local Color3_fromRGB_result1_upvr = Color3.fromRGB(250, 235, 0)

				local Color3_fromRGB_result1_upvr_3 = Color3.fromRGB(255, 28, 0)

				local function listenToHealth_upvr(arg1_8) -- Line 969, Named "listenToHealth"

					--[[ Upvalues[8]:

						[1]: StarterGui_upvr (copied, readonly)

						[2]: module_upvr (copied, readonly)

						[3]: var281_upvw (read and write)

						[4]: arg1 (readonly)

						[5]: Color3_fromRGB_result1_upvr_2 (readonly)

						[6]: Color3_fromRGB_result1_upvr (readonly)

						[7]: Color3_fromRGB_result1_upvr_3 (readonly)

						[8]: clone_2_upvr (readonly)

					]]

					if not arg1_8 then

					else

						local Humanoid_upvr = arg1_8:WaitForChild("Humanoid", 10)

						if not Humanoid_upvr then return end

						local function updateHealthBar() -- Line 978

							--[[ Upvalues[9]:

								[1]: StarterGui_upvr (copied, readonly)

								[2]: Humanoid_upvr (readonly)

								[3]: module_upvr (copied, readonly)

								[4]: var281_upvw (copied, read and write)

								[5]: arg1 (copied, readonly)

								[6]: Color3_fromRGB_result1_upvr_2 (copied, readonly)

								[7]: Color3_fromRGB_result1_upvr (copied, readonly)

								[8]: Color3_fromRGB_result1_upvr_3 (copied, readonly)

								[9]: clone_2_upvr (copied, readonly)

							]]

							-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

							local var286 = Humanoid_upvr.Health / Humanoid_upvr.MaxHealth

							local var287

							if var286 == 1 or module_upvr.healthbarDisabled or var281_upvw and StarterGui_upvr:GetCoreGuiEnabled(Enum.CoreGuiType.Health) == false then

								if arg1.enabled then

									arg1:setEnabled(false)

								end

							else

								if var286 < 1 then

									if not arg1.enabled then

										arg1:setEnabled(true)

									end

									var281_upvw = false

									-- KONSTANTERROR: Expression was reused, decompilation is incorrect

									if StarterGui_upvr:GetCoreGuiEnabled(Enum.CoreGuiType.Health) then

										var287 = false

										StarterGui_upvr:SetCoreGuiEnabled(Enum.CoreGuiType.Health, var287)

									end

								end

								local var288 = 1.25 * var286

								local var289 = var288 + -0.125

								if 1 < var289 then

									var288 = 1

								elseif var289 < 0 then

									var288 = 0

								else

									var288 = var289

								end

								var287 = 0.5

								if var287 >= var286 or not Color3_fromRGB_result1_upvr_2 then

									local var290 = Color3_fromRGB_result1_upvr

								end

								local function INLINED_7() -- Internal function, doesn't exist in bytecode

									var287 = Color3_fromRGB_result1_upvr

									return var287

								end

								if 0.5 >= var286 or not INLINED_7() then

									var287 = Color3_fromRGB_result1_upvr_3

								end

								local var291 = (1 - var288) * 2

								if 0.5 >= var286 or not (1 - var291) then

								end

								local var292 = nil or 2

								local var293 = var292

								local var294 = var292

								local any_Lerp_result1 = Color3.new(math.pow(var287.R, var293), math.pow(var287.G, var293), math.pow(var287.B, var293)):Lerp(Color3.new(math.pow(var290.R, var294), math.pow(var290.G, var294), math.pow(var290.B, var294)), 2 - var291)

								local var296 = 1 / var292

								clone_2_upvr.BackgroundColor3 = Color3.new(math.pow(any_Lerp_result1.R, var296), math.pow(any_Lerp_result1.G, var296), math.pow(any_Lerp_result1.B, var296))

								clone_2_upvr.Size = UDim2.new(var286, 0, 1, 0)

							end

						end

						Humanoid_upvr.HealthChanged:Connect(updateHealthBar)

						module_upvr.healthbarDisabledSignal:Connect(updateHealthBar)

						updateHealthBar()

					end

				end

				LocalPlayer_upvr.CharacterAdded:Connect(function(arg1_9) -- Line 1015

					--[[ Upvalues[1]:

						[1]: listenToHealth_upvr (readonly)

					]]

					listenToHealth_upvr(arg1_9)

				end)

				task.spawn(listenToHealth_upvr, LocalPlayer_upvr.Character)

			end)

		end)

	end

end

local UserInputService_upvr = game:GetService("UserInputService")

coroutine.wrap(function() -- Line 1027

	--[[ Upvalues[6]:

		[1]: RunService_upvr (readonly)

		[2]: UserInputService_upvr (readonly)

		[3]: module_upvr (readonly)

		[4]: GuiService_upvr (readonly)

		[5]: StarterGui_upvr (readonly)

		[6]: tbl_2_upvr (readonly)

	]]

	RunService_upvr.Heartbeat:Wait()

	local Parent = require(script.Parent)

	local any_setProperty_result1_upvr = Parent.new():setProperty("internalIcon", true):setName("_TopbarControllerOption"):setOrder(100):setImage("rbxassetid://5278150942"):setRight():setEnabled(false):setTip("Controller mode"):setProperty("deselectWhenOtherIconSelected", false)

	local function determineDisplay() -- Line 1045

		--[[ Upvalues[3]:

			[1]: UserInputService_upvr (copied, readonly)

			[2]: any_setProperty_result1_upvr (readonly)

			[3]: module_upvr (copied, readonly)

		]]

		local MouseEnabled = UserInputService_upvr.MouseEnabled

		local GamepadEnabled = UserInputService_upvr.GamepadEnabled

		if MouseEnabled and GamepadEnabled then

			any_setProperty_result1_upvr:setEnabled(true)

		else

			if MouseEnabled then

				if not GamepadEnabled then

					any_setProperty_result1_upvr:setEnabled(false)

					module_upvr._enableControllerMode(false)

					any_setProperty_result1_upvr:deselect()

					return

				end

			end

			if not MouseEnabled and GamepadEnabled then

				any_setProperty_result1_upvr:setEnabled(false)

				module_upvr._enableControllerMode(true)

			end

		end

	end

	UserInputService_upvr:GetPropertyChangedSignal("MouseEnabled"):Connect(determineDisplay)

	UserInputService_upvr.GamepadConnected:Connect(determineDisplay)

	UserInputService_upvr.GamepadDisconnected:Connect(determineDisplay)

	determineDisplay()

	local function iconClicked() -- Line 1069

		--[[ Upvalues[2]:

			[1]: any_setProperty_result1_upvr (readonly)

			[2]: module_upvr (copied, readonly)

		]]

		local var306 = any_setProperty_result1_upvr

		local isSelected = var306.isSelected

		if isSelected then

			var306 = "Normal mode"

		else

			var306 = "Controller mode"

		end

		any_setProperty_result1_upvr:setTip(var306)

		module_upvr._enableControllerMode(isSelected)

	end

	any_setProperty_result1_upvr.selected:Connect(iconClicked)

	any_setProperty_result1_upvr.deselected:Connect(iconClicked)

	UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 1079

		--[[ Upvalues[3]:

			[1]: module_upvr (copied, readonly)

			[2]: GuiService_upvr (copied, readonly)

			[3]: StarterGui_upvr (copied, readonly)

		]]

		-- KONSTANTERROR: [0] 1. Error Block 21 start (CF ANALYSIS FAILED)

		if not module_upvr.controllerModeEnabled then

		else

			if arg1.KeyCode == Enum.KeyCode.DPadDown then

				if not GuiService_upvr.SelectedObject then

					local xpcall_result1_8, xpcall_result2_10 = xpcall(function() -- Line 167

						--[[ Upvalues[1]:

							[1]: StarterGui_upvr (copied, readonly)

						]]

						return StarterGui_upvr:GetCore("TopbarEnabled")

					end, function(arg1_10) -- Line 169

						return true

					end)

					local var313 = xpcall_result1_8 and xpcall_result2_10

					if not var313 then

						var313 = not module_upvr.mimicCoreGui

					end

					if var313 then

						module_upvr.setTopbarEnabled(true, false)

						-- KONSTANTWARNING: GOTO [59] #45

					end

					-- KONSTANTWARNING: GOTO [59] #45

				end

			elseif arg1.KeyCode == Enum.KeyCode.ButtonB then

				module_upvr._previousSelectedObject = GuiService_upvr.SelectedObject

				module_upvr._setControllerSelectedObject(nil)

				module_upvr.setTopbarEnabled(false, false)

			end

			-- KONSTANTERROR: [0] 1. Error Block 21 end (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [59] 45. Error Block 12 start (CF ANALYSIS FAILED)

			arg1:Destroy()

			-- KONSTANTERROR: [59] 45. Error Block 12 end (CF ANALYSIS FAILED)

		end

	end)

	for i_12, v_12 in pairs(tbl_2_upvr) do

		if i_12 ~= "mid" then

			local any_setEnabled_result1 = Parent.new():setProperty("internalIcon", true):setImage(6069276526):setName("_overflowIcon-"..i_12):setEnabled(false)

			v_12.overflowIcon = any_setEnabled_result1

			any_setEnabled_result1.accountForWhenDisabled = true

			if i_12 == "left" then

				any_setEnabled_result1:setOrder(math.huge)

				any_setEnabled_result1:setLeft()

				any_setEnabled_result1:set("dropdownAlignment", "right")

			elseif i_12 == "right" then

				any_setEnabled_result1:setOrder((-math.huge))

				any_setEnabled_result1:setRight()

				any_setEnabled_result1:set("dropdownAlignment", "left")

			end

			any_setEnabled_result1.lockedSettings = {

				iconImage = true;

				order = true;

				alignment = true;

			}

		end

	end

end)()

coroutine.wrap(function() -- Line 1123

	--[[ Upvalues[3]:

		[1]: Players_upvr (readonly)

		[2]: StarterGui_upvr (readonly)

		[3]: module_upvr (readonly)

	]]

	local ChatScript = Players_upvr.LocalPlayer.PlayerScripts:WaitForChild("ChatScript", 4)

	if not ChatScript then

		ChatScript = game:GetService("Chat"):WaitForChild("ChatScript", 4)

	end

	if not ChatScript then

	else

		local ChatMain = ChatScript:FindFirstChild("ChatMain")

		if not ChatMain then return end

		require(ChatMain).CoreGuiEnabled:connect(function() -- Line 1129

			--[[ Upvalues[2]:

				[1]: StarterGui_upvr (copied, readonly)

				[2]: module_upvr (copied, readonly)

			]]

			local xpcall_result1, xpcall_result2_9 = xpcall(function() -- Line 167

				--[[ Upvalues[1]:

					[1]: StarterGui_upvr (copied, readonly)

				]]

				return StarterGui_upvr:GetCore("TopbarEnabled")

			end, function(arg1) -- Line 169

				return true

			end)

			local var327 = xpcall_result1 and xpcall_result2_9

			if var327 == module_upvr.previousTopbarEnabled then

				module_upvr.updateTopbar()

				return "SetCoreGuiEnabled was called instead of SetCore"

			end

			if module_upvr.mimicCoreGui then

				module_upvr.previousTopbarEnabled = var327

				if module_upvr.controllerModeEnabled then

					module_upvr.setTopbarEnabled(false, false)

				else

					module_upvr.setTopbarEnabled(var327, false)

				end

			end

			module_upvr.updateTopbar()

		end)

		local _, _ = xpcall(function() -- Line 167

			--[[ Upvalues[1]:

				[1]: StarterGui_upvr (copied, readonly)

			]]

			return StarterGui_upvr:GetCore("TopbarEnabled")

		end, function(arg1) -- Line 169

			return true

		end)

		local var332

		if not var332 and not module_upvr.mimicCoreGui then

			var332 = true

		end

		module_upvr.setTopbarEnabled(var332, false)

	end

end)()

GuiService_upvr.MenuClosed:Connect(function() -- Line 1153

	--[[ Upvalues[2]:

		[1]: var9_upvw (read and write)

		[2]: module_upvr (readonly)

	]]

	var9_upvw = false

	if not module_upvr.controllerModeEnabled then

		module_upvr.setTopbarEnabled(module_upvr.topbarEnabled, false)

	end

end)

GuiService_upvr.MenuOpened:Connect(function() -- Line 1159

	--[[ Upvalues[2]:

		[1]: var9_upvw (read and write)

		[2]: module_upvr (readonly)

	]]

	var9_upvw = true

	module_upvr.setTopbarEnabled(false, false)

end)

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line 1165

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	module_upvr.updateTopbar()

end)

return module_upvr
