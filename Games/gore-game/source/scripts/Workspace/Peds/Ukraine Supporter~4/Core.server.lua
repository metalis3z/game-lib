local character = script.Parent
local clone = character:Clone()

local humanoid = character:WaitForChild("Humanoid")
humanoid.RootPart:SetNetworkOwner(nil)
humanoid:SetAttribute("LastHit", 0)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local RagdollModule = require(Assets.Modules.Ragdoll)
local SimplePath = require(Assets.Modules.SimplePath)

local RagdollController = RagdollModule.create(character, true)
RagdollController:registerEvent()

local path = SimplePath.new(character, {
	WaypointSpacing = 12;
})
path.Visualize = false
local moving = false

function getDistance(p1, p2)
	return ((typeof(p1) == "Instance" and p1.Position or p1) - (typeof(p2) == "Instance" and p2.Position or p2)).magnitude
end

humanoid.Died:Connect(function()
	humanoid:SetAttribute("LastHit", tick())
	while tick() - humanoid:GetAttribute("LastHit") < 10 do
		task.wait(1 / 30)
	end
	clone.Parent = character.Parent
	character:Destroy()
end)

while humanoid.Health > 0 and moving do
	local pos = humanoid.RootPart.Position + Vector3.new(math.random(-100, 100), 0, math.random(-100, 100))
	path:Run(pos)
	local processTick = tick()
	while getDistance(humanoid.RootPart, pos) > 5 and humanoid.Health > 0 do
		local vel = Vector3.new(humanoid.RootPart.Velocity.x, 0, humanoid.RootPart.Velocity.z).magnitude
		if (vel < 1) then
			if (tick() - processTick >= 1.5) then
				break
			end
		else
			processTick = tick()
		end
		task.wait(1 / 30)
	end
	task.wait(math.random(3, 5))
end