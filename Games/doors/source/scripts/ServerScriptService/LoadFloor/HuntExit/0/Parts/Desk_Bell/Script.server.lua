local Animation = script.Parent.InteractAnimation
local AnimationController = script.Parent.AnimationController
local LoadAnim = AnimationController:LoadAnimation(Animation)
local Number = 0

	script.Parent.InteractPrompt.Triggered:Connect(function()
	LoadAnim:Play()
	script.Parent.Base.InteractSound:Play()
	Number += 1
	wait(0.3)
end)

while true do
	wait(0.3)
	if Number >= 7 then
		script.Parent.Base.InteractSound.SoundId = "rbxassetid://965879083"
	end
end
