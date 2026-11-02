--// property of unknown, dont steal u mudafucka
local module = function(Conch, Config)

	Conch.register("spawnbrainrot", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "Boat",
					name = "Boat",
					opitional = true
				}
			}
		end,

		callback = function()
			-- Procurar a canoa no ReplicatedStorage
			local CanoeModel = game:GetService("ReplicatedStorage"):FindFirstChild("Canoa")

			if not CanoeModel then
				return "Modelo 'Canoa' não encontrado em ReplicatedStorage!"
			end

			-- Clonar e spawnar
			local canoeClone = CanoeModel:Clone()
			canoeClone.Parent = workspace

			-- Define posição inicial (pode ajustar se quiser)
			if canoeClone.PrimaryPart then
				canoeClone:SetPrimaryPartCFrame(CFrame.new(0, 5, 0))
			end

			return "Canoa spawnada com sucesso!"
		end,
	})
end

return module
