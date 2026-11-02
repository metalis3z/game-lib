
local TeleportService = game:GetService("TeleportService")

return {
	TeleportInitFailed = TeleportService.TeleportInitFailed,
	GetLocalPlayerTeleportData = function(_)
		return TeleportService:GetLocalPlayerTeleportData()
	end
}
