local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local DataStoreService = game:GetService("DataStoreService")

	local SnapSkinStore = DataStoreService:GetDataStore("SnapSkinGlobal")
	local STORE_KEY = "LastSnapSkinUserId"

	-- Charger le skin sauvegarde
	task.spawn(function()
		local success, data = pcall(function()
			return SnapSkinStore:GetAsync(STORE_KEY)
		end)
		if success and data then
			ServerScriptService:SetAttribute("SammySnapSkinUserId", data)
		end
	end)

	-- S'abonner via MessagingHub
	if not _G._sub_snapskin then
		_G._sub_snapskin = true
		_G.MessagingHub.Register("SnapSkinGlobal", function(data)
			ServerScriptService:SetAttribute("SammySnapSkinUserId", data.userId)
		end)
	end

	-- Commande snapskin
	Conch.register("snapskin", {
		permissions = { Config.RequiredRole or "super-user" },
		description = "Change le skin de Sammy pendant le snap",
		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player"
			}
		end,
		callback = function(targetPlayer)
			if not targetPlayer then
				return "Joueur introuvable"
			end
			local userId = targetPlayer.UserId
			ServerScriptService:SetAttribute("SammySnapSkinUserId", userId)
			_G.MessagingHub.Publish("SnapSkinGlobal", { userId = userId })
			pcall(function()
				SnapSkinStore:SetAsync(STORE_KEY, userId)
			end)
			return "Snap skin set to " .. targetPlayer.Name
		end
	})

	-- Commande snapskinreset
	Conch.register("snapskinreset", {
		permissions = { Config.RequiredRole or "super-user" },
		description = "Remet le skin de Sammy au joueur qui snap",
		arguments = function() return nil end,
		callback = function()
			ServerScriptService:SetAttribute("SammySnapSkinUserId", nil)
			_G.MessagingHub.Publish("SnapSkinGlobal", { userId = nil })
			pcall(function()
				SnapSkinStore:RemoveAsync(STORE_KEY)
			end)
			return "Snap skin reset"
		end
	})
end

return module