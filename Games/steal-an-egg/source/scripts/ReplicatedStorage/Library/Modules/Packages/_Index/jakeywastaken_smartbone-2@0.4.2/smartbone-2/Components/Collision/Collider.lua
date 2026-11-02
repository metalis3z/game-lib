-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local Dependencies = script.Parent.Parent.Parent:WaitForChild("Dependencies")
local Colliders = script.Parent:WaitForChild("Colliders")
local Box = require(Colliders:WaitForChild("Box"))
local Capsule = require(Colliders:WaitForChild("Capsule"))
local Cylinder = require(Colliders:WaitForChild("Cylinder"))
local Sphere = require(Colliders:WaitForChild("Sphere"))
local Config = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Config"))
local SB_VERBOSE_LOG = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")).SB_VERBOSE_LOG
local Gizmo = require(Dependencies:WaitForChild("Gizmo"))

if game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG or Config.ALLOW_LIVE_GAME_DEBUG then
	Gizmo.Init()
end

local t = {}

t.__index = t
function t.new() --[[ new | Line: 76 | Upvalues: HttpService (copy), t (copy) ]]
	return setmetatable({
		Type = "Box",
		Scale = Vector3.new(0, 0, 0),
		Offset = Vector3.new(0, 0, 0),
		Rotation = Vector3.new(0, 0, 0),
		Radius = 0,
		PreviousScale = Vector3.new(0, 0, 0),
		PreviousOffset = Vector3.new(0, 0, 0),
		PreviousRotation = Vector3.new(0, 0, 0),
		PreviousObjectPosition = Vector3.new(0, 0, 0),
		PreviousObjectRotation = Vector3.new(0, 0, 0),
		m_Object = nil,
		InNarrowphase = false,
		Size = Vector3.new(0, 0, 0),
		Transform = CFrame.identity,
		GUID = HttpService:GenerateGUID(false)
	}, t)
end
function t.SetObject(p1, p2) --[[ SetObject | Line: 105 ]]
	p1.m_Object = p2
	p1:UpdateTransform()
end
function t.UpdateTransform(p1) --[[ UpdateTransform | Line: 112 ]]
	local m_Object = p1.m_Object
	local Size = m_Object.Size
	local Rotation = p1.Rotation
	local v2 = Size * p1.Scale
	local v3 = CFrame.Angles(Rotation.X * 0.017453, Rotation.Y * 0.017453, Rotation.Z * 0.017453)

	p1.Transform = m_Object.CFrame * CFrame.new(Size * p1.Offset) * v3
	p1.Size = v2
	p1.Radius = math.sqrt((math.max(v2.X, v2.Y, v2.Z) * 0.5) ^ 2 * 2)
end
function t.GetClosestPoint(p1, p2, p3) --[[ GetClosestPoint | Line: 139 | Upvalues: Box (copy), Capsule (copy), Sphere (copy), Cylinder (copy) ]]
	if p1.m_Object == nil then
		return
	end

	p1.InNarrowphase = false

	if (p2 - p1.Transform.Position).Magnitude - p3 > p1.Radius then
		return
	end

	p1.InNarrowphase = true

	local Type = p1.Type
	local v1, v2, v3

	if Type == "Box" then
		local v4, v5, v6 = Box(p1.Transform, p1.Size, p2, p3)

		v1 = v4
		v2 = v5
		v3 = v6
	else
		v1 = nil
		v2 = nil
		v3 = nil
	end

	if Type == "Capsule" then
		local v7, v8, v9 = Capsule(p1.Transform, p1.Size, p2, p3)

		v1 = v7
		v2 = v8
		v3 = v9
	end

	if Type == "Sphere" then
		local v10, v11, v12 = Sphere(p1.Transform, p1.Size, p2, p3)

		v1 = v10
		v2 = v11
		v3 = v12
	end

	if Type == "Cylinder" then
		local v13, v14, v15 = Cylinder(p1.Transform, p1.Size, p2, p3)

		v1 = v13
		v2 = v14
		v3 = v15
	end

	return v1, v2, v3
end
function t.Step(p1) --[[ Step | Line: 184 ]]
	p1:UpdateTransform()
end
function t.DrawDebug(p1, p2, p3, p4, p5, p6) --[[ DrawDebug | Line: 198 | Upvalues: Gizmo (copy) ]]
	local v1 = Color3.new(0.509803, 0.933333, 0.42745)
	local v2 = Color3.new(0.90196, 0.784313, 0.513725)
	local v3 = Color3.new(255/255, 0/255, 255/255)
	local v4 = Color3.new(0/255, 255/255, 255/255)
	local v5 = Color3.new(1, 0.3, 0.3)
	local Type = p1.Type
	local Transform = p1.Transform
	local Size = p1.Size

	if not p2.m_Awake and p5 then
		v1 = v3
	end

	if p1.InNarrowphase == false and p6 then
		v2 = v4
	end

	if p4 then
		Gizmo.SetStyle(v5, 0, false)
		Gizmo.Sphere:Draw(Transform, p1.Radius, 25, 360)
	end

	if Type == "Box" then
		Gizmo.SetStyle(v1, 0, false)
		Gizmo.Box:Draw(Transform, Size)

		if not p3 then
			return
		end

		Gizmo.SetStyle(v2, 0.75, false)
		Gizmo.VolumeBox:Draw(Transform, Size)
	elseif Type == "Capsule" then
		local v7 = (Size.Y < Size.Z and Size.Y or Size.Z) * 0.5
		local X = Size.X
		local v8 = Transform * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)

		Gizmo.SetStyle(v1, 0, false)
		Gizmo.Capsule:Draw(v8, v7, X, 15)

		if not p3 then
			return
		end

		Gizmo.SetStyle(v2, 0.75, false)
		Gizmo.VolumeCylinder:Draw(Transform, v7, X)
		Gizmo.VolumeSphere:Draw(CFrame.new(v8.Position + v8.UpVector * (X * 0.5)), v7)
		Gizmo.VolumeSphere:Draw(CFrame.new(v8.Position - v8.UpVector * (X * 0.5)), v7)
	elseif Type == "Sphere" then
		local v11 = math.min(Size.X, Size.Y, Size.Z) * 0.5

		Gizmo.SetStyle(v1, 0, false)
		Gizmo.Sphere:Draw(Transform, v11, 15, 360)

		if not p3 then
			return
		end

		Gizmo.SetStyle(v2, 0.75, false)
		Gizmo.VolumeSphere:Draw(Transform, v11)
	else
		if Type ~= "Cylinder" then
			return
		end

		local v13 = (Size.Y < Size.Z and Size.Y or Size.Z) * 0.5

		Gizmo.SetStyle(v1, 0, false)
		Gizmo.Cylinder:Draw(Transform * CFrame.Angles(0, 0, 1.5707963267948966), v13, Size.X, 15)

		if not p3 then
			return
		end

		Gizmo.SetStyle(v2, 0.75, false)
		Gizmo.VolumeCylinder:Draw(Transform * CFrame.Angles(0, -1.5707963267948966, 0), v13, Size.X, 0, 360)
	end

	Gizmo.PushProperty("Transparency", 0)
end
function t.Destroy(p1) --[[ Destroy | Line: 290 | Upvalues: SB_VERBOSE_LOG (copy) ]]
	SB_VERBOSE_LOG((("Collider destroying, object: %*"):format(p1.m_Object)))
	setmetatable(p1, nil)
end

return t