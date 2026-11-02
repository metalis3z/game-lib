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
-- CQNAB3JlcXVpcmUGc2NyaXB0BlBhcmVudAZGcmFtZXMMV2FpdEZvckNoaWxkB19faW5kZXgMc2V0bWV0YXRhYmxlBFBhcnQER2FtZQ1PdmVybGFwUGFyYW1zA25ldxpGaWx0ZXJEZXNjZW5kYW50c0luc3RhbmNlcwRFbnVtEVJheWNhc3RGaWx0ZXJUeXBlB0V4Y2x1ZGUKRmlsdGVyVHlwZQpDYW5FbmRHYW1lCldlaWdodGxlc3MKSXNTcGlubmluZwpWZWxvY2l0eV9ZDkFjY2VsZXJhdGlvbl9ZCURlc3Ryb3llZAdEZXN0cm95ClNldEdyYXZpdHkNU2V0SW50cm9GbG9hdARtYXRoA21heARKdW1wC0dBTUVfQ09ORklHDVNDUkVFTl9IRUlHSFQIUG9zaXRpb24BWQ1Jc091dE9mQm91bmRzBkNGcmFtZQRTaXplEkdldFBhcnRCb3VuZHNJbkJveA1Jc092ZXJsYXBwaW5nBEFuaW0HQWR2YW5jZQZBbmdsZXMGWkFuZ2xlB1ZlY3RvcjMHUGl2b3RUbwR0aWNrCEluc3RhbmNlCEFuY2hvcmVkCkNhbkNvbGxpZGUGU21vb3RoClRvcFN1cmZhY2UNQm90dG9tU3VyZmFjZQxUcmFuc3BhcmVuY3kFQ29sb3IGQ29sb3IzBEZpc2gJRmlzaFNjYWxlCmJ1aWxkUGxhbmULbmV3QW5pbWF0b3IHRmlzaEZQUwVDbG9uZQhNZXNoUGFydANJc0EJVGV4dHVyZUlECENhblF1ZXJ5BXBjYWxsAAsFAAAAAAANpAABAAAAAECkAQMAAAAgQE0BASQEAAAAbwMFAIwEBQC8AQHTBgAAAJ8BBACfAAAAggAAAAcDAQQAAABAAwIEAAAgQAMDAwQDBQAGAAEYAAAAAAAAAAAAAAAAAAYAAAAABgIBAAAHBAAABQIPBzP/AwQAAAAAAOIEAQD7BQAAMAUEbgAAAACePQMDBAAAAKQCAwAAACBAnwIDAjABAkQEAAAAMAACvQUAAACkAwgAABxggJ8DAQIwAwIfBgAAAE0DAh8GAAAA/wQAAAEAAABSBQEAxQQFAgEAAAAwBAN9CQAAAE0DAh8GAAAApAQNAAwsoMAwBANXDgAAAKkDAQAwAwKCDwAAAKkDAQAwAwKuEAAAAKkDAAAwAwKLEQAAAG8DEgAw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

-- https://lua.expert/
local t = {}
local ok, result = pcall(function() --[[ Line: 6 ]]
	return require(script.Parent:WaitForChild("Frames", 5))
end)
local v2 = if ok then result or nil else nil
local v3 = 0.75
local v4 = 0.01

function t.new(p1, p2) --[[ new | Line: 18 | Upvalues: t (copy) ]]
	local v1 = setmetatable({}, {
		__index = t
	})

	v1.Part = p2
	v1.Game = p1
	v1.OverlapParams = OverlapParams.new()
	v1.OverlapParams.FilterDescendantsInstances = { p2 }
	v1.OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
	v1.CanEndGame = true
	v1.Weightless = true
	v1.IsSpinning = false
	v1.Velocity_Y = -0.1
	v1.Acceleration_Y = -5

	return v1
end
function t.Destroy(p1) --[[ Destroy | Line: 33 ]]
	p1.Destroyed = true
	p1.Velocity_Y = 0
	p1.Part:Destroy()
end
function t.SetGravity(p1, p2) --[[ SetGravity | Line: 39 | Upvalues: v3 (ref) ]]
	if not p2 then
		return
	end

	v3 = p2
end
function t.SetIntroFloat(p1, p2) --[[ SetIntroFloat | Line: 47 | Upvalues: v4 (ref) ]]
	if not p2 then
		return
	end

	v4 = p2
end
function t.Jump(p1) --[[ Jump | Line: 53 ]]
	p1.Velocity_Y = math.max(math.max(0, p1.Velocity_Y) + 0.8, 1)
	p1.Weightless = false
end
function t.IsOutOfBounds(p1) --[[ IsOutOfBounds | Line: 58 ]]
	local SCREEN_HEIGHT = p1.Game.GAME_CONFIG.SCREEN_HEIGHT
	local Y = p1.Part.Position.Y

	return if SCREEN_HEIGHT * 0.5 < Y then true else Y < SCREEN_HEIGHT * -0.5
end
function t.IsOverlapping(p1) --[[ IsOverlapping | Line: 65 ]]
	return #p1.Part.Parent:GetPartBoundsInBox(p1.Part.CFrame, p1.Part.Size * 0.8, p1.OverlapParams) > 0
end
function t.tick(p1, p2) --[[ tick | Line: 72 | Upvalues: v3 (ref), v4 (ref) ]]
	if p1.Destroyed then
		return
	end

	if p1.Anim then
		p1.Anim:Advance(p2)
	end

	p1.Velocity_Y = math.max(-2, p1.Velocity_Y + (p1.Weightless and p1.Acceleration_Y * p2 * v3 * v4 or p1.Acceleration_Y * p2 * v3))

	local v42 = CFrame.Angles(0, 0, 1.5707963267948966 * ((p1.Velocity_Y + 2) / 4 - 0.5))

	if p1.IsSpinning then
		local v5 = (p1.ZAngle or 0) + p2 * 10
		local v6 = CFrame.Angles(0, 0, v5)

		p1.ZAngle = v5
		v42 = v6
	end

	local v9 = CFrame.new(p1.Part.Position + Vector3.new(0, p1.Velocity_Y * 60 * p2, 0)) * v42

	p1.Part:PivotTo(v9 * CFrame.Angles(0, math.pi, 0))

	if p1:IsOutOfBounds() then
		return -1
	end

	if p1:IsOverlapping() then
		return -1
	end
end

return function(p1, p2, p3, p4) --[[ Line: 99 | Upvalues: t (copy), v2 (ref) ]]
	local v1 = if p2 then p2 else {}
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.TopSurface = "Smooth"
	Part.BottomSurface = "Smooth"
	Part.Transparency = 1
	Part.Color = v1.Color or Color3.new(0.796078, 0.760784, 0.25098)
	Part.Size = v1.Size or Vector3.new(1, 1, 1)

	local v3 = t.new(p1, Part)

	if v2 and (v2.Fish and #v2.Fish > 0) then
		local v5 = v2.buildPlane(Part.Size * (v2.FishScale or 1), v2.Fish)

		v5.CFrame = Part.CFrame
		v5.Parent = Part
		v3.Anim = v2.newAnimator(v5, v2.Fish, v2.FishFPS)

		return v3
	end

	local v6 = p3:Clone()

	if v6:IsA("MeshPart") then
		v6.TextureID = if p4 then p4 else v6.TextureID
	end

	v6.Anchored = true
	v6.CanCollide = false
	v6.CanQuery = false
	v6.CFrame = Part.CFrame * CFrame.Angles(0, math.pi, 0)
	v6.Parent = Part

	return v3
end