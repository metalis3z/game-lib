local module = function(Conch, Config)
	local MessagingService = game:GetService("MessagingService")
	local ServerScriptService = game:GetService("ServerScriptService")
	local DataStoreService = game:GetService("DataStoreService")

	local SnapMusicStore = DataStoreService:GetDataStore("SnapMusicGlobal")
	local STORE_KEY = "LastPhaseTheme"

	task.spawn(function()
		local success, data = pcall(function()
			return SnapMusicStore:GetAsync(STORE_KEY)
		end)

		if success and data then
			ServerScriptService:SetAttribute("LastPhaseTheme", data)
		end
	end)

	if not script:GetAttribute("SnapMusicSubscribed") then
		script:SetAttribute("SnapMusicSubscribed", true)

		task.spawn(function()
			MessagingService:SubscribeAsync("SnapMusicGlobal", function(message)
				ServerScriptService:SetAttribute("LastPhaseTheme", message.Data)
			end)
		end)
	end

	Conch.register("snapmusic", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "Snap Music",
				name = "Variant",
			}
		end,

		callback = function(variant)
			ServerScriptService:SetAttribute("LastPhaseTheme", variant)

			MessagingService:PublishAsync("SnapMusicGlobal", variant)

			pcall(function()
				SnapMusicStore:SetAsync(STORE_KEY, variant)
			end)

			return "set"
		end
	})
end

return module