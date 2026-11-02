repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Slash = script.parent.parent.Humanoid:LoadAnimation(script.parent.Animation)
local Clicked = false

script.Parent.Activated:Connect(function()
if Clicked == false and script.Parent.Parent.StaminaBar.Stamina.Value > 30 then
Clicked = true
Slash:Play()
		--script.Parent.Parent.StaminaRefill.Disabled = true
		script.Parent.ShockPart.Shock.Disabled = false
		script.Parent.Parent.StaminaBar.Stamina.Value = script.Parent.Parent.StaminaBar.Stamina.Value - 30
		script.Parent.Parent.StaminaBar.StaminaRefill.Disabled = true
		script.Parent.Parent.StaminaBar.StaminaRefill.Disabled = false
		--script.Parent.ShockPart.ZapScript.Disabled = false
		script.Parent.Handle.Sound:Play()
wait(0.6)
		script.Parent.ShockPart.Shock.Disabled = true
		--script.Parent.ShockPart.ZapScript.Disabled = true
		--wait(0.7)
Clicked = false
end
end)