--[[
	ServerBootstrap — Main server entry point
	Loads all Knit services and starts the server framework
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Require Knit (this returns KnitServer on the server side)
local Knit = require(ReplicatedStorage.Packages.Knit)

print("[ServerBootstrap] Loading services...")

-- Load all service modules from ServerScriptService.Services
-- Each module calls Knit.CreateService() when required
local ServicesFolder = ServerScriptService:WaitForChild("Services")
for _, child in ServicesFolder:GetChildren() do
	if child:IsA("ModuleScript") then
		local success, err = pcall(function()
			require(child)
		end)
		if success then
			print("[ServerBootstrap] Loaded:", child.Name)
		else
			warn("[ServerBootstrap] FAILED to load", child.Name, ":", err)
		end
	end
end

print("[ServerBootstrap] All services loaded. Starting Knit...")

-- Start Knit (initializes all services: KnitInit → KnitStart)
Knit.Start()

print("[ServerBootstrap] Knit started successfully!")
print("[ServerBootstrap] Server Version:", game.PlaceVersion)
