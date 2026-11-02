-- Made By Loxy (Fixed Boost Vfx)
-- Race condition & yield fix: observeTag callback must NOT yield and must return a function
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Observers = require(ReplicatedStorage.Packages.Observers)
local Spring = require(ReplicatedStorage.Packages.Spring)
local t = {}

local function collectBoostVfx(rig)
	local beams = {}
	local particles = {}

	-- Non-yielding: FindFirstChild kullanıyoruz (WaitForChild yield eder, observeTag callback'inde kullanılamaz)
	local Cube = rig:FindFirstChild("Cube")
	if not Cube then return beams, particles end

	local Bone = Cube:FindFirstChild("Bone")
	if not Bone then return beams, particles end

	local Boosting = Bone:FindFirstChild("Boosting")
	if not Boosting then return beams, particles end

	-- Boosting altındaki tüm Beam ve ParticleEmitter'ları topla
	for _, descendant in ipairs(Boosting:GetDescendants()) do
		if descendant:IsA("Beam") then
			descendant.Enabled = true -- Beam'ler varsayılan kapalı, açıyoruz
			table.insert(beams, {
				Beam = descendant,
				Width0 = descendant.Width0,
				Width1 = descendant.Width1
			})
		elseif descendant:IsA("ParticleEmitter") then
			table.insert(particles, descendant)
		end
	end

	return beams, particles
end

Observers.observeTag("WaveriderRig", function(rig)
	local beams = {}
	local particles = {}
	local attrConn = nil
	local spring = Spring.new(0)
	spring.Speed = 16
	spring.Damper = 0.7
	spring.Target = 0

	local cancelled = false

	local function initVfx()
		if cancelled then return false end

		local collectedBeams, collectedParticles = collectBoostVfx(rig)
		if #collectedBeams == 0 and #collectedParticles == 0 then
			return false
		end

		beams = collectedBeams
		particles = collectedParticles

		-- Mevcut boost durumunu kontrol et
		local isBoosting = rig:GetAttribute("BoostBeams") == true
		spring.Target = if isBoosting then 1 else 0

		for _, emitter in ipairs(particles) do
			emitter.Enabled = isBoosting
		end

		-- Boost attribute değişikliğini dinle
		attrConn = rig:GetAttributeChangedSignal("BoostBeams"):Connect(function()
			if cancelled then return end
			local boosting = rig:GetAttribute("BoostBeams") == true
			spring.Target = if boosting then 1 else 0
			for _, emitter in ipairs(particles) do
				emitter.Enabled = boosting
			end
		end)

		-- RenderStepped için tabloya ekle
		t[rig] = {
			Spring = spring,
			Beams = beams,
			Particles = particles
		}

		return true
	end

	-- Önce senkron (non-yielding) dene
	if not initVfx() then
		-- Rig henüz tam yüklenmemiş, arka planda bekle
		task.spawn(function()
			if cancelled then return end
			local Cube = rig:WaitForChild("Cube", 15)
			if cancelled or not Cube then return end
			local Bone = Cube:WaitForChild("Bone", 15)
			if cancelled or not Bone then return end
			local Boosting = Bone:WaitForChild("Boosting", 15)
			if cancelled or not Boosting then return end
			initVfx()
		end)
	end

	-- observeTag callback'i HER ZAMAN bir fonksiyon dönmek zorundur (nil assertion hatası verir)
	return function()
		cancelled = true
		if attrConn then
			attrConn:Disconnect()
		end
		t[rig] = nil
	end
end)

RunService.RenderStepped:Connect(function()
	for rig, data in t do
		local springPos = math.max(data.Spring.Position, 0)

		for i = #data.Beams, 1, -1 do
			local beamData = data.Beams[i]
			-- pcall: Beam destroy edilmişse loop çökmesini engelle
			local ok = pcall(function()
				beamData.Beam.Width0 = beamData.Width0 * springPos
				beamData.Beam.Width1 = beamData.Width1 * springPos
			end)
			if not ok then
				table.remove(data.Beams, i)
			end
		end
	end
end)