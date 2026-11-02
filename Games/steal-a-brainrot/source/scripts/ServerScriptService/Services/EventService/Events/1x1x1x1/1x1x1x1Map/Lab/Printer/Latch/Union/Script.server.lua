-- Script dans l'Union (porte)
local porte = script.Parent
local tweenService = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")

local charniere = porte.Parent:FindFirstChild("Charniere")
if not charniere then
	warn("Crée une Part 'Charniere' au bord de la porte")
	return
end

charniere.Anchored = true

-- Configuration
local orientationFermee = Vector3.new(0, -90, 0)   -- Porte fermée
local orientationOuverte = Vector3.new(0, 0, 0)   -- Porte ouverte
local dureeAnim = 0.8
local tempsAvantFermeture = 3

local originalCFrame = porte.CFrame
local charniereCFrame = charniere.CFrame

local estOuverte = false
local dernierSignal = 0

-- Calculer l'offset relatif à la charnière
local offsetRelatif = charniereCFrame:ToObjectSpace(originalCFrame)

local function pivoterPorte(orientationCible)
	-- Calculer la rotation à appliquer
	local angleRad = math.rad(orientationCible.Y)  -- Rotation sur Y seulement

	-- Rotation autour de la charnière
	local rotation = CFrame.Angles(0, angleRad, 0)

	-- Nouveau CFrame : charnière pivotée * offset relatif
	local nouveauCFrame = charniereCFrame * rotation * offsetRelatif

	local tween = tweenService:Create(porte,
		TweenInfo.new(dureeAnim, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
		{CFrame = nouveauCFrame}
	)
	tween:Play()
	return tween
end

local function ouvrirPorte()
	if not estOuverte then
		pivoterPorte(orientationOuverte)
		estOuverte = true
		print("🚪 Porte ouverte - orientation:", orientationOuverte)
	end
end

local function fermerPorte()
	if estOuverte then
		pivoterPorte(orientationFermee)
		estOuverte = false
		print("🚪 Porte fermée - orientation:", orientationFermee)
	end
end

-- Boucle qui vérifie en continu s'il faut fermer
task.spawn(function()
	while true do
		if estOuverte then
			local tempsEcoule = os.time() - dernierSignal
			if tempsEcoule >= tempsAvantFermeture then
				fermerPorte()
			end
		end
		task.wait(0.5)
	end
end)

-- Écouter le BindableEvent
local animalSpawnBindable = replicatedStorage:FindFirstChild("AnimalSpawnBindable")

if animalSpawnBindable then
	animalSpawnBindable.Event:Connect(function()
		dernierSignal = os.time()
		print("🦊 Signal reçu - ouverture porte")
		ouvrirPorte()
	end)
	print("✅ Porte connectée au signal AnimalSpawnBindable")
else
	warn("❌ AnimalSpawnBindable non trouvé dans ReplicatedStorage!")
end

-- Forcer la porte en position fermée au démarrage
task.wait(0.5)
pivoterPorte(orientationFermee)
estOuverte = false
print("🚪 Porte initialisée en position fermée")

print("🚪 Porte prête - fermée à 90°, ouverte à 0°")