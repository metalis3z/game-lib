-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:33
-- Luau version 6, Types version 3
-- Time taken: 0.010888 seconds

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
function Functions.TagHumanoid(arg1, arg2) -- Line 18
	local tbl = {
		Name = "creator";
	}
	tbl.Value = arg2
	local var10 = Create("ObjectValue")(tbl)
	Debris:AddItem(var10, 2)
	var10.Parent = arg1
end
function Functions.UntagHumanoid(arg1) -- Line 27
	for _, v_2 in pairs(arg1:GetChildren()) do
		if v_2:IsA("ObjectValue") and v_2.Name == "creator" then
			v_2:Destroy()
		end
	end
end
function Functions.IsTeamMate(arg1, arg2) -- Line 35
	local var19 = arg1
	if var19 then
		var19 = arg2
		if var19 then
			var19 = arg1.Neutral
			if not var19 then
				var19 = arg2.Neutral
				if not var19 then
					if arg1.TeamColor ~= arg2.TeamColor then
						var19 = false
					else
						var19 = true
					end
				end
			end
		end
	end
	return var19
end
function Functions.CheckTableForString(arg1, arg2) -- Line 39
	for _, v_3 in pairs(arg1) do
		if string.find(string.lower(arg2), string.lower(v_3)) then
			return true
		end
	end
	return false
end
function Functions.CheckIntangible(arg1) -- Line 48
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local _ = {"Lightning", "Effect", "Projectile", "Arrow", "Bullet", "Water"}
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [11] 10. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [11] 10. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [67] 50. Error Block 16 start (CF ANALYSIS FAILED)
	do
		return false
	end
	-- KONSTANTERROR: [67] 50. Error Block 16 end (CF ANALYSIS FAILED)
end
function Functions.CastRay(arg1, arg2, arg3, arg4, arg5) -- Line 65
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var26
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var26 = arg4
		return var26
	end
	if type(arg4) ~= "table" or not INLINED() then
		var26 = {}
		var26[1] = arg4
	end
	local var27
	if var27 and Functions.CheckIntangible(var27) then
		if arg5 then
			wait()
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
		local Functions_CastRay_result1, Functions_CastRay_result2, Functions_CastRay_result3 = Functions.CastRay(arg4 + arg2 * 0.01, arg2, arg3 - (arg1 - arg4).magnitude, var26, arg5)
		var27 = Functions_CastRay_result1
	end
	return var27, Functions_CastRay_result2, Functions_CastRay_result3
end
function Functions.GetTotalParts(arg1, arg2, arg3) -- Line 77
	if arg1 < arg2 then
		return arg1
	end
	if arg1 <= arg3 then
		return 0
	end
	if arg2 <= arg1 then
		if arg3 <= arg1 then
			local var31 = arg1 - arg3
			if arg2 < var31 then
				return arg2
			end
			return var31
		end
		if arg2 <= var31 then
			return arg2
		end
		return var31
	end
end
function Functions.GetParts(arg1, arg2, arg3) -- Line 99
	local module = {}
	while #module < arg2 and not false do
		local any_FindPartsInRegion3WithIgnoreList_result1 = game:GetService("Workspace"):FindPartsInRegion3WithIgnoreList(arg1, arg3, Functions.GetTotalParts(arg2, 100, #module))
		if #any_FindPartsInRegion3WithIgnoreList_result1 == 0 then
		else
			for _, v_4 in pairs(any_FindPartsInRegion3WithIgnoreList_result1) do
				table.insert(module, v_4)
				table.insert(arg3, v_4)
			end
		end
	end
	return module
end
function Functions.CheckTableForInstance(arg1, arg2) -- Line 118
	for _, v_5 in pairs(arg1) do
		if v_5 == arg2 then
			return true
		end
	end
	return false
end
return Functions