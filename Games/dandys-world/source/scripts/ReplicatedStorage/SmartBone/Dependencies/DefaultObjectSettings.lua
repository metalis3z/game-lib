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
-- CQMWBXRhYmxlBmZyZWV6ZQdEYW1waW5nCVN0aWZmbmVzcwdJbmVydGlhCkVsYXN0aWNpdHkLQW5jaG9yRGVwdGgNQW5jaG9yc1JvdGF0ZQpDb25zdHJhaW50BlNwcmluZwVGb3JjZQdHcmF2aXR5CFdpbmRUeXBlBkh5YnJpZBJNYXRjaFdvcmtzcGFjZVdpbmQNV2luZEluZmx1ZW5jZQxXaW5kU3RyZW5ndGgJV2luZFNwZWVkDVdpbmREaXJlY3Rpb24KVXBkYXRlUmF0ZRJBY3RpdmF0aW9uRGlzdGFuY2UQVGhyb3R0bGVEaXN0YW5jZQABAgAAAQIABqMAAACkAAIAAAQAgOIBJQCfAAIAggAAACYDAQMCBAAEAIADAwKamZmZmZm5PwMEApqZmZmZmck/AwUCAAAAAAAAAAADBgIAAAAAAAAIQAMHAwgBAAMJAwoDCwcAAAAAzcxMPgAAAAAAAAAAAwwHAAAAgAAAyMEAAACAAAAAgAMNAw4DDwEBAxACAAAAAAAA8D8DEQIAAAAAAAAAQAMSAxMHAACAPwAAAAAAAAAAAAAAAAMUAgAAAAAAAE5AAxUCAAAAAACARkADFgIAAAAAAAAuQAgSAwQAAAAFBgAAAAcIAAAACQoAAAALCAAAAAwNAAAADg8AAAAQEQAAABITAAAAFBUAAAAWFwAAABgZAAAAGhsAAAAcGQAAAB0eAAAAHyAAAAAhIgAAACMkAAAAAAEAARgAAgAAAAABAAAAAADnm1e4Oz4+GripaQctrcJTl4NAzNVfPbk=

-- https://lua.expert/
return table.freeze({
	Damping = 0.1,
	Stiffness = 0.2,
	Inertia = 0,
	Elasticity = 3,
	AnchorDepth = 0,
	AnchorsRotate = false,
	Constraint = "Spring",
	Force = Vector3.new(0, 0.2, 0),
	Gravity = Vector3.new(-0, -25, -0),
	WindType = "Hybrid",
	MatchWorkspaceWind = true,
	WindInfluence = 1,
	WindStrength = 2,
	WindSpeed = 1,
	WindDirection = Vector3.new(1, 0, 0),
	UpdateRate = 60,
	ActivationDistance = 45,
	ThrottleDistance = 15
})