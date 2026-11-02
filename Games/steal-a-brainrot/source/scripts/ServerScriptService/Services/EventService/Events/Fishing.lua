local Fishing = {}

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TargetPosition = Vector3.new(-382.375, -10, 14.715)
local TargetOrientation = Vector3.new(0, 0, 0)

local OriginalPivot = nil

local function GetFishingModel()
	return workspace.Events.Fishing:WaitForChild("Model")
end

function Fishing.OnStart(EventData)
	if not EventData or not EventData.endsAt then
		return
	end

	local FishingModel = GetFishingModel()

	ReplicatedStorage:SetAttribute("FishingEvent", true)
	FishingModel:SetAttribute("Hidden", false)

	OriginalPivot = FishingModel:GetPivot()

	local RotationCFrame = CFrame.Angles(math.rad(TargetOrientation.X), math.rad(TargetOrientation.Y), math.rad(TargetOrientation.Z))

	FishingModel:PivotTo(CFrame.new(TargetPosition) * RotationCFrame)
end

function Fishing.OnStop()
	local FishingModel = GetFishingModel()

	ReplicatedStorage:SetAttribute("FishingEvent", false)
	ReplicatedStorage:SetAttribute("FishingEvent", nil)

	FishingModel:SetAttribute("Hidden", true)

	if OriginalPivot then
		FishingModel:PivotTo(OriginalPivot)
	end
end

return Fishing