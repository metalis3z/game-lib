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
-- CQMqCEh1bWFub2lkDkZpbmRGaXJzdENoaWxkEEh1bWFub2lkUm9vdFBhcnQEd2FybjhDaHJpc3RtYXNDb29raWVBT0U6IE1pc3NpbmcgSHVtYW5vaWQgb3IgSHVtYW5vaWRSb290UGFydARTaXplAVkJSGlwSGVpZ2h0BVBhcnRzCVRpc2hhUG9vZidDaHJpc3RtYXNDb29raWVBT0U6IFRpc2hhUG9vZiBub3QgZm91bmQFQ2xvbmUJd29ya3NwYWNlBlBhcmVudAhBbmNob3JlZApDYW5Db2xsaWRlCENhblF1ZXJ5CkNhc3RTaGFkb3cIQ2FuVG91Y2gIUG9zaXRpb24HVmVjdG9yMwNuZXcGQ29sb3IzB2Zyb21SR0IFQ29sb3IHQWRkSXRlbQlUd2VlbkluZm8ERW51bQtFYXNpbmdTdHlsZQRRdWFkD0Vhc2luZ0RpcmVjdGlvbgNPdXQMVHJhbnNwYXJlbmN5CFJvdGF0aW9uBkNyZWF0ZQRQbGF5DFJlbmRlck9iamVjdARnYW1lBkRlYnJpcwpHZXRTZXJ2aWNlDFR3ZWVuU2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQACDgEDAAAHAAABCAlHAWoTAQAAbwQAALwCAQMBAAAAnwIDAm8FAgC8AwEDAQAAAJ8DAwIOAgEAKwMFAKQEBAAAADBAbwUFAJ8EAgGCAAEATQYDLwcAAABNBgZ4CAAAAD4FBgZNBgIXCQAAAEMEBQb7BQAATQUFLwoAAABvBwsAvAUFAwEAAACfBQMCKwUFAKQGBAAAADBAbwcMAJ8GAgGCAAEAvAYFOg0AAACfBgICpAcPAAAA4EAwBwYkEAAAAKkHAQAwBwZFEQAAAKkHAAAwBwbTEgAAAKkHAAAwBwZiEwAAAKkHAAAwBwY+FAAAAKkHAAAwBwb2FQAAAG8HFgAwBwYvBwAAAE0IAzsXAAAAjAoAADkLBACMDAAATDYAAqQJGgAAZICBnwkEAkMHCAkwBwY7FwAAAKQHHQAAcLCBjAjcAIwJoACMCmQAnwcEAjAHBqQeAAAA+wcBAFIJBgCMCgUAvAcHeB8AAACfBwQB+wcCAFIJBgCkCiEAAGQAgowLAQCkDCUAJIwgwqQNKAAnmCDCnwoEAuILLgC8BweWLwAAAJ8HBQK8CAfuMAAAAJ8IAgGCAAEAMQMBAwIDAwMEBAAAMEADBQIAAAAAAAAAQAMGAwcDCAMJAwoDCwMMAw0EAADgQAMOAw8DEAMRAxIDEwcAAAAAAACAPgAAAAAAAAAAAxQDFQMWBABkgIEDFwMYBABwsIEDGQMaAxsEAGQAggMcAx0DHgQkjCDCAx8DIAQnmCDCBwAAcEIAAIA+AABwQgAAAAADIQIAAAAAAADwPwMiBwAAAADlXi9AAAAAAAAAAAAIAwcpAAAAKisAAAAsLQAAAAMjAyQAByUBGAACAAAAAQAAAAIAAQAAAAEDAAAAAAAAAAMAAAAAAAABAQAAAAEDAAABAAAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAAAAAAAAAAAAAwAAAAAAAAACAAAAAAABAAAAAAAAAAAAAAAAAAUAAAEIAAAAAAYAAAECAByjAAAA/wABAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBAC8AgIWAwAAAJ8CAwKkAwEAAAAAQG8FBQC8AwMWAwAAAJ8DAwLABAYAEgADABIAAQASAAIAMAQASAcAAACCAAIACAMmBAAAAEADJwMoAykDKgYAAyUBAAEAARgAAAACAAAAAAABAAAAAAABAAAAAAACAAAAAAAqAQAAAAABzBFtU5kUCcmXkakuMn7iJrwJeif+1QdS

-- https://lua.expert/
local t = {}
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

function t.RenderObject(p1) --[[ RenderObject | Line: 7 | Upvalues: ReplicatedStorage (copy), Debris (copy), TweenService (copy) ]]
	local v1 = p1[1]
	local Humanoid = v1:FindFirstChild("Humanoid")
	local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart")

	if not (Humanoid and HumanoidRootPart) then
		warn("ChristmasCookieAOE: Missing Humanoid or HumanoidRootPart")

		return
	end

	local v2 = HumanoidRootPart.Size.Y / 2 + Humanoid.HipHeight
	local TishaPoof = ReplicatedStorage.Parts:FindFirstChild("TishaPoof")

	if TishaPoof then
		local v3 = TishaPoof:Clone()

		v3.Parent = workspace
		v3.Anchored = true
		v3.CanCollide = false
		v3.CanQuery = false
		v3.CastShadow = false
		v3.CanTouch = false
		v3.Size = Vector3.new(0, 0.25, 0)
		v3.Position = HumanoidRootPart.Position + Vector3.new(0, -v2, 0)
		v3.Color = Color3.fromRGB(220, 160, 100)
		Debris:AddItem(v3, 5)
		TweenService:Create(v3, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = Vector3.new(60, 0.25, 60),
			Transparency = 1,
			Rotation = Vector3.new(0, 2.740167, 0)
		}):Play()
	else
		warn("ChristmasCookieAOE: TishaPoof not found")
	end
end

return t