--[[

This is where MainModule startup is handled from
For details on how HD Admin's framework works, see 'Framework' under Modules

--]]


-- LOCAL
-- This lookup must never be able to stop a v1 game booting, so any failure just
-- leaves version nil and remote v2 loaders fall back to their bundled copy
local MainModule = {}
local versionSuccess, appVersion = pcall(function()
	return require(script.Value.Controllers.UI.Config.VERSION).appVersion
end)


-- PUBLIC
MainModule.supportsV2 = true
MainModule.version = if versionSuccess then appVersion else nil


-- FUNCTIONS
function MainModule.initialize(loader, handshake)
	local isV2Loader = type(handshake) == "table" and handshake.app == "v2"
	if not isV2Loader then
		-- If not isV2Loader then this is a v1 caller and it only requires v1 code
		local v1Container = script:FindFirstChild("v1")
		local v1MainModule = v1Container and v1Container:FindFirstChild("MainModule")
		if not v1MainModule then
			error("HD Admin: this copy does not include v1. Install the official loader from create.roblox.com/store/asset/857927023")
		end
		return require(v1MainModule).initialize(loader)
	end

	-- We destroy the spare MainModule otherwise it replicates a second copy to every client
	local loaderCore = loader and loader:FindFirstChild("Core")
	local bundledSpare = if loaderCore then loaderCore:FindFirstChild("MainModule") else nil
	if bundledSpare and bundledSpare ~= script then
		bundledSpare:Destroy()
	end

	-- v1 is not needed on the v2 path and would replicate to every client once the
	-- framework moves this module into ReplicatedStorage, so we drop it before then
	local v1Container = script:FindFirstChild("v1")
	if v1Container then
		v1Container:Destroy()
	end

	local Framework = require(script.Value.Modules.Framework)
	return Framework.initialize(loader, handshake)
end


return MainModule
