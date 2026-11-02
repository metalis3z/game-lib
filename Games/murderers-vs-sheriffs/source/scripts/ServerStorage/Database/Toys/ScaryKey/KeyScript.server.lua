local tool = script.Parent
local handle = tool:FindFirstChild("Handle")

-- 10 cores diferentes
local colors = {
	Color3.fromRGB(255, 0, 0),     -- Vermelho
	Color3.fromRGB(0, 255, 0),     -- Verde
	Color3.fromRGB(0, 0, 255),     -- Azul
	Color3.fromRGB(255, 255, 0),   -- Amarelo
	Color3.fromRGB(255, 0, 255),   -- Magenta
	Color3.fromRGB(0, 255, 255),   -- Ciano
	Color3.fromRGB(255, 165, 0),   -- Laranja
	Color3.fromRGB(128, 0, 128),   -- Roxo escuro
	Color3.fromRGB(0, 128, 128),   -- Verde água escuro
	Color3.fromRGB(255, 192, 203)  -- Rosa claro
}

local currentColorIndex = 1

-- Função para mudar de cor
local function changeColor()
	if handle then
		currentColorIndex = currentColorIndex + 1
		if currentColorIndex > #colors then
			currentColorIndex = 1
		end
		handle.Color = colors[currentColorIndex]
	end
end

-- Muda a cor ao equipar ou desequipar
tool.Equipped:Connect(changeColor)
tool.Unequipped:Connect(changeColor)
