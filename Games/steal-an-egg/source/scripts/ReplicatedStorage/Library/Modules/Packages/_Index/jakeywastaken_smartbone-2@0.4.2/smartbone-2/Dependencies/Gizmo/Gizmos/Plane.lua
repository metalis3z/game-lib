-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.Init(p1, p2, p3, p4, p5) --[[ Init | Line: 4 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Ceive = p1
	v2.Propertys = p2
	v2.Request = p3
	v2.Release = p4
	v2.Retain = p5

	return v2
end
function t.Draw(p1, p2, p3, p4) --[[ Draw | Line: 16 ]]
	local Ceive = p1.Ceive

	if Ceive.Enabled then
		local v1 = CFrame.lookAt(p2, p2 + p3)
		local v2 = p4 * Vector3.new(1, 1, 0) * 0.5

		(function(p1, p22, p3) --[[ CalculateZFace | Line: 35 | Upvalues: p2 (copy), Ceive (copy) ]]
			local v1 = p2 + (p1 - p22 + p3)
			local v2 = p2 + (p1 + p22 + p3)
			local v3 = p2 + (-p1 - p22 + p3)
			local v4 = p2 + (-p1 + p22 + p3)

			Ceive.Ray:Draw(v1, v2)
			Ceive.Ray:Draw(v1, v3)
			Ceive.Ray:Draw(v2, v4)
			Ceive.Ray:Draw(v2, v3)
			Ceive.Ray:Draw(v3, v4)
		end)(v1.UpVector * v2.Y, v1.RightVector * v2.X, v1.LookVector * v2.Z)
	end
end
function t.Create(p1, p2, p3, p4) --[[ Create | Line: 53 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Position = p2,
		Normal = p3,
		Size = p4,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 70 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Position, p2.Normal, p2.Size)
end

return t