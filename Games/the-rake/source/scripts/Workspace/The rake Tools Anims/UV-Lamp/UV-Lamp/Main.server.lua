-- Script by Xcorrectgamermaster
local Clicked = false

script.Parent.Unequipped:Connect(function()
if Clicked == false then
script.Parent.ShockPart.Damage.Disabled = true
script.Parent.ShockPart.Damage1.Disabled = true
script.Parent.ShockPart.Anim.Disabled = true
script.Parent.MouseIcon.Disabled = false
script.Parent.MouseIcon2.Disabled = true
elseif Clicked == true then
script.Parent.MouseIcon.Disabled = true
script.Parent.MouseIcon2.Disabled = false
wait(13)
Clicked = false
script.Parent.MouseIcon.Disabled = false
script.Parent.MouseIcon2.Disabled = true
end
end)

script.Parent.Activated:Connect(function()
if Clicked == false then
script.Parent.ShockPart.Damage.Disabled = false
script.Parent.ShockPart.Damage1.Disabled = false

script.Parent.MouseIcon.Disabled = true
script.Parent.MouseIcon2.Disabled = false
script.Parent.Handle.Sound:Play()
Clicked = true
wait(0)
script.Parent.Light.l1.Enabled = true
script.Parent.Light.l2.Enabled = true
script.Parent.Light.l3.Enabled = true
script.Parent.Light.Transparency = 0
script.Parent.ShockPart.Damage.Disabled = false
script.parent.ShockPart.Damage1.Disabled = false
script.Parent.ShockPart.Anim.Disabled = false
wait(8)
script.Parent.ShockPart.Damage.Disabled = true
script.parent.ShockPart.Damage1.Disabled = true
script.parent.ShockPart.Anim.Disabled = true
script.Parent.Light.l1.Enabled = false
script.Parent.Light.l2.Enabled = false
script.Parent.Light.l3.Enabled = false
script.Parent.Light.Transparency = 1
script.Parent.ShockPart.TrailElectricity.Enabled = false
wait(13)
script.Parent.MouseIcon.Disabled = false
script.Parent.MouseIcon2.Disabled = true
Clicked = false
end
end)