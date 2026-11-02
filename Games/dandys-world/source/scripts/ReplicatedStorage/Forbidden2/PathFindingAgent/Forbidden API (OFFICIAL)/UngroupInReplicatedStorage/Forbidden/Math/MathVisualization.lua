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
-- 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

-- https://lua.expert/
local t = {}
local t2 = {}
local v1 = nil

local function getInstance(p1) --[[ getInstance | Line: 12 | Upvalues: v1 (ref), t2 (copy) ]]
	if v1 == nil then
		v1 = Instance.new("Folder")
		v1.Name = "ForbiddenMathVisualizerParts"
		v1.Parent = workspace
	end

	if not t2[p1] then
		t2[p1] = {}

		local v12 = Instance.new("Folder")

		v12.Name = p1.Name
		v12.Parent = v1

		local function makeNewPart(p1) --[[ makeNewPart | Line: 29 ]]
			local Part = Instance.new("Part")

			Part.Size = Vector3.new(1, 1, 1)
			Part.Material = Enum.Material.Neon
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.Anchored = true
			Part.CastShadow = false
			Part.Transparency = 0.5

			return Part
		end

		local Part = Instance.new("Part")

		Part.Size = Vector3.new(1, 1, 1)
		Part.Material = Enum.Material.Neon
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Anchored = true
		Part.CastShadow = false
		Part.Transparency = 0.5
		Part.Shape = Enum.PartType.Ball
		Part.Parent = v12
		t2[p1].originPart = Part

		local Part2 = Instance.new("Part")

		Part2.Size = Vector3.new(1, 1, 1)
		Part2.Material = Enum.Material.Neon
		Part2.CanCollide = false
		Part2.CanQuery = false
		Part2.CanTouch = false
		Part2.Anchored = true
		Part2.CastShadow = false
		Part2.Transparency = 0.5
		Part2.Shape = Enum.PartType.Ball
		Part2.Parent = v12
		t2[p1].endPart = Part2

		local Part3 = Instance.new("Part")

		Part3.Size = Vector3.new(1, 1, 1)
		Part3.Material = Enum.Material.Neon
		Part3.CanCollide = false
		Part3.CanQuery = false
		Part3.CanTouch = false
		Part3.Anchored = true
		Part3.CastShadow = false
		Part3.Transparency = 0.5
		Part3.Parent = v12
		t2[p1].connectingPart = Part3
	end

	return t2[p1]
end

local function isValidVector3(p1) --[[ isValidVector3 | Line: 59 ]]
	return if p1.X == p1.X and p1.Y == p1.Y then p1.Z == p1.Z else false
end

function t.VisualizeRaycast(p1, p2, p3, p4) --[[ Line: 63 | Upvalues: getInstance (copy) ]]
	local v1 = getInstance(p1)
	local originPart = v1.originPart
	local endPart = v1.endPart
	local connectingPart = v1.connectingPart

	if not (if p2.X == p2.X and p2.Y == p2.Y then if p2.Z == p2.Z then true else false else false) then
		warn("Invalid Vector3 detected. Skipping visualization.")

		return
	end

	if not (if p3.X == p3.X and p3.Y == p3.Y then if p3.Z == p3.Z then true else false else false) then
		warn("Invalid Vector3 detected. Skipping visualization.")

		return
	end

	originPart.Position = p2
	endPart.Position = p3

	local v4 = (p2 + p3) / 2

	if if v4.X == v4.X and v4.Y == v4.Y then if v4.Z == v4.Z then true else false else false then
		connectingPart.CFrame = CFrame.lookAt(v4, p3)
	end

	local function ChangeColor(p1) --[[ ChangeColor | Line: 83 | Upvalues: originPart (copy), endPart (copy), connectingPart (copy) ]]
		originPart.BrickColor = p1
		endPart.BrickColor = p1
		connectingPart.BrickColor = p1
	end

	if p4 then
		local v6 = BrickColor.Green()

		originPart.BrickColor = v6
		endPart.BrickColor = v6
		connectingPart.BrickColor = v6
	end

	if p4 then
		return
	end

	local v7 = BrickColor.Red()

	originPart.BrickColor = v7
	endPart.BrickColor = v7
	connectingPart.BrickColor = v7
end

return t