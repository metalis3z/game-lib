-- Script by XcorrectTheDev

while true do
if script.Parent.NPC.Health > 0 then
script.Parent.NPC:MoveTo(Vector3.new(math.random(-820, 840), 
 0, math.random(-820, 840)), game.Workspace.Terrain)
for i= 1,16 do
wait(0.5)
script.Parent.Head.RakeStep:Play()
end
end
wait(10)
end