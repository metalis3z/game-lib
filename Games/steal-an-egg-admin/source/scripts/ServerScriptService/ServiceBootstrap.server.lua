--!strict
local ServerScriptService = game:GetService("ServerScriptService")

local SERVICE_ORDER = {
	"DataService",
	"TutorialService",
	"PlotService",
	"CodesService",
	"AdminPanelService",
	"AreaEggService",
	"PenService",
	"HomesteadService",
	"TreadmillService",
	"EarningService",
}

local loadedServices = {}

for _, serviceName in SERVICE_ORDER do
	local module = ServerScriptService:FindFirstChild(serviceName)
	if not module or not module:IsA("ModuleScript") then
		warn(`[ServiceBootstrap] Service '{serviceName}' not found, skipping.`)
		continue
	end

	local ok, result = pcall(require, module)
	if not ok then
		warn(`[ServiceBootstrap] Failed to require '{serviceName}': {result}`)
		continue
	end

	loadedServices[serviceName] = result
	print(`[ServiceBootstrap] Loaded service '{serviceName}'.`)
end

for _, serviceName in SERVICE_ORDER do
	local service = loadedServices[serviceName]
	if service and type(service.Init) == "function" then
		local ok, err = pcall(service.Init)
		if not ok then
			warn(`[ServiceBootstrap] Error in '{serviceName}.Init': {err}`)
		else
			print(`[ServiceBootstrap] Initialized '{serviceName}'.`)
		end
	end
end

for _, serviceName in SERVICE_ORDER do
	local service = loadedServices[serviceName]
	if service and type(service.Start) == "function" then
		local ok, err = pcall(service.Start)
		if not ok then
			warn(`[ServiceBootstrap] Error in '{serviceName}.Start': {err}`)
		else
			print(`[ServiceBootstrap] Started '{serviceName}'.`)
		end
	end
end