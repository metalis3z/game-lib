local Debounce = false 

function OnTouched(Hit) 
if Hit.Parent ~= nil then
if Debounce == false and Hit.Parent:findFirstChild("NPC") ~= nil then
if Hit.Parent:findFirstChild("NPC").Health > 0 then
				Debounce = true
				workspace.CavePartScript.Disabled = true
				wait()
workspace.The_Rake.SpawnScript.Disabled = true
				workspace.The_Rake.MainScript.Disabled = false
				workspace.The_Rake.Stun.Disabled = false
				workspace.The_Rake.Stun2.Disabled = false
				workspace.Trapped.Value = false
script.Disabled = true
wait(1)
Debounce = false 
end
end
end
end 

script.Parent.Touched:Connect(OnTouched)