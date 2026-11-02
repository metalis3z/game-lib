local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local DataService = require(ServerScriptService.Services.DataService)

local DataResetRemote = Net:RemoteFunction("DataService/WipePlayerData")

local function resetdata(player, confirmation)
	if confirmation ~= "CONFIRM_WIPE" then
		warn(player.Name .. " attempted to wipe data without proper confirmation string.")
		return false, "Invalid Request"
	end

	local success = DataService:ResetData(player)

	if success then
		print("Data successfully wiped for: " .. player.Name)
		return true, "Success"
	else
		warn("DataService failed to reset data for: " .. player.Name)
		return false, "DataStore Error"
	end
end

DataResetRemote.OnServerInvoke = resetdata
