local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local PhysicsService = game:GetService("PhysicsService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function RegisterCollisionGroup(collisionGroupName)
	local createdGroups = PhysicsService:GetRegisteredCollisionGroups()
	local collisionGroupExists = {} do
		for _, createdGroup in pairs(createdGroups) do
			collisionGroupExists[createdGroup] = true
		end
	end
	if not collisionGroupExists[collisionGroupName] then
		PhysicsService:RegisterCollisionGroup(collisionGroupName)
	end
end

RegisterCollisionGroup("Chars")
RegisterCollisionGroup("CharCollide")
RegisterCollisionGroup("Buddies")
PhysicsService:CollisionGroupSetCollidable("Default", "Chars", false)
PhysicsService:CollisionGroupSetCollidable("Chars", "Chars", false)
PhysicsService:CollisionGroupSetCollidable("CharCollide", "Chars", false)
PhysicsService:CollisionGroupSetCollidable("CharCollide", "CharCollide", false)
PhysicsService:CollisionGroupSetCollidable("Buddies", "Chars", false)
PhysicsService:CollisionGroupSetCollidable("Buddies", "CharCollide", false)
PhysicsService:CollisionGroupSetCollidable("Buddies", "Buddies", false)

local function OnCharacterAdded(Character)
	local Humanoid = Character:WaitForChild("Humanoid") :: Humanoid
	local RootPart = Character:WaitForChild("HumanoidRootPart")
	RootPart.CollisionGroup = "CharCollide"
	RootPart.CanCollide = true
	Humanoid.Died:Connect(function()
		for i,v in ipairs(Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.CollisionGroup = "CharCollide"
			end
		end
	end)
	for _, item in Character:GetDescendants() do
		if item:IsA("BasePart") and item ~= RootPart then
			item.CollisionGroup = "Chars"
			item.Massless = true
		end
	end
	Character.DescendantAdded:Connect(function(item : BasePart?)
		if item:IsA("BasePart") and item ~= RootPart then
			item.CollisionGroup = "Chars"
			item.Massless = true
		end
	end)

	RootPart.CustomPhysicalProperties = PhysicalProperties.new(
		3.15, 0.5, 1, 0.3, 1
	)
end

local function OnPlayerAdded(Player)
	if Player.Character then OnCharacterAdded(Player.Character) end
	Player.CharacterAdded:Connect(OnCharacterAdded)
end

for _, player in Players:GetPlayers() do
	OnPlayerAdded(player)
end
Players.PlayerAdded:Connect(OnPlayerAdded)