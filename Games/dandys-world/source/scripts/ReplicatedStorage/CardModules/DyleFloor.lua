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
-- CQMeCUR5bGVGbG9vcg5GaW5kRmlyc3RDaGlsZAhJbnN0YW5jZQNuZXcJQm9vbFZhbHVlBE5hbWUFVmFsdWUGUGFyZW50DUR5bGVGbG9vclVzZWQFcHJpbnQzRHlsZUZsb29yOiBEeWxlIGZsb29yIG1vZGlmaWVyIGFwcGxpZWQgLSBUSU1FJ1MgVVAhEEFwcGx5Q2FyZEVmZmVjdHMMTWluaW11bUZsb29yCXdvcmtzcGFjZQRJbmZvEFZvdGVzU2luY2VGbG9vcjIQTWluaW11bVZvdGVSb3VuZA9DYW5BcHBlYXJJblZvdGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlDVNlcnZlclN0b3JhZ2UNQ2FyZE1vZGlmaWVycwtQbGF5ZXJTdGF0cwlUSU1FJ1MgVVAbcmJ4YXNzZXRpZDovLzczOTcyNzg2NzM2NzQ1BEljb26GAVRyYXZlbCB0byBvbmUgb2YgdGhlIG1vc3QgZGFuZ2Vyb3VzIHBsYWNlcyBpbiBHYXJkZW52aWV3LiBDb21wbGV0ZSB0aGlzIGNoYWxsZW5naW5nIGZsb29yIHRvIGVhcm4gKzUwIHN0YW1pbmEgZm9yIHRoZSByZXN0IG9mIHRoZSBydW4uC0Rlc2NyaXB0aW9uCVNpbmdsZVVzZQADBAABAAAAJfsAAABvAgAAvAAAAwEAAACfAAMCKwAeAKQABAAADCCAbwEFAJ8AAgJvAQAAMAEAugYAAACpAQEAMAEA7AcAAAD7AQAAMAEAJAgAAACkAQQAAAwggG8CBQCfAQICbwIJADACAboGAAAAqQIBADACAewHAAAA+wIAADACASQIAAAApAILAAAAoEBvAwwAnwICAYIAAQANAwEDAgMDAwQEAAwggAMFAwYDBwMIAwkDCgQAAKBAAwsAEQwBGAAAAAAAAAEAAAABAAABAAABAAADAAAAAQAAAQAAAQAAAgAAAAITAAAAAAUCAgAAACP7AgAAbwQAALwCAgMBAAAAnwIDAg4CAgCpAgAAggICAPsCAQBNAgLuAgAAAGAAAwACAAAAqQIAAIICAgCkAgQAAAAwQE0CAnoFAAAAbwQGALwCAgMBAAAAnwIDAg4CCQBNAwLsBwAAAPsEAQBNBAT0CAAAAGADAwAEAAAAqQMAAIIDAgCpAwEAggMCAAkDCQMCAw0DDgQAADBAAw8DEAMHAxEAJBIBGAAAAAAAAAEABAAAAAABAAQAAAAAAAAAAQAAAAAAAAABAAMAJgAAAAAGAAABAgA3owAAAP8ABAAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAQAvAICFgMAAACfAgMCpAMGAAAAUEBNAwN6BwAAAE0DA6QIAAAApAQGAAAAUEBNBAR6BwAAAE0EBAEJAAAAbwUKADAFALoLAAAAbwUMADAFAK4NAAAAbwUOADAFAOIPAAAAqQUBADAFACkQAAAAjAUDADAFAO4RAAAAjAUEADAFAPQSAAAAwAUTABIAAwAwBQCDFAAAAMAFFQASAAMAEgAAADAFADAWAAAAggACABcDEwQAAABAAxQDFQMWAw4EAABQQAMPAxcDGAMZAwYDGgMbAxwDHQMeAw0DEQYAAwwGAQMSAgABAQABGAAAAAIAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAIAAAEAAAEAAAMAAAEAAAEAAAIAAAATAAAAABQBAAAAAALulBXgjIWzQIzP3E0Jq0tlnowClNxQf+E=

-- https://lua.expert/
local t = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

t.Name = "TIME\'S UP"
t.Icon = "rbxassetid://73972786736745"
t.Description = "Travel to one of the most dangerous places in Gardenview. Complete this challenging floor to earn +50 stamina for the rest of the run."
t.SingleUse = true
t.MinimumFloor = 3
t.MinimumVoteRound = 4
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 17 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild("DyleFloor") then
		return
	end

	local DyleFloor = Instance.new("BoolValue")

	DyleFloor.Name = "DyleFloor"
	DyleFloor.Value = true
	DyleFloor.Parent = CardModifiers

	local DyleFloorUsed = Instance.new("BoolValue")

	DyleFloorUsed.Name = "DyleFloorUsed"
	DyleFloorUsed.Value = true
	DyleFloorUsed.Parent = CardModifiers
	print("DyleFloor: Dyle floor modifier applied - TIME\'S UP!")
end
function t.CanAppearInVote(p1, p2) --[[ CanAppearInVote | Line: 36 | Upvalues: CardModifiers (copy), t (copy) ]]
	if CardModifiers:FindFirstChild("DyleFloorUsed") then
		return false
	end

	if p1 < t.MinimumFloor then
		return false
	end

	local VotesSinceFloor2 = workspace.Info:FindFirstChild("VotesSinceFloor2")

	return not (VotesSinceFloor2 and VotesSinceFloor2.Value < t.MinimumVoteRound)
end

return t