local Cyber = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local EventController = require(ReplicatedStorage.Controllers.EventController)
local ServerData = require(ReplicatedStorage.Datas.ServerData)

local isActive = false
local cyberMap = nil
local originalAtmosphere = nil
local originalSky = nil
local atmosphereCyber = nil
local skyCyber = nil

function Cyber.OnStart()
	if isActive then return end
	isActive = true
	
	print("[CyberEvent] Started")
	
	-- Set attribute
	ReplicatedStorage:SetAttribute("CyberEvent", true)
	
	-- Get the Cyber event module from EventController
	local cyberEventModule = ReplicatedStorage.Controllers.EventController.Events:FindFirstChild("Cyber")
	if not cyberEventModule then
		warn("[CyberEvent] Cyber event module not found in EventController")
		return
	end
	
	-- Load the map
	local mapToUse = cyberEventModule.CyberMap
	if ServerData.IsBiggerServer and ServerData.IsBiggerServer() then
		mapToUse = cyberEventModule.BiggerCyberMap
	end
	
	if mapToUse then
		cyberMap = mapToUse:Clone()
		cyberMap.Parent = Workspace
		print("[CyberEvent] Map loaded")
	end
	
	-- Handle Atmosphere
	originalAtmosphere = Lighting:FindFirstChild("Atmosphere")
	if originalAtmosphere then
		originalAtmosphere.Parent = cyberEventModule
	end
	
	if cyberEventModule:FindFirstChild("AtmosphereCyber") then
		atmosphereCyber = cyberEventModule.AtmosphereCyber:Clone()
		atmosphereCyber.Parent = Lighting
		print("[CyberEvent] Atmosphere loaded")
	end
	
	-- Handle Sky
	originalSky = Lighting:FindFirstChild("Cartoon")
	if originalSky then
		originalSky.Parent = cyberEventModule
	end
	
	if cyberEventModule:FindFirstChild("SkyCyber") then
		skyCyber = cyberEventModule.SkyCyber:Clone()
		skyCyber.Parent = Lighting
		print("[CyberEvent] Sky loaded")
	end
end

function Cyber.OnStop()
	if not isActive then return end
	isActive = false
	
	print("[CyberEvent] Stopped")
	
	-- Remove attribute
	ReplicatedStorage:SetAttribute("CyberEvent", false)
	ReplicatedStorage:SetAttribute("CyberEvent", nil)
	
	-- Set last time for wheel
	ReplicatedStorage:SetAttribute("CyberEventLastTime", os.time())
	
	-- Remove the map

	if cyberMap then
		cyberMap:Destroy()
		cyberMap = nil
		print("[CyberEvent] Map removed")
	end
	
	-- Restore Atmosphere
	if atmosphereCyber then
		atmosphereCyber:Destroy()
		atmosphereCyber = nil
	end
	
	local cyberEventModule = ReplicatedStorage.Controllers.EventController.Events:FindFirstChild("Cyber")
	if originalAtmosphere and cyberEventModule then
		originalAtmosphere.Parent = Lighting
		originalAtmosphere = nil
		print("[CyberEvent] Atmosphere restored")
	end
	
	-- Restore Sky
	if skyCyber then
		skyCyber:Destroy()
		skyCyber = nil
	end
	
	if originalSky and cyberEventModule then
		originalSky.Parent = Lighting
		originalSky = nil
		print("[CyberEvent] Sky restored")
	end
end

return Cyber