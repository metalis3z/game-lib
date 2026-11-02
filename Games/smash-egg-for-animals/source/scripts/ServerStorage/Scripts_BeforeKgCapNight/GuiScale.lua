-- Échelle commune de toutes les interfaces du jeu (UIScaler, boutons de droite, réglages...).
-- Comme les boutons de Roblox : la même taille à l'écran sur PC et sur mobile (Roblox compte déjà en points, pas en pixels
-- physiques). Seuls les petits écrans (hauteur < 700) réduisent un peu, jusqu'à 0,85 sur un téléphone en paysage.
-- Les grands écrans PC ne grossissent plus (avant : jusqu'à x1,4, et x0,6 sur mobile).
local GuiScale = {}
GuiScale.SMALL_H, GuiScale.BIG_H = 380, 700
GuiScale.MIN = 0.85
function GuiScale.get()
	local h = workspace.CurrentCamera.ViewportSize.Y
	local k = math.clamp((h - GuiScale.SMALL_H) / (GuiScale.BIG_H - GuiScale.SMALL_H), 0, 1)
	return GuiScale.MIN + (1 - GuiScale.MIN) * k
end
return GuiScale
