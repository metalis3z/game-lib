-----------------
--| Constants |--
-----------------

local COOLDOWN = 7 -- Seconds until tool can be used again

-- RocketPropulsion Fields
local TARGET_RADIUS = 5
local MAX_SPEED = 250--60
local MAX_TORQUE = Vector3.new(40, 40, 0)
local MAX_THRUST = 50000
local THRUST_P = 100--500
local THRUST_D = 5


local TARGET_OVERSHOOT_DISTANCE = 10000000

local ROCKET_MESH_ID = 'http://www.roblox.com/asset/?id=103970395'
local ROCKET_MESH_SCALE = Vector3.new(1, 1, 1)
local ROCKET_PART_SIZE = Vector3.new(1, 1, 4)

--------------------
--| WaitForChild |--
--------------------

-- Waits for parent.child to exist, then returns it
local function WaitForChild(parent, childName)
	assert(parent, "ERROR: WaitForChild: parent is nil")
	while not parent:FindFirstChild(childName) do print(child) wait(1/30) end
	return parent[childName]
end

-----------------
--| Variables |--
-----------------

local DebrisService = Game:GetService('Debris')
local PlayersService = Game:GetService('Players')

local Tool = script.Parent
local ToolHandle = Tool.Handle

local RocketScript = WaitForChild(script, 'Rocket')

local SwooshSound = WaitForChild(script, 'Swoosh')
local BoomSound = WaitForChild(script, 'Boom')
local ReloadSound = WaitForChild(ToolHandle, 'ReloadSound')
local EquipSound = WaitForChild(ToolHandle, 'Equip')

local LockOnSound = WaitForChild(ToolHandle, 'lockon')
local HoldLockOnSound = WaitForChild(ToolHandle, 'holdlock')

local MyModel = nil
local MyPlayer = nil

local BaseRocket = nil
local RocketClone = nil

local MyBillboard = WaitForChild(Tool,'BillboardGui'):Clone()
local lockonImg = WaitForChild(MyBillboard,'lockon')
local holdlockImg = WaitForChild(MyBillboard,'lockonHeld')
local MyDistText = WaitForChild(MyBillboard,'Distance')

-----------------
--| Functions |--
-----------------

local function MakeBaseRocket()
	-- Set up the rocket part
	local rocket = Instance.new('Part')
	rocket.Name = 'Rocket'
	rocket.FormFactor = Enum.FormFactor.Custom --NOTE: This must be done before changing Size
	rocket.Size = ROCKET_PART_SIZE
	rocket.CanCollide = false
	rocket.BottomSurface = Enum.SurfaceType.Smooth
	rocket.TopSurface = Enum.SurfaceType.Smooth

	-- Add the mesh
	local mesh = Instance.new('SpecialMesh', rocket)
	mesh.MeshId = ROCKET_MESH_ID
	mesh.Scale = ROCKET_MESH_SCALE
	mesh.TextureId = ToolHandle.Mesh.TextureId

	-- Add fire
	local fire = Instance.new('Fire', rocket)
	fire.Heat = 5
	fire.Size = 2

	-- Add the propulsion
	local rocketPropulsion = Instance.new('RocketPropulsion', rocket)
	rocketPropulsion.CartoonFactor = 1
	rocketPropulsion.TargetRadius = TARGET_RADIUS
	rocketPropulsion.MaxSpeed = MAX_SPEED
	rocketPropulsion.MaxTorque = MAX_TORQUE
	rocketPropulsion.MaxThrust = MAX_THRUST
	rocketPropulsion.ThrustP = THRUST_P
	rocketPropulsion.ThrustD = THRUST_D
	
	-- Clone the sounds
	local swooshSoundClone = SwooshSound:Clone()
	swooshSoundClone.Parent = rocket
	local boomSoundClone = BoomSound:Clone()
	boomSoundClone.PlayOnRemove = true
	boomSoundClone.Parent = rocket

	-- Attach creator tags
	local creatorTag = Instance.new('ObjectValue', rocket)
	creatorTag.Name = 'creator' --NOTE: Must be called 'creator' for website stats
	creatorTag.Value = MyPlayer
	local nameTag = Instance.new('StringValue', creatorTag)
	nameTag.Name = 'weaponName'
	nameTag.Value = Tool.Name
	local iconTag = Instance.new('StringValue', creatorTag)
	iconTag.Name = 'weaponIcon'
	iconTag.Value = Tool.TextureId

	-- Finally, clone the rocket script and enable it
	local rocketScriptClone = RocketScript:Clone()
	rocketScriptClone.Parent = rocket
	rocketScriptClone.Disabled = false

	return rocket
end

local IsEquipped = false
local DoTrackLock = true
local function OnEquipped()
	if IsEquipped then return end
	print('was equipped')
	IsEquipped = true
	MyPlayer = nil	
	while not MyPlayer do
		MyModel = Tool.Parent
		MyPlayer = PlayersService:GetPlayerFromCharacter(MyModel)
		wait(1/30)
	end
	
	BaseRocket = MakeBaseRocket()
	RocketClone = BaseRocket:Clone()
	EquipSound:Play()
	local mouse = MyPlayer:GetMouse()
	DoTrackLock = true
	wait(1)
	Spawn(function() TrackLock(mouse) end)
end

local LockedPlayer = nil
local TrackTime = 0


local lockOnSoundPlaying = false
local holdSoundPlaying = false

function TrackLock(mouse)
	local myHead = WaitForChild(MyModel,'Head')
	IsMouseDown = true
	HaveLock = false
	LockedPlayer = nil
	while DoTrackLock do
		--local closestPlayer	 = nil
		local mousePos = mouse.Hit
		local minOffset = nil
		local foundPlayer = false
		for _,i in pairs(game.Players:GetPlayers()) do			
			if i.Character and i.Character:FindFirstChild('Torso') and i~= MyPlayer then
				
				local torsoPos = i.Character.Torso.CFrame
				local dist = (myHead.CFrame.p-torsoPos.p).magnitude
				local mouseDirection = (mouse.hit.p-myHead.CFrame.p).unit
				local offset = (((mouseDirection*dist)+myHead.CFrame.p)-
					 torsoPos.p).magnitude
				if offset<9 and (not minOffset or offset<minOffset) then
					foundPlayer = true
					MyDistText.Text = tostring(math.floor(dist*100)/100)
					if LockedPlayer~=i then	
						if not LockedPlayer	 and i  and not lockOnSoundPlaying 
								and not holdSoundPlaying then
							LockOnSound:Play()
							lockOnSoundPlaying = true
							lockonImg.Visible = true
							MyDistText.Visible = true
							TrackTime = tick()
						end			
						LockedPlayer = i
						print('TRACKING'..i.Name)
						MyBillboard.Parent = MyPlayer.PlayerGui
						MyBillboard.Adornee =  i.Character.Torso
						lockonImg.Visible = true
					end
				end
			end
		end
		
		if (tick()-TrackTime)>1.1 and LockedPlayer and not holdSoundPlaying then
			HoldLockOnSound:Play()
			holdSoundPlaying=true
			lockonImg.Visible = false
			holdlockImg.Visible = true
		--elseif holdSoundPlaying then
		--	HoldLockOnSound:Stop()
		--	holdSoundPlaying = false
		end
		
		if not foundPlayer and LockedPlayer then
			LockedPlayer=nil
			lockOnSoundPlaying=false
			LockOnSound:Stop()
			print('UnTracking')
			if holdSoundPlaying then
				HoldLockOnSound:Stop()
				holdSoundPlaying = false
			end
			lockonImg.Visible = false
			holdlockImg.Visible = false
			MyDistText.Visible = false
			MyBillboard.Parent = nil
			MyBillboard.Adornee = nil
		end		
		wait(1/30)
	end
	
	
	LockedPlayer=nil
	lockOnSoundPlaying=false
	LockOnSound:Stop()
	print('escaped loop')
	if holdSoundPlaying then
		HoldLockOnSound:Stop()
		holdSoundPlaying = false
	end
	lockonImg.Visible = false
	holdlockImg.Visible = false
	MyDistText.Visible = false
	MyBillboard.Parent = nil
	MyBillboard.Adornee = nil
	
end


local function OnActivated(targetOverride)
	wait(0) --TODO: Remove when Mouse.Hit and Humanoid.TargetPoint update properly on iPad
	if Tool.Enabled and MyModel and MyModel:FindFirstChild('Humanoid') and MyModel.Humanoid.Health > 0 then
		Tool.Enabled = false

		-- Pick a target
		local targetPosition = targetOverride or MyModel.Humanoid.TargetPoint

		-- Position the rocket clone
		local spawnPosition = ToolHandle.Position + (ToolHandle.CFrame.lookVector * (ToolHandle.Size.Z / 2))
		RocketClone.CFrame = CFrame.new(spawnPosition, targetPosition) --NOTE: This must be done before assigning Parent
		DebrisService:AddItem(RocketClone, 30)
		RocketClone.Parent = Workspace
		
		-- Assign target and launch!
		local rocketPropulsion = RocketClone:FindFirstChild('RocketPropulsion')
		if rocketPropulsion then
			
			if not LockedPlayer then
				local direction = (targetPosition - RocketClone.Position).unit
				rocketPropulsion.TargetOffset = RocketClone.Position + (direction * TARGET_OVERSHOOT_DISTANCE)
			else
				rocketPropulsion.Target = LockedPlayer.Character:FindFirstChild('Torso')
				--rocketPropulsion.ReachedTarget:connect(rocketPropulsion:Destroy())
			end
			rocketPropulsion:Fire()
		end

		-- Prepare the next rocket to be fired
		RocketClone = BaseRocket:Clone()

		ReloadSound:Play()

		wait(COOLDOWN)

		-- Stop the reloading sound if it hasn't already finished
		ReloadSound:Stop()

		Tool.Enabled = true
	end
end

local function OnUnequipped()
	print('wasUnequipped')
	DoTrackLock = false
	ReloadSound:Stop()
	IsEquipped = false
	Wait(1)
end

-- Also activate when the Action Button is pressed
local function OnChildAdded(child)
	if child.Name == 'ActionButtonData' then
		child.Changed:connect(function(newValue)
			local bindable = child:FindFirstChild('GetTargetPosition')
			if bindable and string.sub(newValue, 1, 1) == 'v' then
				local matches = {}
				for match in string.gmatch(newValue, '%d+%.?%d*') do
					table.insert(matches, match)
				end
				if #matches == 4 then
					local screenPosition = Vector2.new(matches[1], matches[2])
					local screenSize = Vector2.new(matches[3], matches[4])
					local targetPosition = bindable:Invoke(screenPosition, screenSize, {MyModel})
					OnActivated(targetPosition)
				end
			end
		end)
	end
end

--------------------
--| Script Logic |--
--------------------

Tool.Equipped:connect(OnEquipped)
Tool.Activated:connect(OnActivated)
Tool.Unequipped:connect(OnUnequipped)
Tool.ChildAdded:connect(OnChildAdded) --NOTE: Added for Action Button
