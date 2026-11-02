-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("GuiService")
local v_u_5 = game:GetService("Debris")
game:GetService("Players")
local v_u_6 = require(v2.UserGenerated.Concurrency.Bindable)
local v7 = require(v2.UserGenerated.Lang.Asserts)
local v_u_8 = require(v2.Shared.SafeCast)
local v_u_9 = require(v2.Classes.Projectile.FindProbableTarget)
local v_u_10 = Instance.new("Folder")
v_u_10.Name = "__PROJECTILES"
v_u_10.Parent = workspace
local v11 = v7.Table({
	["Timestamp"] = v7.Finite,
	["Character"] = v7.Optional(v7.Model),
	["CFrame"] = v7.CFrameFinite,
	["LinearVelocity"] = v7.Vector3Finite,
	["Age"] = v7.FiniteNonNegative,
	["Attributes"] = v7.Map(v7.String, v7.Any),
	["HitPart"] = v7.BasePart,
	["HitNormal"] = v7.Vector3Unit,
	["HitPosition"] = v7.Vector3Finite,
	["HitEnding"] = v7.Vector3Finite,
	["HitAlpha"] = v7.Range(0, 1),
	["HitSize"] = v7.Vector3Positive,
	["HitCFrame"] = v7.CFrameFinite
})
local v_u_12 = {}
v_u_6.new()
local v_u_13 = RaycastParams.new()
v_u_13.IgnoreWater = false
v_u_13.BruteForceAllSlow = false
v_u_13.RespectCanCollide = true
v_u_13.CollisionGroup = "Projectile"
v_u_13.FilterType = Enum.RaycastFilterType.Exclude
v_u_13.FilterDescendantsInstances = {}
local v14 = RaycastParams.new()
v14.IgnoreWater = false
v14.BruteForceAllSlow = false
v14.RespectCanCollide = true
v14.CollisionGroup = "MobFinder"
v14.FilterType = Enum.RaycastFilterType.Exclude
v14.FilterDescendantsInstances = {}
local v_u_15 = OverlapParams.new()
v_u_15.MaxParts = 100
v_u_15.BruteForceAllSlow = false
v_u_15.RespectCanCollide = true
v_u_15.CollisionGroup = "MobFinder"
v_u_15.FilterType = Enum.RaycastFilterType.Exclude
v_u_15.FilterDescendantsInstances = {}
local function v_u_22(p16)
	-- upvalues: (copy) v_u_12, (copy) v_u_5
	if p16.Destroyed then
		return false
	end
	p16.Destroyed = true
	v_u_12[p16] = nil
	local v17 = p16.Model
	if v17 then
		local v18 = 0
		for _, v19 in ipairs(v17:GetDescendants()) do
			if v19:IsA("BasePart") then
				v19.Transparency = 1
			elseif v19:IsA("Trail") then
				local v20 = v19.Lifetime
				v18 = math.max(v18, v20)
			elseif v19:IsA("ParticleEmitter") then
				v19.Enabled = false
				local v21 = v19.Lifetime.Max
				v18 = math.max(v18, v21)
			end
		end
		v_u_5:AddItem(v17, v18)
	end
	p16.Destroying:Fire()
	return true
end
local function v_u_42(p23, p24, p25, p26, p27, p28)
	-- upvalues: (copy) v_u_13, (copy) v_u_15, (copy) v_u_9
	local v29 = p25.Magnitude
	local v30 = p25 / v29
	if v29 < 1e-6 then
		return Vector3.new(0, 0, 0)
	end
	local v31 = v_u_13
	v31.FilterDescendantsInstances = p23.FilterDescendantsInstances
	local v32 = v_u_15
	v32.FilterDescendantsInstances = p23.FilterDescendantsInstances
	local v33 = v_u_9(p24, p24 + v30 * 1000, p23.Radius + p26, v31, v32)
	if not v33 then
		return Vector3.new(0, 0, 0)
	end
	local v34 = v33 - p24
	local v35 = v34.Magnitude
	if v35 < 1e-6 then
		return Vector3.new(0, 0, 0)
	end
	local v36 = v34 / v35
	local v37 = v30:Dot(v36)
	local v38 = math.clamp(v37, -1, 1)
	local v39 = -math.acos(v38) * p28
	local v40 = (1 - math.exp(v39)) * (1 / (1 + p27 * v35))
	local v41 = v30:Cross(v36)
	return v41.Magnitude < 1e-6 and Vector3.new(0, 0, 0) or (v30 + v41:Cross(v30).Unit * v40).Unit * v29 - p25
end
local function v_u_57(p43, p44)
	-- upvalues: (copy) v_u_42, (copy) v_u_13, (copy) v_u_8, (copy) v_u_22
	local v45 = p43.CFrame
	local v46 = v45.Position
	local v47 = p43.LinearVelocity
	local v48 = Vector3.new(0, 0, 0)
	if p43.TrackingResponse then
		v48 = v48 + v_u_42(p43, v46, v47, p43.TrackingRadius or 0, p43.TrackingFalloff or 0, p43.TrackingResponse)
	end
	local v49 = p43.Gravity
	local v50 = p44 * p44
	local v51 = v46 + v47 * p44 + 0.5 * v49 * v50
	local v52 = v47 + (v49 + v48) * p44
	local v53 = v_u_13
	v53.FilterDescendantsInstances = p43.FilterDescendantsInstances
	local v54 = v_u_8(v46, v51, p43.Radius, v53)
	if v54 then
		local v55 = v54.Alpha
		v51 = v46:Lerp(v51, v55)
		v52 = v47:Lerp(v52, v55)
		p44 = p44 * v55
	end
	local v56 = v45.Rotation
	if v52.Magnitude > 1e-6 then
		v56 = CFrame.lookAlong(Vector3.new(0, 0, 0), v52)
	end
	p43.CFrame = CFrame.new(v51) * v56
	p43.LinearVelocity = v52
	p43.Age = p43.Age + p44
	if v54 then
		p43.Hit:Fire(v54)
	end
	if p43.Age >= p43.MaxAge then
		v_u_22(p43)
	end
	return p44
end
local function v_u_62(p58, p59, p60)
	-- upvalues: (copy) v_u_57
	local v61 = p59 - p58.CreationTime
	for _ = 1, p60 or 4 do
		if p58.Destroyed or v61 - p58.Age < 0.03333333333333333 then
			break
		end
		v_u_57(p58, 0.03333333333333333)
	end
end
local function v_u_75(p63, p64)
	local v65 = p63.Model
	if v65 then
		local v66 = p64 - p63.CreationTime - p63.Age
		local v67 = p63.CFrame
		local v68 = v67.Position
		local v69 = p63.LinearVelocity
		local v70 = p63.Gravity
		local v71 = v66 * v66
		local v72 = v68 + v69 * v66 + 0.5 * v70 * v71
		local v73 = v69 + (v70 + Vector3.new(0, 0, 0)) * v66
		local v74 = v67.Rotation
		if v73.Magnitude > 1e-6 then
			v74 = CFrame.lookAlong(Vector3.new(0, 0, 0), v73)
		end
		v65:PivotTo(CFrame.new(v72) * v74)
	end
end
local v77 = {
	["__index"] = table.freeze({
		["IsDestroyed"] = function(p76)
			return p76.Destroyed
		end,
		["Destroy"] = v_u_22,
		["SimulateTo"] = v_u_62
	})
}
local v_u_78 = table.freeze(v77)
local v_u_79 = v7.Table({
	["Id"] = v7.UUIDStripped,
	["CreationTime"] = v7.Finite,
	["Origin"] = v7.Vector3Finite,
	["LinearVelocity"] = v7.Vector3Finite,
	["Radius"] = v7.FiniteNonNegative,
	["Gravity"] = v7.Optional(v7.Vector3Finite),
	["MaxAge"] = v7.Optional(v7.FiniteNonNegative),
	["TrackingRadius"] = v7.Optional(v7.FiniteNonNegative),
	["TrackingFalloff"] = v7.Optional(v7.FiniteNonNegative),
	["TrackingResponse"] = v7.Optional(v7.FiniteNonNegative),
	["FilterDescendantsInstances"] = v7.Optional(v7.Array(v7.Instance)),
	["TemplateModel"] = v7.Optional(v7.Model)
})
local function v90(p80)
	-- upvalues: (copy) v_u_79, (copy) v_u_10, (copy) v_u_6, (copy) v_u_78, (copy) v_u_12
	v_u_79(p80)
	local v81 = CFrame.lookAlong(p80.Origin, p80.LinearVelocity)
	local v82 = not p80.FilterDescendantsInstances and {} or table.clone(p80.FilterDescendantsInstances)
	local v83
	if p80.TemplateModel then
		v83 = p80.TemplateModel:Clone()
		for _, v84 in ipairs(v83:GetDescendants()) do
			if v84:IsA("BasePart") then
				v84.Anchored = true
				v84.CanCollide = false
				v84.CanTouch = false
				v84.CollisionGroup = "Projectile"
			end
		end
		v83:PivotTo(v81)
		v83.Parent = v_u_10
		table.insert(v82, v83)
	else
		v83 = nil
	end
	local v85 = {
		["Destroyed"] = false,
		["Hit"] = v_u_6.new(),
		["Destroying"] = v_u_6.new(),
		["Attributes"] = {},
		["Impacts"] = {},
		["Id"] = p80.Id,
		["CreationTime"] = p80.CreationTime,
		["CFrame"] = v81,
		["LinearVelocity"] = p80.LinearVelocity,
		["Radius"] = p80.Radius
	}
	local v86 = p80.Gravity
	if not v86 then
		local v87 = -workspace.Gravity
		v86 = Vector3.new(0, v87, 0)
	end
	v85.Gravity = v86
	v85.Age = 0
	v85.MaxAge = p80.MaxAge or 5
	v85.TrackingRadius = p80.TrackingRadius
	v85.TrackingFalloff = p80.TrackingFalloff
	v85.TrackingResponse = p80.TrackingResponse
	v85.FilterDescendantsInstances = v82
	v85.Model = v83
	local v88 = v_u_78
	local v89 = setmetatable(v85, v88)
	v_u_12[v89] = true
	return v89
end
local v_u_91 = v7.Table({
	["CameraDistance"] = v7.Optional(v7.Finite),
	["RaycastDistance"] = v7.Optional(v7.FiniteNonNegative),
	["FilterDescendantsInstances"] = v7.Optional(v7.Array(v7.Instance))
})
local function v105(p92)
	-- upvalues: (copy) v_u_91, (copy) v_u_3, (copy) v_u_4, (copy) v_u_13
	v_u_91(p92)
	local v93 = p92.CameraDistance or 0
	local v94 = p92.RaycastDistance or 1000
	local v95 = p92.FilterDescendantsInstances or {}
	local v96 = v_u_3:GetMouseLocation()
	local v97, _ = v_u_4:GetGuiInset()
	local v98 = v96 - v97
	local v99 = workspace.CurrentCamera:ScreenPointToRay(v98.X, v98.Y, v93)
	local v100 = v99.Direction.Unit
	local v101 = v99.Origin
	local v102 = v100 * v94
	local v103 = v_u_13
	v103.FilterDescendantsInstances = v95
	local v104 = workspace:Raycast(v101, v102, v103)
	if v104 then
		return v104.Position
	else
		return v101 + v102
	end
end
v1.PostSimulation:Connect(function(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_62, (copy) v_u_22
	local v106 = workspace:GetServerTimeNow()
	for v107, _ in pairs(v_u_12) do
		local v108, v109 = pcall(v_u_62, v107, v106)
		if not v108 then
			v_u_22(v107)
			warn("Projectile.SimulateTo", v109)
		end
	end
end)
if v1:IsClient() then
	v1:BindToRenderStep("Projectile", Enum.RenderPriority.Last.Value - 1, function(_)
		-- upvalues: (copy) v_u_12, (copy) v_u_75, (copy) v_u_22
		local v110 = workspace:GetServerTimeNow()
		for v111, _ in pairs(v_u_12) do
			local v112, v113 = pcall(v_u_75, v111, v110)
			if not v112 then
				v_u_22(v111)
				warn("Projectile.RenderTo", v113)
			end
		end
	end)
end
return table.freeze({
	["new"] = v90,
	["AssertImpactMeta"] = v11,
	["PickTarget"] = v105
})
