-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GuardAreaLookupUtil = require(ReplicatedStorage.Library.Util.GuardAreaLookupUtil)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local Player = require(ReplicatedStorage.Library.Player)
local LocalPlayer = Players.LocalPlayer
local __OBJECTS = Workspace.__OBJECTS

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = __OBJECTS.Areas

assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local SeparationLine = Areas.SeparationLine

assert(SeparationLine:IsA("BasePart"), "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")

local t = {}

local function showSafeZoneMessage() --[[ showSafeZoneMessage | Line: 44 | Upvalues: Message (copy) ]]
	Message.Bottom({
		Message = "Cannot use items in the safe zone!",
		Time = 2,
		Color = Color3.fromRGB(255, 70, 70)
	}, {
		PreventDuplicateText = true
	})
end

local function isGameplayGearTool(p1) --[[ isGameplayGearTool | Line: 54 ]]
	if p1 == nil then
		return true
	end

	return typeof(p1:GetAttribute("GearName")) == "string"
end

function t.IsLocalPlayerInGameplayArea() --[[ IsLocalPlayerInGameplayArea | Line: 66 | Upvalues: Player (copy), LocalPlayer (copy), GuardAreaLookupUtil (copy), SeparationLine (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)

	if v1 == nil or not v1:IsA("BasePart") then
		return false
	end

	return GuardAreaLookupUtil.IsInGameplaySide(SeparationLine, v1.Position)
end
function t.CanActivateLocal(p1) --[[ CanActivateLocal | Line: 75 | Upvalues: t (copy), showSafeZoneMessage (copy) ]]
	if not (if p1 == nil then true else typeof(p1:GetAttribute("GearName")) == "string") then
		return true
	end

	if t.IsLocalPlayerInGameplayArea() then
		return true
	end

	showSafeZoneMessage()

	return false
end

return t