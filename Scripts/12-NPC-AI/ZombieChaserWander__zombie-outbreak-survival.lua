-- Reference copy for study. Game: zombie-outbreak-survival
-- Original: ReplicatedStorage/Zombie/ZombieAi.server.lua  (Script, 232 lines)
-- What it does: Classic per-zombie Script: finds the nearest player on the 'Alive' team, pathfinds toward them, wanders randomly when no one is near, and deals touch damage with a per-victim cooldown.

local SearchDistance = 	1000 	-- How far a player can be before it detects you
local ZombieDamage = 	25		-- How much damage the Zombie inficts towards the player
local DamageWait = 		1		-- How many seconds to wait before it can damage the player again
local WanderX, WanderZ = 30, 30
function getHumanoid(model)
	for _, v in model:GetChildren() do
		if v:IsA("Humanoid") then
			return v
		end
	end
end

local zombie = script.Parent
local human = getHumanoid(zombie)
local hroot = zombie:FindFirstChild("HumanoidRootPart")
local zspeed = hroot and hroot.Velocity.magnitude or 0
local head = zombie:FindFirstChild("Head")
local vars = script.vars

local pfs = game:GetService("PathfindingService")
local players = game:GetService("Players")
local teams = game:GetService("Teams")
local CollectionService = game:GetService("CollectionService")

local path
local waypoint

-- Only chase players in the "Alive" team
function GetTorso(part)
	local chars = workspace:GetChildren()
	local chaseRoot = nil
	local chaseTorso = nil
	local chasePlr = nil
	local chaseHuman = nil
	local mag = SearchDistance
	for i = 1, #chars do
		chasePlr = chars[i]
		if chasePlr:IsA("Model") and chasePlr ~= zombie then
			chaseHuman = getHumanoid(chasePlr)
			chaseRoot = chasePlr:FindFirstChild("HumanoidRootPart")
			if chaseRoot ~= nil and chaseHuman ~= nil and chaseHuman.Health > 0 then
				-- Only chase if the model is a player character (parent is Workspace, but name is in Players)
				local playerObj = players:FindFirstChild(chasePlr.Name)
				if playerObj and chasePlr.Parent == workspace then
					-- Check if player is in "Alive" team
					if playerObj.Team and playerObj.Team.Name == "Alive" then
						if (chaseRoot.Position - part).magnitude < mag then
							chaseTorso = chaseRoot
							mag = (chaseRoot.Position - part).magnitude
						end
					end
				end
			end
		end
	end
	return chaseTorso
end

function GetPlayersBodyParts(t)
	local torso = t
	if torso then
		local figure = torso.Parent
		for _, v in figure:GetChildren() do
			if v:IsA("Part") then
				return v.Name
			end
		end
	else
		return "HumanoidRootPart"
	end
end

-- Per-zombie-per-player debounce table
local damageDebounce = {}

for _, zambieparts in zombie:GetChildren() do
	if zambieparts:IsA("Part") and human and human.Health > 0 then
		zambieparts.Touched:Connect(function(p)
			local enemy = p.Parent
			if enemy and enemy ~= zombie and players:FindFirstChild(enemy.Name) then
				local enemyhuman = getHumanoid(enemy)
				local playerObj = players:FindFirstChild(enemy.Name)
				-- Only damage players in "Alive" team
				if playerObj and playerObj.Team and playerObj.Team.Name == "Alive" then
					if enemyhuman and enemyhuman.Health > 0 and not CollectionService:HasTag(enemy, "PlayerZombie") then
						local key = enemy
						if not damageDebounce[key] or (os.clock() - damageDebounce[key]) >= DamageWait then
							damageDebounce[key] = os.clock()
							vars.Attacking.Value = true
							enemyhuman:TakeDamage(ZombieDamage)
							vars.Attacking.Value = false
						end
					end
				end
			end
		end)
	end
end

-- wandering 
spawn(function()
	while vars.Wandering.Value == false and human and human.Health > 0 do	
		vars.Chasing.Value = false	
		vars.Wandering.Value = true
		local desgx, desgz = hroot.Position.x+math.random(-WanderX,WanderX), hroot.Position.z+math.random(-WanderZ,WanderZ)
		local function checkw(t)
			local ci = 3
			if ci > #t then
				ci = 3
			end
			if t[ci] == nil and ci < #t then
				repeat ci = ci + 1 task.wait() until t[ci] ~= nil
				return Vector3.new(1,0,0) + t[ci]
			else
				ci = 3
				return t[ci]
			end
		end
		
		path = pfs:FindPathAsync(hroot.Position, Vector3.new(desgx, 0, desgz))
		waypoint = path:GetWaypoints()
		local connection;
		
		local direct = Vector3.FromNormalId(Enum.NormalId.Front)
		local ncf = hroot.CFrame * CFrame.new(direct)
		direct = ncf.p.unit
		local rootr = Ray.new(hroot.Position, direct)
		local phit, ppos = workspace:FindPartOnRay(rootr, hroot)
		
		if path and waypoint or checkw(waypoint) then
			if checkw(waypoint) ~= nil and checkw(waypoint).Action == Enum.PathWaypointAction.Walk then
				human:MoveTo( checkw(waypoint).Position )
				human.Jump = false
			end
			
			if checkw(waypoint) ~= nil and checkw(waypoint).Action == Enum.PathWaypointAction.Jump then
				connection = human.Changed:Connect(function()
					human.Jump = true
				end)
				human:MoveTo( waypoint[4].Position )
			else
				human.Jump = false
			end
			
			if connection then
				connection:Disconnect()
			end
			
		else
			for i = 3, #waypoint do
				human:MoveTo( waypoint[i].Position )	
			end
		end
		task.wait(math.random(4,6))
		vars.Wandering.Value = false
	end
end)

while task.wait() do
	local nrstt = GetTorso(hroot.Position)
	if nrstt ~= nil and human and human.Health > 0 then -- if player detected	
		vars.Wandering.Value = false
		vars.Chasing.Value = true
		local function checkw(t)
			local ci = 3
			if ci > #t then
				ci = 3
			end
			if t[ci] == nil and ci < #t then
				repeat ci = ci + 1 task.wait() until t[ci] ~= nil
				return Vector3.new(1,0,0) + t[ci]
			else
				ci = 3
				return t[ci]
			end
		end
		
		path = pfs:FindPathAsync(hroot.Position, nrstt.Position)
		waypoint = path:GetWaypoints()
		local connection;
		
		local direct = Vector3.FromNormalId(Enum.NormalId.Front)
		local ncf = hroot.CFrame * CFrame.new(direct)
		direct = ncf.p.unit
		local rootr = Ray.new(hroot.Position, direct)
		local phit, ppos = workspace:FindPartOnRay(rootr, hroot)
		
		if path and waypoint or checkw(waypoint) then
			if checkw(waypoint) ~= nil and checkw(waypoint).Action == Enum.PathWaypointAction.Walk then
				human:MoveTo( checkw(waypoint).Position )
				human.Jump = false
			end
			
			if checkw(waypoint) ~= nil and checkw(waypoint).Action == Enum.PathWaypointAction.Jump then
				connection = human.Changed:Connect(function()
					human.Jump = true
				end)
				human:MoveTo( waypoint[4].Position )
			else
				human.Jump = false
			end
			
			hroot.Touched:Connect(function(p)
				local bodypartnames = GetPlayersBodyParts(nrstt)
				if p:IsA("Part") and not p.Name == bodypartnames and phit and phit.Name ~= bodypartnames and phit:IsA("Part") and (rootr:Distance(phit.Position) < 5) then
					connection = human.Changed:Connect(function()
						human.Jump = true
					end)
				else
					human.Jump = false
				end
			end)
			
			if connection then
				connection:Disconnect()
			end
			
		else
			for i = 3, #waypoint do
				human:MoveTo( waypoint[i].Position )	
			end
		end
		path = nil
		waypoint = nil
	elseif nrstt == nil then -- if player not detected
		vars.Wandering.Value = false
		vars.Chasing.Value = false
		path = nil
		waypoint = nil
		human.MoveToFinished:Wait()
	end
end
