-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:10
-- Luau version 6, Types version 3
-- Time taken: 0.014585 seconds

Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
RunService = game:GetService("RunService") -- Setting global
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
LightningModelRemoval = script:WaitForChild("LightningModelRemoval") -- Setting global
BasePart = Create("Part")({
	Material = Enum.Material.Plastic;
	Shape = Enum.PartType.Block;
	TopSurface = Enum.SurfaceType.Smooth;
	BottomSurface = Enum.SurfaceType.Smooth;
	FormFactor = Enum.FormFactor.Custom;
	Size = Vector3.new(0.20000, 0.20000, 0.20000);
	CanCollide = true;
	Locked = true;
}) -- Setting global
BaseLightning = BasePart:Clone() -- Setting global
BaseLightning.Name = "Effect"
BaseLightning.Transparency = 0.1
BaseLightning.Material = Enum.Material.Neon
BaseLightning.Anchored = true
BaseLightning.CanCollide = false
Rate = 0.05 -- Setting global
LightningBolts = {} -- Setting global
LastBolt = nil -- Setting global
function GetLightningModel() -- Line 42
	if not game:GetService("Workspace"):FindFirstChild("LightningModel") then
		local var11 = Create("Model")({
			Name = "LightningModel";
		})
		local clone = LightningModelRemoval:Clone()
		clone.Disabled = false
		clone.Parent = var11
		var11.Parent = game:GetService("Workspace")
	end
	return var11
end
function CheckTableForString(arg1, arg2) -- Line 57
	for _, v_2 in pairs(arg1) do
		if string.find(string.lower(arg2), string.lower(v_2)) then
			return true
		end
	end
	return false
end
function CheckIntangible(arg1) -- Line 66
	if arg1 and arg1.Parent and (not arg1.CanCollide or CheckTableForString({"Water", "Arrow", "Projectile", "Effect", "Rail", "Lightning", "Bullet"}, arg1.Name)) then
		if not arg1.Parent:FindFirstChild("Humanoid") then
			return true
		end
	end
	return false
end
function CastRay(arg1, arg2, arg3, arg4, arg5) -- Line 76
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var19
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var19 = arg4
		return var19
	end
	if type(arg4) ~= "table" or not INLINED() then
		var19 = {}
		var19[1] = arg4
	end
	local var20
	if var20 and CheckIntangible(var20) then
		if arg5 then
			wait()
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
		local CastRay_result1, CastRay_result2, CastRay_result3 = CastRay(arg4 + arg2 * 0.01, arg2, arg3 - (arg1 - arg4).magnitude, var19, arg5)
		var20 = CastRay_result1
	end
	return var20, CastRay_result2, CastRay_result3
end
function Clamp(arg1, arg2, arg3) -- Line 88
	return math.max(math.min(arg3, arg1), arg2)
end
function GetPercentage(arg1, arg2, arg3) -- Line 92
	return (arg3 - arg1) / (arg2 - arg1) * 100
end
function Round(arg1, arg2) -- Line 96
	local _, math_modf_result2 = math.modf(arg1)
	local var26
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var26 = math.ceil(arg1)
		return var26
	end
	if arg2 > math_modf_result2 or not INLINED_2() then
		var26 = false
		if math_modf_result2 < arg2 then
			var26 = math.floor(arg1)
		end
	end
	return var26
end
function Zap(arg1) -- Line 101
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local StartPosition = arg1.StartPosition
	local TargetPosition = arg1.TargetPosition
	local Character = arg1.Character
	local Color = arg1.Color
	local var43 = arg1.Duration or 2
	local var44_upvr = arg1.TimeToFade or 0.5
	local var45
	if not var45 then
		var45 = {}
	end
	local var46 = arg1.Thickness or 0.4
	if not StartPosition or not TargetPosition or not Character then return end
	local GetLightningModel_result1 = GetLightningModel()
	for _, v_3 in pairs({Character, GetLightningModel_result1}) do
		table.insert(var45, v_3)
	end
	local var52 = StartPosition
	local CastRay_result1_2, CastRay_result2_3, CastRay_result3_2 = CastRay(StartPosition, CFrame.new(StartPosition, TargetPosition).lookVector, arg1.MaxRange or 40, var45, false)
	local Magnitude = (StartPosition - CastRay_result2_3).Magnitude
	local ceiled = math.ceil(Magnitude / (arg1.SegmentLength or 5))
	local var59 = Create("Model")({
		Name = "LightningBolt";
	})
	if not (arg1.Individualize or false) then
		table.insert(LightningBolts, var59)
	end
	LastBolt = var59 -- Setting global
	Debris:AddItem(var59, var43)
	var59.Parent = GetLightningModel_result1
	for i_4 = 1, ceiled do
		local var61 = StartPosition + (CFrame.new(StartPosition, CastRay_result2_3).lookVector) * ((Magnitude) * (i_4 / ceiled)) + Vector3.new(math.random() * 0.125 - 0, math.random() * 0.25 - 0, 0) - var52
		local _, CastRay_result2_2, _ = CastRay(var52, var61.Unit, var61.Magnitude, {Character, GetLightningModel_result1}, false)
		local var66 = var52 - CastRay_result2_2
		local clone_upvr = BaseLightning:Clone()
		clone_upvr.BrickColor = BrickColor.new(Color)
		clone_upvr.Size = Vector3.new(0.2, 0.2, var66.Magnitude)
		clone_upvr.CFrame = CFrame.new(var52, CastRay_result2_2) * CFrame.new(0, 0, -(var66.Magnitude / 2))
		Debris:AddItem(clone_upvr, var43 - 0.5)
		local _ = {
			Name = "Light";
			Color = BrickColor.new(Color).Color;
			Brightness = 50;
			Range = 2;
			Shadows = false;
			Enabled = true;
			Parent = clone_upvr;
		}
		local _ = {
			Name = "Mesh";
			Scale = Vector3.new(var46, 1, var46);
			Parent = clone_upvr;
		}
		clone_upvr.Size = Vector3.new(clone_upvr.Size.X, clone_upvr.Size.Z, clone_upvr.Size.Y)
		clone_upvr.CFrame *= CFrame.Angles((math.pi/2), 0, 0)
		clone_upvr.Parent = var59
		Spawn(function() -- Line 166
			--[[ Upvalues[2]:
				[1]: clone_upvr (readonly)
				[2]: var44_upvr (readonly)
			]]
			for i_5 = 1, var44_upvr / 0.05 do
				wait(0.05)
				clone_upvr.Transparency += (i_5) / (var44_upvr / 0.05)
				for _, v_4 in pairs(clone_upvr:GetChildren()) do
					if v_4:IsA("Light") then
						v_4.Brightness = 50 - (50) * (GetPercentage(0, 1, clone_upvr.Transparency) * 0.01)
						if v_4.Brightness <= 0 then
							v_4.Enabled = false
						end
					end
				end
			end
		end)
		local _
	end
	return {
		RayHit = CastRay_result1_2;
		RayPos = CastRay_result2_3;
		RayNormal = CastRay_result3_2;
		LightningModel = GetLightningModel_result1;
	}
end
function RemoveLightning() -- Line 187
	for _, v_5 in pairs(LightningBolts) do
		if v_5 and v_5.Parent then
			v_5:Destroy()
		end
	end
	LightningBolts = {} -- Setting global
end
Functions = {
	Zap = Zap;
	RemoveLightning = RemoveLightning;
} -- Setting global
return Functions