-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:37
-- Luau version 6, Types version 3
-- Time taken: 0.010727 seconds

Debris = game:GetService("Debris") -- Setting global
ProjectileNames = {"Water", "Arrow", "Projectile", "Effect", "Rail", "Laser", "Ray", "Bullet", "ParticlePart"} -- Setting global
Functions = {
	CreateConfiguration = function(arg1, arg2) -- Line 9
		for _, v in pairs(arg1:GetChildren()) do
			if string.find(v.ClassName, "Value") then
				arg2[v.Name] = v:Clone()
			elseif v:IsA("Folder") or v:IsA("Configuration") then
				arg2[v.Name] = Functions.CreateConfiguration(v, arg2)
			end
		end
		return arg2
	end;
	FindCharacterAncestor = function(arg1) -- Line 20
		if arg1 and arg1 ~= game:GetService("Workspace") then
			local Humanoid = arg1:FindFirstChild("Humanoid")
			if Humanoid then
				return arg1, Humanoid
			end
			return Functions.FindCharacterAncestor(arg1.Parent)
		end
		return nil
	end;
	CheckTableForString = function(arg1, arg2) -- Line 32
		for _, v_2 in pairs(arg1) do
			if string.lower(v_2) == string.lower(arg2) then
				return true
			end
		end
		return false
	end;
	CheckIntangible = function(arg1) -- Line 41
		if arg1 and arg1.Parent then
			if Functions.CheckTableForString(ProjectileNames, arg1.Name) then
				return true
			end
			local Parent = arg1.Parent
			local Humanoid_2 = Parent.Parent:FindFirstChild("Humanoid")
			if Humanoid_2 and 0 < Humanoid_2.Health and Parent:IsA("Hat") then
				return true
			end
		end
		return false
	end;
	CastRay = function(arg1, arg2, arg3, arg4, arg5) -- Line 56
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var21
		if var21 and Functions.CheckIntangible(var21) then
			if arg5 then
				wait()
			end
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [32.6]
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			local Functions_CastRay_result1, Functions_CastRay_result2, Functions_CastRay_result3 = Functions.CastRay(nil + arg2 * 0.01, arg2, arg3 - (arg1 - nil).magnitude, arg4, arg5)
			var21 = Functions_CastRay_result1
		end
		return var21, Functions_CastRay_result2, Functions_CastRay_result3
	end;
	IsTeamMate = function(arg1, arg2) -- Line 67
		local var29 = arg1
		if var29 then
			var29 = arg2
			if var29 then
				var29 = arg1.Neutral
				if not var29 then
					var29 = arg2.Neutral
					if not var29 then
						if arg1.TeamColor ~= arg2.TeamColor then
							var29 = false
						else
							var29 = true
						end
					end
				end
			end
		end
		return var29
	end;
	TagHumanoid = function(arg1, arg2) -- Line 71
		local ObjectValue = Instance.new("ObjectValue")
		ObjectValue.Name = "creator"
		ObjectValue.Value = arg2
		Debris:AddItem(ObjectValue, 2)
		ObjectValue.Parent = arg1
	end;
	UntagHumanoid = function(arg1) -- Line 79
		for _, v_3 in pairs(arg1:GetChildren()) do
			if v_3:IsA("ObjectValue") and v_3.Name == "creator" then
				v_3:Destroy()
			end
		end
	end;
	CheckTableForString = function(arg1, arg2) -- Line 87
		for _, v_4 in pairs(arg1) do
			if string.lower(v_4) == string.lower(arg2) then
				return true
			end
		end
		return false
	end;
	Clamp = function(arg1, arg2, arg3) -- Line 96
		return math.max(math.min(arg3, arg1), arg2)
	end;
	GetPercentage = function(arg1, arg2, arg3) -- Line 100
		return (arg3 - arg1) / (arg2 - arg1) * 100
	end;
	Round = function(arg1, arg2) -- Line 104
		local _, math_modf_result2 = math.modf(arg1)
		local var49
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var49 = math.ceil(arg1)
			return var49
		end
		if arg2 > math_modf_result2 or not INLINED() then
			var49 = false
			if math_modf_result2 < arg2 then
				var49 = math.floor(arg1)
			end
		end
		return var49
	end;
} -- Setting global
return Functions