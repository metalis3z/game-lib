local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Shared.EventTypes)
local PhantomEventController = {}
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local Observers = require(ReplicatedStorage.Packages.Observers)
local scriptName = script.Name
local trove = Trove.new()
local whiteColor = Color3.fromRGB(255, 255, 255)
local originalCaveColors = nil
local function getCaveParts()
	local Map = workspace:FindFirstChild("Map")
	local cave = Map and Map:FindFirstChild("Cave")
	local collisions = cave and cave:FindFirstChild("Collisions")
	if not collisions then
		return nil
	end
	local parts = collisions:QueryDescendants("BasePart")
	if #parts == 0 then
		return nil
	end
	return parts
end
function PhantomEventController.OnStart(_)
	assert((EventController:GetActiveEventData(scriptName)))
	EffectController:Activate("Blink")
	trove:Add(function()
		EffectController:Activate("Blink")
	end)
	EffectController:Run("PhantomEvent", "GrassRecolor")
	trove:Add(function()
		EffectController:Stop("PhantomEvent", "GrassRecolor")
	end)
	EffectController:Run("PhantomEvent", "WallRecolor")
	trove:Add(function()
		EffectController:Stop("PhantomEvent", "WallRecolor")
	end)
	EffectController:Run("PhantomEvent", "WallBottomRecolor")
	trove:Add(function()
		EffectController:Stop("PhantomEvent", "WallBottomRecolor")
	end)
	trove:Add(Observers.observeTag("HideInPhantom", function(instance)
		local originalParent = instance.Parent
		instance.Parent = script
		return function()
			pcall(function()
				instance.Parent = originalParent
			end)
		end
	end, {
		workspace,
		script
	}))
	local PhantomAtmosphere = script:FindFirstChild("PhantomAtmosphere")
	if PhantomAtmosphere then
		local Atmosphere = Lighting:FindFirstChild("Atmosphere")
		if Atmosphere then
			Atmosphere.Parent = script
			trove:Add(function()
				Atmosphere.Parent = Lighting
			end)
		end
		trove:Clone(PhantomAtmosphere).Parent = Lighting
	end
	local PhantomSky = script:FindFirstChild("PhantomSky")
	if PhantomSky then
		local originalSky = Lighting:FindFirstChild("Cartoon") or Lighting:FindFirstChildOfClass("Sky")
		if originalSky then
			originalSky.Parent = script
			trove:Add(function()
				originalSky.Parent = Lighting
			end)
		end
		trove:Clone(PhantomSky).Parent = Lighting
	end
	if not ServerData.IsTsunamiServer() then
		local PhantomMap = script:FindFirstChild("PhantomMap")
		if PhantomMap then
			trove:Clone(PhantomMap).Parent = workspace
		end
	end
	local caveFlashCounter = 0
	local function restoreCave()
		local caveColors = originalCaveColors
		if not caveColors then
			return
		end
		for part, color in caveColors do
			if part.Parent then
				part.Color = color
			end
		end
	end
	trove:Add(Net:RemoteEvent("GameService/PhantomCaveFlash").OnClientEvent:Connect(function()
		caveFlashCounter += 1
		local currentFlashId = caveFlashCounter
		task.spawn(function()
			local caveParts = getCaveParts()
			if not caveParts then
				warn("No cave parts found for flash effect")
				return
			end
			if not originalCaveColors then
				local colorTable = {}
				for _, part in caveParts do
					colorTable[part] = part.Color
				end
				originalCaveColors = colorTable
			end
			assert(originalCaveColors)
			local originalColors = originalCaveColors
			local function stillActive()
				return currentFlashId == caveFlashCounter
			end
			local startTime = os.clock()
			while currentFlashId == caveFlashCounter do
				local elapsedTime = os.clock() - startTime
				if elapsedTime >= 2 then
					break
				end
				local lerpAlpha = (1 - math.cos(elapsedTime / 2 * 3.141592653589793 * 2 * 2)) / 2
				for _, part in caveParts do
					local originalColor = originalColors[part]
					if originalColor then
						part.Color = originalColor:Lerp(whiteColor, lerpAlpha)
					end
				end
				RunService.Heartbeat:Wait()
			end
			if currentFlashId == caveFlashCounter then
				local caveColors = originalCaveColors
				if not caveColors then
					return
				end
				for part, color in caveColors do
					if part.Parent then
						part.Color = color
					end
				end
			end
		end)
	end))
	trove:Add(function()
		caveFlashCounter += 1
		local caveColors = originalCaveColors
		if not caveColors then
			return
		end
		for part, color in caveColors do
			if part.Parent then
				part.Color = color
			end
		end
	end)
	CycleController:Update()
end
function PhantomEventController.OnStop(_)
	trove:Destroy()
	CycleController:Update()
end
function PhantomEventController.OnLoad(_)
end
return PhantomEventController