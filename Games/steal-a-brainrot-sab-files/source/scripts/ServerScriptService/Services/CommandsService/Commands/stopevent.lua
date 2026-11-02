local module = function(Conch, Config)

	Conch.register("stopevent", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				{
					kind = "argument",
					type = "Event",
					name = "Event",
				},
				{
					kind = "argument",
					type = "number",
					name = "Duration",
				},
			}
		end,

		-- Conch callback SEMPRE recebe (context, args...)
		callback = function(_, eventName, duration)
			local svcModule = game:GetService("ServerScriptService"):FindFirstChild("Services")
			if not svcModule then
				return false, "Services folder not found"
			end

			local ok, svc = pcall(function()
				return require(svcModule:WaitForChild("EventService"))
			end)

			if not ok or not svc then
				return false, "Failed to load EventService"
			end

			-- Confere se os eventos carregaram
			local rs = game:GetService("ReplicatedStorage")
			if not rs:GetAttribute("EventsLoaded") then
				return false, "EventService not fully loaded"
			end

			-- Validação de nome
			if typeof(eventName) ~= "string" then
				return false, "Invalid event name"
			end

			-- Verifica se existe no EventConfigs
			if not svc.EventConfigs or not svc.EventConfigs[eventName] then
				return false, "Event not found"
			end

			-- Cancela o evento
			local success, err = pcall(function()
				svc:CancelEvent(eventName, duration)
			end)

			if not success then
				return false, "Failed to stop event: " .. tostring(err)
			end

			return true, "Event '" .. eventName .. "' stopped"
		end,
	})

end

return module
