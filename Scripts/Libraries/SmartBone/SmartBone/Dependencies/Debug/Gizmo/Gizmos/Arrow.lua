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
-- CQMbDHNldG1ldGF0YWJsZQVDZWl2ZQlQcm9wZXJ0eXMHUmVxdWVzdAdSZWxlYXNlBlJldGFpbgRJbml0B0VuYWJsZWQDUmF5BERyYXcGQ0ZyYW1lBmxvb2tBdARVbml0BENvbmUGT3JpZ2luA0VuZAZSYWRpdXMGTGVuZ3RoDFN1YmRpdmlzaW9ucwtBbHdheXNPblRvcAxUcmFuc3BhcmVuY3kGQ29sb3IzB0Rlc3Ryb3kGQ3JlYXRlDFB1c2hQcm9wZXJ0eQZVcGRhdGUHX19pbmRleAAFCAUBAAAAE/8GBAAAAAAA+wcAAJ49BgMHAAAApAUBAAAAAECfBQMCMAAFNwIAAAAwAQXqAwAAADACBUwEAAAAMAMFXAUAAAAwBAWPBgAAAIIFAgAHAwEEAAAAQAMCAwMDBAMFAwYABAcBGAAAAAAAAAAAAgABAAEAAQABAAIFAAAAAA4GAAAADwgAAQUGBAgIAgICCAoQAiFNBgA3AAAAAE0HBvABAAAAKwcBAIIAAQBNBwa4AgAAAFIJAQBSCgIAvAcH1AMAAACfBwQBpAcGAAAUQIAmCgECTQoKBwcAAABbCwQICQkKC0MIAglSCQIAnwcDAk0IBjQJAAAAUgoHAFILAwBSDAQAUg0FALwICNQDAAAAnwgGAYIAAQAKAwIDCAMJAwoDCwMMBAAUQIADDQIAAAAAAADgPwMOABAKARgAAAIAAAEDAAAAAAAAAgAAAAAAAAAAAAEAAAAAAAAAAAERAAAAAAoGAAAACwgAAAUGBAgIAgICI+IGDAAwAQZDAAAAADACBgsBAAAAMAMGcQIAAAAwBAatAwAAADAFBpkEAAAATQcA6g0AAABNBweOBQAAADAHBo4FAAAATQcA6g0AAABNBwfZBgAAADAHBtkGAAAATQcA6g0AAABNBweaBwAAADAHBpoHAAAATQcAjw4AAABSCAAAUgkGAJ8HAwGCBgIADwMPAxADEQMSAxMDFAMVAxYDCAEBAxcBAAgKAP////8B/////wL/////A/////8E/////wX/////Bv////8H/////wgJAAAACgsAAAADAwMGAB0YARgAAQABAAEAAQABAAEAAAAAAAEAAAAAAAEAAAAAAAUAAAAAAh4AAAAACgIAAAAAIk0CADcAAAAATQMCMwEAAABvBAIATQUBjgIAAACfAwMBTQMCMwEAAABvBAMATQUB2QMAAACfAwMBTQMCMwEAAABvBAQATQUBmgQAAACfAwMBTQUBQwUAAABNBgELBgAAAE0HAXEHAAAATQgBrQgAAABNCQGZCQAAALwDANQKAAAAnwMHAYIAAQALAwIDGQMUAxUDFgMPAxADEQMSAxMDCgAwGgEYAAACAAAAAAABAAAAAAABAAAAAAACAAAAAAAAAAAAAAAAATEAAAAAAgAAAQIAE6MAAAD/AAQAAAAAADAAAG4AAAAAwAEBABIAAAAwAQBzAgAAAMABAwAwAQDUBAAAAMABBQAwAQCWBgAAAMABBwAwAQAmCAAAAIIAAgAJAxsGAAMHBgEDCgYCAxgGAwMaBAABAgMBAAEYAAAAAQACAAAADAAADQAAEwAACgEAAAAABMPZf5kkYcbTN6k2+MmVz+mzwWjt8R0VmA==

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

	if Ceive.Enabled then
		Ceive.Ray:Draw(p2, p3)
		Ceive.Cone:Draw(CFrame.lookAt(p3 + (p2 - p3).Unit * (p5 * 0.5), p3), p4, p5, p6)
	end
end
function t.Create(p1, p2, p3, p4, p5, p6) --[[ Create | Line: 29 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Origin = p2,
		End = p3,
		Radius = p4,
		Length = p5,
		Subdivisions = p6,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 48 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Origin, p2.End, p2.Radius, p2.Length, p2.Subdivisions)
end

return t