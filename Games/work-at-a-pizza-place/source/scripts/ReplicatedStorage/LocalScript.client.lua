
game:GetService('TeleportService').LocalPlayerArrivedFromTeleport:connect(function(customLoadingScreen, teleportData)
	print("PLAYER ARRIVED",teleportData)
	_G["TeleportData"] = teleportData
end)