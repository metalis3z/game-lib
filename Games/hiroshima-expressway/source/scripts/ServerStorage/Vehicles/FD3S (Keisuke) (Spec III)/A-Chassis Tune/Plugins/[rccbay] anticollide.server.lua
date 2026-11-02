--heavily modified vers of standard anticollide
--chedsapp
wait(1.6)



local PhysicsService = game:GetService("PhysicsService")



local function checktab()
	local check = false
	for i = 1,20 do
		local th = PhysicsService:GetCollisionGroupName(i)
		if th == "RaceCars" then
			check = true
		end
	end

	if not check~=nil and check == false then
		warn("RCCBAY ANTICOLLIDE | not there, creating group")
		PhysicsService:CreateCollisionGroup("RaceCars")
		
	else
		warn("RCCBAY ANTICOLLIDE | collision group already exists, aborted creation")
	end
	return check

end

local check = checktab()


wait(2.3)

PhysicsService:CollisionGroupSetCollidable("RaceCars", "RaceCars", false)
local function setCollisionGroupRecursive(object)
	if object:IsA("BasePart") then
		PhysicsService:SetPartCollisionGroup(object, "RaceCars")
	end
	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end
wait(1.3)


for i, v in pairs(game:GetService("Players"):GetPlayers()) do
	local char = v.Character
	setCollisionGroupRecursive(char)
end
game:GetService("Players").PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		setCollisionGroupRecursive(char)
	end)
end)
setCollisionGroupRecursive(script.Parent)