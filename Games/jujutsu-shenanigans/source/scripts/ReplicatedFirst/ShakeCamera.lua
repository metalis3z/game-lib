local ShakeCamera = {}

local RS = game:GetService("ReplicatedStorage")

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local function SetCameraCFrame(ShakeCFrame)
	camera.CFrame = camera.CFrame * ShakeCFrame
end

local CameraShaker = require(RS.Modules.CameraShaker)
local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, SetCameraCFrame)

camShake:Start()

function ShakeCamera:ShakeCamera(Magnitude, Roughness, FadeInTime, FadeOutTime)
	camShake:ShakeOnce(Magnitude, Roughness, FadeInTime, FadeOutTime)
end

function ShakeCamera:KanjiCamShake(Magnitude, Roughness, FadeInTime, FadeOutTime, Pos, Rot)
	camShake:ShakeOnce(Magnitude, Roughness, FadeInTime, FadeOutTime, Pos, Rot)
end

function ShakeCamera:SustainShakeCamera(_Instance,shakeTime,fadeOutTime)
	camShake:ShakeSustain(CameraShaker.Presets[_Instance])

	task.delay(shakeTime,function()
		camShake:StopSustained(fadeOutTime)
	end)
end

-- Domain Stuff

ShakeCamera.SustainShake = function(Inst)
	camShake:ShakeSustain(Inst)
end

ShakeCamera.StopSustainShake = function()
	camShake:StopSustained()
end

return ShakeCamera
