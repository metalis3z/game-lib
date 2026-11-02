-- ============================================
-- WINS LEADERBOARD - GLOBAL, DIAGNOSTIC MAXIMAL
-- À placer dans ServerScriptService (Script normal)
-- ============================================

print("🟢 [Wins] Le script démarre.") -- si tu ne vois même pas ÇA, le script ne tourne pas du tout

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

print("🟢 [Wins] Services chargés, tentative de require DataHandler...")

local requireOk, DataHandler = pcall(function()
	return require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))
end)

if not requireOk then
	print("🔴 [Wins] ECHEC du require DataHandler : " .. tostring(DataHandler))
	return
end

print("🟢 [Wins] DataHandler chargé avec succès.")

local UPDATE_INTERVAL = 10
local MAX_ENTRIES = 50
local DATA_KEY = "Wins"
local TITLE_TEXT = "🏆 Wins"

local playerNameCache = {}
local function getPlayerName(userId)
	if playerNameCache[userId] then
		return playerNameCache[userId]
	end
	local success, name = pcall(function()
		return Players:GetNameFromUserIdAsync(userId)
	end)
	if success and name then
		playerNameCache[userId] = name
		return name
	end
	return "Player_" .. tostring(userId)
end

local function formatNumber(num)
	if num >= 1e12 then
		return string.format("%.1fT", num / 1e12)
	elseif num >= 1e9 then
		return string.format("%.1fB", num / 1e9)
	elseif num >= 1e6 then
		return string.format("%.1fM", num / 1e6)
	elseif num >= 1e3 then
		return string.format("%.1fK", num / 1e3)
	else
		return tostring(math.floor(num))
	end
end

print("🟢 [Wins] Recherche de workspace.Leaderboards...")

local leaderboardsFolder = Workspace:WaitForChild("Leaderboards", 30)
if not leaderboardsFolder then
	print("🔴 [Wins] 'workspace.Leaderboards' INTROUVABLE après 30s. Vérifie qu'il existe dans l'Explorer, orthographe exacte.")
	return
end
print("🟢 [Wins] workspace.Leaderboards trouvé.")

local model = leaderboardsFolder:WaitForChild("WinsLeaderboard", 30)
if not model then
	print("🔴 [Wins] 'WinsLeaderboard' INTROUVABLE dans workspace.Leaderboards après 30s.")
	print("🔎 [Wins] Contenu actuel de workspace.Leaderboards :")
	for _, child in ipairs(leaderboardsFolder:GetChildren()) do
		print("   - " .. child.Name .. " (" .. child.ClassName .. ")")
	end
	return
end
print("🟢 [Wins] Model WinsLeaderboard trouvé.")

local lbInner = model:WaitForChild("Leaderboard", 10)
if not lbInner then
	print("🔴 [Wins] Objet 'Leaderboard' INTROUVABLE dans le model WinsLeaderboard.")
	print("🔎 [Wins] Contenu actuel de WinsLeaderboard :")
	for _, child in ipairs(model:GetChildren()) do
		print("   - " .. child.Name .. " (" .. child.ClassName .. ")")
	end
	return
end
print("🟢 [Wins] Objet 'Leaderboard' trouvé.")

local surfaceGui = nil
for _, child in ipairs(lbInner:GetChildren()) do
	if child.Name == "Board" then
		local sg = child:FindFirstChildOfClass("SurfaceGui")
		if sg then
			print("🟢 [Wins] Un 'Board' avec SurfaceGui trouvé : " .. child.Name)
			if sg:FindFirstChild("ScrollingFrame") then
				surfaceGui = sg
				break
			else
				print("🔴 [Wins] Ce SurfaceGui n'a PAS de 'ScrollingFrame' à l'intérieur.")
			end
		end
	end
end

if not surfaceGui then
	print("🔴 [Wins] Aucun SurfaceGui valide trouvé sous Leaderboard.")
	print("🔎 [Wins] Contenu actuel de l'objet Leaderboard :")
	for _, child in ipairs(lbInner:GetChildren()) do
		print("   - " .. child.Name .. " (" .. child.ClassName .. ")")
	end
	return
end

print("🟢 [Wins] SurfaceGui + ScrollingFrame trouvés. Le leaderboard est prêt !")

local scrollingFrame = surfaceGui:FindFirstChild("ScrollingFrame")
local entryCount = 0
for _, child in ipairs(scrollingFrame:GetChildren()) do
	if string.match(child.Name, "^Entry_%d+$") then
		entryCount += 1
	end
end
print("🟢 [Wins] " .. entryCount .. " objets Entry_X trouvés dans le ScrollingFrame.")

if entryCount == 0 then
	print("🔴 [Wins] ATTENTION : aucun 'Entry_1', 'Entry_2'... trouvé. Le leaderboard ne pourra rien afficher tant que ces objets n'existent pas.")
end

-- ============================
-- POUSSE LES STATS DES JOUEURS EN LIGNE
-- ============================
local function pushOnlinePlayersToStore()
	for _, player in ipairs(Players:GetPlayers()) do
		local ok, err = pcall(function()
			DataHandler.UpdateOrderedStores(player)
		end)
		if not ok then
			print("🔴 [Wins] Erreur UpdateOrderedStores pour " .. player.Name .. " : " .. tostring(err))
		end
	end
end

-- ============================
-- MET A JOUR L'AFFICHAGE
-- ============================
local function updateDisplay()
	local titleLabel = surfaceGui:FindFirstChild("TitleLabel")
	if titleLabel and titleLabel:IsA("TextLabel") then
		titleLabel.Text = TITLE_TEXT
	end

	local success, topEntries = pcall(function()
		return DataHandler.GetTopEntries(DATA_KEY, MAX_ENTRIES)
	end)

	if not success then
		print("🔴 [Wins] Erreur GetTopEntries : " .. tostring(topEntries))
		return
	end

	print("🟢 [Wins] GetTopEntries a renvoyé " .. #topEntries .. " entrée(s).")

	if #topEntries == 0 then
		print("🟡 [Wins] Le OrderedDataStore est vide. Si tu es en Studio, vérifie Game Settings > Security > 'Enable Studio Access to API Services'. Sinon, joue une partie et gagne un Win pour créer une première entrée.")
	end

	local playerData = {}
	for _, entry in ipairs(topEntries) do
		table.insert(playerData, {
			name = getPlayerName(entry.userId),
			value = entry.value,
		})
	end

	for i = 1, MAX_ENTRIES do
		local entry = scrollingFrame:FindFirstChild("Entry_" .. i)
		if not entry then continue end

		local rankLabel = entry:FindFirstChild("RankLabel")
		local nameLabel = entry:FindFirstChild("NameLabel")
		local scoreLabel = entry:FindFirstChild("ScoreLabel")

		if i <= #playerData then
			local data = playerData[i]
			if rankLabel then rankLabel.Text = tostring(i) end
			if nameLabel then nameLabel.Text = data.name end
			if scoreLabel then scoreLabel.Text = formatNumber(data.value) end
		else
			if rankLabel then rankLabel.Text = "" end
			if nameLabel then nameLabel.Text = "" end
			if scoreLabel then scoreLabel.Text = "" end
		end
	end
end

-- ============================
-- BOUCLE PRINCIPALE
-- ============================
task.spawn(function()
	while true do
		local ok1, err1 = pcall(pushOnlinePlayersToStore)
		if not ok1 then
			print("🔴 [Wins] Erreur pushOnlinePlayersToStore : " .. tostring(err1))
		end

		local ok2, err2 = pcall(updateDisplay)
		if not ok2 then
			print("🔴 [Wins] Erreur updateDisplay : " .. tostring(err2))
		end

		task.wait(UPDATE_INTERVAL)
	end
end)