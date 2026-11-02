-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:49
-- Luau version 6, Types version 3
-- Time taken: 0.004693 seconds

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local module_upvr = {}
module_upvr.__index = module_upvr
local any_GetController_result1_upvr = Knit.GetController("DataController")
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local Assets_upvr = ReplicatedStorage.Assets
local MainUI_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI")
function module_upvr.new(arg1, arg2) -- Line 35
	--[[ Upvalues[6]:
		[1]: module_upvr (readonly)
		[2]: any_GetController_result1_upvr (readonly)
		[3]: Util_upvr (readonly)
		[4]: Assets_upvr (readonly)
		[5]: MainUI_upvr (readonly)
		[6]: Functions_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	local var14 = arg2
	if not var14 then
		var14 = {}
	end
	setmetatable_result1._parameters = var14
	setmetatable_result1._ui = arg1
	if arg2.itemId then
		if not arg2.item then
			setmetatable_result1._parameters.itemId = arg2.itemId
			setmetatable_result1._parameters.item = Util_upvr.itemUtils.getItemFromId(any_GetController_result1_upvr.data, arg2.itemId, {
				archived = true;
				equipped = true;
			})
		end
	end
	setmetatable_result1._infoHover = Assets_upvr.UI.InfoHover.InfoHover:Clone()
	setmetatable_result1._infoHover.Parent = MainUI_upvr
	setmetatable_result1._renderId = Functions_upvr.id()
	setmetatable_result1._previousGuiState = nil
	setmetatable_result1._signals = {}
	setmetatable_result1:createInfoHover()
	setmetatable_result1:setInfoHoverAtMouse()
	setmetatable_result1:playSound()
	setmetatable_result1:guiStateChanged()
	setmetatable_result1:setVisible()
	return setmetatable_result1
end
local Types_upvr = require(script.Types)
function module_upvr.createInfoHover(arg1) -- Line 70
	--[[ Upvalues[2]:
		[1]: Types_upvr (readonly)
		[2]: Functions_upvr (readonly)
	]]
	local hoverType = arg1._parameters.hoverType
	local var22
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var22 = arg1._parameters
		return var22.item
	end
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var22 = arg1._parameters
		return var22.hoverType
	end
	if arg1._parameters.itemId or INLINED() or not INLINED_2() then
		var22 = arg1._parameters
		if not var22.item then
			var22 = `DEBUG InfoHover: {arg1._parameters.itemId}, {arg1._parameters.item.nm}, {debug.traceback()}`
			warn(var22)
		end
		var22 = arg1._parameters
		local any_getClass_result1 = var22.item:getClass()
		if any_getClass_result1 == "pet" or any_getClass_result1 == "exclusiveEgg" then
			hoverType = any_getClass_result1
		else
			hoverType = "item"
		end
	end
	if not hoverType or not Types_upvr[hoverType] then return end
	local any_any_result1 = Types_upvr[hoverType](arg1._parameters)
	var22 = 0.1
	local var25 = Functions_upvr.getAmountInTable(any_any_result1) * 0.005
	for i, v in any_any_result1 do
		v.LayoutOrder = i
		v.Parent = arg1._infoHover.Holder
		var22 += v.Size.Y.Scale
	end
	local _infoHover = arg1._infoHover
	_infoHover.Main.Size = UDim2.fromScale(1, var22 + var25)
	_infoHover.Shadow.Size = UDim2.fromScale(1.5, var22 + var25 + 0.32)
end
function module_upvr.hasUI(arg1) -- Line 111
	local var27
	if arg1._infoHover.Parent == nil then
		var27 = false
	else
		var27 = true
	end
	return var27
end
local any_GetController_result1_upvr_3 = Knit.GetController("SoundController")
function module_upvr.playSound(arg1) -- Line 115
	--[[ Upvalues[1]:
		[1]: any_GetController_result1_upvr_3 (readonly)
	]]
	any_GetController_result1_upvr_3:play("Hover", {
		volume = 0.25;
	})
end
function module_upvr.setVisible(arg1) -- Line 121
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	task.spawn(function() -- Line 122
		--[[ Upvalues[2]:
			[1]: RunService_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		RunService_upvr.Heartbeat:Wait()
		arg1._infoHover.Visible = true
	end)
end
function module_upvr.isFrameOutsideScreen(arg1, arg2) -- Line 128
	local var31 = arg2.Parent.AbsolutePosition.Y + arg2.AbsoluteSize.Y
	if workspace.Camera.ViewportSize.Y >= var31 + 60 then
		var31 = false
	else
		var31 = true
	end
	return var31
end
local UserInputService_upvr = game:GetService("UserInputService")
local CurrentCamera_upvr = workspace.CurrentCamera
function module_upvr.setInfoHoverAtMouse(arg1) -- Line 139
	--[[ Upvalues[3]:
		[1]: RunService_upvr (readonly)
		[2]: UserInputService_upvr (readonly)
		[3]: CurrentCamera_upvr (readonly)
	]]
	RunService_upvr:BindToRenderStep(`infoHoverPosition-{arg1._renderId}`, 1, function() -- Line 141
		--[[ Upvalues[3]:
			[1]: UserInputService_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: CurrentCamera_upvr (copied, readonly)
		]]
		local any_GetMouseLocation_result1 = UserInputService_upvr:GetMouseLocation()
		arg1._isOutside = arg1:isFrameOutsideScreen(arg1._infoHover.Main)
		local _infoHover_2 = arg1._infoHover
		local var37 = 0
		if arg1._isOutside then
			var37 = -_infoHover_2.Main.Size.Y.Scale
		end
		_infoHover_2.Main.Position = UDim2.fromScale(0, var37)
		_infoHover_2.Holder.Position = UDim2.new(0.5, 0, var37 + 0.55, 0)
		_infoHover_2.Shadow.Position = UDim2.new(0.5, 0, var37 + -0.16, 0)
		_infoHover_2.Position = UDim2.fromScale(any_GetMouseLocation_result1.X / CurrentCamera_upvr.ViewportSize.X, any_GetMouseLocation_result1.Y / CurrentCamera_upvr.ViewportSize.Y)
	end)
end
function module_upvr.onIdle(arg1) -- Line 162
	arg1:remove()
end
local any_GetController_result1_upvr_2 = Knit.GetController("UIController")
function module_upvr.guiStateChanged(arg1) -- Line 166
	--[[ Upvalues[1]:
		[1]: any_GetController_result1_upvr_2 (readonly)
	]]
	arg1._signals.guiState = arg1._ui:GetPropertyChangedSignal("GuiState"):Connect(function() -- Line 167
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1._ui.GuiState == Enum.GuiState.Idle then
			arg1:onIdle()
		end
	end)
	arg1._signals.onRemove = arg1._ui.AncestryChanged:Connect(function() -- Line 172
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:remove()
	end)
	arg1._signals.onInvisible = arg1._ui:GetPropertyChangedSignal("Visible"):Connect(function() -- Line 175
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:remove()
	end)
	arg1._signals.onClose = any_GetController_result1_upvr_2:listenToClose("InventoryFrame"):Connect(function() -- Line 178
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:remove()
	end)
end
function module_upvr.remove(arg1) -- Line 183
	--[[ Upvalues[2]:
		[1]: RunService_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	for i_2, v_2 in arg1._signals do
		v_2:Disconnect()
		arg1._signals[i_2] = nil
	end
	RunService_upvr:UnbindFromRenderStep(`infoHoverPosition-{arg1._renderId}`)
	arg1._infoHover:Destroy()
	setmetatable(module_upvr, nil)
end
return module_upvr