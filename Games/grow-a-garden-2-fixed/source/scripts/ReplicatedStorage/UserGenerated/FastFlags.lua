--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags)

local v1 = nil

if RunService:IsClient() then
	return require(ReplicatedStorage.UserGenerated.Client.ClientFastFlags)
end

if RunService:IsServer() then
	local ServerScriptService = game:GetService("ServerScriptService")

	return require(ServerScriptService.UserGenerated.Server.ServerFastFlags)
end

error("RunContext")