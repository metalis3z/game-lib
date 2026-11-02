local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local Assets = ReplicatedStorage:WaitForChild("Assets")

local Spring = require(Assets.Modules.Spring)
local Network = require(Assets.Modules.Network)

local humanoid = character:WaitForChild("Humanoid")

local neck = character.Torso:WaitForChild("Neck")
local defaultNeck = neck.C0

local lastGurgle
local rightShoulder, leftShoulder = character.Torso:WaitForChild("Right Shoulder"), character.Torso:WaitForChild("Left Shoulder")

local config = {
	blood_timeout = 2;
	meat_timeout = 2;
	blood_cleanup_time = 5;
	blood_cleanup_animation_time = 2.5;

	max_blood_parts = 1000;
	max_wound_parts = 20;
	max_meat_parts = 80;
	blood_render_distance = 150065;
	wound_render_distance = 60;
	meat_render_distance = 40;
	render_process = 1 / 30;
	decal_cleanup_time = 10;
	meat_cleanup_time = 5;
	
	combat_time = 1;

	default_debug_clean_time = 5;
	debug = false;
}

local springCam = Spring.new(Vector3.new())
springCam.Speed = 1
springCam.Damper = 0

local lastActive = 0
local delay = 0
local equipDelay = 0
local neckTilt = 0
local aimFOV = 0
local cameraOffset = 1.5
local DOFPos = Vector3.new()

local default_sens = UserInputService.MouseDeltaSensitivity

local bloodParts = {}
local woundParts = {}
local meatParts = {}
local tools = {}

local equippingGun = false
local gunTool

local params = RaycastParams.new()
params.FilterDescendantsInstances = {workspace.Ignored, workspace.Characters}
params.IgnoreWater = true
params.CollisionGroup = "Raycast"

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.D = 250
bodyGyro.P = 10000
bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)

local offsetPos = {
	["Top"] = Vector3.new(0, 1, 0);
	["Center"] = Vector3.new(0, 0, 0);
	["Right"] = Vector3.new(1, 0, 0);
	["TopLeft"] = Vector3.new(-1, 1, 0);
	["TopRight"] = Vector3.new(1, 1, 0);
	["RightBottom"] = Vector3.new(1, -1, 0);
	["Left"] = Vector3.new(-1, 0, 0);
	["Bottom"] = Vector3.new(0, -1, 0);
	["BottomLeft"] = Vector3.new(-1, -1, 0);
}

local offsetPos2 = {
	["Top"] = Vector3.new(0, 1, 0);
	["Center"] = Vector3.new(0, 0, 0);
	["Bottom"] = Vector3.new(0, -1, 0)
}

function loadAnim(id)
	local animTrack = Instance.new("Animation")
	animTrack.AnimationId = "rbxassetid://" .. id
	return humanoid.Animator:LoadAnimation(animTrack),
		animTrack:Destroy()
end

function findTool(tool)
	for index,data in pairs(tools) do
		if (data.tool == tool) then
			return tools[index], index
		end
	end
	
	return false
end

function destroyed(x)
	if x.Parent then return false end
	local _, result = pcall(function() x.Parent = x end)
	return result:match("locked") and true or false
end

Assets.Events.ToolLoader.Event:Connect(function(tool, type, data, unique_id)
	if (not tools[unique_id] and type == "registerGun") then
		tools[unique_id] = {
			tool = tool;
			anims = {};
			gun = true;
			settings = data.settings
		}

		for index,data in pairs(data.anims) do
			tools[unique_id].anims[index] = loadAnim(data)
		end
	end
	
	if (tools[unique_id]) then
		if (tools[unique_id].gun) then
			if (not equippingGun) then
				equipDelay = tick()
			end
			equippingGun = tool:IsDescendantOf(character)
			gunTool = tool
		end
		if (type == "anims") then
			tools[unique_id].anims[data]:Play()
		elseif (type == "stopAnims") then
			for index,anim in pairs(tools[unique_id].anims) do
				local canStop = true
				for _,v in pairs(data) do
					if (v == index) then
						canStop = false
						break
					end
				end
				if (canStop) then
					anim:Stop()
				end
			end
		end
	end
end)

function lerp(a, b, t)
	return a + (b - a) * t
end

function debugLine(p1, p2, t, b)
	if (not config.debug and not b) then
		return
	end

	local startPoint = Assets.Miscs.rayDebug.start:Clone()
	local endPoint = Assets.Miscs.rayDebug["end"]:Clone()
	startPoint.Position = p1
	endPoint.Position = p2
	startPoint.Parent, endPoint.Parent = workspace.Ignored, workspace.Ignored
	startPoint.Beam.Attachment1 = endPoint.point
	Debris:AddItem(startPoint, t or config.default_debug_clean_time)
	Debris:AddItem(endPoint, t or config.default_debug_clean_time)
	return startPoint, endPoint
end

function debugDot(p1, t, b)
	if (not config.debug and not b) then
		return
	end

	local dot = Assets.Miscs.dot:Clone()
	dot.Position = p1
	dot.Parent = workspace.Ignored
	Debris:AddItem(dot, t or config.default_debug_clean_time)
	return dot
end

function findHumanoid(p)
	if (p.Parent:FindFirstChild("Humanoid")) then
		return p.Parent
	end

	if (not p.Parent == workspace) then
		return findHumanoid(p.Parent)
	end

	return false
end

function getDistance(p1, p2)
	return ((typeof(p1) == "Instance" and p1.Position or p1) - (typeof(p2) == "Instance" and p2.Position or p2)).magnitude
end

function getRandomChild(parent)
	return parent:GetChildren()[math.random(#parent:GetChildren())]
end

function playsound(sound, parent, pitch)
	local isPos = typeof(parent) == "Vector3"
	if (isPos) then
		local pos = parent
		parent = Instance.new("Attachment")
		parent.WorldPosition = pos
		parent.Parent = workspace.Terrain
	end

	local sound = sound:Clone()
	sound.PlaybackSpeed = pitch and sound.PlaybackSpeed + (math.random() * pitch) or sound.PlaybackSpeed
	sound.Parent = parent
	sound:Play()
	Debris:AddItem(isPos and parent or sound, sound.TimeLength + 1)
	return sound
end

function getTableIndex(t)
	local n = 0
	for i,v in pairs(t) do
		n += 1
	end
	return n
end

function normalIdFromVector(vector)
	local epsilon = 0.01
	for _,normalId in pairs(Enum.NormalId:GetEnumItems()) do
		if vector.unit:Dot(Vector3.FromNormalId(normalId)) > 1 - epsilon then
			return normalId
		end
	end
end

function getSize(p)
	local n = 0
	n += p.Size.x
	n += p.Size.y
	n += p.Size.z
	return n
end

function getClampedVel(curVel, maxVel)
	local v3 = curVel.unit * math.min(maxVel, curVel.magnitude)
	if (string.find(tostring(v3), "nan")) then
		v3 = Vector3.new(1, 1, 1)
	end
	return v3
end

function getGibFromPosition(part, origin)
	local dir, dist = nil, math.huge
	if (part.Name == "Head") then
		for index,offset in pairs(offsetPos) do
			local pos = part.CFrame + (offset / 2)
			local d = getDistance(pos.Position, origin)
			if (d < dist) then
				dir, dist = index, d
			end
		end
	else
		for index,offset in pairs(offsetPos2) do
			local pos = part.CFrame + offset
			local d = getDistance(pos.Position, origin)
			if (d < dist) then
				dir, dist = index, d
			end
		end
	end
	
	return dir, dist
end

function disconnect_blood(index)
	if (bloodParts[index] and bloodParts[index].connection) then
		bloodParts[index].connection:Disconnect()
		bloodParts[index].connection = nil
	end
end

function kill_blood(index)
	disconnect_blood(index)
	if (bloodParts[index]) then
		bloodParts[index].part:Destroy()
		bloodParts[index].part = nil
		bloodParts[index].index = nil
		bloodParts[index] = nil
	end
end

function kill_wound(index)
	if (woundParts[index]) then
		for i,v in pairs(woundParts[index]) do
			v:Destroy()
			woundParts[index][i] = nil
		end
		woundParts[index] = nil
	end
end

function kill_meat(index)
	if (meatParts[index]) then
		meatParts[index]:Destroy()
		meatParts[index] = nil
	end
end

function handleBlood(model, origin, dir, t, settings)
	local originDir = dir
	local isTrack = settings.mode == "track"
	local track, trackDir
	if (isTrack) then
		track = Instance.new("Attachment")
		track.Parent = settings.parent
		track.WorldPosition = origin
		track.Name = "origin"

		trackDir = Instance.new("Attachment")
		trackDir.Parent = settings.parent
		trackDir.WorldPosition = origin + dir
		trackDir.Name = "direction"
	end
	
	local particles = Assets.Bloods.particles.Attachment:Clone()
	particles.WorldPosition = origin + Vector3.new(
		math.random(-100, 100) / 1000,
		math.random(-100, 100) / 1000,
		math.random(-100, 100) / 1000
	)
	particles.Parent = workspace.Terrain
	Debris:AddItem(particles, 3)

	for _,particle in pairs(particles:GetChildren()) do
		if (particle:IsA("ParticleEmitter")) then
			particle:Emit(math.random(3, 5))
		end
	end
	
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = t or {workspace.Ignored}
	params.IgnoreWater = true
	params.CollisionGroup = "Raycast"
	
	-- // organs system
	if (settings.meat) then
		for k = 1, settings.meatAmount do
			local meat = getRandomChild(Assets.Bloods.meats):Clone()
			meat.Position = origin + Vector3.new(
				math.random(-100, 100) / 1000,
				math.random(-100, 100) / 1000,
				math.random(-100, 100) / 1000
			)
			
			local force = Instance.new("BodyForce")
			force.Force = Vector3.new(0, meat:GetMass() * 170)
			force.Parent = meat
			meat.Velocity = ((dir or meat.Velocity) + Vector3.new(
				math.random(-1000, 1000) / 500 * settings.spreadness,
				math.random(-1000, 1000) / 500 * settings.spreadness,
				math.random(-1000, 1000) / 500 * settings.spreadness
			)) / (math.random(10, 30) / 10)
			meat.RotVelocity = meat.Velocity
			meat.Parent = workspace.Ignored
			local meatIndex = #meatParts + 1
			meatParts[meatIndex] = meat
			if (getTableIndex(meatParts) >= config.max_meat_parts) then
				for i = 1, #meatParts do
					if (meatParts[i] and i ~= meatIndex) then
						kill_meat(i)
					end
				end
			end
			
			local lastPosition = meat.Position
			local startTime = tick()
			local connection
			connection = RunService.RenderStepped:Connect(function(dt)
				dt *= 60
				
				local cast = workspace:Raycast(meat.Position, (meat.Position - lastPosition).unit * 1.5 * dt, params)
				local startLine, endLine = debugLine(meat.Position, meat.Position + (meat.Position - lastPosition).unit * 1.5 * dt)
				if (cast) then
					playsound(getRandomChild(Assets.Sounds.chunk), meat, 0.4)
					connection:Disconnect()
					if (startLine) then
						startLine.Beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
					end
					
					meat.CFrame = CFrame.new(cast.Position, cast.Position + cast.Normal) * CFrame.Angles(math.rad(90), math.rad(math.random(-90, 90)), 0)
					local weld
					if (findHumanoid(cast.Instance) or not cast.Instance.Anchored) then
						weld = Instance.new("WeldConstraint")
						weld.Part0 = cast.Instance
						weld.Part1 = meat
						weld.Parent = meat
					else
						meat.Anchored = true
					end
					local blood_settings = {
						["spreadness"] = 1.1,
						["amount"] = math.random(2, 3),
						["process"] = {10, 15, 100},
						["size"] = {60, 80, 100},
						["mode"] = "track",
						["parent"] = meat,
						["tweenIn"] = TweenInfo.new(0.25, Enum.EasingStyle.Quint),
						["drain"] = true,
					}
					handleBlood(meat, cast.Position + (cast.Normal / 50), meat.CFrame.UpVector, {model, workspace.Ignored}, blood_settings)
					if (normalIdFromVector(cast.Normal) ~= Enum.NormalId.Top) then
						meat.Velocity = Vector3.new()
						meat.RotVelocity = Vector3.new()
						if (math.random(3) == 1) then
							task.wait(math.random(1, 3))
							pcall(function()
								playsound(getRandomChild(Assets.Sounds.chunk), meat, 0.4)
								if (weld) then
									weld:Destroy()
								end
								local gyro = Instance.new("BodyGyro")
								gyro.CFrame = meat.CFrame
								gyro.Parent = meat
								meat.CanCollide = true
								meat.Anchored = false
							end)
						end
					end
					Debris:AddItem(meat, config.meat_cleanup_time)
					task.delay(config.meat_cleanup_time - 0.5, function()
						TweenService:Create(meat, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Transparency = 1}):Play()
					end)
				elseif (tick() - startTime >= config.meat_timeout) then
					meat:Destroy()
					connection:Disconnect()
				end
				
				lastPosition = meat.Position
			end)
		end
	end

	for k = 1, settings.amount or 1 do
		if (not model:IsDescendantOf(workspace)) then
			break
		end
		if (isTrack) then
			origin = track.WorldPosition
			dir = (trackDir.WorldPosition - origin)
		end
		
		settings.spreadness = settings.spreadness or 1
		local drip = Assets.Bloods.drip:Clone()
		-- // random spawn pos so it doesn't look goofy
		drip.Position = origin + Vector3.new(
			math.random(-100, 100) / 1000,
			math.random(-100, 100) / 1000,
			math.random(-100, 100) / 1000
		)
		-- // added spread cuz why not
		drip.Velocity = (dir or drip.Velocity) / (settings.drain and k or 1) + Vector3.new(
			math.random(-1000, 1000) / 500 * settings.spreadness,
			math.random(-1000, 1000) / 500 * settings.spreadness,
			math.random(-1000, 1000) / 500 * settings.spreadness
		)
		drip.Parent = workspace.Ignored
		if (settings.drain) then
			local baseLifetime = drip.Trail.Lifetime
			drip.Trail.Lifetime *= math.max(3 / k, baseLifetime)
		end
		
		local index = #bloodParts + 1
		local lastPosition = drip.Position
		local startTime = tick()
		bloodParts[index] = {
			part = drip,
			placed = false,
			destroyed = false
		}

		if (getTableIndex(bloodParts) > config.max_blood_parts) then
			for i,_ in pairs(bloodParts) do
				if (bloodParts[i] and bloodParts[i].placed) then
					kill_blood(i)
					break
				end
			end
		end

		if (not bloodParts[index]) then
			return
		end

		bloodParts[index].connection = RunService.RenderStepped:Connect(function(dt)
			dt *= 60
			
			local cast
			local startLine, endLine
			if (settings.singleSegment) then
				dir = originDir + Vector3.new(
					math.random(-1000, 1000) / 500 * settings.spreadness,
					math.random(-1000, 1000) / 500 * settings.spreadness,
					math.random(-1000, 1000) / 500 * settings.spreadness
				)
				cast = workspace:Raycast(origin, dir, params)
				startLine, endLine = debugLine(drip.Position, drip.Position + dir)
			else
				cast = workspace:Raycast(drip.Position, (drip.Position - lastPosition).unit * 1.5 * dt, params)
				startLine, endLine = debugLine(drip.Position, drip.Position + (drip.Position - lastPosition).unit * 1.5 * dt)
			end
			if (cast) then
				if (startLine) then
					startLine.Beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
				end
				
				local originPos = cast.Position + cast.Normal / 50
				drip.CFrame = CFrame.new(originPos, originPos + cast.Normal) * CFrame.Angles(math.rad(90), 0, 0)
				drip.Color = Color3.fromRGB(math.random(70, 110), 0, 0)
				local welding = findHumanoid(cast.Instance) or not cast.Instance.Anchored
				if (welding) then
					local weld = Instance.new("WeldConstraint")
					weld.Part0 = cast.Instance
					weld.Part1 = drip
					weld.Parent = drip
					drip.Trail.Enabled = false
				else
					drip.Anchored = true
				end
				
				local normal = normalIdFromVector(cast.Normal)
				if (normal ~= Enum.NormalId.Top and not findHumanoid(cast.Instance) and math.random(5) == 1) then
					if (normal ~= Enum.NormalId.Bottom and not welding) then
						return
					end

					local blood_settings = {
						["spreadness"] = 0.5,
						["amount"] = math.random(10, 15),
						["process"] = {35, 40, 100},
						["size"] = {30, 45, 100},
						["tweenIn"] = TweenInfo.new(0.25, Enum.EasingStyle.Quint),
						["mode"] = "track",
						["parent"] = drip,
						["drain"] = true,
					}
					handleBlood(drip, cast.Position + (cast.Normal / 100), drip.CFrame.UpVector * -5, {model, cast.Instance, workspace.Ignored}, blood_settings)
				end
				pcall(function()
					local size = settings.size and math.random(settings.size[1], settings.size[2]) / settings.size[3] or 0.25
					TweenService:Create(drip, settings.tweenIn or TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = Vector3.new(size, 0, size), Transparency = 0}):Play()
					playsound(getRandomChild(Assets.Sounds.drips), drip, 0.4)
					bloodParts[index].placed = true
					disconnect_blood(index)
					task.wait(config.blood_cleanup_time)
					if (not destroyed(drip)) then
						TweenService:Create(drip, TweenInfo.new(config.blood_cleanup_animation_time, Enum.EasingStyle.Sine), {Size = Vector3.new(0, 0, 0), Transparency = 1}):Play()
						task.wait(config.blood_cleanup_animation_time)
						bloodParts[index].destroyed = true
						kill_blood(index)
					end
				end)
			elseif (tick() - startTime >= config.blood_timeout) then
				kill_blood(index)
			end

			lastPosition = drip.Position
		end)

		if (settings.process) then
			task.wait(math.random(settings.process[1], settings.process[2]) / settings.process[3])
		end
	end

	if (track and trackDir) then
		track:Destroy()
		trackDir:Destroy()
	end
end

function handleWound(cast, model, originPos)
	local woundIndex = #woundParts + 1
	if (getTableIndex(woundParts) >= config.max_wound_parts) then
		for i = 1, #woundParts do
			if (woundParts[i] and i ~= woundIndex) then
				kill_wound(i)
			end
		end
	end

	local wound = getRandomChild(Assets.Bloods.wounds):Clone()
	local size = math.random(300, 350) / 1000
	wound.Color = Color3.fromRGB(math.random(86, 130), 0, 0)
	wound.Size = Vector3.new(size, 0.12, size)
	wound.CFrame = CFrame.new(originPos, originPos + cast.Normal) * CFrame.Angles(math.rad(-90), math.rad(math.random(-90, 90)), 0)
	wound.Name = "wound"
	wound.Parent = cast.Instance
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = cast.Instance.Name == "HumanoidRootPart" and cast.Instance.Parent.Torso or cast.Instance
	weld.Part1 = wound
	weld.Parent = wound
	Debris:AddItem(wound, config.decal_cleanup_time)

	local bloodHole = Assets.Bloods.bloodHole:Clone()
	local size = math.random(45, 50) / 100
	bloodHole.Size = Vector3.new(size, 0, size)
	bloodHole.CFrame = CFrame.new(cast.Position, cast.Position + cast.Normal) * CFrame.Angles(math.rad(-90), math.rad(math.random(-90, 90)), 0)
	bloodHole.Parent = cast.Instance
	bloodHole.Decal.Color3 = Color3.fromRGB(math.random(53, 140), 0, 0)
	task.delay(math.random(4, 6) / 10, function()
		local sizeMultiplier = size * math.random(2, 5)
		TweenService:Create(bloodHole, TweenInfo.new(math.random(8, 10), Enum.EasingStyle.Sine), {Size = Vector3.new(sizeMultiplier, 0, sizeMultiplier)}):Play()
	end)
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = cast.Instance.Name == "HumanoidRootPart" and cast.Instance.Parent.Torso or cast.Instance
	weld.Part1 = bloodHole
	weld.Parent = bloodHole
	Debris:AddItem(bloodHole, config.decal_cleanup_time)
	woundParts[woundIndex] = {
		wound,
		bloodHole
	}
	local charConnection
	charConnection = model.Destroying:Connect(function()
		kill_wound(woundIndex)
		charConnection:Disconnect()
	end)
	task.delay(config.decal_cleanup_time - 0.5, function()
		pcall(function()
			TweenService:Create(bloodHole.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Transparency = 1}):Play()
			TweenService:Create(wound, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {Transparency = 1}):Play()
		end)
	end)
	task.delay(config.decal_cleanup_time, function()
		charConnection:Disconnect()
		kill_wound(woundIndex)
	end)
end

UserInputService.InputBegan:Connect(function(input, typing)
	if (not typing) then
		if (input.UserInputType == Enum.UserInputType.MouseButton1 and character:FindFirstChild("Head") and equippingGun and gunTool) then
			local gunData, unique_id = findTool(gunTool)
			if (tick() - delay < gunData.settings.rate) then
				return
			end
			
			local function fire()
				lastActive = tick()
				
				local origin, dir = mouse.UnitRay.Origin, mouse.UnitRay.Direction
				if (gunData.settings.shotgun.enabled) then
					dir += Vector3.new(
						math.random(-100, 100) / 5000 * gunData.settings.shotgun.spreadness,
						math.random(-100, 100) / 5000 * gunData.settings.shotgun.spreadness,
						math.random(-100, 100) / 5000 * gunData.settings.shotgun.spreadness
					)
				end
				dir *= 1e4
				-- // bullet tracer
				local startTracer, endTracer = Assets.Miscs.bulletTracer.start:Clone(), Assets.Miscs.bulletTracer["end"]:Clone()
				local beamTracer = Assets.Miscs.bulletTracer.Beam:Clone()
				beamTracer.Attachment0 = startTracer
				beamTracer.Attachment1 = endTracer
				startTracer.Parent, endTracer.Parent = workspace.Terrain, workspace.Terrain
				beamTracer.Parent = workspace.Terrain
				startTracer.WorldPosition = gunTool.Handle.Muzzle.WorldPosition
				
				local cast = workspace:Raycast(origin, dir, params)
				if (cast) then
					endTracer.WorldPosition = cast.Position
					local startLine, endLine = debugLine(origin, cast.Position, 1)
					if (startLine) then
						startLine.Beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
					end
					local model = findHumanoid(cast.Instance)
					if (model) then
						local ignore = {workspace.Ignored, model}
						local originPos = cast.Position + cast.Normal / 20
						
						local hitPoint = CFrame.new(originPos, originPos + cast.Normal)
						local objectSpace = model.Torso.CFrame:toObjectSpace(hitPoint)
						local lastHealth = model.Humanoid.Health
						Network:FireServer("hit", model, cast.Instance, cast.Position + dir, objectSpace, gunData.settings)
						local death, damage = false, cast.Instance.Name == "Head" and gunData.settings.damage * gunData.settings.critical or gunData.settings.damage
						if (model.Humanoid.Health - damage <= 0 and lastHealth > 0 and not model.Head:FindFirstChild("gurgle")) then
							for _,sound in pairs(model.Head:GetChildren()) do
								if (sound.Name == "hurt") then
									sound:Destroy()
								end
							end
							local gurgle
							while true do
								gurgle = getRandomChild(Assets.Sounds.gurgles)
								if (gurgle ~= lastGurgle) then
									break
								end
								task.wait()
							end
							lastGurgle = gurgle
							playsound(gurgle, model.Head, 0.2)
							
							death = true
						end
						
						local damageStreak = model.Humanoid:FindFirstChild("damage_streak")
						if (not damageStreak) then
							damageStreak = Instance.new("NumberValue")
							damageStreak.Name = "damage_streak"
							damageStreak.Parent = model.Humanoid
						end
						
						damageStreak.Value += gunData.settings.damage
						
						-- // gibs system
						local gib, dist = getGibFromPosition(cast.Instance, cast.Position)
						if (gib and (gunData.settings.damage >= 20 or damageStreak.Value >= 30) and gunData.settings.dismember) then
							-- // head gib
							if (cast.Instance.Name == "Head") then
								if (not cast.Instance:FindFirstChild("GIBS")) then
									for _,wound in pairs(cast.Instance:GetChildren()) do
										if (wound.Name == "wound") then
											wound:Destroy()
										end
									end

									cast.Instance.Transparency = 1
									local gibModel = getRandomChild(Assets.Gibs.Head[gib]):Clone()
									if (gibModel.Transparency < 1) then
										gibModel.Color = cast.Instance.Color
									else
										for _,skin in pairs(gibModel:GetChildren()) do
											if (skin.Name == "Skin") then
												skin.Color = cast.Instance.Color
											end
										end
									end
									-- // remove accessories
									for _,handle in pairs(model:GetDescendants()) do
										if (handle:IsA("Part") and (handle:FindFirstChild("HatAttachment") or handle:FindFirstChild("FaceFrontAttachment") or handle:FindFirstChild("FaceCenterAttachment") or handle:FindFirstChild("HairAttachment"))) then
											for _,stuff in pairs(handle:GetChildren()) do
												if (stuff:IsA("Attachment") or stuff:IsA("Weld")) then
													stuff:Destroy()
												end
											end
											--[[if (not handle:FindFirstChild("HairAttachment")) then
												handle:BreakJoints()
												handle.CanCollide = true
												handle.CollisionGroupId = 3
												local accessory = handle.Parent
												handle.Velocity = dir.unit * math.random(15, 20)
												handle.Parent = workspace.Ignored
												local connection
												connection = model.Destroying:Connect(function()
													connection:Disconnect()
													handle:Destroy()
												end)
												accessory:Destroy()
											else
												handle.Parent:Destroy()
											end]]
											handle.Parent:Destroy()
										end
									end
									--
									gibModel.Name = model.Name .. "_" .. gibModel.Name
									gibModel.Parent = workspace.Ignored
									local gibs = Instance.new("ObjectValue")
									gibs.Name = "GIBS"
									gibs.Value = gibModel
									gibs.Parent = cast.Instance
									if (gib ~= "Bottom") then
										local weld = Instance.new("Weld")
										weld.Part0 = cast.Instance
										weld.Part1 = gibModel
										weld.Parent = gibModel
									else
										local neckModel = Assets.Gibs.Neck:Clone()
										neckModel.Skin.Color = cast.Instance.Color
										neckModel.Parent = gibModel
										local neckWeld = Instance.new("Weld")
										neckWeld.Part0 = cast.Instance
										neckWeld.Part1 = neckModel
										neckWeld.Parent = neckModel
										cast.Instance.CollisionGroupId = 2
										gibModel.CFrame = cast.Instance.CFrame
										gibModel.Velocity = dir.unit 
											* math.random(80, 100)
											+ Vector3.new(0, math.random(20, 30), 0)
										local totalMass = gibModel:GetMass()
										for _,part in pairs(gibModel:GetChildren()) do
											if (part:IsA("BasePart")) then
												totalMass += part:GetMass()
											end
										end
										local force = Instance.new("BodyForce")
										force.Force = Vector3.new(0, totalMass * 120, 0)
										force.Parent = gibModel
										gibModel.Velocity = getClampedVel(gibModel.Velocity, 50)
										task.spawn(function()
											local blood_settings = {
												["spreadness"] = 2,
												["amount"] = math.random(15, 20),
												["process"] = {15, 20, 100},
												["size"] = {60, 150, 100},
												["tweenIn"] = TweenInfo.new(0.8, Enum.EasingStyle.Quint),
												["mode"] = "track",
												["parent"] = neckModel,
												["drain"] = true,
											}
											handleBlood(neckModel, cast.Position + (cast.Normal / 100), neckModel.CFrame.UpVector * math.random(150, 200), {model, cast.Instance, workspace.Ignored}, blood_settings)
										end)
										task.spawn(function()
											local blood_settings = {
												["spreadness"] = 1.1,
												["amount"] = math.random(4, 6),
												["process"] = {150, 300, 100},
												["size"] = {60, 300, 100},
												["tweenIn"] = TweenInfo.new(5, Enum.EasingStyle.Quint),
												["mode"] = "track",
												["parent"] = gibModel,
												["drain"] = true,
											}
											handleBlood(gibModel, gibModel.Position, gibModel.CFrame.UpVector * -math.random(5, 10), {model, cast.Instance, workspace.Ignored}, blood_settings)
										end)
									end
									local connection
									connection = model.Destroying:Connect(function()
										connection:Disconnect()
										gibModel:Destroy()
									end)
									local decal = cast.Instance:FindFirstChildWhichIsA("Decal")
									local decal1 = gibModel:FindFirstChildWhichIsA("Decal")
									if (decal1 and decal) then
										decal1.Texture = decal.Texture
										decal:Destroy()
									end
									local originNormal = character.Head.CFrame.LookVector
									local cur = 0
									for _,gib in pairs(Assets.Gibs.Debris:GetChildren()) do
										local force = originNormal - (2 * originNormal:Dot(cast.Normal) * cast.Normal)
										local dir = force * math.random(15, 35) + Vector3.new(0, math.random(5, 15), 0)
										local gib = gib:Clone()
										gib.CFrame = cast.Instance.CFrame + Vector3.new(math.random(-1, 1) / 10, math.random(-1, 1) / 10, math.random(-1, 1) / 10)
										gib.Velocity = dir + Vector3.new(
											math.random(-500, 500) / 100,
											math.random(-500, 500) / 100,
											math.random(-500, 500) / 100
										)
										gib.RotVelocity = gib.Velocity / 2
										gib.Color = cast.Instance.Color
										gib.Parent = workspace.Ignored
										Debris:AddItem(gib, 0.85)
										local force = Instance.new("BodyForce")
										force.Force = Vector3.new(0, gib:GetMass() * 100, 0)
										force.Parent = gib
										cur += 1
										if (math.random(3) == 1 and cur > 1) then
											break
										end
									end
								else
									local gibObject = cast.Instance.GIBS.Value
									gibObject:Destroy()
									local neckModel = Assets.Gibs.Neck:Clone()
									neckModel.Skin.Color = cast.Instance.Color
									neckModel.Parent = workspace.Ignored
									local neckWeld = Instance.new("Weld")
									neckWeld.Part0 = cast.Instance
									neckWeld.Part1 = neckModel
									neckWeld.Parent = neckModel
									cast.Instance.CollisionGroupId = 2
									cast.Instance.GIBS.Value = neckModel
									task.spawn(function()
										local blood_settings = {
											["spreadness"] = 2,
											["amount"] = math.random(15, 20),
											["process"] = {15, 20, 100},
											["size"] = {60, 150, 100},
											["tweenIn"] = TweenInfo.new(0.8, Enum.EasingStyle.Quint),
											["mode"] = "track",
											["parent"] = neckModel,
											["drain"] = true,
										}
										handleBlood(neckModel, cast.Position + (cast.Normal / 100), neckModel.CFrame.UpVector * math.random(150, 200), {model, cast.Instance, workspace.Ignored}, blood_settings)
									end)

									local connection
									connection = model.Destroying:Connect(function()
										connection:Disconnect()
										neckModel:Destroy()
									end)

									cast.Instance:ClearAllChildren()
								end
							elseif (string.find(cast.Instance.Name, "Arm") or string.find(cast.Instance.Name, "Leg")) then
								if (not cast.Instance:FindFirstChild("GIBS")) then
									for _,sound in pairs(model.Head:GetChildren()) do
										if (sound.Name == "hurt") then
											sound:Destroy()
										end
									end
									local sound = playsound(getRandomChild(Assets.Sounds.hurt), model.Head, 0.25)
									sound.Name = "hurt"
									for _,wound in pairs(cast.Instance:GetChildren()) do
										if (wound.Name == "wound") then
											wound:Destroy()
										end
									end

									cast.Instance.Transparency = 1
									local gibModel = getRandomChild(Assets.Gibs.Limbs[gib]):Clone()
									for _,skin in pairs(gibModel:GetDescendants()) do
										if (skin:IsA("BasePart") and (skin.Name == "Skin" or skin.Name == "Debris")) then
											skin.Color = cast.Instance.Color
										end
									end
									local weld = Instance.new("Weld")
									weld.Part0 = cast.Instance
									weld.Part1 = gibModel.Attach
									weld.Parent = gibModel
									
									--[[local shirtInstance = model:FindFirstChildWhichIsA("Shirt")
									if (shirtInstance and gibModel.Attach:FindFirstChild("Skin")) then
										local shirt = Instance.new("SurfaceAppearance")
										shirt.Parent = gibModel.Attach.Skin
										shirt.ColorMap = shirtInstance.ShirtTemplate
									end]]
									
									gibModel.Name = model.Name .. "_" .. gibModel.Name
									gibModel.Parent = workspace.Ignored
									local gibs = Instance.new("ObjectValue")
									gibs.Name = "GIBS"
									gibs.Value = gibModel
									gibs.Parent = cast.Instance
									
									local debrisWeld = gibModel.Attach:FindFirstChild("Debris")
									if (debrisWeld) then 
										task.delay(1 / 30, function()
											debrisWeld:Destroy()
											
											gibModel.Debris.Velocity = (dir.unit * math.random(5, 10)) + Vector3.new(
												math.random(-100, 100) / 100,
												math.random(-100, 100) / 100,
												math.random(-100, 100) / 100
											)
											gibModel.Debris.RotVelocity = gibModel.Debris.Velocity
											local force = Instance.new("BodyForce")
											force.Force = Vector3.new(0, gibModel.Debris:GetMass() * 120, 0)
											force.Parent = gibModel.Debris
										end)
									end
									
									task.spawn(function()
										local blood_settings = {
											["spreadness"] = 2,
											["amount"] = math.random(15, 20),
											["process"] = {15, 20, 100},
											["size"] = {60, 150, 100},
											["tweenIn"] = TweenInfo.new(0.8, Enum.EasingStyle.Quint),
											["mode"] = "track",
											["parent"] = gibModel.Attach,
											["drain"] = true,
											["meat"] = true,
											["meatAmount"] = math.random(6, 8)
										}
										handleBlood(gibModel.Attach, cast.Position + (cast.Normal / 100), dir.unit * math.random(20, 30), {model, cast.Instance, workspace.Ignored}, blood_settings)
									end)
									
									if (gibModel:FindFirstChild("Debris")) then
										task.spawn(function()
											local blood_settings = {
												["spreadness"] = 2,
												["amount"] = math.random(8, 12),
												["process"] = {45, 50, 100},
												["size"] = {60, 240, 100},
												["tweenIn"] = TweenInfo.new(0.8, Enum.EasingStyle.Quint),
												["mode"] = "track",
												["parent"] = gibModel.Debris,
												["drain"] = true,
											}
											handleBlood(gibModel.Debris, cast.Position + (cast.Normal / 100), gibModel.Debris.CFrame.UpVector * -5, {model, cast.Instance, workspace.Ignored}, blood_settings)
										end)
									end
									
									local connection
									connection = model.Destroying:Connect(function()
										connection:Disconnect()
										gibModel:Destroy()
									end)
									
									local originNormal = character.Head.CFrame.LookVector
									local cur = 0
									for _,gib in pairs(Assets.Gibs.Debris:GetChildren()) do
										local force = originNormal - (2 * originNormal:Dot(cast.Normal) * cast.Normal)
										local dir = force * math.random(15, 35) + Vector3.new(0, math.random(5, 15), 0)
										local gib = gib:Clone()
										gib.CFrame = cast.Instance.CFrame + Vector3.new(math.random(-1, 1) / 10, math.random(-1, 1) / 10, math.random(-1, 1) / 10)
										gib.Velocity = dir + Vector3.new(
											math.random(-500, 500) / 100,
											math.random(-500, 500) / 100,
											math.random(-500, 500) / 100
										)
										gib.RotVelocity = gib.Velocity / 2
										gib.Color = cast.Instance.Color
										gib.Parent = workspace.Ignored
										Debris:AddItem(gib, 0.85)
										local force = Instance.new("BodyForce")
										force.Force = Vector3.new(0, gib:GetMass() * 100, 0)
										force.Parent = gib
										cur += 1
										if (math.random(3) == 1 and cur > 1) then
											break
										end
									end
								else
									
								end
							end
						end
						--
						
						playsound(getRandomChild(Assets.Sounds.bullet_flesh), cast.Position, 0.5)
						if (not cast.Instance:FindFirstChild("GIBS")) then
							-- // blood and wounds
							handleWound(cast, model, originPos)
							--

							-- // exit wound
							do
								local params = RaycastParams.new()
								params.FilterDescendantsInstances = {model}
								params.FilterType = Enum.RaycastFilterType.Whitelist
								params.CollisionGroup = "Raycast"
								local origin, dir1 = cast.Position + dir.unit * getSize(cast.Instance), dir.unit * -dir.magnitude
								local cast = workspace:Raycast(origin, dir1, params)
								local startLine, endLine
								if (cast) then
									startLine, endLine = debugLine(origin, cast.Position)
									if (startLine) then
										startLine.Beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
									end
									handleWound(cast, model, cast.Position + cast.Normal / 20)
									local blood_settings = {
										["spreadness"] = 2,
										["amount"] = math.random(10, 12),
										["process"] = {10, 15, 100},
										["size"] = {50, 140, 100},
										["mode"] = "track",
										["parent"] = cast.Instance,
										["tweenIn"] = TweenInfo.new(0.5, Enum.EasingStyle.Sine),
										["drain"] = true,
									}
									task.spawn(function()
										handleBlood(model, cast.Position + cast.Normal / 20, dir.unit * 50, ignore, blood_settings)
									end)
								else
									startLine, endLine = debugLine(origin, dir1) 
								end
							end
							--
						end
						
						-- // reflect blood
						if (math.random(5) == 1 or death) then
							task.spawn(function()
								local originNormal = character.Head.CFrame.LookVector
								-- // ray reflection
								local force = originNormal - (2 * originNormal:Dot(cast.Normal) * cast.Normal)
								local dir = force * math.random(15, 20) + Vector3.new(0, math.random(5, 10), 0)
								local amount = (gunData.settings.shotgun.enabled and gunData.settings.damage / gunData.settings.shotgun.amount or gunData.settings.damage) * 3.5
								local blood_settings = {
									["spreadness"] = 2,
									["amount"] = math.random(amount / 2, amount),
									["process"] = {10, 15, 100},
									["size"] = {15, 40, 100},
									["mode"] = "track",
									["parent"] = cast.Instance.Name == "HumanoidRootPart" and cast.Instance.Parent.Torso or cast.Instance,
									["tweenIn"] = TweenInfo.new(0.25, Enum.EasingStyle.Quint),
									["drain"] = true;
								}
								handleBlood(model, cast.Position, dir, ignore, blood_settings)
							end)
						end
						---

						-- // reflect fast blood
						task.spawn(function()
							local originNormal = character.Head.CFrame.LookVector
							-- // ray reflection
							local force = originNormal - (2 * originNormal:Dot(cast.Normal) * cast.Normal)
							local dir = force * math.random(10, 15) + Vector3.new(0, math.random(5), 0)
							local amount = (gunData.settings.shotgun.enabled and gunData.settings.damage / gunData.settings.shotgun.amount or gunData.settings.damage) / 5
							local blood_settings = {
								["spreadness"] = 30,
								["amount"] = math.random(amount / 2, amount),
								["process"] = {1, 2, 500},
								["size"] = {15, 40, 100},
								["mode"] = "track",
								["parent"] = cast.Instance.Name == "HumanoidRootPart" and cast.Instance.Parent.Torso or cast.Instance,
								["tweenIn"] = TweenInfo.new(0.25, Enum.EasingStyle.Quint),
							}
							handleBlood(model, cast.Position, dir, ignore, blood_settings)
						end)
						---

						-- // piercing blood
						local amount = (gunData.settings.shotgun.enabled and gunData.settings.damage / gunData.settings.shotgun.amount or gunData.settings.damage) / 2
						local blood_settings = {
							["spreadness"] = 3,
							["amount"] = math.random(amount / 2, amount),
							["process"] = {1, 2, 500},
							["size"] = {15, 80, 100},
							["tweenIn"] = TweenInfo.new(0.05, Enum.EasingStyle.Quint),
							["singleSegment"] = true;
							["meat"] = cast.Instance.Name == "Head",
							["meatAmount"] = math.random(amount / 2, amount),
						}
						handleBlood(model, cast.Position, mouse.UnitRay.Direction * 50, ignore, blood_settings)
						---
					else
						local bulletHole = Assets.Bloods.bulletHole:Clone()
						local size = math.random(25, 30) / 100
						bulletHole.Size = Vector3.new(size, 0, size)
						bulletHole.CFrame = CFrame.new(cast.Position, cast.Position + cast.Normal) * CFrame.Angles(math.rad(-90), math.rad(math.random(-90, 90)), 0)
						bulletHole.Parent = cast.Instance
						local weld = Instance.new("WeldConstraint")
						weld.Part0 = cast.Instance.Name == "HumanoidRootPart" and cast.Instance.Parent.Torso or cast.Instance
						weld.Part1 = bulletHole
						weld.Parent = bulletHole
						Debris:AddItem(bulletHole, config.decal_cleanup_time)
						task.delay(config.decal_cleanup_time - 0.5, function()
							pcall(function()
								TweenService:Create(bulletHole.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Transparency = 1}):Play()
							end)
						end)
					end
				else
					debugLine(origin, origin + dir, 1)
					endTracer.WorldPosition = origin + dir
				end

				-- // beam transparency tween
				local current = 0.9
				local connection
				connection = RunService.RenderStepped:Connect(function(dt)
					dt *= 60

					if (current >= 1 or not beamTracer:IsDescendantOf(workspace)) then
						connection:Disconnect()
						return
					end

					current = lerp(current, 1, 0.05 * dt)
					beamTracer.Transparency = NumberSequence.new(current)
				end)
				Debris:AddItem(startTracer, 1.5)
				Debris:AddItem(endTracer, 1.5)
				Debris:AddItem(beamTracer, 1.5)
			end
			
			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
				if (tick() - delay >= gunData.settings.rate and tick() - equipDelay >= gunData.settings.equip_time) then
					delay = tick()
					Assets.Events.ToolLoader:Fire(gunTool, "stopAnims", {"idle"}, unique_id)
					Assets.Events.ToolLoader:Fire(gunTool, "anims", "fire", unique_id)
					local recoil = Vector3.new(
						math.random(gunData.settings.recoil.x[1], gunData.settings.recoil.x[2]),
						math.random(gunData.settings.recoil.y[1], gunData.settings.recoil.y[2]),
						math.random(gunData.settings.recoil.z[1], gunData.settings.recoil.z[2])
					)
					springCam.Speed = gunData.settings.recoil_speed
					springCam.Damper = gunData.settings.recoil_damp
					springCam:Impulse(recoil)
					task.delay(1 / 15, function()
						springCam.Speed = gunData.settings.recoil_speed * gunData.settings.recoil_back_threshold
						springCam.Damper = gunData.settings.recoil_damp / gunData.settings.recoil_back_threshold
						springCam:Impulse(-recoil / gunData.settings.recoil_back)
					end)
					
					playsound(getRandomChild(gunTool.Sounds.Fire), gunTool.Handle.Muzzle, 0.4)
					playsound(gunTool.Sounds.Echo, gunTool.Handle.Muzzle, 0.6)
					for _,instance in pairs(gunTool.Handle.Muzzle:GetChildren()) do
						if (instance:IsA("ParticleEmitter")) then
							instance:Emit(instance.Rate)
						elseif (instance.Name == "FlashLight") then
							local newInstance = instance:Clone()
							newInstance.Name = ""
							newInstance.Enabled = true
							newInstance.Parent = gunTool.Handle.Muzzle
							Debris:AddItem(newInstance, 1 / 40)
						end
					end
					if (gunData.settings.shotgun.enabled) then
						for k = 1, gunData.settings.shotgun.amount do
							task.spawn(fire)
						end
					else
						task.spawn(fire)
					end
					
					if (not gunData.settings.auto) then
						break
					end
				end
				
				task.wait()
			end
		end
	end
end)

task.spawn(function()
	while humanoid.Health > 0 and humanoid.RootPart and humanoid:IsDescendantOf(workspace) do
		for index,data in pairs(bloodParts) do
			if (data.part and data.placed) then
				if (getDistance(data.part, camera.CFrame.Position) > config.blood_render_distance) then
					data.part.Parent = nil
				elseif (not destroyed(data.part)) then
					data.part.Parent = workspace.Ignored
				end
			end
		end
		
		for index,data in pairs(woundParts) do
			if (woundParts[index]) then
				for _,part in pairs(data) do
					if (getDistance(part, camera.CFrame.Position) > config.wound_render_distance) then
						part.Parent = nil
					elseif (not destroyed(part)) then
						part.Parent = workspace.Ignored
					end
				end
			end
		end
		
		for index,data in pairs(meatParts) do
			if (meatParts[index]) then
				if (getDistance(meatParts[index], camera.CFrame.Position) > config.meat_render_distance) then
					meatParts[index].Parent = nil
				elseif (not destroyed(meatParts[index])) then
					meatParts[index].Parent = workspace.Ignored
				end
			end
		end

		task.wait(config.render_process)
	end
end)

RunService.RenderStepped:Connect(function(dt)
	dt *= 60
	
	local DOFCast = workspace:Raycast(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 1e4, params)
	if (DOFCast) then
		DOFPos = DOFCast.Position
	else
		DOFPos = mouse.UnitRay.Direction * 1e4
	end
	
	local originMath = (mouse.UnitRay.Origin - DOFPos)
	local m = originMath.magnitude
	local depthOfField = Lighting.DepthOfField
	depthOfField.InFocusRadius = lerp(depthOfField.InFocusRadius, m, 0.1 * dt)
	if (depthOfField.InFocusRadius > 100) then
		depthOfField.InFocusRadius = lerp(depthOfField.InFocusRadius, 100, 0.1 * dt)
	elseif (depthOfField.InFocusRadius < 80) then
		depthOfField.InFocusRadius = lerp(depthOfField.InFocusRadius, m, 0.1 * dt)
	end 
	
	player.CameraMinZoomDistance = 5
	player.CameraMaxZoomDistance = 5
	
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	mouse.Icon = "rbxassetid://68308747"
	
	if (equippingGun and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) then
		lastActive = tick()
		aimFOV = -25
		cameraOffset = lerp(cameraOffset, 2.5, 0.2 * dt)
		neckTilt = lerp(neckTilt, -35, 0.35 * dt)
	else
		aimFOV = 0
		cameraOffset = lerp(cameraOffset, 1.5, 0.15 * dt)
		neckTilt = lerp(neckTilt, 0, 0.65 * dt)
	end
	
	local rightMouse = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
	if (tick() - lastActive >= config.combat_time and (not rightMouse or rightMouse and not equippingGun)) then
		if (bodyGyro:IsDescendantOf(workspace)) then
			bodyGyro.Parent = nil
		end
		humanoid.AutoRotate = true
	else
		humanoid.AutoRotate = false
		local dir = camera.CFrame.LookVector * 1e4
		bodyGyro.CFrame = CFrame.new(humanoid.RootPart.Position, Vector3.new(dir.x, humanoid.RootPart.Position.y, dir.z))
		bodyGyro.Parent = humanoid.RootPart
	end
	
	camera.CFrame *= CFrame.new(cameraOffset, 0, 0) 
		* CFrame.Angles(
			math.rad(springCam.Position.y * dt),
			math.rad(springCam.Position.x * dt),
			math.clamp(math.rad(springCam.Position.x * 5 * dt), -0.025, 0.025)
		)
	
	local cameraDir = humanoid.RootPart.CFrame:toObjectSpace(camera.CFrame).LookVector
	if (neck) then
		TweenService:Create(neck, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
			C0 = CFrame.new(0, defaultNeck.y, 0) 
				* CFrame.Angles(3 * math.pi / 2, 0, math.pi) 
				* CFrame.Angles(0, 0, -math.asin(cameraDir.x)) 
				* CFrame.Angles(-math.asin(cameraDir.y), 0, 0)
				* CFrame.Angles(0, math.rad(neckTilt), 0)
		}):Play()
	end
	local _, _, rightZ = rightShoulder.C0:toEulerAnglesYXZ()
	TweenService:Create(rightShoulder, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
		C0 = rightShoulder.C0 
			* CFrame.Angles(0, 0, -rightZ)
			* CFrame.Angles(0, 0, math.asin(cameraDir.unit.y))
	}):Play()

	local _, _, leftZ = leftShoulder.C0:toEulerAnglesYXZ()
	TweenService:Create(leftShoulder, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
		C0 = leftShoulder.C0 
			* CFrame.Angles(0, 0, -leftZ)
			* CFrame.Angles(0, 0, math.asin(-cameraDir.unit.y))
	}):Play()
	
	TweenService:Create(camera, TweenInfo.new(2, Enum.EasingStyle.Quint), {FieldOfView = 70 + aimFOV}):Play()
	UserInputService.MouseDeltaSensitivity = math.min(camera.FieldOfView / 70, default_sens)
end)