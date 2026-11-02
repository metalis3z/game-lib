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
-- CQMiDHNldG1ldGF0YWJsZQVDZWl2ZQlQcm9wZXJ0eXMHUmVxdWVzdAdSZWxlYXNlBlJldGFpbghSZWdpc3RlcgRJbml0B0VuYWJsZWQGQ0ZyYW1lBmxvb2tBdARVbml0CFBvc2l0aW9uCU1hZ25pdHVkZQ5Wb2x1bWVDeWxpbmRlcgREcmF3A1JheQpWb2x1bWVDb25lEFNjaGVkdWxlQ2xlYW5pbmcGT3JpZ2luA0VuZA5DeWxpbmRlclJhZGl1cwpDb25lUmFkaXVzBkxlbmd0aAtVc2VDeWxpbmRlcgtBbHdheXNPblRvcAxUcmFuc3BhcmVuY3kGQ29sb3IzB0Rlc3Ryb3kGQ3JlYXRlDFB1c2hQcm9wZXJ0eQZSYWRpdXMGVXBkYXRlB19faW5kZXgABQkGAQAAABX/BwQAAAAAAPsIAACePQcDCAAAAKQGAQAAAABAnwYDAjAABjcCAAAAMAEG6gMAAAAwAgZMBAAAADADBlwFAAAAMAQGjwYAAAAwBQaDBwAAAIIGAgAIAwEEAAAAQAMCAwMDBAMFAwYDBwAECAEYAAAAAAAAAAACAAEAAQABAAEAAQACBQAAAAARBwAAABAJAAEFBwQICAICAoEICwkCO00HADcAAAAATQgH8AEAAAArCAEAggABAKQIBAAADCCAJgsCAU0LCwcFAAAAWwwFBgkKCwwmCQIKUgoCAJ8IAwIqBhUAAQAAgE0JCDsHAAAAJgoJAU0KCqoIAAAApAsEAAAMIIBDDQEJWwwNBlINAgCfCwMCTQwHCwkAAABSDgsAUg8DAFIQCgC8DAzUCgAAAJ8MBQFlAAcATQkHuAsAAABSCwEAUgwCALwJCdQKAAAAnwkEAU0JB3oMAAAAUgsIAFIMBABSDQUAvAkJ1AoAAACfCQUBTQkANwAAAABNCQk6DQAAAJ8JAQGCAAEADgMCAwkDCgMLBAAMIIADDAIAAAAAAADgPwMNAw4DDwMQAxEDEgMTABEQARgAAAIAAAEDAAAAAAAAAAAAAgABAAEAAAEAAAAAAAIAAAAAAAAAAAIAAAAAAAADAAAAAAAAAAEAAAAAARIAAAAACwcAAAAMCQAABQcECAgCAgKBJeIHDQAwAQdDAAAAADACBwsBAAAAMAMH+QIAAAAwBAcWAwAAADAFB60EAAAAMAYHZwUAAABNCADqDgAAAE0ICI4GAAAAMAgHjgYAAABNCADqDgAAAE0ICNkHAAAAMAgH2QcAAABNCADqDgAAAE0ICJoIAAAAMAgHmggAAABNCACPDwAAAFIJAABSCgcAnwgDAYIHAgAQAxQDFQMWAxcDGAMZAxoDGwMcAwkBAQMdAQAICwD/////Af////8C/////wP/////BP////8F/////wb/////B/////8I/////wkKAAAACwwAAAADAwMGACgeARgAAQABAAEAAQABAAEAAQAAAAAAAQAAAAAAAQAAAAAABQAAAAACKQAAAAAKAgAAAAAiTQIANwAAAABNAwIzAQAAAG8EAgBNBQGOAgAAAJ8DAwFNAwIzAQAAAG8EAwBNBQHZAwAAAJ8DAwFNAwIzAQAAAG8EBABNBQGaBAAAAJ8DAwFNBQFDBQAAAE0GAQsGAAAATQcBcQcAAABNCAGtCAAAAE0JAWcJAAAAvAMA1AoAAACfAwcBggABAAsDAgMfAxoDGwMcAxQDFQMgAxgDGQMQADwhARgAAAIAAAAAAAEAAAAAAAEAAAAAAAIAAAAAAAAAAAAAAAABPQAAAAACAAABAgATowAAAP8ABAAAAAAAMAAAbgAAAADAAQEAEgAAADABAHMCAAAAwAEDADABANQEAAAAwAEFADABAJYGAAAAwAEHADABACYIAAAAggACAAkDIgYAAwgGAQMQBgIDHgYDAyEEAAECAwEAARgAAAABAAIAAAANAAAXAAAUAAAKAQAAAAAEwBJknx0qAHU+BQctucpV+7AKc+vy1g6e

-- https://lua.expert/
local t = {}

t.__index = t
function t.Init(p1, p2, p3, p4, p5, p6) --[[ Init | Line: 4 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Ceive = p1
	v2.Propertys = p2
	v2.Request = p3
	v2.Release = p4
	v2.Retain = p5
	v2.Register = p6

	return v2
end
function t.Draw(p1, p2, p3, p4, p5, p6, p7) --[[ Draw | Line: 17 ]]
	local Ceive = p1.Ceive

	if not Ceive.Enabled then
		return
	end

	local v1 = CFrame.lookAt(p3 - (p3 - p2).Unit * (p6 * 0.5), p3)

	if p7 == true then
		local Position = v1.Position

		Ceive.VolumeCylinder:Draw(CFrame.lookAt((p2 + Position) * 0.5, p3), p4, (Position - p2).Magnitude)
	else
		Ceive.Ray:Draw(p2, p3)
	end

	Ceive.VolumeCone:Draw(v1, p5, p6)
	p1.Ceive.ScheduleCleaning()
end
function t.Create(p1, p2, p3, p4, p5, p6, p7) --[[ Create | Line: 40 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Origin = p2,
		End = p3,
		CylinderRadius = p4,
		ConeRadius = p5,
		Length = p6,
		UseCylinder = p7,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 60 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Origin, p2.End, p2.Radius, p2.Length, p2.UseCylinder)
end

return t