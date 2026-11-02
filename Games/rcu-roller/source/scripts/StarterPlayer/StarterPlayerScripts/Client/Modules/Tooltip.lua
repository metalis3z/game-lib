-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:05
-- Luau version 6, Types version 3
-- Time taken: 0.001545 seconds

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local CurrentCamera_upvr = workspace.CurrentCamera
local module_upvr = {}
module_upvr.__index = module_upvr
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
function module_upvr.new(arg1, arg2) -- Line 30
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: Functions_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._renderId = Functions_upvr.id()
	setmetatable_result1:createTooltip()
	setmetatable_result1:setTooltipAtMouse()
	return setmetatable_result1
end
function module_upvr.setTooltipSize(arg1) -- Line 41
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvr (readonly)
	]]
	arg1._ui.Size = UDim2.fromScale(arg1._ui.TextBounds.X / CurrentCamera_upvr.ViewportSize.X + 0.015, arg1._ui.Size.Y.Scale)
end
local Assets_upvr = ReplicatedStorage.Assets
local MainUI_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI")
function module_upvr.createTooltip(arg1) -- Line 49
	--[[ Upvalues[2]:
		[1]: Assets_upvr (readonly)
		[2]: MainUI_upvr (readonly)
	]]
	local clone = Assets_upvr.UI.Tooltip.Tooltip:Clone()
	clone.Parent = MainUI_upvr
	arg1._ui = clone
end
function module_upvr.setText(arg1, arg2) -- Line 57
	arg1._ui.Text = arg2
	arg1:setTooltipSize()
end
local UserInputService_upvr = game:GetService("UserInputService")
function module_upvr.setTooltipAtMouse(arg1) -- Line 62
	--[[ Upvalues[3]:
		[1]: RunService_upvr (readonly)
		[2]: UserInputService_upvr (readonly)
		[3]: CurrentCamera_upvr (readonly)
	]]
	RunService_upvr:BindToRenderStep(`tooltipPosition-{arg1._renderId}`, 1, function() -- Line 64
		--[[ Upvalues[3]:
			[1]: UserInputService_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: CurrentCamera_upvr (copied, readonly)
		]]
		local any_GetMouseLocation_result1 = UserInputService_upvr:GetMouseLocation()
		arg1._ui.Position = UDim2.fromScale(any_GetMouseLocation_result1.X / CurrentCamera_upvr.ViewportSize.X, any_GetMouseLocation_result1.Y / CurrentCamera_upvr.ViewportSize.Y)
	end)
end
function module_upvr.remove(arg1) -- Line 71
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	RunService_upvr:UnbindFromRenderStep(`tooltipPosition-{arg1._renderId}`)
	arg1._ui:Destroy()
end
return module_upvr