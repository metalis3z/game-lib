--credit to prince games studio
--[[
	PowerWasher — VFX del chorro de la Power Hose.
	Corre como script de Tool (Legacy): arranca cuando la Tool entra al Backpack /
	personaje. Al activar la Tool emite las partículas del Nozzle.VFX (Water/Water2/
	Waves) y reproduce SoundService.SFX.PowerHose desde el Nozzle.
	El EMPUJE/knockback lo maneja GearUsageService (Networking.PowerHose.Activate);
	aquí va SOLO el efecto visual del agua (replica a todos al estar en el Tool).
]]

local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")

local Tool = script.Parent
if not (Tool and Tool:IsA("Tool")) then
	return -- en el template (Model en Assets) no hace nada
end

local SPRAY_TIME = 0.8
local lastSpray = 0

local function getNozzleVFX()
	local nozzle = Tool:FindFirstChild("Nozzle")
	if not nozzle then
		return nil, nil
	end
	return nozzle:FindFirstChild("VFX"), nozzle
end

local function setEnabled(vfx, on)
	for _, emitter in vfx:GetChildren() do
		if emitter:IsA("ParticleEmitter") then
			if on then
				emitter:Emit(emitter:GetAttribute("EmitCount") or 6)
			end
			emitter.Enabled = on
		end
	end
end

Tool.Activated:Connect(function()
	if os.clock() - lastSpray < 0.4 then
		return -- antiespam del chorro
	end
	lastSpray = os.clock()

	local vfx, nozzle = getNozzleVFX()
	if not vfx then
		return
	end
	setEnabled(vfx, true)

	local sfxFolder = SoundService:FindFirstChild("SFX")
	local source = sfxFolder and sfxFolder:FindFirstChild("PowerHose")
	if source and nozzle then
		local sound = source:Clone()
		sound.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		sound.Parent = nozzle
		sound.TimePosition = 0
		sound.Playing = true
		Debris:AddItem(sound, 3)
	end

	task.delay(SPRAY_TIME, function()
		if vfx.Parent then
			setEnabled(vfx, false)
		end
	end)
end)

-- por si arranca con los emisores encendidos, apagarlos al inicio
do
	local vfx = getNozzleVFX()
	if vfx then
		for _, emitter in vfx:GetChildren() do
			if emitter:IsA("ParticleEmitter") then
				emitter.Enabled = false
			end
		end
	end
end
