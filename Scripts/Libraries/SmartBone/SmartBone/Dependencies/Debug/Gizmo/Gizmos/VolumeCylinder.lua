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
local Terrain = workspace.Terrain
local t = {}

t.__index = t
function t.Init(p1, p2, p3, p4, p5, p6) --[[ Init | Line: 6 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Ceive = p1
	v2.Propertys = p2
	v2.Request = p3
	v2.Release = p4
	v2.Retain = p5
	v2.Register = p6

	return v2
end
function t.Draw(p1, p2, p3, p4, p5, p6) --[[ Draw | Line: 19 | Upvalues: Terrain (copy) ]]
	local Ceive = p1.Ceive

	if Ceive.Enabled then
		local v1 = p1.Request("CylinderHandleAdornment")

		v1.Color3 = p1.Propertys.Color3
		v1.Transparency = p1.Propertys.Transparency
		v1.CFrame = p2
		v1.Height = p4
		v1.Radius = p3
		v1.InnerRadius = p5 or 0
		v1.Angle = p6 or 360
		v1.AlwaysOnTop = p1.Propertys.AlwaysOnTop
		v1.ZIndex = 1
		v1.Adornee = Terrain
		v1.Parent = Terrain
		Ceive.ActiveInstances = Ceive.ActiveInstances + 1
		p1.Register(v1)
		p1.Ceive.ScheduleCleaning()
	end
end
function t.Create(p1, p2, p3, p4, p5, p6) --[[ Create | Line: 46 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Radius = p3,
		Length = p4,
		InnerRadius = p5 or 0,
		Angle = p6 or 360,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 65 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Transform, p2.Radius, p2.Length, p2.InnerRadius, p2.Angle)
end

return t