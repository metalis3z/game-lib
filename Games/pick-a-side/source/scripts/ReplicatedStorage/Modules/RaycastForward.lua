-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:16
-- Luau version 6, Types version 3
-- Time taken: 0.002282 seconds

local new_upvr = Ray.new
local cframe_upvr_2 = CFrame.Angles(0.7853981633974483, 0.6283185307179586, 0)
local cframe_upvr_4 = CFrame.Angles(0.7853981633974483, -0.6283185307179586, 0)
local cframe_upvr = CFrame.Angles(-0.7853981633974483, 0.6283185307179586, 0)
local cframe_upvr_3 = CFrame.Angles(-0.7853981633974483, -0.6283185307179586, 0)
function RaycastForward(arg1, arg2, arg3) -- Line 15
	--[[ Upvalues[5]:
		[1]: new_upvr (readonly)
		[2]: cframe_upvr_2 (readonly)
		[3]: cframe_upvr_4 (readonly)
		[4]: cframe_upvr (readonly)
		[5]: cframe_upvr_3 (readonly)
	]]
	local p = arg1.p
	local tbl = {}
	table.insert(tbl, new_upvr(p, arg1.lookVector * arg2))
	table.insert(tbl, new_upvr(p, (arg1 * cframe_upvr_2).lookVector * arg2))
	table.insert(tbl, new_upvr(p, (arg1 * cframe_upvr_4).lookVector * arg2))
	table.insert(tbl, new_upvr(p, (arg1 * cframe_upvr).lookVector * arg2))
	table.insert(tbl, new_upvr(p, (arg1 * cframe_upvr_3).lookVector * arg2))
	for _, v in pairs(tbl) do
		local workspace_FindPartOnRayWithIgnoreList_result1, workspace_FindPartOnRayWithIgnoreList_result2 = workspace:FindPartOnRayWithIgnoreList(v, arg3)
		if workspace_FindPartOnRayWithIgnoreList_result1 and workspace_FindPartOnRayWithIgnoreList_result1.Name ~= "HumanoidRootPart" then
			return workspace_FindPartOnRayWithIgnoreList_result1, workspace_FindPartOnRayWithIgnoreList_result1.Parent, workspace_FindPartOnRayWithIgnoreList_result2
		end
	end
end
return RaycastForward