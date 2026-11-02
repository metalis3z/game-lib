-- Starts the RNG machine even when a decompiled service blocks the shared loader.
-- By Mr_Wyzoxx
script:SetAttribute("Status", "Starting")
task.spawn(function()
	local ok, err = xpcall(function()
		-- Asset streaming can stall in decompiled places; it must not block RNG state.
		task.spawn(function()
			local streamOk, streamError = xpcall(function()
				local assetStreamService = require(game.ServerScriptService.Services.AssetStreamService)
				assetStreamService:Start()
			end, debug.traceback)
			if not streamOk then
				warn("[RNGMachineBootstrap] Asset streaming failed: " .. tostring(streamError))
			end
		end)

		local service = require(game.ServerScriptService.Services.RNGMachineService)
		script:SetAttribute("Status", "Required")
		service:Start()
		script:SetAttribute("Status", service.DebugStatus)
	end, debug.traceback)
	if not ok then
		script:SetAttribute("Status", "Failed")
		script:SetAttribute("Error", tostring(err))
		warn("[RNGMachineBootstrap] " .. tostring(err))
	end
end)
