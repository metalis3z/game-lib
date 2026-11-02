local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)

local bulkMoveCount = 0
local bulkMoveParts = {}
local bulkMoveCFrames = {}

local CARPET_ZONE_C_FRAME = CFrame.new(-410.752, -9.782, 59.406):Inverse()

local isThreeRoadsEvent = ReplicatedStorage:GetAttribute("3RoadsEvent")
ReplicatedStorage:GetAttributeChangedSignal("3RoadsEvent"):Connect(function()
	isThreeRoadsEvent = ReplicatedStorage:GetAttribute("3RoadsEvent")
end)

local function pushPartCFrame(part, cframe)
	bulkMoveCount = bulkMoveCount + 1
	bulkMoveParts[bulkMoveCount] = part
	bulkMoveCFrames[bulkMoveCount] = cframe
end

local function isPointInCarpet(position)
	if isThreeRoadsEvent then
		return MathUtils.isPointInVolume_direct(position, CARPET_ZONE_C_FRAME, Vector3.new(68, 661.5, 401))
	else
		return MathUtils.isPointInVolume_direct(position, CARPET_ZONE_C_FRAME, Vector3.new(20, 661.5, 401))
	end
end

local function isPointInCarpetHalf(position)
	if isThreeRoadsEvent then
		return MathUtils.isPointInVolume_direct(position, CARPET_ZONE_C_FRAME, Vector3.new(34, 661.5, 200.5))
	else
		return MathUtils.isPointInVolume_direct(position, CARPET_ZONE_C_FRAME, Vector3.new(10, 661.5, 200.5))
	end
end

local function onStepParts()
	debug.profilebegin("SharedEventUtils:StepParts")
	
	workspace:BulkMoveTo(bulkMoveParts, bulkMoveCFrames, Enum.BulkMoveMode.FireCFrameChanged)
	
	bulkMoveCount = 0
	table.clear(bulkMoveParts)
	table.clear(bulkMoveCFrames)
	
	debug.profileend()
end

local function loadAnimation(trove, animator, animation)
	local track = animator:LoadAnimation(animation)
	
	local function cleanup()
		track:Stop(0)
		track:Destroy()
	end
	
	trove:Add(cleanup)
	
	return track, function()
		trove:Remove(cleanup)
	end
end

if RunService:IsServer() then
	RunService.PostSimulation:Connect(onStepParts)
else
	RunService.PreRender:Connect(onStepParts)
end

return {
	["pushPartCFrame"] = pushPartCFrame,
	["isPointInCarpet"] = isPointInCarpet,
	["isPointInCarpetHalf"] = isPointInCarpetHalf,
	["loadAnimation"] = loadAnimation
}