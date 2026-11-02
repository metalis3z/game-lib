local tool = script.Parent
local handle = tool.Handle
local opened = tool.OpenHandle
local canUse = true
local effects = {
	opened.Effect_1,
	opened.Effect_2,
	opened.Effect_3,
	opened.Effect_4,
	opened.Effect_5,
	opened.Effect_6,
	opened.Effect_7
}
local clickCount = 0

tool.Activated:Connect(function()
	if canUse then
		clickCount = clickCount + 1

		if clickCount == 1 then
			-- Primeira ativação: tocar o som "BookSound"
			opened.BookSound:Play()
			handle.Transparency = 1
			opened.Transparency = 0
		elseif clickCount == 2 then
			-- Segunda ativação: tocar o som "MagicSound" e ativar um efeito aleatório
			opened.MagicSound:Play()  -- Toca o som apenas uma vez

			-- Ativa um efeito aleatório de partículas
			local effectIndex = math.random(1, #effects)
			effects[effectIndex]:Emit(1)

			-- Reseta as transparências e o controle de cliques
			canUse = false
			wait(10)
			handle.Transparency = 0
			opened.Transparency = 1
			canUse = true

			-- Reseta o contador de cliques para o próximo ciclo
			clickCount = 0
		end
	end
end)
