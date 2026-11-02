local module = {}
module.__index = module

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Assets = ReplicatedStorage:WaitForChild("Assets")

local limbsToMotor = {
	["Head"] = "Neck",
	["Right Arm"] = "Right Shoulder",
	["Right Leg"] = "Right Hip",
	["Left Arm"] = "Left Shoulder",
	["Left Leg"] = "Left Hip",
}

local motorToLimbs = {
	["Neck"] = "Neck",
	["Right Shoulder"] = "Right Arm",
	["Right Hip"] = "Right Leg",
	["Left Shoulder"] = "Left Arm",
	["Left Hip"] = "Left Leg",
}

local config = {
	debug = false;
}

local euphoriaAnims = {
	["Normal"] = {
		10045050849,
	};
	["Arm"] = {
		["Left Arm"] = {
			10045055011,
			10045059933
		},
		["Right Arm"] = {
			10045068707,
			10045075842
		},
	};
	["Head"] = {
		10045080545,
		10045084065,
		10045088165,
		10045093666,
		10045098742
	};
	["Leg"] = {
		["Right Leg"] = {
			10045102505,
		},
		["Left Leg"] = {
			10045107536,
		}
	};
}

function module.create(character, euphoria)
	local player = Players:GetPlayerFromCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.BreakJointsOnDeath = false
	local ragdollStuff = {}
	local collisions = {}
	local muscles = euphoria and Assets.Ragdoll.Muscles.Bones:Clone()
	local musclesSprings = {}
	local euphoriaState = false
	if (muscles) then
		local connection
		connection = character.Destroying:Connect(function()
			connection:Disconnect()
			muscles:Destroy()
		end)
		muscles.Name = character.Name .. "__muscles"
		muscles.Parent = workspace.Ignored.Muscles
		muscles.Humanoid.PlatformStand = true
		local weld = Instance.new("Weld")
		weld.Part0 = character.Torso
		weld.Part1 = muscles.Torso
		weld.Parent = character
		if (config.debug) then
			for _,part in pairs(muscles:GetDescendants()) do
				if (part:IsA("BasePart") and part ~= muscles.Humanoid.RootPart) then
					part.Transparency = 0.75
				elseif (part:IsA("Attachment")) then
					part.Visible = true
				elseif (part:IsA("Beam")) then
					part.Enabled = true
				end
			end
		end
		
		for _,bone in pairs(muscles:GetDescendants()) do
			if (bone:IsA("Attachment")) then
				local charBone = character:FindFirstChild(bone.Name, true)
				if (charBone) then
					local spring = Instance.new("SpringConstraint")
					spring.Attachment0 = bone
					spring.Attachment1 = charBone
					spring.LimitsEnabled = true
					spring.MaxLength = bone.Length.Value
					spring.Enabled = false
					spring.Name = bone.Parent.Name
					spring.Parent = bone.Parent
					musclesSprings[#musclesSprings + 1] = spring
					
					local bone2 = bone.Parent:FindFirstChild(bone.Name .. "1")
					if (bone2) then
						local a0 = bone2:Clone()
						a0.Parent = charBone.Parent
						local spring = Instance.new("SpringConstraint")
						spring.Attachment0 = a0
						spring.Attachment1 = bone.Parent[bone.Name .. "1"]
						spring.LimitsEnabled = true
						spring.MaxLength = bone2.Length.Value
						spring.Enabled = false
						spring.Name = bone.Parent.Name
						spring.Parent = bone.Parent
						musclesSprings[#musclesSprings + 1] = spring
					end
				end
			end
		end
		
		humanoid.RootPart:SetNetworkOwner(nil)
	end
	for _,part in pairs(character:GetChildren()) do
		local validPart = Assets.Ragdoll:FindFirstChild(part.Name)
		if (validPart) then
			part.CanCollide = false
			local a0, a1 = validPart["0"]:Clone(), validPart["1"]:Clone()
			local socket = validPart.Socket:Clone()
			socket.Attachment0 = a0
			socket.Attachment1 = a1
			socket.Parent = part
			a0.Parent = character.Torso
			a1.Parent = part
			ragdollStuff[#ragdollStuff + 1] = a0
			ragdollStuff[#ragdollStuff + 1] = a1
			ragdollStuff[#ragdollStuff + 1] = socket
			
			local collisionPart = validPart.collision:Clone()
			collisionPart.Weld.Part0 = part
			collisionPart.Name = part.Name
			collisionPart.Parent = part
			collisions[#collisions + 1] = collisionPart
		end
	end
	
	local event = Instance.new("BindableEvent")
	local connections = {}
	local forces = {}
	
	table.insert(connections, humanoid.Died:Connect(function()
		event:Fire("switch", true, euphoriaState)
	end))
	
	humanoid:SetAttribute("Ragdoll", false)
	local function charFunc(type, ...)
		if (type == "clean") then
			for index,con in pairs(connections) do
				con:Disconnect()
				connections[index] = nil
			end
			for index,stuff in pairs(ragdollStuff) do
				stuff:Destroy()
				ragdollStuff[index] = nil
			end
			event:Destroy()
		elseif (type == "switch") then
			local boolean, euphoria, part = ...
			if (character:FindFirstChild("Torso")) then
				humanoid:SetAttribute("Ragdoll", boolean)
				local noMess = {}
				for _,motor in pairs(character.Torso:GetChildren()) do
					if (motor:IsA("Motor6D") and not motor:FindFirstChild("no")) then
						motor.Enabled = not boolean
					elseif (motor:FindFirstChild("no")) then
						noMess[motor.Name] = true
					end
				end
				
				if (boolean and euphoria) then
					for _,socket in pairs(ragdollStuff) do
						if (socket:IsA("BallSocketConstraint") and socket.Parent.Name ~= "Head" --[[and socket.Parent ~= part]]) then
							socket.Enabled = false
						end
					end
				else
					for _,socket in pairs(ragdollStuff) do
						if (socket:IsA("BallSocketConstraint")) then
							socket.Enabled = true
						end
					end
				end
				
				for _,part in pairs(collisions) do
					if (not noMess[part.Name]) then
						part.CanCollide = boolean
					end
				end
				
				-- // ragdoll state
				if (not player) then
					if (boolean) then
						if (#forces < 1) then
							for _,part in pairs(character:GetChildren()) do
								if (part:IsA("BasePart") and part.Name ~= "HumanoidRootPart") then
									local force = Instance.new("BodyForce")
									force.Force = Vector3.new(0, part:GetMass() * 50, 0)
									force.Parent = part
									forces[#forces + 1] = force
								end
							end
						end
						
						humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
						humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
						humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
						humanoid.PlatformStand = true
					else
						for index,force in pairs(forces) do
							force:Destroy()
							forces[index] = nil
						end
						forces = {}
						humanoid.PlatformStand = false
						humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
						local connection
						connection = humanoid.StateChanged:Connect(function(_,current)
							if (current == Enum.HumanoidStateType.GettingUp or humanoid.Health < 1) then
								humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
								humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
								humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
								connection:Disconnect()
							end
						end)
					end
				end
				
				humanoid.RootPart:SetNetworkOwner(nil)
			end
		elseif (type == "muscles") then
			local state, part, disableTime, playTime = ...
			for _,spring in pairs(musclesSprings) do
				--[[if ((state and spring.Name ~= part.Name) or humanoid.Health <= 0) then
					spring.Enabled = true
				else
					task.delay(disableTime or 16e-6, function()
						spring.Enabled = false
					end)
				end]]
				
				if (state or humanoid.Health <= 0) then
					spring.Enabled = true
				else
					task.delay(disableTime or 16e-6, function()
						spring.Enabled = false
					end)
				end
			end
			euphoriaState = state
			event:Fire("switch", (state or humanoid.Health <= 0), true, part)
			if (state) then
				for _,anim in pairs(muscles.Humanoid:GetPlayingAnimationTracks()) do
					anim:Stop()
				end
				local animId
				for index,t in pairs(euphoriaAnims) do
					if (string.find(part.Name, index)) then
						animId = t[part.Name] and t[part.Name][math.random(#t[part.Name])] or t[math.random(#t)]	
						break
					else
						animId = euphoriaAnims.Normal[math.random(#euphoriaAnims.Normal)]
					end
				end
				local animTrack = Instance.new("Animation")
				animTrack.AnimationId = "rbxassetid://" .. animId
				local anim = muscles.Humanoid.Animator:LoadAnimation(animTrack)
				anim:Play()
				anim:AdjustWeight(math.random(8, 10) / 10)
				animTrack:Destroy()
				task.spawn(function()
					local startTick = tick()
					while euphoriaState and character:IsDescendantOf(workspace) and tick() - startTick < playTime - 0.5 do
						task.wait(1 / 30)
					end
					anim:AdjustWeight(0, playTime - 0.5)
				end)
			else
				for _,anim in pairs(muscles.Humanoid:GetPlayingAnimationTracks()) do
					anim:Stop(0.5)
				end
			end
		end
	end
	
	table.insert(connections, event.Event:Connect(function(...)
		charFunc(...)
	end))
	
	return setmetatable({
		character = character,
		humanoid = humanoid,
		event = event,
		ragdoll = false,
		euphoria = false,
		dur = 0,
		connections = connections
	}, module)
end

function module.setGlobal(...)
	script._signal:Fire(...)
end

function module:registerEvent()
	table.insert(self.connections, script._signal.Event:Connect(function(char, func, ...)
		if (char == self.character) then
			if (func == "set") then
				self:set(...)
			elseif (func == "setLimb") then
				self:setLimb(...)
			elseif (func == "muscles") then
				self:muscles(func, ...)
			end
		end
	end))
end

function module:getTime()
	return tick() - self.dur
end

function module:set(state, timer)
	if (state) then
		self.dur = tick()
	else
		self.ragdoll = false
		return
	end
	
	if (not self.ragdoll) then
		self.ragdoll = true
		self.event:Fire("switch", true, self.euphoria)
		
		task.spawn(function()
			while self.character:IsDescendantOf(workspace) and self.humanoid.Health > 0 and self:getTime() < (timer or math.huge) and self.ragdoll do
				task.wait(1 / 30)
			end
			
			if (self.humanoid.Health > 0 and not self.euphoria) then
				self.ragdoll = false
				if (self.character:IsDescendantOf(workspace)) then
					self.event:Fire("switch", false, self.euphoria)
				else
					self:destroy()
				end
			end
		end)
	end
end

function module:setLimb(limb, state)
	local motor = self.character.Torso[limbsToMotor[limb]]
	motor.Enabled = state
	if (not state and not motor:FindFirstChild("no")) then
		local no = Instance.new("StringValue")
		no.Name = "no"
		no.Parent = motor
	elseif (state) then
		local findMotor = motor:FindFirstChild("no")
		if (findMotor) then findMotor:Destroy() end
	end
end

function module:muscles(func, state, ...)
	self.euphoria = state
	self.event:Fire(func, state, ...)
end

function module:destroy()
	--self.character:Destroy()
	self.event:Fire("clean")
	for index,_ in pairs(self) do
		self[index] = nil
	end
end

function module:Destroy()
	return self:destroy()
end

return module