function Seated(theSeated)
dude = game.Players:playerFromCharacter(theSeated.Part1.Parent) 
if dude ~= nil then
thing2 = script.Parent.Turret1212:clone()
thing2.Parent = dude.Backpack
thing2.Vehicle.Value = script.Parent.Parent
end
end


function UNSeated(theSeated)
dude = game.Players:playerFromCharacter(theSeated.Part1.Parent) 
if dude ~= nil then
if dude.Backpack:findFirstChild("Turret1212") ~= nil then
dude.Backpack:findFirstChild("Turret1212").Active = false
dude.Backpack:findFirstChild("Turret1212"):remove()
end
end
end

script.Parent.ChildAdded:connect(Seated)
script.Parent.ChildRemoved:connect(UNSeated)
