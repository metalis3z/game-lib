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
-- CQMdDHNldG1ldGF0YWJsZQVDZWl2ZQlQcm9wZXJ0eXMHUmVxdWVzdAdSZWxlYXNlBlJldGFpbghSZWdpc3RlcgRJbml0B0VuYWJsZWQVU3BoZXJlSGFuZGxlQWRvcm5tZW50BkNvbG9yMwxUcmFuc3BhcmVuY3kGQ0ZyYW1lBlJhZGl1cwtBbHdheXNPblRvcAZaSW5kZXgHQWRvcm5lZQZQYXJlbnQPQWN0aXZlSW5zdGFuY2VzEFNjaGVkdWxlQ2xlYW5pbmcERHJhdwlUcmFuc2Zvcm0HRGVzdHJveQZDcmVhdGUMUHVzaFByb3BlcnR5BlVwZGF0ZQl3b3Jrc3BhY2UHVGVycmFpbgdfX2luZGV4AQ0ABQkGAQAAABX/BwQAAAAAAPsIAACePQcDCAAAAKQGAQAAAABAnwYDAjAABjcCAAAAMAEG6gMAAAAwAgZMBAAAADADBlwFAAAAMAQGjwYAAAAwBQaDBwAAAIIGAgAIAwEEAAAAQAMCAwMDBAMFAwYDBwAGCAEYAAAAAAAAAAACAAEAAQABAAEAAQACBwAAAAAHAwEAAAgFAAAFAwRAAjhNAwA3AAAAAE0EA/ABAAAAKwQBAIIAAQBNBABMAgAAAG8FAwCfBAICTQUA6gQAAABNBQWaBQAAADAFBJoFAAAATQUA6gQAAABNBQXZBgAAADAFBNkGAAAAMAEEhQcAAAAwAgRxCAAAAE0FAOoEAAAATQUFjgkAAAAwBQSOCQAAAIwFAQAwBQQNCgAAAPsFAAAwBQQUCwAAAPsFAAAwBQQkDAAAAE0FA0QNAAAAlQUFDjAFA0QNAAAATQUAgw8AAABSBgQAnwUCAU0FADcAAAAATQUFOhAAAACfBQEBggABABEDAgMJAwQDCgMDAwsDDAMNAw4DDwMQAxEDEgMTAgAAAAAAAPA/AwcDFAATFQEYAAACAAABAwAAAAEAAAAAAAEAAAAAAAIAAQABAAAAAAABAAABAAABAAACAAAAAAIAAAABAAAAAAEUAAAAAAcDAAAACAUAAAUDBEACHeIDCQAwAQMhAAAAADACA3EBAAAATQQA6goAAABNBASOAgAAADAEA44CAAAATQQA6goAAABNBATZAwAAADAEA9kDAAAATQQA6goAAABNBASaBAAAADAEA5oEAAAATQQAjwsAAABSBQAAUgYDAJ8EAwGCAwIADAMWAw4DDwMMAwsDCQEBAxcBAAgHAP////8B/////wL/////A/////8E/////wUGAAAABwgAAAADAwMGACsYARgAAQABAAEAAAAAAAEAAAAAAAEAAAAAAAUAAAAAAiwAAAAABwIAAAAAHE0CADcAAAAATQMCMwEAAABvBAIATQUBjgIAAACfAwMBTQMCMwEAAABvBAMATQUB2QMAAACfAwMBTQMCMwEAAABvBAQATQUBmgQAAACfAwMBTQUBIQUAAABNBgFxBgAAALwDANQHAAAAnwMEAYIAAQAIAwIDGQMPAwwDCwMWAw4DFQA7GgEYAAACAAAAAAABAAAAAAABAAAAAAACAAAAAAAAATwAAAAAAwAAAQIAGKMAAACkAAEAAAAAQE0AAFQCAAAA/wEEAAAAAAAwAQFuAwAAAMACBAASAAEAMAIBcwUAAADAAgYAEgAAADACAdQHAAAAwAIIADACAZYJAAAAwAIKADACASYLAAAAggECAAwDGwQAAABAAxwDHQYAAwgGAQMVBgIDGAYDAxoEAAECAwEAARgAAAAAAAIAAQACAAAADQAAABgAABAAAAoBAAAAAAQXICLQFn/BqD1edHX2xslOZzg1pCXkSNE=

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
		local v1 = p1.Request("SphereHandleAdornment")

		v1.Color3 = p1.Propertys.Color3
		v1.Transparency = p1.Propertys.Transparency
		v1.CFrame = p2
		v1.Radius = p3
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
		Radius = p3,
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
	p1:Draw(p2.Transform, p2.Radius)
end

return t