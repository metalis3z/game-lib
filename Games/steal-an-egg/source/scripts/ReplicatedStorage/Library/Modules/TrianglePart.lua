-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Tri = Instance.new("WedgePart")

Tri.Color = Color3.fromRGB(200, 255, 200)
Tri.Material = Enum.Material.SmoothPlastic
Tri.Reflectance = 0
Tri.Transparency = 0
Tri.Name = "Tri"
Tri.Anchored = true
Tri.CanCollide = false
Tri.CanTouch = false
Tri.CanQuery = false
Tri.CFrame = CFrame.new()
Tri.Size = Vector3.new(0.25, 0.25, 0.25)
Tri.BottomSurface = Enum.SurfaceType.Smooth
Tri.TopSurface = Enum.SurfaceType.Smooth

local function fromAxes(p1, p2, p3, p4) --[[ fromAxes | Line: 18 ]]
	return CFrame.new(p1.x, p1.y, p1.z, p2.x, p3.x, p4.x, p2.y, p3.y, p4.y, p2.z, p3.z, p4.z)
end

function t.Triangle(p1, p2, p3, p4) --[[ Triangle | Line: 22 | Upvalues: Tri (copy) ]]
	local magnitude = (p3 - p2).magnitude
	local magnitude2 = (p4 - p2).magnitude
	local magnitude3 = (p4 - p3).magnitude

	if magnitude3 < magnitude and magnitude2 < magnitude then
		p2, p4 = p4, p2
	elseif magnitude3 < magnitude2 and magnitude < magnitude2 then
		p3, p2 = p2, p3
	end

	local v1 = p3 - p2
	local v2 = p4 - p2
	local v3 = p4 - p3
	local unit = v2:Cross(v1).unit
	local v4 = Tri:Clone()
	local v5 = Tri:Clone()
	local unit2 = v3:Cross(unit).unit
	local v7 = math.abs((v1:Dot(unit2)))
	local magnitude4 = v3.magnitude

	v4.Size = Vector3.new(0, math.abs((v1:Dot(v3))) / magnitude4, v7)
	v5.Size = Vector3.new(0, v7, math.abs((v2:Dot(v3))) / magnitude4)

	local v12 = -v3.unit
	local v13 = (p2 + p3) / 2
	local v14 = -unit
	local v15 = -unit2

	v4.CFrame = CFrame.new(v13.x, v13.y, v13.z, v14.x, v12.x, v15.x, v14.y, v12.y, v15.y, v14.z, v12.z, v15.z)

	local v16 = (p2 + p4) / 2
	local v17 = -unit

	v5.CFrame = CFrame.new(v16.x, v16.y, v16.z, v17.x, unit2.x, v12.x, v17.y, unit2.y, v12.y, v17.z, unit2.z, v12.z)

	return v4, v5
end

return t