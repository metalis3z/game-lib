-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:13
-- Luau version 6, Types version 3
-- Time taken: 0.014563 seconds

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
BaseUrl = "http://www.roblox.com/asset/?id=" -- Setting global
Functions = {} -- Setting global
function Functions.DeathEffect(arg1) -- Line 20
	if not arg1 then
	else
		local tbl_2_upvr = {
			Head = {
				MeshId = "4770583";
				TextureId = "36869975";
				Scale = Vector3.new(3, 3, 3);
			};
			Torso = {
				MeshId = "36780113";
				TextureId = "36780292";
				Scale = Vector3.new(1, 1, 1);
			};
			["Left Arm"] = {
				MeshId = "36780032";
				TextureId = "36780292";
				Scale = Vector3.new(1, 1, 1);
			};
			["Right Arm"] = {
				MeshId = "36780156";
				TextureId = "36780292";
				Scale = Vector3.new(1, 1, 1);
			};
			["Left Leg"] = {
				MeshId = "36780079";
				TextureId = "36780292";
				Scale = Vector3.new(1, 1, 1);
			};
			["Right Leg"] = {
				MeshId = "36780195";
				TextureId = "36780292";
				Scale = Vector3.new(1, 1, 1);
			};
		}
		local function Materialize_upvr(arg1_3) -- Line 32, Named "Materialize"
			--[[ Upvalues[1]:
				[1]: tbl_2_upvr (readonly)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			local children = arg1_3:IsA("BasePart")
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [16] 13. Error Block 23 start (CF ANALYSIS FAILED)
			for _, v_6 in pairs(arg1_3:GetChildren()) do
				if v_6:IsA("DataModelMesh") or v_6:IsA("Decal") or v_6:IsA("Texture") then
					v_6:Destroy()
				end
			end
			;({
				Name = "Mesh";
				MeshType = Enum.MeshType.FileMesh;
				MeshId = BaseUrl..children.MeshId;
				TextureId = "";
				Scale = children.Scale;
				VertexColor = Vector3.new(1, 1, 1);
				Offset = Vector3.new(0, 0, 0);
			}).Parent = arg1_3
			do
				return
			end
			-- KONSTANTERROR: [16] 13. Error Block 23 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [79] 56. Error Block 18 start (CF ANALYSIS FAILED)
			if arg1_3:IsA("CharacterMesh") or arg1_3:IsA("Clothing") then
				arg1_3:Destroy()
			end
			-- KONSTANTERROR: [79] 56. Error Block 18 end (CF ANALYSIS FAILED)
		end
		local function Effect_upvr(arg1_4) -- Line 57, Named "Effect"
			--[[ Upvalues[2]:
				[1]: Materialize_upvr (readonly)
				[2]: Effect_upvr (readonly)
			]]
			for _, v_7 in pairs(arg1_4:GetChildren()) do
				Materialize_upvr(v_7)
				Effect_upvr(v_7)
			end
		end
		Effect_upvr(arg1)
	end
end
function Functions.Clamp(arg1, arg2, arg3) -- Line 67
	return math.max(math.min(arg3, arg1), arg2)
end
function Functions.GetPercentage(arg1, arg2, arg3) -- Line 71
	return (arg3 - arg1) / (arg2 - arg1) * 100
end
function Functions.Round(arg1, arg2) -- Line 75
	local _, math_modf_result2 = math.modf(arg1)
	local var30
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var30 = math.ceil(arg1)
		return var30
	end
	if arg2 > math_modf_result2 or not INLINED() then
		var30 = false
		if math_modf_result2 < arg2 then
			var30 = math.floor(arg1)
		end
	end
	return var30
end
function Functions.IsTeamMate(arg1, arg2) -- Line 80
	local var34 = arg1
	if var34 then
		var34 = arg2
		if var34 then
			var34 = arg1.Neutral
			if not var34 then
				var34 = arg2.Neutral
				if not var34 then
					if arg1.TeamColor ~= arg2.TeamColor then
						var34 = false
					else
						var34 = true
					end
				end
			end
		end
	end
	return var34
end
function Functions.TagHumanoid(arg1, arg2) -- Line 84
	local tbl = {
		Name = "creator";
	}
	tbl.Value = arg2
	local var36 = Create("ObjectValue")(tbl)
	Debris:AddItem(var36, 2)
	var36.Parent = arg1
end
function Functions.UntagHumanoid(arg1) -- Line 93
	for _, v_2 in pairs(arg1:GetChildren()) do
		if v_2:IsA("ObjectValue") and v_2.Name == "creator" then
			v_2:Destroy()
		end
	end
end
function Functions.GetAllConnectedParts(arg1) -- Line 101
	local module_upvr = {}
	local function GetConnectedParts_upvr(arg1_5) -- Line 103, Named "GetConnectedParts"
		--[[ Upvalues[2]:
			[1]: module_upvr (readonly)
			[2]: GetConnectedParts_upvr (readonly)
		]]
		for _, v_3 in pairs(arg1_5:GetConnectedParts()) do
			local var57
			for _, v_4 in pairs(module_upvr) do
				if v_3 == v_4 then
				end
			end
			if not nil then
				table.insert(module_upvr, v_3)
				GetConnectedParts_upvr(v_3)
			end
		end
	end
	GetConnectedParts_upvr(arg1)
	return module_upvr
end
function Functions.CheckTableForString(arg1, arg2) -- Line 121
	for _, v_5 in pairs(arg1) do
		if string.find(string.lower(arg2), string.lower(v_5)) then
			return true
		end
	end
	return false
end
function Functions.CheckIntangible(arg1) -- Line 130
	if arg1 and arg1.Parent and (not arg1.CanCollide or Functions.CheckTableForString({"Water", "Arrow", "Projectile", "Effect", "Rail", "Laser", "Bullet"}, arg1.Name)) then
		if not arg1.Parent:FindFirstChild("Humanoid") then
			return true
		end
	end
	return false
end
function Functions.CastRay(arg1, arg2, arg3, arg4, arg5) -- Line 140
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var64
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var64 = arg4
		return var64
	end
	if type(arg4) ~= "table" or not INLINED_2() then
		var64 = {}
		var64[1] = arg4
	end
	local var65
	if var65 and Functions.CheckIntangible(var65) then
		if arg5 then
			wait()
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
		local Functions_CastRay_result1, Functions_CastRay_result2, Functions_CastRay_result3, Functions_CastRay_result4 = Functions.CastRay(arg4 + arg2 * 0.01, arg2, arg3 - (arg1 - arg4).magnitude, var64, arg5)
		var65 = Functions_CastRay_result1
	end
	return var65, Functions_CastRay_result2, Functions_CastRay_result3, Functions_CastRay_result4
end
return Functions