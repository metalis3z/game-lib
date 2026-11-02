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
-- CQMXDHNldG1ldGF0YWJsZQVDZWl2ZQlQcm9wZXJ0eXMHUmVxdWVzdAdSZWxlYXNlBlJldGFpbgRJbml0B0VuYWJsZWQIUG9zaXRpb24KTG9va1ZlY3RvcgNSYXkERHJhdwlUcmFuc2Zvcm0GTGVuZ3RoC0Fsd2F5c09uVG9wDFRyYW5zcGFyZW5jeQZDb2xvcjMHRGVzdHJveQZDcmVhdGUMUHVzaFByb3BlcnR5BlVwZGF0ZQdfX2luZGV4BkNGcmFtZQEXAAUIBQEAAAAT/wYEAAAAAAD7BwAAnj0GAwcAAACkBQEAAAAAQJ8FAwIwAAU3AgAAADABBeoDAAAAMAIFTAQAAAAwAwVcBQAAADAEBY8GAAAAggUCAAcDAQQAAABAAwIDAwMEAwUDBgAEBwEYAAAAAAAAAAACAAEAAQABAAEAAgUAAAAACgMAAAAIBQAABQMEQAIdTQMANwAAAABNBAPwAQAAACsEAQCCAAEATQUBOwIAAABNBwFoAwAAADkJAgBbCAkECQYHCEMEBQZNBgE7AgAAAE0IAWgDAAAAWwkCBAkHCAlDBQYHTQYDuAUAAABSCAQAUgkFALwGBtQGAAAAnwYEAYIAAQAHAwIDCAMJAwoCAAAAAAAA4D8DCwMMABAMARgAAAIAAAEDAAAAAAAAAAEAAAAAAAACAAAAAAAAAREAAAAABwMAAAAIBQAABQMEQAId4gMJADABAyEAAAAAMAIDrQEAAABNBADqCgAAAE0EBI4CAAAAMAQDjgIAAABNBADqCgAAAE0EBNkDAAAAMAQD2QMAAABNBADqCgAAAE0EBJoEAAAAMAQDmgQAAABNBACPCwAAAFIFAABSBgMAnwQDAYIDAgAMAw0DDgMPAxADEQMIAQEDEgEACAcA/////wH/////Av////8D/////wT/////BQYAAAAHCAAAAAMDAwYAHRMBGAABAAEAAQAAAAAAAQAAAAAAAQAAAAAABQAAAAACHgAAAAAHAgAAAAAcTQIANwAAAABNAwIzAQAAAG8EAgBNBQGOAgAAAJ8DAwFNAwIzAQAAAG8EAwBNBQHZAwAAAJ8DAwFNAwIzAQAAAG8EBABNBQGaBAAAAJ8DAwFNBQEhBQAAAE0GAa0GAAAAvAMA1AcAAACfAwQBggABAAgDAgMUAw8DEAMRAw0DDgMMAC0VARgAAAIAAAAAAAEAAAAAAAEAAAAAAAIAAAAAAAABLgAAAAACAAABAgATowAAAP8ABAAAAAAAMAAAbgAAAADAAQEAEgAAADABAHMCAAAAwAEDADABANQEAAAAwAEFADABAJYGAAAAwAEHADABACYIAAAAggACAAkDFgYAAwcGAQMMBgIDEwYDAxUEAAECAwEAARgAAAABAAIAAAAMAAANAAAQAAAKAQAAAAAEFhgFM8dKXGYoTlOEYkIw02YAEkck3G8y

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
function t.Draw(p1, p2, p3) --[[ Draw | Line: 16 ]]
	local Ceive = p1.Ceive

	if Ceive.Enabled then
		Ceive.Ray:Draw(p2.Position + p2.LookVector * (-p3 * 0.5), p2.Position + p2.LookVector * (p3 * 0.5))
	end
end
function t.Create(p1, p2, p3) --[[ Create | Line: 29 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Length = p3,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 45 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Transform, p2.Length)
end

return t