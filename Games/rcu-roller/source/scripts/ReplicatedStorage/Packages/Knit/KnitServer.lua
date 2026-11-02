--[[
	KnitServer — Server-side Knit framework implementation
	Recreated for server rewrite (original was destroyed by client decompiler)
	
	FIX: Signal/property markers are snapshot at CreateService time, before
	service modules can overwrite them with handler functions (e.g.
	function Service.Client:signalName(player, ...) overwrites the marker).
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Packages = script.Parent.Parent -- ReplicatedStorage.Packages
local Signal = require(Packages.Signal)
local Comm = require(Packages.Comm)
local ServerComm = Comm.ServerComm

local ServicesFolder = script.Parent:FindFirstChild("Services")
if not ServicesFolder then
	ServicesFolder = Instance.new("Folder")
	ServicesFolder.Name = "Services"
	ServicesFolder.Parent = script.Parent
end

-- Clean up obfuscated service folders (decompiler artifacts with unreadable names)
for _, child in ServicesFolder:GetChildren() do
	if child:IsA("Folder") then
		local name = child.Name
		if string.find(name, "jag") or string.find(name, "känner") or string.find(name, "heter") or #name > 60 then
			child:Destroy()
		end
	end
end

local Services = {} -- [name] = serviceObject
local Started = false
local StartedComplete = false
local OnStartSignal = Signal.new()

local KnitServer = {}
KnitServer.Player = nil
KnitServer.Util = Packages

function KnitServer.CreateService(serviceDef)
	assert(type(serviceDef) == "table", "Service definition must be a table")
	assert(type(serviceDef.Name) == "string" and #serviceDef.Name > 0, "Service must have a non-empty Name")
	assert(not Services[serviceDef.Name], "Service already exists: " .. serviceDef.Name)
	assert(not Started, "Cannot create services after Knit has started")

	serviceDef.Client = serviceDef.Client or {}
	serviceDef.Client.Server = serviceDef

	-- Snapshot signal/property markers NOW, before the module can overwrite them
	-- with handler functions (function Service.Client:signalName(...) overwrites the marker)
	serviceDef._signalMarkers = {}
	serviceDef._propertyMarkers = {}
	for key, value in serviceDef.Client do
		if type(value) == "table" then
			if value._isRemoteSignal then
				serviceDef._signalMarkers[key] = value
			elseif value._isRemoteProperty then
				serviceDef._propertyMarkers[key] = value
			end
		end
	end

	Services[serviceDef.Name] = serviceDef
	return serviceDef
end

function KnitServer.AddServices(folder)
	assert(not Started, "Cannot add services after Knit has started")
	for _, child in folder:GetChildren() do
		if child:IsA("ModuleScript") then
			require(child)
		end
	end
end

function KnitServer.AddServicesDeep(folder)
	assert(not Started, "Cannot add services after Knit has started")
	for _, child in folder:GetDescendants() do
		if child:IsA("ModuleScript") then
			require(child)
		end
	end
end

function KnitServer.GetService(serviceName)
	assert(type(serviceName) == "string", "Service name must be a string")
	local service = Services[serviceName]
	assert(service, "Service not found: " .. serviceName)
	return service
end

function KnitServer.Start()
	assert(not Started, "Knit already started")
	Started = true

	-- Phase 1: Set up Comm for each service (create/reuse folders, bind RF/RE/RP)
	for name, service in Services do
		-- Remove existing folder if present (to avoid ServerComm assert conflict)
		local existingFolder = ServicesFolder:FindFirstChild(name)
		if existingFolder then
			existingFolder:Destroy()
		end

		-- Create fresh ServerComm for this service
		local ok, commOrErr = pcall(ServerComm.new, ServicesFolder, name)
		if not ok then
			warn("[KnitServer] ServerComm.new FAILED for", name, ":", commOrErr)
			continue
		end
		local comm = commOrErr
		service._comm = comm
		service._knit_re = {}
		service._knit_rp = {}

		-- Collect all Client keys (excluding Server back-ref and internal fields)
		local clientKeys = {}
		for key in service.Client do
			if key ~= "Server" then
				clientKeys[key] = true
			end
		end
		-- Also include keys from saved markers (in case they were completely removed)
		for key in service._signalMarkers do
			clientKeys[key] = true
		end
		for key in service._propertyMarkers do
			clientKeys[key] = true
		end

		-- Wire up Client table using saved markers to distinguish signals from functions
		for key in clientKeys do
			local value = service.Client[key]

			if service._signalMarkers[key] then
				-- This key was originally a signal marker (may have been overwritten by handler fn)
				local marker = service._signalMarkers[key]
				local unreliable = marker._unreliable or false
				local handler = type(value) == "function" and value or nil

				local ok2, signalOrErr = pcall(comm.CreateSignal, comm, key, unreliable)
				if ok2 then
					service.Client[key] = signalOrErr
					service._knit_re[key] = signalOrErr
					-- If the module defined a handler function with the same name, connect it
					if handler then
						signalOrErr:Connect(function(player, ...)
							handler(service.Client, player, ...)
						end)
					end
				else
					warn("[KnitServer] CreateSignal FAILED:", name, key, signalOrErr)
				end

			elseif service._propertyMarkers[key] then
				-- This key was originally a property marker
				local marker = service._propertyMarkers[key]
				local ok2, propOrErr = pcall(comm.CreateProperty, comm, key, marker._initialValue)
				if ok2 then
					service.Client[key] = propOrErr
					service._knit_rp[key] = propOrErr
				else
					warn("[KnitServer] CreateProperty FAILED:", name, key, propOrErr)
				end

			elseif type(value) == "function" then
				-- Pure function (never was a signal/property marker)
				local ok2, err2 = pcall(comm.WrapMethod, comm, service.Client, key)
				if not ok2 then
					warn("[KnitServer] WrapMethod FAILED:", name, key, err2)
				end
			end
		end
	end
	print("[KnitServer] Phase 1 complete — Comm set up for all services")

	-- Phase 2: KnitInit on all services
	for name, service in Services do
		if type(service.KnitInit) == "function" then
			local ok, err = pcall(service.KnitInit, service)
			if not ok then
				warn("[KnitServer] KnitInit FAILED for", name, ":", err)
			end
		end
	end
	print("[KnitServer] Phase 2 complete — KnitInit done")

	-- Phase 3: KnitStart on all services (parallel via task.spawn)
	local startCount = 0
	local totalStarts = 0
	for _, service in Services do
		if type(service.KnitStart) == "function" then
			totalStarts += 1
		end
	end

	if totalStarts == 0 then
		StartedComplete = true
		OnStartSignal:Fire()
		return
	end

	for name, service in Services do
		if type(service.KnitStart) == "function" then
			task.spawn(function()
				local ok, err = pcall(service.KnitStart, service)
				if not ok then
					warn("[KnitServer] KnitStart FAILED for", name, ":", err)
				end
				startCount += 1
				if startCount >= totalStarts then
					StartedComplete = true
					OnStartSignal:Fire()
					print("[KnitServer] Phase 3 complete — all services started")
				end
			end)
		end
	end
end

function KnitServer.OnStart()
	if StartedComplete then return end
	OnStartSignal:Wait()
end

-- Helper constructors for service definitions
function KnitServer.CreateSignal(unreliable)
	return { _isRemoteSignal = true, _unreliable = unreliable or false }
end

function KnitServer.CreateProperty(initialValue)
	return { _isRemoteProperty = true, _initialValue = initialValue }
end

-- Expose useful references
KnitServer.Services = Services
KnitServer.Shared = game:GetService("ReplicatedStorage"):FindFirstChild("Shared")

return KnitServer
