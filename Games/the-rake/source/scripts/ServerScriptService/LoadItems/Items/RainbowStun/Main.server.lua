repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Slash = script.parent.parent.Humanoid:LoadAnimation(script.parent.Animation)
local Clicked = false

script.Parent.Activated:Connect(function()
if Clicked == false and script.Parent.Parent.StaminaBar.Stamina.Value > 40 then
Clicked = true
Slash:Play()
script.Parent.ShockPart.Damage.Disabled = false
script.Parent.Parent.StaminaBar.Stamina.Value = script.Parent.Parent.StaminaBar.Stamina.Value - 40
script.Parent.Parent.StaminaBar.StaminaRefill.Disabled = true
script.Parent.Parent.StaminaBar.StaminaRefill.Disabled = false
		script.Parent.Handle.Sound:Play()
		script.Parent.LightPart.Trail.Enabled = true
wait(1)
		script.Parent.ShockPart.Damage.Disabled = true
		script.Parent.LightPart.Trail.Enabled = false
Clicked = false
end
end)