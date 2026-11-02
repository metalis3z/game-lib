-- Starts the authentic RNGMachineController independently of stalled decompiled controllers.
-- By Mr_Wyzoxx
local ReplicatedStorage = game:GetService("ReplicatedStorage")

script:SetAttribute("Status", "Starting")
script:SetAttribute("Error", nil)

task.spawn(function()
	local ok, err = xpcall(function()
		local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
		script:SetAttribute("Status", "ConnectingReplication")
		ReplicatorClient.init()

		local assetStreamController = require(ReplicatedStorage.Controllers.AssetStreamController)
		assetStreamController.Load()
		script:SetAttribute("Status", "StartingRealController")
		local controller = require(ReplicatedStorage.Controllers.RNGMachineController)
		controller:Start()
		script:SetAttribute("Status", "Ready")
	end, debug.traceback)

	if not ok then
		script:SetAttribute("Status", "Failed")
		script:SetAttribute("Error", tostring(err))
		warn("[RNGMachineClientBootstrap] " .. tostring(err))
	end
end)
