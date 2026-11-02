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

	local v1 = p2.Position + p2.UpVector * (p4 * 0.5)
	local v2 = p2.Position - p2.UpVector * (p4 * 0.5)
	local v5, v6, v7, v8, v9, v10 = nil, nil, CFrame.lookAt(v1, v1 + p2.UpVector), CFrame.lookAt(v2, v2 - p2.UpVector), nil, nil

	for i = 0, 360, math.floor(360 / p5) do
		local v12 = math.sin((math.rad(i))) * p3
		local v15 = p2.LookVector * (math.cos((math.rad(i))) * p3) + p2.RightVector * v12
		local v16 = v7.Position + v15
		local v17 = v8.Position + v15

		Ceive.Ray:Draw(v16, v17)
		Ceive.Circle:Draw(CFrame.new(v7.Position) * p2.Rotation * CFrame.Angles(0, math.rad(i), 0), p3, p5 * 0.5, 90, false)
		Ceive.Circle:Draw(CFrame.new(v8.Position) * p2.Rotation * CFrame.Angles(math.pi, math.rad(i), 0), p3, p5 * 0.5, 90, false)

		if v5 then
			Ceive.Ray:Draw(v5, v16)
			Ceive.Ray:Draw(v6, v17)
			v5 = v16
			v6 = v17

			continue
		end

		v5, v6, v9, v10 = v16, v17, v16, v17
	end

	Ceive.Ray:Draw(v5, v9)
	Ceive.Ray:Draw(v6, v10)
end
function t.Create(p1, p2, p3, p4, p5) --[[ Create | Line: 88 ]]
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
function t.Update(p1, p2) --[[ Update | Line: 106 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Transform, p2.Radius, p2.Length, p2.Subdivisions)
end

return t