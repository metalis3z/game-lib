-- Ambiance par zone : selon la zone où se trouve le joueur, l'image devient plus claire ou plus sombre, plus chaude ou plus froide,
-- avec une brume de la couleur de la zone. Tout est local (un ColorCorrection "ZoneGrade" + l'Atmosphere), en fondu doux.
-- Ne touche pas aux réglages de Lighting gérés par NightServer ni à la ColorCorrection des events (SkyEventsClient).
-- La nuit (ReplicatedStorage.IsNight), les zones sombres le sont un peu moins pour qu'on voie toujours bien la carte.
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local rgb = Color3.fromRGB
local FADE = TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

-- Tint / Brightness / Contrast / Saturation = ColorCorrection ; Density / Haze / Glare / Color / Decay = Atmosphere
local MOODS = {
	Safe      = {Tint = rgb(255, 252, 245), Brightness = 0.02,  Contrast = 0.03, Saturation = 0.05,  Density = 0.24, Haze = 0,   Glare = 0,   Color = rgb(200, 216, 235), Decay = rgb(110, 130, 160)},
	Common    = {Tint = rgb(255, 250, 235), Brightness = 0,     Contrast = 0.06, Saturation = 0.02,  Density = 0.26, Haze = 0.5, Glare = 0,   Color = rgb(210, 230, 212), Decay = rgb(120, 150, 120)},
	Uncommon  = {Tint = rgb(236, 255, 230), Brightness = -0.05, Contrast = 0.1,  Saturation = 0.04,  Density = 0.32, Haze = 1,   Glare = 0,   Color = rgb(170, 205, 160), Decay = rgb(80, 120, 70)},
	Rare      = {Tint = rgb(222, 240, 255), Brightness = 0.03,  Contrast = 0.05, Saturation = 0.1,   Density = 0.3,  Haze = 0.6, Glare = 0.1, Color = rgb(165, 205, 240), Decay = rgb(70, 120, 180)},
	Epic      = {Tint = rgb(228, 242, 255), Brightness = 0.08,  Contrast = 0.02, Saturation = -0.1,  Density = 0.35, Haze = 1.5, Glare = 0.3, Color = rgb(228, 240, 255), Decay = rgb(160, 190, 225)},
	Legendary = {Tint = rgb(255, 240, 212), Brightness = 0.03,  Contrast = 0.06, Saturation = 0.1,   Density = 0.33, Haze = 2,   Glare = 0.4, Color = rgb(240, 215, 170), Decay = rgb(200, 150, 90)},
	Mythic    = {Tint = rgb(255, 228, 210), Brightness = -0.1,  Contrast = 0.16, Saturation = -0.12,  Density = 0.4,  Haze = 2,   Glare = 0.2, Color = rgb(150, 70, 45),   Decay = rgb(110, 30, 10)},
	Secret    = {Tint = rgb(222, 195, 255), Brightness = -0.14, Contrast = 0.2,  Saturation = -0.05, Density = 0.42, Haze = 1.5, Glare = 0,   Color = rgb(80, 45, 100),   Decay = rgb(60, 15, 60)},
	Ancient   = {Tint = rgb(255, 240, 212), Brightness = -0.03, Contrast = 0.1,  Saturation = 0.05,  Density = 0.34, Haze = 1.5, Glare = 0.1, Color = rgb(200, 190, 150), Decay = rgb(130, 110, 70)},
	OG        = {Tint = rgb(255, 234, 246), Brightness = 0.06,  Contrast = 0.03, Saturation = 0.2,   Density = 0.28, Haze = 0.6, Glare = 0.1, Color = rgb(255, 212, 236), Decay = rgb(220, 140, 190)},
	Divine    = {Tint = rgb(255, 248, 228), Brightness = 0.1,   Contrast = -0.02, Saturation = 0.02, Density = 0.3,  Haze = 1,   Glare = 0.5, Color = rgb(255, 246, 222), Decay = rgb(240, 210, 150)},
	Prismatic = {Tint = rgb(225, 195, 255), Brightness = -0.17, Contrast = 0.22, Saturation = -0.08, Density = 0.45, Haze = 1.5, Glare = 0.2, Color = rgb(65, 38, 85),    Decay = rgb(255, 120, 40)},
	Galactic  = {Tint = rgb(205, 200, 255), Brightness = -0.12, Contrast = 0.18, Saturation = 0.12,  Density = 0.42, Haze = 1.2, Glare = 0.4, Color = rgb(52, 40, 120),   Decay = rgb(90, 200, 255)},
}
-- sol de chaque zone (workspace) -> son ambiance
local FLOORS = {
	["safe zone"] = "Safe", ["common egg zone"] = "Common", ["UNcommon jungle egg zone"] = "Uncommon", ["RARE aquatic egg zone"] = "Rare",
	["EPIC Ice egg zone"] = "Epic", ["legendary egg zone"] = "Legendary", ["Mythic lava egg zone"] = "Mythic", ["SECRET demon egg zone"] = "Secret",
	["ANCIENT dino egg zone"] = "Ancient", ["OG candy egg zone"] = "OG", ["DIVINE angel egg zone"] = "Divine", ["Halloween demon egg zone"] = "Prismatic",
	["GALACTIC galaxy egg zone"] = "Galactic",
}

local grade = Instance.new("ColorCorrectionEffect")
grade.Name = "ZoneGrade"
grade.Parent = Lighting
local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
if not atmosphere then
	atmosphere = Instance.new("Atmosphere")
	atmosphere.Name = "ZoneAtmosphere"
	atmosphere.Offset = 0.15
	atmosphere.Parent = Lighting
end

-- zones alignées le long de l'axe X : on garde l'étendue de chaque sol
local ranges = {}
for name, mood in FLOORS do
	local floor = workspace:WaitForChild(name, 10)
	if floor and floor:IsA("BasePart") then
		table.insert(ranges, {Min = floor.Position.X - floor.Size.X / 2, Max = floor.Position.X + floor.Size.X / 2, Center = floor.Position.X, Mood = mood})
	end
end
local function moodAt(x)
	local best, bestDist
	for _, r in ranges do
		if x >= r.Min and x <= r.Max and r.Mood ~= "Safe" then return r.Mood end
		local d = math.abs(x - r.Center)
		if not bestDist or d < bestDist then best, bestDist = r.Mood, d end
	end
	for _, r in ranges do if x >= r.Min and x <= r.Max then return r.Mood end end
	return best or "Safe"
end

local current, wasNight
local function apply(name, night)
	local mood = MOODS[name] or MOODS.Safe
	local soften = night and mood.Brightness < 0 and 0.5 or 1 -- la nuit assombrit déjà : on garde la carte lisible
	TweenService:Create(grade, FADE, {TintColor = mood.Tint, Brightness = mood.Brightness * soften, Contrast = mood.Contrast, Saturation = mood.Saturation}):Play()
	TweenService:Create(atmosphere, FADE, {Density = mood.Density * (night and 0.8 or 1), Haze = mood.Haze, Glare = night and 0 or mood.Glare,
		Color = mood.Color, Decay = mood.Decay}):Play()
end

while true do
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local camera = workspace.CurrentCamera
	-- en jeu la caméra suit le joueur ; pendant une cinématique elle est ailleurs : c'est elle qui compte
	local x = camera and camera.CFrame.Position.X or (root and root.Position.X) or 0
	if root and camera and camera.CameraSubject and camera.CameraSubject:IsDescendantOf(character) then x = root.Position.X end
	local name = moodAt(x)
	local night = ReplicatedStorage:GetAttribute("IsNight") == true
	if name ~= current or night ~= wasNight then
		current, wasNight = name, night
		apply(name, night)
	end
	task.wait(0.4)
end
