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
-- CQMbDHNldG1ldGF0YWJsZQdoZWxwZXJzBnR3ZWVucw5Mb2FkU3R5bGVzaGVldARJbml0DHNhdmVJbml0aWFscwlwbGF5VHdlZW4FQ2xvY2sGSGFuZGxlCVR3ZWVuSW5mbwNuZXcERW51bQtFYXNpbmdTdHlsZQZMaW5lYXIPRWFzaW5nRGlyZWN0aW9uBUluT3V0CFJvdGF0aW9uB2lzU3RhdGUIZ2V0U3RhdGUNYWRkQ29ubmVjdGlvbhBjbGVhckNvbm5lY3Rpb25zBGJhc2UNdGVtcGxhdGVTdGF0ZQZzdGF0ZXMMdGVtcGxhdGVGbGFnBWZsYWdzB19faW5kZXgABgUCAQAAABL/AwIAAAAAAPsEAACePQMDBAAAAKQCAQAAAABAnwIDAjABAnYCAAAATQMBPAMAAAAwAwI8AwAAALwDAnsEAAAAnwMCAYICAgAFAwEEAAAAQAMCAwMDBAAFBQEYAAAAAAAAAAACAAEAAAACAAACBwAAAAAKAgEAAAAZ+wIAAE0CAmIAAAAAUgMAAJ8CAgH7AgAATQICQAEAAABNAwBsAgAAAE0DA+wDAAAApAQGAAAUQICMBQMApAYKAAkgcMCkBw0ADCxwwIwI//+pCQAAnwQGAuIFEACfAgQBggABABEDBgMHAwgDCQMKAwsEABRAgAMMAw0DDgQJIHDAAw8DEAQMLHDAAxECAAAAAACAdkAIAQ4PAAAAABwAARgAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAAADHQAAAAACAgAAAAABggABAAAAMAABGAA0AAAAAAMDAAAAAAGCAAEAAABFAAEYAEkAAAAACQEBAAAAKE0BADwAAAAATQIAdgEAAABNAgLQAgAAAE0DAHYBAAAATQMDFgMAAABNBAB2AQAAAE0EBEYEAAAATQUAdgEAAABNBQV0BQAAAPsGAADZBwAAEgABADAHBk4GAAAA+wYAAP8HAQAAAAAAwAgHADAIB0IIAAAAMAcGPwkAAAD7BgAA/wcBAAAAAADACAoAMAgHlgsAAAAwBwZYDAAAAIIAAQANAwMDAgMSAxMDFAMVAxYGAgMXAxgGAwMZAxoDAQIDEgQBGAAAAQAAAAEAAAABAAAAAQAAAAMAAAAAEgAAAgAA/gAUAAADAAD9AAwVAAAAAAIAAAECAA6jAAAA/wAEAAAAAAAwAABuAAAAAMABAQASAAAAMAEAcwIAAADAAQMAEgAAADABAHsEAAAAggACAAUDGwYAAwUGBAMEAgAEAQABGAABAAEAAgAAAA0AAABCAQAAAAAF9L1lInwqbzKN10tspSihEYSlclbGeQ8j

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

	function t.base(p1, p2) --[[ Line: 28 | Upvalues: tweens (copy) ]]
		tweens.saveInitials(p1)
		tweens.playTween(p1.Clock.Handle, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false), {
			Rotation = 360
		})
	end
	t.states = {
		templateState = function(p1, p2) --[[ Line: 48 ]] end
	}
	t.flags = {
		templateFlag = function(p1, p2, p3) --[[ Line: 69 ]] end
	}
end

return t