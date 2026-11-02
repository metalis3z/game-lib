-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:48
-- Luau version 6, Types version 3
-- Time taken: 0.007680 seconds

Functions = {} -- Setting global
Debris = game:GetService("Debris") -- Setting global
function Create(arg1) -- Line 7
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 9
		--[[ Upvalues[1]:
			[1]: any_upvr (readonly)
		]]
		for i, v in pairs(arg1_2) do
			any_upvr[i] = v
		end
		return any_upvr
	end
end
function Functions.Clamp(arg1, arg2, arg3) -- Line 17
	return math.max(math.min(arg3, arg1), arg2)
end
function Functions.GetPercentage(arg1, arg2, arg3) -- Line 21
	return (arg3 - arg1) / (arg2 - arg1) * 100
end
function Functions.Round(arg1, arg2) -- Line 25
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
function Functions.CheckTableForInstance(arg1, arg2) -- Line 30
	for _, v_2 in pairs(arg1) do
		if v_2 == arg2 then
			return true
		end
	end
	return false
end
function Functions.CheckTableForString(arg1, arg2) -- Line 39
	for _, v_3 in pairs(arg1) do
		if string.lower(v_3) == string.lower(arg2) then
			return true
		end
	end
	return false
end
function Functions.CheckIntangible(arg1) -- Line 48
	if arg1 and arg1.Parent and (not arg1.CanCollide or Functions.CheckTableForString({"Water", "Arrow", "Projectile", "Effect", "Rail", "Laser", "Bullet"}, arg1.Name)) then
		if not arg1.Parent:FindFirstChild("Humanoid") then
			return true
		end
	end
	return false
end
function Functions.CastRay(arg1, arg2, arg3, arg4, arg5) -- Line 58
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var23
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var23 = arg4
		return var23
	end
	if type(arg4) ~= "table" or not INLINED_2() then
		var23 = {}
		var23[1] = arg4
	end
	local var24
	if var24 and Functions.CheckIntangible(var24) then
		if arg5 then
			wait()
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
		local Functions_CastRay_result1, Functions_CastRay_result2, Functions_CastRay_result3 = Functions.CastRay(arg4 + arg2 * 0.01, arg2, arg3 - (arg1 - arg4).magnitude, var23, arg5)
		var24 = Functions_CastRay_result1
	end
	return var24, Functions_CastRay_result2, Functions_CastRay_result3
end
function Functions.TagHumanoid(arg1, arg2) -- Line 70
	local tbl = {
		Name = "creator";
	}
	tbl.Value = arg2
	local var29 = Create("ObjectValue")(tbl)
	Debris:AddItem(var29, 2)
	var29.Parent = arg1
end
function Functions.UntagHumanoid(arg1) -- Line 79
	for _, v_4 in pairs(arg1:GetChildren()) do
		if v_4:IsA("ObjectValue") and v_4.Name == "creator" then
			v_4:Destroy()
		end
	end
end
function Functions.IsTeamMate(arg1, arg2) -- Line 87
	local var38 = arg1
	if var38 then
		var38 = arg2
		if var38 then
			var38 = arg1.Neutral
			if not var38 then
				var38 = arg2.Neutral
				if not var38 then
					if arg1.TeamColor ~= arg2.TeamColor then
						var38 = false
					else
						var38 = true
					end
				end
			end
		end
	end
	return var38
end
return Functions