

local PhysicsService = game:GetService("PhysicsService")
 
local playerGroup = "playerGroup"
 
PhysicsService:CreateCollisionGroup(playerGroup)
PhysicsService:CollisionGroupSetCollidable(playerGroup, playerGroup, false)
 
wait(5)

 
while wait() do
	local players = game.Players:GetChildren()
	for i = 1, #players do
		local player = players[i]
		if player.Character.HumanoidRootPart.CollisionGroupId == 0 then
			local children = player.Character:GetChildren()
			for j = 1, #children do
				if children[j]:IsA('MeshPart') or children[j]:IsA('Part') then
					PhysicsService:SetPartCollisionGroup(children[j], playerGroup)
				end
			end
		end
	end
end
