local Event3Roads = {}

local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local CollectionService  = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local Trove = require(ReplicatedStorage.Packages.Trove)

local isActive = false
local eventTrove = nil

local MAP_STORAGE = script:FindFirstChild("3 Roads")

local shops        = workspace:FindFirstChild("Shop")
local stock        = workspace:FindFirstChild("AdventCalendar")
local spin         = workspace:FindFirstChild("PhantomSpinWheel")
local robux        = workspace:FindFirstChild("RobuxShop")
local eventBoard   = workspace:FindFirstChild("")
local festiveBlock = workspace:FindFirstChild("Events")
	and workspace.Events:FindFirstChild("Festive Block")
	and workspace.Events["Festive Block"]:FindFirstChild("Model")
local laJolly      = workspace:FindFirstChild("")
	and workspace.Events:FindFirstChild("Winter Hour Stock")
	and workspace.Events["Winter Hour Stock"]:FindFirstChild("")
local codes        = workspace:FindFirstChild("LiveBoard")
local stealboard   = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("StealsBoard")
local generation   = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("GenerationBoard")
local santafuse    = workspace:FindFirstChild("FuseMachine")
local trade        = workspace:FindFirstChild("TradeMachine")
local adminboard   = workspace:FindFirstChild("")
local backrooms    = workspace:FindFirstChild("Events") and workspace.Events:FindFirstChild("")

local BACKROOMS_DEFAULT_POS = Vector3.new(-378.455, -5, 12.322)
local BACKROOMS_EVENT_POS   = Vector3.new(-367.755, -5, 23.906)

local function setupModel1Hiding(trove)
	local mapFolder = workspace:FindFirstChild("Map")
	if not mapFolder then return end

	local model1 = mapFolder:FindFirstChild("Model1")
	if not model1 then return end

	local transparencyData = {}

	for _, descendant in ipairs(model1:GetDescendants()) do
		if descendant:IsA("BasePart") then
			transparencyData[descendant] = {
				Transparency = descendant.Transparency,
				CanCollide   = descendant.CanCollide,
			}
			descendant.Transparency = 1
			descendant.CanCollide   = false
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			transparencyData[descendant] = {Transparency = descendant.Transparency}
			descendant.Transparency = 1
		end
	end

	trove:Add(function()
		if not model1 or not model1.Parent then return end
		for descendant, properties in pairs(transparencyData) do
			if descendant and descendant.Parent then
				if descendant:IsA("BasePart") then
					descendant.Transparency = properties.Transparency
					descendant.CanCollide   = properties.CanCollide
				elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
					descendant.Transparency = properties.Transparency
				end
			end
		end
	end)
end

local function moveObject(obj, targetPos, targetRot, originalCFrames)
	if not obj then return end

	local currentPivot = obj:GetPivot()
	originalCFrames[obj] = currentPivot

	local newCF = CFrame.new(targetPos)
	if targetRot then
		newCF = newCF * CFrame.Angles(
			math.rad(targetRot.X),
			math.rad(targetRot.Y),
			math.rad(targetRot.Z)
		)
	else
		newCF = newCF * (currentPivot - currentPivot.Position)
	end
	obj:PivotTo(newCF)
end

local function moveBackroomsToEventPosition()
	if not backrooms then return end
	local currentPivot = backrooms:GetPivot()
	local newCF = CFrame.new(BACKROOMS_EVENT_POS) * (currentPivot - currentPivot.Position)
	backrooms:PivotTo(newCF)
end

local function moveBackroomsToDefaultPosition()
	if not backrooms then return end
	local currentPivot = backrooms:GetPivot()
	local newCF = CFrame.new(BACKROOMS_DEFAULT_POS) * (currentPivot - currentPivot.Position)
	backrooms:PivotTo(newCF)
end

local function setupBackroomsHandling(trove)
	if not backrooms then return end

	local connection = ReplicatedStorage:GetAttributeChangedSignal("BackroomsEvent"):Connect(function()
		if not isActive then return end

		if ReplicatedStorage:GetAttribute("BackroomsEvent") then
			moveBackroomsToEventPosition()
		end
	end)

	trove:Add(connection)

	if ReplicatedStorage:GetAttribute("BackroomsEvent") then
		moveBackroomsToEventPosition()
	end

	trove:Add(function()
		if ReplicatedStorage:GetAttribute("BackroomsEvent") then
			moveBackroomsToDefaultPosition()
		end
	end)
end

function Event3Roads.OnStart()
	if isActive then return end
	isActive = true

	eventTrove = Trove.new()

	ReplicatedStorage:SetAttribute("3RoadsEvent", true)
	eventTrove:Add(function()
		ReplicatedStorage:SetAttribute("3RoadsEvent", false)
	end)

	setupModel1Hiding(eventTrove)

	if MAP_STORAGE then
		local mapInstance = MAP_STORAGE:Clone()
		mapInstance.Parent = workspace
		CollectionService:AddTag(mapInstance, "3 Roads")

		eventTrove:Add(mapInstance)
		eventTrove:Add(function()
			if mapInstance.Parent then
				CollectionService:RemoveTag(mapInstance, "3 Roads")
			end
		end)
	end

	local originalCFrames = {}

	moveObject(festiveBlock, Vector3.new(-451.717, -9.5,   14.582), nil, originalCFrames)
	moveObject(eventBoard,   Vector3.new(-450.015, -0.374,  31.015), nil, originalCFrames)
	moveObject(stock,        Vector3.new(-460.502, -3.5,    86.795), nil, originalCFrames)
	moveObject(robux,        Vector3.new(-454.132, -5,      53.406), nil, originalCFrames)
	moveObject(shops,        Vector3.new(-367.755, -5,      53.406), nil, originalCFrames)
	moveObject(santafuse,    Vector3.new(-363.75,  -9.5,  85.805), nil, originalCFrames)
	moveObject(spin,         Vector3.new(-451.404, -4.629,  75.028), nil, originalCFrames)
	if trade      then moveObject(trade,      Vector3.new(-453.202, -3.5,   95.995),  nil, originalCFrames) end
	if laJolly    then moveObject(laJolly,    Vector3.new(-368.862, -3.317,  1.022),  nil, originalCFrames) end
	if generation then moveObject(generation, Vector3.new(-460.641,  4.75,  258.906), nil, originalCFrames) end
	if stealboard then moveObject(stealboard, Vector3.new(-362.285,  4.75,  258.906), nil, originalCFrames) end
	if codes      then moveObject(codes,      Vector3.new(-353.952,  4.25, -138.594), nil, originalCFrames) end
	if adminboard then moveObject(adminboard, Vector3.new(-453, -9.85, 25.636),       nil, originalCFrames) end

	setupBackroomsHandling(eventTrove)

	eventTrove:Add(function()
		for obj, oldCF in pairs(originalCFrames) do
			if obj and obj.Parent then
				obj:PivotTo(oldCF)
			end
		end
	end)

	eventTrove:Add(function()
		for _, model in ipairs(CollectionService:GetTagged("EventAnimal")) do
			if model:GetAttribute("EventRoad") ~= nil and model.Parent then
				model:Destroy()
			end
		end
	end)

	eventTrove:Add(function()
		AnimalService.ResetThreeRoadsData()
	end)

	AnimalService.ResetThreeRoadsData()

end

function Event3Roads.OnStop()
	if not isActive then return end
	isActive = false

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end
end

return Event3Roads