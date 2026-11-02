-- Reference copy for study. Game: doors
-- Original: ServerScriptService/Server/Special/Hotel_FigureLibrary/FigureSetup/FigureMovement/AssetControl.server.lua  (Script, 350 lines)
-- What it does: DOORS-style Figure: patrols a Nodes folder, but while 'blind' only targets players moving faster than a speed threshold (hearing); uses direct movement when it has line of sight and pathfinding otherwise; grab-and-kill on touch; crucifix check.

--Values
local humanoid = script.Parent.Humanoid

--Animation
local walk = humanoid:LoadAnimation(script.walk)
local idle = humanoid:LoadAnimation(script.idle2)
idle:Play()
idle.Looped = true
local running = false
local footstep = 1
local track = "nil, maybe"
walk:Play()
walk:GetMarkerReachedSignal('Footstep'):Connect(function()
	if script.Parent.FigureRagdoll.HumanoidRootPart.Velocity.Magnitude <= 25 then
		track = "just walking"
		if footstep == 1 then
			footstep = 2
			game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(0.7, 12, 0, 0.7)
			script.Parent.FigureRagdoll.RightFoot.Footstep:Play()
			script.Parent.FigureRagdoll.RightFoot.FootstepLow:Play()
		else
			footstep = 1
			game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(0.9, 14, 0, 0.6)
			script.Parent.FigureRagdoll.LeftFoot.Footstep:Play()
			script.Parent.FigureRagdoll.LeftFoot.FootstepLow:Play()
		end
	else
		game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(0.7, 12, 0, 0.7)
		script.Parent.FigureRagdoll.RightFoot.Footstep:Play()
		script.Parent.FigureRagdoll.RightFoot.FootstepLow:Play()
	end
end)
game:GetService("RunService").Heartbeat:Connect(function()
	-- print("figure status:", track)
	if script.Parent.Speed.Value > 9 then
		walk:AdjustSpeed(1)
		idle:AdjustSpeed(1)
	elseif script.Parent.Speed.Value > 20 then
		walk:AdjustSpeed(1.25)
		idle:AdjustSpeed(1.25)
	elseif script.Parent.Speed.Value > 30 then
		walk:AdjustSpeed(1.5)
		idle:AdjustSpeed(1.5)
	end
end)

local chasing = false
local walkDebounce = false
local killDebounce = false
local isblind = true
local PathFolder = workspace:FindFirstChild("PathFolder")
if not PathFolder then
	PathFolder = Instance.new("Folder", workspace)
	PathFolder.Name = "PathFolder"
end
for i, v in pairs(script.Parent:GetChildren()) do
	if v:IsA("BasePart") then
		v.Touched:Connect(function(obj)
			if obj.Parent:FindFirstChild("Humanoid") then
				if obj.Parent.Humanoid.Health > 0 and not script.Parent.Crucified.Enabled and not obj.Parent:FindFirstChild("Crucifix") then
					if obj.Parent.Humanoid.RigType == Enum.HumanoidRigType.R6 then
						if not killDebounce then
							killDebounce = true
							obj.Parent.Humanoid.Health = 2
							script.Parent.FigureRagdoll.Head.Growl:Play()
							local attachment1 = Instance.new("Attachment", obj.Parent["Right Arm"])
							attachment1.Name = "GrabAttach"
							local attachment2 = Instance.new("Attachment", obj.Parent["Left Arm"])
							attachment2.Name = "GrabAttach"
							local attachment3 = Instance.new("Attachment", obj.Parent.Head)
							attachment2.Name = "GrabAttach"
							script.Parent.FigureRagdoll.Grab_Right.Attachment1 = attachment1
							script.Parent.FigureRagdoll.Grab_Left.Attachment1 = attachment2
							task.wait(1)
							obj.Parent.Humanoid.Health = 0
							obj.Parent["Right Arm"].CanCollide = false
							obj.Parent["Left Arm"].CanCollide = false
							killDebounce = false
							task.wait(10)
							local plr = game.Players:GetPlayerFromCharacter(obj.Parent)
							if plr then
								plr:LoadCharacter()
							end
						end
					end
				end
			end
		end)
	end
end
function findNearestTorso(pos)
	if isblind == true then
		local list = game.Workspace:children()
		local torso = nil
		local dist = 50
		local temp = nil
		local human = nil
		local temp2 = nil
		for x = 1, #list do
			temp2 = list[x]
			if (temp2.className == "Model") and (temp2 ~= script.Parent) then
				temp = temp2:FindFirstChild("HumanoidRootPart")
				human = temp2:FindFirstChildOfClass("Humanoid")
				if (temp ~= nil) and (human ~= nil) and (temp2:FindFirstChild("findplayer") == nil) and (human.Health > 0) then
					if (temp.Position - pos).magnitude < dist and temp.Velocity.Magnitude >= 10 then
						torso = temp
						dist = (temp.Position - pos).magnitude
						track = "player"
					elseif (temp.Position - pos).magnitude >= dist then
						track = "not_player"
					end
				end
			end
		end
		return torso
	elseif isblind == false then
		local list = game.Workspace:children()
		local torso = nil
		local dist = 120
		local temp = nil
		local human = nil
		local temp2 = nil
		for x = 1, #list do
			temp2 = list[x]
			if (temp2.className == "Model") and (temp2 ~= script.Parent) then
				temp = temp2:FindFirstChild("HumanoidRootPart")
				human = temp2:FindFirstChildOfClass("Humanoid")
				if (temp ~= nil) and (human ~= nil) and (temp2:FindFirstChild("findplayer") == nil) and (human.Health > 0) then
					if (temp.Position - pos).magnitude < dist then
						torso = temp
						dist = (temp.Position - pos).magnitude
						track = "player"
					elseif (temp.Position - pos).magnitude >= dist then
						track = "not_player"
					end
				end
			end
		end
		return torso
	end
end
spawn(function()
	while true do
		script.Parent.Humanoid:MoveTo(script.Parent.FigureRagdoll.Torso.Position)
		task.wait()
	end
end)
spawn(function()
	while true do
		if not chasing then
			if not walkDebounce then
				walkDebounce = true
				if not script.IsEnraged.Value then
					script.Parent.Humanoid.WalkSpeed = script.Parent.SpeedValue.Value
				else
					script.Parent.Humanoid.WalkSpeed = script.Parent.SpeedValue.Value
				end
				if chasing then
					walkDebounce = false
					break
				end
				for i, randomwalk in pairs(script.Parent.Parent.Parent.Nodes:GetChildren()) do
					local path = game:GetService("PathfindingService"):CreatePath({
						AgentHeight = 6,
						AgentRadius = 2,
						AgentCanJump = false, -- falce
					})
					path:ComputeAsync(script.Parent.FigureRagdoll.Torso.Position, randomwalk.Position)
					local waypoints = path:GetWaypoints()
					local speed = script.Parent.Humanoid.WalkSpeed

					for i, v in next, waypoints do
						if path.Status == Enum.PathStatus.Success and track ~= "player" then
							local distance = (script.Parent.FigureRagdoll.Torso.Position - v.Position).Magnitude
							local relativeSpeed = distance / speed
							local part = Instance.new("Part", workspace:FindFirstChild("PathFolder"))
							part.Position = v.Position + Vector3.new(0, 6, 0)
							--part.Position = Vector3.new(part.Position.X, script.Parent.FigureRagdoll.Torso.Position.Y, part.Position.Z)
							part.Transparency = 1
							part.CanCollide = false
							part.Anchored = true
							if chasing then
								break
							end
							--script.Parent.FigureRagdoll.Torso.BodyVelocity.Velocity = game.Workspace.Part.Position.Unit
							script.Parent.FigureRagdoll.Torso.BodyVelocity.Velocity = -(script.Parent.FigureRagdoll.Torso.Position - part.Position).Unit * script.Parent.Humanoid.WalkSpeed
							if not script.IsEnraged.Value then
								task.wait(script.Parent.Humanoid.WalkSpeed / script.Parent.Humanoid.WalkSpeed * 0.49)
							else
								task.wait(script.Parent.Humanoid.WalkSpeed / script.Parent.Humanoid.WalkSpeed * 0.27)
							end
							workspace.PathFolder:ClearAllChildren()
						end
					end
				end
				walkDebounce = false
			end
		end
		task.wait()
	end
end)
spawn(function()
	while true do
		local mat = math.random(1, 2)
		local mat2 = math.random(4, 8)
		if mat == 1 then
			if chasing then
				game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3.2, 16, 1, 1.5)
				script.Parent.FigureRagdoll.Head.Click:Play()
				script.Parent.FigureRagdoll.Head.ClickLow:Play()
				task.wait(mat2)
			else
				game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3.2, 16, 1, 1.5)
				script.Parent.FigureRagdoll.Head.Click:Play()
				script.Parent.FigureRagdoll.Head.ClickLow:Play()
				task.wait(mat2)
			end
		elseif mat == 2 then
			if chasing then
				game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3.2, 16, 1, 1.5)
				script.Parent.FigureRagdoll.Head.Click2:Play()
				script.Parent.FigureRagdoll.Head.Click2Low:Play()
				task.wait(mat2)
			else
				game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3.2, 16, 1, 1.5)
				script.Parent.FigureRagdoll.Head.Click2:Play()
				script.Parent.FigureRagdoll.Head.Click2Low:Play()
				task.wait(mat2)
			end
		end
		task.wait()
	end
end)

while true do
	local target = findNearestTorso(script.Parent.FigureRagdoll.HumanoidRootPart.Position)
	script.Parent.FigureRagdoll.HumanoidRootPart:SetNetworkOwner(nil)

	if script.Parent.FigureRagdoll.Crucified.Value == true then
		chasing = false
	else

	end
	if target then
		chasing = true
		if script.IsEnraged.Value then
			script.Parent.SlashSpeed.Value = script.Parent.SlashSpeed.Value
			script.Parent.Humanoid.WalkSpeed = script.Parent.Speed.Value
		else
			script.Parent.SlashSpeed.Value = script.Parent.SlashSpeed.Value
			script.Parent.Humanoid.WalkSpeed = script.Parent.Speed.Value + 4
		end	
		--script.Parent.FigureRagdoll.Torso.BodyVelocity.Velocity = -(script.Parent.FigureRagdoll.Torso.Position - target.Position).Unit * script.Parent.Humanoid.WalkSpeed
		local ray = Ray.new(script.Parent.FigureRagdoll.Torso.Position, (target.Position - script.Parent.FigureRagdoll.Torso.Position).Unit * 500)
		local hit = workspace:FindPartOnRay(ray, script.Parent.FigureRagdoll)
		local pathfind = false
		if hit then
			if not hit:IsDescendantOf(target.Parent) or track ~= "player" then
				pathfind = true
			end
		end
		if pathfind then
			local path = game:GetService("PathfindingService"):CreatePath({
				AgentHeight = 6,
				AgentRadius = 2.3,
				AgentCanJump = false,
			})
			path:ComputeAsync(script.Parent.FigureRagdoll.Torso.Position, target.Position)
			local waypoints = path:GetWaypoints()
			local speed = script.Parent.Humanoid.WalkSpeed

			for i, v in next, waypoints do
				if path.Status == Enum.PathStatus.Success then
					-- print("les go")
					local distance = (script.Parent.FigureRagdoll.Torso.Position - v.Position).Magnitude
					local relativeSpeed = distance / speed
					local part = Instance.new("Part", workspace:FindFirstChild("PathFolder"))
					part.Position = v.Position + Vector3.new(0, 6, 0)
					--part.Position = Vector3.new(part.Position.X, script.Parent.FigureRagdoll.Torso.Position.Y, part.Position.Z)
					part.Transparency = 1
					part.CanCollide = false
					part.Anchored = true
					if chasing then
						break
					end
					script.Parent.FigureRagdoll.Torso.BodyVelocity.Velocity = -(script.Parent.FigureRagdoll.Torso.Position - part.Position).Unit * script.Parent.Humanoid.WalkSpeed
					if not script.IsEnraged.Value then
						task.wait(script.Parent.Humanoid.WalkSpeed / script.Parent.Humanoid.WalkSpeed * 0.35)
					else
						task.wait(script.Parent.Humanoid.WalkSpeed / script.Parent.Humanoid.WalkSpeed * 0.13)
					end
					workspace.PathFolder:ClearAllChildren()
				end
				-- print("path status:", path.Status)
			end
		else
			script.Parent.FigureRagdoll.Torso.BodyVelocity.Velocity = -(script.Parent.FigureRagdoll.Torso.Position - target.Position).Unit * script.Parent.Humanoid.WalkSpeed
		end
	end
	if not target then
		chasing = false
		script.Parent.SlashSpeed.Value = 11.5
		if not script.IsEnraged.Value then
			script.Parent.Humanoid.WalkSpeed = script.Parent.SpeedValue.Value
		else
			script.Parent.Humanoid.WalkSpeed = script.Parent.SpeedValue.Value
		end
	end
	task.wait()
end

task.wait(.1)

local npc = script.Parent
local clone = npc:Clone()

local hum = npc:FindFirstChildOfClass("Humanoid") or Instance.new("Humanoid",npc)
local root = npc:FindFirstChild("HumanoidRootPart") or hum.RootPart

dead = false

local die = function()
	if dead then return end
	dead = true
	task.delay(3,function()
		clone.Parent = npc.Parent
		npc:Destroy()
	end)
end

if hum then
	hum.Died:Once(die)
end

if root then
	if not root.Anchored then
		root:SetNetworkOwner(nil)
	end
	coroutine.wrap(function()
		local count = 3

		if count < 1 then
			count = 1
		end

		repeat task.wait(count) until root == nil

		die()
	end)()
end
