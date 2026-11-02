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
-- CQMQDHNldG1ldGF0YWJsZQdoZWxwZXJzBnR3ZWVucw5Mb2FkU3R5bGVzaGVldARJbml0DHNhdmVJbml0aWFscwdpc1N0YXRlCGdldFN0YXRlDWFkZENvbm5lY3Rpb24QY2xlYXJDb25uZWN0aW9ucwRiYXNlDXRlbXBsYXRlU3RhdGUGc3RhdGVzDHRlbXBsYXRlRmxhZwVmbGFncwdfX2luZGV4AAYFAgEAAAAS/wMCAAAAAAD7BAAAnj0DAwQAAACkAgEAAAAAQJ8CAwIwAQJ2AgAAAE0DATwDAAAAMAMCPAMAAAC8AwJ7BAAAAJ8DAgGCAgIABQMBBAAAAEADAgMDAwQABQUBGAAAAAAAAAAAAgABAAAAAgAAAgcAAAAABAIBAAAABvsCAABNAgJiAAAAAFIDAACfAgIBggABAAEDBgAcAAEYAAAAAAABHQAAAAACAgAAAAABggABAAAAKwABGAAvAAAAAAMDAAAAAAGCAAEAAABAAAEYAEQAAAAACQEBAAAAKE0BADwAAAAATQIAdgEAAABNAgLQAgAAAE0DAHYBAAAATQMDFgMAAABNBAB2AQAAAE0EBEYEAAAATQUAdgEAAABNBQV0BQAAAPsGAADZBwAAEgABADAHBk4GAAAA+wYAAP8HAQAAAAAAwAgHADAIB0IIAAAAMAcGPwkAAAD7BgAA/wcBAAAAAADACAoAMAgHlgsAAAAwBwZYDAAAAIIAAQANAwMDAgMHAwgDCQMKAwsGAgMMAw0GAwMOAw8DAQIDEgQBGAAAAQAAAAEAAAABAAAAAQAAAAMAAAAADQAAAgAA/gAUAAADAAD9AAwVAAAAAAIAAAECAA6jAAAA/wAEAAAAAAAwAABuAAAAAMABAQASAAAAMAEAcwIAAADAAQMAEgAAADABAHsEAAAAggACAAUDEAYAAwUGBAMEAgAEAQABGAABAAEAAgAAAA0AAAA9AQAAAAAF1BL2L4xvau6IQAtPy2Y64qQK4Vvm1pwu

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
	end
	t.states = {
		templateState = function(p1, p2) --[[ Line: 43 ]] end
	}
	t.flags = {
		templateFlag = function(p1, p2, p3) --[[ Line: 64 ]] end
	}
end

return t