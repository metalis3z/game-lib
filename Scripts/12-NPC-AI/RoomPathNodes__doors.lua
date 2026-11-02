-- Reference copy for study. Game: doors
-- Original: ServerScriptService/Game/Directory/EntryRoomNodes.lua  (ModuleScript, 103 lines)
-- What it does: Computes a path from a room's RoomStart to RoomEnd once and stores the waypoints as numbered invisible parts (PathNodes) so entities can follow them later.

local module = {
	Path = function(CurrentRoom)
		local PathfindingService = game:GetService("PathfindingService")

		local start = CurrentRoom.RoomStart
		local goal = CurrentRoom.RoomEnd

		local path = PathfindingService:CreatePath({ AgentHeight = 5, AgentRadius = 3, AgentCanJump = true })

		path:ComputeAsync(start.Position, goal.Position)

		local waypoints = path:GetWaypoints()
		
		local pathFolder = Instance.new("Folder", CurrentRoom)
		pathFolder.Name = "PathNodes"
		
		task.delay(math.random(1, 2), function()

			if not CurrentRoom.PathNodes:FindFirstChild("1") then
				for v, waypoint in pairs(waypoints) do

					local part = Instance.new("Part")
					part.Shape = "Ball"
					part.Material = "ForceField"
					part.Transparency = 0.5

					part.Size = Vector3.new(3, 3, 3)
					part.Position = waypoint.Position
					part.Anchored = true
					part.CanCollide = false

					if CurrentRoom.PathNodes then
						part.Parent = CurrentRoom.PathNodes
					else
						part.Parent = CurrentRoom
					end

					part.Name = v
				end

			end

		end)
		
		task.delay(math.random(3, 4), function()

			if not CurrentRoom.PathNodes:FindFirstChild("1") then
				for v, waypoint in pairs(waypoints) do

					local part = Instance.new("Part")
					part.Shape = "Ball"
					part.Material = "ForceField"
					part.Transparency = 0.5

					part.Size = Vector3.new(3, 3, 3)
					part.Position = waypoint.Position
					part.Anchored = true
					part.CanCollide = false

					if CurrentRoom.PathNodes then
						part.Parent = CurrentRoom.PathNodes
					else
						part.Parent = CurrentRoom
					end

					part.Name = v
				end

			end

		end)
		
		task.delay(math.random(5, 6), function()

			if not CurrentRoom.PathNodes:FindFirstChild("1") then
				for v, waypoint in pairs(waypoints) do

					local part = Instance.new("Part")
					part.Shape = "Ball"
					part.Material = "ForceField"
					part.Transparency = 0.5

					part.Size = Vector3.new(3, 3, 3)
					part.Position = waypoint.Position
					part.Anchored = true
					part.CanCollide = false

					if CurrentRoom.PathNodes then
						part.Parent = CurrentRoom.PathNodes
					else
						part.Parent = CurrentRoom
					end

					part.Name = v
				end

			end

		end)
	end,
}

return module
