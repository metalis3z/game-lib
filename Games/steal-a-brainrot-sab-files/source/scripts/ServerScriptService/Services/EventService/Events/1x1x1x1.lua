local Event = {}

local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")

local Trove = require(game:GetService("ReplicatedStorage").Packages.Trove)

local isActive = false
local MAP_TAG = "1x1x1x1Map"
local HIDE_TAG = "HideIn1x1x1x1Server"

local MapTemplate = script:FindFirstChild("1x1x1x1Map")
local spawnedMap = nil
local trove = nil
local hiddenInstances = {}

local function hideInstance(instance)
	if not trove then
		return
	end

	if hiddenInstances[instance] then
		return
	end

	if not instance:IsDescendantOf(Workspace) then
		return
	end

	local originalParent = instance.Parent
	if not originalParent then
		return
	end

	hiddenInstances[instance] = true
	instance.Parent = script

	trove:Add(function()
		hiddenInstances[instance] = nil

		if originalParent and originalParent.Parent ~= nil then
			pcall(function()
				instance.Parent = originalParent
			end)
		end
	end)
end

function Event.OnStart()
	if isActive then
		return
	end
	isActive = true

	trove = Trove.new()
	hiddenInstances = {}

	for _, instance in CollectionService:GetTagged(HIDE_TAG) do
		hideInstance(instance)
	end

	trove:Connect(CollectionService:GetInstanceAddedSignal(HIDE_TAG), function(instance)
		hideInstance(instance)
	end)

	if MapTemplate then
		spawnedMap = trove:Clone(MapTemplate)
		spawnedMap.Parent = Workspace
		CollectionService:AddTag(spawnedMap, MAP_TAG)
	else
		warn("Map template not found!")
	end
end

function Event.OnStop()
	if not isActive then
		return
	end
	isActive = false

	if trove then
		trove:Destroy()
		trove = nil
	end

	hiddenInstances = {}
	spawnedMap = nil
end

return Event