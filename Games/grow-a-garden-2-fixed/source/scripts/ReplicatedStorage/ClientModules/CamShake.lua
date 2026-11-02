--credit to prince games studio
local CameraShaker = require(script.CameraShaker)
local CurrentCamera = workspace.CurrentCamera
local v1 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p1) --[[ Line: 3 | Upvalues: CurrentCamera (copy) ]]
	CurrentCamera.CFrame = CurrentCamera.CFrame * p1
end)

v1:Start()

return v1