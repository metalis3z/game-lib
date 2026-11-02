-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local Config = require(v1:WaitForChild("Config"))
local Utilities = require(v1:WaitForChild("Utilities"))
local t = {
	GetCFrames = function(p1, p2) --[[ GetCFrames | Line: 8 ]]
		local v1 = p1.CFrame
		local Position = v1.Position
		local RightVector = v1.RightVector
		local UpVector = v1.UpVector
		local v2 = p2 * 0.5
		local v4 = math.tan((p1.FieldOfView + 5) * 0.5 * 0.017453) * p2
		local v5 = v4 * (p1.ViewportSize.X / p1.ViewportSize.Y)
		local v6 = v1 * CFrame.new(0, 0, -p2)
		local v7 = v6 * Vector3.new(v5, v4, 0)
		local v8 = v6 * Vector3.new(-v5, -v4, 0)
		local v9 = v6 * Vector3.new(v5, -v4, 0)

		return (v1 * CFrame.new(0, 0, -v2)):Inverse(), v5, v4, v2, UpVector:Cross(v9 - Position).Unit, UpVector:Cross(v8 - Position).Unit, RightVector:Cross(Position - v7).Unit, RightVector:Cross(Position - v9).Unit, v1
	end,
	InViewFrustum = function(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ InViewFrustum | Line: 42 ]]
		local v1 = p2 * p1

		if p3 < v1.X or (v1.X < -p3 or (p4 < v1.Y or (v1.Y < -p4 or (p5 < v1.Z or v1.Z < -p5)))) then
			return false
		end

		local v2 = p1 - p10.Position

		return not (p6:Dot(v2) < 0 or (p7:Dot(v2) > 0 or (p8:Dot(v2) < 0 or p9:Dot(v2) > 0)))
	end
}

function t.ObjectInFrustum(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ ObjectInFrustum | Line: 92 | Upvalues: Config (copy), Utilities (copy), t (copy) ]]
	local v1 = p1.CFrame
	local v2 = Config.FAR_PLANE * 0.5
	local v5, v6 = Utilities.ClosestPointInBox(v1, p1.Size, (Utilities.ClosestPointOnLine(p10.Position + p10.LookVector * v2, p10.LookVector, v2, v1.Position)))

	if v5 then
		return true
	end

	return t.InViewFrustum(v6, p2, p3, p4, p5, p6, p7, p8, p9, p10) and true or false
end

return t