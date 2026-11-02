local Pathfinding = {}

Node = {}
Node.__index = Node
function Node.new(position)
	local self = setmetatable({}, Node)
	self.position = position
	self.parent = nil
	self.g = 0
	self.h = 0
	self.f = 0
	return self
end

function calculateHeuristic(nodeA, nodeB)
	return (nodeA.position - nodeB.position).magnitude
end


function getLowestFNode(nodeList)
	local lowestIndex = 1
	for i = 2, #nodeList do
		if nodeList[i].f < nodeList[lowestIndex].f then
			lowestIndex = i
		end
	end
	return nodeList[lowestIndex]
end

function retracePath(startNode, endNode)
	local path = {}
	local currentNode = endNode
	while currentNode do
		table.insert(path, 1, currentNode.position)
		currentNode = currentNode.parent
	end
	return path
end

function isPositionInObstacle(position, obstacles, buffer)
	buffer = buffer or 0  -- If no buffer is provided, default is 0
	for _, obstacle in pairs(obstacles:GetDescendants()) do
		if obstacle:IsA('BasePart') then 
			local distance = (obstacle.Position - position).magnitude
			-- Adjust for obstacle size and buffer zone
			if distance < (obstacle.Size.magnitude / 2) + buffer then
				return true
			end
		end 
	end
	return false
end


function getNeighborNodes(currentNode, obstacles, stepSize, buffer)
	stepSize = stepSize or 4  -- Default step size if not provided
	buffer = buffer or 0      -- Default buffer if not provided

	local neighbors = {}
	local moves = {
		Vector3.new(stepSize, 0, 0), -- Right
		Vector3.new(-stepSize, 0, 0), -- Left
		Vector3.new(0, 0, stepSize), -- Forward
		Vector3.new(0, 0, -stepSize) -- Back
	}

	for _, move in ipairs(moves) do
		local newPos = currentNode.position + move
		if not isPositionInObstacle(newPos, obstacles, buffer) then
			table.insert(neighbors, Node.new(newPos))
		end
	end
	return neighbors
end




function AStarPathfinding(startPosition, endObject, obstaclesFolder)
	local endPosition = endObject.Position
	local startNode = Node.new(startPosition)
	local endNode = Node.new(endPosition)

	local openList = {startNode}
	local closedList = {}

	while #openList > 0 do
		wait() 

		local current = getLowestFNode(openList)

		createPartAtPosition(current.position)

		if current.position == endPosition then
			local path = retracePath(startNode, current)
			return path
		end

		table.remove(openList, table.find(openList, current))
		table.insert(closedList, current)

		for _, neighbor in ipairs(getNeighborNodes(current, obstaclesFolder)) do
			if not table.find(closedList, neighbor) then
				local tentativeG = current.g + 1
				local inOpen = table.find(openList, neighbor)

				if not inOpen or tentativeG < neighbor.g then
					neighbor.parent = current
					neighbor.g = tentativeG
					neighbor.h = calculateHeuristic(neighbor, endNode)
					neighbor.f = neighbor.g + neighbor.h

					if not inOpen then
						table.insert(openList, neighbor)
					end
				end
			end
		end
	end
	return nil
end

Pathfinding.AStar = function(NPC, endObject, obstaclesFolder)
	local CanCreatePath = true 
	local positions = {}

	local PathsFolder = Instance.new('Folder',NPC)
	PathsFolder.Name = 'Paths'

	function createPartAtPosition(position)
		if (NPC.PrimaryPart.Position-endObject.Position).Magnitude < 4 or (position-endObject.Position).magnitude< 4 and (CanCreatePath == true) then
			CanCreatePath = false 
			print('Wandering!')

			delay(0,function()
				for i,v in ipairs(positions) do 
					wait(0.025)
					delay(0,function()
						game:GetService('TweenService'):Create(v,TweenInfo.new(0.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,math.huge,true,0.3),{Transparency=0.2}):Play()
					end)
				end
			end)

			delay(0,function()
				for i,v in ipairs(positions) do 
					wait(1)
					--NPC.Humanoid:MoveTo(v.Position)
					--NPC.Humanoid.MoveToFinished:Wait()
				end
				--PathsFolder:Destroy()
				print('✅ | Success!')
				return
			end)
		else 
			if CanCreatePath then
				local part = Instance.new("Part")
				part.Size = Vector3.new(4, 0.5, 4)
				part.Position = Vector3.new(position.X, 0.25, position.Z) 
				part.Anchored = true
				part.CanCollide = false
				part.Material = Enum.Material.Neon
				part.Transparency = 0.5 
				part.Color = Color3.fromRGB(0, 170, 255) 
				part.Parent = PathsFolder		


				table.insert(positions,part)

			end 


		end
	end

	local function visualizePath(path)
		for _, position in ipairs(path) do
			createPartAtPosition(position)	
		end
	end

	local startPosition = NPC.PrimaryPart.Position
	local path = AStarPathfinding(startPosition, endObject, obstaclesFolder)

	if path then
	else
		return
	end
end

return Pathfinding