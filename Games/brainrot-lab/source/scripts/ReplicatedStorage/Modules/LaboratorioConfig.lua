--!strict
-- LOCATION: ReplicatedStorage/Modules/LaboratorioConfig
-- Configuracao do sistema de Laboratorio (aplicacao de ingredientes em brainrots)

local LaboratorioConfig = {}

-- Tempo de segurar E para aplicar o ingrediente (segundos)
LaboratorioConfig.HoldDuration = 2

-- Mapeamento de ingredientes para seus icons no frame Mutations do Brainrot_UI
-- e a porcentagem de aumento do valor do brainrot
-- Percentage = quanto o valor do brainrot aumenta (ex: 10 = +10%)
LaboratorioConfig.IngredientEffects = {
	["Taco"]       = { Percentage = 10, IconName = "Taco" },
	["Flower"]     = { Percentage = 15, IconName = "Flower" },
	["Star"]       = { Percentage = 20, IconName = "Stars" },
	["Lighter"]    = { Percentage = 12, IconName = "Lightning" },
	["Phone"]      = { Percentage = 18, IconName = "Hacker" },
	["Ice Emblem"] = { Percentage = 14, IconName = "Ice" },
	["Victrola"]   = { Percentage = 25, IconName = "Sound" },
}

-- Obter efeito de um ingrediente
function LaboratorioConfig.GetEffect(ingredientName: string)
	return LaboratorioConfig.IngredientEffects[ingredientName]
end

-- Obter porcentagem de aumento
function LaboratorioConfig.GetPercentage(ingredientName: string): number
	local effect = LaboratorioConfig.IngredientEffects[ingredientName]
	return effect and effect.Percentage or 0
end

-- Obter nome do icon no frame Mutations
function LaboratorioConfig.GetIconName(ingredientName: string): string?
	local effect = LaboratorioConfig.IngredientEffects[ingredientName]
	return effect and effect.IconName or nil
end

return LaboratorioConfig