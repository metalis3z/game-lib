-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Player = require(ReplicatedStorage.Library.Player)
local Trails = require(ReplicatedStorage.Directory.Trails)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Trails2 = Constants.NETWORK_MAP.Trails
local v1 = Log.new()
local Trails3 = ReplicatedStorage.Assets.Trails
local t = {}

local function reconcileTrailVisual(p1) --[[ reconcileTrailVisual | Line: 42 | Upvalues: t (copy), Trails (copy), Player (copy), Trails3 (copy) ]]
	local v1 = t[p1]
	local v3 = assert(v1, (("Missing trail renderer state for %*"):format(p1.Name)))

	v3.RenderRevision = v3.RenderRevision + 1

	local RenderRevision = v3.RenderRevision

	v3.CharacterTrove:Clean()

	local TrailId = v3.TrailId
	local Character = v3.Character

	if TrailId ~= nil and Character ~= nil then
		v3.CharacterTrove:Add(task.defer(function() --[[ Line: 54 | Upvalues: Trails (ref), TrailId (copy), Player (ref), p1 (copy), t (ref), v3 (copy), RenderRevision (copy), Character (copy), Trails3 (ref) ]]
			local v1 = Trails.Types.TrailNameExists(TrailId)

			assert(v1, (("Invalid active trail \"%*\""):format(TrailId)))

			local v32 = Player.HumanoidRootPart(p1)

			if t[p1] == v3 and (v3.RenderRevision == RenderRevision and (v3.Character == Character and (v3.TrailId == TrailId and v32.Parent == Character))) then
				local v4 = Trails3[TrailId]
				local v5 = v4:IsA("BasePart")

				assert(v5, (("Trail asset \"%*\" must be a BasePart"):format(TrailId)))

				local v7 = v4:Clone()

				v3.CharacterTrove:Add(v7)
				v7.Anchored = false
				v7.CanCollide = false
				v7.CanTouch = false
				v7.CanQuery = false
				v7.Massless = true
				v7.Transparency = 1
				v7.CFrame = v32.CFrame
				v7.Parent = v32

				local MainPartTrailWeldConstraint = v7.MainPartTrailWeldConstraint
				local v8 = MainPartTrailWeldConstraint:IsA("WeldConstraint")

				assert(v8, (("Trail asset \"%*\" has an invalid weld"):format(TrailId)))
				MainPartTrailWeldConstraint.Part1 = v32
			end
		end))
	end
end

local function applyActiveTrail(p1, p2, p3) --[[ applyActiveTrail | Line: 89 | Upvalues: Asserts (copy), t (copy), reconcileTrailVisual (copy) ]]
	Asserts.Player(p1)
	Asserts.optional.string(p2)

	local v3 = assert(t[p1], (("Missing trail renderer state for %*"):format(p1.Name)))

	v3.TrailId = p2
	v3.ReceivedLiveUpdate = v3.ReceivedLiveUpdate or p3
	reconcileTrailVisual(p1)
end

local function bindPlayer(p1) --[[ bindPlayer | Line: 99 | Upvalues: t (copy), Trove (copy), Player (copy), reconcileTrailVisual (copy) ]]
	if t[p1] ~= nil then
		return
	end

	local v1 = Trove.new()
	local v2 = v1:Extend()

	t[p1] = {
		TrailId = nil,
		RenderRevision = 0,
		ReceivedLiveUpdate = false,
		Character = Player.Optional.Character(p1),
		PlayerTrove = v1,
		CharacterTrove = v2
	}

	local v3 = t[p1]

	v1:Connect(p1.CharacterAdded, function(p12) --[[ Line: 116 | Upvalues: v3 (copy), reconcileTrailVisual (ref), p1 (copy) ]]
		v3.Character = p12
		reconcileTrailVisual(p1)
	end)
	v1:Connect(p1.CharacterRemoving, function(p12) --[[ Line: 120 | Upvalues: v3 (copy), reconcileTrailVisual (ref), p1 (copy) ]]
		if v3.Character ~= p12 then
			return
		end

		v3.Character = nil
		reconcileTrailVisual(p1)
	end)

	if v3.Character == nil then
		return
	end

	reconcileTrailVisual(p1)
end

local function handleActiveTrailChanged(p1, p2) --[[ handleActiveTrailChanged | Line: 132 | Upvalues: bindPlayer (copy), Asserts (copy), t (copy), reconcileTrailVisual (copy) ]]
	bindPlayer(p1)
	Asserts.Player(p1)
	Asserts.optional.string(p2)

	local v3 = assert(t[p1], (("Missing trail renderer state for %*"):format(p1.Name)))

	v3.TrailId = p2
	v3.ReceivedLiveUpdate = v3.ReceivedLiveUpdate or true
	reconcileTrailVisual(p1)
end

local function unbindPlayer(p1) --[[ unbindPlayer | Line: 137 | Upvalues: t (copy) ]]
	local v3 = assert(t[p1], (("Missing trail renderer state for %*"):format(p1.Name)))

	t[p1] = nil
	v3.PlayerTrove:Destroy()
end

local function hydrateActiveTrailSnapshot() --[[ hydrateActiveTrailSnapshot | Line: 143 | Upvalues: Network (copy), Trails2 (copy), Players (copy), bindPlayer (copy), t (copy), Asserts (copy), reconcileTrailVisual (copy), v1 (copy) ]]
	for k, v in pairs((Network.Invoke(Trails2.REQUEST_ACTIVE_SNAPSHOT))) do
		local v2 = Players:GetPlayerByUserId(k)

		if v2 == nil then
			v1:AtDebug():Log((("Skipped trail snapshot for departed user %*"):format(k)))

			continue
		end

		bindPlayer(v2)

		if not assert(t[v2], (("Missing trail renderer state for %*"):format(v2.Name))).ReceivedLiveUpdate then
			Asserts.Player(v2)
			Asserts.optional.string(v)

			local v7 = assert(t[v2], (("Missing trail renderer state for %*"):format(v2.Name)))

			v7.TrailId = v
			v7.ReceivedLiveUpdate = v7.ReceivedLiveUpdate or false
			reconcileTrailVisual(v2)
		end
	end
end

Players.PlayerAdded:Connect(bindPlayer)
Players.PlayerRemoving:Connect(unbindPlayer)

for i, v in ipairs(Players:GetPlayers()) do
	task.spawn(bindPlayer, v)
end

Network.Fired(Trails2.ACTIVE_TRAIL_EVENT):Connect(handleActiveTrailChanged)
task.defer(hydrateActiveTrailSnapshot)

return {}