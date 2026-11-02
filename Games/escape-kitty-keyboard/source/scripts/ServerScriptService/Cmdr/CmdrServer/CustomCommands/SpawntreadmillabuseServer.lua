local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LOW_GRAVITY = 50 -- gravité normale = 196.2, on baisse fort
local TRAIL_COLOR = Color3.fromRGB(170, 80, 255)

-- Evite de relancer le setup des trails plusieurs fois si la commande est réexécutée
local effectsAlreadySetup = false

-- ============================
-- APPLIQUE LE CIEL VIOLET (depuis l'objet "Sky Purple" mis dans AbuseTreadmill)
-- ============================
local function applyPurpleSky(sourceModel)
	local skyObject = sourceModel:FindFirstChild("Sky Purple") or sourceModel:FindFirstChild("SkyPurple")
	if not skyObject then
		warn("⚠️ [AbuseTreadmill] Aucun objet 'Sky Purple' trouvé dans AbuseTreadmill.")
		return false
	end

	-- Retire les Sky déjà présents dans Lighting pour éviter les conflits
	for _, obj in ipairs(Lighting:GetChildren()) do
		if obj:IsA("Sky") then
			obj:Destroy()
		end
	end

	local newSky = skyObject:Clone()
	newSky.Parent = Lighting
	return true
end

-- ============================
-- APPLIQUE LA FAIBLE GRAVITE
-- Workspace.Gravity est UNE SEULE valeur pour TOUT le serveur (pas par joueur).
-- Elle reste donc active pour tout le monde même après un respawn/la mort d'un
-- joueur, tant que rien ne la remet explicitement à sa valeur normale. C'est le
-- comportement natif de Roblox, pas un bug : Roblox ne propose pas de gravité
-- par joueur, seulement une gravité globale au niveau du Workspace.
-- ============================
local function applyLowGravity()
	Workspace.Gravity = LOW_GRAVITY
end

-- ============================
-- AJOUTE UNE TRAINEE VIOLETTE AUX PIEDS, VISIBLE PENDANT LE SAUT
-- ============================
local function setupJumpTrail(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	-- Compatible R15 (LeftFoot/RightFoot) et R6 (Left Leg/Right Leg)
	local leftFoot = character:FindFirstChild("LeftFoot") or character:FindFirstChild("Left Leg")
	local rightFoot = character:FindFirstChild("RightFoot") or character:FindFirstChild("Right Leg")
	if not leftFoot or not rightFoot then return end

	local function createTrailOnPart(part)
		local attachment0 = Instance.new("Attachment")
		attachment0.Name = "JumpTrailAttach0"
		attachment0.Position = Vector3.new(0, 0.4, 0)
		attachment0.Parent = part

		local attachment1 = Instance.new("Attachment")
		attachment1.Name = "JumpTrailAttach1"
		attachment1.Position = Vector3.new(0, -0.4, 0)
		attachment1.Parent = part

		local trail = Instance.new("Trail")
		trail.Name = "PurpleJumpTrail"
		trail.Attachment0 = attachment0
		trail.Attachment1 = attachment1
		trail.Color = ColorSequence.new(TRAIL_COLOR)
		trail.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.2),
			NumberSequenceKeypoint.new(1, 1),
		})
		trail.Lifetime = 0.4
		trail.MinLength = 0
		trail.WidthScale = NumberSequence.new(0.5)
		trail.Enabled = false
		trail.Parent = part

		return trail
	end

	local trailLeft = createTrailOnPart(leftFoot)
	local trailRight = createTrailOnPart(rightFoot)

	humanoid.StateChanged:Connect(function(_, newState)
		local isJumping = (newState == Enum.HumanoidStateType.Jumping or newState == Enum.HumanoidStateType.Freefall)
		trailLeft.Enabled = isJumping
		trailRight.Enabled = isJumping
	end)
end

-- setupTrailsForAllPlayers connecte CharacterAdded UNE SEULE FOIS par joueur,
-- donc même après un respawn (mort), la traînée est automatiquement recréée
-- sur le nouveau personnage sans avoir besoin de relancer la commande.
local function setupTrailsForAllPlayers()
	local function onCharacterAdded(character)
		task.wait(0.5) -- laisse le temps aux parts de bien se charger
		local ok, err = pcall(setupJumpTrail, character)
		if not ok then
			warn("⚠️ [AbuseTreadmill] Erreur setupJumpTrail : " .. tostring(err))
		end
	end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character then
			onCharacterAdded(plr.Character)
		end
		plr.CharacterAdded:Connect(onCharacterAdded)
	end

	Players.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(onCharacterAdded)
	end)
end

-- ============================
-- MESSAGE EN HAUT DE L'ECRAN (envoyé à tous les joueurs, donc global aussi)
-- ============================
local function showEventMessage(player)
	local playerGui = player:FindFirstChild("PlayerGui")
	if not playerGui then return end

	local oldGui = playerGui:FindFirstChild("AbuseEventGui")
	if oldGui then
		oldGui:Destroy()
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "AbuseEventGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	local label = Instance.new("TextLabel")
	label.AnchorPoint = Vector2.new(0.5, 0)
	label.Position = UDim2.new(0.5, 0, 0.03, 0)
	label.Size = UDim2.new(0, 700, 0, 50)
	label.BackgroundTransparency = 1
	label.Text = "Admin Abuse Treadmill event is here!"
	label.TextColor3 = Color3.fromRGB(170, 80, 255)
	label.TextStrokeColor3 = Color3.new(0, 0, 0)
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.Parent = screenGui

	task.delay(6, function()
		if screenGui then
			screenGui:Destroy()
		end
	end)
end

-- ============================
-- COMMANDE : spawn + applique tous les effets (globalement, à tout le serveur)
-- ============================
return function(context)
	local treadmillFolder = Workspace:FindFirstChild("Treadmill")
	if not treadmillFolder then
		return "❌ Erreur : le folder 'Treadmill' n'existe pas dans workspace."
	end

	local sourceModel = treadmillFolder:FindFirstChild("AbuseTreadmill")
	if not sourceModel then
		return "❌ Erreur : le model 'AbuseTreadmill' est introuvable dans le folder Treadmill."
	end

	-- Clone le model existant pour en spawner un nouveau
	local newModel = sourceModel:Clone()
	newModel.Parent = treadmillFolder
	local targetPosition = Vector3.new(-146.52, 10.793, 53.42)

	if newModel.PrimaryPart then
		newModel:SetPrimaryPartCFrame(CFrame.new(targetPosition))
	else
		local firstPart = newModel:FindFirstChildWhichIsA("BasePart", true)
		if firstPart then
			local offset = targetPosition - firstPart.Position
			for _, part in pairs(newModel:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Position = part.Position + offset
				end
			end
		end
	end

	-- Applique le ciel violet (lu depuis le model source, avant clone en double)
	local skyOk = applyPurpleSky(sourceModel)

	-- Applique la faible gravité globale (persiste après la mort, voir commentaire plus haut)
	applyLowGravity()

	-- Met en place les traînées violettes au saut (une seule fois, persiste aussi après la mort)
	if not effectsAlreadySetup then
		effectsAlreadySetup = true
		local ok, err = pcall(setupTrailsForAllPlayers)
		if not ok then
			warn("⚠️ [AbuseTreadmill] Erreur setupTrailsForAllPlayers : " .. tostring(err))
		end
	end

	local resultMsg = "✅ AbuseTreadmill spawné. Gravité réduite à " .. LOW_GRAVITY .. " (globale, tout le serveur, persiste après la mort). Traînée violette activée au saut."
	if skyOk then
		resultMsg = resultMsg .. " Ciel violet appliqué."
	else
		resultMsg = resultMsg .. " ⚠️ Ciel violet NON appliqué (objet 'Sky Purple' introuvable)."
	end

	for _, player in ipairs(Players:GetPlayers()) do
		showEventMessage(player)
	end

	return resultMsg
end