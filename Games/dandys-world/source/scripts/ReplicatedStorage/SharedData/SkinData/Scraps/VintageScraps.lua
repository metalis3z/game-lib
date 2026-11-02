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
-- CQMdBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRA5Sb3BlQ29uc3RyYWludApCcmlja0NvbG9yA25ldwZGb3NzaWwFQ29sb3IJQXBwbHlTa2luBEJhc2UMV2FpdEZvckNoaWxkBFRhaWwETWVzaAlUZXh0dXJlSWQKVXNlQWJpbGl0eQ5WaW50YWdlIFNjcmFwcwROYW1lB01hc3RlcnkTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vNzY3NDE3Mjk4NjMwNzgccmJ4YXNzZXRpZDovLzEwNjY4MTExOTUyNDk1OQVCbGluaxtyYnhhc3NldGlkOi8vNzUzMjE4ODQ5MzQ5NzIESHVydA5VU0VfU0tJTl9NT0RFTAADCQEBAAAGAwAABQEHIqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBGABvCAMAvAYF/gQAAACfBgMCDgYIAPsGAABNBgYhBQAAAE0GBhAGAAAAMAYFhAcAAABlAAsAbwgIALwGBf4EAAAAnwYDAg4GBgCkBgsAACiQgG8HDACfBgICMAYFpA0AAABuAef/AgAAAIIAAQAOAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgQAKJCAAwsDDAASDQEYAAAAAAAAAAEAAAAAAQAAAAAAAAABAAAAAAEAAAAAAPwACBQAAAAACgIAAAAHBAAABQIHBymkAgEAAAAAQLwDAUcCAAAAnwMCAJ8CAAQXAgsAbwkDALwHBv4EAAAAnwcDAg4HBgCkBwcAABhQgG8ICACfBwICMAcGpAkAAABuAvT/AgAAAG8ECgC8AgHTCwAAAJ8CAwJvBAwAvAIC0wsAAACfAgMCbwQNALwCAtMLAAAAnwIDAm8FDAC8AwDTCwAAAJ8DAwJNAwOEDgAAADADAvcPAAAAggABABADAQQAAABAAwIDCAMEAwkDCgQAGFCAAwsDDAMOAw8DEAMRAwcDEgAeEwEYAAAAAAAAAAEAAAAAAQAAAAAA/gAGAAAAAAAAAAAAAAACAAAAAAAAAAIgAAAAAAMAAAECACWjAAAA/wAEAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAAD/AQAAAAAAADABAOkDAAAA/wEDAAAAAABvAgQAMAIBEAUAAABvAgYAMAIBmQcAAABvAggAMAIBxQkAAAAwAQAhCgAAAKkBAAAwAQDCCwAAAMABDAASAAAAMAEA6Q0AAADAAQ4AMAEAsg8AAACCAAIAEAMUAxUDFgMXAxgDBgMZAxoDGwMcAwUDHQYAAw0GAQMTAgABAQABGAAAAAIAAAEAAAMAAAADAAEAAAEAAAEAAP0ABgAAAgAAAAwAAA4BAAAAAAJwyjSIpy8YDdC/1vyJzZj9ANIj/EIOXok=

-- https://lua.expert/
local t = {
	Name = "Vintage Scraps",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://76741729863078",
		Blink = "rbxassetid://106681119524959",
		Hurt = "rbxassetid://75321884934972"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 18 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal

			continue
		end

		if v:IsA("RopeConstraint") then
			v.Color = BrickColor.new("Fossil")
		end
	end
end
function t.UseAbility(p1, p2) --[[ UseAbility | Line: 30 ]]
	for k, v in pairs(p2:GetDescendants()) do
		if v:IsA("RopeConstraint") then
			v.Color = BrickColor.new("Fossil")
		end
	end

	p2:WaitForChild("Base"):WaitForChild("Tail"):WaitForChild("Mesh").TextureId = p1:WaitForChild("Tail").TextureID
end

return t