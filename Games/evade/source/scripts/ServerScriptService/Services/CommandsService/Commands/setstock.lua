local module = function(Conch, Config)
	Conch.register("setstock", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				{
					kind = "argument",
					type = "number",
					name = "Amount",
				},
			}
		end,

		callback = function(amount)
			if amount < 0 then
				return false, "Amount cannot be negative"
			end

			local ServerScriptService = game:GetService("ServerScriptService")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")

			local SammyTruck = require(ServerScriptService.Services.SammyTruck)

			local STOCK_KEY = "StockEvent_La_Taco_Combinasion"

			SammyTruck.CurrentStock = amount
			SammyTruck.INITIAL_STOCK = amount

			ReplicatedStorage:SetAttribute(STOCK_KEY, amount)

			-- 🔥 Enviar anúncio para todos os players
			local notifyEvent = ReplicatedStorage:FindFirstChild("NotifyAll")

			if notifyEvent and notifyEvent:IsA("RemoteEvent") then
				NotifyAll:FireAllClients("Sammy set global stock!", 15, "Sounds.Sfx.Success")
			else
			end

			return true, string.format("Set global stock to %d", amount)
		end,
	})
end

return module
