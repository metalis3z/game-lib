-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:39
-- Luau version 6, Types version 3
-- Time taken: 0.007516 seconds

Debris = game:GetService("Debris") -- Setting global
function Create(arg1) -- Line 5
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 7
		--[[ Upvalues[1]:
			[1]: any_upvr (readonly)
		]]
		for i, v in pairs(arg1_2) do
			any_upvr[i] = v
		end
		return any_upvr
	end
end
Functions = {
	CheckTableForInstance = function(arg1, arg2) -- Line 17
		for _, v_2 in pairs(arg1) do
			if v_2 == arg2 then
				return true
			end
		end
		return false
	end;
	CheckTableForString = function(arg1, arg2) -- Line 26
		for _, v_3 in pairs(arg1) do
			if string.lower(v_3) == string.lower(arg2) then
				return true
			end
		end
		return false
	end;
	CheckIntangible = function(arg1, arg2) -- Line 35
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		-- KONSTANTERROR: [0] 1. Error Block 33 start (CF ANALYSIS FAILED)
		local tbl_2 = {"Water", "Arrow", "Projectile", "Effect", "Rail", "Laser", "Ray", "Bullet", "ParticlePart"}
		if not arg1 or not arg1.Parent then
			return true
		end
		local Parent = arg1.Parent
		if Parent:IsA("Hat") or Parent:IsA("Tool") then
		end
		local pairs_result1, pairs_result2, pairs_result3_4 = pairs(Parent.Parent:GetChildren())
		-- KONSTANTERROR: [0] 1. Error Block 33 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [48] 39. Error Block 12 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [48] 39. Error Block 12 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [41] 33. Error Block 10 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		-- KONSTANTERROR: [41] 33. Error Block 10 end (CF ANALYSIS FAILED)
	end;
	CastRay = function(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 60
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		local any_FindPartOnRayWithIgnoreList_result1, _, _ = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(arg1, arg2 * arg3), arg4)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [17] 14. Error Block 2 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [17] 14. Error Block 2 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [24] 18. Error Block 3 start (CF ANALYSIS FAILED)
		;({
			Object = any_FindPartOnRayWithIgnoreList_result1;
			Players = {};
		}).Object = any_FindPartOnRayWithIgnoreList_result1
		-- KONSTANTERROR: [24] 18. Error Block 3 end (CF ANALYSIS FAILED)
	end;
	TagHumanoid = function(arg1, arg2) -- Line 91
		local tbl = {
			Name = "creator";
		}
		tbl.Value = arg2
		local var36 = Create("ObjectValue")(tbl)
		Debris:AddItem(var36, 2)
		var36.Parent = arg1
	end;
	UntagHumanoid = function(arg1) -- Line 100
		for _, v_4 in pairs(arg1:GetChildren()) do
			if v_4:IsA("ObjectValue") and v_4.Name == "creator" then
				v_4:Destroy()
			end
		end
	end;
	IsTeamMate = function(arg1, arg2) -- Line 108
		local var47 = arg1
		if var47 then
			var47 = arg2
			if var47 then
				var47 = arg1.Neutral
				if not var47 then
					var47 = arg2.Neutral
					if not var47 then
						if arg1.TeamColor ~= arg2.TeamColor then
							var47 = false
						else
							var47 = true
						end
					end
				end
			end
		end
		return var47
	end;
} -- Setting global
return Functions