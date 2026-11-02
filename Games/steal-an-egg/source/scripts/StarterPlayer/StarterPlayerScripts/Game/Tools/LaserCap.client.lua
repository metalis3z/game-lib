-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolSetup = require(ReplicatedStorage.Library.Util.ToolSetup)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local LaserCap = require(ReplicatedStorage.Directory.Gears._Index.Other.LaserCap)
local LaserCap2 = Constants.NETWORK_MAP.LaserCap
local COOLDOWN = LaserCap.COOLDOWN
local beamTrail = ReplicatedStorage.Assets.ToolEffects:FindFirstChild("beamTrail")
local LocalPlayer = Players.LocalPlayer

local function findTargetPart(p1) --[[ findTargetPart | Line: 30 | Upvalues: LocalPlayer (copy), Workspace (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	if LocalPlayer.Character then
		v1.FilterDescendantsInstances = { LocalPlayer.Character }
	end

	local v2 = Workspace:Raycast(p1, Vector3.new(0, -0.1, 0), v1)

	if v2 and v2.Instance then
		return v2.Instance
	end

	return nil
end

local function spawnBeamEffect(p1, p2) --[[ spawnBeamEffect | Line: 45 | Upvalues: beamTrail (copy), Workspace (copy), findTargetPart (copy) ]]
	if not beamTrail then
		warn("[LaserCap] Beam effect template not found")

		return
	end

	local v1 = beamTrail:Clone()

	v1.Parent = Workspace

	local v2 = v1:FindFirstChildWhichIsA("Beam", true)

	if not v2 then
		v1:Destroy()

		return
	end

	local LaserCapBeamStart = Instance.new("Attachment")

	LaserCapBeamStart.Name = "LaserCapBeamStart"
	LaserCapBeamStart.Parent = p1

	local v3 = findTargetPart(p2)
	local v4, v5

	if v3 then
		v4 = v3
		v5 = nil
	else
		local LaserCapBeamEndAnchor = Instance.new("Part")

		LaserCapBeamEndAnchor.Name = "LaserCapBeamEndAnchor"
		LaserCapBeamEndAnchor.Anchored = true
		LaserCapBeamEndAnchor.CanCollide = false
		LaserCapBeamEndAnchor.CanTouch = false
		LaserCapBeamEndAnchor.CanQuery = false
		LaserCapBeamEndAnchor.Transparency = 1
		LaserCapBeamEndAnchor.Size = Vector3.new(0.2, 0.2, 0.2)
		LaserCapBeamEndAnchor.CFrame = CFrame.new(p2)
		LaserCapBeamEndAnchor.Parent = Workspace
		v5 = LaserCapBeamEndAnchor
		v4 = LaserCapBeamEndAnchor
		v5 = LaserCapBeamEndAnchor
	end

	local LaserCapBeamEnd = Instance.new("Attachment")

	LaserCapBeamEnd.Name = "LaserCapBeamEnd"
	LaserCapBeamEnd.Parent = v4
	LaserCapBeamEnd.WorldPosition = p2
	v2.Attachment0 = LaserCapBeamStart
	v2.Attachment1 = LaserCapBeamEnd
	task.delay(0.3, function() --[[ Line: 93 | Upvalues: LaserCapBeamStart (copy), LaserCapBeamEnd (copy), v5 (ref), v1 (copy) ]]
		if LaserCapBeamStart.Parent then
			LaserCapBeamStart:Destroy()
		end

		if LaserCapBeamEnd.Parent then
			LaserCapBeamEnd:Destroy()
		end

		if v5 and v5.Parent then
			v5:Destroy()
		end

		v1:Destroy()
	end)
end

local function playBeamVFX(p1, p2) --[[ playBeamVFX | Line: 110 | Upvalues: spawnBeamEffect (copy) ]]
	spawnBeamEffect(p1, p2)
end

local function playSFX(p1) --[[ playSFX | Line: 114 ]] end

local function getHeadPosition() --[[ getHeadPosition | Line: 116 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	local Head = Character:FindFirstChild("Head")

	if Head and Head:IsA("BasePart") then
		return Head
	end

	return nil
end

local function onActivated(p1) --[[ onActivated | Line: 130 | Upvalues: LocalPlayer (copy), Network (copy), LaserCap2 (copy) ]]
	if not LocalPlayer.Character then
		return
	end

	local Character = LocalPlayer.Character
	local v1

	if Character then
		local Head = Character:FindFirstChild("Head")

		v1 = if Head and Head:IsA("BasePart") then Head else nil
	else
		v1 = nil
	end

	if not v1 then
		return
	end

	local v2 = LocalPlayer:GetMouse().Hit.Position - v1.Position
	local Magnitude = v2.Magnitude

	if Magnitude ~= 0 and Magnitude == Magnitude then
		Network.Fire(LaserCap2.REQUEST_FIRE, v1.Position, v2.Unit)
	end
end

local v1 = ToolSetup.Initialize(LaserCap.DisplayName, {
	onActivated = onActivated
})

Network.Fired(LaserCap2.PLAY_BEAM_VFX):Connect(function(p1, p2) --[[ Line: 158 | Upvalues: spawnBeamEffect (copy), ToolSetup (copy), v1 (ref), COOLDOWN (copy) ]]
	spawnBeamEffect(p1, p2)
	ToolSetup.StartCooldown(v1, COOLDOWN)
end)
Network.Fired(LaserCap2.PLAY_SFX):Connect(function(p1) --[[ Line: 163 ]] end)