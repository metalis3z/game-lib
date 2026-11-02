local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NotifyEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("NotifyEvent")

NotifyEvent.OnServerEvent:Connect(function(player : Player, message : string, color : Color3, MsgType : string)
	NotifyEvent:FireClient(player, message, color, MsgType)
end)

--[[
discord.gg/Tsw2b2EkSE is this only server that this admin abuse SHOULD be sold on.
]]--