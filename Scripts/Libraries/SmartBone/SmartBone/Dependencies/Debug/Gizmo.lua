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
-- CQMbBERyYXcGQ3JlYXRlCFNldFN0eWxlEkFkZERlYnJpc0luU2Vjb25kcwxQdXNoUHJvcGVydHkLUG9wUHJvcGVydHkRQWRkRGVicmlzSW5GcmFtZXMKU2V0RW5hYmxlZApEb0NsZWFuaW5nEFNjaGVkdWxlQ2xlYW5pbmcPVHdlZW5Qcm9wZXJ0aWVzB19faW5kZXgGc2NyaXB0BlBhcmVudAdyZXF1aXJlBkNvbmZpZwxXYWl0Rm9yQ2hpbGQFR2l6bW8EZ2FtZQpSdW5TZXJ2aWNlCkdldFNlcnZpY2UISXNTdHVkaW8VQUxMT1dfTElWRV9HQU1FX0RFQlVHBEluaXQMc2V0bWV0YXRhYmxlBXRhYmxlBmZyZWV6ZQAFAAAAAAAAAYIAAQAAACYAARgAJgAAAAAAAAAAAAABggABAAAAKgEBGAAqAAAAAAAAAAAAAAGCAAEAAAArAgEYACsAAAAABQICAAAAEvsCAAAOAgMA+wMBAIcCAwGCAgIA4gIKAIcDAgEOAwIAwAMLAIIDAgDiAw4AwAQPADAEA9QMAAAAwAQQADAEA5YNAAAAggMCABEDAwEBAwQDBQMGAwcDCAMJAwoDCwgJAAEAAAACAQAAAAMBAAAABAEAAAAFAQAAAAYBAAAABwEAAAAIAQAAAAkBAAAABgADAQMCBQIMDQYBBgIDAAECFQwBGAAAAQAAAgwAAQADAQAAAQAAABYAAAAACQAAAQIAOqMAAACkAAEAAAAAQE0AACQCAAAATQAAJAIAAACkAQQAAAAwQG8EBQC8AgDTBgAAAJ8CAwCfAQACpAIEAAAAMECkAwEAAAAAQG8FBwC8AwPTBgAAAJ8DAwCfAgACpAMJAAAAgEBvBQoAvAMDFgsAAACfAwMCvAMDCgwAAACfAwICUgQDACsEAgBNBAG0DQAAAA4EAwBNBQJzDgAAAJ8FAQH/BgAAAAAAAOIHEADACBEAEgAEABIAAgAwCAduDwAAAJ49BgMHAAAApAUTAAAAIEGfBQMCpAYWAABUQIFSBwUAnwYCAIIGAAAXAw0EAAAAQAMOAw8EAAAwQAMQAxEDEgMTBAAAgEADFAMVAxYDFwMYAwwFAQ8GAwMZBAAAIEEDGgMbBABUQIEBAwEAARgABgAAAAAAAgAAAAAAAAEAAAAAAAAAAAIAAAAAAAAAAAEAAAABAQAABQAAAQAAAAAAAP8AAB0AAAAAAQAAAAAE2O4q6RoWP/AsoU2ZmFDABqj2PZ3qKkDo

-- https://lua.expert/
local Config = require(script.Parent.Parent:WaitForChild("Config"))
local Gizmo = require(script:WaitForChild("Gizmo"))
local v2 = game:GetService("RunService"):IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG

if v2 then
	Gizmo.Init()
end

return table.freeze((setmetatable({}, {
	__index = function(p1, p2) --[[ __index | Line: 21 | Upvalues: v2 (copy), Gizmo (copy) ]]
		if v2 then
			return Gizmo[p2]
		end

		if ({
			SetStyle = true,
			AddDebrisInSeconds = true,
			PushProperty = true,
			PopProperty = true,
			AddDebrisInFrames = true,
			SetEnabled = true,
			DoCleaning = true,
			ScheduleCleaning = true,
			TweenProperties = true
		})[p2] then
			return function() --[[ Line: 38 ]] end
		end

		return {
			Draw = function() --[[ Draw | Line: 42 ]] end,
			Create = function() --[[ Create | Line: 43 ]] end
		}
	end
})))