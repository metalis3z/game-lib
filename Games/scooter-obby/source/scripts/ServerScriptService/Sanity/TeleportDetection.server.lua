local teleportThreshold = 35 -- how many studs must be travelled in the check time to flag
local checkTime = 0.05 -- how many seconds between checks
local veloMagnitude = 0.1 -- how low the players velocity magnitude needs to be to be flagged (set to math.huge() if not wanted)

local lastPositions = {}
local joinTimes = {}

while true do
	for i,v in pairs(game.Players:GetChildren()) do
		if not joinTimes[v.Name] then
			joinTimes[v.Name] = os.time()
		end
		if v.Character ~= nil and joinTimes[v.Name] - os.time() <= -10 then
			if not lastPositions[v.Name] then
				lastPositions[v.Name] = v.Character.HumanoidRootPart.Position
			else
				if v:GetAttribute("Safe2") == 0 then
					if (lastPositions[v.Name] - v.Character.HumanoidRootPart.Position).magnitude > teleportThreshold and workspace.Ignore:FindFirstChild(v.Name) and workspace.Ignore:FindFirstChild(v.Name).AssemblyLinearVelocity.magnitude <= veloMagnitude then
						--v:Kick("ruh oh (2)")
					end
				else
					if v:GetAttribute("Safe2") == nil then
						v:SetAttribute("Safe2", 0)
					else
						v:SetAttribute("Safe2", v:GetAttribute("Safe2") - checkTime)
					end
					if v:GetAttribute("Safe2") < 0 then
						v:SetAttribute("Safe2", 0)
					end
				end
				lastPositions[v.Name] = v.Character.HumanoidRootPart.Position
			end
		end
	end
	task.wait(checkTime)
end