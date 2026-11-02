-- ExtraPanelAccess
-- Unico lugar donde vive "quien puede usar el ExtraPanel", para que el server,
-- el panel y el boton Extra no se contradigan entre si.
--
-- Se entra de dos formas:
--   1) siendo ClaraSigm1 (entra con el panel puesto)
--   2) aguantando RequiredSeconds dentro del server (lo otorga ExtraPanelUnlockServer)
--
-- El atributo Unlocked lo escribe SOLO el server. Un cliente puede escribirselo
-- localmente, pero eso no replica hacia arriba, asi que el server nunca se lo cree.

local ExtraPanelAccess = {}

ExtraPanelAccess.AdminUserId = 7889117873 -- ClaraSigm1
ExtraPanelAccess.RequiredSeconds = 10 * 60

ExtraPanelAccess.UnlockedAttribute = "ExtraPanelUnlocked"
ExtraPanelAccess.DeadlineAttribute = "ExtraPanelDeadline"

function ExtraPanelAccess.isAdmin(player)
	return player.UserId == ExtraPanelAccess.AdminUserId
end

function ExtraPanelAccess.canUse(player)
	if ExtraPanelAccess.isAdmin(player) then
		return true
	end
	return player:GetAttribute(ExtraPanelAccess.UnlockedAttribute) == true
end

return ExtraPanelAccess
