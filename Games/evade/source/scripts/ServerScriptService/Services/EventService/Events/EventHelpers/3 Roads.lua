local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local MapManipulation = {
	initialized = false;
}

local threeRoadsModel = nil

local OBJECT_CONFIGS = {
	{ path = Workspace.Events["Festive Lucky Block"].Model, newPos = CFrame.new(-453.646, -9.5, 12.906) * CFrame.Angles(0, math.pi, 0) },
	{ path = Workspace.EventBoard, newPos = CFrame.new(-454.567, -3.503, 30.427) * CFrame.Angles(0, math.pi, 0) },
	{ path = workspace.FuseMachine, newPos = CFrame.new(-360.95, -9, 85.805) * CFrame.Angles(0, math.pi, 0) },
}

local originalPivots = {}

local function saveAndMoveObjects()
	for i, config in OBJECT_CONFIGS do
		originalPivots[i] = config.path:GetPivot()
		config.path:PivotTo(config.newPos)
	end
end

local function restoreObjects()
	for i, config in OBJECT_CONFIGS do
		local originalPivot = originalPivots[i]
		if originalPivot then
			config.path:PivotTo(originalPivot)
		end
	end
end

function MapManipulation.Start(player)
	if MapManipulation.initialized then
		return
	end

	MapManipulation.initialized = true

	if threeRoadsModel then
		threeRoadsModel:Destroy()
	end

	restoreObjects()
	saveAndMoveObjects()

	local eventModel = script["3 Roads"]:Clone()
	eventModel.Parent = Workspace.Map
	threeRoadsModel = eventModel

	ReplicatedStorage:SetAttribute("3RoadsEvent", true)
end

function MapManipulation.Stop(player)
	MapManipulation.initialized = false

	if threeRoadsModel then
		threeRoadsModel:Destroy()
		threeRoadsModel = nil
	end

	restoreObjects()

	ReplicatedStorage:SetAttribute("3RoadsEvent", nil)
end

return MapManipulation