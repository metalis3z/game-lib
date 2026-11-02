local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerData = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("ServerData"))

if ServerData.IsDuelsServer() then
	local DesyncFolder = ReplicatedStorage:WaitForChild("Desync")
	local DesyncRemote = DesyncFolder:WaitForChild("UnreliableRemoteEvent")

	DesyncRemote.OnClientEvent:Connect(function(targetPlayer, serverCFrame)
		if not targetPlayer then return end
		if not targetPlayer.Character then return end

		local character = targetPlayer.Character
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then return end
		if typeof(serverCFrame) ~= "CFrame" then return end

		local isStealing = targetPlayer:GetAttribute("Stealing")
		local maxAllowedDistance = isStealing and 4.5 or 7

		local distanceFromServerPosition = 
			(humanoidRootPart.Position - serverCFrame.Position).Magnitude

		if distanceFromServerPosition > maxAllowedDistance then
			humanoidRootPart.CFrame = serverCFrame
		end
	end)
end