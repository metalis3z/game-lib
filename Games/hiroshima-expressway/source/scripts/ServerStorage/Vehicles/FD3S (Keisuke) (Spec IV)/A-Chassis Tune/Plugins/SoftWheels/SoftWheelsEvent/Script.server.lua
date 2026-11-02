-- SoftWheels.lua by VanillaEdge (server)

local car = script.Parent.Parent :: Model
local seat = car.DriveSeat :: VehicleSeat

local isBike = car["A-Chassis Tune"]["A-Chassis Interface"]:FindFirstChild("Bike")

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

for i, child in car.Wheels:GetChildren() do
	if not child:IsA("Part") then
		continue
	end
	
	if child:FindFirstChild("Collision") then
		continue
	end
	
	local collisionPart = Instance.new("Part")
	collisionPart.Name = "Collision"
	collisionPart.Shape = child.Shape
	collisionPart.Size = child.Size
	collisionPart.CFrame = child.CFrame
	collisionPart.CustomPhysicalProperties = getCollisionPhysicalProperties(child)
	collisionPart.CollisionGroup = child.CollisionGroup
	collisionPart.CanQuery = false
	collisionPart.AudioCanCollide = false
	collisionPart.Transparency = 1
	collisionPart.CanCollide = false
	collisionPart.Parent = child
	
	local attachment0 = Instance.new("Attachment")
	attachment0.Name = "CollisionAttachment0"
	attachment0.Parent = collisionPart
	
	local attachment1 = Instance.new("Attachment")
	attachment1.Name = "CollisionAttachment1"
	attachment1.Parent = child
	
	local resetWeld = Instance.new("WeldConstraint")
	resetWeld.Name = "CollisionResetWeld"
	resetWeld.Part0 = collisionPart
	resetWeld.Part1 = child
	resetWeld.Enabled = true
	resetWeld.Parent = collisionPart
	
	local alignPosition = Instance.new("AlignPosition")
	alignPosition.Mode = Enum.PositionAlignmentMode.TwoAttachment
	alignPosition.Attachment0 = attachment0
	alignPosition.Attachment1 = attachment1
	alignPosition.ApplyAtCenterOfMass = true
	alignPosition.ReactionForceEnabled = true
	alignPosition.MaxForce = isBike and 1000 or 3200
	alignPosition.MaxVelocity = 10
	alignPosition.Responsiveness = 100
	alignPosition.Enabled = false
	alignPosition.Parent = collisionPart
	
	local alignOrientation = Instance.new("AlignOrientation")
	alignOrientation.Mode = Enum.OrientationAlignmentMode.TwoAttachment
	alignOrientation.Attachment0 = attachment0
	alignOrientation.Attachment1 = attachment1
	alignOrientation.ReactionTorqueEnabled = true
	alignOrientation.RigidityEnabled = true
	alignOrientation.Enabled = false
	alignOrientation.Parent = collisionPart
	
	local ropeConstraint = Instance.new("RopeConstraint")
	ropeConstraint.Attachment0 = attachment0
	ropeConstraint.Attachment1 = attachment1
	ropeConstraint.Length = isBike and 0.18 or 0.05
	ropeConstraint.Restitution = 0 -- keep 0 otherwise it does weird back and fourth
	ropeConstraint.Enabled = false
	ropeConstraint.Parent = collisionPart
	
	local vectorForce = Instance.new("VectorForce")
	vectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
	vectorForce.ApplyAtCenterOfMass = true
	vectorForce.Attachment0 = attachment0
	vectorForce.Force = Vector3.new(0, GRAVITY > 0 and TARGET_MASS * (workspace.Gravity - GRAVITY) or 0, 0)
	vectorForce.Enabled = false
	vectorForce.Parent = collisionPart
	
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
end
