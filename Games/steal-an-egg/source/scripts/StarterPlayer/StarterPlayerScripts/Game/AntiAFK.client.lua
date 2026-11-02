-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Analytics = Constants.NETWORK_MAP.Analytics
local v1 = Analytics.REQUEST_AFK_TELEPORT_FLUSH or Analytics.REPORT_AFK_TELEPORT
local LocalPlayer = Players.LocalPlayer
local v2 = false

local function reportAfkState(p1) --[[ reportAfkState | Line: 27 | Upvalues: v2 (ref), Network (copy), Analytics (copy) ]]
	if v2 ~= p1 then
		v2 = p1
		Network.Fire(Analytics.REPORT_AFK_STATE, p1)
	end
end

local function reportActiveFromInput() --[[ reportActiveFromInput | Line: 36 | Upvalues: v2 (ref), Network (copy), Analytics (copy) ]]
	if not v2 then
		return
	end

	if v2 ~= false then
		v2 = false
		Network.Fire(Analytics.REPORT_AFK_STATE, false)
	end
end

LocalPlayer.Idled:Connect(function(p1) --[[ Line: 48 | Upvalues: v2 (ref), Network (copy), Analytics (copy), Constants (copy), v1 (copy), TeleportService (copy), LocalPlayer (copy) ]]
	if p1 >= 60 and v2 ~= true then
		v2 = true
		Network.Fire(Analytics.REPORT_AFK_STATE, true)
	end

	if not (p1 > 1080) or Constants.IS_STUDIO then
		return
	end

	pcall(function() --[[ Line: 54 | Upvalues: Network (ref), v1 (ref) ]]
		Network.Invoke(v1)
	end)
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
UserInputService.InputBegan:Connect(function() --[[ Line: 61 | Upvalues: v2 (ref), Network (copy), Analytics (copy) ]]
	if not v2 then
		return
	end

	if v2 ~= false then
		v2 = false
		Network.Fire(Analytics.REPORT_AFK_STATE, false)
	end
end)
UserInputService.InputChanged:Connect(function(p1) --[[ Line: 64 | Upvalues: v2 (ref), Network (copy), Analytics (copy) ]]
	if p1.UserInputType == Enum.UserInputType.MouseMovement or p1.UserInputType == Enum.UserInputType.Touch then
		if not v2 then
			return
		end

		if v2 ~= false then
			v2 = false
			Network.Fire(Analytics.REPORT_AFK_STATE, false)
		end
	else
		if string.find(p1.UserInputType.Name, "Gamepad") == nil then
			return
		end

		if not v2 then
			return
		end

		if v2 == false then
			return
		end

		v2 = false
		Network.Fire(Analytics.REPORT_AFK_STATE, false)
	end
end)