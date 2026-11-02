wait()
local plr = game.Players.LocalPlayer
local char = plr.Character
local humanoid = char.Humanoid
local healthhumanoid = humanoid.Health

local camera = workspace.CurrentCamera

local CameraShaker = require(game.ReplicatedStorage.CameraShaker)

local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, (function(shakeCFame)
	camera.CFrame = camera.CFrame*shakeCFame
end))

camShake:Start()

humanoid.HealthChanged:Connect(function(health)
	if healthhumanoid > health then
		camShake:ShakeOnce(29,6,0,0.08)
	end
	healthhumanoid = health
end)