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
-- CQMlDHNldG1ldGF0YWJsZQdoZWxwZXJzBnR3ZWVucw5Mb2FkU3R5bGVzaGVldARJbml0BkFjdGl2ZQdWaXNpYmxlDFNldEF0dHJpYnV0ZQxzYXZlSW5pdGlhbHMHdmlzaWJsZRhHZXRQcm9wZXJ0eUNoYW5nZWRTaWduYWwHQ29ubmVjdA1BZGRDb25uZWN0aW9uCUNvcHlMYWJlbA5GaW5kRmlyc3RDaGlsZAZDb2xvcjMHZnJvbVJHQgpUZXh0Q29sb3IzCXBsYXlUd2VlbglUd2VlbkluZm8DbmV3BEVudW0LRWFzaW5nU3R5bGUEU2luZQ9FYXNpbmdEaXJlY3Rpb24FSW5PdXQQVGV4dFRyYW5zcGFyZW5jeQZDYW5jZWwEUGxheQdpc1N0YXRlCGdldFN0YXRlDWFkZENvbm5lY3Rpb24QY2xlYXJDb25uZWN0aW9ucwRiYXNlBnN0YXRlcwVmbGFncwdfX2luZGV4AAYFAgEAAAAS/wMCAAAAAAD7BAAAnj0DAwQAAACkAgEAAAAAQJ8CAwIwAQJ2AgAAAE0DATwDAAAAMAMCPAMAAAC8AwJ7BAAAAJ8DAgGCAgIABQMBBAAAAEADAgMDAwQABQUBGAAAAAAAAAAAAgABAAAAAgAAAgcAAAAABAABAAAACfsAAABvAgAA+wMAAE0DA4ABAAAAvAAALgIAAACfAAQBggABAAMDBgMHAwgAKQABGAAAAAAAAAAAASoAAAAACgIDAAAAPPsCAABNAgJiAAAAAFIDAACfAgIBqQIAADACAIABAAAAUgQAAG8FAgBvCAEAvAYAlAMAAACfBgMC2QgAABIAAAC8BgbHBAAAAJ8GAwC8AgGmBQAAAJ8CAAFvBAYAvAIAAwcAAACfAgMC3gIBAPsCAQAOAh4A+wIBAKQDCgAAJICAjAQAAIwF/wCMBi8AnwMEAjADAnMLAAAA+wIAAE0CAkAMAAAA+wMBAKQEDwAAONCAjAUBAKQGEwASRADBpAcWABVQAMGMCP//qQkBAJ8EBgLiBRkAnwIEAt4CAgD7AgIAvAICoRoAAACfAgIBggABABsDCQMHAwoDCwMMAw0DDgMPAxADEQQAJICAAxIDEwMUAxUEADjQgAMWAxcDGAQSRADBAxkDGgQVUADBAxsCAAAAAAAA6D8IARcYAAAAAxwBASAAARgAAAAAAAYAAAIAAAAAAAAAAAAAAAAABAAAAAACAAEAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAYhAAAAAAUDAgAAABX7AwAAKwMBAIIAAQD7AwEAKwMBAIIAAQAOAQkA+wMBAIwEAAAwBAMkAAAAAPsDAAC8AwPuAQAAAJ8DAgGCAAEA+wMAALwDA6ECAAAAnwMCAYIAAQADAxsDHQMcAFUAARgAAAABAAACAQAAAAEAAAAAAwAAAARXAAAAAAsBAQAAACxNAQA8AAAAAE0CAHYBAAAATQIC0AIAAABNAwB2AQAAAE0DAxYDAAAATQQAdgEAAABNBARGBAAAAE0FAHYBAAAATQUFdAUAAADGBgAAxgcAAPsIAADZCQAAEgABABIBBv8SAQf/MAkITgYAAAD7CAAA/wkAAAAAAAAwCQg/BwAAAPsIAAD/CQEAAAAAANkKAQASAQf/EgEG/zAKCYMIAAAAMAkIWAkAAADBBgAAggABAAoDAwMCAx4DHwMgAyEDIgMjAwYDJAICAxIEARgAAAEAAAABAAAAAQAAAAEAAAADAQMAAAAAAAAjAAAAAA8AAAMAAAAA/QAXABUAAAAAAgAAAQIADqMAAAD/AAQAAAAAADAAAG4AAAAAwAEBABIAAAAwAQBzAgAAAMABAwASAAAAMAEAewQAAACCAAIABQMlBgADBQYEAwQCAAQBAAEYAAEAAQACAAAADQAAAF0BAAAAAAXnAvOqcMRq5t5KIMZCXToPlxrk3tXGmas=

-- https://lua.expert/
local t = {}

t.__index = t
function t.Init(p1, p2) --[[ Init | Line: 5 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.helpers = p2
	v2.tweens = p2.tweens
	v2:LoadStylesheet()

	return v2
end
function t.LoadStylesheet(p1) --[[ LoadStylesheet | Line: 18 | Upvalues: t (copy) ]]
	local tweens = p1.tweens
	local isState = p1.helpers.isState
	local getState = p1.helpers.getState
	local addConnection = p1.helpers.addConnection
	local clearConnections = p1.helpers.clearConnections
	local v1 = nil
	local v2 = nil

	function t.base(p1, p2) --[[ Line: 32 | Upvalues: tweens (copy), v1 (ref), v2 (ref) ]]
		tweens.saveInitials(p1)
		p1.Visible = false
		p2:AddConnection(p1, "visible", p1:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 41 | Upvalues: p1 (copy) ]]
			p1:SetAttribute("Active", p1.Visible)
		end))
		v1 = p1:FindFirstChild("CopyLabel")

		if not v1 then
			return
		end

		v1.TextColor3 = Color3.fromRGB(0, 255, 47)
		v2 = tweens.playTween(v1, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
			TextTransparency = 0.75
		})
		v2:Cancel()
	end
	t.states = {}
	t.flags = {
		Active = function(p1, p2, p3) --[[ Line: 85 | Upvalues: v2 (ref), v1 (ref) ]]
			if not v2 then
				return
			end

			if not v1 then
				return
			end

			if p2 then
				v1.TextTransparency = 0
				v2:Play()
			else
				v2:Cancel()
			end
		end
	}
end

return t