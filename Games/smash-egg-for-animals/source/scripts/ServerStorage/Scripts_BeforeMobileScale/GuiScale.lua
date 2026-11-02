-- Échelle commune de toutes les interfaces du jeu (UIScaler, boutons de droite, réglages, alertes...).
-- PC / tablette (écran d'au moins 720 de haut) : taille normale (1). Plus l'écran est petit, plus tout est réduit :
-- jusqu'à 0,6 sur un téléphone en paysage (environ 360-400 de haut), pour que les boutons et textes ne prennent pas tout l'écran.
local GuiScale = {}
GuiScale.SMALL_H, GuiScale.BIG_H = 360, 720
GuiScale.MIN = 0.6
function GuiScale.get()
	local h = workspace.CurrentCamera.ViewportSize.Y
	if h < 50 then return 1 end -- écran pas encore prêt
	local k = math.clamp((h - GuiScale.SMALL_H) / (GuiScale.BIG_H - GuiScale.SMALL_H), 0, 1)
	return GuiScale.MIN + (1 - GuiScale.MIN) * k
end
return GuiScale
