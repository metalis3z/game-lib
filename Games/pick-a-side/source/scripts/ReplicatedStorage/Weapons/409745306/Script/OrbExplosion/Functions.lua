-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:41
-- Luau version 6, Types version 3
-- Time taken: 0.006432 seconds

Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
function Create(arg1) -- Line 6
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 8
		--[[ Upvalues[1]:
			[1]: any_upvr (readonly)
		]]
		for i, v in pairs(arg1_2) do
			any_upvr[i] = v
		end
		return any_upvr
	end
end
Functions = {} -- Setting global
function Functions.IsTeamMate(arg1, arg2) -- Line 18
	local var12 = arg1
	if var12 then
		var12 = arg2
		if var12 then
			var12 = arg1.Neutral
			if not var12 then
				var12 = arg2.Neutral
				if not var12 then
					if arg1.TeamColor ~= arg2.TeamColor then
						var12 = false
					else
						var12 = true
					end
				end
			end
		end
	end
	return var12
end
function Functions.TagHumanoid(arg1, arg2) -- Line 22
	local tbl = {
		Name = "creator";
	}
	tbl.Value = arg2
	local var14 = Create("ObjectValue")(tbl)
	Debris:AddItem(var14, 2)
	var14.Parent = arg1
end
function Functions.UntagHumanoid(arg1) -- Line 31
	for _, v_2 in pairs(arg1:GetChildren()) do
		if v_2:IsA("ObjectValue") and v_2.Name == "creator" then
			v_2:Destroy()
		end
	end
end
function Functions.GetTotalParts(arg1, arg2, arg3) -- Line 39
	if arg1 < arg2 then
		return arg1
	end
	if arg1 <= arg3 then
		return 0
	end
	if arg2 <= arg1 then
		if arg3 <= arg1 then
			local var20 = arg1 - arg3
			if arg2 < var20 then
				return arg2
			end
			return var20
		end
		if arg2 <= var20 then
			return arg2
		end
		return var20
	end
end
function Functions.GetParts(arg1, arg2, arg3) -- Line 61
	local module = {}
	while #module < arg2 and not false do
		local any_FindPartsInRegion3WithIgnoreList_result1 = game:GetService("Workspace"):FindPartsInRegion3WithIgnoreList(arg1, arg3, Functions.GetTotalParts(arg2, 100, #module))
		if #any_FindPartsInRegion3WithIgnoreList_result1 == 0 then
		else
			for _, v_3 in pairs(any_FindPartsInRegion3WithIgnoreList_result1) do
				table.insert(module, v_3)
				table.insert(arg3, v_3)
			end
		end
	end
	return module
end
function Functions.CheckTableForInstance(arg1, arg2) -- Line 80
	for _, v_4 in pairs(arg1) do
		if v_4 == arg2 then
			return true
		end
	end
	return false
end
return Functions