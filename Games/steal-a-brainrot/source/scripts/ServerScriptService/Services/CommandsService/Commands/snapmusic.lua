local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local DataStoreService = game:GetService("DataStoreService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local SnapMusicStore = DataStoreService:GetDataStore("SnapMusicGlobal")
	local SnapTypeStore = DataStoreService:GetDataStore("SnapTypeGlobal")
	local STORE_KEY_MUSIC = "LastPhaseTheme"
	local STORE_KEY_TYPE = "LastSnapType"

	-- Charger la musique sauvegardee
	task.spawn(function()
		local success, data = pcall(function()
			return SnapMusicStore:GetAsync(STORE_KEY_MUSIC)
		end)
		if success and data then
			ServerScriptService:SetAttribute("LastPhaseTheme", data)
		end
	end)

	-- Charger le type de snap sauvegarde
	task.spawn(function()
		local success, data = pcall(function()
			return SnapTypeStore:GetAsync(STORE_KEY_TYPE)
		end)
		if success and data then
			ServerScriptService:SetAttribute("LastSnapType", data)
			ReplicatedStorage:SetAttribute("LastSnapType", data)
		else
			ServerScriptService:SetAttribute("LastSnapType", "Normal")
			ReplicatedStorage:SetAttribute("LastSnapType", "Normal")
		end
	end)

	-- S'abonner via MessagingHub
	if not _G._sub_snapmusic then
		_G._sub_snapmusic = true

		_G.MessagingHub.Register("SnapMusicGlobal", function(data)
			ServerScriptService:SetAttribute("LastPhaseTheme", data.variant)
		end)

		_G.MessagingHub.Register("SnapTypeGlobal", function(data)
			ServerScriptService:SetAttribute("LastSnapType", data.snapType)
			ReplicatedStorage:SetAttribute("LastSnapType", data.snapType)
		end)
	end

	-- Commande musique
	Conch.register("snapmusic", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Snap Music",
				name = "Variant"
			}
		end,
		callback = function(variant)
			ServerScriptService:SetAttribute("LastPhaseTheme", variant)
			_G.MessagingHub.Publish("SnapMusicGlobal", { variant = variant })
			pcall(function()
				SnapMusicStore:SetAsync(STORE_KEY_MUSIC, variant)
			end)
			return "set"
		end
	})

	-- Commande type de snap
	Conch.register("snaptype", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Snap Type",
				name = "Type"
			}
		end,
		callback = function(snapType)
			ServerScriptService:SetAttribute("LastSnapType", snapType)
			ReplicatedStorage:SetAttribute("LastSnapType", snapType)
			_G.MessagingHub.Publish("SnapTypeGlobal", { snapType = snapType })
			pcall(function()
				SnapTypeStore:SetAsync(STORE_KEY_TYPE, snapType)
			end)
			return "set"
		end
	})
end

return module