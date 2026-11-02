-- Échelle commune de toutes les interfaces du jeu (UIScaler, compteurs d'argent / speed, barre, boutons, réglages, alertes...).
-- Les interfaces ont été dessinées pour un écran de 1280 x 760. L'échelle suit le PLUS PETIT des deux rapports (largeur et
-- hauteur) : un téléphone en paysage (environ 850 x 390) est très peu haut, tout y est donc réduit de moitié.
--   PC plein écran (1920 x 1080), console / PlayStation (TV 1920 x 1080) : 1 (taille normale)
--   tablette (environ 1024 x 768) : 0,8
--   téléphone (environ 850 x 390, ou 667 x 375) : 0,5 (le minimum : les boutons restent assez grands pour les doigts)
-- GuiScale.small() : vrai sur un petit écran (téléphone) ; GuiScale.hud() : échelle des compteurs (argent, speed), encore un
-- peu plus petits sur téléphone pour laisser voir le jeu.
local GuiScale = {}
GuiScale.DESIGN = Vector2.new(1280, 760)
GuiScale.MIN, GuiScale.MAX = 0.5, 1
GuiScale.HUD_MOBILE = 0.85
function GuiScale.get()
	local view = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.zero
	if view.Y < 50 or view.X < 50 then return 1 end -- écran pas encore prêt
	local s = math.min(view.X / GuiScale.DESIGN.X, view.Y / GuiScale.DESIGN.Y)
	return math.clamp(s, GuiScale.MIN, GuiScale.MAX)
end
function GuiScale.small()
	return GuiScale.get() < 0.7
end
function GuiScale.hud()
	return GuiScale.get() * (GuiScale.small() and GuiScale.HUD_MOBILE or 1)
end
return GuiScale
