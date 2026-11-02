-- SoftWheels.lua by VanillaEdge (client)

local Players = game:GetService("Players")

local car = script.Parent.Car.Value :: Model
local seat = car.DriveSeat :: VehicleSeat
local player = Players.LocalPlayer

local cache = {}

local TARGET_MASS = 1 -- too low and it will do weird back and fourth
local GRAVITY = 35 -- seperate to gravcomp, so plugin makes the same result on all games

local function getCollisionPhysicalProperties(part: Part): PhysicalProperties
	local props = part.CurrentPhysicalProperties
	local size = part.Size
	local boxVolume = size.X * size.Y * size.Z

	local volume = 0
	if part.Shape == Enum.PartType.Ball then
		volume = math.pi / 6 * boxVolume
	elseif part.Shape == Enum.PartType.Cylinder then
		volume = math.pi / 4 * boxVolume
	else
		volume = boxVolume -- sus wheels bro
	end

	return PhysicalProperties.new(
		math.clamp(TARGET_MASS / volume, 0.0001, 100),
		props.Friction,
		props.Elasticity,
		props.FrictionWeight,
		props.ElasticityWeight
	)
end

local function toggleWheels(enabled: boolean)
	for wheel, data in cache do
		if enabled then
			data.ResetWeld.Enabled = false
			
			for i, v in data.Constraints do
				v.Enabled = true
			end
			
			for i, v in data.Collisions do
				v.CanCollide = false
			end
			
			data.Part.CanCollide = true			
		else
			data.Part.CanCollide = false
			
			for i, v in data.Constraints do
				v.Enabled = false
			end
			
			data.ResetWeld.Enabled = true
			
			for i, v in data.Collisions do
				v.CanCollide = true
			end
		end
	end
end

for i, child in car.Wheels:GetChildren() do
	if not child:IsA("Part") then
		continue
	end
	
	local collisionPart = child:WaitForChild("Collision", 10)
	if not collisionPart or not collisionPart:IsA("Part") then
		continue
	end
	
	local collisions = { child }
	for i, descendant in child:GetDescendants() do
		if descendant:IsA("BasePart") and descendant.CanCollide then
			table.insert(collisions, descendant)
		end
	end
	
	child:GetPropertyChangedSignal("CollisionGroup"):Connect(function()
		collisionPart.CollisionGroup = child.CollisionGroup
	end)
	
	child:GetPropertyChangedSignal("Size"):Connect(function()
		collisionPart.CustomPhysicalProperties = getCollisionPhysicalProperties(child)
		collisionPart.Size = child.Size
	end)
	
	child:GetPropertyChangedSignal("Shape"):Connect(function()
		collisionPart.Shape = child.Shape
		collisionPart.CustomPhysicalProperties = getCollisionPhysicalProperties(child)
	end)
	
	child:GetPropertyChangedSignal("CustomPhysicalProperties"):Connect(function()
		collisionPart.CustomPhysicalProperties = getCollisionPhysicalProperties(child)
	end)
	
	child:GetPropertyChangedSignal("Material"):Connect(function()
		collisionPart.CustomPhysicalProperties = getCollisionPhysicalProperties(child)
	end)
	
	child:GetPropertyChangedSignal("MaterialVariant"):Connect(function()
		collisionPart.CustomPhysicalProperties = getCollisionPhysicalProperties(child)
	end)
	
	cache[child] = {
		Constraints = {
			collisionPart:WaitForChild("AlignPosition"),
			collisionPart:WaitForChild("AlignOrientation"),
			collisionPart:WaitForChild("RopeConstraint"),
			collisionPart:WaitForChild("VectorForce"),
		},
		Collisions = collisions,
		Part = collisionPart,
		ResetWeld = collisionPart:WaitForChild("CollisionResetWeld"),
	}
end

seat:GetPropertyChangedSignal("Occupant"):Connect(function()
	toggleWheels(false)
end)

toggleWheels(true)
