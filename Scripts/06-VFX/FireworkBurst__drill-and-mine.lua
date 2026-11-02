-- Reference copy for study. Game: drill-and-mine
-- Original: ReplicatedStorage/Source/Modules/FireworkModule.lua  (ModuleScript, 98 lines)
-- What it does: Spawns 4 firework templates in a circle around a point, emits dust then sparks with a delay, plays a sound and cleans up. Includes a good note about TimeLength being 0 before a sound loads.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local FireworkModule = {}

local EffectsFolder = ReplicatedStorage:FindFirstChild("Effects")
local SoundsFolder = SoundService:FindFirstChild("Sounds")
local FireworkSound = SoundsFolder and SoundsFolder:FindFirstChild("FireworkSound")
local player = Players.LocalPlayer

local FIREWORK_COUNT = 4
local RADIUS = 8
local DUST_EMIT_COUNT = 5
local PARTICLE_EMIT_COUNT = 10
local DUST_DELAY = 0.0
local PARTICLE_DELAY = 0.3
local CLEANUP_TIME = 3

function FireworkModule.Play(originPosition)
	if not EffectsFolder then return end
	if not originPosition then
		local character = player.Character
		if not character then return end
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if not rootPart then return end
		originPosition = rootPart.Position
	end

	if FireworkSound then
		local sound = FireworkSound:Clone()
		sound.Parent = workspace
		sound:Play()
		-- a fresh clone reports TimeLength 0 until the asset loads, so the old
		-- `TimeLength + 1` cleanup killed the 4s firework sound after ONE
		-- second -- clean up when it actually finishes, failsafe well past it
		sound.Ended:Once(function()
			sound:Destroy()
		end)
		Debris:AddItem(sound, 30)
	end

	for i = 1, FIREWORK_COUNT do
		local templateName = "Fireworks" .. tostring(i)
		local template = EffectsFolder:FindFirstChild(templateName)
		if not template then
			warn("[FireworkModule] Template not found:", templateName)
			continue
		end

		local angle = math.rad((360 / FIREWORK_COUNT) * (i - 1))
		local offset = Vector3.new(math.cos(angle) * RADIUS, 0, math.sin(angle) * RADIUS)
		local spawnPos = originPosition + offset

		local fireworkPart = template:Clone()
		fireworkPart.CFrame = CFrame.new(spawnPos)
		fireworkPart.Anchored = true
		fireworkPart.CanCollide = false
		fireworkPart.Parent = workspace

		task.delay(DUST_DELAY, function()
			local dust = fireworkPart:FindFirstChild("dust")
			local dust2 = fireworkPart:FindFirstChild("dust2")

			if dust and dust:IsA("ParticleEmitter") then
				dust:Emit(DUST_EMIT_COUNT)
			end
			if dust2 and dust2:IsA("ParticleEmitter") then
				dust2:Emit(DUST_EMIT_COUNT)
			end
		end)

		task.delay(PARTICLE_DELAY, function()
			local attachment = fireworkPart:FindFirstChildWhichIsA("Attachment")
			if attachment then
				for _, emitter in ipairs(attachment:GetChildren()) do
					if emitter:IsA("ParticleEmitter") then
						emitter:Emit(PARTICLE_EMIT_COUNT)
					end
				end
			end
		end)

		Debris:AddItem(fireworkPart, CLEANUP_TIME)
	end
end

function FireworkModule.PlayAtPlayer(targetPlayer)
	targetPlayer = targetPlayer or player
	local character = targetPlayer.Character
	if not character then return end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	FireworkModule.Play(rootPart.Position)
end

return FireworkModule
