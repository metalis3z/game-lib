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
function t.Draw(p1, p2, p3, p4, p5, p6) --[[ Draw | Line: 16 ]]
	local Ceive = p1.Ceive

	if not Ceive.Enabled then
		return
	end

	local v1 = nil
	local v2 = 0
	local v3 = nil

	for i = 0, p5, math.floor(p5 / p4) do
		local v5 = math.sin((math.rad(i))) * p3
		local v8 = p2.Position + (p2.UpVector * (math.cos((math.rad(i))) * p3) + p2.RightVector * v5)

		if v1 == nil then
			v1 = v8
			v2 = i
			v3 = v8

			continue
		end

		Ceive.Ray:Draw(v1, v8)
		v1, v2 = v8, i
	end

	if v2 ~= p5 then
		local v10 = math.sin((math.rad(p5))) * p3

		Ceive.Ray:Draw(v1, p2.Position + (p2.UpVector * (math.cos((math.rad(p5))) * p3) + p2.RightVector * v10))
	end

	if p6 ~= false then
		Ceive.Ray:Draw(v1, v3)
	end

	return v1
end
function t.Create(p1, p2, p3, p4, p5, p6) --[[ Create | Line: 66 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Radius = p3,
		Subdivisions = p4,
		Angle = p5,
		ConnectToStart = p6,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 85 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Transform, p2.Radius, p2.Subdivisions, p2.Angle, p2.ConnectToStart)
end

return t