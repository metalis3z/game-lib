local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")

local collisionGroup = "PlayerCharacters"
local debrisGroup = "DrillDebris"

PhysicsService:RegisterCollisionGroup(collisionGroup)
PhysicsService:RegisterCollisionGroup(debrisGroup)
PhysicsService:CollisionGroupSetCollidable(collisionGroup, collisionGroup, false)
-- client-side drill debris chunks land on world geometry but never push or
-- block characters, and don't waste physics bouncing off each other
PhysicsService:CollisionGroupSetCollidable(debrisGroup, collisionGroup, false)
PhysicsService:CollisionGroupSetCollidable(debrisGroup, debrisGroup, false)

local function setCollideable(character)
	for _, part in pairs(character:GetChildren()) do
		if part:IsA("BasePart") then
			part.CollisionGroup = collisionGroup
		end
	end
	-- limbs can still be streaming in when CharacterAdded fires
	character.ChildAdded:Connect(function(part)
		if part:IsA("BasePart") then
			part.CollisionGroup = collisionGroup
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		setCollideable(character)
	end)
end)