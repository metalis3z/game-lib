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
		if health < 100 then
			camShake:ShakeOnce(10,1,0,0.05)
		end
	end
	healthhumanoid = health
end)