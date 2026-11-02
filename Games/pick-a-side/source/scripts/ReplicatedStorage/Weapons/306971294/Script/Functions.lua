-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:31
-- Luau version 6, Types version 3
-- Time taken: 0.007664 seconds

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
function Functions.Clamp(arg1, arg2, arg3) -- Line 18
	return math.max(math.min(arg3, arg1), arg2)
end
function Functions.GetPercentage(arg1, arg2, arg3) -- Line 22
	return (arg3 - arg1) / (arg2 - arg1) * 100
end
function Functions.Round(arg1, arg2) -- Line 26
	local _, math_modf_result2 = math.modf(arg1)
	local var11
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var11 = math.ceil(arg1)
		return var11
	end
	if arg2 > math_modf_result2 or not INLINED() then
		var11 = false
		if math_modf_result2 < arg2 then
			var11 = math.floor(arg1)
		end
	end
	return var11
end
function Functions.IsTeamMate(arg1, arg2) -- Line 31
	local var15 = arg1
	if var15 then
		var15 = arg2
		if var15 then
			var15 = arg1.Neutral
			if not var15 then
				var15 = arg2.Neutral
				if not var15 then
					if arg1.TeamColor ~= arg2.TeamColor then
						var15 = false
					else
						var15 = true
					end
				end
			end
		end
	end
	return var15
end
function Functions.TagHumanoid(arg1, arg2) -- Line 35
	local tbl = {
		Name = "creator";
	}
	tbl.Value = arg2
	local var17 = Create("ObjectValue")(tbl)
	Debris:AddItem(var17, 2)
	var17.Parent = arg1
end
function Functions.UntagHumanoid(arg1) -- Line 44
	for _, v_2 in pairs(arg1:GetChildren()) do
		if v_2:IsA("ObjectValue") and v_2.Name == "creator" then
			v_2:Destroy()
		end
	end
end
function Functions.CheckTableForString(arg1, arg2) -- Line 52
	for _, v_3 in pairs(arg1) do
		if string.find(string.lower(arg2), string.lower(v_3)) then
			return true
		end
	end
	return false
end
function Functions.CheckIntangible(arg1) -- Line 61
	if arg1 and arg1.Parent and (not arg1.CanCollide or Functions.CheckTableForString({"Water", "Arrow", "Projectile", "Effect", "Rail", "Laser", "Bullet"}, arg1.Name)) then
		if not arg1.Parent:FindFirstChild("Humanoid") then
			return true
		end
	end
	return false
end
function Functions.CastRay(arg1, arg2, arg3, arg4, arg5) -- Line 71
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var29
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var29 = arg4
		return var29
	end
	if type(arg4) ~= "table" or not INLINED_2() then
		var29 = {}
		var29[1] = arg4
	end
	local var30
	if var30 and Functions.CheckIntangible(var30) then
		if arg5 then
			wait()
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
		local Functions_CastRay_result1, Functions_CastRay_result2, Functions_CastRay_result3, Functions_CastRay_result4 = Functions.CastRay(arg4 + arg2 * 0.01, arg2, arg3 - (arg1 - arg4).magnitude, var29, arg5)
		var30 = Functions_CastRay_result1
	end
	return var30, Functions_CastRay_result2, Functions_CastRay_result3, Functions_CastRay_result4
end
return Functions