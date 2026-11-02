-- PushStatsServer.lua (Script dans ServerScriptService)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local PushStatsToBin = ReplicatedStorage:WaitForChild("PushStatsToBin")

local JSONBIN_BIN_ID         = "69a871b943b1c97be9b369c7"
local JSONBIN_BIN_ID_DETAILS = "69a88cddae596e708f5f7ecb"
local JSONBIN_API_KEY        = "$2a$10$zYpN4lgLUxpFrEj9gmHXSe8aamA0VMSGQ3wTgZUerR181/l5cUuP2"

local function pushToBin(binId, payload)
	local ok, err = pcall(function()
		HttpService:RequestAsync({
			Url    = "https://api.jsonbin.io/v3/b/" .. binId,
			Method = "PUT",
			Headers = {
				["Content-Type"] = "application/json",
				["X-Master-Key"] = JSONBIN_API_KEY,
			},
			Body = payload,
		})
	end)
	if not ok then
		warn("[PushStats] Erreur push: " .. tostring(err))
		return false
	end
	return true
end

PushStatsToBin.OnServerEvent:Connect(function(player, counts, mutSummary, traitSummary, totalBrainrots, totalPlayers)
	print("[PushStats] 📊 Push demandé par " .. player.Name .. " — " .. totalBrainrots .. " brainrots, " .. totalPlayers .. " joueurs")

	local p1 = HttpService:JSONEncode({
		counts         = counts,
		totalBrainrots = totalBrainrots,
		totalPlayers   = totalPlayers,
		lastUpdated    = os.time()
	})

	if pushToBin(JSONBIN_BIN_ID, p1) then
		print("[PushStats] ✅ Bin 1 pushé ! (" .. math.floor(#p1/1024) .. "KB)")
	end

	task.wait(1)

	local p2 = HttpService:JSONEncode({
		mutSummary   = mutSummary,
		traitSummary = traitSummary,
		lastUpdated  = os.time()
	})

	if pushToBin(JSONBIN_BIN_ID_DETAILS, p2) then
		print("[PushStats] ✅ Bin 2 pushé ! (" .. math.floor(#p2/1024) .. "KB)")
	end
end)

print("[PushStats] ✅ Serveur push stats chargé")