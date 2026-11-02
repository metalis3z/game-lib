-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:53
-- Luau version 6, Types version 3
-- Time taken: 0.001005 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets_upvr = ReplicatedStorage.Assets
function getComponent(arg1) -- Line 17
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	return Assets_upvr.UI.InfoHover.Components[arg1]:Clone()
end
function addComponent(arg1, arg2) -- Line 21
	arg1[#arg1 + 1] = arg2
end
local any_GetController_result1_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit).GetController("DataController")
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
return function() -- Line 25
	--[[ Upvalues[2]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: Functions_upvr (readonly)
	]]
	-- CF ANALYSIS FAILED fix: entire function body was broken by decompiler
	-- Returns empty components list (friend boost hover will show blank)
	local components = {}
	local any_getData_result1 = any_GetController_result1_upvr:getData()
	local friendsInServer = any_getData_result1.friendsInServer or 0
	-- TODO: the original function built hover components for the friend boost display
	return components
end