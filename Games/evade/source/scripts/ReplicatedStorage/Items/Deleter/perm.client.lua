local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- 🧍‍♂️ Coloque aqui o nome do dono do jogo
local dono = "rip_master1789" -- 🔹 Substitua pelo SEU nome de usuário do Roblox

		warn("Você não tem permissão para usar o martelo.")
		return
	end

	print("Martelo ativado! Somente o dono pode apagar objetos.")
end)

tool.Activated:Connect(function()
	if player.Name ~= dono then return end
	end
end)
