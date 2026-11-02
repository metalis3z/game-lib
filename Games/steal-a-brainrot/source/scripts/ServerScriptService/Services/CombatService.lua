local CombatService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local ApplyImpulse = Net:RemoteEvent("CombatService/ApplyImpulse")

function CombatService.Fling(HumanoidRootPart: Part, power, attackerPosition: Vector3?)
	local flingDirection

	if attackerPosition then
		flingDirection = (HumanoidRootPart.Position - attackerPosition).Unit
	else
		flingDirection = HumanoidRootPart.CFrame.LookVector
	end

	flingDirection = flingDirection + Vector3.new(0, 0.3, 0)
	flingDirection = flingDirection.Unit

	local forceDampener = math.random(10, 15)

	local bv = Instance.new("BodyVelocity")
	bv.Parent = HumanoidRootPart
	bv.P = 50000
	bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = flingDirection * (power or 50) / forceDampener

	local av = Instance.new("AngularVelocity")
	av.Parent = HumanoidRootPart
	av.MaxTorque = 10000
	av.ReactionTorqueEnabled = false
	av.AngularVelocity = Vector3.new(math.random(-20,20), math.random(-20,20), math.random(-20,20))

	game.Debris:AddItem(bv, 0.2)
	game.Debris:AddItem(av, 0.2)
end

return CombatService