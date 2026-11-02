--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

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

	if not Ceive.Enabled then
		return
	end

	local Position = p2.Position
	local v1 = p3 * 0.5
	local v2 = p2.UpVector * v1.Y
	local v3 = p2.RightVector * v1.X
	local v4 = p2.LookVector * v1.Z
	local v5 = nil
	local v6 = nil
	local v7 = nil
	local v8 = nil

	local function CalculateYFace(p1, p2, p3) --[[ CalculateYFace | Line: 38 | Upvalues: Position (copy), v5 (ref), v6 (ref), Ceive (copy), p4 (copy) ]]
		local v1 = Position + (p1 - p2 + p3)
		local v2 = Position + (p1 + p2 + p3)
		local v3 = Position + (p1 - p2 - p3)
		local v4 = Position + (p1 + p2 - p3)

		v5 = v1
		v6 = v2
		Ceive.Ray:Draw(v1, v2)
		Ceive.Ray:Draw(v1, v3)
		Ceive.Ray:Draw(v2, v4)

		if p4 ~= false then
			Ceive.Ray:Draw(v2, v3)
		end

		Ceive.Ray:Draw(v3, v4)
	end

	local function CalculateZFace(p1, p2, p3) --[[ CalculateZFace | Line: 58 | Upvalues: Position (copy), v7 (ref), v8 (ref), Ceive (copy), p4 (copy) ]]
		local v1 = Position + (p1 - p2 + p3)
		local v2 = Position + (p1 + p2 + p3)
		local v3 = Position + (-p1 - p2 + p3)
		local v4 = Position + (-p1 + p2 + p3)

		v7 = v1
		v8 = v2
		Ceive.Ray:Draw(v1, v2)
		Ceive.Ray:Draw(v1, v3)
		Ceive.Ray:Draw(v2, v4)

		if p4 ~= false then
			Ceive.Ray:Draw(v2, v3)
		end

		Ceive.Ray:Draw(v3, v4)
	end

	CalculateYFace(-v2, v3, v4)
	CalculateZFace(v2, v3, -v4)
	Ceive.Ray:Draw(v5, v7)
	Ceive.Ray:Draw(v6, v8)

	if p4 == false then
		return
	end

	Ceive.Ray:Draw(v6, v7)
end
function t.Create(p1, p2, p3, p4) --[[ Create | Line: 89 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Size = p3,
		DrawTriangles = p4,
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
	p1:Draw(p2.Transform, p2.Size, p2.DrawTriangles)
end

return t