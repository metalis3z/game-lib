local anim = script.Animation
local animController = script.Parent.AnimationController
local LoadAnim = animController:LoadAnimation(anim)
script.Parent.InteractPrompt.Triggered:Connect(function()
	LoadAnim:Play()
	script.Parent.Base.InteractSound:Play()
end)
