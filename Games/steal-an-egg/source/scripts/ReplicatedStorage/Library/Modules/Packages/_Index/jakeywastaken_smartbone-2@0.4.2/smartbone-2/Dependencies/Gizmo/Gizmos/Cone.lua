-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.Init(p1, p2, p3, p4, p5) --[[ Init | Line: 6 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Ceive = p1
	v2.Propertys = p2
	v2.Request = p3
	v2.Release = p4
	v2.Retain = p5

	return v2
end
function t.Draw(p1, p2, p3, p4, p5) --[[ Draw | Line: 18 ]]
	local Ceive = p1.Ceive

	if not Ceive.Enabled then
		return
	end

	local v1 = p2 * CFrame.Angles(-1.5707963267948966, 0, 0)
	local v2 = v1.Position + v1.UpVector * (p4 * 0.5)
	local v3 = v1.Position + -v1.UpVector * (p4 * 0.5)
	local v6, v7, v8, v9 = CFrame.lookAt(v2, v2 + v1.UpVector), CFrame.lookAt(v3, v3 - v1.UpVector), nil, nil

	for i = 0, 360, math.floor(360 / p5) do
		local v11 = math.sin((math.rad(i))) * p3
		local v15 = v7.Position + (v1.LookVector * (math.cos((math.rad(i))) * p3) + v1.RightVector * v11)

		if v8 then
			Ceive.Ray:Draw(v15, v6.Position)
			Ceive.Ray:Draw(v8, v15)
			v8 = v15

			continue
		end

		Ceive.Ray:Draw(v15, v6.Position)
		v8, v9 = v15, v15
	end

	Ceive.Ray:Draw(v8, v9)
end
function t.Create(p1, p2, p3, p4, p5) --[[ Create | Line: 63 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Radius = p3,
		Length = p4,
		Subdivisions = p5,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 81 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Transform, p2.Radius, p2.Length, p2.Subdivisions)
end

return t