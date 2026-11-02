-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:27
-- Luau version 6, Types version 3
-- Time taken: 0.001328 seconds

local module = {}
local var2_upvw
local RunService_upvr = game:GetService("RunService")
function module.setupWorldModel(arg1) -- Line 8
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: RunService_upvr (readonly)
	]]
	local var4
	if var4 then
		var4 = var2_upvw
		return var4
	end
	if RunService_upvr:IsClient() then
		var4 = "ReplicatedStorage"
	else
		var4 = "ServerStorage"
	end
	var2_upvw = Instance.new("WorldModel")
	var2_upvw.Name = "ZonePlusWorldModel"
	var2_upvw.Parent = game:GetService(var4)
	return var2_upvw
end
function module._getCombinedResults(arg1, arg2, ...) -- Line 22
	--[[ Upvalues[1]:
		[1]: var2_upvw (read and write)
	]]
	local workspace_any_result1 = workspace[arg2](workspace, ...)
	if var2_upvw then
		for _, v in pairs(var2_upvw[arg2](var2_upvw, ...)) do
			table.insert(workspace_any_result1, v)
		end
	end
	return workspace_any_result1
end
function module.GetPartBoundsInBox(arg1, arg2, arg3, arg4) -- Line 33
	return arg1:_getCombinedResults("GetPartBoundsInBox", arg2, arg3, arg4)
end
function module.GetPartBoundsInRadius(arg1, arg2, arg3, arg4) -- Line 37
	return arg1:_getCombinedResults("GetPartBoundsInRadius", arg2, arg3, arg4)
end
function module.GetPartsInPart(arg1, arg2, arg3) -- Line 41
	return arg1:_getCombinedResults("GetPartsInPart", arg2, arg3)
end
return module