-- DemonCity.Mood : l'ambiance de la ville détruite (côté client) : ciel sombre aux nuages rouges (le ciel d'Halloween du
-- jeu, copié dans DemonCity.DemonSky), brume rouge sang, lumière de fin de journée rouge-orangée, image plus contrastée.
-- Utilisée par la cinématique (FightFilm.DemonFilm) et par le combat (DemonArenaClient).
--   Mood.enter()           allume l'ambiance (compteur : la cinématique puis le combat se relaient sans coupure) et met en
--                          pause la musique du jeu ("Days")
--   Mood.leave(grace)      l'éteint quand plus personne ne l'utilise : l'éclairage et la musique du jeu reviennent exactement
--                          comme avant ; grace = secondes d'attente (si le combat reprend l'ambiance entre-temps, rien ne bouge)
--   Mood.setLevel(n, t)    1 = ville en feu, 2 = attaque ultime / boss enragé (plus rouge, plus sombre)
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local rgb = Color3.fromRGB

local Mood = {}
local LIGHT = {
	ClockTime = 17.6, Brightness = 2.6, Ambient = rgb(120, 70, 66), OutdoorAmbient = rgb(190, 110, 96),
	ColorShift_Top = rgb(255, 110, 70), ExposureCompensation = 0.2,
}
local LEVELS = {
	[1] = {
		atmosphere = {Density = 0.34, Offset = 0.14, Color = rgb(205, 66, 44), Decay = rgb(120, 24, 22), Glare = 0.5, Haze = 2.0},
		grade = {TintColor = rgb(255, 214, 205), Saturation = 0.12, Contrast = 0.12, Brightness = 0},
	},
	[2] = {
		atmosphere = {Density = 0.47, Offset = 0.2, Color = rgb(225, 42, 30), Decay = rgb(95, 10, 12), Glare = 1.1, Haze = 2.7},
		grade = {TintColor = rgb(255, 182, 172), Saturation = 0.22, Contrast = 0.22, Brightness = -0.04},
	},
}

local users = 0
local saved, atmosphere, grade, sky
local level = 1
local leaveToken = 0

local function apply(props, obj, t)
	if not obj then return end
	if t and t > 0 then
		TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Sine), props):Play()
	else
		for k, v in props do obj[k] = v end
	end
end

function Mood.setLevel(n, t)
	level = LEVELS[n] and n or 1
	if not saved then return end
	apply(LEVELS[level].atmosphere, atmosphere, t)
	apply(LEVELS[level].grade, grade, t)
end

function Mood.enter()
	leaveToken += 1 -- (une sortie différée en attente est annulée)
	users += 1
	if users > 1 or saved then return end
	saved = {props = {}, moved = {}}
	local days = game:GetService("SoundService"):FindFirstChild("Days")
	if days and days.IsPlaying then days:Pause() saved.days = days end
	for k, v in LIGHT do
		saved.props[k] = Lighting[k]
		Lighting[k] = v
	end
	-- le ciel et la brume du jeu sont mis de côté le temps de l'ambiance (remis à l'identique ensuite)
	for _, c in Lighting:GetChildren() do
		if c:IsA("Sky") or c:IsA("Atmosphere") then table.insert(saved.moved, c) c.Parent = nil end
	end
	local template = script.Parent:FindFirstChild("DemonSky")
	if template then
		sky = template:Clone()
		sky.Name = "DemonCitySky"
		sky.Parent = Lighting
	end
	atmosphere = Instance.new("Atmosphere")
	atmosphere.Name = "DemonCityAtmosphere"
	atmosphere.Parent = Lighting
	grade = Instance.new("ColorCorrectionEffect")
	grade.Name = "DemonCityGrade"
	grade.Parent = Lighting
	Mood.setLevel(level, 0)
	-- un autre script du jeu peut toucher à l'éclairage : on remet le nôtre tant que l'ambiance est allumée
	local mine = saved
	task.spawn(function()
		while saved == mine do
			task.wait(0.5)
			if saved ~= mine then break end
			for k, v in LIGHT do if Lighting[k] ~= v then Lighting[k] = v end end
			for _, c in Lighting:GetChildren() do
				if (c:IsA("Sky") and c ~= sky) or (c:IsA("Atmosphere") and c ~= atmosphere) then table.insert(mine.moved, c) c.Parent = nil end
			end
			if atmosphere and atmosphere.Parent ~= Lighting then atmosphere.Parent = Lighting end
			if sky and sky.Parent ~= Lighting then sky.Parent = Lighting end
		end
	end)
end

local function teardown()
	if users > 0 or not saved then return end
	level = 1
	if saved.days and saved.days.Parent then saved.days:Resume() end
	if atmosphere then atmosphere:Destroy() end
	if grade then grade:Destroy() end
	if sky then sky:Destroy() end
	if saved then
		for k, v in saved.props do Lighting[k] = v end
		for _, c in saved.moved do pcall(function() c.Parent = Lighting end) end
	end
	saved, atmosphere, grade, sky = nil, nil, nil, nil
end

function Mood.leave(grace)
	if users <= 0 then return end
	users -= 1
	if users > 0 then return end
	if grace and grace > 0 then
		leaveToken += 1
		local token = leaveToken
		task.delay(grace, function() if leaveToken == token then teardown() end end)
	else
		teardown()
	end
end

function Mood.active() return users > 0 end

return Mood
