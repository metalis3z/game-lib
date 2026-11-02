local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Knit = require(RS.Packages.Knit)

local ChatService = Knit.CreateService({
	Name = "ChatService",
	Client = {
		message = Knit.CreateSignal(),
	},
})

function ChatService:SendMessage(messageType, text, playerName)
	for _, player in Players:GetPlayers() do
		self.Client.message:Fire(player, messageType, text, playerName)
	end
end

function ChatService:KnitInit()
end

function ChatService:KnitStart()
	print("[ChatService] Started")
end

return ChatService