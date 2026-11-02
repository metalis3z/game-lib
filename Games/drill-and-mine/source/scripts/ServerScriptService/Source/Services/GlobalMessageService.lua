local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GlobalMessageService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local globalMessageEvent = Remotes:WaitForChild("GlobalMessageService"):FindFirstChild("GlobalSystemMessage")

function GlobalMessageService.Send(text: string)
	globalMessageEvent:FireAllClients(text)
end

function GlobalMessageService.SendToPlayer(player: Player, text: string)
	globalMessageEvent:FireClient(player, text)
end

function GlobalMessageService.Init()
end

return GlobalMessageService