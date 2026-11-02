-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Signal = require(ReplicatedStorage.Library.Signal)
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = Log.new()

local function resolvePlatform() --[[ resolvePlatform | Line: 19 | Upvalues: UserInputService (copy) ]]
	local PreferredInput = UserInputService.PreferredInput

	if PreferredInput == Enum.PreferredInput.Gamepad then
		return "Console"
	end

	if PreferredInput == Enum.PreferredInput.Touch then
		return "Mobile"
	end

	return "Desktop"
end

local function publishPlatform() --[[ publishPlatform | Line: 30 | Upvalues: UserInputService (copy), Variables (copy), Signal (copy), v1 (copy) ]]
	local PreferredInput = UserInputService.PreferredInput
	local v12 = if PreferredInput == Enum.PreferredInput.Gamepad then "Console" elseif PreferredInput == Enum.PreferredInput.Touch then "Mobile" else "Desktop"

	if Variables.Platform == v12 then
		return
	end

	Variables.Platform = v12
	Variables.Console = v12 == "Console"
	Variables.Mobile = v12 == "Mobile"
	Variables.Desktop = v12 == "Desktop"
	Variables.VR = UserInputService.VREnabled
	Signal.Fire("Changed Platform", v12)
	v1:AtInfo():Log((("Preferred platform changed to %*"):format(v12)))
end

Signal.Invoked("Platform: Get").OnInvoke = function() --[[ Line: 48 | Upvalues: Variables (copy) ]]
	return Variables.Platform
end
UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(publishPlatform)
Variables.Platform = ""
publishPlatform()