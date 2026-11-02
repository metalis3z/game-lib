local tool = script.Parent
local canFire = true
local gunWeld

-----------------
--| Constants |--
-----------------

local GRAVITY_ACCELERATION = 196.2

local RELOAD_TIME = tool.Configurations.ReloadTime.Value -- Seconds until tool can be used again
local ROCKET_SPEED = tool.Configurations.RocketSpeed.Value -- Speed of the projectile

local MISSILE_MESH_ID = 'http://www.roblox.com/asset/?id=2251534'
local MISSILE_MESH_SCALE = Vector3.new(0.35, 0.35, 0.25)
local ROCKET_PART_SIZE = Vector3.new(1.2, 1.2, 3.27)

local RocketScript = script:WaitForChild('Rocket')
local SwooshSound = script:WaitForChild('Swoosh')
local BoomSound = script:WaitForChild('Boom')

local attackCooldown = tool.Configurations.AttackCooldown.Value
local damage = tool.Configurations.Damage.Value
local reloadTime = tool.Configurations.ReloadTime.Value

local function createEvent(eventName)
	local event = game.ReplicatedStorage:FindFirstChild(eventName)
	if not event then
		event = Instance.new("RemoteEvent", game.ReplicatedStorage)
		event.Name = eventName
	end
	return event
end

local updateEvent = createEvent("ROBLOX_RocketUpdateEvent")
local equipEvent = createEvent("ROBLOX_RocketEquipEvent")
local unequipEvent = createEvent("ROBLOX_RocketUnequipEvent")
local fireEvent = createEvent("ROBLOX_RocketFireEvent")

updateEvent.OnServerEvent:connect(function(player, neckC0, rshoulderC0)
	local character = player.Character
	character.Torso.Neck.C0 = neckC0
	character.Torso:FindFirstChild("Right Shoulder").C0 = rshoulderC0
	gunWeld = character:FindFirstChild("Right Arm"):WaitForChild("RightGrip")
end)

equipEvent.OnServerEvent:connect(function(player)
	player.Character.Humanoid.AutoRotate = false
end)

unequipEvent.OnServerEvent:connect(function(player)
	player.Character.Humanoid.AutoRotate = true
end)

--NOTE: We create the rocket once and then clone it when the player fires
local Rocket = Instance.new('Part') do
	-- Set up the rocket part
	Rocket.Name = 'Rocket'
	Rocket.FormFactor = Enum.FormFactor.Custom --NOTE: This must be done before changing Size
	Rocket.Size = ROCKET_PART_SIZE
	Rocket.CanCollide = false

	-- Add the mesh
	local mesh = Instance.new('SpecialMesh', Rocket)
	mesh.MeshId = MISSILE_MESH_ID
	mesh.Scale = MISSILE_MESH_SCALE

	-- Add fire
	local fire = Instance.new('Fire', Rocket)
	fire.Heat = 5
	fire.Size = 2

	-- Add a force to counteract gravity
	local bodyForce = Instance.new('BodyForce', Rocket)
	bodyForce.Name = 'Antigravity'
	bodyForce.force = Vector3.new(0, Rocket:GetMass() * GRAVITY_ACCELERATION, 0)

	-- Clone the sounds and set Boom to PlayOnRemove
	local swooshSoundClone = SwooshSound:Clone()
	swooshSoundClone.Parent = Rocket
	local boomSoundClone = BoomSound:Clone()
	boomSoundClone.PlayOnRemove = true
	boomSoundClone.Parent = Rocket

	-- Finally, clone the rocket script and enable it
--	local rocketScriptClone = RocketScript:Clone()
--	rocketScriptClone.Parent = Rocket
--	rocketScriptClone.Disabled = false
end


fireEvent.OnServerEvent:connect(function(player, target)
	if canFire and player.Character == tool.Parent then
		canFire = false
		
		-- Create a clone of Rocket and set its color
		local rocketClone = Rocket:Clone()
		--game.Debris:AddItem(rocketClone, 30)
		rocketClone.BrickColor = player.TeamColor
		rocketClone.Touched:connect(function(hit)
			if hit and hit.Parent and hit.Parent ~= player.Character and hit.Parent ~= tool then
				local explosion = Instance.new("Explosion", game.Workspace)
				explosion.Position = rocketClone.Position
				rocketClone:Destroy()
			end
		end)
		
		spawn(function()
			wait(30)
			if rocketClone then rocketClone:Destroy() end
		end)		
		
		-- Position the rocket clone and launch!
		local spawnPosition = (tool.Handle.CFrame * CFrame.new(2, 0, 0)).p
		rocketClone.CFrame = CFrame.new(spawnPosition, target) --NOTE: This must be done before assigning Parent
		rocketClone.Velocity = rocketClone.CFrame.lookVector * ROCKET_SPEED --NOTE: This should be done before assigning Parent
		rocketClone.Parent = game.Workspace		
		
		-- Attach creator tags to the rocket early on
		local creatorTag = Instance.new('ObjectValue', rocketClone)
		creatorTag.Value = player
		creatorTag.Name = 'creator' --NOTE: Must be called 'creator' for website stats
		local iconTag = Instance.new('StringValue', creatorTag)
		iconTag.Value = tool.TextureId
		iconTag.Name = 'icon'
		
		delay(attackCooldown, function()
			canFire = true
		end)
	end
end)