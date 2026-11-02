-- Reference copy for study. Game: +1 Escape Kitty Keyboard (escape-kitty-keyboard)
-- Original: ServerScriptService/AdminPanelServer.server.lua  (430 lines)
-- What it does: Remote functions for an admin panel: player list, kick, DataStore ban/unban checked on join, freeze that survives respawn, fun actions (ragdoll, spin, invisible, spectate), per-admin cooldown.
-- Excerpt of lines 1-15, 20-429 (only the relevant part of a bigger script).
-- Note: Lines 16-19 held the original ADMIN_USER_IDS table with the game's own ids; removed on purpose. Add `local ADMIN_USER_IDS = { [yourUserId] = true }` before isPlayerAdmin.

-- ============================================
-- ADMIN PANEL SERVER - COMPLET
-- À placer dans ServerScriptService
-- ============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")

local banStore = DataStoreService:GetDataStore("BannedPlayers_V1")

-- ============================
-- LISTE DES ADMINS (METS TES USERID ICI)
-- ============================

-- ... (lines 16-19 skipped) ...


local function isPlayerAdmin(player)
	return ADMIN_USER_IDS[player.UserId] == true
end

-- ============================
-- REMOTES
-- ============================
local checkAdminRemote = Instance.new("RemoteFunction")
checkAdminRemote.Name = "CheckAdminAccess"
checkAdminRemote.Parent = ReplicatedStorage

local getPlayersRemote = Instance.new("RemoteFunction")
getPlayersRemote.Name = "GetServerPlayers"
getPlayersRemote.Parent = ReplicatedStorage

local moderationRemote = Instance.new("RemoteFunction")
moderationRemote.Name = "AdminModerationAction"
moderationRemote.Parent = ReplicatedStorage

local trollRemote = Instance.new("RemoteFunction")
trollRemote.Name = "AdminTrollAction"
trollRemote.Parent = ReplicatedStorage

local announceEffectRemote = Instance.new("RemoteEvent")
announceEffectRemote.Name = "AnnounceEffect"
announceEffectRemote.Parent = ReplicatedStorage

-- ============================
-- ANTI DOUBLE-EXECUTION (cooldown serveur par admin)
-- ============================
local lastActionTime = {}
local COOLDOWN = 1

local function isOnCooldown(player)
	local now = tick()
	local last = lastActionTime[player.UserId]
	if last and (now - last) < COOLDOWN then
		return true
	end
	lastActionTime[player.UserId] = now
	return false
end

-- ============================
-- CHECK ADMIN
-- ============================
checkAdminRemote.OnServerInvoke = function(player)
	return isPlayerAdmin(player)
end

-- ============================
-- LISTE DES JOUEURS
-- ============================
getPlayersRemote.OnServerInvoke = function(player)
	if not isPlayerAdmin(player) then return {} end
	local list = {}
	for _, p in pairs(Players:GetPlayers()) do
		table.insert(list, { name = p.Name, userId = p.UserId })
	end
	return list
end

-- ============================
-- MODERATION : ETATS
-- ============================
local frozenPlayers = {}

local function kickPlayer(target, reason)
	target:Kick("Vous avez été expulsé par un admin. Raison : " .. (reason or "Aucune raison fournie"))
end

local function freezePlayer(target)
	local character = target.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end
	frozenPlayers[target.UserId] = true
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.JumpHeight = 0
	return true
end

local function unfreezePlayer(target)
	local character = target.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end
	frozenPlayers[target.UserId] = nil
	humanoid.WalkSpeed = 16
	humanoid.JumpPower = 50
	return true
end

local function banPlayer(target, reason)
	local success = pcall(function()
		banStore:SetAsync("User_" .. target.UserId, {
			banned = true,
			reason = reason or "Aucune raison fournie",
			date = os.time(),
		})
	end)
	if success then
		target:Kick("Vous avez été banni. Raison : " .. (reason or "Aucune raison fournie"))
	end
	return success
end

local function unbanPlayer(userId)
	return pcall(function()
		banStore:RemoveAsync("User_" .. userId)
	end)
end

Players.PlayerAdded:Connect(function(player)
	local success, data = pcall(function()
		return banStore:GetAsync("User_" .. player.UserId)
	end)
	if success and data and data.banned then
		player:Kick("Vous êtes banni. Raison : " .. (data.reason or "Aucune raison"))
		return
	end

	player.CharacterAdded:Connect(function(character)
		if frozenPlayers[player.UserId] then
			task.wait(0.5)
			freezePlayer(player)
		end
	end)
end)

-- ============================
-- MODERATION : HANDLER
-- ============================
moderationRemote.OnServerInvoke = function(admin, action, targetUserId, reason)
	if not isPlayerAdmin(admin) then
		return false, "Accès refusé."
	end
	if isOnCooldown(admin) then
		return false, "⏳ Attends un peu avant la prochaine action."
	end

	if action == "unban" then
		local ok = unbanPlayer(targetUserId)
		return ok, ok and "✅ Joueur débanni." or "Erreur unban."
	end

	local target = Players:GetPlayerByUserId(targetUserId)
	if not target then return false, "Joueur introuvable." end

	if action == "kick" then
		kickPlayer(target, reason)
		return true, "✅ " .. target.Name .. " a été expulsé."

	elseif action == "freeze" then
		local ok = freezePlayer(target)
		return ok, ok and ("❄️ " .. target.Name .. " est freeze.") or "Erreur freeze."

	elseif action == "unfreeze" then
		local ok = unfreezePlayer(target)
		return ok, ok and ("🔥 " .. target.Name .. " est unfreeze.") or "Erreur unfreeze."

	elseif action == "ban" then
		local ok = banPlayer(target, reason)
		return ok, ok and ("🔨 " .. target.Name .. " a été banni.") or "Erreur ban."
	end

	return false, "Action inconnue."
end

-- ============================
-- TROLL : ETATS
-- ============================
local spectatingPlayers = {} -- [adminUserId] = targetUserId
local ragdolledPlayers = {}
local spinningPlayers = {}
local rainbowPlayers = {}

local function ragdollPlayer(target)
	local character = target.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end
	ragdolledPlayers[target.UserId] = true
	humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
	humanoid.PlatformStand = true
	return true
end

local function unragdollPlayer(target)
	local character = target.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end
	ragdolledPlayers[target.UserId] = nil
	humanoid.PlatformStand = false
	humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	return true
end

local function killPlayer(target)
	local character = target.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end
	humanoid.Health = 0
	return true
end

local function setInvisible(target, invisible)
	local character = target.Character
	if not character then return false end
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			part.Transparency = invisible and 1 or 0
		elseif part:IsA("Decal") then
			part.Transparency = invisible and 1 or 0
		end
	end
	return true
end

local function setSize(target, scale)
	local character = target.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end
	local success = pcall(function()
		humanoid.BodyDepthScale.Value = scale
		humanoid.BodyWidthScale.Value = scale
		humanoid.BodyHeightScale.Value = scale
		humanoid.HeadScale.Value = scale
	end)
	return success
end

local function setSpin(target, enabled)
	local character = target.Character
	if not character then return false end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return false end

	local existing = rootPart:FindFirstChild("TrollSpin")
	if existing then existing:Destroy() end

	if enabled then
		local bodyGyro = Instance.new("BodyAngularVelocity")
		bodyGyro.Name = "TrollSpin"
		bodyGyro.AngularVelocity = Vector3.new(0, 20, 0)
		bodyGyro.MaxTorque = Vector3.new(0, math.huge, 0)
		bodyGyro.Parent = rootPart
		spinningPlayers[target.UserId] = true
	else
		spinningPlayers[target.UserId] = nil
	end
	return true
end

local function setGravity(target, low)
	local character = target.Character
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end
	humanoid.JumpHeight = low and 30 or 7.2
	return true
end

local function setRainbow(target, enabled)
	local character = target.Character
	if not character then return false end

	local existing = character:FindFirstChild("RainbowLoop")
	if existing then existing:Destroy() end
	rainbowPlayers[target.UserId] = nil

	if enabled then
		local marker = Instance.new("BoolValue")
		marker.Name = "RainbowLoop"
		marker.Parent = character

		local conn
		conn = RunService.Heartbeat:Connect(function()
			if not marker.Parent then
				conn:Disconnect()
				return
			end
			local hue = (tick() % 5) / 5
			local color = Color3.fromHSV(hue, 1, 1)
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Color = color
				end
			end
		end)
		rainbowPlayers[target.UserId] = conn
	end
	return true
end

-- Réapplique le respawn propre (enlève les effets residuels au respawn)
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		ragdolledPlayers[player.UserId] = nil
		spinningPlayers[player.UserId] = nil
		if rainbowPlayers[player.UserId] then
			rainbowPlayers[player.UserId] = nil
		end
	end)
end)

-- ============================
-- TROLL : HANDLER
-- ============================
trollRemote.OnServerInvoke = function(admin, action, targetUserId)
	if not isPlayerAdmin(admin) then
		return false, "Accès refusé."
	end
	if isOnCooldown(admin) then
		return false, "⏳ Attends un peu."
	end

	if action == "unspectate" then
		spectatingPlayers[admin.UserId] = nil
		return true, "👁️ Spectate arrêté."
	end

	local target = Players:GetPlayerByUserId(targetUserId)
	if not target then return false, "Joueur introuvable." end

	if action == "spectate" then
		spectatingPlayers[admin.UserId] = target.UserId
		return true, "👁️ Spectate " .. target.Name

	elseif action == "ragdoll" then
		local ok = ragdollPlayer(target)
		return ok, ok and ("🦴 " .. target.Name .. " ragdoll.") or "Erreur."

	elseif action == "unragdoll" then
		local ok = unragdollPlayer(target)
		return ok, ok and ("🦴 " .. target.Name .. " relevé.") or "Erreur."

	elseif action == "kill" then
		local ok = killPlayer(target)
		return ok, ok and ("💀 " .. target.Name .. " tué.") or "Erreur."

	elseif action == "invisible" then
		local ok = setInvisible(target, true)
		return ok, ok and ("👻 " .. target.Name .. " invisible.") or "Erreur."

	elseif action == "visible" then
		local ok = setInvisible(target, false)
		return ok, ok and ("👤 " .. target.Name .. " visible.") or "Erreur."

	elseif action == "giant" then
		local ok = setSize(target, 3)
		return ok, ok and ("🗿 " .. target.Name .. " géant.") or "Erreur."

	elseif action == "tiny" then
		local ok = setSize(target, 0.4)
		return ok, ok and ("🐜 " .. target.Name .. " minuscule.") or "Erreur."

	elseif action == "normalsize" then
		local ok = setSize(target, 1)
		return ok, ok and ("↩️ " .. target.Name .. " taille normale.") or "Erreur."

	elseif action == "spin" then
		local ok = setSpin(target, true)
		return ok, ok and ("🌀 " .. target.Name .. " en rotation.") or "Erreur."

	elseif action == "unspin" then
		local ok = setSpin(target, false)
		return ok, ok and "🌀 Rotation arrêtée." or "Erreur."

	elseif action == "lowgravity" then
		local ok = setGravity(target, true)
		return ok, ok and ("🎈 " .. target.Name .. " gravité faible.") or "Erreur."

	elseif action == "normalgravity" then
		local ok = setGravity(target, false)
		return ok, ok and "↩️ Gravité normale." or "Erreur."

	elseif action == "rainbow" then
		local ok = setRainbow(target, true)
		return ok, ok and ("🌈 " .. target.Name .. " rainbow.") or "Erreur."

	elseif action == "unrainbow" then
		local ok = setRainbow(target, false)
		return ok, ok and "↩️ Rainbow arrêté." or "Erreur."
	end

	return false, "Action inconnue."
end

-- ============================
-- NETTOYAGE A LA DECONNEXION
-- ============================
Players.PlayerRemoving:Connect(function(player)
	frozenPlayers[player.UserId] = nil
	ragdolledPlayers[player.UserId] = nil
	spinningPlayers[player.UserId] = nil
	rainbowPlayers[player.UserId] = nil
	spectatingPlayers[player.UserId] = nil
end)

print("✅ Admin Panel Server chargé")

-- ============================
-- RAPPEL : dans ton AnnounceServer existant, ajoute après l'envoi :
-- game.ReplicatedStorage.AnnounceEffect:FireAllClients(message)
