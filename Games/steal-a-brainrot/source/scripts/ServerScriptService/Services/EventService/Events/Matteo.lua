local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local Matteo = {}

local isActive = false
local treePositions = {}
local collectedTrees = {}
local spawnedTrees = {}

local CollectTreeRemote = Net:RemoteFunction("EventService/Matteo/CollectTree")

local function findGroundY(x, z)
	local rayOrigin = Vector3.new(x, 100, z)
	local rayDirection = Vector3.new(0, -200, 0)

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {}

	local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

	if raycastResult then
		return raycastResult.Position.Y
	else
		return 5
	end
end

local function generateTreePositions()
	treePositions = {}

	local matteoFolder = workspace.Events:FindFirstChild("Matteo")
	if not matteoFolder then
		warn("workspace.Events.Matteo not found!")
		return
	end

	local treeSpawnParts = {}
	for _, child in ipairs(matteoFolder:GetChildren()) do
		if child.Name == "TreeSpawn" and child:IsA("BasePart") then
			table.insert(treeSpawnParts, child)
		end
	end

	if #treeSpawnParts == 0 then
		warn("No Tree spawn parts found in workspace.Events.Matteo")
		return
	end

	local treeCount = math.random(15, 25)

	for i = 1, treeCount do
		local randomSpawn = treeSpawnParts[math.random(1, #treeSpawnParts)]
		local position = randomSpawn.Position
		treePositions[i] = position
	end
end

local function spawnTrees()
	local matteoModels = ReplicatedStorage:FindFirstChild("Models")
	if not matteoModels then return end

	local eventsFolder = matteoModels:FindFirstChild("Events")
	if not eventsFolder then return end

	local matteoFolder = eventsFolder:FindFirstChild("Matteo")
	if not matteoFolder then return end

	local normalTrees = matteoFolder:FindFirstChild("NormalTrees")
	if not normalTrees then return end

	local treeNames = {"Tree1", "Tree2", "Tree3", "Tree4", "Tree5"}

	for i, position in pairs(treePositions) do
		local randomTreeName = treeNames[math.random(1, #treeNames)]
		local treeTemplate = normalTrees:FindFirstChild(randomTreeName)

		if treeTemplate then
			local tree = treeTemplate:Clone()
			local treeSize = tree:GetExtentsSize()

			tree:PivotTo(CFrame.new(position) * CFrame.new(0, treeSize.Y * 0.5, 0))
			tree.Parent = workspace
			tree:SetAttribute("TreeID", i)

			spawnedTrees[i] = tree
		end
	end
end

CollectTreeRemote.OnServerInvoke = function(player, treeId)
	if not isActive then
		return false
	end

	if player.Character and player.Character:GetAttribute("Matteo_CollectedTree") then
		return false
	end

	if not treePositions[treeId] then
		return false
	end

	if collectedTrees[treeId] then
		return false
	end

	collectedTrees[treeId] = true
	player.Character:SetAttribute("Matteo_CollectedTree", true)

	local tree = spawnedTrees[treeId]
	if tree then
		local treeSize = tree:GetExtentsSize()
		local treeScale = tree:GetScale()
		print("Tree collected! Scale:", treeScale, "Size:", treeSize)

		tree:Destroy()
		spawnedTrees[treeId] = nil
	end

	treePositions[treeId] = nil

	return true
end

function Matteo.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("MatteoEvent", true)

	generateTreePositions()

	task.wait(10)

	spawnTrees()
end

function Matteo.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("MatteoEvent", false)

	for _, tree in pairs(spawnedTrees) do
		if tree and tree.Parent then
			tree:Destroy()
		end
	end

	spawnedTrees = {}
	treePositions = {}
	collectedTrees = {}
end

return Matteo