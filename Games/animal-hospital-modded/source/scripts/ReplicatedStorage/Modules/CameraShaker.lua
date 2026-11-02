local Camera = workspace.CurrentCamera
local CameraShaker = require(script.CameraShaker)

local CamShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
	if Camera.CameraType == Enum.CameraType.Scriptable then return end
	Camera.CFrame = Camera.CFrame * shakeCf
end)
CamShake:Start()




return function(Preset : string)
	CamShake:Shake(CameraShaker.Presets[Preset])
end