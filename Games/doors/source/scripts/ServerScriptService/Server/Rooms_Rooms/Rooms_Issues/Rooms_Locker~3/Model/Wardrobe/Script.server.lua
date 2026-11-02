local anim = script.Animation
local animController = script.Parent.AnimationController
local LoadAnim = animController:LoadAnimation(anim)
script.Parent.Part.ProximityPrompt.Triggered:Connect(function()
	LoadAnim:Play()
end)
