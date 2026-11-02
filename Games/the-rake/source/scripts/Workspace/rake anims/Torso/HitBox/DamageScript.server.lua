-- Script by XcorrectTheDev

wait()
local Debounce = false 
local Damage = script.Parent.Parent.Parent.Configuration.Damage.Value
local AttackDelay = script.Parent.Parent.Parent.Configuration.AttackDelay.Value

function OnTouched(Hit) 
if Hit.Parent ~= nil then
if Debounce == false and Hit.Parent:findFirstChildOfClass("Humanoid") ~= nil then
if Hit.Parent:findFirstChildOfClass("Humanoid").Health > 0 then
Debounce = true
wait(0.2)
local hitsound = "Hit".. math.random(1,2)
script.Parent.Parent:FindFirstChild(hitsound).Pitch=0.9+(math.random()*0.1)
script.Parent.Parent:FindFirstChild(hitsound):Play()
Hit.Parent:findFirstChildOfClass("Humanoid"):TakeDamage(Damage)
wait(AttackDelay)
Debounce = false 
end
end
end
end 

script.Parent.Touched:Connect(OnTouched)