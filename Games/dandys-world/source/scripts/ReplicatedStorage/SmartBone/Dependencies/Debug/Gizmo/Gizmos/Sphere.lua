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
-- CQMYDHNldG1ldGF0YWJsZQVDZWl2ZQlQcm9wZXJ0eXMHUmVxdWVzdAdSZWxlYXNlBlJldGFpbgRJbml0B0VuYWJsZWQGQ2lyY2xlBERyYXcGQ0ZyYW1lBkFuZ2xlcwlUcmFuc2Zvcm0GUmFkaXVzDFN1YmRpdmlzaW9ucwVBbmdsZQtBbHdheXNPblRvcAxUcmFuc3BhcmVuY3kGQ29sb3IzB0Rlc3Ryb3kGQ3JlYXRlDFB1c2hQcm9wZXJ0eQZVcGRhdGUHX19pbmRleAELAAUIBQEAAAAT/wYEAAAAAAD7BwAAnj0GAwcAAACkBQEAAAAAQJ8FAwIwAAU3AgAAADABBeoDAAAAMAIFTAQAAAAwAwVcBQAAADAEBY8GAAAAggUCAAcDAQQAAABAAwIDAwMEAwUDBgAGBwEYAAAAAAAAAAACAAEAAQABAAEAAgcAAAAADQUAAAAKBwAABQUEQAICAi5NBQA3AAAAAE0GBfABAAAAKwYBAIIAAQBNBgVwAgAAAFIIAQBSCQIAUgoDAFILBAC8BgbUAwAAAJ8GBgFNBgVwAgAAAKQJBgAAFECAjAoAAG8LBwCMDAAAnwkEAgkIAQlSCQIAUgoDAFILBAC8BgbUAwAAAJ8GBgFNBgVwAgAAAKQJBgAAFECAbwoHAIwLAACMDAAAnwkEAgkIAQlSCQIAUgoDAFILBAC8BgbUAwAAAJ8GBgGCAAEACAMCAwgDCQMKAwsDDAQAFECAAhgtRFT7Ifk/ABIKARgAAAIAAAEDAAAAAAAAAAABAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAABEwAAAAAJBQAAAAoHAAAFBQRAAgICIeIFCwAwAQUhAAAAADACBXEBAAAAMAMFmQIAAAAwBAUtAwAAAE0GAOoMAAAATQYGjgQAAAAwBgWOBAAAAE0GAOoMAAAATQYG2QUAAAAwBgXZBQAAAE0GAOoMAAAATQYGmgYAAAAwBgWaBgAAAE0GAI8NAAAAUgcAAFIIBQCfBgMBggUCAA4DDQMOAw8DEAMRAxIDEwMIAQEDFAEACAkA/////wH/////Av////8D/////wT/////Bf////8G/////wcIAAAACQoAAAADAwMGAB4VARgAAQABAAEAAQABAAAAAAABAAAAAAABAAAAAAAFAAAAAAIfAAAAAAkCAAAAACBNAgA3AAAAAE0DAjMBAAAAbwQCAE0FAY4CAAAAnwMDAU0DAjMBAAAAbwQDAE0FAdkDAAAAnwMDAU0DAjMBAAAAbwQEAE0FAZoEAAAAnwMDAU0FASEFAAAATQYBcQYAAABNBwGZBwAAAE0IAS0IAAAAvAMA1AkAAACfAwYBggABAAoDAgMWAxEDEgMTAw0DDgMPAxADCgAwFwEYAAACAAAAAAABAAAAAAABAAAAAAACAAAAAAAAAAAAAAExAAAAAAIAAAECABOjAAAA/wAEAAAAAAAwAABuAAAAAMABAQASAAAAMAEAcwIAAADAAQMAMAEA1AQAAADAAQUAMAEAlgYAAADAAQcAMAEAJggAAACCAAIACQMYBgADBwYBAwoGAgMVBgMDFwQAAQIDAQABGAACAAEAAgAAAAwAAAwAABIAAAoBAAAAAASETcb/b1REhcQC/kGOWJCR9FXRi7aJrP4=

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

	if Ceive.Enabled then
		Ceive.Circle:Draw(p2, p3, p4, p5)
		Ceive.Circle:Draw(p2 * CFrame.Angles(0, 1.5707963267948966, 0), p3, p4, p5)
		Ceive.Circle:Draw(p2 * CFrame.Angles(1.5707963267948966, 0, 0), p3, p4, p5)
	end
end
function t.Create(p1, p2, p3, p4, p5) --[[ Create | Line: 30 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Radius = p3,
		Subdivisions = p4,
		Angle = p5,
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
	p1:Draw(p2.Transform, p2.Radius, p2.Subdivisions, p2.Angle)
end

return t