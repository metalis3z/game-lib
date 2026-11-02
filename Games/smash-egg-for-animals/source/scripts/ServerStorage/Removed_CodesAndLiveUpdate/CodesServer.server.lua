-- Échange de codes : le RemoteFunction appelle CodesService (codes fixes + codes admin)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local CodesService = require(ServerScriptService:WaitForChild("CodesService"))
local redeemRemote = ReplicatedStorage:WaitForChild("CodesSystem"):WaitForChild("RedeemCode")

redeemRemote.OnServerInvoke = function(player, code)
	return CodesService.Redeem(player, code)
end
