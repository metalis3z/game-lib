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
-- CQNYBHRpY2sFcGFpcnMJR2V0VGFnZ2VkBmlwYWlycwZQYXJlbnQIem9uZVR5cGUIcG9zaXRpb24Ec2l6ZQRwYXJ0CFBvc2l0aW9uBFNpemUFdGFibGUGaW5zZXJ0DmdldEFjdGl2ZVpvbmVzE2ludmFsaWRhdGVab25lQ2FjaGUHb3duZXJJRAlNYWduaXR1ZGUBWAdPd25lcklEDEdldEF0dHJpYnV0ZRhtaW5EaXN0YW5jZUZyb21TYW1lT3duZXIXbWluRGlzdGFuY2VGcm9tU2FtZVR5cGUZbWluRGlzdGFuY2VGcm9tT3RoZXJab25lcw9JY2hvclB1ZGRsZVpvbmUQV2lsdGVkRmxvd2VyWm9uZRxtaW5EaXN0YW5jZUZyb21XaWx0ZWRGbG93ZXJzEmFsbG93T3duZXJTdGFja2luZw9pc1Bvc2l0aW9uVmFsaWQJd29ya3NwYWNlC0N1cnJlbnRSb29tDkZpbmRGaXJzdENoaWxkBU1vZGVsFUZpbmRGaXJzdENoaWxkT2ZDbGFzcxJNb25zdGVyU3Bhd25Qb2ludHMLR2V0Q2hpbGRyZW4IQmFzZVBhcnQDSXNBDmdldFNwYXduUG9pbnRzC21heEF0dGVtcHRzDHNlYXJjaFJhZGl1cwR3YXJuK1pvbmVQbGFjZW1lbnRNYW5hZ2VyOiBObyBzcGF3biBwb2ludHMgZm91bmQSRmluZFZhbGlkUG9zaXRpb25zB3JlcXVpcmUEZ2FtZRNTZXJ2ZXJTY3JpcHRTZXJ2aWNlE1pvbmVNb2RpZmllck1hbmFnZXIMV2FpdEZvckNoaWxkCkNyZWF0ZVpvbmUPQ3JlYXRlWm9uZUJhdGNoEENoZWNrWm9uZU92ZXJsYXAIZGlzdGFuY2UEc29ydA5HZXROZWFyYnlab25lcwVwcmludBo9PT0gWk9ORSBTUEFDSU5HIERFQlVHID09PRNUb3RhbCBhY3RpdmUgem9uZXM6BnN0cmluZwZmb3JtYXQRWm9uZSAlZDogJXMgYXQgJXMIdG9zdHJpbmcISW5zdGFuY2UDbmV3DEJpbGxib2FyZEd1aQVVRGltMgtTdHVkc09mZnNldAlUZXh0TGFiZWwWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQZDb2xvcjMHZnJvbVJHQgpUZXh0Q29sb3IzClRleHRT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EgAEABIAAQDZCAEAEgEF/8AJIgASAAQAEgAHAMAKIwDACyQAEgAKABIAAgASAAMAEgAJADALACYlAAAA2QsFABIACQASAQX/MAsARSYAAADACycAEgAJADALAOcoAAAAwAspABIABwAwCwBUKgAAAMALKwASAAcAMAsA8iwAAADACy0AEgADABIAAAAwCwCILgAAAMALLwASAAQAMAsA/zAAAADBBQAAggACADEDLQQAAABAA1MDSwNOA1QEABRAgANVAz8EACBwgAMZAxgDVgNXBQQKCwwNAxYCAAAAAAAALkADFwIAAAAAAAAkQANYAgAAAAAAAAhACAMPEAAAABESAAAAExQAAAACAAAAAAAAKEACAAAAAAAAGEADGgIAAAAAAAAUQAgEDxYAAAARFwAAABgZAAAAExAAAAACAAAAAAAAIEAIAw8WAAAAERsAAAATEgAAAAIAAAAAAAA0QAMVAxsBAAgFDxsAAAARFwAAABMdAAAAHhQAAAAfIAAAAAYCBgMGBAMrAzIGBgMzBggDNgYJA00GCgNRBgsDUgsAAQIDBAUGCAkKCwEAAQUAAAACAAAAAAADAAIAAwEAAAUAAAYAAAUAAAsBBAAAANUhAAUAADQVAAAAAAAAKgAAAAAYAAAABQAAABUAAAAeFwAAABkAAAAEAAEAAAArAAAA6QAAAAAMwAyBD3pXET0qwzo4fII4MbAUlnvyyOsO

-- https://lua.expert/
local t = {}
local CollectionService = game:GetService("CollectionService")
local random = math.random
local v1 = Vector3.new
local t2 = {
	WiltedFlowerZone = {
		minDistanceFromSameType = 15,
		minDistanceFromOtherZones = 10,
		maxPerFloor = 3
	},
	IchorPuddleZone = {
		minDistanceFromSameType = 12,
		minDistanceFromOtherZones = 6,
		minDistanceFromWiltedFlowers = 5,
		maxPerFloor = 15
	},
	SpeedBoostZone = {
		minDistanceFromSameType = 12,
		minDistanceFromOtherZones = 8,
		maxPerFloor = 10
	},
	BlotHandZone = {
		minDistanceFromSameType = 8,
		minDistanceFromOtherZones = 6,
		maxPerFloor = 20,
		minDistanceFromSameOwner = 3,
		allowOwnerStacking = false
	}
}
local v2 = nil
local v3 = 0

local function getActiveZones() --[[ getActiveZones | Line: 44 | Upvalues: v2 (ref), v3 (ref), t2 (copy), CollectionService (copy) ]]
	local v1 = tick()

	if v2 and v1 - v3 < 1 then
		return v2
	end

	local t = {}

	for k, v in pairs(t2) do
		for i, v4 in ipairs((CollectionService:GetTagged(k))) do
			if v4.Parent then
				table.insert(t, {
					zoneType = k,
					position = v4.Position,
					size = v4.Size,
					part = v4
				})
			end
		end
	end

	v2 = t
	v3 = v1

	return t
end

local function invalidateZoneCache() --[[ invalidateZoneCache | Line: 77 | Upvalues: v2 (ref) ]]
	v2 = nil
end

local function isPositionValid(p1, p2, p3, p4) --[[ isPositionValid | Line: 82 | Upvalues: t2 (copy), getActiveZones (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return true
	end

	local v2 = getActiveZones()
	local v3 = p3 / 2
	local v4 = if p4 then p4.ownerID else p4

	for i, v in ipairs(v2) do
		local v5
		local Magnitude = (p1 - v.position).Magnitude
		local v7 = if v4 and v.part:GetAttribute("OwnerID") == v4 then true else false

		if v.zoneType == p2 then
			v5 = if v7 and v1.minDistanceFromSameOwner then v1.minDistanceFromSameOwner else v1.minDistanceFromSameType or 15
		else
			v5 = v1.minDistanceFromOtherZones or 10

			if p2 == "IchorPuddleZone" and v.zoneType == "WiltedFlowerZone" then
				v5 = v1.minDistanceFromWiltedFlowers or 8
			end
		end

		if Magnitude < v5 then
			return false
		end

		if not (v7 and v1.allowOwnerStacking) and Magnitude < v3.X + v.size.X / 2 then
			return false
		end
	end

	return true
end

local function getSpawnPoints() --[[ getSpawnPoints | Line: 134 ]]
	local CurrentRoom = workspace:FindFirstChild("CurrentRoom")

	if not CurrentRoom then
		return {}
	end

	local Model = CurrentRoom:FindFirstChildOfClass("Model")

	if not Model then
		return {}
	end

	local MonsterSpawnPoints = Model:FindFirstChild("MonsterSpawnPoints")

	if not MonsterSpawnPoints then
		return {}
	end

	local t = {}

	for i, v in ipairs(MonsterSpawnPoints:GetChildren()) do
		if v:IsA("BasePart") then
			table.insert(t, v.Position)
		end
	end

	return t
end

function t.FindValidPositions(p1, p2, p3, p4) --[[ FindValidPositions | Line: 155 | Upvalues: getSpawnPoints (copy), random (copy), v1 (copy), isPositionValid (copy) ]]
	local v12 = if p4 then p4 else {}
	local v2 = v12.maxAttempts or 50
	local v3 = v12.searchRadius or 25
	local v4 = getSpawnPoints()

	if #v4 == 0 then
		warn("ZonePlacementManager: No spawn points found")

		return {}
	end

	local v5, v6, count = v12, {}, 0

	while #v6 < p2 and count < v2 do
		count = count + 1

		local v7 = v4[random(1, #v4)]
		local v8 = if v3 > 0 then v7 + v1(random(-v3, v3), 0, random(-v3, v3)) else v7

		if isPositionValid(v8, p1, p3, v5) then
			table.insert(v6, v8)
		end
	end

	return v6
end
function t.CreateZoneBatch(p1, p2, p3, p4) --[[ CreateZoneBatch | Line: 197 | Upvalues: isPositionValid (copy), v2 (ref) ]]
	local ZoneModifierManager = require(game.ServerScriptService:WaitForChild("ZoneModifierManager"))
	local t = {}
	local t2 = {}

	for i, v in ipairs(p2) do
		if isPositionValid(v, p1, p3, p4) then
			local v1 = ZoneModifierManager.CreateZone(p1, v, p3, p4)

			if v1 then
				table.insert(t2, v1)
				v2 = nil

				continue
			end

			table.insert(t, v)

			continue
		end

		table.insert(t, v)
	end

	return t2, t
end
function t.CheckZoneOverlap(p1, p2, p3, p4) --[[ CheckZoneOverlap | Line: 221 | Upvalues: isPositionValid (copy) ]]
	return not isPositionValid(p1, p3, p2, p4)
end
function t.GetNearbyZones(p1, p2) --[[ GetNearbyZones | Line: 226 | Upvalues: getActiveZones (copy) ]]
	local t = {}

	for i, v in ipairs((getActiveZones())) do
		local Magnitude = (p1 - v.position).Magnitude

		if Magnitude <= p2 then
			v.distance = Magnitude
			table.insert(t, v)
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 239 ]]
		return p1.distance < p2.distance
	end)

	return t
end
function t.DebugZoneSpacing(p1) --[[ DebugZoneSpacing | Line: 247 | Upvalues: getActiveZones (copy) ]]
	local v1 = getActiveZones()

	print("=== ZONE SPACING DEBUG ===")
	print("Total active zones:", #v1)

	for i, v in ipairs(v1) do
		print(string.format("Zone %d: %s at %s", i, v.zoneType, (tostring(v.position))))

		if p1 then
			local BillboardGui = Instance.new("BillboardGui")

			BillboardGui.Size = UDim2.new(0, 100, 0, 50)
			BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
			BillboardGui.Parent = v.part

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextScaled = true
			TextLabel.Text = v.zoneType
			TextLabel.Parent = BillboardGui
			game:GetService("Debris"):AddItem(BillboardGui, 10)
		end
	end
end
function t.FindNearbyValidPosition(p1, p2, p3, p4) --[[ FindNearbyValidPosition | Line: 277 | Upvalues: v1 (copy), t (copy) ]]
	for i = 1, 20 do
		local v12 = i / 20
		local v2 = v12 * 6.283185307179586
		local v3 = v12 * 10
		local v4 = p1 + v1(math.cos(v2) * v3, 0, math.sin(v2) * v3)

		if not t.CheckZoneOverlap(v4, p2, p3, p4) then
			return v4
		end
	end

	return nil
end
function t.GetZoneConfig(p1) --[[ GetZoneConfig | Line: 302 | Upvalues: t2 (copy) ]]
	return t2[p1]
end

return t