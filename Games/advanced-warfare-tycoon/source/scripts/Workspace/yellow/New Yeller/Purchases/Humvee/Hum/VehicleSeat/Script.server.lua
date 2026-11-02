local car = script.Parent.Parent 

function onTouched(hit) 
local human = hit.Parent:findFirstChild("Humanoid") 
if (human ~= nil ) then 
car.Parent = hit.Parent 
end 
end 

script.Parent.Touched:connect(onTouched)
