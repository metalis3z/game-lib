-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function Map(p1, p2, p3, p4, p5) --[[ Map | Line: 1 ]]
	return (p1 - p2) / (p3 - p2) * (p5 - p4) + p4
end

local t = {}

t.__index = t
function t.Init(p1, p2, p3, p4, p5) --[[ Init | Line: 8 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Ceive = p1
	v2.Propertys = p2
	v2.Request = p3
	v2.Release = p4
	v2.Retain = p5

	return v2
end
function t.Draw(p1, p2, p3, p4, p5) --[[ Draw | Line: 20 ]]
	local Ceive = p1.Ceive

	if not Ceive.Enabled then
		return
	end

	local v1 = (1 / 0)
	local v2 = (-1 / 0)
	local v3 = (-1 / 0)
	local v4 = (-1 / 0)
	local v5 = (1 / 0)
	local v6 = (1 / 0)

	for v7, v8 in p4 do
		local v9 = math.max(v2, v8.x)
		local v10 = math.max(v3, v8.y)
		local v11 = math.max(v4, v8.z)
		local v12 = math.min(v5, v8.x)
		local v13 = math.min(v6, v8.y)

		v1, v2, v3, v4, v5, v6 = math.min(v1, v8.z), v9, v10, v11, v12, v13
	end

	for v15, v16 in p4 do
		p4[v15] = p2 * CFrame.new(Vector3.new((v16.x - v5) / (v2 - v5) * 1 + -0.5, (v16.y - v6) / (v3 - v6) * 1 + -0.5, (v16.z - v1) / (v4 - v1) * 1 + -0.5) * p3)
	end

	for v20, v21 in p5 do
		if #v21 == 3 then
			local v22 = p4[v21[1].v]
			local v23 = p4[v21[2].v]
			local v24 = p4[v21[3].v]

			Ceive.Ray:Draw(v22.Position, v23.Position)
			Ceive.Ray:Draw(v23.Position, v24.Position)
			Ceive.Ray:Draw(v24.Position, v22.Position)

			continue
		end

		local v25 = p4[v21[1].v]
		local v26 = p4[v21[2].v]
		local v27 = p4[v21[3].v]
		local v28 = p4[v21[4].v]

		Ceive.Ray:Draw(v25.Position, v26.Position)
		Ceive.Ray:Draw(v25.Position, v28.Position)
		Ceive.Ray:Draw(v28.Position, v26.Position)
		Ceive.Ray:Draw(v27.Position, v28.Position)
		Ceive.Ray:Draw(v26.Position, v27.Position)
	end
end
function t.Create(p1, p2, p3, p4, p5) --[[ Create | Line: 79 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Size = p3,
		Vertices = p4,
		Faces = p5,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 97 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Transform, p2.Size, p2.Vertices, p2.Faces)
end

return t