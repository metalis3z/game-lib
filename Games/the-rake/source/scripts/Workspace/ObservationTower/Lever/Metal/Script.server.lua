local debounce = false 
function OnTouched(Part) 
if Part.Parent ~= nil then
if debounce == false and Part.Parent:findFirstChild("NPC") ~= nil then 
debounce = true 
script.Parent.CanCollide = false
script.Parent.Parent.Metal1.CanCollide = false
wait(0.2)
script.Parent.Parent.Metal1.CanCollide = true
script.Parent.CanCollide = true
debounce = false 
end 
end 
end 
script.Parent.Touched:connect(OnTouched)