-- Useful for code which will be accessed by both server and client
local mainValue = script:FindFirstAncestor("MainModule").Value
local modules = mainValue.Modules
local RunService = game:GetService("RunService")
local isClient = RunService:IsClient()
return function(settingName: string, optionalPlayer: Player?)
	if isClient then
		local clientUser = require(modules.References.clientUser)
		local success, value = clientUser.perm:fetchAsync("YouSettings", settingName)
		if success and value ~= nil then
			return value
		end
		local fallbackOk, fallback = clientUser.everyone:fetchAsync("GameSettings", "PlayerSettings", settingName)
		if fallbackOk and fallback ~= nil then
			return fallback
		end
		return nil
	end
	local User = require(modules.Objects.User)
	local optionalUser = typeof(optionalPlayer) == "Instance" and User.getUser(optionalPlayer)
	local services = mainValue.Services
	local config = require(services.Config)
	return config.getSetting(settingName, optionalUser)
end