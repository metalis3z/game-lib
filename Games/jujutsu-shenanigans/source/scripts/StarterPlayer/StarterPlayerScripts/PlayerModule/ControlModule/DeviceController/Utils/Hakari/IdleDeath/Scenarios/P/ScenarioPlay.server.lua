-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMeBGdhbWUMVHdlZW5TZXJ2aWNlCkdldFNlcnZpY2UGRGVicmlzBnNjcmlwdAZQYXJlbnQHSmFja3BvdAxHZXRBdHRyaWJ1dGUFU3BlZWQFWXV1a2kISHVtYW5vaWQJQW5pbWF0aW9uDUxvYWRBbmltYXRpb24EUGxheQxUaW1lUG9zaXRpb24EdGFzawR3YWl0CEluc3RhbmNlA25ldwlIaWdobGlnaHQGQ29sb3IzCUZpbGxDb2xvchBGaWxsVHJhbnNwYXJlbmN5E091dGxpbmVUcmFuc3BhcmVuY3kERW51bRJIaWdobGlnaHREZXB0aE1vZGUIT2NjbHVkZWQJRGVwdGhNb2RlCVR3ZWVuSW5mbwZDcmVhdGUAAQ0AAAECAGejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAMGAAAAUEBNAgMkBwAAAG8ECAC8AgISCQAAAJ8CAwKkBAYAAABQQE0DBCQHAAAAbwUKALwDAxIJAAAAnwMDAqQGBgAAAFBATQUGJAcAAABNBAWsCwAAAE0FBAEMAAAApAgGAAAAUEBNBwgzDQAAALwFBZQOAAAAnwUDAowIAADGCQAAUgoDALwGBe4PAAAAnwYFASoCMwAAAACAjAYHADAGBcYQAAAApAYTAABIEIHYBxQDnwYCAaQGFwAAWFCBbwcYAJ8GAgKkBxoAAFiQgYwIAACMCQAAjAoAAJ8HBAIwBwaAGwAAAIwHAQAwBwYWHAAAAIwHAQAwBwaiHQAAAKQHIQAgfODBMAcGMyIAAACkCAYAAABQQE0HCCQHAAAAMAcGJAcAAABSCQYApAokAABYMILYCyUDnwoCAuILJgBvDCcAMAwLFhwAAAC8BwCWKAAAAJ8HBQK8BwfuDwAAAJ8HAgGCAAEAKQMBBAAAAEADAgMDAwQDBQQAAFBAAwYDBwMIAwkDCgMLAwwDDQMOAw8DEAMRBABIEIECAAAAAAAAEEADEgMTBABYUIEDFAMVBABYkIEDFgMXAxgDGQMaAxsEIHzgwQMcAx0EAFgwggIAAAAAAADwPwUBHAIAAAAAAADgPwMeAAEAARgAAAAAAAAAAQAAAAAAAgAAAAAAAAABAAAAAAAAAAEAAAAAAAIAAAAAAAAAAAEAAAAAAAEAAQAAAQAAAAEAAAABAAAAAAAAAAEAAAAAAAEAAAABAAAAAAABAAAAAAAAAAAAAAAAAAABAQAAAAAA

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-09-21 04:45:20
-- Luau version 6, Types version 3
-- Time taken: 0.000658 seconds

local Speed = script.Parent:GetAttribute("Speed")
local any_LoadAnimation_result1 = script.Parent.Yuuki.Humanoid:LoadAnimation(script.Animation)
any_LoadAnimation_result1:Play(0, nil, Speed)
if script.Parent:GetAttribute("Jackpot") == false then
	any_LoadAnimation_result1.TimePosition = 7
	task.wait(4 / Speed)
	local Highlight = Instance.new("Highlight")
	Highlight.FillColor = Color3.new(0, 0, 0)
	Highlight.FillTransparency = 1
	Highlight.OutlineTransparency = 1
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.Parent = script.Parent
	game:GetService("TweenService"):Create(Highlight, TweenInfo.new(1 / Speed), {
		FillTransparency = 0.5;
	}):Play()
end