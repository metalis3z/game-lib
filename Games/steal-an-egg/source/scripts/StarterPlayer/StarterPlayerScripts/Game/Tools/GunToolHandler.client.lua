-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolSetup = require(ReplicatedStorage.Library.Util.ToolSetup)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GunUtil = require(ReplicatedStorage.Library.Util.GunUtil)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Audio = require(ReplicatedStorage.Library.Audio)
local Gears = require(ReplicatedStorage.Directory.Gears)

require(ReplicatedStorage.Directory.Gears.Types.ToolConfigs)

local Asserts = require(ReplicatedStorage.Library.Asserts)
local v2 = GunUtil.GetAvailableGuns()
local Gun = Constants.NETWORK_MAP.Gun
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local v3 = nil

local function createWallCheckParams(p1) --[[ createWallCheckParams | Line: 33 ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local t = { p1 }
	local Tool = p1:FindFirstChildOfClass("Tool")

	if Tool then
		table.insert(t, Tool)
	end

	v1.FilterDescendantsInstances = t
	v1.IgnoreWater = true

	return v1
end

local function isShootPathBlocked(p1, p2, p3) --[[ isShootPathBlocked | Line: 48 | Upvalues: createWallCheckParams (copy) ]]
	if not (p3 and p1) then
		return true
	end

	local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart")

	if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
		return true
	end

	local v1 = p3:FindFirstChild("Right Arm")

	if not v1 then
		return true
	end

	local RightShoulderAttachment = v1:FindFirstChild("RightShoulderAttachment")

	if not RightShoulderAttachment then
		return true
	end

	return workspace:Raycast(RightShoulderAttachment.WorldPosition, p1.WorldPosition - RightShoulderAttachment.WorldPosition, (createWallCheckParams(p3))) ~= nil
end

local function getArmShootPosition(p1, p2) --[[ getArmShootPosition | Line: 75 | Upvalues: LocalPlayer (copy), CurrentCamera (copy), isShootPathBlocked (copy) ]]
	if not p1 then
		return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), true
	end

	local v1 = LocalPlayer:GetMouse()
	local v2 = CurrentCamera:ScreenPointToRay(v1.X, v1.Y)
	local v3 = v2.Origin + v2.Direction * 1000
	local v4 = RaycastParams.new()

	v4.FilterType = Enum.RaycastFilterType.Exclude

	local t = { p2 }
	local Tool = p2:FindFirstChildOfClass("Tool")

	if Tool then
		table.insert(t, Tool)
	end

	v4.FilterDescendantsInstances = t
	v4.IgnoreWater = true

	local v5 = workspace:Raycast(v2.Origin, v2.Direction * 1000, v4)

	if v5 then
		v3 = v5.Position
	end

	local WorldPosition = p1.WorldPosition
	local Unit = (v3 - WorldPosition).Unit

	return WorldPosition, Unit, isShootPathBlocked(p1, Unit, p2)
end

local function onActivated(p1) --[[ onActivated | Line: 110 | Upvalues: LocalPlayer (copy), Asserts (copy), getArmShootPosition (copy), v1 (copy), Network (copy), Gun (copy), v3 (ref) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Shoot = p1:FindFirstChild("Shoot", true)
	local v12 = assert(Shoot, "Shoot Attachment not found")

	Asserts.Attachment(v12)

	local v2, v32, v4 = getArmShootPosition(v12, Character)

	if v4 then
		v1:AtDebug():Log("Shoot blocked by wall - preventing fire")
	else
		Network.Fire(Gun.REQUEST_FIRE, v3:GetCurrentToolGearName(), v2, v32)
	end
end

local function onEquipped() --[[ onEquipped | Line: 128 | Upvalues: v3 (ref), Gears (copy), Audio (copy) ]]
	local v1 = v3:GetCurrentToolGearName()

	if not v1 then
		return
	end

	local EQUIP_SFX = Gears.Directory[v1].EQUIP_SFX

	if EQUIP_SFX then
		Audio.PlayFromSoundFile(EQUIP_SFX, script)
	end
end

local function onUnequipped() --[[ onUnequipped | Line: 143 | Upvalues: Network (copy), Gun (copy), v3 (ref) ]]
	Network.Fire(Gun.CLEAR_PLAYER_CASTER, v3:GetCurrentToolGearName())
end

v3 = ToolSetup.Initialize(v2, {
	onActivated = onActivated,
	onEquipped = onEquipped,
	onUnequipped = onUnequipped
})