--[[
	KnitClient — Client-side Knit framework implementation
	Rewritten from scratch (decompiled version was completely broken)
]]

local Players = game:GetService("Players")

local Packages = script.Parent.Parent -- ReplicatedStorage.Packages
local Promise = require(Packages.Promise)
local ClientComm = require(Packages.Comm).ClientComm

local KnitClient = {}
KnitClient.Player = Players.LocalPlayer
KnitClient.Util = Packages

local controllers = {} -- [name] = controllerDef
local services = {} -- [name] = serviceProxy (cached)
local started = false
local startedComplete = false
local onStartComplete = Instance.new("BindableEvent")

local options = {
	ServicePromises = true,
	Middleware = nil,
	PerServiceMiddleware = {},
}

function KnitClient.CreateController(controllerDef)
	assert(type(controllerDef) == "table", "Controller must be a table; got " .. type(controllerDef))
	assert(type(controllerDef.Name) == "string", "Controller.Name must be a string; got " .. type(controllerDef.Name))
	assert(#controllerDef.Name > 0, "Controller.Name must not be empty")
	assert(not started, 'Controllers cannot be created after calling "Knit.Start()"')
	assert(controllers[controllerDef.Name] == nil, 'Controller "' .. controllerDef.Name .. '" already exists')
	controllers[controllerDef.Name] = controllerDef
	return controllerDef
end

function KnitClient.AddControllers(parent)
	assert(not started, 'Controllers cannot be added after calling "Knit.Start()"')
	local added = {}
	for _, child in parent:GetChildren() do
		if child:IsA("ModuleScript") then
			local ok, result = pcall(require, child)
			if ok then
				table.insert(added, result)
			else
				warn("[Knit] Failed to require controller " .. child.Name .. ": " .. tostring(result))
			end
		end
	end
	return added
end

function KnitClient.AddControllersDeep(parent)
	assert(not started, 'Controllers cannot be added after calling "Knit.Start()"')
	local added = {}
	for _, descendant in parent:GetDescendants() do
		if descendant:IsA("ModuleScript") then
			local ok, result = pcall(require, descendant)
			if ok then
				table.insert(added, result)
			else
				warn("[Knit] Failed to require controller " .. descendant.Name .. ": " .. tostring(result))
			end
		end
	end
	return added
end

function KnitClient.GetService(serviceName)
	local cached = services[serviceName]
	if cached then
		return cached
	end
	assert(started, "Cannot call GetService until Knit has been started")
	assert(type(serviceName) == "string", "ServiceName must be a string; got " .. type(serviceName))

	local servicesFolder = script.Parent:FindFirstChild("Services")
	if not servicesFolder then
		servicesFolder = script.Parent:WaitForChild("Services", 10)
	end
	assert(servicesFolder, "Could not find Services folder")

	local middleware = options.PerServiceMiddleware[serviceName] or options.Middleware
	local inbound = middleware and middleware.Inbound or nil
	local outbound = middleware and middleware.Outbound or nil

	local comm = ClientComm.new(servicesFolder, options.ServicePromises, serviceName)
	local serviceObj = comm:BuildObject(inbound, outbound)
	services[serviceName] = serviceObj
	return serviceObj
end

function KnitClient.GetController(controllerName)
	local controller = controllers[controllerName]
	if controller then
		return controller
	end
	assert(started, "Cannot call GetController until Knit has been started")
	assert(type(controllerName) == "string", "ControllerName must be a string; got " .. type(controllerName))
	error('Could not find controller "' .. controllerName .. '". Check to verify a controller with this name exists.', 2)
end

function KnitClient.GetControllers()
	assert(started, "Cannot call GetControllers until Knit has been started")
	return controllers
end

function KnitClient.Start(opts)
	if started then
		return Promise.reject("Knit already started")
	end
	started = true

	if opts then
		if opts.ServicePromises ~= nil then
			options.ServicePromises = opts.ServicePromises
		end
		if opts.Middleware then
			options.Middleware = opts.Middleware
		end
		if opts.PerServiceMiddleware then
			options.PerServiceMiddleware = opts.PerServiceMiddleware
		end
	end

	return Promise.new(function(resolve)
		-- KnitInit phase
		print("[KnitClient] Starting KnitInit phase, controllers:", #controllers)
		local count = 0
		for name, _ in controllers do
			count += 1
		end
		print("[KnitClient] Total controllers:", count)
		for name, controller in controllers do
			if type(controller.KnitInit) == "function" then
				print("[KnitClient] KnitInit ->", name)
				local ok, err = pcall(controller.KnitInit, controller)
				if not ok then
					warn("[Knit] KnitInit failed for " .. name .. ": " .. tostring(err))
				else
					print("[KnitClient] KnitInit OK:", name)
				end
			end
		end
		print("[KnitClient] KnitInit phase complete, starting KnitStart phase")

		-- KnitStart phase (parallel via task.spawn)
		for name, controller in controllers do
			if type(controller.KnitStart) == "function" then
				task.spawn(function()
					local ok, err = pcall(controller.KnitStart, controller)
					if not ok then
						warn("[Knit] KnitStart failed for " .. name .. ": " .. tostring(err))
					end
				end)
			end
		end

		startedComplete = true
		onStartComplete:Fire()
		resolve()
	end)
end

function KnitClient.OnStart()
	if startedComplete then
		return Promise.resolve()
	end
	return Promise.fromEvent(onStartComplete.Event)
end

return KnitClient
