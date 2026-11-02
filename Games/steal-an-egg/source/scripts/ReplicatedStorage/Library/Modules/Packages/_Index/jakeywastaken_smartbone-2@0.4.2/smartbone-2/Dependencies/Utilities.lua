-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local Config = require(script.Parent:WaitForChild("Config"))
local DefaultObjectSettings = require(script.Parent:WaitForChild("DefaultObjectSettings"))
local t = {
	Block = "Box",
	Ball = "Sphere",
	Capsule = "Capsule",
	Sphere = "Sphere",
	Box = "Box",
	Cylinder = "Cylinder"
}

local function SafeUnit(p1) --[[ SafeUnit | Line: 14 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(-0, -1, -0)
	end

	return p1.Unit
end

local t2 = {
	LogIndent = 0,
	GetRotationBetween = function(p1, p2) --[[ GetRotationBetween | Line: 25 ]]
		local v1 = p1:Dot(p2)
		local Magnitude = p1:Cross(p2).Magnitude
		local v2 = math.atan2(Magnitude, v1)
		local v3 = p1:Cross(p2)

		return CFrame.fromAxisAngle(if v3.Magnitude == 0 then Vector3.new(-0, -1, -0) else v3.Unit, v2)
	end,
	GetCFrameAxis = function(p1, p2) --[[ GetCFrameAxis | Line: 34 ]]
		local v1, v2, v3 = p1:ToEulerAnglesXYZ()

		if p2 == "X" then
			return v1
		end

		if p2 == "Y" then
			return v2
		end

		if p2 == "Z" then
			return v3
		end

		return nil
	end,
	GatherObjectSettings = function(p1) --[[ GatherObjectSettings | Line: 46 | Upvalues: DefaultObjectSettings (copy) ]]
		local function Expect(p12, p2, p3) --[[ Expect | Line: 49 | Upvalues: p1 (copy) ]]
			if typeof(p12) == p2 then
				return true
			end

			warn((("[SmartBone][Object] Expected attribute %* on %* to be of type %*, got type %*"):format(p3, p1.Name, p2, (typeof(p12)))))

			return false
		end

		local t = {}

		for v3, v4 in DefaultObjectSettings do
			local v1, v2
			local v5 = p1:GetAttribute(v3)

			if v5 ~= nil then
				local v6 = typeof(v4)

				if typeof(v5) == v6 then
					v1 = true
				else
					warn((("[SmartBone][Object] Expected attribute %* on %* to be of type %*, got type %*"):format(v3, p1.Name, v6, (typeof(v5)))))
					v1 = false
				end

				if not v1 then
					v5 = nil
				end
			end

			v2 = if v5 == nil and v4 then v4 else v5
			t[v3] = v2
		end

		return t
	end,
	GatherBoneSettings = function(p1) --[[ GatherBoneSettings | Line: 77 ]]
		local function Attrib(p12) --[[ Attrib | Line: 78 | Upvalues: p1 (copy) ]]
			return p1:GetAttribute(p12)
		end

		local function Expect(p12, p2, p3) --[[ Expect | Line: 82 | Upvalues: p1 (copy) ]]
			if typeof(p12) == p2 then
				return
			end

			warn((("[SmartBone][Bone] Expected attribute %* on %* to be of type %*, got type %*"):format(p3, p1.Name, p2, (typeof(p12)))))
		end

		local v1 = p1:GetAttribute("XAxisLocked") or false
		local v2 = p1:GetAttribute("YAxisLocked") or false
		local v3 = p1:GetAttribute("ZAxisLocked") or false
		local v4 = p1:GetAttribute("XAxisLimits") or NumberRange.new((-1 / 0), (1 / 0))
		local v5 = p1:GetAttribute("YAxisLimits") or NumberRange.new((-1 / 0), (1 / 0))
		local v6 = p1:GetAttribute("ZAxisLimits") or NumberRange.new((-1 / 0), (1 / 0))
		local v7 = p1:GetAttribute("Radius") or 0.25
		local v8 = p1:GetAttribute("RotationLimit") or 180
		local v9 = p1:GetAttribute("Force") or "\194\172"
		local v10 = p1:GetAttribute("Gravity") or "\194\172"

		if typeof(v1) ~= "boolean" then
			warn((("[SmartBone][Bone] Expected attribute XAxisLocked on %* to be of type boolean, got type %*"):format(p1.Name, (typeof(v1)))))
		end

		if typeof(v2) ~= "boolean" then
			warn((("[SmartBone][Bone] Expected attribute YAxisLocked on %* to be of type boolean, got type %*"):format(p1.Name, (typeof(v2)))))
		end

		if typeof(v3) ~= "boolean" then
			warn((("[SmartBone][Bone] Expected attribute ZAxisLocked on %* to be of type boolean, got type %*"):format(p1.Name, (typeof(v3)))))
		end

		if typeof(v4) ~= "NumberRange" then
			warn((("[SmartBone][Bone] Expected attribute XAxisLimits on %* to be of type NumberRange, got type %*"):format(p1.Name, (typeof(v4)))))
		end

		if typeof(v5) ~= "NumberRange" then
			warn((("[SmartBone][Bone] Expected attribute YAxisLimits on %* to be of type NumberRange, got type %*"):format(p1.Name, (typeof(v5)))))
		end

		if typeof(v6) ~= "NumberRange" then
			warn((("[SmartBone][Bone] Expected attribute ZAxisLimits on %* to be of type NumberRange, got type %*"):format(p1.Name, (typeof(v6)))))
		end

		if typeof(v7) ~= "number" then
			warn((("[SmartBone][Bone] Expected attribute Radius on %* to be of type number, got type %*"):format(p1.Name, (typeof(v7)))))
		end

		if typeof(v8) ~= "number" then
			warn((("[SmartBone][Bone] Expected attribute RotationLimit on %* to be of type number, got type %*"):format(p1.Name, (typeof(v8)))))
		end

		if v9 ~= "\194\172" and typeof(v9) ~= "Vector3" then
			warn((("[SmartBone][Bone] Expected attribute Force on %* to be of type Vector3, got type %*"):format(p1.Name, (typeof(v9)))))
		end

		if v9 ~= "\194\172" and typeof(v10) ~= "Vector3" then
			warn((("[SmartBone][Bone] Expected attribute Gravity on %* to be of type Vector3, got type %*"):format(p1.Name, (typeof(v10)))))
		end

		return {
			AxisLocked = { v1, v2, v3 },
			XAxisLimits = v4,
			YAxisLimits = v5,
			ZAxisLimits = v6,
			RotationLimit = v8,
			Radius = v7,
			Force = v9,
			Gravity = v10
		}
	end,
	ClosestPointOnLine = function(p1, p2, p3, p4) --[[ ClosestPointOnLine | Line: 140 ]]
		return p1 + p2 * math.clamp((p4 - p1):Dot(p2), -p3, p3)
	end,
	ClosestPointInBox = function(p1, p2, p3) --[[ ClosestPointInBox | Line: 148 ]]
		local v1 = p1:PointToObjectSpace(p3)
		local X = p2.X
		local X2 = p2.X
		local Z = p2.Z
		local X3 = v1.X
		local Y = v1.Y
		local Z2 = v1.Z

		if v1 ~= v1 or p2 ~= p2 then
			return false, p1.Position, Vector3.new(0, 1, 0)
		end

		local v2 = math.clamp(X3, -X * 0.5, X * 0.5)
		local v3 = math.clamp(Y, -X2 * 0.5, X2 * 0.5)
		local v4 = math.clamp(Z2, -Z * 0.5, Z * 0.5)

		if v2 == X3 and (v3 == Y and v4 == Z2) then
			local v5 = X3 - X * 0.5
			local v6 = Y - X2 * 0.5
			local v7 = Z2 - Z * 0.5
			local v8 = -X3 - X * 0.5
			local v9 = -Y - X2 * 0.5
			local v10 = -Z2 - Z * 0.5
			local v11 = math.max(v5, v6, v7, v8, v9, v10)

			if v11 == v5 then
				return true, p1 * Vector3.new(X * 0.5, Y, Z2), p1.XVector
			end

			if v11 == v6 then
				return true, p1 * Vector3.new(X3, X2 * 0.5, Z2), p1.YVector
			end

			if v11 == v7 then
				return true, p1 * Vector3.new(X3, Y, Z * 0.5), p1.ZVector
			end

			if v11 == v8 then
				return true, p1 * Vector3.new(-X * 0.5, Y, Z2), -p1.XVector
			end

			if v11 == v9 then
				return true, p1 * Vector3.new(X3, -X2 * 0.5, Z2), -p1.YVector
			end

			if v11 == v10 then
				return true, p1 * Vector3.new(X3, Y, -Z * 0.5), -p1.ZVector
			end

			warn("CLOSEST POINT ON BOX FAIL")

			return false, Vector3.new(0, 0, 0), Vector3.new(0, 1, 0)
		end

		local v12 = p1 * Vector3.new(v2, v3, v4)

		return false, v12, (p3 - v12).unit
	end,
	GetCollider = function(p1) --[[ GetCollider | Line: 203 | Upvalues: HttpService (copy), t (copy) ]]
		local v1 = p1:FindFirstChild("self.Collider")
		local v2

		if v1 and v1:IsA("ModuleScript") then
			local v3 = require(v1)
			local v4 = nil

			pcall(function() --[[ Line: 212 | Upvalues: v4 (ref), HttpService (ref), v3 (copy) ]]
				v4 = HttpService:JSONDecode(v3)
			end)
			v2 = v4
		else
			v2 = nil
		end

		if v2 then
			return v2
		end

		local function GetShapeName(p1) --[[ GetShapeName | Line: 225 ]]
			local v1 = p1:GetAttribute("ColliderShape")

			if v1 then
				return v1
			end

			if p1:IsA("Part") then
				return p1.Shape.Name
			end

			return "Box"
		end

		local v6 = p1:GetAttribute("ColliderShape")

		return {
			{
				ScaleX = 1,
				ScaleY = 1,
				ScaleZ = 1,
				OffsetX = 0,
				OffsetY = 0,
				OffsetZ = 0,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Type = t[if v6 then v6 elseif p1:IsA("Part") then p1.Shape.Name else "Box"] or "Box"
			}
		}
	end
}

function t2.SB_INDENT_LOG() --[[ SB_INDENT_LOG | Line: 259 | Upvalues: t2 (copy) ]]
	local v1 = t2

	v1.LogIndent = v1.LogIndent + 1
end
function t2.SB_UNINDENT_LOG() --[[ SB_UNINDENT_LOG | Line: 263 | Upvalues: t2 (copy) ]]
	local v1 = t2

	v1.LogIndent = v1.LogIndent - 1
	t2.LogIndent = math.max(t2.LogIndent, 0)
end
function t2.SB_ASSERT_CB(p1, p2, ...) --[[ SB_ASSERT_CB | Line: 268 ]]
	if p1 ~= false and p1 ~= nil then
		return
	end

	p2(...)
end
function t2.SB_VERBOSE_LOG(p1) --[[ SB_VERBOSE_LOG | Line: 274 | Upvalues: Config (copy), t2 (copy) ]]
	if Config.LOG_VERBOSE then
		print((("%*[SmartBone][Log]: %*"):format(string.rep("    ", t2.LogIndent), p1)))
	end
end
function t2.SB_VERBOSE_WARN(p1) --[[ SB_VERBOSE_WARN | Line: 284 | Upvalues: Config (copy), t2 (copy) ]]
	if Config.LOG_VERBOSE then
		warn((("%*[SmartBone][Warn]: %*"):format(string.rep("    ", t2.LogIndent), p1)))
	end
end
function t2.SB_VERBOSE_ERROR(p1) --[[ SB_VERBOSE_ERROR | Line: 294 | Upvalues: Config (copy), t2 (copy) ]]
	if Config.LOG_VERBOSE then
		error((("%*[SmartBone][Error]: %*"):format(string.rep("    ", t2.LogIndent), p1)))
	end
end

return t2