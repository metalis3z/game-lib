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
-- CQMKBnNjcmlwdAZQYXJlbnQMVHJhbnNwYXJlbmN5Bk5vcm1hbAxXYWl0Rm9yQ2hpbGQFQmxpbmsHQ2hhbmdlZAdDb25uZWN0BHRhc2sEd2FpdAACAgACAAAAE6QAAQAAAABATQAAJAIAAABNAAAkAgAAAE0AANkDAAAADQAJAAQAAID7AAAAjAEBADABANkDAAAA+wABAIwBAQAwAQDZAwAAAIIAAQAFAwEEAAAAQAMCAwMCAAAAAAAA8D8AJQABGAAAAAAAAAAAAAABAAAAAQAAAAQnAAAAAAYAAAEAADejAAAApAABAAAAAEBNAAAkAgAAAG8DAwC8AQDTBAAAAJ8BAwJvBAUAvAIA0wQAAACfAgMCjAMAADADAdkGAAAAjAMBADADAtkGAAAApAMBAAAAAEBNAwMkAgAAAE0DAyQCAAAATQMDhQcAAADABQgAEgABABIAAgC8AwPHCQAAAJ8DAwGMAwEAMAMB2QYAAACMAwAAMAMC2QYAAACkAwwAACyggG8EDQCfAwIBjAMAADADAdkGAAAAjAMBADADAtkGAAAApAMMAAAsoICMBAUAnwMCAUgA6/+CAAEADgMBBAAAAEADAgMEAwUDBgMDAwcGAAMIAwkDCgQALKCAApqZmZmZmbk/AQABAAEYABYAAAABAAAAAQAAAAMAAAEAAAgAAAAAAAAAAAAAAAAADgAAAQAAAwAAAAMAAAEAAAIAAADyEQEAAAAAATNo5MZREAiFSz/f+lJGeotDcPOyAayOxw==

-- https://lua.expert/
local v1 = script.Parent
local Normal = v1:WaitForChild("Normal")
local Blink = v1:WaitForChild("Blink")

Normal.Transparency = 0
Blink.Transparency = 1
script.Parent.Parent.Changed:Connect(function() --[[ Line: 37 | Upvalues: Normal (copy), Blink (copy) ]]
	if script.Parent.Parent.Transparency ~= 1 then
		return
	end

	Normal.Transparency = 1
	Blink.Transparency = 1
end)

while true do
	Normal.Transparency = 1
	Blink.Transparency = 0
	task.wait(0.1)
	Normal.Transparency = 0
	Blink.Transparency = 1
	task.wait(5)
end