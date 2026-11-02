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
-- CQMfDHNldG1ldGF0YWJsZQVDZWl2ZQlQcm9wZXJ0eXMHUmVxdWVzdAdSZWxlYXNlBlJldGFpbghSZWdpc3RlcgRJbml0B0VuYWJsZWQTQ29uZUhhbmRsZUFkb3JubWVudAZDb2xvcjMMVHJhbnNwYXJlbmN5BkNGcmFtZQtBbHdheXNPblRvcAZaSW5kZXgGSGVpZ2h0BlJhZGl1cwdBZG9ybmVlBlBhcmVudA9BY3RpdmVJbnN0YW5jZXMQU2NoZWR1bGVDbGVhbmluZwREcmF3CVRyYW5zZm9ybQZMZW5ndGgHRGVzdHJveQZDcmVhdGUMUHVzaFByb3BlcnR5BlVwZGF0ZQl3b3Jrc3BhY2UHVGVycmFpbgdfX2luZGV4AQ0ABQkGAQAAABX/BwQAAAAAAPsIAACePQcDCAAAAKQGAQAAAABAnwYDAjAABjcCAAAAMAEG6gMAAAAwAgZMBAAAADADBlwFAAAAMAQGjwYAAAAwBQaDBwAAAIIGAgAIAwEEAAAAQAMCAwMDBAMFAwYDBwAGCAEYAAAAAAAAAAACAAEAAQABAAEAAQACBwAAAAAIBAEAAAkGAAAFBARAAgI6TQQANwAAAABNBQTwAQAAACsFAQCCAAEATQUATAIAAABvBgMAnwUCAk0GAOoEAAAATQYGmgUAAAAwBgWaBQAAAE0GAOoEAAAATQYG2QYAAAAwBgXZBgAAADABBYUHAAAATQYA6gQAAABNBgaOCAAAADAGBY4IAAAAjAYBADAGBQ0JAAAAMAMFvAoAAAAwAgVxCwAAAPsGAAAwBgUUDAAAAPsGAAAwBgUkDQAAAE0GBEQOAAAAlQYGDzAGBEQOAAAATQYAgxAAAABSBwUAnwYCAU0GADcAAAAATQYGOhEAAACfBgEBggABABIDAgMJAwQDCgMDAwsDDAMNAw4DDwMQAxEDEgMTAxQCAAAAAAAA8D8DBwMVABMWARgAAAIAAAEDAAAAAQAAAAAAAQAAAAAAAgABAAAAAAABAAABAAEAAQAAAQAAAgAAAAACAAAAAQAAAAABFAAAAAAIBAAAAAkGAAAFBARAAgIf4gQKADABBCEAAAAAMAIEcQEAAAAwAwStAgAAAE0FAOoLAAAATQUFjgMAAAAwBQSOAwAAAE0FAOoLAAAATQUF2QQAAAAwBQTZBAAAAE0FAOoLAAAATQUFmgUAAAAwBQSaBQAAAE0FAI8MAAAAUgYAAFIHBACfBQMBggQCAA0DFwMRAxgDDgMMAwsDCQEBAxkBAAgIAP////8B/////wL/////A/////8E/////wX/////BgcAAAAICQAAAAMDAwYALBoBGAABAAEAAQABAAAAAAABAAAAAAABAAAAAAAFAAAAAAItAAAAAAgCAAAAAB5NAgA3AAAAAE0DAjMBAAAAbwQCAE0FAY4CAAAAnwMDAU0DAjMBAAAAbwQDAE0FAdkDAAAAnwMDAU0DAjMBAAAAbwQEAE0FAZoEAAAAnwMDAU0FASEFAAAATQYBcQYAAABNBwGtBwAAALwDANQIAAAAnwMFAYIAAQAJAwIDGwMOAwwDCwMXAxEDGAMWAD0cARgAAAIAAAAAAAEAAAAAAAEAAAAAAAIAAAAAAAAAAAE+AAAAAAMAAAECABijAAAApAABAAAAAEBNAABUAgAAAP8BBAAAAAAAMAEBbgMAAADAAgQAEgABADACAXMFAAAAwAIGABIAAAAwAgHUBwAAAMACCAAwAgGWCQAAAMACCgAwAgEmCwAAAIIBAgAMAx0EAAAAQAMeAx8GAAMIBgEDFgYCAxoGAwMcBAABAgMBAAEYAAAAAAACAAEAAgAAAA0AAAAZAAARAAAKAQAAAAAE2ZNZ9dcKd11VxFwQQt+usKmLToHrVzP0

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
function t.Draw(p1, p2, p3, p4) --[[ Draw | Line: 19 | Upvalues: Terrain (copy) ]]
	local Ceive = p1.Ceive

	if Ceive.Enabled then
		local v1 = p1.Request("ConeHandleAdornment")

		v1.Color3 = p1.Propertys.Color3
		v1.Transparency = p1.Propertys.Transparency
		v1.CFrame = p2
		v1.AlwaysOnTop = p1.Propertys.AlwaysOnTop
		v1.ZIndex = 1
		v1.Height = p4
		v1.Radius = p3
		v1.Adornee = Terrain
		v1.Parent = Terrain
		Ceive.ActiveInstances = Ceive.ActiveInstances + 1
		p1.Register(v1)
		p1.Ceive.ScheduleCleaning()
	end
end
function t.Create(p1, p2, p3, p4) --[[ Create | Line: 44 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Radius = p3,
		Length = p4,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 61 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Transform, p2.Radius, p2.Length)
end

return t