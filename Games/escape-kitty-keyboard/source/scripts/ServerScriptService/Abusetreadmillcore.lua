-- ============================================
-- ABUSE TREADMILL CORE (ModuleScript)
-- À placer dans ServerScriptService
-- Source UNIQUE de vérité, utilisée par le panel ET les commandes Cmdr
-- ============================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Core = {}

local LOW_GRAVITY = 50
local NORMAL_GRAVITY = 196.2
local TRAIL_COLOR = Color3.fromRGB(170, 80, 255)

local ACTIVE_Y = 10.793
local INACTIVE_Y = 0.793
local FIXED_X = -146.52
local FIXED_Z = 53.42

local isActive = false
local originalSkyClone = nil
local trailsSetupDone = false

-- ============================
-- POSITION DU TAPIS (monte/descend selon l'état)
-- ============================
local function getTreadmillModel()
	local treadmillFolder = Workspace:FindFirstChild("Treadmill")
	if not treadmillFolder then return nil end
	return treadmillFolder:FindFirstChild("AbuseTreadmill")
end

local function moveTreadmill(yPosition)
	local model = getTreadmillModel()
	if not model then
		warn("⚠️ [AbuseTreadmillCore] Model 'AbuseTreadmill' introuvable dans workspace.Treadmill.")
		return false
	end

	local targetPosition = Vector3.new(FIXED_X, yPosition, FIXED_Z)

	if model:IsA("Model") and model.PrimaryPart then
		model:SetPrimaryPartCFrame(CFrame.new(targetPosition))
	elseif model:IsA("BasePart") then
		model.Position = targetPosition
	else
		local firstPart = model:FindFirstChildWhichIsA("BasePart", true)
		if firstPart then
			local offset = targetPosition - firstPart.Position
			for _, part in pairs(model:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Position = part.Position + offset
				end
			end
		else
			return false
		end
	end

	return true
end

-- ============================
-- CIEL
-- ============================
local function findSkyObject()
	local model = getTreadmillModel()
	if not model then return nil end
	return model:FindFirstChild("Sky Purple") or model:FindFirstChild("SkyPurple")
end

local function saveOriginalSkyIfNeeded()
	if originalSkyClone then return end
	local existingSky = Lighting:FindFirstChildOfClass("Sky")
	if existingSky then
		originalSkyClone = existingSky:Clone()
	end
end

local function applyPurpleSky()
	local skyObject = findSkyObject()
	if not skyObject then
		warn("⚠️ [AbuseTreadmillCore] Objet 'Sky Purple' introuvable.")
		return false
	end

	saveOriginalSkyIfNeeded()

	for _, obj in ipairs(Lighting:GetChildren()) do
		if obj:IsA("Sky") then
			obj:Destroy()
		end
	end

	skyObject:Clone().Parent = Lighting
	return true
end

local function restoreOriginalSky()
	for _, obj in ipairs(Lighting:GetChildren()) do
		if obj:IsA("Sky") then
			obj:Destroy()
		end
	end
	if originalSkyClone then
		originalSkyClone:Clone().Parent = Lighting
	end
end

-- ============================
-- GRAVITE (globale, tout le serveur — persiste après la mort, c'est normal)
-- ============================
local function applyLowGravity()
	Workspace.Gravity = LOW_GRAVITY
end

local function restoreGravity()
	Workspace.Gravity = NORMAL_GRAVITY
end

-- ============================
-- TRAINEE VIOLETTE AU SAUT
-- ============================
local function setupJumpTrail(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local leftFoot = character:FindFirstChild("LeftFoot") or character:FindFirstChild("Left Leg")
	local rightFoot = character:FindFirstChild("RightFoot") or character:FindFirstChild("Right Leg")
	if not leftFoot or not rightFoot then return end

	local function createTrailOnPart(part)
		if part:FindFirstChild("PurpleJumpTrail") then
			return part.PurpleJumpTrail
		end

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
		trailLeft.Enabled = isJumping and isActive
		trailRight.Enabled = isJumping and isActive
	end)
end

local function setupTrailsForAllPlayers()
	if trailsSetupDone then return end
	trailsSetupDone = true

	local function onCharacterAdded(character)
		task.wait(0.5)
		local ok, err = pcall(setupJumpTrail, character)
		if not ok then
			warn("⚠️ [AbuseTreadmillCore] Erreur setupJumpTrail : " .. tostring(err))
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
-- MESSAGE EN HAUT DE L'ECRAN
-- ============================
local function showEventMessage(player, text)
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
	label.Text = text
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

local function broadcastEventMessage(text)
	for _, plr in ipairs(Players:GetPlayers()) do
		showEventMessage(plr, text)
	end
end

-- ============================
-- API PUBLIQUE
-- ============================
function Core.IsActive()
	return isActive
end

function Core.Activate()
	if isActive then return true, "Déjà actif." end

	isActive = true
	moveTreadmill(ACTIVE_Y)
	applyPurpleSky()
	applyLowGravity()
	setupTrailsForAllPlayers()
	broadcastEventMessage("Admin Abuse Treadmill event is here!")

	print("🟢 [AbuseTreadmillCore] Effets ACTIVÉS globalement.")
	return true, "Activé"
end

function Core.Deactivate()
	if not isActive then
		-- Même si déjà inactif, on s'assure que la position/gravité/ciel sont bien remis
		-- (utile pour la commande manuelle StopTreadmill en cas de désync)
		moveTreadmill(INACTIVE_Y)
		restoreOriginalSky()
		restoreGravity()
		return true, "Déjà inactif (état re-synchronisé)."
	end

	isActive = false
	moveTreadmill(INACTIVE_Y)
	restoreOriginalSky()
	restoreGravity()

	print("🔴 [AbuseTreadmillCore] Effets DÉSACTIVÉS globalement.")
	return true, "Désactivé"
end

return Core