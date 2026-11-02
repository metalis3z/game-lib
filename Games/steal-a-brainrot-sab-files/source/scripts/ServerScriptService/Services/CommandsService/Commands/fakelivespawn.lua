local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)

-- Liste des faux joueurs
local FAKE_PLAYERS = {
	{ name = "xX_EXOTIQUE", avatarId = 23829062 },
	{ name = "DarFrenchh2024", avatarId = 43752760 },
	{ name = "NovaFan-COCONUT", avatarId = 69251320 },
	{ name = "SkibidiNOvaFan", avatarId = 123456789 },
	{ name = "RizzGod_123", avatarId = 987654321 },
	{ name = "SigmaGrinder", avatarId = 111111111 },
	{ name = "OhioFinalBoss", avatarId = 222222222 },
	{ name = "Brainrot2Stock", avatarId = 333333333 },
	{ name = "92IZI_Pro", avatarId = 444444444 },
	{ name = "LankyBox_Fan", avatarId = 555555555 },
}

local module = function(Conch, Config)
	Conch.register("fakelivespawn", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				{ kind = "argument", type = "FakePlayer", name = "Player" },
				{ kind = "argument", type = "Brainrot", name = "Brainrot" },
				{ kind = "argument", type = "Mutation", name = "Mutation", optional = true },
			}
		end,

		callback = function(playerName, brainrot, mutation)
			-- Trouver le faux joueur
			local fakePlayer = nil
			for _, fake in ipairs(FAKE_PLAYERS) do
				if fake.name == playerName then
					fakePlayer = fake
					break
				end
			end

			if not fakePlayer then
				return false, "Faux joueur non trouvé"
			end

			-- Trouver le brainrot
			local brainrotData = nil
			local brainrotName = nil
			for name, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then
					brainrotData = data
					brainrotName = name
					break
				end
			end

			if not brainrotData then
				return false, "Brainrot non trouvé"
			end

			-- Valider la mutation
			local mutParam = nil
			if mutation and mutation ~= "" and mutation ~= "Normal" then
				if not Mutations[mutation] then
					return false, "Mutation non trouvée"
				end
				mutParam = mutation
			end

			-- Créer l'entrée dans le Liveboard
			local success, LiveboardService = pcall(function()
				return require(ServerScriptService.Services.LiveboardService)
			end)

			if success and LiveboardService and LiveboardService.CreateFakeEntryWithOwner then
				LiveboardService.CreateFakeEntryWithOwner(
					brainrotName,
					fakePlayer.avatarId,
					fakePlayer.name,
					mutParam
				)
			end

			return string.format("✅ %s a obtenu %s%s", fakePlayer.name, brainrotName, mutParam and " (" .. mutParam .. ")" or "")
		end,
	})

	Conch.register("fls", { alias = "fakelivespawn" })
end

return module