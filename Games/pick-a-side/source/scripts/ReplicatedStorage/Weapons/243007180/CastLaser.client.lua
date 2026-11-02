-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:36
-- Luau version 6, Types version 3
-- Time taken: 0.006077 seconds

Debris = game:GetService("Debris") -- Setting global
Camera = game:GetService("Workspace").CurrentCamera -- Setting global
BasePart = Instance.new("Part") -- Setting global
BasePart.Shape = Enum.PartType.Block
BasePart.Material = Enum.Material.Plastic
BasePart.TopSurface = Enum.SurfaceType.Smooth
BasePart.BottomSurface = Enum.SurfaceType.Smooth
BasePart.FormFactor = Enum.FormFactor.Custom
BasePart.Size = Vector3.new(0.20000, 0.20000, 0.20000)
BasePart.CanCollide = true
BasePart.Locked = true
BasePart.Anchored = false
BaseRay = BasePart:Clone() -- Setting global
BaseRay.Name = "Laser"
BaseRay.BrickColor = BrickColor.new("New Yeller")
BaseRay.Material = Enum.Material.SmoothPlastic
BaseRay.Size = Vector3.new(0.20000, 0.20000, 0.20000)
BaseRay.Anchored = true
BaseRay.CanCollide = false
BaseRayMesh = Instance.new("SpecialMesh") -- Setting global
BaseRayMesh.Name = "Mesh"
BaseRayMesh.MeshType = Enum.MeshType.Brick
BaseRayMesh.Scale = Vector3.new(0.20000, 0.20000, 1)
BaseRayMesh.Offset = Vector3.new(0, 0, 0)
BaseRayMesh.VertexColor = Vector3.new(1, 1, 1)
BaseRayMesh.Parent = BaseRay
function PlaySound(arg1, arg2) -- Line 37
	local clone_3 = BasePart:Clone()
	clone_3.Name = "ParticlePart"
	clone_3.Transparency = 1
	clone_3.Anchored = true
	clone_3.CanCollide = false
	local clone = arg2:Clone()
	clone.Parent = clone_3
	Debris:AddItem(clone_3, 1.5)
	clone_3.Parent = game:GetService("Workspace")
	clone_3.CFrame = CFrame.new(arg1)
	clone:Play()
end
function FireRay(arg1, arg2, arg3) -- Line 51
	local var7 = arg2 - arg1
	local magnitude_3 = var7.magnitude
	local unit = var7.unit
	local var10 = arg1 + 0.25 * magnitude_3 * unit
	local var11 = arg1 + 0.5 * magnitude_3 * unit
	local var12 = arg1 + 0.75 * magnitude_3 * unit
	local magnitude_2 = (arg1 - var10).magnitude
	local magnitude_4 = (var10 - var11).magnitude
	local magnitude = (var11 - var12).magnitude
	local var16 = var10 + Vector3.new(math.random(math.max(-2, -0.21 * magnitude_2), math.min(2, 0.21 * magnitude_2)), math.random(math.max(-2, -0.21 * magnitude_2), math.min(2, 0.21 * magnitude_2)), math.random(math.max(-2, -0.21 * magnitude_2), math.min(2, 0.21 * magnitude_2)))
	local var17 = var11 + Vector3.new(math.random(math.max(-2, -0.21 * magnitude_4), math.min(2, 0.21 * magnitude_4)), math.random(math.max(-2, -0.21 * magnitude_4), math.min(2, 0.21 * magnitude_4)), math.random(math.max(-2, -0.21 * magnitude_4), math.min(2, 0.21 * magnitude_4)))
	local var18 = var12 + Vector3.new(math.random(math.max(-2, -0.21 * magnitude), math.min(2, 0.21 * magnitude)), math.random(math.max(-2, -0.21 * magnitude), math.min(2, 0.21 * magnitude)), math.random(math.max(-2, -0.21 * magnitude), math.min(2, 0.21 * magnitude)))
	local tbl = {{
		Distance = (var16 - arg1).magnitude;
		Direction = CFrame.new(arg1, var16);
	}, {
		Distance = (var17 - var16).magnitude;
		Direction = CFrame.new(var16, var17);
	}, {
		Distance = (var18 - var17).magnitude;
		Direction = CFrame.new(var17, var18);
	}, {
		Distance = (arg2 - var18).magnitude;
		Direction = CFrame.new(var18, arg2);
	}}
	for i, v in pairs(tbl) do
		local clone_2 = BaseRay:Clone()
		clone_2.BrickColor = BrickColor.new("New Yeller")
		clone_2.Reflectance = 0.4
		clone_2.Transparency = 0.7
		clone_2.Mesh.Scale = Vector3.new(0.15, 0.15, v.Distance / 1) * 5
		clone_2.CFrame = v.Direction * CFrame.new(0, 0, -0.5 * v.Distance)
		Debris:AddItem(clone_2, 0.1 / ((#tbl) - (i - 1)))
		clone_2.Parent = Camera
	end
end
pcall(function() -- Line 91
	FireRay(script:WaitForChild("StartPosition").Value, script:WaitForChild("TargetPosition").Value)
	if not script:WaitForChild("RayHit").Value then
	end
end)
Debris:AddItem(script, 1)