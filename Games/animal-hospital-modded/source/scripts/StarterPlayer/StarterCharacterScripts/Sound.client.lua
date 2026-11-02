local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

script:WaitForChild("FootstepSounds").Parent = SoundService

local FootstepSounds = SoundService:WaitForChild("FootstepSounds")
local LocalPlayer = game.Players.LocalPlayer

repeat
	wait()
until LocalPlayer.Character

local Character = LocalPlayer.Character
local HumanoidRootPart = Character.HumanoidRootPart
local Humanoid = Character.Humanoid
local v1 = nil

Humanoid.Running:connect(function(p1) --[[ Line: 14 | Upvalues: Humanoid (copy), v1 (ref) ]]
	v1 = Humanoid.WalkSpeed / 2 < p1
end)
function getMaterial() --[[ getMaterial | Line: 22 | Upvalues: Humanoid (copy) ]]
	return string.split(tostring(Humanoid.FloorMaterial or "Air"), "Enum.Material.")[2]
end

local v2 = nil

RunService.Heartbeat:connect(function() --[[ Line: 31 | Upvalues: v1 (ref), v2 (ref), FootstepSounds (copy), Humanoid (copy) ]]
	if v1 then
		local v12 = getMaterial()

		-- apaga el sonido del material anterior (si cambió)
		if v12 ~= v2 and v2 ~= nil then
			local prev = FootstepSounds:FindFirstChild(v2)
			if prev then
				prev.Playing = false
			end
		end

		-- algunos materiales (o "Air") no tienen sonido de pisada -> no indexar nil
		local v22 = v12 and FootstepSounds:FindFirstChild(v12)
		if v22 then
			v22.SoundGroup = FootstepSounds
			v22.PlaybackSpeed = Humanoid.WalkSpeed / 12
			v22.Playing = true
			v2 = v12
		end
	else
		for k, v in pairs(FootstepSounds:GetChildren()) do
			v.Playing = false
		end
	end
end)
