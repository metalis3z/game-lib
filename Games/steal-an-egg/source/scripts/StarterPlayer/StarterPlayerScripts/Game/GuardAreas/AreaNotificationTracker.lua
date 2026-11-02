-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Areas = require(ReplicatedStorage.Directory.Areas)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local GuardAreaLookupUtil = require(ReplicatedStorage.Library.Util.GuardAreaLookupUtil)
local Heartbeat = require(ReplicatedStorage.Library.Functions.Heartbeat)
local Player = require(ReplicatedStorage.Library.Player)
local LocalPlayer = Players.LocalPlayer
local __OBJECTS = Workspace:WaitForChild("__OBJECTS")

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas2 = __OBJECTS.Areas

assert(Areas2:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local SeparationLine = Areas2.SeparationLine

assert(SeparationLine:IsA("BasePart"), "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")

local GuardAreas = Areas2.GuardAreas

assert(GuardAreas:IsA("Folder"), "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")

local t = {}
local t2 = {}
local v5 = nil
local v6 = nil

local function rebuildAreaEntries(p1) --[[ rebuildAreaEntries | Line: 49 | Upvalues: t2 (copy), GuardAreaLookupUtil (copy), GuardAreas (copy), Areas (copy) ]]
	table.clear(t2)

	for i, v in ipairs(GuardAreaLookupUtil.ResolveAreaBoundsEntries(GuardAreas)) do
		t2[#t2 + 1] = {
			AreaId = v.AreaId,
			Bounds = v.Bounds,
			Config = Areas.Directory[v.AreaId]
		}
	end

	table.sort(t2, function(p1, p2) --[[ Line: 60 ]]
		local RarityNumber = p1.Config.Rarity.RarityNumber
		local RarityNumber2 = p2.Config.Rarity.RarityNumber

		if RarityNumber == RarityNumber2 then
			return p1.AreaId < p2.AreaId
		end

		return RarityNumber < RarityNumber2
	end)
end

local function resolveCurrentArea(p1) --[[ resolveCurrentArea | Line: 71 | Upvalues: Asserts (copy), t2 (copy), GuardAreaLookupUtil (copy) ]]
	Asserts.Vector3(p1)

	for i, v in ipairs(t2) do
		if GuardAreaLookupUtil.IsWorldPositionInsideXZBounds(v.Bounds, p1) then
			return v
		end
	end

	return nil
end

local function step(p1) --[[ step | Line: 83 | Upvalues: Player (copy), LocalPlayer (copy), v5 (ref), GuardAreaLookupUtil (copy), SeparationLine (copy), v6 (ref), resolveCurrentArea (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)

	if v1 == nil then
		v5 = nil

		return
	end

	local v2 = v1:IsA("BasePart")

	assert(v2, (("%* must be a BasePart"):format((v1:GetFullName()))))

	if not GuardAreaLookupUtil.IsInGameplaySide(SeparationLine, v1.Position) then
		v5 = nil
		v6 = nil

		return
	end

	local v4 = resolveCurrentArea(v1.Position)

	if v4 == nil then
		v5 = nil

		return
	end

	if v4.AreaId == v5 then
		return
	end

	v5 = v4.AreaId

	local RarityNumber = v4.Config.Rarity.RarityNumber
	local v52 = v6

	v6 = RarityNumber

	if v52 == nil or not (RarityNumber <= v52) then
		p1(v4.Config)
	end
end

function t.Start(p1) --[[ Start | Line: 122 | Upvalues: Asserts (copy), rebuildAreaEntries (copy), GuardAreas (copy), Heartbeat (copy), step (copy) ]]
	Asserts.func(p1)
	rebuildAreaEntries(nil)
	GuardAreas.ChildAdded:Connect(rebuildAreaEntries)
	GuardAreas.ChildRemoved:Connect(rebuildAreaEntries)

	local v1 = 0

	Heartbeat(function(p12) --[[ Line: 130 | Upvalues: v1 (ref), step (ref), p1 (copy) ]]
		v1 = v1 + p12

		if not (v1 < 0.1) then
			v1 = 0
			step(p1)
		end

		return nil
	end)
end

return t