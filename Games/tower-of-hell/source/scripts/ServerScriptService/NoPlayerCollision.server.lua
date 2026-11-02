--Put the used services into variables
local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")
 
--The name of the collision group that characters are put in
local GroupName = "Players"
 
--Make a collision group for all players' characters
PhysicsService:CreateCollisionGroup(GroupName)
 
--Make the collision group for parts of characters not collide with itself
PhysicsService:CollisionGroupSetCollidable(GroupName, GroupName, false)
 
--Connect any players that are added to the game to above 'NewPlayer' function
Players.PlayerAdded:connect(function(Player)
 Player.CharacterAdded:Connect(function(Character)
  --Run on every part that is added to the character
  local function ChangeGroup(Part)
   if Part:IsA("BasePart") then --Make sure we're dealing with any type of part
    PhysicsService:SetPartCollisionGroup(Part, "Players") --Set the part's collision group
   end
  end
 
  --Run above function on any parts that are added to the character from this point
  Character.ChildAdded:Connect(ChangeGroup)
 
  --Run above function on any parts that may already exist
  for _, Object in pairs(Character:GetChildren()) do
   ChangeGroup(Object)
  end
 end)
end) 
                                                                                                  
