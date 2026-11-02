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
-- CQMdDHNldG1ldGF0YWJsZQVDZWl2ZQlQcm9wZXJ0eXMHUmVxdWVzdAdSZWxlYXNlBlJldGFpbghSZWdpc3RlcgRJbml0B0VuYWJsZWQSQm94SGFuZGxlQWRvcm5tZW50BkNvbG9yMwxUcmFuc3BhcmVuY3kGQ0ZyYW1lBFNpemULQWx3YXlzT25Ub3AGWkluZGV4B0Fkb3JuZWUGUGFyZW50D0FjdGl2ZUluc3RhbmNlcxBTY2hlZHVsZUNsZWFuaW5nBERyYXcJVHJhbnNmb3JtB0Rlc3Ryb3kGQ3JlYXRlDFB1c2hQcm9wZXJ0eQZVcGRhdGUJd29ya3NwYWNlB1RlcnJhaW4HX19pbmRleAENAAUJBgEAAAAV/wcEAAAAAAD7CAAAnj0HAwgAAACkBgEAAAAAQJ8GAwIwAAY3AgAAADABBuoDAAAAMAIGTAQAAAAwAwZcBQAAADAEBo8GAAAAMAUGgwcAAACCBgIACAMBBAAAAEADAgMDAwQDBQMGAwcABggBGAAAAAAAAAAAAgABAAEAAQABAAEAAgcAAAAABwMBAAAIBQAABQMEQAg4TQMANwAAAABNBAPwAQAAACsEAQCCAAEATQQATAIAAABvBQMAnwQCAk0FAOoEAAAATQUFmgUAAAAwBQSaBQAAAE0FAOoEAAAATQUF2QYAAAAwBQTZBgAAADABBIUHAAAAMAIELwgAAABNBQDqBAAAAE0FBY4JAAAAMAUEjgkAAACMBQEAMAUEDQoAAAD7BQAAMAUEFAsAAAD7BQAAMAUEJAwAAABNBQNEDQAAAJUFBQ4wBQNEDQAAAE0FAIMPAAAAUgYEAJ8FAgFNBQA3AAAAAE0FBToQAAAAnwUBAYIAAQARAwIDCQMEAwoDAwMLAwwDDQMOAw8DEAMRAxIDEwIAAAAAAADwPwMHAxQAExUBGAAAAgAAAQMAAAABAAAAAAABAAAAAAACAAEAAQAAAAAAAQAAAQAAAQAAAgAAAAACAAAAAQAAAAABFAAAAAAHAwAAAAgFAAAFAwRACB3iAwkAMAEDIQAAAAAwAgMvAQAAAE0EAOoKAAAATQQEjgIAAAAwBAOOAgAAAE0EAOoKAAAATQQE2QMAAAAwBAPZAwAAAE0EAOoKAAAATQQEmgQAAAAwBAOaBAAAAE0EAI8LAAAAUgUAAFIGAwCfBAMBggMCAAwDFgMOAw8DDAMLAwkBAQMXAQAIBwD/////Af////8C/////wP/////BP////8FBgAAAAcIAAAAAwMDBgArGAEYAAEAAQABAAAAAAABAAAAAAABAAAAAAAFAAAAAAIsAAAAAAcCAAAAABxNAgA3AAAAAE0DAjMBAAAAbwQCAE0FAY4CAAAAnwMDAU0DAjMBAAAAbwQDAE0FAdkDAAAAnwMDAU0DAjMBAAAAbwQEAE0FAZoEAAAAnwMDAU0FASEFAAAATQYBLwYAAAC8AwDUBwAAAJ8DBAGCAAEACAMCAxkDDwMMAwsDFgMOAxUAOxoBGAAAAgAAAAAAAQAAAAAAAQAAAAAAAgAAAAAAAAE8AAAAAAMAAAECABijAAAApAABAAAAAEBNAABUAgAAAP8BBAAAAAAAMAEBbgMAAADAAgQAEgABADACAXMFAAAAwAIGABIAAAAwAgHUBwAAAMACCAAwAgGWCQAAAMACCgAwAgEmCwAAAIIBAgAMAxsEAAAAQAMcAx0GAAMIBgEDFQYCAxgGAwMaBAABAgMBAAEYAAAAAAACAAEAAgAAAA0AAAAYAAAQAAAKAQAAAAAE/vFIVIK0JZC99kPp8ldFQo7pXyDMNSJV

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
function t.Draw(p1, p2, p3) --[[ Draw | Line: 19 | Upvalues: Terrain (copy) ]]
	local Ceive = p1.Ceive

	if Ceive.Enabled then
		local v1 = p1.Request("BoxHandleAdornment")

		v1.Color3 = p1.Propertys.Color3
		v1.Transparency = p1.Propertys.Transparency
		v1.CFrame = p2
		v1.Size = p3
		v1.AlwaysOnTop = p1.Propertys.AlwaysOnTop
		v1.ZIndex = 1
		v1.Adornee = Terrain
		v1.Parent = Terrain
		Ceive.ActiveInstances = Ceive.ActiveInstances + 1
		p1.Register(v1)
		p1.Ceive.ScheduleCleaning()
	end
end
function t.Create(p1, p2, p3) --[[ Create | Line: 43 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Transform = p2,
		Size = p3,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 59 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Transform, p2.Size)
end

return t